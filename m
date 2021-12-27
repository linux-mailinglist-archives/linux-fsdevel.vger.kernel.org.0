Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2625247FCD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhL0Myx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:54:53 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39213 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236771AbhL0Myu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:54:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.w7GWF_1640609687;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.w7GWF_1640609687)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:54:48 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/23] cachefiles: detect backing file size in demand-read mode
Date:   Mon, 27 Dec 2021 20:54:24 +0800
Message-Id: <20211227125444.21187-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When upper read-only fs uses fscache for demand reading, it has no idea
on the size of the backed file. (You need to input the file size as the
@object_size parameter when calling fscache_acquire_cookie().)

In this using scenario, user daemon is responsible for preparing all
backing files with correct file size (though they can be all sparse
files), and the upper fs shall guarantee that past EOF access will never
happen.

Then with this precondition, cachefiles can detect the actual size of
backing file, and set it as the size of backed file.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/namei.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 074722c21522..54123b2693cd 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -511,9 +511,19 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
  */
 static bool cachefiles_create_file(struct cachefiles_object *object)
 {
+	struct cachefiles_cache *cache = object->volume->cache;
 	struct file *file;
 	int ret;
 
+	/*
+	 * Demand read mode requires that backing files have been prepared with
+	 * correct file size under corresponding directory. We can get here when
+	 * the backing file doesn't exist under corresponding directory, or the
+	 * file size is unexpected 0.
+	 */
+	if (test_bit(CACHEFILES_DEMAND_MODE, &cache->flags))
+		return false;
+
 	ret = cachefiles_has_space(object->volume->cache, 1, 0,
 				   cachefiles_has_space_for_create);
 	if (ret < 0)
@@ -530,6 +540,32 @@ static bool cachefiles_create_file(struct cachefiles_object *object)
 	return true;
 }
 
+/*
+ * Fs using fscache for demand reading may have no idea of the file size of
+ * backing files. Thus the demand read mode requires that backing files have
+ * been prepared with correct file size under corresponding directory. Then
+ * fscache backend is responsible for taking the file size of the backing file
+ * as the object size.
+ */
+static int cachefiles_recheck_size(struct cachefiles_object *object,
+				   struct file *file)
+{
+	loff_t size;
+	struct cachefiles_cache *cache = object->volume->cache;
+
+	if (!test_bit(CACHEFILES_DEMAND_MODE, &cache->flags))
+		return 0;
+
+	size = i_size_read(file_inode(file));
+	if (size) {
+		object->cookie->object_size = size;
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+
+}
+
 /*
  * Open an existing file, checking its attributes and replacing it if it is
  * stale.
@@ -569,6 +605,10 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	}
 	_debug("file -> %pd positive", dentry);
 
+	ret = cachefiles_recheck_size(object, file);
+	if (ret < 0)
+		goto check_failed;
+
 	ret = cachefiles_check_auxdata(object, file);
 	if (ret < 0)
 		goto check_failed;
-- 
2.27.0

