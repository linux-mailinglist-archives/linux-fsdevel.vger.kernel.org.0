Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9BB5B86B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiINKwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 06:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiINKvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:51:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674A67D7BF
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:51:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q3so14157792pjg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IrNJXJy2Qfp61vWuuO+NXKEK9HBiciqOqk0BOw7bdEk=;
        b=HuHz/O1NbGKWuzT134PJzmW4zHJ9Ig1Ewm9e5IpSywIIu5wXuE418wYKvpALrR6v4I
         RN7Z37cPxS3wS5zFO6uzGT3yNiNRagQ4W+L73PwsPmemfYytu9gHuLZRgDmBMwTI9TJ0
         iH3rFVMW/PKg1BmZYzFycEtLWDXQYrdei2lIymMgw3CRgq/DpZSy0zCoMqzMBADF/Owa
         aYwO67wj1v8KhA+8mM4bfl1/Mc8MD7ljvNR2qDE+cIHud8tu/dXFyzZybV+KuBWKKRv4
         afZKFGtzDMxVMR8d89LGYr9MPzfdKnwNBxhBd0q4iwTveTZpe2edFeJh5taI+rOnGtOf
         vZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IrNJXJy2Qfp61vWuuO+NXKEK9HBiciqOqk0BOw7bdEk=;
        b=EHzDueyyDTPQHsBSFJYPxf8wCsPRwGH/IdCcoXLNSdwtBhK/KY3JDG02ardsvDfMfL
         DujjwQmYdx8sZPEKL9UbiLa/hBiW/amjGhsDX3jsjxA+V4eipbPXL14Y2TUZvLL4HfCA
         lyVI4I+j9ZE+dBv5WHUXddpDFA6zUbjLdDe2a8kJ1/ULdocgByoZvXRnUFpakXkW7yiu
         vIkKC/c2MGzi6gIdwOy0QwNFe2L6ntMfyoCLihyU0aZmoUKn5hXk1aPwepGTHx7DWGJ1
         RreRPktyh1JyS0Cdh/hYGRQnbkXjccQrlH2pMzEIe8iGwhM8O5KBbjftjovwSh6QAWAv
         kbAA==
X-Gm-Message-State: ACgBeo1iWUwPIAEegsBQ9pLJvofFG0HFDc+5DT0Sx7WY8AeueNNu+R8/
        2pfCpxKzH3A43AflDhr9JTz5UA==
X-Google-Smtp-Source: AA6agR7zIf6cTNMutEmLYBBSDrMiX8sfjaJDTX66cNjrRwG7LFaLG1XSqM4sbjMoWE5vt1C4y9Ht1g==
X-Received: by 2002:a17:902:c944:b0:178:4568:9f99 with SMTP id i4-20020a170902c94400b0017845689f99mr8157121pla.98.1663152669412;
        Wed, 14 Sep 2022 03:51:09 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([2400:8800:1f02:83:4000:0:1:2])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b0016dc2366722sm10537042plg.77.2022.09.14.03.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:51:09 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V3 5/6] erofs: introduce a pseudo mnt to manage shared cookies
Date:   Wed, 14 Sep 2022 18:50:40 +0800
Message-Id: <20220914105041.42970-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220914105041.42970-1-zhujia.zj@bytedance.com>
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
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

Use a pseudo mnt to manage shared cookies.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/fscache.c  | 13 +++++++++++++
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 31 +++++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index b2100dc67cde..4e0a441afb7d 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -8,6 +8,7 @@
 
 static DEFINE_MUTEX(erofs_domain_list_lock);
 static LIST_HEAD(erofs_domain_list);
+static struct vfsmount *erofs_pseudo_mnt;
 
 static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space *mapping,
 					     loff_t start, size_t len)
@@ -436,6 +437,10 @@ static void erofs_fscache_domain_put(struct erofs_domain *domain)
 		fscache_relinquish_volume(domain->volume, NULL, false);
 		mutex_lock(&erofs_domain_list_lock);
 		list_del(&domain->list);
+		if (list_empty(&erofs_domain_list)) {
+			kern_unmount(erofs_pseudo_mnt);
+			erofs_pseudo_mnt = NULL;
+		}
 		mutex_unlock(&erofs_domain_list_lock);
 		kfree(domain->domain_id);
 		kfree(domain);
@@ -489,6 +494,14 @@ static int erofs_fscache_init_domain(struct super_block *sb)
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
 	mutex_init(&domain->mutex);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5ce6889d6f1d..4dd0b545755a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -403,6 +403,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
 }
 
 extern const struct super_operations erofs_sops;
+extern struct file_system_type erofs_fs_type;
 
 extern const struct address_space_operations erofs_raw_access_aops;
 extern const struct address_space_operations z_erofs_aops;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 856758ee4869..ced1d2fd6e4b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -688,6 +688,13 @@ static const struct export_operations erofs_export_ops = {
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
@@ -789,6 +796,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -858,10 +870,20 @@ static const struct fs_context_operations erofs_context_ops = {
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
@@ -888,6 +910,11 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
+	if (sb->s_flags & SB_KERNMOUNT) {
+		kill_litter_super(sb);
+		return;
+	}
+
 	if (erofs_is_fscache_mode(sb))
 		kill_anon_super(sb);
 	else
@@ -923,7 +950,7 @@ static void erofs_put_super(struct super_block *sb)
 	sbi->s_fscache = NULL;
 }
 
-static struct file_system_type erofs_fs_type = {
+struct file_system_type erofs_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "erofs",
 	.init_fs_context = erofs_init_fs_context,
-- 
2.20.1

