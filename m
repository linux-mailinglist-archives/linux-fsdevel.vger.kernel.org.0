Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4A4AE9EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 07:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiBIGFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 01:05:11 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiBIGBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:01:12 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFE1C050CC3;
        Tue,  8 Feb 2022 22:01:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V3zaQQi_1644386471;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V3zaQQi_1644386471)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 14:01:11 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/22] fscache: add a method to support on-demand read semantics
Date:   Wed,  9 Feb 2022 14:00:48 +0800
Message-Id: <20220209060108.43051-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add .ondemand_read() callback to netfs_cache_ops to implement on-demand
read.

The precondition for implementing on-demand read semantics is that,
all blob files have been placed under corresponding directory with
correct file size (sparse files) on the first beginning. When upper fs
starts to access the blob file, it will "cache miss" (hit the hole).
Then .ondemand_read() callback can be called to notify backend to
prepare the data.

The implementation of .ondemand_read() callback can be backend specific.
The following patch will introduce the implementation for cachefiles,
which will notify user daemon the requested file range to read. The
.ondemand_read() callback will get blocked until the user daemon has
prepared the corresponding data.

Then once .ondemand_read() callback returns with 0, it is guaranteed
that the requested data has been ready. In this case, users can retry to
read from the backing file.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 Documentation/filesystems/netfs_library.rst | 18 +++++++++++++++
 include/linux/fscache.h                     | 25 +++++++++++++++++++++
 include/linux/netfs.h                       |  4 ++++
 3 files changed, 47 insertions(+)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 4f373a8ec47b..e544d6688100 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -466,6 +466,8 @@ operation table looks like the following::
 		int (*query_occupancy)(struct netfs_cache_resources *cres,
 				       loff_t start, size_t len, size_t granularity,
 				       loff_t *_data_start, size_t *_data_len);
+		int (*ondemand_read)(struct netfs_cache_resources *cres,
+				     loff_t start_pos, size_t len);
 	};
 
 With a termination handler function pointer::
@@ -552,6 +554,22 @@ The methods defined in the table are:
    It returns 0 if some data was found, -ENODATA if there was no usable data
    within the region or -ENOBUFS if there is no caching on this file.
 
+ * ``ondemand_read()``
+
+   [Optional] Called to make cache prepare for the data. It shall be called only
+   when on-demand read semantics is required. It will be called when a cache
+   miss is encountered. The function will make the backend somehow prepare for
+   the data in the region specified by @start_pos/@len of the cache file. It may
+   get blocked until the backend has prepared the data in the cache file
+   successfully, or error encountered.
+
+   Once it returns with 0, it is guaranteed that the requested data has been
+   ready in the cache file. In this case, users can retry to read from the cache
+   file.
+
+   It returns 0 if data has been ready in the cache file, or other error code
+   from the cache, such as -ENOMEM.
+
 Note that these methods are passed a pointer to the cache resource structure,
 not the read request structure as they could be used in other situations where
 there isn't a read request structure as well, such as writing dirty data to the
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index d2430da8aa67..efcd5d5c6726 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -514,6 +514,31 @@ int fscache_read(struct netfs_cache_resources *cres,
 			 term_func, term_func_priv);
 }
 
+/**
+ * fscache_ondemand_read - Make cache prepare for the data.
+ * @cres: The cache resources to use
+ * @start_pos: The beginning file offset in the cache file
+ * @len: The length of the file offset range in the cache file
+ *
+ * This shall only be called when a cache miss is encountered. It will make
+ * the backend somehow prepare for the data in the file offset range specified
+ * by @start_pos/@len of the cache file. It may get blocked until the backend
+ * has prepared the data in the cache file successfully, or error encountered.
+ *
+ * Returns:
+ * * 0		- Success (Data is ready in the cache file)
+ * * Other error code from the cache, such as -ENOMEM.
+ */
+static inline
+int fscache_ondemand_read(struct netfs_cache_resources *cres,
+			  loff_t start_pos, size_t len)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+	if (ops->ondemand_read)
+		return ops->ondemand_read(cres, start_pos, len);
+	return -EOPNOTSUPP;
+}
+
 /**
  * fscache_begin_write_operation - Begin a write operation for the netfs lib
  * @cres: The cache resources for the write being performed
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 614f22213e21..81fe707ad38d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -251,6 +251,10 @@ struct netfs_cache_ops {
 	int (*query_occupancy)(struct netfs_cache_resources *cres,
 			       loff_t start, size_t len, size_t granularity,
 			       loff_t *_data_start, size_t *_data_len);
+
+	/* Make cache prepare for the data */
+	int (*ondemand_read)(struct netfs_cache_resources *cres,
+			     loff_t start_pos, size_t len);
 };
 
 struct readahead_control;
-- 
2.27.0

