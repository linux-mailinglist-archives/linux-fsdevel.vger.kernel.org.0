Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5315BBBA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 06:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiIREfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 00:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIREfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 00:35:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C493815A18
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso4169423pjq.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A/aoDsk49ETFUaGu6ntYPDp5Xpa3glyWzoYuA85stpo=;
        b=61PHmhzxDjMs06OEy3Cb1sztffy0FZOHZCqFyM6w2PJ/XFUpo97cM+5wNAwiN6TtBO
         fzy1o7cenhEgpWgMVxov1vtcB70zgPt0gHAG2/qeb7Nefh+ezr4gLsqsK2b1tlsoGKyT
         5/qfa44PhkZm000renBu0LIAsqj3ZsJkysOWwzdJqPKfXb0mjoXGw3nqfCGvn80B95ha
         UWUdu6g+vtwG2PtxJIkSspk3MT9DfLXHDV/OAe4cc6hVmzQ6WcI6/xLN59NLuL6X1eFD
         rIsM5fkH8sliEY1Cmk/aCjjVXgoAql1yduupzTFihK1RUipimMY4m3sXSAGf2SRazNr+
         tBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A/aoDsk49ETFUaGu6ntYPDp5Xpa3glyWzoYuA85stpo=;
        b=VzxBpNJuf8W1h/zTWW6SeTANoBYp/+it6P5AJekZecCxDX0Ra6gmtcO503Q+Umsapo
         dtKxBAngEkGU4f5CrTCNOuimsVNginI+dK/O08v7ZjErJQNKeJgkY4I01hwhRiQOfzKT
         bD8JI9jtiVz0WOcyXxqzNUzzfaI8gXNSzy9ACcv8O3QyumJhoP2JypiaYZGGiXzxb4IC
         7I6IW/p3Pga/x67gEIQb8sBBPNpKuCZ/HuVLNX0FVQ5lrEVoCrFCgEeVQsgMlKx3N90Q
         Dr+QfdJc5UgajNzPy04wuXiTWXf+daJE2COUIwpBR8TUr/4pGtqbxS+Xx3Bcg3o+5+H4
         0iGw==
X-Gm-Message-State: ACrzQf3ucwGf+vs8pa81AbhP1CY7Dx5uvDIcOmS1hQ/aAClS5oEL7ST2
        Jj5O8xdtsrsy3EudZAIMnOyARQ==
X-Google-Smtp-Source: AMsMyM6JXjtVoeByE0sNx+bWugwWJQan1z688+nSCVSRqAdmymrapUIy4SsElW+AtLZHzSQLVayrPA==
X-Received: by 2002:a17:902:d4cf:b0:178:1e39:31ff with SMTP id o15-20020a170902d4cf00b001781e3931ffmr6996051plg.137.1663475708271;
        Sat, 17 Sep 2022 21:35:08 -0700 (PDT)
Received: from localhost.localdomain ([111.201.134.95])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b0054b5239f7fesm3955248pfl.210.2022.09.17.21.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 21:35:07 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V6 2/6] erofs: code clean up for fscache
Date:   Sun, 18 Sep 2022 12:34:52 +0800
Message-Id: <20220918043456.147-3-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220918043456.147-1-zhujia.zj@bytedance.com>
References: <20220918043456.147-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some cleanups. No logic changes.

Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 39 +++++++++++++++++++--------------------
 fs/erofs/internal.h | 19 +++++++++----------
 fs/erofs/super.c    | 21 ++++++++-------------
 3 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 8e01d89c3319..d3a90103abb7 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -417,9 +417,8 @@ const struct address_space_operations erofs_fscache_access_aops = {
 	.readahead = erofs_fscache_readahead,
 };
 
-int erofs_fscache_register_cookie(struct super_block *sb,
-				  struct erofs_fscache **fscache,
-				  char *name, bool need_inode)
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
@@ -428,7 +427,7 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
 					name, strlen(name), NULL, 0, 0);
@@ -458,42 +457,33 @@ int erofs_fscache_register_cookie(struct super_block *sb,
 		ctx->inode = inode;
 	}
 
-	*fscache = ctx;
-	return 0;
+	return ctx;
 
 err_cookie:
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
-	ctx->cookie = NULL;
 err:
 	kfree(ctx);
