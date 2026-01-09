Return-Path: <linux-fsdevel+bounces-73047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E960DD093E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 13:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78BB73025532
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE5435A923;
	Fri,  9 Jan 2026 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eG0Rb0h7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9402933CE9A;
	Fri,  9 Jan 2026 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960294; cv=none; b=sN9nvjGBt4vBF2a1WwoReRuiDGexJ9AlApN/ck7hNfBLx4jqd1WIe2//wo8kKOxOnanQEQwkCw0Qf7W+kZABWjbsVIlqA0SiNtkeX5YqzJBafyTvT2nO0uE914w4uh8/PrdQc7LPTfQEND4FhB0HT0xWmAn7T9eymP3BDIfNLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960294; c=relaxed/simple;
	bh=0I6F4CldaZ2RPhT6u7HHZv4WuOsVTLrci2EdzKcU1Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFJiV7GD6hoCPHCwKyfarOqitEGgaP8gQmijOTGDTyrF55xp0xBuieo/BF4K9fMVcoyBuWmMC8a1mpZ1ey1Y/FGmQEZ8+6hDTr7F26Bk8iyD8di8vZa+Eo49YDYW/ySJ66JK75li2mT2kZC4v5cGUF/pBBYqFAwpgif+XliOt6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eG0Rb0h7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A13EC4CEF1;
	Fri,  9 Jan 2026 12:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767960294;
	bh=0I6F4CldaZ2RPhT6u7HHZv4WuOsVTLrci2EdzKcU1Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eG0Rb0h7luYYirT/N1s1Xp9ewCZGErEPikZveW7ncmFdeSDGs4ksIYPJZqxn/k6pK
	 fl9NQH5DNXHwHF3NhT5X5GLcEnqosD7EvK8yVNrOz2TIOs7TcM6+Uhjn78KZjwn4AU
	 H8oFhplwPh5+FfYiEgfFh6JEUa3dxr2sj3y0eVA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 321/737] hfsplus: fix volume corruption issue for generic/073
Date: Fri,  9 Jan 2026 12:37:40 +0100
Message-ID: <20260109112146.074701009@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit 24e17a29cf7537f0947f26a50f85319abd723c6c ]

The xfstests' test-case generic/073 leaves HFS+ volume
in corrupted state:

sudo ./check generic/073
FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.17.0-rc1+ #4 SMP PREEMPT_DYNAMIC Wed Oct 1 15:02:44 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/073 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
(see XFSTESTS-2/xfstests-dev/results//generic/073.full for details)

Ran: generic/073
Failures: generic/073
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
Invalid directory item count
(It should be 1 instead of 0)
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0000
CBTStat = 0x0000 CatStat = 0x00004000
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

The test is doing these steps on final phase:

mv $SCRATCH_MNT/testdir_1/bar $SCRATCH_MNT/testdir_2/bar
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir_1
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo

So, we move file bar from testdir_1 into testdir_2 folder. It means that HFS+
logic decrements the number of entries in testdir_1 and increments number of
entries in testdir_2. Finally, we do fsync only for testdir_1 and foo but not
for testdir_2. As a result, this is the reason why fsck.hfsplus detects the
volume corruption afterwards.

This patch fixes the issue by means of adding the
hfsplus_cat_write_inode() call for old_dir and new_dir in
hfsplus_rename() after the successful ending of
hfsplus_rename_cat(). This method makes modification of in-core
inode objects for old_dir and new_dir but it doesn't save these
modifications in Catalog File's entries. It was expected that
hfsplus_write_inode() will save these modifications afterwards.
However, because generic/073 does fsync only for testdir_1 and foo
then testdir_2 modification hasn't beed saved into Catalog File's
entry and it was flushed without this modification. And it was
detected by fsck.hfsplus. Now, hfsplus_rename() stores in Catalog
File all modified entries and correct state of Catalog File will
be flushed during hfsplus_file_fsync() call. Finally, it makes
fsck.hfsplus happy.

sudo ./check generic/073
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc3+ #93 SMP PREEMPT_DYNAMIC Wed Nov 12 14:37:49 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/073 32s ...  32s
Ran: generic/073
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20251112232522.814038-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index f5c4b3e31a1c2..33154c720a4e9 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -552,8 +552,13 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 	res = hfsplus_rename_cat((u32)(unsigned long)old_dentry->d_fsdata,
 				 old_dir, &old_dentry->d_name,
 				 new_dir, &new_dentry->d_name);
-	if (!res)
+	if (!res) {
 		new_dentry->d_fsdata = old_dentry->d_fsdata;
+
+		res = hfsplus_cat_write_inode(old_dir);
+		if (!res)
+			res = hfsplus_cat_write_inode(new_dir);
+	}
 	return res;
 }
 
-- 
2.51.0




