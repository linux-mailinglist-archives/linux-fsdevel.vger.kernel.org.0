Return-Path: <linux-fsdevel+bounces-18562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69F8BA59D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 05:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5651F24086
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2931CA9C;
	Fri,  3 May 2024 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OjgJo//a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149F1B299;
	Fri,  3 May 2024 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706319; cv=none; b=XMq8gt8xe1Ar/hNu2upEM0P4QZPttsQQkbtd5W7xhd/v81gPr1XvCrEduHLLhIhmCJJdDt4DvTpq1HpB61aWKGnDWvK54Y6Gxf0H8J35dg5wWyKd3SiZaUa7ge7DdXcv6O7NOaZomI/VgQ0VlVXt1M1ucT+jlS1gCJAYmtSFmIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706319; c=relaxed/simple;
	bh=FUU9iVfjt1Iwtk/vnvoYlu5LlKdIrGnJl89nXQBrA3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahD2PleZIB0xFkfn82ZnejuFQsh/fr2bzCzzvFIgSFz2SSaBaE8Ko4QvVTA/4L1Iejonm48N352SIlzRFkS6u9GLpWBtfL//eym46EYeD0En+Li9/hCrBI5xCuyG2sE/U0o2n6/7buOojG1KuPNSAPVrxn2N2ixoD94lCkgj+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OjgJo//a; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AD1DWCmY12Xm6FHUbR56Tj82yPsHjkXdgFTV9BSpp4E=; b=OjgJo//aBsu1n+3YSE8Rq8CrEz
	uCx2vLqnLAheat0PP105qYxUZm6q+QVvYWx8zjdxoyS7QkVqhYyNU/5+IkvMUmhu3euV39SI0f3hm
	6U/l7AifaEJs93QL3OeeaOwd3ctDL7ePIHymbvpdwMt8erXL+aVOIvZJ6KvnaSK7txkUqXJ61znt2
	azsLWNNyxdgOJ9nsfDPTIOl74amCs89DCwhnL3fKYAApNjkc++i4iV2zikDGujpXthd4+EZa0RPDa
	vT+Xto49R3aUnh8ZbM4m12IpJc5QXjq8qFCBdFus/HCf3JUbDSi0IjJ0T9hypdhF0xd6bSgN7ruqt
	KFf2JgLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2jRR-00A2Fw-0O;
	Fri, 03 May 2024 03:18:33 +0000
Date: Fri, 3 May 2024 04:18:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCHES v2][RFC] set_blocksize() rework
Message-ID: <20240503031833.GU2118490@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427210920.GR2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 27, 2024 at 10:09:20PM +0100, Al Viro wrote:
> 	Any buffer-cache based filesystem is going to be FUBAR
> if somebody manages to change block size of device under it,
> since primitives (sb_bread(), sb_getblk(), etc.) operate in
> terms of block numbers.  If block size suddenly doubles, so
> will the offsets from the beginning of device.  Results are
> not pretty, obviously.
> 
> 	The thing that (mostly) prevents that kind of mess
> is that most of the mechanisms that lead to block size
> change require the device being opened exclusive.  However,
> there are several exceptions that allow to do that without
> an exclusive open.  Fortunately, all of them require
> CAP_SYS_ADMIN, so it's not a security problem - anyone
> who already has that level of access can screw the system
> into the ground in any number of ways.  However, security
> problems or not, that crap should be fixed.
> 
> 	The series below eliminates these calls of set_blocksize()
> and changes calling conventsion of set_blocksize() so that it
> uses struct file * instead of struct block_device * to tell
> which device to act upon.  Unlike struct block_device, struct
> file has enough information to tell an exclusive open from
> non-exclusive one, so we can reject the operation in non-exclusive
> case.
> 
> 	The branch is available at
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.set_blocksize
> Individual patches in followups.
> 
> Review (and testing, obviously) would be very welcome.

Branch updated and force-pushed (same place).  Individual patches in
followups.

Changes:
* zram elimination of double-open added.
* hopefully better description of btrfs side of things.
* final commit split into switch of set_blocksize() to struct file
  and adding a check for exclusive open.
* chunk in Documentation/filesystems/porting.rst added.

Shortlog:
Al Viro (9):
      bcache_register(): don't bother with set_blocksize()
      pktcdvd: sort set_blocksize() calls out
      swapon(2)/swapoff(2): don't bother with block size
      swapon(2): open swap with O_EXCL
      zram: don't bother with reopening - just use O_EXCL for open
      swsusp: don't bother with setting block size
      btrfs_get_bdev_and_sb(): call set_blocksize() only for exclusive opens
      set_blocksize(): switch to passing struct file *
      make set_blocksize() fail unless block device is opened exclusive

Diffstat:
 Documentation/filesystems/porting.rst |  7 +++++++
 block/bdev.c                          | 14 ++++++++++----
 block/ioctl.c                         | 21 ++++++++++++---------
 drivers/block/pktcdvd.c               |  7 +------
 drivers/block/zram/zram_drv.c         | 29 +++++++----------------------
 drivers/block/zram/zram_drv.h         |  2 +-
 drivers/md/bcache/super.c             |  4 ----
 fs/btrfs/dev-replace.c                |  2 +-
 fs/btrfs/volumes.c                    | 13 ++++++++-----
 fs/ext4/super.c                       |  2 +-
 fs/reiserfs/journal.c                 |  5 ++---
 fs/xfs/xfs_buf.c                      |  2 +-
 include/linux/blkdev.h                |  2 +-
 include/linux/swap.h                  |  2 --
 kernel/power/swap.c                   |  7 +------
 mm/swapfile.c                         | 29 ++---------------------------
 16 files changed, 55 insertions(+), 93 deletions(-)

