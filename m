Return-Path: <linux-fsdevel+bounces-68118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC81C54CD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 00:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23AFF4E0616
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 23:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886722F0696;
	Wed, 12 Nov 2025 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="DjQ/A7Bk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2782475CE
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762989948; cv=none; b=FuujihzknNfo4EBqvXvgeWCpp6l8sQ2o78EyelkkWbKwUPj5i/h+4Ov9r3OthLa+azHNqs3//2nzH41BngIw+HHWwZABmWmTuBAXU6NqNTRViKxOj1+mwyhLVSvbwv5tdFFT7kCAdW0a8Px4BF84HVnDOJtrM6UVPTJlgNvBDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762989948; c=relaxed/simple;
	bh=v1OoAREUh3x7UXoXd20Ub3WPSNGH9vHpEBIav+DlF+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ctJFUy4s95tmY59i07DFKeOfwkZhNBq7ShXTbZbGqINFmXX1nBw+wqHpm9c+TusX3Z02wuhOhtwITLRx33xK2WC3lpNVsVIc7gPWyaBjYAvMTC3K99FVp6RzERWiPsVaYkZcyAZmd1Ji2Zcl6r4IE3s7wvf7GX6EWDNbSBBNWnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=DjQ/A7Bk; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640d790d444so177832d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 15:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1762989945; x=1763594745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jhM7NSdhCosUF24u4Ap0OrydLMFgPE/nP1ACQ+pLoOA=;
        b=DjQ/A7BkaH4YSMvcUB8fnNp2hbBjI61sVJHgarN9UIm8sNsSJd1Tc8AJ6xPED4QP70
         hq4/EZGZNbuh7EvRRv2vvphVJ2lt9XG5lwiiT0HnWK8roTC/fOdo1lWhKr7dcA+Y0D4l
         y//vU8CNJt02Z1a3xOJLW+4b0HiFW9u7TbWJF4edGlUGTPqYmv71vORZ8qKWdJIZ6+pv
         ScywVmA16zGwWUPxLGKDrVDQ+hYPEJu+TrspU8iV/o3lPtIvzQyu+mINa7DKIH3qHRBd
         CDsFMkchvD1TvJPmCoCu11kw+mNuUTzhz2YnWyYGlvFyA5yjsLuOt8U9UWV46xqJAaHD
         mDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762989945; x=1763594745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhM7NSdhCosUF24u4Ap0OrydLMFgPE/nP1ACQ+pLoOA=;
        b=re1P6sXtFFCme40Ll3lBQtqLNOQ/RajiBkBphDwjR0loWAKHHkCdIzigCkRr3ap9oa
         wmEZx9TfeXMWFnRzHxDP1yV20LTwA7XFx0gfvzy04jZGp7ZC6p4czneXe/AkcerJXhgn
         I6XPEjw6UlrZFcXxzYnWjo3x3NVGMCn2RSvlPwrfP3GRYP7PHKgA9jHq86Ot4srvWZpq
         RabvzvkUSEUBYSRM82ldmneW+IbMTENpt2ult7YHvork/mYLsaBNWxJZL7QEe81ofSGV
         DF6tEpb+FD8cKrZWcg0E9PcNpPfG7zW8kYAklI2uoLU/dERKvwDTiPxCwLo/FdoAXflc
         Ba7A==
X-Forwarded-Encrypted: i=1; AJvYcCWRn+WjQVDuOszYRmdFWIlkxS+hxQJ3U7oUEBTPZyTKyWQAinp6alOxCPZGEZCk2Z1m7Of/X7mVNaMQczPl@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBwKT3sHjbqpHGi2WuTx4ADpoI/it7ZPcuU/ByewBMNpeu5i3
	HDBXQ77wg02e4flLl4CqvpToW2LNK4QMFRz6a/HWeWBwR1cylaNKM1LeXhOBF++iaKA=
X-Gm-Gg: ASbGnct/gMHB/QToColoC0etfg6K/Q+gtlE98k8+A3CLdemq8nw9NQxBaPUrzkL2bT7
	avGRPef/8ZPk63ltj1dspVxteedHGuM9oHjaHqJKly3U2WVg9CAseZ4VDf0MKhBGCqBGYfXqfSb
	6UTSiMyO6Huy/CWbioHXlz00QRkTgoY6hCtDi6Ak/XFQ0SetFzfWc2teVGQE35GCJQhXtgO4U7+
	rNQcUO8UQIMEWccDA+LrejDymWNYpCJwfMuE6ptsm2VlSgweTwYeX7rRIGxeqKXFfgfC1PN6agE
	JKJuIL6yLAbUOqARL+JXePpIMWucsGk2biFpvNYwpthWHehHF6rtFqVkQv8dlDro4LkV1AyzVVf
	gJJM8uT3Er6UJDrJc9cfI3EWj5uMT/tFucDn1X6Jq6VbKMm9QnuCMBAMa+ZBXJUWbXk6cBoGxfR
	1+Zk+oiRI24OGQ
X-Google-Smtp-Source: AGHT+IFwBT7oeYAYZMk8GYzJjjLxW9uoZidD759tSHzRQNsK79wQJ5wlZkRygDk6J4plzXbpVOuo5g==
X-Received: by 2002:a53:c041:0:10b0:63f:b367:3218 with SMTP id 956f58d0204a3-64101a34e1dmr3547051d50.11.1762989945435;
        Wed, 12 Nov 2025 15:25:45 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:4b92:997b:9f87:893c])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410eabb46esm119871d50.17.2025.11.12.15.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 15:25:44 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix volume corruption issue for generic/073
Date: Wed, 12 Nov 2025 15:25:23 -0800
Message-Id: <20251112232522.814038-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/hfsplus/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 1b3e27a0d5e0..cadf0b5f9342 100644
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
2.43.0


