Return-Path: <linux-fsdevel+bounces-38512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB8EA03534
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28FC3A5026
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 02:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1912137C37;
	Tue,  7 Jan 2025 02:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YVEsvNuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B9B6F30C;
	Tue,  7 Jan 2025 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217408; cv=none; b=ZxR/uQ7zoZ309LA7CRbA2GuUrbVhHq6c+OpSfZTNO4yqBZW3362UBhn2qNv0sxRXojA/LnYHwpRv7d7fE/XCFvotmNPCsptSwtX/6tKloQocA4/5vDcKapmehZGXmYG/WO8tgG2TxcEX2r12NZWw7sUOyjrEWr9hil5Hv98vXss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217408; c=relaxed/simple;
	bh=LXUMqhGpXyCk+mN3SeUyOyODLVWgqRr9V9axoWpO9Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7/N4kAe/a04l1WoE0F13MBFQ+B4c/MfDvB3GOYbb1B7mpuCt50k3V02WK0DXCVC3Z2v7K5PQ2ipO5gWkFgS9u0HFoAY4lWNd8mD8Osk71cNYIXRC4SiOHpc78kYLjTeu2KZ9ntYCzz4ssVIG0bnEoWHKJ38+3VyXnimdSeaBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=YVEsvNuX; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736217404;
	bh=LXUMqhGpXyCk+mN3SeUyOyODLVWgqRr9V9axoWpO9Oc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=YVEsvNuXwSA1aYM+jF8tW4csKmqzWNZHU82HavWJT4GA7fNfiFDkrqPm/IYUkrW4n
	 GerpU0s04e/+VvLQ3zX5XvruX7Uc1ka8jfYrsZ7+t2pcs/2g/bheOcpzd1XdhiecIv
	 8EwNGep1Z7n+GzkhB6CegkdbnuUfRA5f7YmKGIeg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 90D6012860B7;
	Mon, 06 Jan 2025 21:36:44 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id uXQFHwVykRdA; Mon,  6 Jan 2025 21:36:44 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 331F21281F72;
	Mon, 06 Jan 2025 21:36:44 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 1/6] efivarfs: remove unused efi_varaible.Attributes and .kobj
Date: Mon,  6 Jan 2025 18:35:20 -0800
Message-Id: <20250107023525.11466-2-James.Bottomley@HansenPartnership.com>
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


