Return-Path: <linux-fsdevel+bounces-69158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C9EC71489
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 23:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 581502960A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 22:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006F2DE701;
	Wed, 19 Nov 2025 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="CI72Guqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD2275114
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763591571; cv=none; b=gp8/q8vcJp/ptKtE8pnwKoyyrwcAy9NQ0/UEWSoopCV2C9MHwHe0jLq0VJC4D0yPxBvdcgpwfPZf9YlOnpq8y2avi5fSkYO9Non8qE3ieAheBjHAdcup8UF3/oe5tppQFlfkgPXAvhHescm651CfsfhbMh2Gw+uAcYCiIu2P4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763591571; c=relaxed/simple;
	bh=8F0L/lnyWRnul8q1qGlqaS9eZbPWbHznj5RDR9Lo1W4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DViZriu6qmxR3DKgXjqYlGKan8QQZxLV6QYxr5L3GgHQAuX6yrHCc36baiyRfBzW08zxC7EOqh/o3RzQyMnpyTgHRSFHp47bfwQ5ZSSWUNtbYYb2Kk2y8+CbTkGKJN8aMVvdh3PZm+uvDMLM9lgk+eTJOvODbbohOvdbfdV2yMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=CI72Guqp; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e898ba2a03so116731fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 14:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1763591568; x=1764196368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PyDEw5FxanGWwO9UWC5jtZDAVdVVWOhVodJ1zg59fkk=;
        b=CI72Guqp7iCShkJoz7ZoDXZ5f/l6H0go3my/PVTX/G51IRFVdH8poQJMVqbLdzMuzp
         4mTAziBqf4Z4LY6j5p9TJkHNG0proraOBUgcjR06cz9xpWQ5YPyOVChfEs300SUtZb95
         7aaTUOSHh2ytQvtih9hYA2qpb4J02zgHPvKRo+na/VScHVSJu8FXZagi7nTaF9AqScpq
         t5xfS2Qm/COvKDNJFhKRQ5gSJt2G4U9BRlCGoDIBdfwnKIqRowuz1QNmMD/O1OJ8fTZb
         9RSFmV2YYj1uAtCZ4OUT6oplsn4ku5/bOQxZbtppzynjcG8Y5bc+slbRrQeAcYxxKf0s
         6S7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763591568; x=1764196368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyDEw5FxanGWwO9UWC5jtZDAVdVVWOhVodJ1zg59fkk=;
        b=HP9/m9APysWGs/i71Z02XqH7gFlq4yhELHxx424kePjZYnmToN1DToXQgPuB7WGyg9
         V7A/6HFuLla4YtvBXtbz0e1ucXWR+8Ordp4uKwbiTZ1BXotE4ESqHmws7oBh/XrCbB60
         rfL9+75uFq1aM1koG1fT4Do5/XluqgXQXD5OeFBsXnIL1rxAsSe3VEmL4jzzKwk78hcb
         IqAxva3kt8Y+rd7bbwbO9ru/Y4RvaIxTqMBFyGzG4L1WE+XFAGnGTlANUZYh3W9Lmike
         jyc5IR5KVfaV7V/igHDBJCtblLqHw7TY/v4V+DsHLNSg+xJsOc7Ex8WUa7PjIM0xBNih
         I2qw==
X-Forwarded-Encrypted: i=1; AJvYcCVDmKvWMgqJh+IkUShydLU92d4wgGu1mRPDlMCuPDagb+bEU/89kvedQfvg8KBpbDve2MIaExXJbx7iSQoi@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAxKuPORrzPhAl8ssD12nh4XwfqfgtUB9O8GUMJgUTz0yJRu+
	Nqv/lqeIzBU4tbTHf4E74k/7xR8resXqz3Vvk28kdpTTW+zV18eHKSL/PQIsN98gj8I=
X-Gm-Gg: ASbGncsSxebTOO0mCxIEv28WOe7yB/aEd11Fmm8AT6kkCk4nPWtjOUqED8Ns96qTXtq
	hMDKdlvZL3zSWadjzz7D6xexPDvJ3b0erR9MXs6pGFF4Z6i0e4xuMOJMGdXda1w+DBHHx3uF9RX
	DDchuy5BezN/rLl3Xc1DJQnCAyt9Dzt5skB6YLBVFDKXWu9CAJfEVQUTPFqPQhmZnHtuUkUza/7
	2MrAsaLNyjxdjhGR/X9PFd3IcqqFyMLRRKPf0XZK7lnLZvgqb9VVM+V2f6CHqLVk//gIyh41I3D
	MQ+e6jGKRp9DfkGNd4phhBR4kbInzeN57KVk/DToY1rRoGBJnWaSbRlhcpzYSz8gl1DOElPM8N8
	KObmFE4puVw0wpftI9W+2FxF1HRGmNHTj8NmDAxj+hakRHAjhersW0PM9jHSAC+dfsbGPOPXW3H
	HtNGBenen5p8FgVHjsuv93R8Tp7Kp38dztug==
X-Google-Smtp-Source: AGHT+IHFqi7TUpaZE/ychYHbyOul6TQuS3OF6zpBdAG9gl7CJSZZd2oiXH4Ra0/4kCNc6bh8WA/Imw==
X-Received: by 2002:a05:6808:6c8e:b0:44d:aa8b:58f6 with SMTP id 5614622812f47-450ff22f5d4mr522961b6e.1.1763591568496;
        Wed, 19 Nov 2025 14:32:48 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9eaa:1f08:489b:dabc])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450fffbf1fbsm190877b6e.19.2025.11.19.14.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 14:32:47 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix volume corruption issue for generic/101
Date: Wed, 19 Nov 2025 14:32:20 -0800
Message-Id: <20251119223219.1824434-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/hfsplus/hfsplus_fs.h |  2 +
 fs/hfsplus/inode.c      |  9 +++++
 fs/hfsplus/super.c      | 87 +++++++++++++++++++++++++----------------
 3 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 89e8b19c127b..de801942ae47 100644
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
index b51a411ecd23..bb5c37eb0662 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -305,6 +305,7 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	struct inode *inode = file->f_mapping->host;
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	struct hfsplus_vh *vhdr = sbi->s_vhdr;
 	int error = 0, error2;
 
 	error = file_write_and_wait_range(file, start, end);
@@ -348,6 +349,14 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
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
index 16bc4abc67e0..67a7a2a09347 100644
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
2.43.0


