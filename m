Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0E05A7D5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiHaMcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 08:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiHaMcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:32:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05F1D34CA
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:32:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l3so13980769plb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hKdWBWYDJXs3UW3r3n8QFJOIlhbYwEmeU3wrkibpOYY=;
        b=pK3IAzKKQvStYX4DzEh+ITweFS7+vZS9qSQ6azRv6tawU7l+L4AfSSEbKYnTlX3NNV
         T3SPmRcSpufC7NjP8RH4Fhs65lTQtA8PhrWMqMOEwx/SXmWIZJFCuSOzqiYvodZfoPnq
         zQ2j6YVqNeu0G3hMm5V8x7/cGNKlvH/QrzNLp43nd1Ty0m8C3NNaicVt+VRsehgSiU6x
         J5Gbnl/P6l/Sbz7laxsv3yvzHKT30l79GFiTcQpAmu0B0+LVJhwzqD0fyFq4vkAvy0jf
         STcrdCaSsELHXPnH9J42B//HYhxVLrXuYOuTNupjL1yWeK2yE/7jqvMGT2aT1B6+wZ7H
         D38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hKdWBWYDJXs3UW3r3n8QFJOIlhbYwEmeU3wrkibpOYY=;
        b=3G5w8xAyJgpi5C1mUN0mA8gv5/KkHfJcpX/FCJVoDaVwO9Y9FJQXdzem5/Jkh1kCLP
         HiXK9sKsJBfPMTR5SQY97REmwZZzDbAl5rx60X1KNP5UCt4gccMn5EafhJ2iD9ayEU+Y
         cXKE1haigkLmd8UEVkrrelZGQFMmYZ50/A/9QmTPP5ZctwltNMQLNUbJxMBCBo0+sAnH
         +dt3CEiVua8r2NUhJeGsF09atWzlB7woSQRsVIvxVoXdq5sfoWY+tbSPVU1vmjsdW4Nz
         QKBCL4mC5wN7Hy8HZ+isGOVOkdfXM84bdUgIVXL9ohbJJSU4JSEBosLtTYOOx9i+nMHk
         1lOw==
X-Gm-Message-State: ACgBeo3ySf5GRmlWSrWPCGyD7u05+K4k9fTJQ1IGSaBaixO89oFxqwUN
        9ebp3ubhSpz8sw0fZMgdBiX4Gg==
X-Google-Smtp-Source: AA6agR4+sdkfStqKcbUG8P3Il+NIzfdjpnLXYTLm2Vg4zvQgw+UbRR/T3Hc/sNcImlkk+cIYwkm+8Q==
X-Received: by 2002:a17:902:cec7:b0:172:5b09:161c with SMTP id d7-20020a170902cec700b001725b09161cmr24846276plg.60.1661949127383;
        Wed, 31 Aug 2022 05:32:07 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0016efad0a63csm11769896plf.100.2022.08.31.05.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:32:07 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [RFC PATCH 2/5] erofs: introduce fscache-based domain
Date:   Wed, 31 Aug 2022 20:31:22 +0800
Message-Id: <20220831123125.68693-3-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220831123125.68693-1-zhujia.zj@bytedance.com>
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A new fscache-based shared domain mode is going to be introduced for
erofs. In which case, same data blobs in same domain will be shared
and reused to reduce on-disk space usage.

As the first step, we use pseudo mnt to manage and maintain domain's
lifecycle.

The implementation of sharing blobs will be introduced in subsequent
patches.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/Makefile   |   2 +-
 fs/erofs/domain.c   | 115 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/fscache.c  |  10 +++-
 fs/erofs/internal.h |  20 +++++++-
 fs/erofs/super.c    |  17 ++++---
 5 files changed, 154 insertions(+), 10 deletions(-)
 create mode 100644 fs/erofs/domain.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 99bbc597a3e9..a4af7ecf636f 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -5,4 +5,4 @@ erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
-erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o domain.o
diff --git a/fs/erofs/domain.c b/fs/erofs/domain.c
new file mode 100644
index 000000000000..6461e4ee3582
--- /dev/null
+++ b/fs/erofs/domain.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022, Bytedance Inc. All rights reserved.
+ */
+
+#include <linux/pseudo_fs.h>
+#include <linux/fs_context.h>
+#include <linux/magic.h>
+#include <linux/fscache.h>
+
+#include "internal.h"
+
+static DEFINE_SPINLOCK(erofs_domain_list_lock);
+static LIST_HEAD(erofs_domain_list);
+
+void erofs_fscache_domain_get(struct erofs_domain *domain)
+{
+	if (!domain)
+		return;
+	refcount_inc(&domain->ref);
+}
+
+void erofs_fscache_domain_put(struct erofs_domain *domain)
+{
+	if (!domain)
+		return;
+	if (refcount_dec_and_test(&domain->ref)) {
+		fscache_relinquish_volume(domain->volume, NULL, false);
+		spin_lock(&erofs_domain_list_lock);
+		list_del(&domain->list);
+		spin_unlock(&erofs_domain_list_lock);
+		kern_unmount(domain->mnt);
+		kfree(domain->domain_id);
+		kfree(domain);
+	}
+}
+
+static int anon_inodefs_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx = init_pseudo(fc, ANON_INODE_FS_MAGIC);
+
+	if (!ctx)
+		return -ENOMEM;
+	return 0;
+}
+
+static struct file_system_type anon_inode_fs_type = {
+	.name		= "pseudo_domainfs",
+	.init_fs_context = anon_inodefs_init_fs_context,
+	.kill_sb	= kill_anon_super,
+};
+
+static int erofs_fscache_init_domain(struct super_block *sb)
+{
+	int err;
+	struct erofs_domain *domain;
+	struct vfsmount *pseudo_mnt;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	domain = kzalloc(sizeof(struct erofs_domain), GFP_KERNEL);
+	if (!domain)
+		return -ENOMEM;
+
+	domain->domain_id = kstrdup(sbi->opt.domain_id, GFP_KERNEL);
+	if (!domain->domain_id) {
+		kfree(domain);
+		return -ENOMEM;
+	}
+	sbi->domain = domain;
+	pseudo_mnt = kern_mount(&anon_inode_fs_type);
+	if (IS_ERR(pseudo_mnt)) {
+		err = PTR_ERR(pseudo_mnt);
+		goto out;
+	}
+	err = erofs_fscache_register_fs(sb);
+	if (err) {
+		kern_unmount(pseudo_mnt);
+		goto out;
+	}
+
+	domain->mnt = pseudo_mnt;
+	domain->volume = sbi->volume;
+	refcount_set(&domain->ref, 1);
+	mutex_init(&domain->mutex);
+	pseudo_mnt->mnt_sb->s_fs_info = domain;
+	list_add(&domain->list, &erofs_domain_list);
+	return 0;
+out:
+	kfree(domain->domain_id);
+	kfree(domain);
+	sbi->domain = NULL;
+	return err;
+}
+
+int erofs_fscache_register_domain(struct super_block *sb)
+{
+	int err;
+	struct erofs_domain *domain;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	spin_lock(&erofs_domain_list_lock);
+	list_for_each_entry(domain, &erofs_domain_list, list) {
+		if (!strcmp(domain->domain_id, sbi->opt.domain_id)) {
+			erofs_fscache_domain_get(domain);
+			sbi->domain = domain;
+			sbi->volume = domain->volume;
+			spin_unlock(&erofs_domain_list_lock);
+			return 0;
+		}
+	}
+	err = erofs_fscache_init_domain(sb);
+	spin_unlock(&erofs_domain_list_lock);
+
+	return err;
+}
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 8e01d89c3319..5c918a06ae9a 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -495,7 +495,8 @@ int erofs_fscache_register_fs(struct super_block *sb)
 	char *name;
 	int ret = 0;
 
-	name = kasprintf(GFP_KERNEL, "erofs,%s", sbi->opt.fsid);
+	name = kasprintf(GFP_KERNEL, "erofs,%s",
+			sbi->domain ? sbi->domain->domain_id : sbi->opt.fsid);
 	if (!name)
 		return -ENOMEM;
 
@@ -515,6 +516,11 @@ void erofs_fscache_unregister_fs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
-	fscache_relinquish_volume(sbi->volume, NULL, false);
+	if (sbi->domain)
+		erofs_fscache_domain_put(sbi->domain);
+	else
+		fscache_relinquish_volume(sbi->volume, NULL, false);
+
 	sbi->volume = NULL;
+	sbi->domain = NULL;
 }
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index fe435d077f1a..bca4e9c57890 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -99,6 +99,15 @@ struct erofs_sb_lz4_info {
 	u16 max_pclusterblks;
 };
 
+struct erofs_domain {
+	refcount_t ref;
+	struct mutex mutex;
+	struct vfsmount *mnt;
+	struct list_head list;
+	struct fscache_volume *volume;
+	char *domain_id;
+};
+
 struct erofs_fscache {
 	struct fscache_cookie *cookie;
 	struct inode *inode;
@@ -158,6 +167,7 @@ struct erofs_sb_info {
 	/* fscache support */
 	struct fscache_volume *volume;
 	struct erofs_fscache *s_fscache;
+	struct erofs_domain *domain;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
@@ -608,8 +618,11 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 
 /* fscache.c */
 #ifdef CONFIG_EROFS_FS_ONDEMAND
+void erofs_fscache_domain_get(struct erofs_domain *domain);
+void erofs_fscache_domain_put(struct erofs_domain *domain);
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
+int erofs_fscache_register_domain(struct super_block *sb);
 
 int erofs_fscache_register_cookie(struct super_block *sb,
 				  struct erofs_fscache **fscache,
@@ -620,10 +633,15 @@ extern const struct address_space_operations erofs_fscache_access_aops;
 #else
 static inline int erofs_fscache_register_fs(struct super_block *sb)
 {
-	return 0;
+	return -EOPNOTSUPP;
 }
 static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
 
+static inline int erofs_fscache_register_domain(const struct super_block *sb)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int erofs_fscache_register_cookie(struct super_block *sb,
 						struct erofs_fscache **fscache,
 						char *name, bool need_inode)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index fb5a84a07bd5..55d2343c18a4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -715,12 +715,17 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_blocksize = EROFS_BLKSIZ;
 		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
 
-		err = erofs_fscache_register_fs(sb);
-		if (err)
-			return err;
-
-		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
-						    sbi->opt.fsid, true);
+		if (sbi->opt.domain_id) {
+			err = erofs_fscache_register_domain(sb);
+			if (err)
+				return err;
+		} else {
+			err = erofs_fscache_register_fs(sb);
+			if (err)
+				return err;
+			err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
+					sbi->opt.fsid, true);
+		}
 		if (err)
 			return err;
 
-- 
2.20.1

