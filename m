Return-Path: <linux-fsdevel+bounces-39614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA4A1627C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B8D1885858
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16571DF727;
	Sun, 19 Jan 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="AiRajHNk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053384315F;
	Sun, 19 Jan 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737299558; cv=none; b=FttHGv7Xl5mmB5is+VvlxMKpUiptE0EZiaos23TmsaTT/d5e8c06/k9L6PFsLwemgS/MPpRSg2bSPgmjBffZVcJvzIQ2R3nlMTvKOeE3bm0/CJDsrCTeSzs2LVHSuRB7rePw/aWH9FFYPFpup+1HOt5afv4PEuWzR834a5jxC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737299558; c=relaxed/simple;
	bh=LXUMqhGpXyCk+mN3SeUyOyODLVWgqRr9V9axoWpO9Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ru2T9gSSD9BJujiH0J1ar7HQ8zNksvT995GCq3hDbKOiyCL/UXyVdzr43DEJj+2KFsf3j+vUD08qbqBiHkTL3401Yhzil4wgyrDkGnf/bOwyhJ5W2PEWcdELNSrF5O9p+yM7ue3VIMogpjnZ6+bvS7ygtXma34GB0roler/vFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=AiRajHNk; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737299556;
	bh=LXUMqhGpXyCk+mN3SeUyOyODLVWgqRr9V9axoWpO9Oc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=AiRajHNkbMqVl0ILKSACb0lj+X7khTaGL3t1KlMV6GZd4sV3N+h15rcRUih4h/6e8
	 6HE39ehG4A3q96yxLYgEQv1mYEYvC5mfsuvEIE1Qsxgdx7vYbViGOExMcZcsYFx5xj
	 8x1L4lEULH/vQj9CRW05cuLq83PYohfq92hWOVT0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1541E128056F;
	Sun, 19 Jan 2025 10:12:36 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id sakN7IG3IB1P; Sun, 19 Jan 2025 10:12:36 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 42E3812804E8;
	Sun, 19 Jan 2025 10:12:35 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 1/8] efivarfs: remove unused efi_varaible.Attributes and .kobj
Date: Sun, 19 Jan 2025 10:12:07 -0500
Message-Id: <20250119151214.23562-2-James.Bottomley@HansenPartnership.com>
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
index 74f0602a9e01..64d15d1bb6bf 100644
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


