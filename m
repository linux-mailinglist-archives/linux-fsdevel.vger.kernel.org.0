Return-Path: <linux-fsdevel+bounces-33424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB8D9B8B62
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61281B21FFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B315098B;
	Fri,  1 Nov 2024 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz2Ny/3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C41BDC3;
	Fri,  1 Nov 2024 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443877; cv=none; b=eCoI/dV1zyf5HgU3eYGWLn1tss/6qRI/E65dV6o3rjqaF8Xsb95CE3LaULJTf6hQrXKjvw9No7A2rsZDAhoPy0d/hW6I6AYsUxIYLxcsdx7tXfpYRK7ISDdKm7S5YyZp3CZpXIO6V7FCc8Wwpu3HGliUh3rDbE/6tDMK9tIlcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443877; c=relaxed/simple;
	bh=QNz5WFt57Q2JiA4J2xNBEKefwJr3EU+Z8Yrk14NQHi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cikg3arbYqmsfL+ZYrorSISSvvRdQsDygpofb7fcNwbiS7JBoPryZ+gSug55nhrWUkreQats59u1PJ3Ir5vjWEcerlskxptcvvd+IyYLaHPPhHYQB1Hn89cFQtFxr/6vVXoIJ57XlF0ckDiIYfCLutOglwd37FEVssimRzG3igI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz2Ny/3n; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71811707775so922321a34.3;
        Thu, 31 Oct 2024 23:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730443873; x=1731048673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dfQW7OHDgisTT2TJavaNFXyqFSOJrJGPZrVk+jhG0fc=;
        b=Fz2Ny/3ng9QR/NMpI5YEZ5RIZMZ83/9T5N0RW4nx1/0s0e6wzmz2RNlFjljg8L/bEe
         /GP1gssu8SHbuUR/UxsWFTAk+0R/i4f4zYs7tHuXqld58p5ehfPDmb8CpAun21NVA1Bp
         zcibXCbkZgx8p/6orRGaNUss2aV7G0++H2xL5cCHmuOUnoxOvN6i6EYL4EOi2w0mPwF7
         1pBjvUwcMNOlWIC5zblD+KU7ytwkj7FLs99knOwW3O3dEaeKy814ShdmjTzfabu+RNen
         kNZy1uKsR2G+IjV6N5Ab8Niq2chVb0PNSO2m+S6NEU4jT797a9h+oP4q+OCDxj/OP5DE
         etVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730443873; x=1731048673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfQW7OHDgisTT2TJavaNFXyqFSOJrJGPZrVk+jhG0fc=;
        b=lIt3BKRBAkvd7Gt7hhncXk7OjVQ/QakOvT0CO+YhK5R2w7ZgINvNfK3KxjKUO3S8ZY
         hypCbg1ECpJKCRHatXLBLB/jBme1JOR9Q1xq1LrTv+KD/8k87iCvTPpAT+2eeF2jkEyO
         oXVq2md5Jli0RpeABSjEP5vxvKDintoiEIQzljwMlNs2x7THCRsX1dsuqM9TaglI12Gi
         DhDW686XsC/jxk6C005gK+5vFk5txB1pMynlhcx7d9NMdp5kFZJIJergwo3iYaGS+0Di
         +ILBFvZDn5ko5rAYTcXhT2Yd6Oj6u8aMM2KniE9GnFhjMPXNAKfrR06qAX0AO28Qy91x
         X6eg==
X-Forwarded-Encrypted: i=1; AJvYcCUPdo9Q7LkbfSgi+TO7m7v/Flq8+Ewgk7wVfXFtxvwI2de5DklwyNkmiLoEe2U5ggnc2xuKkKd3wNa4NROz@vger.kernel.org, AJvYcCVMHMQPjADhQOdVQUBUJmvefv5uImuQ8DzTBIFE/byiAlLX/DansD1dLP7R+0V3b2X7oCwIUtAXHe/rP3DK@vger.kernel.org, AJvYcCWtQQ2nBd/ETgW3245Nz+zsgjhuCcSrxFaNljFDP8w41pX0+E0GwALgrYFGMyowD2ObTKVccGBCjY5y@vger.kernel.org
X-Gm-Message-State: AOJu0YwrixpthhTTGRKEuNSwXmBFFmwFNJx1gbLH2rAnhL9+JFU2GPwi
	DdLymttjOVLn9bKM07iRYf+pYAxkDd2PI8bCrT0P7f3UB0uwuzLfrE8XEQ==
X-Google-Smtp-Source: AGHT+IFvBXXEwRZVLBxrBILRwzW4fyBoCgYJK/vQhrznmNSVK3x7a6+l9bayJAPsY5OOgiCyy59l0g==
X-Received: by 2002:a05:6870:b493:b0:288:461d:e1da with SMTP id 586e51a60fabf-2949f0b2876mr2125524fac.41.1730443873513;
        Thu, 31 Oct 2024 23:51:13 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([203.81.243.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8971sm2196209b3a.12.2024.10.31.23.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:51:12 -0700 (PDT)
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
Subject: [PATCH v4 0/4] ext4: Add atomic writes support for DIO
Date: Fri,  1 Nov 2024 12:20:50 +0530
Message-ID: <cover.1730437365.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 -> v4:
=========
1. Patch-1 changes the helper function from ext4_can_atomic_write() to
   ext4_inode_can_atomic_write() based on suggestions from Darrick and John.
   Patch-3 then goes and uses it.
2. Patch-4 adds an inline helper ext4_want_directio_fallback() which simplifies
   the logic checks and inherently fixes condition on when to return -ENOTBLK
   which otherwise was always returning true for any write or directio in
   ext4_iomap_end(). It was ok since ext4 only supports direct-io via iomap.
[v3]: https://lore.kernel.org/linux-xfs/cover.1730286164.git.ritesh.list@gmail.com/

(Note as mentioned below as well this is built on top of John XFS atomic series [2])
[2]: https://lore.kernel.org/linux-xfs/20241019125113.369994-1-john.g.garry@oracle.com/


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

 fs/ext4/ext4.h  | 10 ++++++++++
 fs/ext4/file.c  | 24 ++++++++++++++++++++++++
 fs/ext4/inode.c | 39 ++++++++++++++++++++++++++++++++++-----
 fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 5 deletions(-)

--
2.46.0


