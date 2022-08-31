Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CECB5A7D69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiHaMco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 08:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiHaMc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:32:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D032D398E
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:32:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so9488681pjj.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=helHwjQ1amx6sVpTUTNQHDek/KZbVCB+DokfAJJxgvw=;
        b=xnANbkoYtNEadF8Ow9iiySSrrjB4JBOG1rya4cOCRbkFcAwq2QmkxVZsv3+RaFg81T
         WPC14ed6swycXqDFFKrtXemoB7HQofevGUbr03bqc+l+w2HmIUxtG43LPfhJcT+roQfy
         /WYbhkycvUWeblj0KZdSPShub8O9Kc8oAiFokR4jcmc6Uu8qp7RxYQ8sygN3cPabcuOH
         eYDBZn3kNQXnyihxoOdR17iqNqafD3xA1K/2kJh++H4O3/+vGSQhB021HMZuiRm5lCWl
         IULjsDAqr3Kq8XW58ZO7OR0sJhIXn3ghXLAx4C+egY1181KV7mbvRsjD/UDIzo+Fcshp
         XRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=helHwjQ1amx6sVpTUTNQHDek/KZbVCB+DokfAJJxgvw=;
        b=JxH7FoiniM7aWWmJEFu2lHJmQdnL+ArL6ZzdZr+yKK1KoT00kFhQXFwlpOadqgBCXl
         pHIfFRqqB8kF1/32j3EhcIVZEzrL1LyaXpVRvxy58I1WKi6yPva+ZSh8HSqEIBdAWsR3
         MTmD0R1LqnbOPZ7e5xQTjditrFs3y+dq2CKtDtD0ZcRE482sXrJ8sq8X4dQnXGWiq3BC
         hdr2AAU36E3csZdEdgbxsuoaM6pIjvLLqjsar6sNzho4qk/yDIqfSdb/FCcf3BJG4RF4
         Zy36YioP1oeoLSNHgkR7WB31Kju4+E9aGi+pCW/hdOXexu1XHG/6Lx1A9q5elBWRdHXa
         MJZA==
X-Gm-Message-State: ACgBeo2e3XKvJ5GvnnVTf2NxXT7tHJ0uUCychFAzNWq4yAzpTe0L0KwT
        AqHp0gCj6crjcL30ONHFic+Q/A==
X-Google-Smtp-Source: AA6agR7bL+1gEdR1cwCGxhsTwLthUGNCIQjqaMBLzgdcqa5MECtZu1yardGPFvPLevcAOcM5vyzLvA==
X-Received: by 2002:a17:902:c40f:b0:175:3c1e:8493 with SMTP id k15-20020a170902c40f00b001753c1e8493mr4453098plk.19.1661949142037;
        Wed, 31 Aug 2022 05:32:22 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0016efad0a63csm11769896plf.100.2022.08.31.05.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:32:21 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [RFC PATCH 5/5] erofs: support fscache based shared domain
Date:   Wed, 31 Aug 2022 20:31:25 +0800
Message-Id: <20220831123125.68693-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220831123125.68693-1-zhujia.zj@bytedance.com>
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Several erofs filesystems can belong to one domain, and data blobs can
be shared among these erofs filesystems of same domain.

Users could specify domain_id mount option to create or join into a domain.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/domain.c   | 60 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/fscache.c  |  7 ++++++
 fs/erofs/internal.h | 13 ++++++++++
 fs/erofs/super.c    | 10 ++++++--
 4 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/domain.c b/fs/erofs/domain.c
index 6461e4ee3582..ea7b591b7db1 100644
--- a/fs/erofs/domain.c
+++ b/fs/erofs/domain.c
@@ -13,6 +13,66 @@
 static DEFINE_SPINLOCK(erofs_domain_list_lock);
 static LIST_HEAD(erofs_domain_list);
 
