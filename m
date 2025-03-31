Return-Path: <linux-fsdevel+bounces-45344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3DBA7663B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98A6165C13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2FB202F61;
	Mon, 31 Mar 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7LaTGKH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EAC155393;
	Mon, 31 Mar 2025 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743424957; cv=none; b=fHWDNBckRva9Q4Wvo4Jp1GO+sWDWW32QKy8MekYLk5+SflUIyhEgnuZovdpxFKGceQJit6wm/iP9ekrQgm+Jk7uKfNIsRAm6hypcB4OC4CqR4f55qHTz992ty2rowaJU+3KOWegIcw9//9JRbDh9zMTb3s/g2bV/tymy3rNJ+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743424957; c=relaxed/simple;
	bh=Lc007aEuHorTCRuZvzw28cSxiGhASElsj7NvgrkOgYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0WD69ofDI91QBQ70EhIcEBLU19GEb6YMb/nNJ5uEyXKzU0FgXo2Je19C/onQfRbm8uQTgI0AYXs5Vu7pkQol7NyN7EXpDpBFLHFMELdokglUjp2XEOJpyn+0he0bAKONXlll6BXgqwKbrYfhPFV6yCMytFbbjI2RlxttCkf7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7LaTGKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA213C4CEE3;
	Mon, 31 Mar 2025 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743424956;
	bh=Lc007aEuHorTCRuZvzw28cSxiGhASElsj7NvgrkOgYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7LaTGKHqdUHMM0pXPj6gOmSihJKJdBMj4Au4tJtko8uaBbEDzdQ8zzL8rgtBBbI3
	 t/VPts7zPkmr8UVhXzMauI74VYmZyySh+//J2jX4XsWbTfHiVJxfGsybkhJNmknLVN
	 J4MWDpOZUBZzE3ldtgIMdwUaVPfRsl1+E+R7/g6SWkOUAIeTDZrDihsAjqSyoDP/ZP
	 DrdUhpvIac0dILZchQSNJoWusUJyiWBMxwf3EA1v7pAe8NIqa665VCXPxGAENsPgc+
	 IjeCLlnNVzAzY1mnstXtoVcfhFOUbgZBoAIOLDcMrpOZCEiSBZFPqK1S2sqZBkDy48
	 BtqwSPAsSj6Qw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH 2/2] efivarfs: support freeze/thaw
Date: Mon, 31 Mar 2025 14:42:12 +0200
Message-ID: <20250331-work-freeze-v1-2-6dfbe8253b9f@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=8738; i=brauner@kernel.org; h=from:subject:message-id; bh=Lc007aEuHorTCRuZvzw28cSxiGhASElsj7NvgrkOgYs=; b=kA0DAAoWkcYbwGV43KIByyZiAGfqjaXIK1bKyoFYvCIgxTtX1GQG972OLpjX6oTaIkTOsBCkO Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmfqjaUACgkQkcYbwGV43KI5IgD/VDI8 M3DEtkFFvDpvtrma4iu8MK7c80H4hNeXBrALV8ABAIku4X5VRZb0ihP5WxZ2f4OaaVbm3/7XNsV CZm1++uoG
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Allow efivarfs to partake to resync variable state during system
hibernation and suspend. Add freeze/thaw support.

This is a pretty straightforward implementation. We simply add regular
freeze/thaw support for both userspace and the kernel. This works
without any big issues and congrats afaict efivars is the first
pseudofilesystem that adds support for filesystem freezing and thawing.

The simplicity comes from the fact that we simply always resync variable
state after efivarfs has been frozen. It doesn't matter whether that's
because of suspend, userspace initiated freeze or hibernation. Efivars
is simple enough that it doesn't matter that we walk all dentries. There
are no directories and there aren't insane amounts of entries and both
freeze/thaw are already heavy-handed operations. We really really don't
need to care.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/efivarfs/internal.h |   1 -
 fs/efivarfs/super.c    | 196 +++++++++++++------------------------------------
 2 files changed, 51 insertions(+), 146 deletions(-)

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index ac6a1dd0a6a5..f913b6824289 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -17,7 +17,6 @@ struct efivarfs_fs_info {
 	struct efivarfs_mount_opts mount_opts;
 	struct super_block *sb;
 	struct notifier_block nb;
-	struct notifier_block pm_nb;
 };
 
 struct efi_variable {
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 0486e9b68bc6..567e849a03fe 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -20,6 +20,7 @@
 #include <linux/printk.h>
 
 #include "internal.h"
+#include "../internal.h"
 
 static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
 				 void *data)
@@ -119,12 +120,18 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	return 0;
 }
