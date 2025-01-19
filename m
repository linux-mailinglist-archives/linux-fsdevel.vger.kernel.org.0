Return-Path: <linux-fsdevel+bounces-39617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28962A16282
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543DC3A6127
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FE81DF727;
	Sun, 19 Jan 2025 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Z30h1e9N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456B4315F;
	Sun, 19 Jan 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737299614; cv=none; b=YyqA2zNl2+UDydiDxlt8OPUNzwiO0/AD7TCO7in7cFSBg4j/PZ25FhyffH30qhydRKsx1dLh/TX0fJpKn2ZBYdE24DwafZazBUSU6ajw3TMI3ofSwc+dLsrhtkJdeWfxKS7esAnEmhN2Xvua03MMC9xi+5yDDotrR0KwhIUTgb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737299614; c=relaxed/simple;
	bh=3TD51SxpLzycrp38uYDhQmKJwYUUIsV6ycV56MlAc9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VYmRTZScCwDahBu7cPbeWFu7bfRaIRi78sMKipD7Z+mIPLhfdiDJBa1X9tM5mL/YtVg8MHGIVoj5FB2Uc9i/pJm9rulTKbkA1hTPUACpBlc4oVfAEck864pxsVGgFRr7bM/YAIfwzsvFDRpJoz0YcLyKmBVJwm81qDxoi/LYPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Z30h1e9N; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737299612;
	bh=3TD51SxpLzycrp38uYDhQmKJwYUUIsV6ycV56MlAc9E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=Z30h1e9NZtG+I5LBUDcTt7DD0m3bhzblsrpf5EfdKWSRIznzsdqn/sY+8p8ZkpD2N
	 lDy6L5HTwtPm4W2ptLTYhz51B8rRcgjhf7yqFt7+G+2Yp7I20wQmi07Nkwe9LEl9ZZ
	 iyNH3IQkfjrmI++SP+xPfc1ANuFiCDUXRZlMkZRg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 254051286343;
	Sun, 19 Jan 2025 10:13:32 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id p_rY8OKmrO4L; Sun, 19 Jan 2025 10:13:32 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 55E45128633D;
	Sun, 19 Jan 2025 10:13:31 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 4/8] efivarfs: move variable lifetime management into the inodes
Date: Sun, 19 Jan 2025 10:12:10 -0500
Message-Id: <20250119151214.23562-5-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
References: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the inodes the default management vehicle for struct
efivar_entry, so they are now all freed automatically if the file is
removed and on unmount in kill_litter_super().  Remove the now
superfluous iterator to free the entries after kill_litter_super().

Also fixes a bug where some entry freeing was missing causing efivarfs
to leak memory.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v3: Move from evict_inode to alloc_inode/free_inode
---
 fs/efivarfs/inode.c    | 23 +++++++++----------
 fs/efivarfs/internal.h |  7 +++++-
 fs/efivarfs/super.c    | 51 ++++++++++++++++++++++++------------------
 fs/efivarfs/vars.c     | 39 +++-----------------------------
 4 files changed, 48 insertions(+), 72 deletions(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index a4a6587ecd2e..259c97be4cc7 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -82,26 +82,23 @@ static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	struct efivar_entry *var;
 	int namelen, i = 0, err = 0;
 	bool is_removable = false;
+	efi_guid_t vendor;
 
 	if (!efivarfs_valid_name(dentry->d_name.name, dentry->d_name.len))
 		return -EINVAL;
 
-	var = kzalloc(sizeof(struct efivar_entry), GFP_KERNEL);
-	if (!var)
-		return -ENOMEM;
-
 	/* length of the variable name itself: remove GUID and separator */
 	namelen = dentry->d_name.len - EFI_VARIABLE_GUID_LEN - 1;
 
-	err = guid_parse(dentry->d_name.name + namelen + 1, &var->var.VendorGuid);
+	err = guid_parse(dentry->d_name.name + namelen + 1, &vendor);
 	if (err)
 		goto out;
-	if (guid_equal(&var->var.VendorGuid, &LINUX_EFI_RANDOM_SEED_TABLE_GUID)) {
+	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID)) {
 		err = -EPERM;
 		goto out;
 	}
 
-	if (efivar_variable_is_removable(var->var.VendorGuid,
+	if (efivar_variable_is_removable(vendor,
 					 dentry->d_name.name, namelen))
 		is_removable = true;
 
@@ -110,6 +107,9 @@ static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		err = -ENOMEM;
 		goto out;
 	}
+	var = efivar_entry(inode);
+
+	var->var.VendorGuid = vendor;
 
 	for (i = 0; i < namelen; i++)
 		var->var.VariableName[i] = dentry->d_name.name[i];
@@ -117,7 +117,6 @@ static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	var->var.VariableName[i] = '\0';
 
 	inode->i_private = var;
-	kmemleak_ignore(var);
 
 	err = efivar_entry_add(var, &info->efivarfs_list);
 	if (err)
@@ -126,11 +125,9 @@ static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate(dentry, inode);
 	dget(dentry);
 out:
-	if (err) {
-		kfree(var);
-		if (inode)
-			iput(inode);
-	}
+	if (err && inode)
+		iput(inode);
+
 	return err;
 }
 
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 597ccaa60d37..fce7d5e5c763 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -29,15 +29,20 @@ struct efi_variable {
 struct efivar_entry {
 	struct efi_variable var;
 	struct list_head list;
+	struct inode vfs_inode;
 };
 
+static inline struct efivar_entry *efivar_entry(struct inode *inode)
+{
+	return container_of(inode, struct efivar_entry, vfs_inode);
+}
+
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
 			    struct list_head *),
 		void *data, struct list_head *head);
 
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
 void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
