Return-Path: <linux-fsdevel+bounces-36965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B89EB763
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A420E168F86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F5B232799;
	Tue, 10 Dec 2024 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mRsmtLAx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341161BC09F;
	Tue, 10 Dec 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850240; cv=none; b=Te8aJrbo8ylFs7VhstQcWCyVKaVGDK/lUYZCWgWJUep1rqWeVRVxyec2IycHyg53+ozg+ySW35QeyheLtlgPR6wybmejcGsIPWC0odSUJEHWDcZphDOloBFkjc/XCMyM8quVGlJeZtXH378wBGLHho11UXyZ9PWVG1ArkZfVopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850240; c=relaxed/simple;
	bh=RQvizUjBb/iiBoVKkcw/0RJ+LOxqNMarJAfCTsIS6ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bjAer9MWT/wNGziqg1Wnctg54R3vwcVtMkfD+CSu9WumvpnJ+g3UIZxFCWFtwEtyeZbPmyrN5tOmufN3KDGGK1BbxXpPwkxSI0ox2NWRecA/R1rPaF1f4T/0qtye8U11QudCAWM6b1OnPw8EZ/uMcYPWwvxwXduEZfoH9JI5yyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=mRsmtLAx; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733850238;
	bh=RQvizUjBb/iiBoVKkcw/0RJ+LOxqNMarJAfCTsIS6ko=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=mRsmtLAxcesC0NgwFkDE4eQm6LiOouPpdOfwwVODd+cTY4ix/GvPrVFlTZTE5s9gX
	 kYzUh/cW/mdDx3HSWDShkAK4Qyk4Z7rOFb5G7n8cG1wZl1E20ZnAPKQ9xjOXDOqfpr
	 2o91pc2Z9Yu5ZHwKqaopiArkNaIqRW1Ma7eDSqd8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8606E12819EA;
	Tue, 10 Dec 2024 12:03:58 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id rYLrRsEEVGEz; Tue, 10 Dec 2024 12:03:58 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D0D241281666;
	Tue, 10 Dec 2024 12:03:57 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 5/6] efivarfs: remove unused efivarfs_list
Date: Tue, 10 Dec 2024 12:02:23 -0500
Message-Id: <20241210170224.19159-6-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove all function helpers and mentions of the efivarfs_list now that
all consumers of the list have been removed and entry management goes
exclusively through the inode.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/inode.c    |  5 ---
 fs/efivarfs/internal.h | 12 +-----
 fs/efivarfs/super.c    | 15 ++-----
 fs/efivarfs/vars.c     | 89 ++++++------------------------------------
 4 files changed, 16 insertions(+), 105 deletions(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 586446e02ef7..ad4f66e0d09d 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -77,7 +77,6 @@ bool efivarfs_valid_name(const char *str, int len)
 static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
 			   struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct efivarfs_fs_info *info = dir->i_sb->s_fs_info;
 	struct inode *inode = NULL;
 	struct efivar_entry *var;
 	int namelen, i = 0, err = 0;
@@ -119,10 +118,6 @@ static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	inode->i_private = var;
 	kmemleak_ignore(var);
 
-	err = efivar_entry_add(var, &info->efivarfs_list);
-	if (err)
-		goto out;
-
 	d_instantiate(dentry, inode);
 	dget(dentry);
 out:
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index d768bfa7f12b..e3816ec0e9d8 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -6,7 +6,6 @@
 #ifndef EFIVAR_FS_INTERNAL_H
 #define EFIVAR_FS_INTERNAL_H
 
-#include <linux/list.h>
 #include <linux/efi.h>
 
 struct efivarfs_mount_opts {
@@ -16,7 +15,6 @@ struct efivarfs_mount_opts {
 
 struct efivarfs_fs_info {
 	struct efivarfs_mount_opts mount_opts;
-	struct list_head efivarfs_list;
 	struct super_block *sb;
 	struct notifier_block nb;
 };
@@ -28,15 +26,11 @@ struct efi_variable {
 
 struct efivar_entry {
 	struct efi_variable var;
-	struct list_head list;
 };
 
-int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
-			    struct list_head *),
-		void *data, struct list_head *head);
+int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
+		void *data);
 
-int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
-void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
 int efivar_entry_delete(struct efivar_entry *entry);
 
 int efivar_entry_size(struct efivar_entry *entry, unsigned long *size);
@@ -47,8 +41,6 @@ int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
 int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 			      unsigned long *size, void *data, bool *set);
 
-int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
-		      struct list_head *head, void *data);
 
 bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 		     unsigned long data_size);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 70b99f58c906..c9425a546691 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -43,10 +43,7 @@ static void efivarfs_evict_inode(struct inode *inode)
 {
 	struct efivar_entry *entry = inode->i_private;
 
-	if (entry)  {
-		list_del(&entry->list);
-		kfree(entry);
-	}
+	kfree(entry);
 	clear_inode(inode);
 }
 
@@ -208,8 +205,7 @@ bool efivarfs_variable_is_present(efi_char16_t *variable_name,
 }
 
 static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
