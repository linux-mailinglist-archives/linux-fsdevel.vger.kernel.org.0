Return-Path: <linux-fsdevel+bounces-47550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17428A9FEE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 03:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 508AB7ABEEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 01:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4773BB44;
	Tue, 29 Apr 2025 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="e6bcd5pe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9C1E492
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745889365; cv=none; b=JMGApptIOQL3Uoi691J2/LVJFAihlwIPUcGOxonpRW/WC3c2Ni/imupWmbzjlH/swm6Ti3UT5gkAd1NC6a0iSMwu3Isd2gwyXE3U/MB4RvvmRij6O4CmQ1ujgFWHGDPco7WdeQom5fksWHZ8HyDTJyVN2+KUM9Fs4II4zyZestg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745889365; c=relaxed/simple;
	bh=k5nzN7iOkRlYmLATP4PQCVKW8cPPHGoQQ8ExPHmux9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MqXJCGPrwd5Icxq0pXUGQnBW1QR3FnvyzmDBpjgnQMAoKJd9lDjNcWv8ThOrLGs87AEaaH4t99m8inryqBjy4HxU/4fTNWIQMb0lyFAQG7N3QZGrvDjLXjQ14IdkH9CLnjiFuPb2VyoaSrPsHGuITPCII27Xh5KYeDNMDDzvews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=e6bcd5pe; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-309f3bf23b8so5909941a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1745889362; x=1746494162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dT9SoI2QNQ4gPcK5I7vC+qFQ+TSbsVNBjNVnhUDHniM=;
        b=e6bcd5pe+2ra3LMhG0ilkfNaj88Gx2I/QE/zb+7VLAuacI/Jrg2QWnqxuH8WueIP5r
         xaYqqnlE1DN/0Am76OZj84jUJOM6h+rulgbLV9jKrXTGYXRTRntw++qE4qw+BDcCypaX
         o7/2hb231s56GIGMpKNWncUmE2WEz6Ru9T28uqnzndTYZtZfi/ZjoLECnjTwv9OUQdDM
         VzTgpFpqUxIwXFJ8cTYTuPmH42xB+kdZ88V2S7rrT5+silkAO0k+V1CwydpROt1YWqPQ
         6mSnycW5HGaR3GnyY3+QzR6nPZiPjX1Zm0vQ6LpVJoPxcA72lIUHUG6QCoGM0OTOyP+d
         L7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745889362; x=1746494162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT9SoI2QNQ4gPcK5I7vC+qFQ+TSbsVNBjNVnhUDHniM=;
        b=AaJwvAQDXr8pSBLf3pkrJsOtL8iI7F/Hi528SuhNFVwv5DGZ4guVRDQT7T+FKu7WhP
         +IO2p6SgbLA5zoiPlTa499uBOudPBiSJ9A7bpZon0MO5cA5JZOHvrEQbvgG7GY/8G6lf
         TdjU/+/wSgR0F38Hx/B+V40FYl/LoY5Lk066ci/MCL2XSIe8FAMd445DGVTeKSZA0tGL
         XZDgICTf2x5uIo74M9WoCL7iyjDHlteeei34yryMnwi38zSeca/8tMw92rluk6wXMr6T
         6ePigxLzLCnFsx0UX4/uY4i4DoJ5x1y1z0XefMBqyldbFFNBdN+rxEM+TT5YWFzEMA3n
         8oYw==
X-Forwarded-Encrypted: i=1; AJvYcCXHPL5Z0k/X7pyM8Thu1MogmTi/hQeNNcwOrDWND0LzLhJZgJOHl4fsw7art36am45NvzEyO5tAW/HjcNvm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1fEhGhJeRtu/1zojs94Q7p+wlQIVJVtiGsGuOFd/FIJGqrus1
	1HwjDddNXNlosGF46/aDITQlr5w1bO6Z5rouHJKlradED39gNEjHnPeczNJ2IKY=