-void efivar_entry_remove(struct efivar_entry *entry);
 int efivar_entry_delete(struct efivar_entry *entry);
 
 int efivar_entry_size(struct efivar_entry *entry, unsigned long *size);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 9e90823f8009..85ab3af3f1e9 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -39,9 +39,25 @@ static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
 	return NOTIFY_OK;
 }
 
-static void efivarfs_evict_inode(struct inode *inode)
+static struct inode *efivarfs_alloc_inode(struct super_block *sb)
 {
-	clear_inode(inode);
+	struct efivar_entry *entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+
+	if (!entry)
+		return NULL;
+
+	inode_init_once(&entry->vfs_inode);
+
+	return &entry->vfs_inode;
+}
+
+static void efivarfs_free_inode(struct inode *inode)
+{
+	struct efivar_entry *entry = efivar_entry(inode);
+
+	if (inode->i_private)
+		list_del(&entry->list);
+	kfree(entry);
 }
 
 static int efivarfs_show_options(struct seq_file *m, struct dentry *root)
@@ -106,7 +122,8 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 static const struct super_operations efivarfs_ops = {
 	.statfs = efivarfs_statfs,
 	.drop_inode = generic_delete_inode,
-	.evict_inode = efivarfs_evict_inode,
+	.alloc_inode = efivarfs_alloc_inode,
+	.free_inode = efivarfs_free_inode,
 	.show_options = efivarfs_show_options,
 };
 
@@ -227,21 +244,14 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
 		return 0;
 
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return err;
-
-	memcpy(entry->var.VariableName, name16, name_size);
-	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
-
 	name = efivar_get_utf8name(name16, &vendor);
 	if (!name)
-		goto fail;
+		return err;
 
 	/* length of the variable name itself: remove GUID and separator */
 	len = strlen(name) - EFI_VARIABLE_GUID_LEN - 1;
 
-	if (efivar_variable_is_removable(entry->var.VendorGuid, name, len))
+	if (efivar_variable_is_removable(vendor, name, len))
 		is_removable = true;
 
 	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
@@ -249,6 +259,11 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	if (!inode)
 		goto fail_name;
 
+	entry = efivar_entry(inode);
+
+	memcpy(entry->var.VariableName, name16, name_size);
+	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
+
 	dentry = efivarfs_alloc_dentry(root, name);
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
@@ -273,16 +288,8 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	iput(inode);
 fail_name:
 	kfree(name);
-fail:
-	kfree(entry);
-	return err;
-}
 
-static int efivarfs_destroy(struct efivar_entry *entry, void *data)
-{
-	efivar_entry_remove(entry);
-	kfree(entry);
-	return 0;
+	return err;
 }
 
 enum {
@@ -407,7 +414,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
 	kill_litter_super(sb);
 
 	/* Remove all entries and destroy */
-	efivar_entry_iter(efivarfs_destroy, &sfi->efivarfs_list, NULL);
+	WARN_ON(!list_empty(&sfi->efivarfs_list));
 	kfree(sfi);
 }
 
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index b2fc5bdc759a..bb9406e03a10 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -485,34 +485,6 @@ void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
 	list_add(&entry->list, head);
 }
 
-/**
- * efivar_entry_remove - remove entry from variable list
- * @entry: entry to remove from list
- *
- * Returns 0 on success, or a kernel error code on failure.
- */
-void efivar_entry_remove(struct efivar_entry *entry)
-{
-	list_del(&entry->list);
-}
-
-/*
- * efivar_entry_list_del_unlock - remove entry from variable list
- * @entry: entry to remove
- *
- * Remove @entry from the variable list and release the list lock.
- *
- * NOTE: slightly weird locking semantics here - we expect to be
- * called with the efivars lock already held, and we release it before
- * returning. This is because this function is usually called after
- * set_variable() while the lock is still held.
- */
-static void efivar_entry_list_del_unlock(struct efivar_entry *entry)
-{
-	list_del(&entry->list);
-	efivar_unlock();
-}
-
 /**
  * efivar_entry_delete - delete variable and remove entry from list
  * @entry: entry containing variable to delete
@@ -536,12 +508,10 @@ int efivar_entry_delete(struct efivar_entry *entry)
 	status = efivar_set_variable_locked(entry->var.VariableName,
 					    &entry->var.VendorGuid,
 					    0, 0, NULL, false);
-	if (!(status == EFI_SUCCESS || status == EFI_NOT_FOUND)) {
-		efivar_unlock();
+	efivar_unlock();
+	if (!(status == EFI_SUCCESS || status == EFI_NOT_FOUND))
 		return efi_status_to_err(status);
-	}
 
-	efivar_entry_list_del_unlock(entry);
 	return 0;
 }
 
@@ -679,10 +649,7 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
 				    &entry->var.VendorGuid,
 				    NULL, size, NULL);
 
-	if (status == EFI_NOT_FOUND)
-		efivar_entry_list_del_unlock(entry);
-	else
-		efivar_unlock();
+	efivar_unlock();
 
 	if (status && status != EFI_BUFFER_TOO_SMALL)
 		return efi_status_to_err(status);
-- 
2.35.3