-			     unsigned long name_size, void *data,
-			     struct list_head *list)
+			     unsigned long name_size, void *data)
 {
 	struct super_block *sb = (struct super_block *)data;
 	struct efivar_entry *entry;
@@ -253,7 +249,6 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	}
 
 	__efivar_entry_get(entry, NULL, &size, NULL);
-	__efivar_entry_add(entry, list);
 
 	/* copied by the above to local storage in the dentry. */
 	kfree(name);
@@ -344,7 +339,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	return efivar_init(efivarfs_callback, sb, &sfi->efivarfs_list);
+	return efivar_init(efivarfs_callback, sb);
 }
 
 static int efivarfs_get_tree(struct fs_context *fc)
@@ -379,8 +374,6 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 	if (!sfi)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&sfi->efivarfs_list);
-
 	sfi->mount_opts.uid = GLOBAL_ROOT_UID;
 	sfi->mount_opts.gid = GLOBAL_ROOT_GID;
 
@@ -396,8 +389,6 @@ static void efivarfs_kill_sb(struct super_block *sb)
 	blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi->nb);
 	kill_litter_super(sb);
 
-	/* Remove all entries and destroy */
-	WARN_ON(!list_empty(&sfi->efivarfs_list));
 	kfree(sfi);
 }
 
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index bda8e8b869e8..4cac01a0e483 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -364,16 +364,14 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
  * efivar_init - build the initial list of EFI variables
  * @func: callback function to invoke for every variable
  * @data: function-specific data to pass to @func
- * @head: initialised head of variable list
  *
  * Get every EFI variable from the firmware and invoke @func. @func
- * should call efivar_entry_add() to build the list of variables.
+ * should populate the initial dentry and inode tree.
  *
  * Returns 0 on success, or a kernel error code on failure.
  */
-int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
-			    struct list_head *),
-		void *data, struct list_head *head)
+int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
+		void *data)
 {
 	unsigned long variable_name_size = 512;
 	efi_char16_t *variable_name;
@@ -424,7 +422,7 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
 				status = EFI_NOT_FOUND;
 			} else {
 				err = func(variable_name, vendor_guid,
-					   variable_name_size, data, head);
+					   variable_name_size, data);
 				if (err)
 					status = EFI_NOT_FOUND;
 			}
@@ -456,42 +454,12 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
 }
 
 /**
- * efivar_entry_add - add entry to variable list
- * @entry: entry to add to list
- * @head: list head
- *
- * Returns 0 on success, or a kernel error code on failure.
- */
-int efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
-{
-	int err;
-
-	err = efivar_lock();
-	if (err)
-		return err;
-	list_add(&entry->list, head);
-	efivar_unlock();
-
-	return 0;
-}
-
-/**
- * __efivar_entry_add - add entry to variable list
- * @entry: entry to add to list
- * @head: list head
- */
-void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
-{
-	list_add(&entry->list, head);
-}
-
-/**
- * efivar_entry_delete - delete variable and remove entry from list
+ * efivar_entry_delete - delete variable
  * @entry: entry containing variable to delete
  *
- * Delete the variable from the firmware and remove @entry from the
- * variable list. It is the caller's responsibility to free @entry
- * once we return.
+ * Delete the variable from the firmware. It is the caller's
+ * responsibility to free @entry (by deleting the dentry/inode) once
+ * we return.
  *
  * Returns 0 on success, -EINTR if we can't grab the semaphore,
  * converted EFI status code if set_variable() fails.
@@ -605,7 +573,7 @@ int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
  * get_variable() fail.
  *
  * If the EFI variable does not exist when calling set_variable()
- * (EFI_NOT_FOUND), @entry is removed from the variable list.
+ * (EFI_NOT_FOUND).
  */
 int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 			      unsigned long *size, void *data, bool *set)
@@ -621,9 +589,8 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 		return -EINVAL;
 
 	/*
-	 * The lock here protects the get_variable call, the conditional
-	 * set_variable call, and removal of the variable from the efivars
-	 * list (in the case of an authenticated delete).
+	 * The lock here protects the get_variable call and the
+	 * conditional set_variable call
 	 */
 	err = efivar_lock();
 	if (err)
@@ -661,37 +628,3 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 	return err;
 
 }
-
-/**
- * efivar_entry_iter - iterate over variable list
- * @func: callback function
- * @head: head of variable list
- * @data: function-specific data to pass to callback
- *
- * Iterate over the list of EFI variables and call @func with every
- * entry on the list. It is safe for @func to remove entries in the
- * list via efivar_entry_delete() while iterating.
- *
- * Some notes for the callback function:
- *  - a non-zero return value indicates an error and terminates the loop
- *  - @func is called from atomic context
- */
-int efivar_entry_iter(int (*func)(struct efivar_entry *, void *),
-		      struct list_head *head, void *data)
-{
-	struct efivar_entry *entry, *n;
-	int err = 0;
-
-	err = efivar_lock();
-	if (err)
-		return err;
-
-	list_for_each_entry_safe(entry, n, head, list) {
-		err = func(entry, data);
-		if (err)
-			break;
-	}
-	efivar_unlock();
-
-	return err;
-}
-- 
2.35.3


