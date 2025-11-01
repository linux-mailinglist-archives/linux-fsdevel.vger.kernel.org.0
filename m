Return-Path: <linux-fsdevel+bounces-66649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5275C27422
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 01:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AD3F4E5441
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 00:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C013812FF69;
	Sat,  1 Nov 2025 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="cK1UW6eu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5F7E105
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955996; cv=none; b=Rgi1PgTUtmMkqCJ25JaLIfVzwaJj9eRQafMg1aKZChkXUuEXrLe8t33q0fnr52+zh9/otr4YRBy7VHBkCSwvXJ4mK9S/2mDldubb9EL0Dp/J5nWVXC6aLblMSeOK+obklIDsFL/6fI3+9gDVH19q/EACUgvjVZiAx81Kdu+gano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955996; c=relaxed/simple;
	bh=maISa4LCHvWb0lvAc+0xeTgscbKqPu0NT5GY4oZMYPY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t4n3q7gTzLyjA1aDJefq8gHo2juc9dIpY18LguyRcfchI8qkcAZ52AsDHKh7cpQ4Uf+ti7Siw5jpQVy+Ziz5rk1oSdwcXn8y145UDnID6O3Xi178YN/cZD8kH7uhca1tWKtgso+j/QNRGPeb+grW6B5Oi3uY/ENh4Kr9ZdPOKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=cK1UW6eu; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63f74b43db8so3198728d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 17:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1761955993; x=1762560793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78uX3GAglyv1kULhy1GtP8Wr1g/vHEo1qGMW/s/tz+8=;
        b=cK1UW6eueL7QdFpHFGCq6V8CF8YJjO28LnLMxYLXduTSa+ol7aaHnhcCBTayZPTIae
         1KQgzNVhZUPR0hsJfKI6j7jNE7DDeV64G83xCfmznTwxUQfEFgn5+mQRWZsS3ctr8duX
         el8IJ1cCabsCp9P6qOIJqTGLvOYTx0ib++nR7OKNSd9xxkNA0gFFi9p5itkoDPG1xPO/
         wWAhhQEXkrf1dKRk4dNAzDgIFz+dNdVu7Y8XVillXT1jqCYW+MUjB//B5oj8JHPn3s23
         YqDQUyEvbAijwQ7k6fURHqE6gdC0c+/45yYNl9IO4HNOa9+pJHND/r7BV+BfCEjqUxqd
         IGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761955993; x=1762560793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78uX3GAglyv1kULhy1GtP8Wr1g/vHEo1qGMW/s/tz+8=;
        b=O/6nnDlvHK+PW1a11KBbojGjZTLQ6pdCKjDm4s6RKFxEVgs95aMZxgoYoLyPLIh2P6
         oWsPAvdGvAPiqy8SS6KZhOIHNB5TJiaPZ+GsoFEL/UbTSRItjqMvb5EU9aBiDQytPjEy
         7o0dKzxrrm/Gk09HNDUFqR7f+zZbCuJjvwCtYYX+d5JU/JXcjJLATvJ5JRf6Ga2qO3qk
         rVjO+MkZfnvC+/EHb9rgKatiTio+wKzvSksI1QBO1PTcGbjzfNwq1NSe5lHlHpLiG4Lh
         qvEH3IpLf0NmXer126SvHqGgmkyxwrawXkXvbGk2/sFVSOCGY5gSQh9TvghFuolUggdu
         WhfA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Zs8w3mo4deXT4yYWZ5r0Kp0z5WnrBjqhMSaYO7s98QWOvhs/5DLy4BlaT2wXyVdmJTRSmCTrSSClcfWM@vger.kernel.org
X-Gm-Message-State: AOJu0YxhhDcFG8Y8yNN0BrytzDmDlaKVbdwwpyVY+2aQnXvek/Fxy4j2
	WE3MdHAvN7xpmCYNURiSRqfpM4I/lIg0js/pVbuy9+/CSX8fh5aPko60jbOcvhdHJfQ=
