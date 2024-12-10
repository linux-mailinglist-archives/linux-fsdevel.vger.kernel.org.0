Return-Path: <linux-fsdevel+bounces-36961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052AC9EB757
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36DBD1885EFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077CB23278B;
	Tue, 10 Dec 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OxmozZcT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD162063FB;
	Tue, 10 Dec 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850179; cv=none; b=fOtOudOoOLDfsnc/IqnbOzQHGemBGe7nAQuFW9m0mmNN6I9yrdoauwjciWpqDYP3gJaYaTVYWBd+QpARz+kXcNernzj99jHBTj4JtOol5h46VoLQ5ClXXCl/aLECLOKOZb6b421rh+WhF4FEtuGlNBLVLgl8uf9Q5Ry2137ebxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850179; c=relaxed/simple;
	bh=vgO2sbLgqWuxG0mPPsC+kAavuiDQGRuD9LU5zv4R5ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5EsIzvZ0ZWQTpaRiJuO6qpvqJ1ZCtAx4Icvdo6jRjjxZ/slScykplazWBwsqOS45ZPxoaK1mXSYWF3qxr1u6q0H8LvxI7Yi0gonmDOBsK/mCa+OfR9TI1Sa0iUkABz7wlEvH58vh43NGHEVr0wm841iJZAtHhuontMX8U4omo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=OxmozZcT; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733850177;
	bh=vgO2sbLgqWuxG0mPPsC+kAavuiDQGRuD9LU5zv4R5ec=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=OxmozZcTuKch6BglcBklhfcLUd3KH+yoLrzouyitmQdWGNozEfCrm6o0cf9c5TkCV
	 8zdG4hy9I/cdyVGymkMOQ9EAFaa8NiJqR5xOKv1oIz0T71b53Ak71beuDQhXaqgb/G
	 lHeTQP0vX8wUl8+gC8NWu2aYHPE7D+TxLvsJto6U=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3CD9612813BB;
	Tue, 10 Dec 2024 12:02:57 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id pWP26BmmNXYt; Tue, 10 Dec 2024 12:02:57 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id AC32E12813B6;
	Tue, 10 Dec 2024 12:02:56 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 1/6] efivarfs: remove unused efi_varaible.Attributes and .kobj
Date: Tue, 10 Dec 2024 12:02:19 -0500
Message-Id: <20241210170224.19159-2-James.Bottomley@HansenPartnership.com>
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

These fields look to be remnants of older code: Attributes was likely
meant to stash the variable attributes, but doesn't because we always
read them from the variable store and kobj was likely left over from
an older iteration of code where we manually created the objects
instead of using a filesystem.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/internal.h | 2 --
 fs/efivarfs/super.c    | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index d71d2e08422f..107aad8a3443 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -24,13 +24,11 @@ struct efivarfs_fs_info {
 struct efi_variable {
 	efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
 	efi_guid_t    VendorGuid;
-	__u32         Attributes;
 };
 
 struct efivar_entry {
 	struct efi_variable var;
 	struct list_head list;
-	struct kobject kobj;
 };
 
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index beba15673be8..d3c8528274aa 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -245,7 +245,7 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
 
 	inode_lock(inode);
 	inode->i_private = entry;
-	i_size_write(inode, size + sizeof(entry->var.Attributes));
+	i_size_write(inode, size + sizeof(__u32)); /* attributes + data */
 	inode_unlock(inode);
 	d_add(dentry, inode);
 
-- 
2.35.3


