Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E514F1646
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357851AbiDDNoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357002AbiDDNnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:43:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EF33DDC3
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Apr 2022 06:41:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 0AB7E1F44928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649079714;
        bh=Q62XHry7RU5EKa0FvuVG2Xq8LLMlLOBVxsPhfZeA3sU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwY2EsFEp5c8vwG0jMYWuhyuhIbTzrZRvgvcnW/j/ZjdMxW7uaE6McSWk4tkLmYgM
         MxQA8loR8Wj9+I9ro8PtvUu7YGGsDhuKuQZ8dNlbzS5+9sUEzgqQ2450K2Ka+FeJCL
         YYRQvfaf5BcHlNHK2Suf4dSbhVhTPCv4kgmWr7G5z43FQFwPkowLEB0KmL5YRpmuw4
         hMHq7uKsj5vD1sM8dN7ihPxdPXJjVXXZsA/41dk6XWucpKOHSWGlUIeJ2X9kZasSrT
         Uj8kTA/iF9XQA3tsybApdd0Jb/KGyYLxEJ9rPAUfspWjE9nHwD4sccfymnFrt5dORS
         1W4cFuGE4Pvpg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH RESEND 2/3] shmem: Introduce /sys/fs/tmpfs support
Date:   Mon,  4 Apr 2022 09:41:36 -0400
Message-Id: <20220404134137.26284-3-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404134137.26284-1-krisman@collabora.com>
References: <20220404134137.26284-1-krisman@collabora.com>
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
Changes since v1:
  - Use minor instead of fsid for directory in sysfs. (Amir)
---
 include/linux/shmem_fs.h |  4 +++
 mm/shmem.c               | 72 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 1a7cd9ea9107..c27ecf0e1b3b 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -47,6 +47,10 @@ struct shmem_sb_info {
 
 	unsigned long acct_errors;
 	unsigned long space_errors;
+
+	/* sysfs */
+	struct kobject s_kobj;		/* /sys/fs/tmpfs/<uuid> */
+	struct completion s_kobj_unregister;
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
diff --git a/mm/shmem.c b/mm/shmem.c
index c350fa0a0fff..665d417ba8a8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -250,6 +250,7 @@ static const struct inode_operations shmem_dir_inode_operations;
 static const struct inode_operations shmem_special_inode_operations;
 static const struct vm_operations_struct shmem_vm_ops;
 static struct file_system_type shmem_fs_type;
+static struct kobject *shmem_root;
 
 bool vma_is_shmem(struct vm_area_struct *vma)
 {
@@ -3584,6 +3585,56 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 
 #endif /* CONFIG_TMPFS */
 
+#if defined(CONFIG_TMPFS) && defined(CONFIG_SYSFS)
+#define TMPFS_SB_ATTR_RO(name)	\
+	static struct kobj_attribute tmpfs_sb_attr_##name = __ATTR_RO(name)
+
+static struct attribute *tmpfs_attrs[] = {
+	NULL
+};
+ATTRIBUTE_GROUPS(tmpfs);
+
+static void tmpfs_sb_release(struct kobject *kobj)
+{
+	struct shmem_sb_info *sbinfo =
+		container_of(kobj, struct shmem_sb_info, s_kobj);
+
+	complete(&sbinfo->s_kobj_unregister);
+}
+
+static struct kobj_type tmpfs_sb_ktype = {
+	.default_groups = tmpfs_groups,
+	.sysfs_ops	= &kobj_sysfs_ops,
+	.release	= tmpfs_sb_release,
+};
+
+static void shmem_unregister_sysfs(struct super_block *sb)
+{
+	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+
+	kobject_del(&sbinfo->s_kobj);
+	kobject_put(&sbinfo->s_kobj);
+	wait_for_completion(&sbinfo->s_kobj_unregister);
+}
+
+static int shmem_register_sysfs(struct super_block *sb)
+{
+	int err;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+
+	init_completion(&sbinfo->s_kobj_unregister);
+	err = kobject_init_and_add(&sbinfo->s_kobj, &tmpfs_sb_ktype,
+				   shmem_root, "%d", MINOR(sb->s_dev));
+	if (err) {
+		kobject_put(&sbinfo->s_kobj);
+		wait_for_completion(&sbinfo->s_kobj_unregister);
+		return err;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_TMPFS && CONFIG_SYSFS */
+
 static void shmem_put_super(struct super_block *sb)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
@@ -3591,6 +3642,12 @@ static void shmem_put_super(struct super_block *sb)
 	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
+
+#if IS_ENABLED(CONFIG_TMPFS) && IS_ENABLED(CONFIG_SYSFS)
+	if (!(sb->s_flags & SB_NOUSER))
+		shmem_unregister_sysfs(sb);
+#endif
+
 	kfree(sbinfo);
 	sb->s_fs_info = NULL;
 }
@@ -3673,6 +3730,13 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)
 		goto failed;
+
+#if IS_ENABLED(CONFIG_TMPFS) && IS_ENABLED(CONFIG_SYSFS)
+	if (!(sb->s_flags & SB_NOUSER))
+		if (shmem_register_sysfs(sb))
+			goto failed;
+#endif
+
 	return 0;
 
 failed:
@@ -3889,11 +3953,15 @@ int __init shmem_init(void)
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
@@ -3904,6 +3972,8 @@ int __init shmem_init(void)
 #endif
 	return 0;
 
+put_kobj:
+	kobject_put(shmem_root);
 out1:
 	unregister_filesystem(&shmem_fs_type);
 out2:
-- 
2.35.1

