Return-Path: <linux-fsdevel+bounces-39619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916C2A16289
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 645057A238E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECB91DF72C;
	Sun, 19 Jan 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FPCzq4sn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938D4315F;
	Sun, 19 Jan 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737299694; cv=none; b=maU8lNPmp3S79P5PRfswmulwfnpjMoUMqhBujClQ1+/gRKLSRUFFzR637hSCYFd+nau0Cvar5ZMBy6IUC2vRInFGniurcAVv2N+QWUY9FQuvHFlbIspBGg5H1okAFWJ6tYs5DELaBR4uUiDGdvffxfiik7sBSrdvqqFzxhPo6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737299694; c=relaxed/simple;
	bh=k3ugGnUYfk97WZDv7aczKcguvs55qIarCGeHFhZ1knc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmaxF69ba+olxAUxZ1axqpT9GTkhVmJGUHyjiUMqHvzLC2bUfikHyDzKGhtFMFS9yEGGT44+PsVbOlMLx+zMf/VMtPQ906djVvNtkbzmckEs9DWFoLl2GCTetLwfHmahzOpbvJZMQGZct0J/93lNru7z6RSJtWHypUttp920pTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=FPCzq4sn; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737299690;
	bh=k3ugGnUYfk97WZDv7aczKcguvs55qIarCGeHFhZ1knc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=FPCzq4sneM/NjnS3O93DQ+Dv9JYmDWizVMtfJqyDuK1bmwSEpEoz1OQOeSvfA09Eg
	 YbjWQsh2hKtM9jSo+RXJqevkX2i0H0Tuj6dVd02f5ero5WWY4jW3FooCc3l7e2z01Q
	 zMSajTRAYhBxSLkqKAYiPY8HWB3ZyBZb6oQm/RT0=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B88A2128635D;
	Sun, 19 Jan 2025 10:14:50 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id x8XYHRDrrPDP; Sun, 19 Jan 2025 10:14:49 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CD0691286343;
	Sun, 19 Jan 2025 10:14:48 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 6/8] efivarfs: fix error on write to new variable leaving remnants
Date: Sun, 19 Jan 2025 10:12:12 -0500
Message-Id: <20250119151214.23562-7-James.Bottomley@HansenPartnership.com>
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

Make variable cleanup go through the fops release mechanism and use
zero inode size as the indicator to delete the file.  Since all EFI
variables must have an initial u32 attribute, zero size occurs either
because the update deleted the variable or because an unsuccessful
write after create caused the size never to be set in the first place.
In the case of multiple racing opens and closes, the open is counted
to ensure that the zero size check is done on the last close.

Even though this fixes the bug that a create either not followed by a
write or followed by a write that errored would leave a remnant file
for the variable, the file will appear momentarily globally visible
until the last close of the fd deletes it.  This is safe because the
normal filesystem operations will mediate any races; however, it is
still possible for a directory listing at that instant between create
and close contain a zero size variable that doesn't exist in the EFI
table.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v2: implement counter for last close
v3: add removed state to struct efivar_entry and use in place of d_unhashed()
---
 fs/efivarfs/file.c     | 59 +++++++++++++++++++++++++++++++++++-------
 fs/efivarfs/internal.h |  2 ++
 fs/efivarfs/super.c    |  1 +
 3 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 23c51d62f902..cb1b6d0c3454 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -36,28 +36,41 @@ static ssize_t efivarfs_file_write(struct file *file,
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	inode_lock(inode);
+	if (var->removed) {
+		/*
+		 * file got removed; don't allow a set.  Caused by an
+		 * unsuccessful create or successful delete write
+		 * racing with us.
+		 */
+		bytes = -EIO;
+		goto out;
+	}
+
 	bytes = efivar_entry_set_get_size(var, attributes, &datasize,
 					  data, &set);
-	if (!set && bytes) {
+	if (!set) {
 		if (bytes == -ENOENT)
 			bytes = -EIO;
 		goto out;
 	}
 
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
 
 	bytes = count;
 
 out:
+	inode_unlock(inode);
+
 	kfree(data);
 
 	return bytes;
@@ -106,8 +119,36 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	return size;
 }
 
+static int efivarfs_file_release(struct inode *inode, struct file *file)
+{
+	struct efivar_entry *var = inode->i_private;
+
+	inode_lock(inode);
+	var->removed = (--var->open_count == 0 && i_size_read(inode) == 0);
+	inode_unlock(inode);
+
+	if (var->removed)
+		simple_recursive_removal(file->f_path.dentry, NULL);
+
+	return 0;
+}
+
+static int efivarfs_file_open(struct inode *inode, struct file *file)
+{
+	struct efivar_entry *entry = inode->i_private;
+
+	file->private_data = entry;
+
+	inode_lock(inode);
+	entry->open_count++;
+	inode_unlock(inode);
+
+	return 0;
+}
+
 const struct file_operations efivarfs_file_operations = {
-	.open	= simple_open,
-	.read	= efivarfs_file_read,
-	.write	= efivarfs_file_write,
+	.open		= efivarfs_file_open,
+	.read		= efivarfs_file_read,
+	.write		= efivarfs_file_write,
+	.release	= efivarfs_file_release,
 };
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 4366f7949614..1f84844fe032 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -27,6 +27,8 @@ struct efi_variable {
 struct efivar_entry {
 	struct efi_variable var;
 	struct inode vfs_inode;
+	unsigned long open_count;
+	bool removed;
 };
 
 static inline struct efivar_entry *efivar_entry(struct inode *inode)
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 7b3650c97e60..89010c5878ce 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -47,6 +47,7 @@ static struct inode *efivarfs_alloc_inode(struct super_block *sb)
 		return NULL;
 
 	inode_init_once(&entry->vfs_inode);
+	entry->removed = false;
 
 	return &entry->vfs_inode;
 }
-- 
2.35.3


