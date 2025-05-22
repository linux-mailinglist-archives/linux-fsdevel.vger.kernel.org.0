Return-Path: <linux-fsdevel+bounces-49606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A518EAC00E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 02:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15B01BC3CA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 00:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D00D3D76;
	Thu, 22 May 2025 00:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4S7MFPH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E26EC5;
	Thu, 22 May 2025 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872145; cv=none; b=b8729xii2EUCzu7yy20o99MWEA2FQEZ4ZfEsOoJ3DB3GuLE0WV0PxVPgGNPsUEgjRanWF/4ysGVQESt2Dm0OYl6TRG4HRAQciHEQFAkqEsguMpz9V4LvA3qahi0GkCGAvVmuh/ShRumdwRAacwa5uJiOUp5aWv7WcwpDPjz5kPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872145; c=relaxed/simple;
	bh=CccOEkaJJ87vAKsVhEpP5o2VkX2o8exAwv9wCbU7ocY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mv5drA1YEsCCe/C9AmFS5a216PI21377w4ltpMB/hVtiJX3egLmoGYxkcKYpHtHR+GbxEosazWRcEQahQXy6FOOPNMvOrDF1hLyUgCxdjU/10Pg77ZUYt+VUyIMSa3/E/HmVZgPYRHtwwakSGwWIgcyWeiJVCO5t3Kw/Xa5jdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4S7MFPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F21EC4CEE4;
	Thu, 22 May 2025 00:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872145;
	bh=CccOEkaJJ87vAKsVhEpP5o2VkX2o8exAwv9wCbU7ocY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C4S7MFPH9X5QAdvgQT9k6KtxLrNl/pMFx6JPKB23t4LvQLk+pLZrr2HlzYVdogrLE
	 yPaijPm1bPZzFNLiIoNkTUe14Q+b0f+VeP3kjwYFkocUfvv80DFQMNSwAvyvyQDSZk
	 T4hEwVIeaSxYbd8KRdMXuxYaG9S4KY8XP3L9uMGlCmkwdr77aPC6+ba+aeLJ8dAYot
	 1B+R2yhqj3h18HN5SuINIWLkayTtR1ey/zmSRdL5Tx7xktZv+2lgtJtkIZWeB3nhDb
	 8eFIo5mnwJ+sTVCiRKZUEL++rItLavBfi/57iOWeCcyY9U9ui+B8bwXQF2Rw5YvZ2b
	 Kh2TaUY4gJKvA==
Date: Wed, 21 May 2025 17:02:25 -0700
Subject: [PATCHSET RFC[RAP] 3/3] fuse2fs: use fuse iomap data paths for better
 file I/O performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, linux-ext4@vger.kernel.org, miklos@szeredi.hu,
 joannelkoong@gmail.com, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Message-ID: <174787198370.1484996.3340565971108603226.stgit@frogsfrogsfrogs>
In-Reply-To: <20250521235837.GB9688@frogsfrogsfrogs>
References: <20250521235837.GB9688@frogsfrogsfrogs>
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

iomap mode also calls FUSE_DESTROY before unmounting the filesystem, so
for capable systems, fuse2fs doesn't need to run in fuseblk mode
anymore.

However, there are some major warts remaining:

1. The iomap cookie validation is not present, which can lead to subtle
races between pagecache zeroing and writeback on filesystems that
support unwritten and delalloc mappings.

2. Mappings ought to be cached in the kernel for more speed.

3. iomap doesn't support things like fscrypt or fsverity, and I haven't
yet figured out how inline data is supposed to work.

4. I would like to be able to turn on fuse+iomap on a per-inode basis,
which currently isn't possible because the kernel fuse driver will iget
inodes prior to calling FUSE_GETATTR to discover the properties of the
inode it just read.

5. ext4 doesn't support out of place writes so I don't know if that
actually works correctly.

6. iomap is an inode-based service, not a file-based service.  This
means that we /must/ push ext2's inode numbers into the kernel via
FUSE_GETATTR so that it can report those same numbers back out through
the FUSE_IOMAP_* calls.  However, the fuse kernel uses a separate nodeid
to index its incore inode, so we have to pass those too so that
notifications work properly.

I'll work on these in June, but for now here's an unmergeable RFC to
start some discussion.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-iomap
---
Commits in this patchset:
 * fuse2fs: implement bare minimum iomap for file mapping reporting
 * fuse2fs: register block devices for use with iomap
 * fuse2fs: always use directio disk reads with fuse2fs
 * fuse2fs: implement directio file reads
 * fuse2fs: use tagged block IO for zeroing sub-block regions
 * fuse2fs: only flush the cache for the file under directio read
 * fuse2fs: add extent dump function for debugging
 * fuse2fs: implement direct write support
 * fuse2fs: turn on iomap for pagecache IO
 * fuse2fs: flush and invalidate the buffer cache on trim
 * fuse2fs: improve tracing for fallocate
 * fuse2fs: don't zero bytes in punch hole
 * fuse2fs: don't do file data block IO when iomap is enabled
 * fuse2fs: disable most io channel flush/invalidate in iomap pagecache mode
 * fuse2fs: re-enable the block device pagecache for metadata IO
 * fuse2fs: avoid fuseblk mode if fuse-iomap support is likely
---
 configure       |   47 ++
 configure.ac    |   32 +
 lib/config.h.in |    3 
 misc/fuse2fs.c  | 1251 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 1312 insertions(+), 21 deletions(-)


