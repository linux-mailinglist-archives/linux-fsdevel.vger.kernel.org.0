Return-Path: <linux-fsdevel+bounces-45919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31749A7F0F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 01:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97097A515A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 23:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC57228C9D;
	Mon,  7 Apr 2025 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5QgOnqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07229801;
	Mon,  7 Apr 2025 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744068609; cv=none; b=NzHeJtWWBzZY1M6YKNCWBsK/jsW7zoBlOHKLzclri7ISyyJGyy0P+wN0MMqP3XxWIHTiWc0s/+HivQ67WXytgk4JCPq2oYT0HTurJmgGq+aOK0p0j/JuLX7mr/tSDmqBE+7Kl/0LNhcSiDy2yxQVJMZKCekVQo0p4bMHFFC/psU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744068609; c=relaxed/simple;
	bh=VgglbjWzZgjBVmrkLpMQn6t7LoBGPGEKe9mwRMqCLvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kyt+OMe1eJyCFdgWh7QIPYi+AN5CF0PZhQque0RiH6jrPaN7KvpKLKhamlSlKUgkODXws44hVVSa2kfifwhP4vDq12U9u1KbYssXmQol81r5XOka/KGNnzwt+TLZYm2FdTmpWxkgwLAcHAUAsBnRnDl613/tsMlL9WHUDIpRFn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5QgOnqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70676C4CEDD;
	Mon,  7 Apr 2025 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744068608;
	bh=VgglbjWzZgjBVmrkLpMQn6t7LoBGPGEKe9mwRMqCLvk=;
	h=Date:From:To:Cc:Subject:From;
	b=o5QgOnqbfuFV/GznkOwnyxvPlgvSqA+urdqUaR9KMDweAgS3IcdzSxOXAH+q3GWsW
	 tt2K/8sleT9W1VXpO/e+/a4ago9ZLe9/NPKhSYofIaegUTynlsaCwoAjxYbiGKqU7k
	 0QG/RO2xIPY6iM+P9VhPFV52LAs0s2wHwKbyZDKPZshqBfMWma/f5mKxQEEoXdDShe
	 hTnThm777IjBoKanTg032Vw/1ypJrQmXGnUrvi8FFRid0Ntvt4S9jJmLSs02rGNAY+
	 Ns/sqBLCCGW0V6PXq398UrrQgudBZgg+F5ljAea9Ew2Nd2jejIplBmJYHptx40PGXZ
	 L4K248ieczVMA==
Date: Mon, 7 Apr 2025 16:30:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, dlemoal@kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Weird loop device behavior in 6.15-rc1?
Message-ID: <20250407233007.GG6266@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Christoph,

I have a ... weird test setup where loop devices have directio enabled
unconditionally on a system with 4k-lba disks, and now that I pulled
down 6.15-rc1, I see failures in xfs/259:

--- /run/fstests/bin/tests/xfs/259.out	2025-01-30 10:00:17.074275830 -0800
+++ /var/tmp/fstests/xfs/259.out.bad	2025-04-06 19:34:56.587315490 -0700
@@ -1,17 +1,428 @@
 QA output created by 259
 Trying to make (4TB - 4096B) long xfs, block size 4096
 Trying to make (4TB - 4096B) long xfs, block size 2048
+block size 2048 cannot be smaller than sector size 4096

I think bugs in the loop driver's O_DIRECT handling are responsible for
this.  I boiled it down to the key commands so that you don't have to
set up a bunch of hardware.

First, some setup:

# losetup -f --direct-io=on --sector-size 4096 --show /dev/sda
# mkfs.xfs -f /dev/sda
# mount /dev/sda /mnt

On 6.14 and 6.15-rc1, if I create the loop device with directio mode
and try to turn it off so that I can reduce the block size:

# truncate -s 30g /mnt/a
# losetup --direct-io=on -f --show /mnt/a
/dev/loop1
# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 1 4096

# losetup --sector-size 2048 /dev/loop1
# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 0 2048

# losetup --direct-io=off /dev/loop1
# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 0 2048

# losetup --sector-size 2048 /dev/loop1
# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 0 2048

(yes, that is a weird sequence)

Then trying to format an XFS filesystem fails:

# mkfs.xfs -f /dev/loop1 -b size=2k -K
meta-data=/dev/loop1             isize=512    agcount=4, agsize=393216 blks
         =                       sectsz=2048  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
         =                       exchange=0   metadir=0
data     =                       bsize=2048   blocks=1572864, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=0
log      =internal log           bsize=2048   blocks=32768, version=2
         =                       sectsz=2048  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
         =                       rgcount=0    rgsize=0 extents
mkfs.xfs: pwrite failed: Input/output error

I think there's a bug in the loop driver where changing
LO_FLAGS_DIRECT_IO doesn't actually try to change the O_DIRECT state of
the underlying lo->lo_backing_file->f_flags.  So I can try to set a 2k
block size on the loop dev, which turns off LO_FLAGS_DIRECT_IO but the
fd is still open O_DIRECT so the writes fail.  But this isn't a
regression in -rc1, so maybe this is the expected behavior?

/me notes that going the opposite direction (turning directio on after
creation) fails:

# losetup --direct-io=on /dev/loop2
losetup: /dev/loop2: set direct io failed: Invalid argument

At least the loopdev stays in buffered mode and mkfs runs fine.

But now let's try passing in "0" to losetup --sector-size to set the
sector size to the minimum value.  On 6.14, this happens:

# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 1 4096

# losetup --sector-size 0 /dev/loop1
# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 1 4096

# losetup --direct-io=off /dev/loop1
# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 0 4096

# losetup --sector-size 0 /dev/loop1
# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 1 4096

Notice that the loopdev never changes block size, so mkfs fails:

# mkfs.xfs -f /dev/loop1 -b size=2k -K
block size 2048 cannot be smaller than sector size 4096

On 6.15-rc1, you actually /can/ change the sector size:

# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 1 4096
# losetup --sector-size 0 /dev/loop1
# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 1 4096
# losetup --direct-io=off /dev/loop1
# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 0 4096
# losetup --sector-size 0 /dev/loop1
# losetup --list --raw /dev/loop1
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop1 0 0 0 0 /mnt/a 0 512

But the backing file still has O_DIRECT on, so formatting fails:

# mkfs.xfs -f /dev/loop1 -b size=2k -K
meta-data=/dev/loop1             isize=512    agcount=4, agsize=393216 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
         =                       exchange=0   metadir=0
data     =                       bsize=2048   blocks=1572864, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=0
log      =internal log           bsize=2048   blocks=32768, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
         =                       rgcount=0    rgsize=0 extents
mkfs.xfs: pwrite failed: Input/output error

So I /think/ what's going on here is that LOOP_SET_DIRECT_IO should be
trying to set/clear O_DIRECT on the backing file.

I chose to tag you because I think commit f4774e92aab85d ("loop: take
the file system minimum dio alignment into account") is what caused the
change in the block size setting behavior.  I also see similar messages
in xfs/078 and maybe xfs/432 if I turn on zoned=1 mode.

Though as I mentioned, I think the problems with the loop driver go
deeper than that commit. :/

Thoughts?

--D

(/me notes that xfs/801 is failing across the board, and I don't know
what changed about THPs in tmpfs but clearly something's corrupting
memory.)

