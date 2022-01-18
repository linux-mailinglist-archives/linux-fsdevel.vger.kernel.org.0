Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9334249268A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbiARNM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:12:29 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60510 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241978AbiARNMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:12:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V2C8e3U_1642511542;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V2C8e3U_1642511542)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 21:12:23 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/20] cachefiles: detect backing file size in on-demand read mode
Date:   Tue, 18 Jan 2022 21:12:01 +0800
Message-Id: <20220118131216.85338-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
References: <20220118131216.85338-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fscache/cachefiles used to serve as a local cache for remote fs. The
following patches will introduce a new use case, in which local
read-only fs could implement on-demand reading with fscache. Then in
this case, the upper read-only fs may has no idea on the size of the
backed file.

Besides it is worth nothing that, in this scenario, user daemon is
responsible for preparing all backing files with correct file size
(backing files are all sparse files in this case). And since it's
read-only, we can trust the backing file size as the backed file size.

With this precondition, cachefiles can detect the actual size of the
backing file, and set it as the size of the backed file.

This patch also adds one flag bit to distinguish the new introduced
on-demand read mode from the original mode. The following patch will
make it configurable by users.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/Kconfig    |  8 ++++++
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/namei.c    | 60 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index 719faeeda168..0aaef4dd3866 100644
--- a/fs/cachefiles/Kconfig
+++ b/fs/cachefiles/Kconfig
@@ -26,3 +26,11 @@ config CACHEFILES_ERROR_INJECTION
 	help
 	  This permits error injection to be enabled in cachefiles whilst a
 	  cache is in service.
+
+config CACHEFILES_ONDEMAND
+	bool "Support for on-demand reading"
+	depends on CACHEFILES && FSCACHE_ONDEMAND
+	default n
+	help
+	  This permits on-demand read mode of cachefiles.
+	  If unsure, say N.
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 421423819d63..2bb441197106 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -98,6 +98,7 @@ struct cachefiles_cache {
 #define CACHEFILES_DEAD			1	/* T if cache dead */
 #define CACHEFILES_CULLING		2	/* T if cull engaged */
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
+#define CACHEFILES_ONDEMAND_MODE	4	/* T if in on-demand read mode */
 	char				*rootdirname;	/* name of cache root directory */
 	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 9399153e1c99..1469f94cb229 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -506,15 +506,69 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	return file;
 }
 
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+static inline bool cachefiles_can_create_file(struct cachefiles_cache *cache)
+{
+	/*
+	 * On-demand read mode requires that backing files have been prepared
+	 * with correct file size under corresponding directory. We can get here
+	 * when the backing file doesn't exist under corresponding directory, or
+	 * the file size is unexpected 0.
+	 */
+	return !test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
+
+}
+
+/*
+ * Fs using fscache for on-demand reading may have no idea of the file size of
+ * backing files. Thus the on-demand read mode requires that backing files have
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
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return 0;
+
+	size = i_size_read(file_inode(file));
+	if (!size)
+		return -EINVAL;
+
+	object->cookie->object_size = size;
+	return 0;
+}
+#else
+static inline bool cachefiles_can_create_file(struct cachefiles_cache *cache)
+{
+	return true;
+}
+
+static int cachefiles_recheck_size(struct cachefiles_object *object,
+				   struct file *file)
+{
+	return 0;
+}
+#endif
+
+
 /*
  * Create a new file.
  */
 static bool cachefiles_create_file(struct cachefiles_object *object)
 {
+	struct cachefiles_cache *cache = object->volume->cache;
 	struct file *file;
 	int ret;
 
-	ret = cachefiles_has_space(object->volume->cache, 1, 0,
+	if (!cachefiles_can_create_file(cache))
+		return false;
+
+	ret = cachefiles_has_space(cache, 1, 0,
 				   cachefiles_has_space_for_create);
 	if (ret < 0)
 		return false;
@@ -569,6 +623,10 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
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

