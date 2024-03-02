Return-Path: <linux-fsdevel+bounces-13350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0742686EF2C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 08:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3523F1C2170D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC51012B83;
	Sat,  2 Mar 2024 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVYKv2ZE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6014125B2;
	Sat,  2 Mar 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365348; cv=none; b=u4sYg5pArqXVw2k7BVUYWEtAgRjmXKaaADK1QsEe6GQaEFH0BcYsA93Y376IB+yVlsg9+iCiLsJ3zxkbzPbCE5vltsRu6V9xDPrjbTmjzlRl1OiBuQC45UgMabf5Kr1N6p7eL11zgQkF5CeUMfbcO5rfyLn6lxczc85+0BeqxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365348; c=relaxed/simple;
	bh=egQfzR9n2T7+euYgtQ2R2+NxC3oTiAP1hGg0IqRUGhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4JO7ujDm4Zy5G9NxNrZfLlbGYnGHZ62jEbuD0rb538qp/yU1v9Ewljpusnldel9mM6MnF8FKmnI9vdXi8EAYPtrwW2Tg2WIqMlgMihkwgNbKsBhELBJsgUJsESBrLvmY1VTmAK5qzPdrPuaTDCStpjxnhgaX+yT6fhPPY0KIBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVYKv2ZE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e5629d5237so2911984b3a.3;
        Fri, 01 Mar 2024 23:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709365345; x=1709970145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x1MHxTCslTHTnx3xWuCfr0MVVso4bcAgE6PXu4BxIrE=;
        b=NVYKv2ZEotGBbAEDq36kFWUt798Vu8ae9eY4NdoD9arZSSIfia7+WBMrwBQhdBVA6P
         eDg1IjiQwoDbPwcWj5Pd5Tdy5sNWJlRbrik+szNIRR3A0ygBJfX3WdE9t1SUy4QeQ2p9
         U0hnZGToZj0BCgGs+xudUhRTMFZisQsk11lB1cMYjWs6wZzA8XMGxHY18pZMTya3cLbR
         NdacDTF8KNyeTgemlsekrhbjqFDrklUZt610ICJhPlsu+7BC7FHCcvzUo9z7PZ/CoMw4
         tjVVy/cWlap7XiHdEp7qd7eSVcQDlIOPdyyRTeE6f49EdmaeKMOulFoc4BfsMSZPBsf0
         cRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709365345; x=1709970145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1MHxTCslTHTnx3xWuCfr0MVVso4bcAgE6PXu4BxIrE=;
        b=B+xGaHLUMGzFM6JwBmYsOO0+e0fQ0Rqzu5oV+zHFXAMG4q5pbtolSwlM830ekJMQmQ
         ZMPI1NBcbiy4pnU/0at+pU2RW7AbxW9y1s9w1sLbTALuxmItUxI/GcE8O6zFxuO9vzu/
         wfBPgUh1Zxsz9OLwq9aWTMopkNzO2RfuF1ArsyVTvG4pTgVKvI3AD9RL1qqeMG0Z2fWH
         CUnlDnNjwWOpwTUF1sM/fdPvRA1Z8BEAfvah3YDcKtAA0tXEwnCaQtW303FL5y/d+xmN
         U9kej5jZTARe1SdaGjutX2OtSqx/EEeLa7SwJ0KEdAf4YW88ezxYs1fuHGOUQhQFgQJ8
         j0+A==
X-Forwarded-Encrypted: i=1; AJvYcCWtqZgYJfJLiMrACjnremjB1CPcPBAf2Haecmxap+eC73rpzT/RbCUMQJwKBq7uYYk9g338Pg8laPuQE8Mkq0ynC3r8k5G0Fp8va+Nwbzz0y8lvFbYAiFB6t+chK2WTJnuJDAw5ePgUJA==
X-Gm-Message-State: AOJu0YyLUWeDPmWi4t3Rx9p1re7hcvN/HIHkoeoVxl5pjt4EIjAmyU9s
	qTB7Oe8Hb9zopjcbamaYd8HvdcD0AgZARu7Rz9RPkybF2Rcp0HlypKeoQQLy
X-Google-Smtp-Source: AGHT+IGxEAGHU8iFmIkI9IaatCGYlh3vesVByMqHYIf1eRM4W0xbZ2kigB146iIWUsC6lWBgkMnO2A==
X-Received: by 2002:a05:6a00:2354:b0:6e4:6ca5:30b7 with SMTP id j20-20020a056a00235400b006e46ca530b7mr4173722pfj.34.1709365344807;
        Fri, 01 Mar 2024 23:42:24 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006e45c5d7720sm4138206pfn.93.2024.03.01.23.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:42:24 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 0/9] ext4: Add direct-io atomic write support using fsawu
