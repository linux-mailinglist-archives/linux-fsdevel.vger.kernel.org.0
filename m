Return-Path: <linux-fsdevel+bounces-44355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2068DA67D43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 20:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCDD422AE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953A212D65;
	Tue, 18 Mar 2025 19:45:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285A617A30B;
	Tue, 18 Mar 2025 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327159; cv=none; b=KARsLbOHxG4UxJPZb2/9z1gUASditZ3CL0MkthSZQwylagJzCTwJBS28Vg3OzRB7vh+22VpLH2MugQeQ+wOpA4B01HMpiDsW3t1IM3QRv6gCAePavs0JS45hgvdjhGMVOJNP0BT14RGRI+RMnGummu0NmoTfBviHHP+gaNtqd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327159; c=relaxed/simple;
	bh=mjgUYd2kEKX4/RMlqt+MrH5193XPf2wi4ZI0Gx2Y5vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qs4NGDEmDc88iv66ZVub1ekvlpgBZRFFPodn51sVbcu/KdPOwBHUhN+8CnKgXlARohJJ63vjG/iPBzPs9oMHE91EZu7OpGDY6Ssuu28bSdVj+bn68DkWUqZPWEsf8mLsitZPlsLNRkgn3CwpVKLn+u/3MktqdqbqeDPfZsqD0Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id E0BDE1C0105;
	Tue, 18 Mar 2025 15:45:55 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH 3/3] efivarfs: replace iterate_dir with libfs function simple_iterate_call
Date: Tue, 18 Mar 2025 15:41:11 -0400
Message-ID: <20250318194111.19419-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com>
References: <20250318194111.19419-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This relieves us of the requirement to have a struct path and use file
operations, which greatly simplifies the code.  The superblock is now
pinned by the blocking notifier (which is why deregistration moves
above kill_litter_super).

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/super.c | 103 +++-----------------------------------------
 1 file changed, 7 insertions(+), 96 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 81b3c6b7e100..135b0bb9b4b5 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -393,29 +393,13 @@ static const struct fs_context_operations efivarfs_context_ops = {
 	.reconfigure	= efivarfs_reconfigure,
 };
 
-struct efivarfs_ctx {
-	struct dir_context ctx;
-	struct super_block *sb;
-	struct dentry *dentry;
-};
-
-static bool efivarfs_actor(struct dir_context *ctx, const char *name, int len,
-			   loff_t offset, u64 ino, unsigned mode)
+static bool efivarfs_iterate_callback(void *data, struct dentry *dentry)
 {
 	unsigned long size;
-	struct efivarfs_ctx *ectx = container_of(ctx, struct efivarfs_ctx, ctx);
-	struct qstr qstr = { .name = name, .len = len };
-	struct dentry *dentry = d_hash_and_lookup(ectx->sb->s_root, &qstr);
-	struct inode *inode;
-	struct efivar_entry *entry;
+	struct inode *inode = d_inode(dentry);
+	struct efivar_entry *entry = efivar_entry(inode);
 	int err;
 
-	if (IS_ERR_OR_NULL(dentry))
-		return true;
-
-	inode = d_inode(dentry);
-	entry = efivar_entry(inode);
-
 	err = efivar_entry_size(entry, &size);
 	size += sizeof(__u32);	/* attributes */
 	if (err)
@@ -426,12 +410,10 @@ static bool efivarfs_actor(struct dir_context *ctx, const char *name, int len,
 	inode_unlock(inode);
 
 	if (!size) {
-		ectx->dentry = dentry;
-		return false;
+		pr_info("efivarfs: removing variable %pd\n", dentry);
+		simple_recursive_removal(dentry, NULL);
 	}
 
-	dput(dentry);
-
 	return true;
 }
 
@@ -474,33 +456,11 @@ static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendor,
 	return err;
 }
 
-static void efivarfs_deactivate_super_work(struct work_struct *work)
-{
-	struct super_block *s = container_of(work, struct super_block,
-					     destroy_work);
-	/*
-	 * note: here s->destroy_work is free for reuse (which
-	 * will happen in deactivate_super)
-	 */
-	deactivate_super(s);
-}
-
-static struct file_system_type efivarfs_type;
-
 static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
 			      void *ptr)
 {
 	struct efivarfs_fs_info *sfi = container_of(nb, struct efivarfs_fs_info,
 						    pm_nb);
-	struct path path;
-	struct efivarfs_ctx ectx = {
-		.ctx = {
-			.actor	= efivarfs_actor,
-		},
-		.sb = sfi->sb,
-	};
-	struct file *file;
-	struct super_block *s = sfi->sb;
 	static bool rescan_done = true;
 
 	if (action == PM_HIBERNATION_PREPARE) {
@@ -513,64 +473,15 @@ static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
 	if (rescan_done)
 		return NOTIFY_DONE;
 
-	/* ensure single superblock is alive and pin it */
-	if (!atomic_inc_not_zero(&s->s_active))
-		return NOTIFY_DONE;
-
 	pr_info("efivarfs: resyncing variable state\n");
 
-	path.dentry = sfi->sb->s_root;
-
-	/*
-	 * do not add SB_KERNMOUNT which a single superblock could
-	 * expose to userspace and which also causes MNT_INTERNAL, see
-	 * below
-	 */
-	path.mnt = vfs_kern_mount(&efivarfs_type, 0,
-				  efivarfs_type.name, NULL);
-	if (IS_ERR(path.mnt)) {
-		pr_err("efivarfs: internal mount failed\n");
-		/*
-		 * We may be the last pinner of the superblock but
-		 * calling efivarfs_kill_sb from within the notifier
-		 * here would deadlock trying to unregister it
-		 */
-		INIT_WORK(&s->destroy_work, efivarfs_deactivate_super_work);
-		schedule_work(&s->destroy_work);
-		return PTR_ERR(path.mnt);
-	}
-
-	/* path.mnt now has pin on superblock, so this must be above one */
-	atomic_dec(&s->s_active);
-
-	file = kernel_file_open(&path, O_RDONLY | O_DIRECTORY | O_NOATIME,
-				current_cred());
-	/*
-	 * safe even if last put because no MNT_INTERNAL means this
-	 * will do delayed deactivate_super and not deadlock
-	 */
-	mntput(path.mnt);
-	if (IS_ERR(file))
-		return NOTIFY_DONE;
-
 	rescan_done = true;
 
 	/*
 	 * First loop over the directory and verify each entry exists,
 	 * removing it if it doesn't
 	 */
-	file->f_pos = 2;	/* skip . and .. */
-	do {
-		ectx.dentry = NULL;
-		iterate_dir(file, &ectx.ctx);
-		if (ectx.dentry) {
-			pr_info("efivarfs: removing variable %pd\n",
-				ectx.dentry);
-			simple_recursive_removal(ectx.dentry, NULL);
-			dput(ectx.dentry);
-		}
-	} while (ectx.dentry);
-	fput(file);
+	simple_iterate_call(sfi->sb->s_root, NULL, efivarfs_iterate_callback);
 
 	/*
 	 * then loop over variables, creating them if there's no matching
@@ -609,8 +520,8 @@ static void efivarfs_kill_sb(struct super_block *sb)
 	struct efivarfs_fs_info *sfi = sb->s_fs_info;
 
 	blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi->nb);
-	kill_litter_super(sb);
 	unregister_pm_notifier(&sfi->pm_nb);
+	kill_litter_super(sb);
 
 	kfree(sfi);
 }
-- 
2.43.0


