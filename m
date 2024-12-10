Return-Path: <linux-fsdevel+bounces-36964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D7B9EB761
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7916B168E00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C9F231C8E;
	Tue, 10 Dec 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Lopd55rM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72792327A9;
	Tue, 10 Dec 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850227; cv=none; b=R9JWgqEP5k2nH6n5rZuOPGXq1wA9P1nG3OxTgfZFLVeAMsdzlireACPoFLvi82L/IJp+sTDxZQd345gEP1fvh+gZLST1/VfB03FO6ZuE32Vw1EgGOcWxHmJF6RSrdd8T9NfD8yqnOxv5ke6YZ+CNVe2echUpB4o+lczsCqtLZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850227; c=relaxed/simple;
	bh=XMUxmN/lKFGxcD+y+4IND8ySLKRc9nUNBYc6o60jlqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7b3MSShwOwiHyWMmvB6UWvQ61/PVuLeOkvZUQ/v7fNcbfPZBmrqxF6+X7FAi4M9yXa4qI+Dv+K7P6+U38EyvGpD0TAS58BoVnFDXwKBqZ8M43RXdjEcn/RGsS3ET4254jZiJ5zAoTzcH2HZLO74f3CjZmzSthKd3f0G///KJek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Lopd55rM; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733850225;
	bh=XMUxmN/lKFGxcD+y+4IND8ySLKRc9nUNBYc6o60jlqQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=Lopd55rMq1j+t2kma0FPBDFYUN9fMUuU7RCvj5nIMadPrhQLk2I8kE8pOV1FrZf//
	 poIfCE1Bd84VcJpPTadTgmxFjdmCw/YEvfXmYv/sqCqmfdXzZpFnjITtOSGmpdH69r
	 wWOsSxmTjDKctiqKVhXbyl7SVjGLXLlKz4LAy+Uk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1177912813BB;
	Tue, 10 Dec 2024 12:03:45 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id kjHLy__HkyvD; Tue, 10 Dec 2024 12:03:44 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7039412813B6;
	Tue, 10 Dec 2024 12:03:44 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 4/6] efivarfs: move freeing of variable entry into evict_inode
Date: Tue, 10 Dec 2024 12:02:22 -0500
Message-Id: <20241210170224.19159-5-James.Bottomley@HansenPartnership.com>
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
index 84a36e6fb653..d768bfa7f12b 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -37,7 +37,6 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
 
 int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
 void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
-void efivar_entry_remove(struct efivar_entry *entry);
 int efivar_entry_delete(struct efivar_entry *entry);
 
 int efivar_entry_size(struct efivar_entry *entry, unsigned long *size);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index dc3870ae784b..70b99f58c906 100644
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
 
@@ -269,13 +275,6 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
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
@@ -398,7 +397,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
 	kill_litter_super(sb);
 
 	/* Remove all entries and destroy */
-	efivar_entry_iter(efivarfs_destroy, &sfi->efivarfs_list, NULL);
+	WARN_ON(!list_empty(&sfi->efivarfs_list));
 	kfree(sfi);
 }
 
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index f6380fdbe173..bda8e8b869e8 100644
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


