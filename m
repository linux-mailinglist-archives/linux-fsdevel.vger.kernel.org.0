Return-Path: <linux-fsdevel+bounces-17977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A6C8B482C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 23:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65941C20D6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 21:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E763145B34;
	Sat, 27 Apr 2024 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="P6v6S3s+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19E63B9;
	Sat, 27 Apr 2024 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252166; cv=none; b=qR9yP7wnAVZWBbVov3mMYHfb5upXOAwzel5oXR6bZq5lyBGnPxtj2xipJ7VR5dB7nwz/GkuiUr+VnMPJrIuYUtrJ2Yqza7gHvwk1nIh8R33j99L6W9f7P99qY1kuwNs7dFsSUAyM9z1qDmjb7LuEvvhc3XmJOg5qxBzhG1m0jZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252166; c=relaxed/simple;
	bh=hRmktWpr9OzXmJVsLgrjtNWmYsntF4OYL8uwEulRmWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JrjxzZq4Gnu97uN2SyKu/e6cGsMOUnI7pWKjrBZek/ALU2nZ+t4Ujmu0tDzJjnK+tze5zvVRoC9pFnLJzmKk4vZnr1/NoTPYfuptflFOA0j3PINx5Od5giQmku8Uwn1k+9spU6xSZaJpml1TFaQUq4oOUE8kAEiuE8yhILipLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=P6v6S3s+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xRFbES86ktcJSPmzYhgNe+40m7ES/+ZCOLVjegWPQwc=; b=P6v6S3s+5bwoO+Polm3dm4kn5k
	oMSzJUHyyr5BNmrQtWd1Vrt/1wZVipxsolgdY7Icygxmi4SISOEePD93NwmOJ8JrzeY7OAKgPyYIe
	4kdVZkJhpyIiG9SKCXx3CyyBzeRwmhtJPT7So8S/nD9w8FgW1p11pFIgE4Xcw/0A8kXVbBU1whUgg
	r7CvjxlCwUP5c6bLefxTd+AbkIGUvWxwlKy96C3+umt7nusuiZZsq1rCuMx6T6EQEIcHyI+3WFz8n
	dpVxbUdR5UV/LJNuWDrWKX68voxcrv6yEmMKwxyKb6l3mMfLihouStrUoDKaV0UX8qBYUID3A6pXK
	6cDaAhmg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0pIO-006GzR-0J;
	Sat, 27 Apr 2024 21:09:20 +0000
Date: Sat, 27 Apr 2024 22:09:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCHES][RFC] set_blocksize() rework
Message-ID: <20240427210920.GR2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Any buffer-cache based filesystem is going to be FUBAR
if somebody manages to change block size of device under it,
since primitives (sb_bread(), sb_getblk(), etc.) operate in
terms of block numbers.  If block size suddenly doubles, so
will the offsets from the beginning of device.  Results are
not pretty, obviously.

	The thing that (mostly) prevents that kind of mess
is that most of the mechanisms that lead to block size
change require the device being opened exclusive.  However,
there are several exceptions that allow to do that without
an exclusive open.  Fortunately, all of them require
CAP_SYS_ADMIN, so it's not a security problem - anyone
who already has that level of access can screw the system
into the ground in any number of ways.  However, security
problems or not, that crap should be fixed.

	The series below eliminates these calls of set_blocksize()
and changes calling conventsion of set_blocksize() so that it
uses struct file * instead of struct block_device * to tell
which device to act upon.  Unlike struct block_device, struct
file has enough information to tell an exclusive open from
non-exclusive one, so we can reject the operation in non-exclusive
case.

	The branch is available at
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.set_blocksize
Individual patches in followups.

Review (and testing, obviously) would be very welcome.

Shortlog:
Al Viro (7):
      bcache_register(): don't bother with set_blocksize()
      pktcdvd: sort set_blocksize() calls out
      swapon(2)/swapoff(2): don't bother with block size
      swapon(2): open swap with O_EXCL
      swsusp: don't bother with setting block size
      btrfs_get_dev_args_from_path(): don't call set_blocksize()
      set_blocksize(): switch to passing struct file *, fail if it's not opened exclusive

Diffstat:
 block/bdev.c              | 14 ++++++++++----
 block/ioctl.c             | 21 ++++++++++++---------
 drivers/block/pktcdvd.c   |  7 +------
 drivers/md/bcache/super.c |  4 ----
 fs/btrfs/dev-replace.c    |  2 +-
 fs/btrfs/volumes.c        | 13 ++++++++-----
 fs/ext4/super.c           |  2 +-
 fs/reiserfs/journal.c     |  5 ++---
 fs/xfs/xfs_buf.c          |  2 +-
 include/linux/blkdev.h    |  2 +-
 include/linux/swap.h      |  2 --
 kernel/power/swap.c       |  7 +------
 mm/swapfile.c             | 29 ++---------------------------
 13 files changed, 40 insertions(+), 70 deletions(-)

