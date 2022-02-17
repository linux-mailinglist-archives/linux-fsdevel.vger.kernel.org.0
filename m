Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D214B9F87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 13:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbiBQMCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 07:02:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240184AbiBQMCP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:02:15 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB4B60F4;
        Thu, 17 Feb 2022 04:02:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V4keWKf_1645099317;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V4keWKf_1645099317)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 20:01:58 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     xiang@kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 2/4] fscache: add a method to support on-demand read semantics
Date:   Thu, 17 Feb 2022 20:01:52 +0800
Message-Id: <20220217120154.16658-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220217120154.16658-1-jefflexu@linux.alibaba.com>
References: <20220217120154.16658-1-jefflexu@linux.alibaba.com>
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
 Documentation/filesystems/netfs_library.rst | 17 ++++++++++++++
 include/linux/fscache.h                     | 25 +++++++++++++++++++++
 include/linux/netfs.h                       |  4 ++++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index 4f373a8ec47b..075370d4c021 100644
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
@@ -552,6 +554,21 @@ The methods defined in the table are:
    It returns 0 if some data was found, -ENODATA if there was no usable data
    within the region or -ENOBUFS if there is no caching on this file.
 
+ * ``ondemand_read()``
+
+   [Optional] Called to prepare cache for the requested data. It shall be called
+   only when on-demand read semantics is required. It will be called when a cache
+   miss is encountered. The function will make the backend prepare the data
+   regarding to @start_pos/@len of the cache file. It may get blocked until the
+   backend finishes getting the requested data or returns errors.
+
+   Once it returns with 0, it is guaranteed that the requested data has been
+   ready in the cache file. In this case, users can get the data with another
+   read request.
+
+   It returns 0 if data has been ready in the cache file, or other error code
+   from the cache, such as -ENOMEM.
+
 Note that these methods are passed a pointer to the cache resource structure,
 not the read request structure as they could be used in other situations where
 there isn't a read request structure as well, such as writing dirty data to the
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index d2430da8aa67..34af865ba928 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -514,6 +514,31 @@ int fscache_read(struct netfs_cache_resources *cres,
 			 term_func, term_func_priv);
 }
 
+/**
+ * fscache_ondemand_read - Prepare cache for the requested data.
+ * @cres: The cache resources to use
+ * @start_pos: The beginning file offset in the cache file
+ * @len: The length of the file offset range in the cache file
+ *
+ * This shall only be called when a cache miss is encountered. It will make
+ * the backend prepare the data regarding to @start_pos/@len of the cache file.
+ * It may get blocked until the backend finishes getting the requested data or
+ * returns errors.
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
index 614f22213e21..3d5f0376a326 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -251,6 +251,10 @@ struct netfs_cache_ops {
 	int (*query_occupancy)(struct netfs_cache_resources *cres,
 			       loff_t start, size_t len, size_t granularity,
 			       loff_t *_data_start, size_t *_data_len);
+
+	/* Prepare cache for the requested data */
+	int (*ondemand_read)(struct netfs_cache_resources *cres,
+			     loff_t start_pos, size_t len);
 };
 
 struct readahead_control;
-- 
2.27.0

