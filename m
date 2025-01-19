Return-Path: <linux-fsdevel+bounces-39616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC4A16280
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401223A5BBD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823E31DF727;
	Sun, 19 Jan 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="fUGoYrND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C44315F;
	Sun, 19 Jan 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737299596; cv=none; b=PPy0ly7+hibr5qJqVDp8MWa577SDhtcps3WQYzkibg2yGr9NM+xfJdOiGeYMGEjXWtV/5a5g8+KeoT6/5wbbnSWlt1wco8bXDZe2ar8jhkxATyBp/4aQECZUzlcX/IDYaUKJ0sqwyngxoLS17CPDR7eWHIAd0ZlCDeQgqOuMC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737299596; c=relaxed/simple;
	bh=OJkRkHwCEqTFagotBRzVUHjnmsnMz0CSgaXEDuj3qV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sk/jWhSFetP13rCWgoopboHmbrMttTrxIiWtdSNY81iWhFjdHEwrbJ8bl3z0A1wYrbV0w4NSf8c4gPbNCxzKlU6tEkJKxrrgeqSh2ErZuB+qNjjoIaOEPcnYygqfugqzWL9hRhUXbt6/d2oxcyZobQTRwpntosd23nQcCIKLwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=fUGoYrND; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737299594;
	bh=OJkRkHwCEqTFagotBRzVUHjnmsnMz0CSgaXEDuj3qV0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=fUGoYrNDhpLU6KGhkccAJ1/shWttbuH3jIF3XAvmZBFz2jXtESOsY79SOJ76RwCU+
	 3aDv+cifi9L5RWozSd8mAkPb43GqdJVSKwu7+NX6UEtztKlV4KReF2tEv0sQ/bOlCF
	 lkB9FK/t4aMGuCrUjk/PyprA188agkmjvFAedUU4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 030FF128056F;
	Sun, 19 Jan 2025 10:13:14 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id bdrxtmdbanGn; Sun, 19 Jan 2025 10:13:13 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9392412804E8;
	Sun, 19 Jan 2025 10:13:12 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 3/8] efivarfs: make variable_is_present use dcache lookup
Date: Sun, 19 Jan 2025 10:12:09 -0500
Message-Id: <20250119151214.23562-4-James.Bottomley@HansenPartnership.com>
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

Instead of searching the variable entry list for a variable, use the
dcache lookup functions to find it instead.  Also add an efivarfs_
prefix to the function now it is no longer static.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v2: add IS_ERR_OR_NULL check before doing dput
---
 fs/efivarfs/internal.h |  2 ++
 fs/efivarfs/super.c    | 29 +++++++++++++++++++++++++++++
 fs/efivarfs/vars.c     | 26 ++------------------------
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index c10efc1ad0a7..597ccaa60d37 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -56,6 +56,8 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 				  size_t len);
 char *efivar_get_utf8name(const efi_char16_t *name16, efi_guid_t *vendor);
+bool efivarfs_variable_is_present(efi_char16_t *variable_name,
+				  efi_guid_t *vendor, void *data);
 
 extern const struct file_operations efivarfs_file_operations;
 extern const struct inode_operations efivarfs_dir_inode_operations;
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index b22441f7f7c6..9e90823f8009 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -181,6 +181,35 @@ static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
 	return ERR_PTR(-ENOMEM);
 }
 
+bool efivarfs_variable_is_present(efi_char16_t *variable_name,
+				  efi_guid_t *vendor, void *data)
+{
+	char *name = efivar_get_utf8name(variable_name, vendor);
+	struct super_block *sb = data;
+	struct dentry *dentry;
+	struct qstr qstr;
+
+	if (!name)
+		/*
+		 * If the allocation failed there'll already be an
+		 * error in the log (and likely a huge and growing
+		 * number of them since they system will be under
+		 * extreme memory pressure), so simply assume
+		 * collision for safety but don't add to the log
+		 * flood.
+		 */
+		return true;
+
+	qstr.name = name;
+	qstr.len = strlen(name);
+	dentry = d_hash_and_lookup(sb->s_root, &qstr);
+	kfree(name);
+	if (!IS_ERR_OR_NULL(dentry))
+		dput(dentry);
+
+	return dentry != NULL;
+}
+
 static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 			     unsigned long name_size, void *data,
 			     struct list_head *list)
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 13594087d9ee..b2fc5bdc759a 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -313,28 +313,6 @@ efivar_variable_is_removable(efi_guid_t vendor, const char *var_name,
 	return found;
 }
 
-static bool variable_is_present(efi_char16_t *variable_name, efi_guid_t *vendor,
-				struct list_head *head)
-{
-	struct efivar_entry *entry, *n;
-	unsigned long strsize1, strsize2;
-	bool found = false;
-
-	strsize1 = ucs2_strsize(variable_name, EFI_VAR_NAME_LEN);
-	list_for_each_entry_safe(entry, n, head, list) {
-		strsize2 = ucs2_strsize(entry->var.VariableName, EFI_VAR_NAME_LEN);
-		if (strsize1 == strsize2 &&
-			!memcmp(variable_name, &(entry->var.VariableName),
-				strsize2) &&
-			!efi_guidcmp(entry->var.VendorGuid,
-				*vendor)) {
-			found = true;
-			break;
-		}
-	}
-	return found;
-}
-
 /*
  * Returns the size of variable_name, in bytes, including the
  * terminating NULL character, or variable_name_size if no NULL
@@ -439,8 +417,8 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
 			 * we'll ever see a different variable name,
 			 * and may end up looping here forever.
 			 */
-			if (variable_is_present(variable_name, &vendor_guid,
-						head)) {
+			if (efivarfs_variable_is_present(variable_name,
+							 &vendor_guid, data)) {
 				dup_variable_bug(variable_name, &vendor_guid,
 						 variable_name_size);
 				status = EFI_NOT_FOUND;
-- 
2.35.3


