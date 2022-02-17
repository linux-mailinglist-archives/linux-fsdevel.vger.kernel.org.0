Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E84B9F91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 13:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbiBQMC0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 07:02:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240189AbiBQMCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:02:18 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F121C62D1;
        Thu, 17 Feb 2022 04:02:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V4keWL7_1645099319;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V4keWL7_1645099319)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 20:02:00 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     xiang@kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 4/4] cachefiles: detect backing file size in on-demand read mode
Date:   Thu, 17 Feb 2022 20:01:54 +0800
Message-Id: <20220217120154.16658-5-jefflexu@linux.alibaba.com>
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

Fscache/cachefiles used to serve as a local cache for remote fs. The
following patches will introduce a new use case, in which local
read-only fs could implement on-demand reading with fscache. Then in
this case, the upper read-only fs may has no idea on the size of the
backed file.

It is worth nothing that, in this scenario, user daemon is responsible
for preparing all backing files with correct file size in the first
beginning. (Backing files are all sparse files in this case). And since
it's read-only, we can get the backing file size at runtime as the
object size.

This patch also adds one flag bit to distinguish the new introduced
on-demand read mode from the original mode. The following patch will
introduce a user configures it.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/Kconfig    | 13 +++++++++
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/namei.c    | 60 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/Kconfig b/fs/cachefiles/Kconfig
index 719faeeda168..cef412cfd127 100644
--- a/fs/cachefiles/Kconfig
+++ b/fs/cachefiles/Kconfig
@@ -26,3 +26,16 @@ config CACHEFILES_ERROR_INJECTION
 	help
 	  This permits error injection to be enabled in cachefiles whilst a
 	  cache is in service.
+
+config CACHEFILES_ONDEMAND
+	bool "Support for on-demand reading"
+	depends on CACHEFILES
+	default n
+	help
+	  This permits on-demand read mode of cachefiles. In this mode, when
+	  cache miss, the cachefiles backend instead of the upper fs using
+	  fscache is responsible for fetching data, e.g. through user daemon.
+	  Then after the data's ready, upper fs can reinitiate a read from the
+	  cache.
+
+	  If unsure, say N.
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index c793d33b0224..6473634c41a9 100644
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
index f256c8aff7bb..abe75b4b955f 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -510,15 +510,69 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	return file;
 }
 
+#ifdef CONFIG_CACHEFILES_ONDEMAND
+static inline bool cachefiles_can_create_file(struct cachefiles_cache *cache)
+{
+	/*
+	 * On-demand read mode requires that backing files have been prepared
+	 * with correct file size under corresponding directory in the very
+	 * first begginning. We can get here when the backing file doesn't exist
+	 * under corresponding directory, or the file size is unexpected 0.
+	 */
+	return !test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags);
+
+}
+
+/*
+ * Fs using fscache for on-demand reading may have no idea of the file size of
+ * backing files. Thus the on-demand read mode requires that backing files shall
+ * be prepared with correct file size under corresponding directory by the user
+ * daemon in the first beginning. Then the backend is responsible for taking the
+ * file size of the backing file as the object size at runtime.
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
+static inline int cachefiles_recheck_size(struct cachefiles_object *object,
+					  struct file *file)
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
@@ -573,6 +627,10 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
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

