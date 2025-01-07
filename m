Return-Path: <linux-fsdevel+bounces-38609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401E2A04BD1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 22:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3243A5CDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D321F8690;
	Tue,  7 Jan 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="eqsRnceJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4061F76C4;
	Tue,  7 Jan 2025 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285605; cv=none; b=ddO7ULcnq+iOam8YR1bcuxSBCxeodymnxDgXdWfap3+jhXIVctbLrnmFI4FzBATQ/sRTal39efLBOzmg160WqCPOmDCutpJ3GgAONlyGKBBuL05qSKjhGR4aYdXPsVGKSjvWhpb0BlUAyPah3omVarKKHgyEZPLmC/A5iztjOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285605; c=relaxed/simple;
	bh=a8Mrn17PRNJn6hSgrx3WnNcaM6pjfNfZ9l7IUOAETb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXLNeWFE7XH9+xRaDs9vnkSIGmDxWZlFmG9+l96Bz9/2Zwvy6KPwJPLOt1xt2NVOdyhBGWYtod3nUOiFF2oQFkfrSaxmX55D4MPMX2cNmveLeV34QDryluNSvC+qT+1igXKIkbBcytOCScnZYihNAb4vYFFpIJvkbUS9aTefqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=eqsRnceJ; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736285602;
	bh=a8Mrn17PRNJn6hSgrx3WnNcaM6pjfNfZ9l7IUOAETb0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=eqsRnceJwmY4fNSgS0X6URVGL/90QYqUd9iGGKMyUguPCKz//A2QHH/1EPXQPt2G+
	 +ATM2M5SKn+Mqrz2B8yCaIV3Yr8NKV37Uebs1c49vX9F+OlCt6tc1/ndt8g/bGHA8M
	 Qj+6Tsr36xX4FHle0lhvzkWZ+T8je2GLsPMzgQ4U=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 14EC11286BD6;
	Tue, 07 Jan 2025 16:33:22 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id eSW1rxi7RHWk; Tue,  7 Jan 2025 16:33:21 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 396DB1286B13;
	Tue, 07 Jan 2025 16:33:21 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Lennart Poettering <mzxreary@0pointer.de>
Subject: [PATCH 2/2] efivarfs: add variable resync after hibernation
Date: Tue,  7 Jan 2025 13:31:29 -0800
Message-Id: <20250107213129.28454-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250107213129.28454-1-James.Bottomley@HansenPartnership.com>
References: <20250107213129.28454-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hibernation allows other OSs to boot and thus the variable state might
be altered by the time the hibernation image is resumed.  Resync the
variable state by looping over all the dentries and update the size
(in case of alteration) delete any which no-longer exist.  Finally,
loop over all efi variables creating any which don't have
corresponding dentries.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/internal.h |   3 +-
 fs/efivarfs/super.c    | 151 ++++++++++++++++++++++++++++++++++++++++-
 fs/efivarfs/vars.c     |   5 +-
 3 files changed, 155 insertions(+), 4 deletions(-)

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 32b83f644798..48ab75d69b26 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -17,6 +17,7 @@ struct efivarfs_fs_info {
 	struct efivarfs_mount_opts mount_opts;
 	struct super_block *sb;
 	struct notifier_block nb;
+	struct notifier_block pm_nb;
 };
 
 struct efi_variable {
@@ -30,7 +31,7 @@ struct efivar_entry {
 };
 
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
-		void *data);
+		void *data, bool duplicate_check);
 
 int efivar_entry_delete(struct efivar_entry *entry);
 
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 2523030caeda..961264f628dc 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -13,6 +13,7 @@
 #include <linux/pagemap.h>
 #include <linux/ucs2_string.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/magic.h>
 #include <linux/statfs.h>
 #include <linux/notifier.h>
@@ -356,7 +357,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	return efivar_init(efivarfs_callback, sb);
+	return efivar_init(efivarfs_callback, sb, true);
 }
 
 static int efivarfs_get_tree(struct fs_context *fc)
@@ -380,6 +381,148 @@ static const struct fs_context_operations efivarfs_context_ops = {
 	.reconfigure	= efivarfs_reconfigure,
 };
 