+
+static int efivarfs_freeze_fs(struct super_block *sb);
+static int efivarfs_unfreeze_fs(struct super_block *sb);
+
 static const struct super_operations efivarfs_ops = {
 	.statfs = efivarfs_statfs,
 	.drop_inode = generic_delete_inode,
 	.alloc_inode = efivarfs_alloc_inode,
 	.free_inode = efivarfs_free_inode,
 	.show_options = efivarfs_show_options,
+	.freeze_fs = efivarfs_freeze_fs,
+	.unfreeze_fs = efivarfs_unfreeze_fs,
 };
 
 /*
@@ -367,8 +374,6 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	register_pm_notifier(&sfi->pm_nb);
-
 	return efivar_init(efivarfs_callback, sb, true);
 }
 
@@ -393,48 +398,6 @@ static const struct fs_context_operations efivarfs_context_ops = {
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
-{
-	unsigned long size;
-	struct efivarfs_ctx *ectx = container_of(ctx, struct efivarfs_ctx, ctx);
-	struct qstr qstr = { .name = name, .len = len };
-	struct dentry *dentry = d_hash_and_lookup(ectx->sb->s_root, &qstr);
-	struct inode *inode;
-	struct efivar_entry *entry;
-	int err;
-
-	if (IS_ERR_OR_NULL(dentry))
-		return true;
-
-	inode = d_inode(dentry);
-	entry = efivar_entry(inode);
-
-	err = efivar_entry_size(entry, &size);
-	size += sizeof(__u32);	/* attributes */
-	if (err)
-		size = 0;
-
-	inode_lock_nested(inode, I_MUTEX_CHILD);
-	i_size_write(inode, size);
-	inode_unlock(inode);
-
-	if (!size) {
-		ectx->dentry = dentry;
-		return false;
-	}
-
-	dput(dentry);
-
-	return true;
-}
-
 static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendor,
 				  unsigned long name_size, void *data)
 {
@@ -474,111 +437,59 @@ static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendor,
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
 static struct file_system_type efivarfs_type;
 
-static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
-			      void *ptr)
+static int efivarfs_freeze_fs(struct super_block *sb)
 {
-	struct efivarfs_fs_info *sfi = container_of(nb, struct efivarfs_fs_info,
-						    pm_nb);
-	struct path path;
-	struct efivarfs_ctx ectx = {
-		.ctx = {
-			.actor	= efivarfs_actor,
-		},
-		.sb = sfi->sb,
-	};
-	struct file *file;
-	struct super_block *s = sfi->sb;
-	static bool rescan_done = true;
-
-	if (action == PM_HIBERNATION_PREPARE) {
-		rescan_done = false;
-		return NOTIFY_OK;
-	} else if (action != PM_POST_HIBERNATION) {
-		return NOTIFY_DONE;
-	}
-
-	if (rescan_done)
-		return NOTIFY_DONE;
-
-	/* ensure single superblock is alive and pin it */
-	if (!atomic_inc_not_zero(&s->s_active))
-		return NOTIFY_DONE;
-
-	pr_info("efivarfs: resyncing variable state\n");
+	/* Nothing for us to do. */
+	return 0;
+}
 
-	path.dentry = sfi->sb->s_root;
+static int efivarfs_unfreeze_fs(struct super_block *sb)
+{
+	struct dentry *child = NULL;
 
 	/*
-	 * do not add SB_KERNMOUNT which a single superblock could
-	 * expose to userspace and which also causes MNT_INTERNAL, see
-	 * below
+	 * Unconditionally resync the variable state on a thaw request.
+	 * Given the size of efivarfs it really doesn't matter to simply
+	 * iterate through all of the entries and resync. Freeze/thaw
+	 * requests are rare enough for that to not matter and the
+	 * number of entries is pretty low too. So we really don't care.
 	 */
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
+	pr_info("efivarfs: resyncing variable state\n");
+	for (;;) {
+		int err;
+		size_t size;
+		struct inode *inode;
+		struct efivar_entry *entry;
+
+		child = find_next_child(sb->s_root, child);
+		if (!child)
+			break;
+
+		inode = d_inode(child);
+		entry = efivar_entry(inode);
+
+		err = efivar_entry_size(entry, &size);
+		if (err)
+			size = 0;
+		else
+			size += sizeof(__u32);
+
+		inode_lock(inode);
+		i_size_write(inode, size);
+		inode_unlock(inode);
+
+		if (!err)
+			continue;
+
+		/* The variable doesn't exist anymore, delete it. */
+		simple_recursive_removal(child, NULL);
 	}
 
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
-	rescan_done = true;
-
-	/*
-	 * First loop over the directory and verify each entry exists,
-	 * removing it if it doesn't
-	 */
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
-
-	/*
-	 * then loop over variables, creating them if there's no matching
-	 * dentry
-	 */
-	efivar_init(efivarfs_check_missing, sfi->sb, false);
-
-	return NOTIFY_OK;
+	efivar_init(efivarfs_check_missing, sb, false);
+	pr_info("efivarfs: finished resyncing variable state\n");
+	return 0;
 }
 
 static int efivarfs_init_fs_context(struct fs_context *fc)
@@ -598,9 +509,6 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 	fc->s_fs_info = sfi;
 	fc->ops = &efivarfs_context_ops;
 
-	sfi->pm_nb.notifier_call = efivarfs_pm_notify;
-	sfi->pm_nb.priority = 0;
-
 	return 0;
 }
 
@@ -608,9 +516,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
 {
 	struct efivarfs_fs_info *sfi = sb->s_fs_info;
 
-	blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi->nb);
 	kill_litter_super(sb);
-	unregister_pm_notifier(&sfi->pm_nb);
 
 	kfree(sfi);
 }

-- 
2.47.2


