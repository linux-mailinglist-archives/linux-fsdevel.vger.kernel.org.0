Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4536C5BA8E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiIPJAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 05:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiIPJAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:00:22 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E7A1FCCD
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 02:00:06 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v4so19740961pgi.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=y6Z4QOKHCiEESumRJUmDeS9lxU9MKoynA0yak47BDUs=;
        b=NrX12gSf4jM/V8og+yGfMA8n9WCizJr6q4/RjPJveQCFxzOq/adVuIZXBYA/B9vLDt
         0x/1l0dEfCvl2RwRWILujiVCwzHNu6Qc52DlslHRTAUqhUrJ83YIGiiwYJfyFx3ii7wP
         84kROl7lAa2IZv5da5/Wra7jsSE+Nq1JB8i/6MTeT2QHIA4aaH6JNpOUTGiKcpNgc0OZ
         3njd2ohWTBoU+/83MLPTNaxepkYZh9xZLoAafqOjq6XzHKFJiNv/gNb+azEFneT0u7nz
         Ksbul6b3pVvFcy7SifoRae2Lifu+6VDEKSK2psbktytkJALDWk3p4dUZ/MXzph4fWrXg
         rkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=y6Z4QOKHCiEESumRJUmDeS9lxU9MKoynA0yak47BDUs=;
        b=OF6zryAxglb6rBqnjPeyv/G3Q+LhNQKsSYYYzFYvcxCzyp4W1s3zRHB7jPbIa2thjE
         ckxly8Ki8xXXgPV+GkH0IzG00uHnDYCZPmgMwIHnmwyfEhD3ogAjy3CDqO2GvZi67ZBk
         FmSEsZHFxBle19kbHs70Evhy2uUGpM6coYbpWZeravGD/Qi9nceWkmc2z6mAE4dCjHsZ
         FZHdBl/61anW90rBt6osIkVjmHnfue4Sku1VwErQeo96+t0NYXLQZaynuBKUfzvQuVqS
         B7tli5SDLZ9wLvo+anHnAsyx1Avu3NiyiBHFvzXZPsF1comu4B6JebDBrTaoJR9t+PVa
         Qx2Q==
X-Gm-Message-State: ACrzQf0/Hb2RZd4bfUyYQwObe9ydHXZV0O3dwJEp98+ebntJiXfWlxYW
        gPN/JuNYRkBSuYVQ04fd9yN2lelctaiE3Q==
X-Google-Smtp-Source: AMsMyM6uLCJSHd/aLlOffa/l2pS+LnBIaADrHEwm+XOqzcTsyn/mRN93vSiXQewSFGn/YHwiU06BMg==
X-Received: by 2002:a63:ff66:0:b0:434:df48:4c28 with SMTP id s38-20020a63ff66000000b00434df484c28mr3638918pgk.102.1663318805553;
        Fri, 16 Sep 2022 02:00:05 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a450b00b001fd7fe7d369sm970578pjg.54.2022.09.16.02.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 02:00:05 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V5 4/6] erofs: introduce a pseudo mnt to manage shared cookies
Date:   Fri, 16 Sep 2022 16:59:38 +0800
Message-Id: <20220916085940.89392-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220916085940.89392-1-zhujia.zj@bytedance.com>
References: <20220916085940.89392-1-zhujia.zj@bytedance.com>
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

Use a pseudo mnt to manage shared cookies.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 13 +++++++++++++
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 9c82284e66ee..4a7346b9fa73 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -8,6 +8,7 @@
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
 static LIST_HEAD(erofs_domain_list);
+static struct vfsmount *erofs_pseudo_mnt;
 
 static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
 					     loff_t start, size_t len)
@@ -428,6 +429,10 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
 	mutex_lock(&erofs_domain_list_lock);
 	if (refcount_dec_and_test(&domain->ref)) {
 		list_del(&domain->list);
+		if (list_empty(&erofs_domain_list)) {
+			kern_unmount(erofs_pseudo_mnt);
+			erofs_pseudo_mnt = NULL;
+		}
 		mutex_unlock(&erofs_domain_list_lock);
 		fscache_relinquish_volume(domain->volume, NULL, false);
 		kfree(domain->domain_id);
@@ -482,6 +487,14 @@ static int erofs_fscache_init_domain(struct super_block *sb)
 	if (err)
 		goto out;
 
+	if (!erofs_pseudo_mnt) {
+		erofs_pseudo_mnt = kern_mount(&erofs_fs_type);
+		if (IS_ERR(erofs_pseudo_mnt)) {
+			err = PTR_ERR(erofs_pseudo_mnt);
+			goto out;
+		}
+	}
+
 	domain->volume = sbi->volume;
 	refcount_set(&domain->ref, 1);
 	list_add(&domain->list, &erofs_domain_list);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4c11313a072f..273fb35170e2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -402,6 +402,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
 }
 
 extern const struct super_operations erofs_sops;
+extern struct file_system_type erofs_fs_type;
 
 extern const struct address_space_operations erofs_raw_access_aops;
 extern const struct address_space_operations z_erofs_aops;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 884e7ed3d760..ab746181ae08 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -676,6 +676,13 @@ static const struct export_operations erofs_export_ops = {
 	.get_parent = erofs_get_parent,
 };
 
+static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context *fc)
+{
+	static const struct tree_descr empty_descr = {""};
+
+	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
+}
+
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -776,6 +783,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	return 0;
 }
 
+static int erofs_fc_anon_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, erofs_fc_fill_pseudo_super);
+}
+
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
 	struct erofs_fs_context *ctx = fc->fs_private;
@@ -844,10 +856,21 @@ static const struct fs_context_operations erofs_context_ops = {
 	.free		= erofs_fc_free,
 };
 
+static const struct fs_context_operations erofs_anon_context_ops = {
+	.get_tree       = erofs_fc_anon_get_tree,
+};
+
 static int erofs_init_fs_context(struct fs_context *fc)
 {
-	struct erofs_fs_context *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	struct erofs_fs_context *ctx;
+
+	/* pseudo mount for anon inodes */
+	if (fc->sb_flags & SB_KERNMOUNT) {
+		fc->ops = &erofs_anon_context_ops;
+		return 0;
+	}
 
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
@@ -874,6 +897,12 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
+	/* pseudo mount for anon inodes */
+	if (sb->s_flags & SB_KERNMOUNT) {
+		kill_anon_super(sb);
+		return;
+	}
+
 	if (erofs_is_fscache_mode(sb))
 		kill_anon_super(sb);
 	else
@@ -907,7 +936,7 @@ static void erofs_put_super(struct super_block *sb)
 	erofs_fscache_unregister_fs(sb);
 }
 
-static struct file_system_type erofs_fs_type = {
+struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
 	.init_fs_context = erofs_init_fs_context,
-- 
2.20.1

