Return-Path: <linux-fsdevel+bounces-38608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D4BA04BCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 22:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E35188338A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 21:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C994A1F7547;
	Tue,  7 Jan 2025 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aYKGZeIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4E19F41B;
	Tue,  7 Jan 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285567; cv=none; b=IuVHR9VWe0ALJkUM/oCW+oxkr5E5VG+ghPBX3nrHGLBT8gwSSCFxEULg1+DICSPBnLs1t1YqEQGuDP+QE4o7bcRsBl+h3HitJdsrbs/ZILnc8Byg42m8TyxYXvqbNKpPA1Xv/GIuOtfnKOpAYjLzAiFvfS/0zFJ+iW0uW6GUuuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285567; c=relaxed/simple;
	bh=xCeQebNb2nI5pCqF7qE0koNBErGmcPysgDl6CxVWb+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EegEsF3le82g2SQmTcHQYO1uYuENehEM2KAT0/wVX291R5b8zs2/65KQNudU3QPq5XW7Md7ztxSp33qSx/myi8sTNZQCU8kzaV3X9+QsVmjcngR7HUZjFO1C8K1CfQee++IX4Lr/7cBBYU2V952RfJvO7KQDY+ze/VEATIFZsDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=aYKGZeIV; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736285564;
	bh=xCeQebNb2nI5pCqF7qE0koNBErGmcPysgDl6CxVWb+U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=aYKGZeIVzn+WNqxzfTSCO/9ojoGxYXtgS48l/eWMYfA98FRBhsC8oBtNVC5+P1hIe
	 nPvEBIwYaGcgzZm6FYte4axcYpw8zBPTHlNHnsLvJElBVViXjKEm5jk013qunCh9cs
	 L1ozaV1bMq+uUArvBEwrkOC2yCpsQfpAxIIAJopU=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id DA0771286BD6;
	Tue, 07 Jan 2025 16:32:44 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id XCgD4p6EVrma; Tue,  7 Jan 2025 16:32:44 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1AECD1286B13;
	Tue, 07 Jan 2025 16:32:44 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Lennart Poettering <mzxreary@0pointer.de>
Subject: [PATCH 1/2] efivarfs: abstract initial variable creation routine
Date: Tue,  7 Jan 2025 13:31:28 -0800
Message-Id: <20250107213129.28454-2-James.Bottomley@HansenPartnership.com>
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

Reuse later for variable creation after hibernation

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/super.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 2523e74dbcfd..2523030caeda 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -213,32 +213,24 @@ bool efivarfs_variable_is_present(efi_char16_t *variable_name,
 	return dentry != NULL;
 }
 
-static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
-			     unsigned long name_size, void *data)
+static int efivarfs_create_dentry(struct super_block *sb, efi_char16_t *name16,
+				  unsigned long name_size, efi_guid_t *vendor,
+				  char *name)
 {
-	struct super_block *sb = (struct super_block *)data;
 	struct efivar_entry *entry;
-	struct inode *inode = NULL;
+	struct inode *inode;
 	struct dentry *dentry, *root = sb->s_root;
 	unsigned long size = 0;
-	char *name;
 	int len;
 	int err = -ENOMEM;
 	bool is_removable = false;
 
-	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
-		return 0;
-
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return err;
 
 	memcpy(entry->var.VariableName, name16, name_size);
-	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
-
-	name = efivar_get_utf8name(name16, &vendor);
-	if (!name)
-		goto fail;
+	memcpy(&(entry->var.VendorGuid), vendor, sizeof(efi_guid_t));
 
 	/* length of the variable name itself: remove GUID and separator */
 	len = strlen(name) - EFI_VARIABLE_GUID_LEN - 1;
@@ -274,11 +266,27 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	iput(inode);
 fail_name:
 	kfree(name);
-fail:
 	kfree(entry);
+
 	return err;
 }
 
+static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
+			     unsigned long name_size, void *data)
+{
+	struct super_block *sb = (struct super_block *)data;
+	char *name;
+
+	if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
+		return 0;
+
+	name = efivar_get_utf8name(name16, &vendor);
+	if (!name)
+		return -ENOMEM;
+
+	return efivarfs_create_dentry(sb, name16, name_size, &vendor, name);
+}
+
 enum {
 	Opt_uid, Opt_gid,
 };
-- 
2.35.3


