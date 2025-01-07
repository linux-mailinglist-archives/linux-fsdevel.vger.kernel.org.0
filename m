Return-Path: <linux-fsdevel+bounces-38517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29287A0353F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F1517A22C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 02:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD5A13B792;
	Tue,  7 Jan 2025 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FSA601H3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D628691;
	Tue,  7 Jan 2025 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217531; cv=none; b=CB2Egqwh9gSI/webdKyN7JFCUX1NRBCA8Ku9+ILRjV4DjnsuPBg0T534KNMi4losDF/E0To8Ex8k/rirhVHea5ta49ilaF0W63wkjZl9Q6CevKFZnpflmv6SqbhExNHWQ7KDPMkkvLUhQmrGi1HGR4KW9BjTV5LM4DfGlMT7Cd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217531; c=relaxed/simple;
	bh=l2trXjx4HpiseBIIESlN2FkB35bZXyr+ptQmuXg+Ukg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=helk1yNS8oYxLWnSY+PM6A242NURItojiTfzQFu022mDtEYKc4xs0OPYLHhNZ+DwFk/qDqm3Ys8p+kOUzb+geETKcc4gm4azpSMiae/MIWGo81rNi93/69+2Kt3dJD+EEr7USQj6TjgNCDX4ySJQMycBq++ri5zZaxMZ2XiweeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=FSA601H3; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736217528;
	bh=l2trXjx4HpiseBIIESlN2FkB35bZXyr+ptQmuXg+Ukg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=FSA601H3HjC/yluXyzMRLIr7Z+zJww4wa1ZpPA2MjpAWytHrK6i9K4sNWZvNSR17V
	 gm6PvG7HzAPczEnXxd9/DF4vQaBTDkzDg3AiNiwBvbuac94XBKQthCSWZ9UuSrFNJl
	 AJwj9bL1fMx6qhEbEKtGExy4F0U0/S2B3mWtnkRs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5A39F1280B6C;
	Mon, 06 Jan 2025 21:38:48 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id uh0ioeHGCvMd; Mon,  6 Jan 2025 21:38:48 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E5CDA128017F;
	Mon, 06 Jan 2025 21:38:47 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 6/6] efivarfs: fix error on write to new variable leaving remnants
Date: Mon,  6 Jan 2025 18:35:25 -0800
Message-Id: <20250107023525.11466-7-James.Bottomley@HansenPartnership.com>
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
---
 fs/efivarfs/file.c     | 60 +++++++++++++++++++++++++++++++++++-------
 fs/efivarfs/internal.h |  1 +
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 23c51d62f902..cf0179d84bc5 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -36,28 +36,41 @@ static ssize_t efivarfs_file_write(struct file *file,
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	inode_lock(inode);
+	if (d_unhashed(file->f_path.dentry)) {
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
@@ -106,8 +119,37 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	return size;
 }
 
+static int efivarfs_file_release(struct inode *inode, struct file *file)
+{
+	bool release;
+	struct efivar_entry *var = inode->i_private;
+
+	inode_lock(inode);
+	release = (--var->open_count == 0 && i_size_read(inode) == 0);
+	inode_unlock(inode);
+
+	if (release)
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
index 18a600f80992..32b83f644798 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -26,6 +26,7 @@ struct efi_variable {
 
 struct efivar_entry {
 	struct efi_variable var;
+	unsigned long open_count;
 };
 
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
-- 
2.35.3