Date: Sat,  2 Mar 2024 13:11:57 +0530
Message-ID: <cover.1709356594.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

This RFC series adds support for atomic writes to ext4 direct-io using
filesystem atomic write unit. It's built on top of John's "block atomic
write v5" series which adds RWF_ATOMIC flag interface to pwritev2() and enables
atomic write support in underlying device driver and block layer.

This series uses the same RWF_ATOMIC interface for adding atomic write support
to ext4's direct-io path. One can utilize it by 2 of the methods explained below.
((1)mkfs.ext4 -b <BS>, (2) with bigalloc).

Filesystem atomic write unit (fsawu):
============================================
Atomic writes within ext4 can be supported using below 3 methods -
1. On a large pagesize system (e.g. Power with 64k pagesize or aarch64 with 64k pagesize),
   we can mkfs using different blocksizes. e.g. mkfs.ext4 -b <4k/8k/16k/32k/64k).
   Now if the underlying HW device supports atomic writes, than a corresponding
   blocksize can be chosen as a filesystem atomic write unit (fsawu) which
   should be within the underlying hw defined [awu_min, awu_max] range.
   For such filesystem, fsawu_[min|max] both are equal to blocksize (e.g. 16k)

   On a smaller pagesize system this can be utilized when support for LBS is
   complete (on ext4).

2. EXT4 already supports a feature called bigalloc. In that ext4 can handle
   allocation in cluster size units. So for e.g. we can create a filesystem with
   4k blocksize but with 64k clustersize. Such a configuration can also be used
   to support atomic writes if the underlying hw device supports it.
   In such case the fsawu_min will most likely be the filesystem blocksize and
   fsawu_max will mostly likely be the cluster size.

   So a user can do an atomic write of any size between [fsawu_min, fsawu_max]
   range as long as it satisfies other constraints being laid out by HW device
   (or by software stack) to support atomic writes.
   e.g. len should be a power of 2, pos % len should be naturally
   aligned and [start | end] (phys offsets) should not straddle over
   an atomic write boundary.

3. EXT4 mballoc can be made aware of doing aligned block allocation for e.g. by
   utilizing cr-0 allocation criteria. With this support, we won't be needing
   to format a new filesystem and hopefully when the support for this in mballoc
   is done, it can utilize the same interface/helper routines laid out in this
   patch series. There is work going on in this aspect too in parallel [2]


Purpose of an early RFC:
(note only minimal testing has been done on this).
========================
Other than getting early review comments on the design, hopefully it should also
help folks in their discussion at LSFMM since there are various topic proposals
out there regarding atomic write support in xfs and ext4 [3][4].


How to utilize this support:
===========================
1. mkfs.ext4 -b 4096 -C 65536 /dev/<sdb> (scsi_debug or device with atomic write)
   or mkfs.ext4 -b <BS=16k> if your platform supports it.
2. mount /dev/sdb /mnt
3. touch /mnt/f1
4. chattr +W /mnt/f1
5. xfs_io -dc "pwrite <pos> <len>" /mnt/f1


References:
===========
[1]: https://lore.kernel.org/all/20240226173612.1478858-1-john.g.garry@oracle.com/
[2]: https://lore.kernel.org/linux-ext4/cover.1701339358.git.ojaswin@linux.ibm.com/
[3]: https://www.spinics.net/lists/linux-xfs/msg81086.html
[4]: https://www.spinics.net/lists/linux-fsdevel/msg265226.html

John Garry (1):
  fs: Add FS_XFLAG_ATOMICWRITES flag

Ritesh Harjani (IBM) (7):
  fs: Reserve inode flag FS_ATOMICWRITES_FL for atomic writes
  iomap: Add atomic write support for direct-io
  ext4: Add statx and other atomic write helper routines
  ext4: Adds direct-io atomic writes checks
  ext4: Add an inode flag for atomic writes
  ext4: Enable FMODE_CAN_ATOMIC_WRITE in open for direct-io
  ext4: Adds atomic writes using fsawu

Ritesh Harjani (IBM) (1):
  e2fsprogs/chattr: Supports atomic writes attribute

 fs/ext4/ext4.h           | 87 +++++++++++++++++++++++++++++++++++++++-
 fs/ext4/file.c           | 38 ++++++++++++++++--
 fs/ext4/inode.c          | 16 ++++++++
 fs/ext4/ioctl.c          | 11 +++++
 fs/ext4/super.c          |  1 +
 fs/ioctl.c               |  4 ++
 fs/iomap/direct-io.c     | 75 ++++++++++++++++++++++++++++++++--
 fs/iomap/trace.h         |  3 +-
 include/linux/fileattr.h |  4 +-
 include/linux/iomap.h    |  1 +
 include/uapi/linux/fs.h  |  2 +
 11 files changed, 232 insertions(+), 10 deletions(-)

--
2.39.2


