Return-Path: <linux-fsdevel+bounces-72199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FFECE75B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 17:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5C4D3012762
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9CB33033B;
	Mon, 29 Dec 2025 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mRDVjrut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A199330332;
	Mon, 29 Dec 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024945; cv=none; b=FktsssmlDsDnmoHIVy94ucuMaBUZRRDp211HU6u1d+5AR8meymYJqS/ROnF68rRdENXDVARlYxDZ0F+OHOTn04kRvpD7YRcc6H5AC0cZg1fXdznABhOkBbDP1RIekzqOxnR0Mb4ORGpu8pO7gnkOXMXbiQGmHmtpmz5v6rm8cQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024945; c=relaxed/simple;
	bh=tCV8j4qeNCzprriKScwSiX3Nh5cgihVF46Fnuh6J7rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=su0usTm/JtcXU7MdSqebSm4vLG4PgsO86tvUqIlAyfyDgsJzSF3MAUmFxFJ+KfjJhgD5KDu1a4WCEDGPWWycaxEoJgCVe3ikoF1oiq6JZOwTz/f5tiThiG82YObHANBxTUrCmsx5BJBApGzyK6UPw+MPVNNWrm4nh7NfUuKIh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mRDVjrut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBFDC4CEF7;
	Mon, 29 Dec 2025 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767024945;
	bh=tCV8j4qeNCzprriKScwSiX3Nh5cgihVF46Fnuh6J7rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mRDVjrutSTEOfi6FHB9p6Q9vKW5gOVegPJBgOQ2linY5eMdHHR6jFay/X+9ynJjtH
	 hyPNKbIZrM0qV/Xrlg3xHBw+uT3Q1yb7LQGS0mfo/YM0iqqCPyngL/Cqom2z8/UGic
	 Hwv/VczE3VhG0Cr2zHCE3BgzLibi6q5qV5meGJQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 040/430] hfsplus: fix volume corruption issue for generic/101
Date: Mon, 29 Dec 2025 17:07:22 +0100
Message-ID: <20251229160725.841277231@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit 3f04ee216bc1406cb6214ceaa7e544114108e0fa ]

The xfstests' test-case generic/101 leaves HFS+ volume
in corrupted state:

sudo ./check generic/101
FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.17.0-rc1+ #4 SMP PREEMPT_DYNAMIC Wed Oct 1 15:02:44 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/101 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
(see XFSTESTS-2/xfstests-dev/results//generic/101.full for details)

Ran: generic/101
Failures: generic/101
Failed 1 of 1 tests

sudo fsck.hfsplus -d /dev/loop51
** /dev/loop51
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
Invalid volume free block count
(It should be 2614350 instead of 2614382)
Verify Status: VIStat = 0x8000, ABTStat = 0x0000 EBTStat = 0x0000
CBTStat = 0x0000 CatStat = 0x00000000
** Repairing volume.
** Rechecking volume.
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled was repaired successfully.

This test executes such steps: "Test that if we truncate a file
to a smaller size, then truncate it to its original size or
a larger size, then fsyncing it and a power failure happens,
the file will have the range [first_truncate_size, last_size[ with
all bytes having a value of 0x00 if we read it the next time
the filesystem is mounted.".

HFS+ keeps volume's free block count in the superblock.
However, hfsplus_file_fsync() doesn't store superblock's
content. As a result, superblock contains not correct
value of free blocks if a power failure happens.

This patch adds functionality of saving superblock's
content during hfsplus_file_fsync() call.

sudo ./check generic/101
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc3+ #96 SMP PREEMPT_DYNAMIC Wed Nov 19 12:47:37 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/101 32s ...  30s
Ran: generic/101
Passed all 1 tests

sudo fsck.hfsplus -d /dev/loop51
** /dev/loop51
	Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
   Executing fsck_hfs (version 540.1-Linux).
** Checking non-journaled HFS Plus Volume.
   The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled appears to be OK.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20251119223219.1824434-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/hfsplus_fs.h |  2 +
 fs/hfsplus/inode.c      |  9 +++++
 fs/hfsplus/super.c      | 87 +++++++++++++++++++++++++----------------
 3 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 89e8b19c127b0..de801942ae471 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -477,6 +477,8 @@ int hfs_part_find(struct super_block *sb, sector_t *part_start,
 /* super.c */
 struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino);
 void hfsplus_mark_mdb_dirty(struct super_block *sb);
+void hfsplus_prepare_volume_header_for_commit(struct hfsplus_vh *vhdr);
+int hfsplus_commit_superblock(struct super_block *sb);
 
 /* tables.c */
 extern u16 hfsplus_case_fold_table[];
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index e290e417ed3a7..7ae6745ca7ae1 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -325,6 +325,7 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	struct inode *inode = file->f_mapping->host;
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	struct hfsplus_vh *vhdr = sbi->s_vhdr;
 	int error = 0, error2;
 
 	error = file_write_and_wait_range(file, start, end);
@@ -368,6 +369,14 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 			error = error2;
 	}
 
+	mutex_lock(&sbi->vh_mutex);
+	hfsplus_prepare_volume_header_for_commit(vhdr);
+	mutex_unlock(&sbi->vh_mutex);
+
+	error2 = hfsplus_commit_superblock(inode->i_sb);
+	if (!error)
+		error = error2;
+
 	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
 		blkdev_issue_flush(inode->i_sb->s_bdev);
 
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 16bc4abc67e08..67a7a2a093476 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -187,40 +187,15 @@ static void hfsplus_evict_inode(struct inode *inode)
 	}
 }
 