-	return ret;
+	return ERR_PTR(ret);
 }
 
-void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
+void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 {
-	struct erofs_fscache *ctx = *fscache;
-
 	if (!ctx)
 		return;
 
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
-	ctx->cookie = NULL;
-
 	iput(ctx->inode);
-	ctx->inode = NULL;
-
 	kfree(ctx);
-	*fscache = NULL;
 }
 
 int erofs_fscache_register_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct fscache_volume *volume;
+	struct erofs_fscache *fscache;
 	char *name;
-	int ret = 0;
 
 	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
 	if (!name)
@@ -502,19 +492,28 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	volume = fscache_acquire_volume(name, NULL, NULL, 0);
 	if (IS_ERR_OR_NULL(volume)) {
 		erofs_err(sb, "failed to register volume for %s", name);
-		ret = volume ? PTR_ERR(volume) : -EOPNOTSUPP;
-		volume = NULL;
+		kfree(name);
+		return volume ? PTR_ERR(volume) : -EOPNOTSUPP;
 	}
 
 	sbi->volume = volume;
 	kfree(name);
-	return ret;
+
+	fscache = erofs_fscache_register_cookie(sb, sbi->opt.fsid, true);
+	/* acquired volume will be relinquished in kill_sb() */
+	if (IS_ERR(fscache))
+		return PTR_ERR(fscache);
+
+	sbi->s_fscache = fscache;
+	return 0;
 }
 
 void erofs_fscache_unregister_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
+	erofs_fscache_unregister_cookie(sbi->s_fscache);
 	fscache_relinquish_volume(sbi->volume, NULL, false);
+	sbi->s_fscache = NULL;
 	sbi->volume = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index cfee49d33b95..b36850dd7813 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -610,27 +610,26 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
 
-int erofs_fscache_register_cookie(struct super_block *sb,
-				  struct erofs_fscache **fscache,
-				  char *name, bool need_inode);
-void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode);
+void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache);
 
 extern const struct address_space_operations erofs_fscache_access_aops;
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
-	return 0;
+	return -EOPNOTSUPP;
 }
 static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
 
-static inline int erofs_fscache_register_cookie(struct super_block *sb,
-						struct erofs_fscache **fscache,
-						char *name, bool need_inode)
+static inline
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode)
 {
-	return -EOPNOTSUPP;
+	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
+static inline void erofs_fscache_unregister_cookie(struct erofs_fscache *fscache)
 {
 }
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9716d355a63e..884e7ed3d760 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -224,10 +224,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			     struct erofs_device_info *dif, erofs_off_t *pos)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_fscache *fscache;
 	struct erofs_deviceslot *dis;
 	struct block_device *bdev;
 	void *ptr;
-	int ret;
 
 	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
 	if (IS_ERR(ptr))
@@ -245,10 +245,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	}
 
 	if (erofs_is_fscache_mode(sb)) {
-		ret = erofs_fscache_register_cookie(sb, &dif->fscache,
-				dif->path, false);
-		if (ret)
-			return ret;
+		fscache = erofs_fscache_register_cookie(sb, dif->path, false);
+		if (IS_ERR(fscache))
+			return PTR_ERR(fscache);
+		dif->fscache = fscache;
 	} else {
 		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
 					  sb->s_type);
@@ -706,11 +706,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (err)
 			return err;
 
-		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
-						    sbi->opt.fsid, true);
-		if (err)
-			return err;
-
 		err = super_setup_bdi(sb);
 		if (err)
 			return err;
@@ -817,7 +812,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	fs_put_dax(dif->dax_dev, NULL);
 	if (dif->bdev)
 		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
-	erofs_fscache_unregister_cookie(&dif->fscache);
+	erofs_fscache_unregister_cookie(dif->fscache);
+	dif->fscache = NULL;
 	kfree(dif->path);
 	kfree(dif);
 	return 0;
@@ -889,7 +885,6 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
 	kfree(sbi);
@@ -909,7 +904,7 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
-	erofs_fscache_unregister_cookie(&sbi->s_fscache);
+	erofs_fscache_unregister_fs(sb);
 }
 
 static struct file_system_type erofs_fs_type = {
-- 
2.20.1

