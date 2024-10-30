Return-Path: <linux-fsdevel+bounces-33253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E503F9B6896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 16:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5148AB21A0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36552141B5;
	Wed, 30 Oct 2024 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz4xyf+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44626213EDC;
	Wed, 30 Oct 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303885; cv=none; b=IshMziNPYiDHHs6aci0Uyi/qA6nmELXdj2y9PBl5Yd7zyKnu7eUXxScrQNnDXi9KbxSjob90JaNz0gC3nsJk0Rz7FrJTC5/5mbQOqKsweGfgC4KgdOOdGGUnLlM4zEyIpZXzasRpcUfjHP+3ix/cOIetN9s+zuDeHuviIxUQJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303885; c=relaxed/simple;
	bh=ii0HmPh+1u6M/3ljsc+JpCXL0thIm98+oIUl1wxvCn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmNw2TH74loU6zOAWDCg8o0KSVzEgOu+NwSCQbMpFa8TKjheUUAWVBnZ2I+0g6N/l+4rZZN4RMKyWVjPuOArSSgBP82v+t9m9iqVm24jS0mA9Xry2TF/fiP885dLH8IdYdx5d3lsmD38TWLT4zbdNU0xJaDKZGrVTo5XxcWSL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uz4xyf+P; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-72041ff06a0so4549449b3a.2;
        Wed, 30 Oct 2024 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730303881; x=1730908681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUj5pDXiyw4d+gLVfen5igRO/ClY7T1n5Vg78IvA7nE=;
        b=Uz4xyf+PgUZ7R4Zz8sET94fnxdTOZvrd7co00hbh7XsuNZt0DauB3bgc7p4jVvYgiq
         F0awkR1Hcs0WvNTFqZ0s8bmRzLlhYSu0ELBaIctB/O6IgNSsu9toeMnQLQqjFcdZoA+U
         LUOzkCzCmOEZ/PzvEcVV1KVMM9s9UslmQ8ZBJtoXrP79iaA2COMbLhcS149wR1Qui/Mb
         PXha4iwAiJDidfC32E39XoUAnGVdjEzjaG3MFdNYYloGrFdZF86dlzNZxjbRkslWMi+8
         gr677HxZ8DfQYlkhhlq++kLt2mlycXvURRBrLR1PoF4j1hCI3hgPAbJXbz1S6S6/ksNi
         sNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730303881; x=1730908681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aUj5pDXiyw4d+gLVfen5igRO/ClY7T1n5Vg78IvA7nE=;
        b=bViWbOrAcKudtxppKPKNBJ/Iu/odQao+g1ijP2cMRI1T/fqQxon2Ebf2Q+c2dMT0su
         Tseo4/UxJRgn21asGUEiUHT2XQllX1Iog+/4gnL9yBdietABG8J0EBGDHqhiyD0eIjDx
         5oD42A7ADgMYNijDK45xIBQfJ4jGqxMH5Exvr+AaAvVxgGa4m5kwVavYvQ+5KSTiL/i2
         7OqRXk0R+B+ECchvYV5Ehc6s9dibo1LvWa5ESPKgthSxR2CYnE8SI73JzkY3gqkGlLs0
         5uN5Cd/fREq7b7yuVWs9RzMuh2wylBhcnNbujXNRTJrrceuF6yrhcLvcXIzvj6WoStqR
         6cnw==
X-Forwarded-Encrypted: i=1; AJvYcCV86jR664/y1VQHTlHxAigKdjRUgv8SOgaadv21joYqsciVsNxiACcIHQNHNSlV8lYHfAgO9BYDLYzFjv6T@vger.kernel.org, AJvYcCVbHtm7G9NK2K/+gOBL5IlDO4HryienyL4i6A+e+HmUhzNCFQEJMej9AqTqqL58uT9fpest7iBAStX8mqo4@vger.kernel.org, AJvYcCXgePJykHejNDcwVGyb53SxrJMiN1pNdPuJL+f9F99/TwhKoNJRUrJ9zZMSaaPsZB7bNlxbGi6nn5c/@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/l+WkPYci7o/FpvJ5K8TrJMdHBG6MiXJYCUctwA295VIrltO
	6MEm76Ppn3LgqGOC96zK1j+Gm7nS5REFw+GOBT1sBAEfvaUg3bgGjM1pOg==