X-Gm-Gg: ASbGncs3sjZwcxgSq1u2mTnKuhGYFRNfYc/NyrOdOjMbxPED5FErcKKJcmsMARXXual
	EJSRahMtRi1QGT/0pUmMs+cRMY+4d+akmRFBjL1Zbccte2mJnobm69oLZCF68Q+gM2X9SshkH2m
	eDe3fPUyF3jQ5kSyatN0lnVNAjyZUS0dZOOTyM/l0revo5VPYuNdX2nYGqlpozvKVFNgFHl8/oI
	aTJRQ4d/i3hPL/SPzX38a5ak7o8+mChbEmc+9SADEH4Ub07JWGdscFeLzFJnjCbsWYaBEm75sjN
	rNNZk8itDiyYRCJ7YJ+7an632/j+8fQ=
X-Google-Smtp-Source: AGHT+IHptLC31bQ5Cqy9EK/0/AqCBSf3DjZkAg8xvlDw2TKkChAEgqWl7mhu/MmUkdMk08ju0GJOBA==
X-Received: by 2002:a17:90b:57e8:b0:2ff:58b8:5c46 with SMTP id 98e67ed59e1d1-30a013275a8mr14000223a91.8.1745889362263;
        Mon, 28 Apr 2025 18:16:02 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430::45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f774e4ffsm8002638a91.12.2025.04.28.18.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 18:16:01 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: fix not erasing deleted b-tree node issue
Date: Mon, 28 Apr 2025 18:15:24 -0700
Message-Id: <20250429011524.1542743-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic/001 test of xfstests suite fails and corrupts
the HFS volume:

sudo ./check generic/001
FSTYP         -- hfs
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc2+ #3 SMP PREEMPT_DYNAMIC Fri Apr 25 17:13:00 PDT 2>
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/001 32s ... _check_generic_filesystem: filesystem on /dev/loop50 is inconsistent
(see /home/slavad/XFSTESTS-2/xfstests-dev/results//generic/001.full for details)

Ran: generic/001
Failures: generic/001
Failed 1 of 1 tests

fsck.hfs -d -n ./test-image.bin
** ./test-image.bin (NO WRITE)
	Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
   Executing fsck_hfs (version 540.1-Linux).
** Checking HFS volume.
   The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
   Unused node is not erased (node = 2)
   Unused node is not erased (node = 4)
<skipped>
   Unused node is not erased (node = 253)
   Unused node is not erased (node = 254)
   Unused node is not erased (node = 255)
   Unused node is not erased (node = 256)
** Checking catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
   Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0000
                  CBTStat = 0x0004 CatStat = 0x00000000
** The volume untitled was found corrupt and needs to be repaired.
	volume type is HFS
	primary MDB is at block 2 0x02
	alternate MDB is at block 20971518 0x13ffffe
	primary VHB is at block 0 0x00
	alternate VHB is at block 0 0x00
	sector size = 512 0x200
	VolumeObject flags = 0x19
	total sectors for volume = 20971520 0x1400000
	total sectors for embedded volume = 0 0x00

This patch adds logic of clearing the deleted b-tree node.

sudo ./check generic/001
FSTYP         -- hfs
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc2+ #3 SMP PREEMPT_DYNAMIC Fri Apr 25 17:13:00 PDT 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/001 9s ...  32s
Ran: generic/001
Passed all 1 tests

fsck.hfs -d -n ./test-image.bin
** ./test-image.bin (NO WRITE)
	Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
   Executing fsck_hfs (version 540.1-Linux).
** Checking HFS volume.
   The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled appears to be OK.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfs/bnode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index cb823a8a6ba9..c5eae7c418a1 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -219,6 +219,8 @@ void hfs_bnode_unlink(struct hfs_bnode *node)
 		tree->root = 0;
 		tree->depth = 0;
 	}
+
+	hfs_bnode_clear(node, 0, tree->node_size);
 	set_bit(HFS_BNODE_DELETED, &node->flags);
 }
 
-- 
2.34.1


