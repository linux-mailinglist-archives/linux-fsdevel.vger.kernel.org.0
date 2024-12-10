Return-Path: <linux-fsdevel+bounces-36966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC19D9EB765
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0FB188171C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED72327A9;
	Tue, 10 Dec 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FL+7cC82"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ACE1BC09F;
	Tue, 10 Dec 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850250; cv=none; b=K+u90X6A/wzbQ+Vi07hD8lQLb5duQmeVgilZ1qdKvEu1tI5O1tA4e3CwDIyc83iizgfnG2K1iYKyOd1/vssFONDd9tOCLFk7SOptvBu6ASEQI1dRcKrn5CXOIGAEhpc1N19fMxGP2Wj0+MoB0gP0b4aX/mJ0kmrnhHFPaTt7t0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850250; c=relaxed/simple;
	bh=OPxYu+JRY+hSaT08tIK0Mu9O8A/1onhr3l9stHMosLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQBGmXxt8aIs8mWXiiVwM57Xx0U42PneS/cQXJsrBa/28/3QbbiqYKDVE5Wv7z/k0g0dwvDMLRW/v/FHYloVZw1nB3caOL9yZFATYvSXhgqQMfCcDTiTf+VUS94mw5w84e+U7lhwZfZG9RHt6Dy18NOtBUzzFqDxi2sqe4c7M0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=FL+7cC82; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733850248;
	bh=OPxYu+JRY+hSaT08tIK0Mu9O8A/1onhr3l9stHMosLk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=FL+7cC82YdywisEaU4wrHQe68rie6Dh4ZR/EFT9HlzqyrGupXj66LVahVbsKKJ/a7
	 WswozqsHgVrQiMtj6OrFSXyKnugxuHzqAd8iD081mx1TCpMKTojPXExS1zC0VZ5Ocx
	 IkWfBTGcST3HQYb0B+QI6WEAA7x4RyH/YS2pEzVI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 463481281701;
	Tue, 10 Dec 2024 12:04:08 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id fOoGqsTqAgSo; Tue, 10 Dec 2024 12:04:08 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 91E31128165E;
	Tue, 10 Dec 2024 12:04:07 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 6/6] efivarfs: fix error on write to new variable leaving remnants
Date: Tue, 10 Dec 2024 12:02:24 -0500
Message-Id: <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
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

Make variable cleanup go through the fops release mechanism and use
zero inode size as the indicator to delete the file.  Since all EFI
variables must have an initial u32 attribute, zero size occurs either
because the update deleted the variable or because an unsuccessful
write after create caused the size never to be set in the first place.

Even though this fixes the bug that a create either not followed by a
write or followed by a write that errored would leave a remnant file
for the variable, the file will appear momentarily globally visible
until the close of the fd deletes it.  This is safe because the normal
filesystem operations will mediate any races; however, it is still
possible for a directory listing at that instant between create and
close contain a variable that doesn't exist in the EFI table.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/file.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 23c51d62f902..edf363f395f5 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -38,22 +38,24 @@ static ssize_t efivarfs_file_write(struct file *file,
 
 	bytes = efivar_entry_set_get_size(var, attributes, &datasize,
 					  data, &set);
-	if (!set && bytes) {
+	if (!set) {
 		if (bytes == -ENOENT)
 			bytes = -EIO;
 		goto out;
 	}
 
+	inode_lock(inode);
 	if (bytes == -ENOENT) {
-		drop_nlink(inode);
-		d_delete(file->f_path.dentry);
-		dput(file->f_path.dentry);
+		/*
+		 * zero size signals to release that the write deleted
+		 * the variable
+		 */
+		i_size_write(inode, 0);
 	} else {
-		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
-		inode_unlock(inode);
 	}
+	inode_unlock(inode);
 
 	bytes = count;
 
@@ -106,8 +108,19 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	return size;
 }
 
+static int efivarfs_file_release(struct inode *inode, struct file *file)
+{
+	if (i_size_read(inode) == 0) {
+		drop_nlink(inode);
+		d_delete(file->f_path.dentry);
+		dput(file->f_path.dentry);
+	}
+	return 0;
+}
+
 const struct file_operations efivarfs_file_operations = {
-	.open	= simple_open,
-	.read	= efivarfs_file_read,
-	.write	= efivarfs_file_write,
+	.open		= simple_open,
+	.read		= efivarfs_file_read,
+	.write		= efivarfs_file_write,
+	.release	= efivarfs_file_release,
 };
-- 
2.35.3


