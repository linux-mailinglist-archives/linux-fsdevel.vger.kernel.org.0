Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE364505F6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 23:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiDRVkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 17:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiDRVkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:40:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDF42E9FB
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 14:37:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2117C1F419FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650317846;
        bh=Y+ucbxeR+Qi5rPHrBhvrhU/yGHcw5E2wDEXDS0A6lTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9CgekMQMobPNA/RLWz4ovzCY0yGOFDl8V/g4lc9S1gl6ccLy58WhtNDUHuyHD+G8
         radeF2PEzd4xCBi5HHl1lCBjoeedo8GWRvo51FZNxcn5zc+K0BmiRgTS2IeCzoVuvl
         mDRyqXT/ncSV7XbRUyDfvlFQnZ72jx0MswnjYCYm9xzktnAn2D1xFYBnL64E0qP1RK
         3CkGxjPCu1ATn8HNruvg5o3QWnuHdaX/4kTh3aNhh80iqog4DljGeSoOlGLV6ON94i
         4qeLSFi0N7r6iqPOm1rmU395Ck9GR7XAe+rZo8wHjUZjhfHhlPTja3Ww3Ohzf4gIg1
         5wk4el4Dr96Qw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     hughd@google.com, akpm@linux-foundation.org, amir73il@gmail.com
Cc:     viro@zeniv.linux.org.uk,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 2/3] shmem: Introduce /sys/fs/tmpfs support
Date:   Mon, 18 Apr 2022 17:37:12 -0400
Message-Id: <20220418213713.273050-3-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418213713.273050-1-krisman@collabora.com>
References: <20220418213713.273050-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to expose tmpfs statistics on sysfs, add the boilerplate code
to create the /sys/fs/tmpfs structure.  As suggested on a previous
review, this uses the minor as the volume directory in /sys/fs/.

This takes care of not exposing SB_NOUSER mounts.  I don't think we have
a usecase for showing them and, since they don't appear elsewhere, they
might be confusing to users.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Use kobject to release sbinfo (Viro)

Changes since v1:
  - Use minor instead of fsid for directory in sysfs. (Amir)
---
 include/linux/shmem_fs.h |  2 ++
 mm/shmem.c               | 46 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 1a7cd9ea9107..6c1f3a4b8c46 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -47,6 +47,8 @@ struct shmem_sb_info {
 
 	unsigned long acct_errors;
 	unsigned long space_errors;
+
+	struct kobject kobj;
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
diff --git a/mm/shmem.c b/mm/shmem.c
index c350fa0a0fff..8fe4a22e83a6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -250,6 +250,7 @@ static const struct inode_operations shmem_dir_inode_operations;
 static const struct inode_operations shmem_special_inode_operations;
 static const struct vm_operations_struct shmem_vm_ops;
 static struct file_system_type shmem_fs_type;
+static struct kobject *shmem_root;
 
 bool vma_is_shmem(struct vm_area_struct *vma)
 {
@@ -3582,17 +3583,44 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
+#if defined(CONFIG_SYSFS)
+#define TMPFS_SB_ATTR_RO(name)	\
+	static struct kobj_attribute tmpfs_sb_attr_##name = __ATTR_RO(name)
+
+static struct attribute *tmpfs_attrs[] = {
+	NULL
+};
+ATTRIBUTE_GROUPS(tmpfs);
+#endif /* CONFIG_SYSFS */
+
 #endif /* CONFIG_TMPFS */
 
-static void shmem_put_super(struct super_block *sb)
+static void tmpfs_sb_release(struct kobject *kobj)
 {
-	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+	struct shmem_sb_info *sbinfo =
+		container_of(kobj, struct shmem_sb_info, kobj);
 
 	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
 	kfree(sbinfo);
+}
+
+static struct kobj_type tmpfs_sb_ktype = {
+#if defined(CONFIG_TMPFS) && defined(CONFIG_SYSFS)
+	.default_groups = tmpfs_groups,
+#endif
+	.sysfs_ops	= &kobj_sysfs_ops,
+	.release	= tmpfs_sb_release,
+};
+
+static void shmem_put_super(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+
 	sb->s_fs_info = NULL;
+
+	kobject_put(&sbinfo->kobj);
 }
 
 static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
@@ -3608,6 +3636,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 		return -ENOMEM;
 
 	sb->s_fs_info = sbinfo;
+	kobject_init(&sbinfo->kobj, &tmpfs_sb_ktype);
 
 #ifdef CONFIG_TMPFS
 	/*
@@ -3673,6 +3702,11 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)
 		goto failed;
+
+	if (!(sb->s_flags & SB_NOUSER) &&
+	    kobject_add(&sbinfo->kobj, shmem_root, "%d", MINOR(sb->s_dev)))
+		goto failed;
+
 	return 0;
 
 failed:
@@ -3889,11 +3923,15 @@ int __init shmem_init(void)
 		goto out2;
 	}
 
+	shmem_root = kobject_create_and_add("tmpfs", fs_kobj);
+	if (!shmem_root)
+		goto out1;
+
 	shm_mnt = kern_mount(&shmem_fs_type);
 	if (IS_ERR(shm_mnt)) {
 		error = PTR_ERR(shm_mnt);
 		pr_err("Could not kern_mount tmpfs\n");
-		goto out1;
+		goto put_kobj;
 	}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -3904,6 +3942,8 @@ int __init shmem_init(void)
 #endif
 	return 0;
 
+put_kobj:
+	kobject_put(shmem_root);
 out1:
 	unregister_filesystem(&shmem_fs_type);
 out2:
-- 
2.35.1