X-Google-Smtp-Source: AGHT+IGj8LOEZQr5u1DT1R9YX2/xHtkUmEsWVP9izxsbLxNSy4eC2qPo+DpZ7S9gnPb2Afr4vUBRQg==
X-Received: by 2002:a05:6a00:140f:b0:71d:e93e:f542 with SMTP id d2e1a72fcca58-72063036770mr24272078b3a.21.1730303881494;
        Wed, 30 Oct 2024 08:58:01 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([203.81.241.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89f2d5bsm9407519a12.57.2024.10.30.08.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:58:00 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 0/4] ext4: Add atomic writes support for DIO
Date: Wed, 30 Oct 2024 21:27:37 +0530
Message-ID: <cover.1730286164.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 -> v3:
==========
1. Patch-1 adds an "experimental" string in dmesg log during mount when EXT4
   detects that it is capable of doing DIO atomic writes on a given device
   with min and max unit details.
2. Patch-4 has been updated to avoid returning -ENOTBLK (in ext4_iomap_end)
   if the request belongs to atomic write. This patch also adds a WARN_ON_ONCE()
   if atomic write ever fallback to buffered-io (to catch any unwanted bugs in the future).
   More details in the commit log of patch-4.
3. Collected RBs tag from John for Patch 2 & 3.

[v2]: https://lore.kernel.org/linux-ext4/cover.1729944406.git.ritesh.list@gmail.com/

Previous cover letter log:

In v2, we had split the series and this one only takes care of
atomic writes for single fsblock.
That means for now this gets only enabled on bs < ps systems on ext4.
Enablement of atomic writes for bigalloc (multi-fsblock support) is still
under discussion and may require general consensus within the filesystem
community [1].

This series adds the base feature support to enable atomic writes in
direct-io path for ext4. We advertise the minimum and the maximum atomic
write unit sizes via statx on a regular file.

This series allows users to utilize atomic write support using -
1. on bs < ps systems via - mkfs.ext4 -F -b 16384 /dev/sda

This can then be utilized using -
	xfs_io -fdc "pwrite -V 1 -A -b16k 0 16k" /mnt/f1

This is built on top of John's DIO atomic write series for XFS [2].
The VFS and block layer enablement for atomic writes were merged already.


[1]: https://lore.kernel.org/linux-ext4/87jzdvmqfz.fsf@gmail.com
[2]: https://lore.kernel.org/linux-xfs/20241019125113.369994-1-john.g.garry@oracle.com/


Changelogs:
===========
PATCH -> PATCH v2:
- addressed review comments from John and Darrick.
- renamed ext4_sb_info variables names: fs_awu* -> s_awu*
- [PATCH]: https://lore.kernel.org/linux-ext4/cover.1729825985.git.ritesh.list@gmail.com/

RFC -> PATCH:
- Dropped RFC tag
- Last RFC was posted a while ago but back then a lot of VFS and block layer
  interfaces were still not merged. Those are now merged, thanks to John and
  everyone else.
- [RFC] - https://lore.kernel.org/linux-ext4/cover.1709356594.git.ritesh.list@gmail.com/



Ritesh Harjani (IBM) (4):
  ext4: Add statx support for atomic writes
  ext4: Check for atomic writes support in write iter
  ext4: Support setting FMODE_CAN_ATOMIC_WRITE
  ext4: Do not fallback to buffered-io for DIO atomic write

 fs/ext4/ext4.h  |  9 +++++++++
 fs/ext4/file.c  | 24 ++++++++++++++++++++++++
 fs/ext4/inode.c | 28 +++++++++++++++++++++++-----
 fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 5 deletions(-)

--
2.46.0