+struct efivarfs_ctx {
+	struct dir_context ctx;
+	struct super_block *sb;
+	struct dentry *dentry;
+};
+
+static bool efivarfs_actor(struct dir_context *ctx, const char *name, int len,
+			   loff_t offset, u64 ino, unsigned mode)
+{
+	unsigned long size;
+	struct efivarfs_ctx *ectx = container_of(ctx, struct efivarfs_ctx, ctx);
+	struct qstr qstr = { .name = name, .len = len };
+	struct dentry *dentry = d_hash_and_lookup(ectx->sb->s_root, &qstr);
+	struct inode *inode;
+	struct efivar_entry *entry;
+	int err;
+
+	if (IS_ERR_OR_NULL(dentry))
+		return true;
+
+	inode = d_inode(dentry);
+	entry = inode->i_private;
+
+	err = efivar_entry_size(entry, &size);
+	size += sizeof(__u32);	/* attributes */
+	if (err)
+		size = 0;
+
+	inode_lock(inode);
+	i_size_write(inode, size);
+	inode_unlock(inode);
+
+	if (!size) {
+		ectx->dentry = dentry;
+		return false;
+	}
+
+	dput(dentry);
+
+	return true;
+}
+
+static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendor,
+				  unsigned long name_size, void *data)
+{
+	char *name;
+	struct super_block *sb = data;
+	struct dentry *dentry;
+	struct qstr qstr;
+	int err;
+
+	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
+		return 0;
+
+	name = efivar_get_utf8name(name16, &vendor);
+	if (!name)
+		return -ENOMEM;
+
+	qstr.name = name;
+	qstr.len = strlen(name);
+	dentry = d_hash_and_lookup(sb->s_root, &qstr);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
+		goto out;
+	}
+
+	if (!dentry) {
+		/* found missing entry */
+		pr_info("efivarfs: creating variable %s\n", name);
+		return efivarfs_create_dentry(sb, name16, name_size, &vendor, name);
+	}
+
+	dput(dentry);
+	err = 0;
+
+ out:
+	kfree(name);
+
+	return err;
+}
+
+static int efivarfs_pm_notify(struct notifier_block *nb, unsigned long action,
+			      void *ptr)
+{
+	struct efivarfs_fs_info *sfi = container_of(nb, struct efivarfs_fs_info,
+						    pm_nb);
+	struct path path = { .mnt = NULL, .dentry = sfi->sb->s_root, };
+	struct efivarfs_ctx ectx = {
+		.ctx = {
+			.actor	= efivarfs_actor,
+		},
+		.sb = sfi->sb,
+	};
+	struct file *file;
+	static bool rescan_done = true;
+
+	if (action == PM_HIBERNATION_PREPARE) {
+		rescan_done = false;
+		return NOTIFY_OK;
+	} else if (action != PM_POST_HIBERNATION) {
+		return NOTIFY_DONE;
+	}
+
+	if (rescan_done)
+		return NOTIFY_DONE;
+
+	pr_info("efivarfs: resyncing variable state\n");
+
+	/* O_NOATIME is required to prevent oops on NULL mnt */
+	file = kernel_file_open(&path, O_RDONLY | O_DIRECTORY | O_NOATIME,
+				current_cred());
+	if (!file)
+		return NOTIFY_DONE;
+
+	rescan_done = true;
+
+	/*
+	 * First loop over the directory and verify each entry exists,
+	 * removing it if it doesn't
+	 */
+	file->f_pos = 2;	/* skip . and .. */
+	do {
+		ectx.dentry = NULL;
+		iterate_dir(file, &ectx.ctx);
+		if (ectx.dentry) {
+			pr_info("efivarfs: removing variable %pd\n",
+				ectx.dentry);
+			simple_recursive_removal(ectx.dentry, NULL);
+			dput(ectx.dentry);
+		}
+	} while (ectx.dentry);
+	fput(file);
+
+	/*
+	 * then loop over variables, creating them if there's no matching
+	 * dentry
+	 */
+	efivar_init(efivarfs_check_missing, sfi->sb, false);
+
+	return NOTIFY_OK;
+}
+
 static int efivarfs_init_fs_context(struct fs_context *fc)
 {
 	struct efivarfs_fs_info *sfi;
@@ -396,6 +539,11 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 
 	fc->s_fs_info = sfi;
 	fc->ops = &efivarfs_context_ops;
+
+	sfi->pm_nb.notifier_call = efivarfs_pm_notify;
+	sfi->pm_nb.priority = 0;
+	register_pm_notifier(&sfi->pm_nb);
+
 	return 0;
 }
 
@@ -405,6 +553,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
 
 	blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi->nb);
 	kill_litter_super(sb);
+	unregister_pm_notifier(&sfi->pm_nb);
 
 	kfree(sfi);
 }
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index d0beecbf9441..d720d780648b 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -371,7 +371,7 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
  * Returns 0 on success, or a kernel error code on failure.
  */
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
-		void *data)
+		void *data, bool duplicate_check)
 {
 	unsigned long variable_name_size = 512;
 	efi_char16_t *variable_name;
@@ -415,7 +415,8 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 			 * we'll ever see a different variable name,
 			 * and may end up looping here forever.
 			 */
-			if (efivarfs_variable_is_present(variable_name,
+			if (duplicate_check &&
+			    efivarfs_variable_is_present(variable_name,
 							 &vendor_guid, data)) {
 				dup_variable_bug(variable_name, &vendor_guid,
 						 variable_name_size);
-- 
2.35.3