-static int hfsplus_sync_fs(struct super_block *sb, int wait)
+int hfsplus_commit_superblock(struct super_block *sb)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct hfsplus_vh *vhdr = sbi->s_vhdr;
 	int write_backup = 0;
-	int error, error2;
-
-	if (!wait)
-		return 0;
+	int error = 0, error2;
 
 	hfs_dbg("starting...\n");
 
-	/*
-	 * Explicitly write out the special metadata inodes.
-	 *
-	 * While these special inodes are marked as hashed and written
-	 * out peridocically by the flusher threads we redirty them
-	 * during writeout of normal inodes, and thus the life lock
-	 * prevents us from getting the latest state to disk.
-	 */
-	error = filemap_write_and_wait(sbi->cat_tree->inode->i_mapping);
-	error2 = filemap_write_and_wait(sbi->ext_tree->inode->i_mapping);
-	if (!error)
-		error = error2;
-	if (sbi->attr_tree) {
-		error2 =
-		    filemap_write_and_wait(sbi->attr_tree->inode->i_mapping);
-		if (!error)
-			error = error2;
-	}
-	error2 = filemap_write_and_wait(sbi->alloc_file->i_mapping);
-	if (!error)
-		error = error2;
-
 	mutex_lock(&sbi->vh_mutex);
 	mutex_lock(&sbi->alloc_mutex);
 	vhdr->free_blocks = cpu_to_be32(sbi->free_blocks);
@@ -249,11 +224,52 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 				  sbi->part_start + sbi->sect_count - 2,
 				  sbi->s_backup_vhdr_buf, NULL, REQ_OP_WRITE);
 	if (!error)
-		error2 = error;
+		error = error2;
 out:
 	mutex_unlock(&sbi->alloc_mutex);
 	mutex_unlock(&sbi->vh_mutex);
 
+	hfs_dbg("finished: err %d\n", error);
+
+	return error;
+}
+
+static int hfsplus_sync_fs(struct super_block *sb, int wait)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	int error, error2;
+
+	if (!wait)
+		return 0;
+
+	hfs_dbg("starting...\n");
+
+	/*
+	 * Explicitly write out the special metadata inodes.
+	 *
+	 * While these special inodes are marked as hashed and written
+	 * out peridocically by the flusher threads we redirty them
+	 * during writeout of normal inodes, and thus the life lock
+	 * prevents us from getting the latest state to disk.
+	 */
+	error = filemap_write_and_wait(sbi->cat_tree->inode->i_mapping);
+	error2 = filemap_write_and_wait(sbi->ext_tree->inode->i_mapping);
+	if (!error)
+		error = error2;
+	if (sbi->attr_tree) {
+		error2 =
+		    filemap_write_and_wait(sbi->attr_tree->inode->i_mapping);
+		if (!error)
+			error = error2;
+	}
+	error2 = filemap_write_and_wait(sbi->alloc_file->i_mapping);
+	if (!error)
+		error = error2;
+
+	error2 = hfsplus_commit_superblock(sb);
+	if (!error)
+		error = error2;
+
 	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
 		blkdev_issue_flush(sb->s_bdev);
 
@@ -395,6 +411,15 @@ static const struct super_operations hfsplus_sops = {
 	.show_options	= hfsplus_show_options,
 };
 
+void hfsplus_prepare_volume_header_for_commit(struct hfsplus_vh *vhdr)
+{
+	vhdr->last_mount_vers = cpu_to_be32(HFSP_MOUNT_VERSION);
+	vhdr->modify_date = hfsp_now2mt();
+	be32_add_cpu(&vhdr->write_count, 1);
+	vhdr->attributes &= cpu_to_be32(~HFSPLUS_VOL_UNMNT);
+	vhdr->attributes |= cpu_to_be32(HFSPLUS_VOL_INCNSTNT);
+}
+
 static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct hfsplus_vh *vhdr;
@@ -562,11 +587,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		 * H+LX == hfsplusutils, H+Lx == this driver, H+lx is unused
 		 * all three are registered with Apple for our use
 		 */
-		vhdr->last_mount_vers = cpu_to_be32(HFSP_MOUNT_VERSION);
-		vhdr->modify_date = hfsp_now2mt();
-		be32_add_cpu(&vhdr->write_count, 1);
-		vhdr->attributes &= cpu_to_be32(~HFSPLUS_VOL_UNMNT);
-		vhdr->attributes |= cpu_to_be32(HFSPLUS_VOL_INCNSTNT);
+		hfsplus_prepare_volume_header_for_commit(vhdr);
 		hfsplus_sync_fs(sb, 1);
 
 		if (!sbi->hidden_dir) {
-- 
2.51.0




