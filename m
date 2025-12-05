Return-Path: <linux-fsdevel+bounces-70741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA2CA5B86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 01:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E067E3106D29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 00:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537517C77;
	Fri,  5 Dec 2025 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="KRNpgN55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE838D
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764892889; cv=none; b=jsf5vgYaKfbxbpsD3O2wz02WILcu//8zqo+ziWH38qPjS3MfHx2soF1YJ2N3gEBQqt7FwW3rCxuWJeycsyEC7jTxJ2c54I8rf4QAyBYW9fkqqoeOWGwLc31zloYU/1GFZWMvt77u0sl4W+KXpr+aRdXCHlg7p41+FzthdcpTgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764892889; c=relaxed/simple;
	bh=BViJYyVwDG9kNE4HjO6WE0aJ247Tf5rgKjVbppZW704=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NOtccoX9fEdoAZnW7vn+9L9BeO608DT9SwE5tCJifzq5j4OsWCJh3IlfpC3xCq/J4hkLHH74chTaDCeOUdYNyQav1Pxk0ECN4LkqAf5uSVUZIeFDhrcvprK5e6F2r+PmSe9aVFE2xqN2PxkgmnNxzqhsaNj83ABrCfH+CLopANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=KRNpgN55; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787e84ceaf7so14479617b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 16:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1764892886; x=1765497686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ScTaYnEyM1EdNLw3QuLsIZvBzFCYZb8c+npB/BVZ9/M=;
        b=KRNpgN55ACLsDKr9jTEIXFtiyeW3yPEkU/hTBrdhqePNlwRrGy2m5IH8uefTjTpIyZ
         PPek7X3tViVmc29XH4NlLOaQ/PPW5xSsiYphimMfEEt57w9G4563uNXxDjxnfW5T6Mh+
         N7dSGnFGg6ejzCSOnyuX1AyKBVxpkSjtshGmdKI1zCiPa0Xwsi36fV3TBWerFbPei1vA
         nOQNn+faKrRlUz8ua9vJtaNidQrQoNGPGGN5QCP2TH3oFGr4okNHMz4RuR8RZbLXMro0
         vNMzzk9rEv0C01Na/FDhTqRfWbjcLfdfJAlGhJuhRgqIQ/FtKW74sm6eAX99HcRfKEe4
         fVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764892886; x=1765497686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScTaYnEyM1EdNLw3QuLsIZvBzFCYZb8c+npB/BVZ9/M=;
        b=JqmJpcxs1MVtpnvCCDGqJr1vXT2XTfCmyInW9MYdZGJEu6vZvysp+Y4Z6Aob/CQ7YX
         km4qrQwUW1yGTMv4zwDkCXHOoR3O9gzpcTrHQzjfF05tqfvDkULifOGhguMmxD8pNFlY
         3asq7gPeIjcwpOYnqR268OAYHB9SMADALpZxCLdYgCXGZdL/OZNZihpDQr/jBvvCA7aM
         AjsJkKHvFz0OiZ3uAGyDeNHECE4691WE2RkVfQNK7dLa9zOwc8bnQ/PfKirxqcpGGwP/
         QRoNuxo3au8gRf9Br8wBt/5nPac9r7tDLLLZgxuLVBLJrc50IH3YRkrjR6Vh+P1l8aJO
         +5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+tFDOYV2Zt+13AZDdmb50qCj1wA8hvBE7qJfR6F5kEqWZGYAKzBhDrey9i6NxgRT7QWZk2irOLnCCVHev@vger.kernel.org
X-Gm-Message-State: AOJu0YwGlwMEZ1m0DseYlaBQQWuVYBsUibBFoJio1ZkdAe6mhm8QipJG
	M8+SAjEjP5Li9boNC1T7nIwjoucrqt6c/IxIfkGHoPA/j92hwLbnv2xwnBSwNwol1rY=
