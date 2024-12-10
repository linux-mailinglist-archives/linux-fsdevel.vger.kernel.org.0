Return-Path: <linux-fsdevel+bounces-36962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230E59EB75B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE9E28284F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83F1232799;
	Tue, 10 Dec 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ablJwlJU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993D2063FB;
	Tue, 10 Dec 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850192; cv=none; b=puawpO8Ei7SBqfbB67oIVehqaExU0R/+DF5znhsMsuLNf7u/9qtDxRtUN0X2peocHxeHcMtmG+RKanFTP8JrBN6UN/nqpSN7OtMQJ27UWe5LNqB7Uc+f1fN2JvBkVdX/fWwuqQIdj8KFd4qpNNg+P/JhpHUoQuHW+uyJWr1Sqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850192; c=relaxed/simple;
	bh=HENCyC5/taTHHYRATRKhoQp0ZDr7E3TIdvECCrUe3gA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E4+iI02f2+K62ErKkkofTSAiiuiCdACbguIYfroRtefH7fvKne7KENS26XrWFrH2sfKFvu8pOOHYISpGQ9reSEopNRrWA5BGF4YxD6arG4f7iZC5AjFfQCRPmIN8HQn6zljMbLTKsaycukQXdmgYugJN1DqfuWKZ/cU68LTDxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ablJwlJU; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733850190;
	bh=HENCyC5/taTHHYRATRKhoQp0ZDr7E3TIdvECCrUe3gA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=ablJwlJUYIYQ7yh8GBEKzPKRpmaxDHwNwrWaxswKYvaqCyDJpeBLkmdSS80j5pkGH
	 ye0boXin/VebjYFJMMFxa4qR9WRG/jbaAWrc1KUNvjdYkT6tmwZ75GyKzkMpbdWtN6
	 GIm8eKB8lGICR7RjDOkxYHPLK0Yw8lTIgko/bhyE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4FE6A12813BB;
	Tue, 10 Dec 2024 12:03:10 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id C5H9FtMGbGvR; Tue, 10 Dec 2024 12:03:10 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A3B5212813B6;
	Tue, 10 Dec 2024 12:03:09 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 2/6] efivarfs: add helper to convert from UC16 name and GUID to utf8 name
Date: Tue, 10 Dec 2024 12:02:20 -0500
Message-Id: <20241210170224.19159-3-James.Bottomley@HansenPartnership.com>
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

These will be used by a later patch to check for uniqueness on initial
EFI variable iteration.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/internal.h |  1 +
 fs/efivarfs/super.c    | 17 +++--------------
 fs/efivarfs/vars.c     | 25 +++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 107aad8a3443..4b7330b90958 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -55,6 +55,7 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 		     unsigned long data_size);
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 				  size_t len);
+char *efivar_get_utf8name(const efi_char16_t *name16, efi_guid_t *vendor);
 
 extern const struct file_operations efivarfs_file_operations;
 extern const struct inode_operations efivarfs_dir_inode_operations;
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index d3c8528274aa..b22441f7f7c6 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -205,27 +205,16 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 	memcpy(entry->var.VariableName, name16, name_size);
 	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
 
-	len = ucs2_utf8size(entry->var.VariableName);
-
-	/* name, plus '-', plus GUID, plus NUL*/
-	name = kmalloc(len + 1 + EFI_VARIABLE_GUID_LEN + 1, GFP_KERNEL);
+	name = efivar_get_utf8name(name16, &vendor);
 	if (!name)
 		goto fail;
 
-	ucs2_as_utf8(name, entry->var.VariableName, len);
+	/* length of the variable name itself: remove GUID and separator */
+	len = strlen(name) - EFI_VARIABLE_GUID_LEN - 1;
 
 	if (efivar_variable_is_removable(entry->var.VendorGuid, name, len))
 		is_removable = true;
 
-	name[len] = '-';
-
-	efi_guid_to_str(&entry->var.VendorGuid, name + len + 1);
-
-	name[len + EFI_VARIABLE_GUID_LEN+1] = '\0';
-
-	/* replace invalid slashes like kobject_set_name_vargs does for /sys/firmware/efi/vars. */
-	strreplace(name, '/', '!');
-
 	inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
 				   is_removable);
 	if (!inode)
diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
index 3cc89bb624f0..7a07b767e2cc 100644
--- a/fs/efivarfs/vars.c
+++ b/fs/efivarfs/vars.c
@@ -225,6 +225,31 @@ variable_matches(const char *var_name, size_t len, const char *match_name,
 	}
 }
 
+char *
+efivar_get_utf8name(const efi_char16_t *name16, efi_guid_t *vendor)
+{
+	int len = ucs2_utf8size(name16);
+	char *name;
+
+	/* name, plus '-', plus GUID, plus NUL*/
+	name = kmalloc(len + 1 + EFI_VARIABLE_GUID_LEN + 1, GFP_KERNEL);
+	if (!name)
+		return NULL;
+
+	ucs2_as_utf8(name, name16, len);
+
+	name[len] = '-';
+
+	efi_guid_to_str(vendor, name + len + 1);
+
+	name[len + EFI_VARIABLE_GUID_LEN+1] = '\0';
+
+	/* replace invalid slashes like kobject_set_name_vargs does for /sys/firmware/efi/vars. */
+	strreplace(name, '/', '!');
+
+	return name;
+}
+
 bool
 efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 		unsigned long data_size)
-- 
2.35.3


