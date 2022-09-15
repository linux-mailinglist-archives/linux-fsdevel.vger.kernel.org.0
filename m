Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB35B9B32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiIOMn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 08:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiIOMm6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:42:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2B09C8E9
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g4so17261747pgc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xWjAf9wvMTwIsrKn+t2CcTOjGhpgH45SYj+wwCJhngo=;
        b=jqkPqCE35yUwSiFS4layyrnkw357wLFQjNU/RN8Xg1EPyR1hhKr5rcjmOiunTu58xc
         Ikj4NQfFFN2nSkhuFVi1VDDFbtaaXoTPVtOweRi54RxKj9IFruQDVJABZf1IkcP20KqK
         fT5i2ijCDSzDCI9UvSQSgSTAp0go5qZ6MDIgHGKDDPypU4kHGu30diX9XvrLivvFpuzP
         cXVRIeqPZ6wCP28mPpVOHcpbAsQ1l1cQdI0s0iea6s48BtBmGs+ieUeKYvnGTGDPcSq9
         wfUZiy/CjS4WIo+nbq1NFcUuJB0gg9Bub3GCiGCiDK0UpWH5GMDk0Ig0mlT0KSyw9eO2
         dhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xWjAf9wvMTwIsrKn+t2CcTOjGhpgH45SYj+wwCJhngo=;
        b=gl4j95Gpp/gJlLAk3ALaq1uEV6cprDQMwoi4w32vYp/iWBp4PHMPnqtE73i3pm0Hc2
         vrSFZdJ+vOrcw8EQLsr3RYD7AtUx2OIzzk8Po11QVPvs5wTQpTGCjp3zQ4a3oxKsJlj2
         FqyNQhT3u3fG/p66X4zmiHAb93EmtvIFOk0QD+Q3tOa4BKtT9HvuRtfDWVrt22Pxsk1H
         OGnR2ffxatdoMSW/QAptmdHltQNfVHrMHa2OBiW6Qg+NaifzytgrTIuFKA4A4XGVFxLd
         9jWq9OHJdYAJeuHEgSJsXtItUxrSVfYjkD3Xx+Cyrp0OqoqGc65zYOt4IgUNW5YKCbNL
         zyMg==
X-Gm-Message-State: ACgBeo39OhWzvomWmNfjXER3gO0r49jxY1WMJQd0ZsZf+STLtB+2rpfd
        dQbd9PcE6Eiv6b/Uz0NMUWG57g==
X-Google-Smtp-Source: AA6agR5XMjVI1b1fxEsxrzJECABjHTdCah+A6klG74cl2/JM3hA2zEEHXXJAnQ+hjydGuWqiXsQWGQ==
X-Received: by 2002:a05:6a00:cd6:b0:546:d03:3dd7 with SMTP id b22-20020a056a000cd600b005460d033dd7mr12939600pfv.19.1663245768868;
        Thu, 15 Sep 2022 05:42:48 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001637529493esm12721906pll.66.2022.09.15.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:42:48 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V4 5/6] erofs: Support sharing cookies in the same domain
Date:   Thu, 15 Sep 2022 20:42:12 +0800
Message-Id: <20220915124213.25767-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220915124213.25767-1-zhujia.zj@bytedance.com>
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
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

Several erofs filesystems can belong to one domain, and data blobs can
be shared among these erofs filesystems of same domain.

Users could specify domain_id mount option to create or join into a
domain.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 90 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/internal.h |  3 ++
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ff8382df493e..8873a093cf7b 100644
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
@@ -577,14 +578,99 @@ struct erofs_fscache *erofs_fscache_register_cookie(struct super_block *sb,
 	return ERR_PTR(ret);
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
+		kfree(ctx->name);
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
+	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
+	fscache_relinquish_cookie(ctx->cookie, false);
+	if (need_inode)
+		iput(ctx->inode);
+	kfree(ctx);
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
 void erofs_fscache_unregister_cookie(struct erofs_fscache *ctx)
 {
+	bool drop;
+	struct erofs_domain *domain;
+
 	if (!ctx)
 		return;
+	domain = ctx->domain;
+	if (domain) {
+		mutex_lock(&erofs_domain_cookies_lock);
+		drop = atomic_read(&ctx->anon_inode->i_count) == 1;
+		iput(ctx->anon_inode);
+		mutex_unlock(&erofs_domain_cookies_lock);
+		if (!drop)
+			return;
+	}
 
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
+	erofs_fscache_domain_put(domain);
 	iput(ctx->inode);
+	kfree(ctx->name);
 	kfree(ctx);
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 88c1a46867b3..8a6f94b27a23 100644
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

