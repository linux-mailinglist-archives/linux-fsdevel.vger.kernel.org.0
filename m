Return-Path: <linux-fsdevel+bounces-36963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913809EB75D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2202B1689AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB623278D;
	Tue, 10 Dec 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="D58/tVJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDAD231C8E;
	Tue, 10 Dec 2024 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850209; cv=none; b=L9V0K/VZUxhr25ztviHcBfe5MynujE+DcdJi9lFgPrBqdWnW9Uttob4X1qTR2v7GS8J9Pau5lwbZdQ+G7BQpdkhxFIsTpcRBQ+8mzyNKcWggqGeQwqd3i2zSx7bEXq5L7eKNwOLuuqVS+2QOFf0e+VoZ4CVNhaX68NCWoLQjn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850209; c=relaxed/simple;
	bh=6Mp50iC3bNfaQ0SjKfrVdZcmz5QNH6PyRbjXsJphRwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjO++rC/6BnDUK1KGZfzNTUfjO3iuVFRvIWgUjQYCDG9XTJw+hqY2yGns4ACxM2RCtjSznoQkRB1FQeHfm/AtE6Exn4KgoGOElEvZrMi1A1DG3VEiXzUbg0j/q1psb6zWwegzGQ6X2Tz3DLKhmbHFbZ10zGzQHuDg0SOToMllPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=D58/tVJO; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733850207;
	bh=6Mp50iC3bNfaQ0SjKfrVdZcmz5QNH6PyRbjXsJphRwU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=D58/tVJOGAOkKCfrcyFr6oSxJvsVgGeC7KAemy5+Gkrk989/1EFhtLcNeIP9KLibu
	 O8mWxZeDj72zcfHeniwDY/oZdzyBHAr3FqdMMos/GHjcH2UZb5q9mUHIxUAgtt04fQ
	 3T2i5As0s8+AfAkzLZx3kYiAMUcsQY2cfUEyBiH4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 92AE812813BB;
	Tue, 10 Dec 2024 12:03:27 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id gKanO3gje6ad; Tue, 10 Dec 2024 12:03:27 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C96C312813B6;
	Tue, 10 Dec 2024 12:03:26 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 3/6] efivarfs: make variable_is_present use dcache lookup
Date: Tue, 10 Dec 2024 12:02:21 -0500
Message-Id: <20241210170224.19159-4-James.Bottomley@HansenPartnership.com>
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

Instead of searching the variable entry list for a variable, use the
dcache lookup functions to find it instead.  Also add an efivarfs_
prefix to the function now it is no longer static.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/internal.h |  4 ++++
 fs/efivarfs/super.c    | 20 ++++++++++++++++++++
 fs/efivarfs/vars.c     | 26 ++------------------------
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 4b7330b90958..84a36e6fb653 100644
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
@@ -64,4 +66,6 @@ extern struct inode *efivarfs_get_inode(struct super_block *sb,
 			const struct inode *dir, int mode, dev_t dev,
 			bool is_removable);
 
+
+
 #endif /* EFIVAR_FS_INTERNAL_H */
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index b22441f7f7c6..dc3870ae784b 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -181,6 +181,26 @@ static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
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
+		return true;
+
+	qstr.name = name;
+	qstr.len = strlen(name);
+	dentry = d_hash_and_lookup(sb->s_root, &qstr);
+	kfree(name);
+	if (dentry)
+		dput(dentry);
+	return dentry != NULL;
+}
+
 static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 			     unsigned long name_size, void *data,
 			     struct list_head *list)
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 7a07b767e2cc..f6380fdbe173 100644
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


