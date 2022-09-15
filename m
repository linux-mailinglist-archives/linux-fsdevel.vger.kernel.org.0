Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3926B5B9B2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiIOMnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiIOMm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:42:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919F69A9ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k21so7682839pls.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=N+8Ic9syGTC1u0a/MXotLVtHNCtWkf7iFn7tvbMZmlY=;
        b=CHGyfbuDxEYsmMOBtJ5Xs/wDe6c91lFi6Xew7HSn99TcDb2lO22OKPoyVOtbn3MS/1
         Bo73PbLBArqJ0Sa+pDi19plOEapcqrlfeXff+lTxwRhp3tH9lnBF0OR2sS0KjbuhfAp9
         n2/LkHyiCaKigFN/GBELZWSLM9R3IacTlcu7eptgFVKWJak3WylBP3MkZGRvTXL41DBO
         2RxDXhpjM91fR9BWYAkfEy1m51pLajgNOvLpoTBOBQ9bSImNQJZ14NuOdV4MLu1oQOQ+
         kuiTkouHlmwyNkmGXfSiiDkhPLDlOgtsTWyg3vXtG7wz9yxvM4tF1D5kKGDrGi7/XE/9
         FIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=N+8Ic9syGTC1u0a/MXotLVtHNCtWkf7iFn7tvbMZmlY=;
        b=JwgiGMHaMWNVEG1MOJmISElj+fs1zx683L1Vujh0X4T0JRUyL9KuS8mzs3TXgIBTl7
         35CmAzAGL+dnCVfhurVMNHhsXxLORVRfuszK8CeebMlPlcZQyubMjIHd0ve+YLz5XvM0
         UCTN5cVkxc46wxZr73aMxrcGh/z56doSUx/oHhxpNjYlsvhS4oyyqgpZi8GVhj4iH/hM
         qf2cFbGdBjbFx/Afg2zGzah3iRRGr929TUnAJGe45nI6b5LcXISZl9EfZ/OxmRrzGs9Z
         2qBVJnyQvigxvpcy3Tqy++lI0aatPwi/qitIQSQMmYhMLNz/DoDXa0bCZIPwihcFCWGG
         G0sQ==
X-Gm-Message-State: ACrzQf0qSL/PJO9vt+QW7dYM9tQ/PGJBnPykzSINnWk7ZlmT2d0M+IFw
        shW4Ob5MP5EHnIGPiz1M9ga2UQ==
X-Google-Smtp-Source: AMsMyM6LaCBySorEeXuS16yk8C5aL7BUcb/n97QGo/YbEfpMk60hXSn1IPytvrKulSbxhuXVxleeFg==
X-Received: by 2002:a17:90a:c70b:b0:200:4366:d047 with SMTP id o11-20020a17090ac70b00b002004366d047mr10660743pjt.240.1663245765338;
        Thu, 15 Sep 2022 05:42:45 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001637529493esm12721906pll.66.2022.09.15.05.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:42:44 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V4 4/6] erofs: introduce a pseudo mnt to manage shared cookies
Date:   Thu, 15 Sep 2022 20:42:11 +0800
Message-Id: <20220915124213.25767-5-zhujia.zj@bytedance.com>
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

Use a pseudo mnt to manage shared cookies.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 13 +++++++++++++
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 31 +++++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 10d3f0511f15..ff8382df493e 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -8,6 +8,7 @@
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
 static LIST_HEAD(erofs_domain_list);
+static struct vfsmount *erofs_pseudo_mnt;
 
 static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
 					     loff_t start, size_t len)
@@ -429,6 +430,10 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
 	if (refcount_dec_and_test(&domain->ref)) {
 		list_del(&domain->list);
 		fscache_relinquish_volume(domain->volume, NULL, false);
+		if (list_empty(&erofs_domain_list)) {
+			kern_unmount(erofs_pseudo_mnt);
+			erofs_pseudo_mnt = NULL;
+		}
 		mutex_unlock(&erofs_domain_list_lock);
 		kfree(domain->domain_id);
 		kfree(domain);
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
index 7f0939f4005b..88c1a46867b3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -402,6 +402,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
 }
 
 extern const struct super_operations erofs_sops;
+extern struct file_system_type erofs_fs_type;
 
 extern const struct address_space_operations erofs_raw_access_aops;
 extern const struct address_space_operations z_erofs_aops;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 79e871c04fe2..24bac58285e8 100644
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
@@ -844,10 +856,20 @@ static const struct fs_context_operations erofs_context_ops = {
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
+	if (fc->sb_flags & SB_KERNMOUNT) {
+		fc->ops = &erofs_anon_context_ops;
+		return 0;
+	}
 
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
@@ -874,6 +896,11 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
+	if (sb->s_flags & SB_KERNMOUNT) {
+		kill_litter_super(sb);
+		return;
+	}
+
 	if (erofs_is_fscache_mode(sb))
 		kill_anon_super(sb);
 	else
@@ -908,7 +935,7 @@ static void erofs_put_super(struct super_block *sb)
 	sbi->s_fscache = NULL;
 }
 
-static struct file_system_type erofs_fs_type = {
+struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
 	.init_fs_context = erofs_init_fs_context,
-- 
2.20.1

