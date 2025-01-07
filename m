Return-Path: <linux-fsdevel+bounces-38516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A6EA0353D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973533A2F83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 02:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDBA13AD22;
	Tue,  7 Jan 2025 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Q2XlHOsc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA2770FE;
	Tue,  7 Jan 2025 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217500; cv=none; b=t54UO4uAECukk5sKibaoMhxCiWYAeIeBoqutksWHpnPwMKthET1e4wQ/9RgsGxp/WhIdqSZqn7eM97nkqNpB8coFXFqaeUeliUY3E3Lm9MCIwFg7a8iMAwFUpmUx/DVWkXB5hoOcr1BKT+asl72AcF7Gmewr0vcIRpxOP/T7t4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217500; c=relaxed/simple;
	bh=ZIao2ipGlchj3zDdHedAyQ0iemLWbX3K5aK04u6S9yY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRvdIK/IzvUpbPUGeKeyKmXeMFqrp8RYlhVFnUkcA1Cmh9ZZeBMv+G8okAbGWhrLjbj+qgOzRAuqNYY+wFKGUeNIdbIcpCOcgQl5HkYeom0gbA8ey5Nr1cWLhX9UQtQ/ZPZ/nCbEJJ9GwFpjYh0oH1Hn/CjnzjGzBwfN4sama1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Q2XlHOsc; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736217497;
	bh=ZIao2ipGlchj3zDdHedAyQ0iemLWbX3K5aK04u6S9yY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=Q2XlHOscXb15RAPhYWS0TS/lf991Wl6bnaAzqpaVZixUaq6D1/s/CyJk1AOTH2uja
	 uoH26K6MZHzpnO+bNUeyDI9c8We1XjYkZpA7CSCsLg9+XlHhCPDrmPenG/vKZ0pCIM
	 OlCh+jTEgVdx37e02cY/Ngwi7uJEV0ZlQMpiI+p0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 543481280B6C;
	Mon, 06 Jan 2025 21:38:17 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ey0vm5j_mvJ9; Mon,  6 Jan 2025 21:38:17 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E3C70128017F;
	Mon, 06 Jan 2025 21:38:16 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 5/6] efivarfs: remove unused efivarfs_list
Date: Mon,  6 Jan 2025 18:35:24 -0800
Message-Id: <20250107023525.11466-6-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
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
index ec23da8405ff..7fe1b5b60902 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -77,7 +77,6 @@ static bool efivarfs_valid_name(const char *str, int len)
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
index 8d82fc8bca31..18a600f80992 100644
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
index d7facc99b745..2523e74dbcfd 100644
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
 
@@ -217,8 +214,7 @@ bool efivarfs_variable_is_present(efi_char16_t *variable_name,
 }
 
 static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
-			     unsigned long name_size, void *data,
-			     struct list_head *list)
+			     unsigned long name_size, void *data)
 {
 	struct super_block *sb = (struct super_block *)data;
 	struct efivar_entry *entry;
@@ -262,7 +258,6 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	}
 
 	__efivar_entry_get(entry, NULL, &size, NULL);
-	__efivar_entry_add(entry, list);
 
 	/* copied by the above to local storage in the dentry. */
 	kfree(name);
@@ -353,7 +348,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	return efivar_init(efivarfs_callback, sb, &sfi->efivarfs_list);
+	return efivar_init(efivarfs_callback, sb);
 }
 
 static int efivarfs_get_tree(struct fs_context *fc)
@@ -388,8 +383,6 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 	if (!sfi)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&sfi->efivarfs_list);
-
 	sfi->mount_opts.uid = GLOBAL_ROOT_UID;
 	sfi->mount_opts.gid = GLOBAL_ROOT_GID;
 
@@ -405,8 +398,6 @@ static void efivarfs_kill_sb(struct super_block *sb)
 	blocking_notifier_chain_unregister(&efivar_ops_nh, &sfi->nb);
 	kill_litter_super(sb);
 
-	/* Remove all entries and destroy */
-	WARN_ON(!list_empty(&sfi->efivarfs_list));
 	kfree(sfi);
 }
 
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index bb9406e03a10..d0beecbf9441 100644
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


