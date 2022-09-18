Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E15BBD80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiIRLCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 07:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIRLCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:02:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631A725EA2
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 04:02:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l10so25481425plb.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 04:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UweWG+KAoxByUvXZiE3w8yEZnszL9VIJ0HppK6iQww0=;
        b=ag00KFBqWU+JiczYO3n8Rf0xhiOUKF+o4e/4tBQimFDUVD4YOWwQ4u/pujKCNMYHGV
         XibmFxEpwZq2PkHRvgPb1Zr7z0tzhs8QPlLwE8p/rTJ2XqkM9CF9aAyz4D4KQMKdhMrj
         r4lfpNJRHtUfy5/WsKw8HFNGTU36ENxR7n+PKcy7pEhhsplHe7yAbJU80uoTLGk99OeL
         LYiuMQTASydOdUSCqB+0O9wki2H79uMKuFEyxXxhq+yzD8snAUVbRjTN8H16BtXeGYMS
         9b18VKQL9VKpHTqorE7aUrT7RngbLlqZi2cjD6G+hmRnURv2i0OWb/+XsXxG1f0ieUls
         S0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UweWG+KAoxByUvXZiE3w8yEZnszL9VIJ0HppK6iQww0=;
        b=Y/pJw58CvOCbpPqoGG0S7IjJGg/MmD4gHKPcBUV2UzcJrBx3wgbTMFGWjO2ZKtNhgG
         gCTX27hc0giHpvJ+iFYozcFREsseCzchc4DF1rRQRbj0VbpM5fUFhpOvY3EGVd96P+1e
         p0SQlAZPoQpbiUcs8kLvUEheKfDj9zY4RtcVUXHvntiPMDtrhwhtqJudOLHHsRgYCRh4
         sLnSfCg5jfJk5ZjZDMcvjx46OKi4U2gOwIZWDMXNZx511JcuYJc9voysd6Vx94j23yCK
         tpNCkjF324EOzyLhkVkgh3vcLlXxA3p4oM0CAQLceQJhuuTqzPJ2Cj56Bv8wLZYw4SIZ
         WU/A==
X-Gm-Message-State: ACrzQf3rXZn1Dm9MuJPBiK5LWN/OrOnsfmekcN2W3HfoBY/h4JvOQEWJ
        /zsJz5zZEnzIyBodhr6yxhEKHQ==
X-Google-Smtp-Source: AMsMyM75FwxtKty+GHBdCRVMz8gsVEXtrZ7edfDeBRIsRRTIVYHdoogNtGfyq/2bgUh6fGWBUAyrzg==
X-Received: by 2002:a17:90a:e552:b0:203:627b:6c6e with SMTP id ei18-20020a17090ae55200b00203627b6c6emr9060897pjb.59.1663498931920;
        Sun, 18 Sep 2022 04:02:11 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709027e0600b00176dee43e0dsm18161704plm.285.2022.09.18.04.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 04:02:11 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V6 5/6] erofs: Support sharing cookies in the same domain
Date:   Sun, 18 Sep 2022 19:01:50 +0800
Message-Id: <20220918110150.6338-1-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220918043456.147-6-zhujia.zj@bytedance.com>
References: <20220918043456.147-6-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Several erofs filesystems can belong to one domain, and data blobs can
be shared among these erofs filesystems of same domain.

Users could specify domain_id mount option to create or join into a
domain.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 99 ++++++++++++++++++++++++++++++++++++++++++---
 fs/erofs/internal.h |  3 ++
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 4a7346b9fa73..ce9301a890f9 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -7,6 +7,7 @@
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
+static DEFINE_MUTEX(erofs_domain_cookies_lock);
 static LIST_HEAD(erofs_domain_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
@@ -527,8 +528,9 @@ static int erofs_fscache_register_domain(struct super_block *sb)
 	return err;
 }
 
-struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-						     char *name, bool need_inode)
+static
+struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
+						    char *name, bool need_inode)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
@@ -577,17 +579,102 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 	return ERR_PTR(ret);
 }
 
-void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
+static void erofs_fscache_relinquish_cookie(struct erofs_fscache *ctx)
 {
-	if (!ctx)
-		return;
-
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
 	iput(ctx->inode);
+	kfree(ctx->name);
 	kfree(ctx);
 }
 
+static
+struct erofs_fscache *erofs_fscache_domain_init_cookie(struct super_block *sb,
+							char *name, bool need_inode)
+{
+	int err;
+	struct inode *inode;
+	struct erofs_fscache *ctx;
+	struct erofs_domain *domain = EROFS_SB(sb)->domain;
+
+	ctx = erofs_fscache_acquire_cookie(sb, name, need_inode);
+	if (IS_ERR(ctx))
+		return ctx;
+
+	ctx->name = kstrdup(name, GFP_KERNEL);
+	if (!ctx->name) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	inode = new_inode(erofs_pseudo_mnt->mnt_sb);
+	if (!inode) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	ctx->domain = domain;
+	ctx->anon_inode = inode;
+	inode->i_private = ctx;
+	refcount_inc(&domain->ref);
+	return ctx;
+out:
+	erofs_fscache_relinquish_cookie(ctx);
+	return ERR_PTR(err);
+}
+
+static
+struct erofs_fscache *erofs_domain_register_cookie(struct super_block *sb,
+						    char *name, bool need_inode)
+{
+	struct inode *inode;
+	struct erofs_fscache *ctx;
+	struct erofs_domain *domain = EROFS_SB(sb)->domain;
+	struct super_block *psb = erofs_pseudo_mnt->mnt_sb;
+
+	mutex_lock(&erofs_domain_cookies_lock);
+	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
+		ctx = inode->i_private;
+		if (!ctx || ctx->domain != domain || strcmp(ctx->name, name))
+			continue;
+		igrab(inode);
+		mutex_unlock(&erofs_domain_cookies_lock);
+		return ctx;
+	}
+	ctx = erofs_fscache_domain_init_cookie(sb, name, need_inode);
+	mutex_unlock(&erofs_domain_cookies_lock);
+	return ctx;
+}
+
+struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
+						     char *name, bool need_inode)
+{
+	if (EROFS_SB(sb)->opt.domain_id)
+		return erofs_domain_register_cookie(sb, name, need_inode);
+	return erofs_fscache_acquire_cookie(sb, name, need_inode);
+}
+
+void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
+{
+	bool drop;
+	struct erofs_domain *domain;
+
+	if (!ctx)
+		return;
+	domain = ctx->domain;
+	if (domain) {
+		mutex_lock(&erofs_domain_cookies_lock);
+		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
+		iput(ctx->anon_inode);
+		mutex_unlock(&erofs_domain_cookies_lock);
+		if (!drop)
+			return;
+	}
+
+	erofs_fscache_relinquish_cookie(ctx);
+	erofs_fscache_domain_put(domain);
+}
+
 int erofs_fscache_register_fs(struct super_block *sb)
 {
 	int ret;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 273fb35170e2..0f63830c9056 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -109,6 +109,9 @@ struct erofs_domain {
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
 	struct inode *inode;
+	struct inode *anon_inode;
+	struct erofs_domain *domain;
+	char *name;
 };
 
 struct erofs_sb_info {
-- 
2.20.1

