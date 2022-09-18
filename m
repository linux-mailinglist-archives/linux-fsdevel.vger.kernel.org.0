Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D935BBBAE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 06:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIREfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 00:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIREfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 00:35:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9006718372
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 78so23896295pgb.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3XqQQvKG0uG83TPRNIliCiOs6LD7q8fdw/Z9yA8GyaY=;
        b=Vc9gjv79iAU7D8+P6qKuD4awJtAs0DmiUBcCXkosJhBjZub2dGX9kqeYLEEWZsm+ba
         lDmeCnflYYTrp5YXrxobi6kIoVhjmcZZDTJIV4E2K5g2DuAdgxpu0liyrIRf96Zwg+r9
         L8XCyKYtfk7pv/oypK40NjUrezc04AJfAJRDUthpagfBI3HneUZiCH+Gy4XVP9gARqIH
         UoPqXLeAcaEthgVZ/ng+zb9FXg6ezXO3J+47/xIjFiFXvhSPOKeftZP/Y8BT/levRiRM
         6r225D4nRafs+VbxN3sVP1G875H1LmIgI+7W42EjqU1vyNxvUqzkBP8TuQdk1Atc9LY1
         1Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3XqQQvKG0uG83TPRNIliCiOs6LD7q8fdw/Z9yA8GyaY=;
        b=IStTbOAlOmF7lT35J3/FowQE3JmiOlQ5m6UHyJbo90sF51av88yMNjRZJq0DkEz9VF
         gy/EzMgciQ5aw1N0CiKixQGV4plTlDfFGXzFdXB9VL3zY6IRbHczGs4A89sBF/1PWvEF
         Lw/+HhiOpH2lrEsun8tv1si4WoVzONsc8zGDWUMCqOlZjHZf5XpZLvmOG4fo2PTcTC2Y
         tKtl+b0o6k4fyB8wFManZpJ1XsITWAPoviXV4G5b1Iu4cSDxrzc87LNcHqA7tQZ9eLIg
         P7LVFobB4/kI21cwuohqYBGzd61CMw+i2MHxNTxLMr+khYtU6T+DxmIxy2+vt4mbYOOE
         RsAw==
X-Gm-Message-State: ACrzQf3QBQeGNXwxjMNHUU01YxYAPvzobI4ti5DSO/QWzb32ynr9CViL
        hIiT+0uCEOwh+7RyhEoNmm44XQ==
X-Google-Smtp-Source: AMsMyM5scqCHflHacZpDomf4TNrFiB9yWTBub7wegqlGCpFSfK1O46mJ0+pgOxwA/I11ieNOVNwB2Q==
X-Received: by 2002:a63:d54b:0:b0:42c:299e:255 with SMTP id v11-20020a63d54b000000b0042c299e0255mr10683406pgi.282.1663475715101;
        Sat, 17 Sep 2022 21:35:15 -0700 (PDT)
Received: from localhost.localdomain ([111.201.134.95])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b0054b5239f7fesm3955248pfl.210.2022.09.17.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 21:35:14 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V6 5/6] erofs: Support sharing cookies in the same domain
Date:   Sun, 18 Sep 2022 12:34:55 +0800
Message-Id: <20220918043456.147-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220918043456.147-1-zhujia.zj@bytedance.com>
References: <20220918043456.147-1-zhujia.zj@bytedance.com>
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
 fs/erofs/fscache.c  | 98 ++++++++++++++++++++++++++++++++++++++++++---
 fs/erofs/internal.h |  3 ++
 2 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 4a7346b9fa73..a4ee1b430b55 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -7,6 +7,7 @@
 #include "internal.h"
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
+static DEFINE_MUTEX(erofs_domain_cookies_lock);
 static LIST_HEAD(erofs_domain_list);
 static struct vfsmount *erofs_pseudo_mnt;
 
@@ -527,8 +528,8 @@ static int erofs_fscache_register_domain(struct super_block *sb)
 	return err;
 }
 
-struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
-						     char *name, bool need_inode)
+struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
+						    char *name, bool need_inode)
 {
 	struct fscache_volume *volume = EROFS_SB(sb)->volume;
 	struct erofs_fscache *ctx;
@@ -577,17 +578,102 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
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