+static int erofs_fscache_domain_init_cookie(struct super_block *sb,
+		struct erofs_fscache **fscache, char *name, bool need_inode)
+{
+	int ret;
+	struct inode *inode;
+	struct erofs_fscache *ctx;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_domain *domain = sbi->domain;
+
+	ret = erofs_fscache_register_cookie(sb, &ctx, name, need_inode);
+	if (ret)
+		return ret;
+
+	ctx->name = kstrdup(name, GFP_KERNEL);
+	if (!ctx->name)
+		return -ENOMEM;
+
+	inode = new_inode(domain->mnt->mnt_sb);
+	if (!inode) {
+		kfree(ctx->name);
+		return -ENOMEM;
+	}
+
+	ctx->domain = domain;
+	ctx->anon_inode = inode;
+	inode->i_private = ctx;
+	refcount_set(&ctx->ref, 1);
+	erofs_fscache_domain_get(domain);
+	*fscache = ctx;
+	return 0;
+}
+
+int erofs_domain_register_cookie(struct super_block *sb,
+	struct erofs_fscache **fscache, char *name, bool need_inode)
+{
+	int err;
+	struct inode *inode;
+	struct erofs_fscache *ctx;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	struct erofs_domain *domain = sbi->domain;
+	struct super_block *psb = domain->mnt->mnt_sb;
+
+	mutex_lock(&domain->mutex);
+	list_for_each_entry(inode, &psb->s_inodes, i_sb_list) {
+		ctx = inode->i_private;
+		if (!ctx)
+			continue;
+		if (!strcmp(ctx->name, name)) {
+			*fscache = ctx;
+			refcount_inc(&ctx->ref);
+			mutex_unlock(&domain->mutex);
+			return 0;
+		}
+	}
+	err = erofs_fscache_domain_init_cookie(sb, fscache, name, need_inode);
+	mutex_unlock(&domain->mutex);
+
+	return err;
+}
+
 void erofs_fscache_domain_get(struct erofs_domain *domain)
 {
 	if (!domain)
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 5c918a06ae9a..51425e310e3d 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -476,6 +476,8 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 
 	if (!ctx)
 		return;
+	if (ctx->domain && !refcount_dec_and_test(&ctx->ref))
+		return;
 
 	fscache_unuse_cookie(ctx->cookie, NULL, NULL);
 	fscache_relinquish_cookie(ctx->cookie, false);
@@ -483,7 +485,12 @@ void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 
 	iput(ctx->inode);
 	ctx->inode = NULL;
+	iput(ctx->anon_inode);
+	ctx->anon_inode = NULL;
+	erofs_fscache_domain_put(ctx->domain);
 
+	kfree(ctx->name);
+	ctx->name = NULL;
 	kfree(ctx);
 	*fscache = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index bca4e9c57890..1abdad81bfe3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -109,8 +109,12 @@ struct erofs_domain {
 };
 
 struct erofs_fscache {
+	refcount_t ref;
 	struct fscache_cookie *cookie;
 	struct inode *inode;
+	struct inode *anon_inode;
+	struct erofs_domain *domain;
+	char *name;
 };
 
 struct erofs_sb_info {
@@ -627,6 +631,9 @@ int erofs_fscache_register_domain(struct super_block *sb);
 int erofs_fscache_register_cookie(struct super_block *sb,
 				  struct erofs_fscache **fscache,
 				  char *name, bool need_inode);
+int erofs_domain_register_cookie(struct super_block *sb,
+				  struct erofs_fscache **fscache,
+				  char *name, bool need_inode);
 void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
 
 extern const struct address_space_operations erofs_fscache_access_aops;
@@ -648,6 +655,12 @@ static inline int erofs_fscache_register_cookie(struct super_block *sb,
 {
 	return -EOPNOTSUPP;
 }
+static inline int erofs_domain_register_cookie(struct super_block *sb,
+						struct erofs_fscache **fscache,
+						char *name, bool need_inode)
+{
+	return -EOPNOTSUPP;
+}
 
 static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
 {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index bbc63b7d546c..aefe7dfcd4c9 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -245,8 +245,12 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	}
 
 	if (erofs_is_fscache_mode(sb)) {
-		ret = erofs_fscache_register_cookie(sb, &dif->fscache,
-				dif->path, false);
+		if (sbi->opt.domain_id)
+			ret = erofs_domain_register_cookie(sb, &dif->fscache, dif->path,
+					false);
+		else
+			ret = erofs_fscache_register_cookie(sb, &dif->fscache, dif->path,
+					false);
 		if (ret)
 			return ret;
 	} else {
@@ -719,6 +723,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			err = erofs_fscache_register_domain(sb);
 			if (err)
 				return err;
+			err = erofs_domain_register_cookie(sb, &sbi->s_fscache,
+					sbi->opt.fsid, true);
 		} else {
 			err = erofs_fscache_register_fs(sb);
 			if (err)
-- 
2.20.1