X-Gm-Gg: ASbGncuXyneAuVJCf8uz8TrwsXdvWjHXWg5HEZfVxaKjTtHqiTMKi44xEFAajtkdZsi
	bjRsUFSAdGiwjlccirON4a7HER2TASmAQgwekglmKs5QnHFh5FQfv7MKbbXDW6Ydh8XiuNZSbXa
	JlEwlII2Tr6C+g9c+hECOeSyG4M89cOj+1m+R8Y4XnRJKyNbzQZwSp5JyK/XCC03i7ktvOSjOC4
	BIODBPbuVaCi/iIKd2JqFomGUmXTuVihN32QfcjxWdgxdD88xFezMkjQKVvjGWNZ0oXi9mK15ze
	g19N0p3QWgpihBDxKJ0J0uVQC2sYPZeQ5OhUyD5BNtLSe87Y1qMZN21csj5/tFWM41QaQU7SN3U
	0ikpDQoMkkTyKZ77nuzYuEe/g6bDPRPmPpy46rJ2wFi9KLfLdJaFZstOgqlQ5y/pvA2rVrbsKRJ
	1cR6FInAUoYwmKYazyyw1ntA==
X-Google-Smtp-Source: AGHT+IF+/WGv9GCCOS9L+khGCiBqCrKIv770K9fdnamut+q0ZfqLAOHBTyP3qPv22js4OWQvwq+QuQ==
X-Received: by 2002:a05:690e:d86:b0:63e:3099:fe7c with SMTP id 956f58d0204a3-63fa0e18cb7mr1032553d50.16.1761955992825;
        Fri, 31 Oct 2025 17:13:12 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6a77:8f32:2919:3a8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7864c66a2e7sm9645197b3.41.2025.10.31.17.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 17:13:11 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfsplus: fix volume corruption issue for generic/070
Date: Fri, 31 Oct 2025 17:12:30 -0700
Message-Id: <20251101001229.247432-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/070 leaves HFS+ volume
in corrupted state:

sudo ./check generic/070
FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.17.0-rc1+ #4 SMP PREEMPT_DYNAMIC Wed Oct 1 15:02:44 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/070 _check_generic_filesystem: filesystem on /dev/loop50 is inconsistent
(see xfstests-dev/results//generic/070.full for details)

Ran: generic/070
Failures: generic/070
Failed 1 of 1 tests

sudo fsck.hfsplus -d /dev/loop50
** /dev/loop50
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking non-journaled HFS Plus Volume.
The volume name is test
** Checking extents overflow file.
Unused node is not erased (node = 1)
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0004
CBTStat = 0x0000 CatStat = 0x00000000
** Repairing volume.
** Rechecking volume.
** Checking non-journaled HFS Plus Volume.
The volume name is test
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** The volume test was repaired successfully.

It is possible to see that fsck.hfsplus detected not
erased and unused node for the case of extents overflow file.
The HFS+ logic has special method that defines if the node
should be erased:

bool hfs_bnode_need_zeroout(struct hfs_btree *tree)
{
	struct super_block *sb = tree->inode->i_sb;
	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
	const u32 volume_attr = be32_to_cpu(sbi->s_vhdr->attributes);

	return tree->cnid == HFSPLUS_CAT_CNID &&
		volume_attr & HFSPLUS_VOL_UNUSED_NODE_FIX;
}

However, it is possible to see that this method works
only for the case of catalog file. But debugging of the issue
has shown that HFSPLUS_VOL_UNUSED_NODE_FIX attribute has been
requested for the extents overflow file too:

catalog file
kernel: hfsplus: node 4, num_recs 0, flags 0x10
kernel: hfsplus: tree->cnid 4, volume_attr 0x80000800

extents overflow file
kernel: hfsplus: node 1, num_recs 0, flags 0x10
kernel: hfsplus: tree->cnid 3, volume_attr 0x80000800

This patch modifies the hfs_bnode_need_zeroout() by checking
only volume_attr but not the b-tree ID because node zeroing
can be requested for all HFS+ b-tree types.

sudo ./check generic/070
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc3+ #79 SMP PREEMPT_DYNAMIC Fri Oct 31 16:07:42 PDT 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/070 33s ...  34s
Ran: generic/070
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/bnode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 63e652ad1e0d..edf7e27e1e37 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -704,6 +704,5 @@ bool hfs_bnode_need_zeroout(struct hfs_btree *tree)
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	const u32 volume_attr = be32_to_cpu(sbi->s_vhdr->attributes);
 
-	return tree->cnid == HFSPLUS_CAT_CNID &&
-		volume_attr & HFSPLUS_VOL_UNUSED_NODE_FIX;
+	return volume_attr & HFSPLUS_VOL_UNUSED_NODE_FIX;
 }
-- 
2.43.0


