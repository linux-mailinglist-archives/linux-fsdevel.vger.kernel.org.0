Return-Path: <linux-fsdevel+bounces-39615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59339A1627E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E866818854F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD981DF727;
	Sun, 19 Jan 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="K4WPms49"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C61DF267;
	Sun, 19 Jan 2025 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737299572; cv=none; b=L8PahL8c2ceU7AannlmR3s9BIiXd4oUY1YtyU1w5zmxtVhfANhEtXH2x4hsCe2OAE8Waw2z/vmkEfXYibxeVKCzJ2N3UiyEnFY1mkdaVGHcbe5gLyAZnfmfvGsfoh8pcdjidEH5Hi06J7h0BEB9U68oXoUi+YSPU0z1htIw0ikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737299572; c=relaxed/simple;
	bh=1zOgWcapBQJgcm45Fqy3RGNsrJnsNIwbYD2rxUWAOr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPBQPgS6yoen+3nPmnk+aloE+bojA65IK8xcHnQm1l202tm4747BPypCjS0XsmzSEoAbexPjmw8IXZFuXQs8J3U8ZZLjFyANWwmOzU8YIevNfa6opRJ2tsqV9sY85jyzSLMJfiHSUAs9HCAtZ7bzYiokDHQhHrCqfMBfgXeoon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=K4WPms49; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737299570;
	bh=1zOgWcapBQJgcm45Fqy3RGNsrJnsNIwbYD2rxUWAOr0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=K4WPms49LUc5fkzLjkRLtOEzfEN3+bQZUJcvznxYYNkvofzm36jKVSPN/WYSoM4m2
	 YIOrRLj97GwQUEkEuWhWwsmfY0QRgjAG+91MwXYIelSNkt85+cA3+eobxRkCTXPe4L
	 3tOPa7iDYMZjif8ajAaVJtVH6eON5VITLTbeNakQ=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4A551128056F;
	Sun, 19 Jan 2025 10:12:50 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id sClYeGBA7Ilh; Sun, 19 Jan 2025 10:12:50 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8486312804E8;
	Sun, 19 Jan 2025 10:12:49 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 2/8] efivarfs: add helper to convert from UC16 name and GUID to utf8 name
Date: Sun, 19 Jan 2025 10:12:08 -0500
Message-Id: <20250119151214.23562-3-James.Bottomley@HansenPartnership.com>
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