X-Gm-Gg: ASbGnct2r2s2aBB115sXmvO01jpA3/OrNyLhyKgFDkZhSGso25DKC6jxkvUqPt0s90q
	TAK+Injf78pxDrEJI07OstckZLGw1ZFZK0Uj8zQkf2XKsNvY9wJbz3GFwfCh5z6KGAHn3NLAIY5
	j/m0eNJq4SvY+Q6OE5Qrli0DJUUTSm57OgFZ2pVBZJIUn4e/Ys5M/okijFigJ0u/PpMDwKJH2yu
	+038i0Wsn96+cqdZkC0/tF+Uv8S+cBV1b2kM902MztelsnCTkXhfLbSf79Gpm6KoqAMaizP+B36
	TRI8yQym7p8zYAvMf7gPebnDGNkK5ApGwkxlT9WfMsovs6K7fu7hr5RuAeXiyits3IqYv2qcYoV
	QDeSI5Hr6olP2VrVO0p80yyRT5ZlD1LiGwEC06GU4+pzJrF+svLBP/xJf1HJcBhHsdMCuVS3rcz
	+Qhf8WOHS9/cIngVqL72DpuYuRWGj7lTuDpw==
X-Google-Smtp-Source: AGHT+IFnE2ZDTsXwHdgMuBPPWij4w5BWqzJNRMZvxOP3dZRe3JM3tmtfS6VYf4kL7RF4FrGWLq87OA==
X-Received: by 2002:a05:690c:4b87:b0:787:e117:9508 with SMTP id 00721157ae682-78c0c0222d9mr60746147b3.38.1764892885727;
        Thu, 04 Dec 2025 16:01:25 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:8b60:bc11:905f:46d4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b78de56sm11019977b3.38.2025.12.04.16.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 16:01:25 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix volume corruption issue for generic/480
Date: Thu,  4 Dec 2025 16:00:55 -0800
Message-Id: <20251205000054.3670326-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/480 leaves HFS+ volume
in corrupted state:

