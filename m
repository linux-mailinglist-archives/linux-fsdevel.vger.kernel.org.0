Return-Path: <linux-fsdevel+bounces-38515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D310DA0353B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E683A3538
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 02:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1010913AD22;
	Tue,  7 Jan 2025 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FFIeBk3t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (unknown [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FD228691;
	Tue,  7 Jan 2025 02:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217472; cv=none; b=O+S/m5DhCTblk3RPDzqGBo5L7qr/zf3BwLC8wM8hz6/MnIpsJYsbWJn9Rm/lCbs7dCI50Z6LvpWHMTrCD78gLAJjH+MlskxPOJ2Gm8vdgBBu6brnVF9R5Ti3EdW6kGNX2lcBJ5VK/39CdyTnPlmKbH7S4BnsEMzG9rW7swuy9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217472; c=relaxed/simple;
	bh=tmisDjAtGHl5r+ZSk8zOBzy8Eo+Drg9L4QPsIMl1ZY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prTcQiACJ1Q/M5ahyZC6DcuD82fw4pfrYGUlZXfoV/U3SRopumHmIPuxb32Xe9o74C0A7+GjjolvQ1Jex77HtOV9fvFXCQY1iNexc7wjBfjlzZ+h/DCnErXgAnMqfY2rHtp8lNDHS7noa0jMVNtIzRN5xuW8scDBecS8KOD9Xd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=FFIeBk3t; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736217467;
	bh=tmisDjAtGHl5r+ZSk8zOBzy8Eo+Drg9L4QPsIMl1ZY0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=FFIeBk3t7yq8Pu5J8N8AJYXIlLbfaTIlsN3jLGsHFP5qphWmPMpLo/6wP+D8EGHlE
	 uTgnAYA5yoYRL4Qc2l+2AUfhB7JFjALbV07Iq9OgYRzrwxIr05iWOdkQmdbEgFsVQm
	 yz1EI/13NfB9c9FlQhAJo2KqHEUrmb7th+dggZyY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0CE621280B6C;
	Mon, 06 Jan 2025 21:37:47 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id s-Pr2xzWKXJg; Mon,  6 Jan 2025 21:37:46 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A6371128017F;
	Mon, 06 Jan 2025 21:37:46 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 4/6] efivarfs: move freeing of variable entry into evict_inode
Date: Mon,  6 Jan 2025 18:35:23 -0800
Message-Id: <20250107023525.11466-5-James.Bottomley@HansenPartnership.com>
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

Make the inodes the default management vehicle for struct
efivar_entry, so they are now all freed automatically if the file is
removed and on unmount in kill_litter_super().  Remove the now
superfluous iterator to free the entries after kill_litter_super().

Also fixes a bug where some entry freeing was missing causing efivarfs
to leak memory.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/internal.h |  1 -
 fs/efivarfs/super.c    | 15 +++++++--------
 fs/efivarfs/vars.c     | 39 +++------------------------------------
 3 files changed, 10 insertions(+), 45 deletions(-)

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 597ccaa60d37..8d82fc8bca31 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -37,7 +37,6 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
 
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
 void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
-void efivar_entry_remove(struct efivar_entry *entry);
 int efivar_entry_delete(struct efivar_entry *entry);
 
 int efivar_entry_size(struct efivar_entry *entry, unsigned long *size);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 9e90823f8009..d7facc99b745 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -41,6 +41,12 @@ static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
 
 static void efivarfs_evict_inode(struct inode *inode)
 {
+	struct efivar_entry *entry = inode->i_private;
+
+	if (entry)  {
+		list_del(&entry->list);
+		kfree(entry);
+	}
 	clear_inode(inode);
 }
 
@@ -278,13 +284,6 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	return err;
 }
 
-static int efivarfs_destroy(struct efivar_entry *entry, void *data)
-{
-	efivar_entry_remove(entry);
-	kfree(entry);
-	return 0;
-}
-
 enum {
 	Opt_uid, Opt_gid,
 };
@@ -407,7 +406,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
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


