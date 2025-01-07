Return-Path: <linux-fsdevel+bounces-38513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C43A03537
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB963A2FCA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 02:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8739E1547E2;
	Tue,  7 Jan 2025 02:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="U+Qj2e+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (unknown [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F241C69D;
	Tue,  7 Jan 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217433; cv=none; b=AUNDSuyb5FX+g5FDJdYyjsasDm74RM/LuPuFyB0DbG5zlbWhQo9wX6FYoeI/adlIpsgoSwWO3ll1OkhoSDAqrPkUoIAPr3FehnrlKHqYc+yLH6hqvK1cDR5e04qGOdWkk8ZGSG4/O3utZhluEaV56kCxPnHb/XbmGC2/DNDD9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217433; c=relaxed/simple;
	bh=1zOgWcapBQJgcm45Fqy3RGNsrJnsNIwbYD2rxUWAOr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJbBM9z0QPSwqW6641N2Xgy5iHWydRsrdBfph+Iq3PfAyPqi5CnO2fZd+rwbAjFRUGvRPiAEKnWFybFEjSWemhGcrgHnRvJNQf4+O8dtZuCJeydH1+nxac935mAIQySezFdpxVaoopIo2VG7KL/QscdLq/wMnJ4JfEO53mIKVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=U+Qj2e+f; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736217430;
	bh=1zOgWcapBQJgcm45Fqy3RGNsrJnsNIwbYD2rxUWAOr0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=U+Qj2e+ftlrSIQ42rccYh73yz+a0vtzdvegL6yw/N1LvrR1HINKFG+z1Xo7N5dde3
	 dB+UofvoZmGt1g+fihR1y9nA1KlfvhR2KIyX0hxLASEePox35/7Bu60NeqS8yQB5gy
	 h7zzQcxyGt6TANNx9nGGUNi8IEBPaLSoUiFbcZ0c=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4FB1B1280E9E;
	Mon, 06 Jan 2025 21:37:10 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id grlkZWDYgCAK; Mon,  6 Jan 2025 21:37:10 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C3DBB128017F;
	Mon, 06 Jan 2025 21:37:09 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 2/6] efivarfs: add helper to convert from UC16 name and GUID to utf8 name
Date: Mon,  6 Jan 2025 18:35:21 -0800
Message-Id: <20250107023525.11466-3-James.Bottomley@HansenPartnership.com>
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

These will be used by a later patch to check for uniqueness on initial
EFI variable iteration.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/internal.h |  1 +
 fs/efivarfs/super.c    | 17 +++--------------
 fs/efivarfs/vars.c     | 25 +++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 64d15d1bb6bf..c10efc1ad0a7 100644
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
index f7d43c847ee9..13594087d9ee 100644
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