sudo ./check generic/480
FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.17.0-rc1+ #4 SMP PREEMPT_DYNAMIC Wed Oct 1 15:02:44 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/480 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
(see XFSTESTS-2/xfstests-dev/results//generic/480.full for details)

Ran: generic/480
Failures: generic/480
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
CheckHardLinks: found 1 pre-Leopard file inodes.
Incorrect number of file hard links
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
invalid VHB nextCatalogID
Volume header needs minor repair
(2, 0)
Verify Status: VIStat = 0x8000, ABTStat = 0x0000 EBTStat = 0x0000
CBTStat = 0x0000 CatStat = 0x00000002
** Repairing volume.
Incorrect flags for file hard link (id = 19)
(It should be 0x22 instead of 0x2)
Incorrect flags for file inode (id = 18)
(It should be 0x22 instead of 0x2)
first link ID=0 is < 16 for fileinode=18
Error getting first link ID for inode = 18 (result=2)
Invalid first link in hard link chain (id = 18)
(It should be 19 instead of 0)
Indirect node 18 needs link count adjustment
(It should be 1 instead of 2)
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

The generic/480 test executes such steps on final phase:

"Now remove of the links of our file and create
a new file with the same name and in the same
parent directory, and finally fsync this new file."

unlink $SCRATCH_MNT/testdir/bar
touch $SCRATCH_MNT/testdir/bar
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/bar

"Simulate a power failure and mount the filesystem
to check that replaying the fsync log/journal
succeeds, that is the mount operation does not fail."

_flakey_drop_and_remount

The key issue in HFS+ logic is that hfsplus_link(),
hfsplus_unlink(), hfsplus_rmdir(), hfsplus_symlink(),
and hfsplus_mknod() methods don't call
hfsplus_cat_write_inode() for the case of modified
inode objects. As a result, even if hfsplus_file_fsync()
is trying to flush the dirty Catalog File, but because of
not calling hfsplus_cat_write_inode() not all modified
inodes save the new state into Catalog File's records.
Finally, simulation of power failure results in inconsistent
state of Catalog File and FSCK tool reports about
volume corruption.

This patch adds calling of hfsplus_cat_write_inode()
method for modified inodes in hfsplus_link(),
hfsplus_unlink(), hfsplus_rmdir(), hfsplus_symlink(),
and hfsplus_mknod() methods. Also, it adds debug output
in several methods.

sudo ./check generic/480
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc1+ #18 SMP PREEMPT_DYNAMIC Thu Dec  4 12:24:45 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/480 16s ...  16s
Ran: generic/480
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/dir.c   | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/hfsplus/inode.c |  5 +++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index cadf0b5f9342..ca5f74a140ec 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -313,6 +313,9 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 	if (!S_ISREG(inode->i_mode))
 		return -EPERM;
 
+	hfs_dbg("src_dir->i_ino %lu, dst_dir->i_ino %lu, inode->i_ino %lu\n",
+		src_dir->i_ino, dst_dir->i_ino, inode->i_ino);
+
 	mutex_lock(&sbi->vh_mutex);
 	if (inode->i_ino == (u32)(unsigned long)src_dentry->d_fsdata) {
 		for (;;) {
@@ -332,7 +335,7 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 		cnid = sbi->next_cnid++;
 		src_dentry->d_fsdata = (void *)(unsigned long)cnid;
 		res = hfsplus_create_cat(cnid, src_dir,
-			&src_dentry->d_name, inode);
+					 &src_dentry->d_name, inode);
 		if (res)
 			/* panic? */
 			goto out;
@@ -350,6 +353,21 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 	mark_inode_dirty(inode);
 	sbi->file_count++;
 	hfsplus_mark_mdb_dirty(dst_dir->i_sb);
+
+	res = hfsplus_cat_write_inode(src_dir);
+	if (res)
+		goto out;
+
+	res = hfsplus_cat_write_inode(dst_dir);
+	if (res)
+		goto out;
+
+	res = hfsplus_cat_write_inode(sbi->hidden_dir);
+	if (res)
+		goto out;
+
+	res = hfsplus_cat_write_inode(inode);
+
 out:
 	mutex_unlock(&sbi->vh_mutex);
 	return res;
@@ -367,6 +385,9 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 	if (HFSPLUS_IS_RSRC(inode))
 		return -EPERM;
 
+	hfs_dbg("dir->i_ino %lu, inode->i_ino %lu\n",
+		dir->i_ino, inode->i_ino);
+
 	mutex_lock(&sbi->vh_mutex);
 	cnid = (u32)(unsigned long)dentry->d_fsdata;
 	if (inode->i_ino == cnid &&
@@ -408,6 +429,15 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 	inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
 out:
+	if (!res) {
+		res = hfsplus_cat_write_inode(dir);
+		if (!res) {
+			res = hfsplus_cat_write_inode(sbi->hidden_dir);
+			if (!res)
+				res = hfsplus_cat_write_inode(inode);
+		}
+	}
+
 	mutex_unlock(&sbi->vh_mutex);
 	return res;
 }
@@ -429,6 +459,8 @@ static int hfsplus_rmdir(struct inode *dir, struct dentry *dentry)
 	inode_set_ctime_current(inode);
 	hfsplus_delete_inode(inode);
 	mark_inode_dirty(inode);
+
+	res = hfsplus_cat_write_inode(dir);
 out:
 	mutex_unlock(&sbi->vh_mutex);
 	return res;
@@ -465,6 +497,12 @@ static int hfsplus_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 	hfsplus_instantiate(dentry, inode, inode->i_ino);
 	mark_inode_dirty(inode);
+
+	res = hfsplus_cat_write_inode(dir);
+	if (res)
+		goto out;
+
+	res = hfsplus_cat_write_inode(inode);
 	goto out;
 
 out_err:
@@ -506,6 +544,12 @@ static int hfsplus_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 	hfsplus_instantiate(dentry, inode, inode->i_ino);
 	mark_inode_dirty(inode);
+
+	res = hfsplus_cat_write_inode(dir);
+	if (res)
+		goto out;
+
+	res = hfsplus_cat_write_inode(inode);
 	goto out;
 
 failed_mknod:
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 7ae6745ca7ae..c762bf909d1a 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -328,6 +328,9 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	struct hfsplus_vh *vhdr = sbi->s_vhdr;
 	int error = 0, error2;
 
+	hfs_dbg("inode->i_ino %lu, start %llu, end %llu\n",
+		inode->i_ino, start, end);
+
 	error = file_write_and_wait_range(file, start, end);
 	if (error)
 		return error;
@@ -616,6 +619,8 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	hfsplus_cat_entry entry;
 	int res = 0;
 
+	hfs_dbg("inode->i_ino %lu\n", inode->i_ino);
+
 	if (HFSPLUS_IS_RSRC(inode))
 		main_inode = HFSPLUS_I(inode)->rsrc_inode;
 
-- 
2.43.0


