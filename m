Return-Path: <linux-fsdevel+bounces-55311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7705B097D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EA3189031D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3F24BBEB;
	Thu, 17 Jul 2025 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv4JB/Kk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4112417C8;
	Thu, 17 Jul 2025 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794749; cv=none; b=Lf+uvxxsHiTs6fetrvPA6VuGBnNBUU5ElgT3jVo3F5Dp0CKGOrN7ows8U0xPszFbpk56dyZHYACB09Gl2G/I/RRX3jcA/XWFTaOpj9EBjBSU4cg/rHiNjRyEFSts4ywBpOU5PFCJbZm4sjeAW952qTG653qiQ/85lvFtxScw420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794749; c=relaxed/simple;
	bh=XIEiVgF7vZrfbE2Em/X//eVwwWzaKO16+tj7MGfWmuw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJDo20vQIvSNZ58yHOCwKSOEb3b442YIxmNfFSDt+1MP2xmUFcI1auqfKeMK+GVTRyziDhhH24G2h/ykkSJ9W74ANDCUnL+ZHuoC73VDoiVdDkeP68AXwKIzV410sJ18aYrW9yfj1tHQsoJmRI7emzvhnb4J7OLp86T62jsDETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv4JB/Kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0638C4CEE3;
	Thu, 17 Jul 2025 23:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794748;
	bh=XIEiVgF7vZrfbE2Em/X//eVwwWzaKO16+tj7MGfWmuw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Tv4JB/KkflKK5M6Umoj78KiIjqbGkQEZBI/5wnysjvmlBDvAtZJp/kX83fYhc+/rQ
	 Czm0QJQjGIjvxgj2tbA3nAbSZpNyMKJ5tiBT9YvxJfMvpEEm30rytcjVuiwPMGWExl
	 sd7OWAQIH6wByLVge/qK9vb1aT3FzkNzlcVKTaeLRJpgRINZ5zEaAJ4mvn+f+Jts5o
	 JNO0dBfo9UWWJvP4KFfm2xp4sVDJeaumsjcCTLjbKAzZa+IKcpjajvVeH2y2r4yLoa
	 d94GQXwqW6UxPTr3//aEfwAy0jUOjOLPWeP7elXwacC4/uZlaPxLq2hRnBKCER+Jj4
	 gFcQZjKyyi+ag==
Date: Thu, 17 Jul 2025 16:25:48 -0700
Subject: [PATCHSET RFC v3 1/3] fuse2fs: use fuse iomap data paths for better
 file I/O performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
In-Reply-To: <20250717231038.GQ2672029@frogsfrogsfrogs>
References: <20250717231038.GQ2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Switch fuse2fs to use the new iomap file data IO paths instead of
pushing it very slowly through the /dev/fuse connection.  For local
filesystems, all we have to do is respond to requests for file to device
mappings; the rest of the IO hot path stays within the kernel.  This
means that we can get rid of all file data block processing within
fuse2fs.

Because we're not pinning dirty pages through a potentially slow network
connection, we don't need the heavy BDI throttling for which most fuse
servers have become infamous.  Yes, mapping lookups for writeback can
stall, but mappings are small as compared to data and this situation
exists for all kernel filesystems as well.

The performance of this new data path is quite stunning: on a warm
system, streaming reads and writes through the pagecache go from
60-90MB/s to 2-2.5GB/s.  Direct IO reads and writes improve from the
same baseline to 2.5-8GB/s.  FIEMAP and SEEK_DATA/SEEK_HOLE now work
too.  The kernel ext4 driver can manage about 1.6GB/s for pagecache IO
and about 2.6-8.5GB/s, which means that fuse2fs is about as fast as the
kernel for streaming file IO.

Random 4k buffered IO is not so good: plain fuse2fs pokes along at
25-50MB/s, whereas fuse2fs with iomap manages 90-1300MB/s.  The kernel
can do 900-1300MB/s.  Random directio is worse: plain fuse2fs does
20-30MB/s, fuse-iomap does about 30-35MB/s, and the kernel does
40-55MB/s.  I suspect that metadata heavy workloads do not perform well
on fuse2fs because libext2fs wasn't designed for that and it doesn't
even have a journal to absorb all the fsync writes.  We also probably
need iomap caching really badly.

These performance numbers are slanted: my machine is 12 years old, and
fuse2fs is VERY poorly optimized for performance.  It contains a single
Big Filesystem Lock which nukes multi-threaded scalability.  There's no
inode cache nor is there a proper buffer cache, which means that fuse2fs
reads metadata in from disk and checksums it on EVERY ACCESS.  Sad!

Despite these gaps, this RFC demonstrates that it's feasible to run the
metadata parsing parts of a filesystem in userspace while not
sacrificing much performance.  We now have a vehicle to move the
filesystems out of the kernel, where they can be containerized so that
malicious filesystems can be contained, somewhat.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-iomap
---
Commits in this patchset:
 * fuse2fs: implement bare minimum iomap for file mapping reporting
 * fuse2fs: add iomap= mount option
 * fuse2fs: implement iomap configuration
 * fuse2fs: register block devices for use with iomap
 * fuse2fs: always use directio disk reads with fuse2fs
 * fuse2fs: implement directio file reads
 * fuse2fs: use tagged block IO for zeroing sub-block regions
 * fuse2fs: only flush the cache for the file under directio read
 * fuse2fs: add extent dump function for debugging
 * fuse2fs: implement direct write support
 * fuse2fs: turn on iomap for pagecache IO
 * fuse2fs: improve tracing for fallocate
 * fuse2fs: don't zero bytes in punch hole
 * fuse2fs: don't do file data block IO when iomap is enabled
 * fuse2fs: disable most io channel flush/invalidate in iomap pagecache mode
 * fuse2fs: re-enable the block device pagecache for metadata IO
 * fuse2fs: avoid fuseblk mode if fuse-iomap support is likely
 * fuse2fs: don't allow hardlinks for now
 * fuse2fs: enable file IO to inline data files
 * fuse2fs: set iomap-related inode flags
 * fuse2fs: add strictatime/lazytime mount options
 * fuse2fs: configure block device block size
---
 configure       |   47 ++
 configure.ac    |   32 +
 lib/config.h.in |    3 
 misc/fuse2fs.c  | 1567 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 1628 insertions(+), 21 deletions(-)


