Return-Path: <linux-fsdevel+bounces-47656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4B5AA3EA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 02:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B17486E11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 00:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD247FBAC;
	Wed, 30 Apr 2025 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="TE7nw/91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD377104
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971939; cv=none; b=JZtS877ex33LVARa4Iv7qVwzuBYVd7biIRLKIUxyhkLnBWVTkkqVo6zKNypWT+tUnnYwq9770iHPql7CcqvneX/QpbQ0KM969GbtBBctC/t7EQcQXduC32lvsWm9tAIRtDrekWHYos42pj3nfSjIoBBmr+Uwl9WNDuA3gKLl9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971939; c=relaxed/simple;
	bh=2WFI7YG09+m0cx02C/Cg8tS2QN4QWTbJbjpo7VZ8GSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tAkzHdJHQ0XxN0pG9Mke3Q532hoKkGi2SFLLuk7xTYpKBC43l2QPCaA/4W00GQ+xPosd6K0htGJQwnFNEv8BmLQryXddTNWn3Ut5kBiJCuDtOs9EevFESOhbx30AkFeaEoecrUpX3xbI7Bkpu1CWstDIG/Re6orNi8Xru4gKg1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=TE7nw/91; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f6dccdcadaso5244377b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1745971936; x=1746576736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RifrksALX2Vder+a6SHgAFpR082K9ppi+AV/kBSVHQs=;
        b=TE7nw/91Add6xXVmnDlqM5ZYHCx88OJUihQC1346YZHMhL7II17yeUqFxsJwDqJ0kA
         OYfObkMDmltSzyxsHTxqEGWtx+CmBAgcfZqioXh+1ub4fYuu9w6NzagMTbeGvaZO0Jb/
         VpI4gWn+qHXa3QERZFWiJLWBxJlWYRaxVyUgCM2aFeyz2dFSXDquTTr9+Kj2aeRUR1Kw
         5jBvSaVa9XXE0gh9gQR7OVoHqh/jiSYz5C8qn2Ih0P2VGwAPZySCFu4Hr6z9PLTnXsq1
         BDXOuQprJlkWtmHPIuheC5NKsv4x+AQq2b06fFm06ywY9G5gF/NVxDsDAxLub+ps/5GT
         RcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971936; x=1746576736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RifrksALX2Vder+a6SHgAFpR082K9ppi+AV/kBSVHQs=;
        b=gLPip9/wKl4O235PLexHftxYL5UkwqR8G4zqjtLhat0DptK0JZWl6GDuQi5KMzVCC/
         J2zeGbJlfCnEDjkXa0h7ZJt5fBwAZu/4Ac+pfSIPwP+c37LLsw4WakZC9XKVtcMYcHDo
         5UBSHoOrvVRXGm4K1X69A2kDBnY20RQRa22WMKhunAy5bhPQY6rSwLczE31Cq+9fSbdc
         u4At26OXzls5Y8F34d0EJg/imfkRkerlCeYmVbKIhKw+jFIcFkoTU0rExfbJ6rzVHEtD
         6uaCXq+0d4kqg5Wu5TGGBxulqYFRfO2sAXXs1XjeoXZ7nGA2U7G6d3MPMCiA5qx3HORo
         ge3A==
X-Forwarded-Encrypted: i=1; AJvYcCXZqAmh7rZPLGhDU88HZDzDcJ4YxzCJkQ1YKD+L6pid2tnB4FMz3q1wHVh0w5gLLiog9wrcvSVoRILMznti@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5UDD+SxRh+ulMVdYUZwGznAvkHr8WNY1l5W22v7mQrPTNnhxO
	UyO9cN7pY/rZS+/OqnquaRGt1i25WdnNiaEmWtXc2BjiQudqAc758musEwmd8pw=
X-Gm-Gg: ASbGncueFQwrM1aiiC+yDSPYEGAWsBNZUmFoYsMJBKphH7TmQUyh/eDjBI+d/+4VUPc
	sTJTK+lkYkaPndDWNbo4e/PEAA9AKEUtySTU1qtdm17hcEQ56qXlvJTQC/Qn3+4j7PJZeJi2kcr
	ylkzVEQAPxV0dhT9/Eqyd+msod/nObPwaxwmvrIl29Hue6VbeaGZfWxJjd1xFYGDS/Yh0wTSN0n
	DK8JphtORBtSigKKukLaycKgcKW4RMeq5Tswdw02GZuEDHSq04s3Ii51uYEf3e3G2bfIATJOLJ7
	pDKu68OVgy8Mt/QCFjS5JcXQYnzZhmk=
X-Google-Smtp-Source: AGHT+IFnPrNg8+Z4pnoghpX6MpSr/CqPz9Yx7fB2BjbMPsTcgGC66QMwLDMWftDgGPTmQ3JL1jT4HA==
X-Received: by 2002:a05:6808:6f96:b0:3f9:28b9:702a with SMTP id 5614622812f47-40239e4938amr948898b6e.8.1745971936132;
        Tue, 29 Apr 2025 17:12:16 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430::45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-402129255a2sm512854b6e.13.2025.04.29.17.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:15 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	linux-fsdevel@vger.kernel.org,
	Johannes.Thumshirn@wdc.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2] hfs: fix not erasing deleted b-tree node issue
Date: Tue, 29 Apr 2025 17:12:11 -0700
Message-Id: <20250430001211.1912533-1-slava@dubeyko.com>
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
 fs/hfs/bnode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index cb823a8a6ba9..50ed4c855364 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -482,6 +482,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
 		if (test_bit(HFS_BNODE_DELETED, &node->flags)) {
 			hfs_bnode_unhash(node);
 			spin_unlock(&tree->hash_lock);
+			hfs_bnode_clear(node, 0, tree->node_size);
 			hfs_bmap_free(node);
 			hfs_bnode_free(node);
 			return;
-- 
2.34.1


