Return-Path: <linux-fsdevel+bounces-65988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CF6C17957
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340A91C80C97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8522D0C6C;
	Wed, 29 Oct 2025 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRrspJ8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C563226CE25;
	Wed, 29 Oct 2025 00:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698479; cv=none; b=ucfOt0CF+j51Jr9S5rlSw2ZqqVvxUGkRTdeoj5Dmnmyw25I3d4j6fL2zg8BvnbsBMk2miwTVLYY9Yhr1G5PCuJF1JbXmvcxYIpuOqjSUgDSMf2cvOQ/TKykQIPV/VReSEYnQm4fZPhEEj2CjV49m1ZuKNwxmIMiXozILOmU7vRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698479; c=relaxed/simple;
	bh=Nhob9g/OpLMLMKTVFTWkCNU2SobhVKUVLH4d89rfXN4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwSSS2OMFX0Jv12stbYxyFvcu72Z/U6Ajhb8Q6/WeoQokhQcHxy6b8C3tg5n85DLsdDpl23hFnSgLKzs377Zs5T64Lcw1cAulH18GTBkvGGj3vcJPBsFwluy+z0uHhY+EysZcOMOSsq5x602g7+GKyG4AgNRdw/eUpXUaNLZm7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRrspJ8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A26C4CEE7;
	Wed, 29 Oct 2025 00:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698479;
	bh=Nhob9g/OpLMLMKTVFTWkCNU2SobhVKUVLH4d89rfXN4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oRrspJ8dby5s7uYZL+rc0JIvOnzj9rW8IDqdo2uVdY7S+qJVHXPbxLhXjj7ZEbd45
	 JsOz6PkPI73RHaMP96NClbqINm+L9hp2RMgfduglFjxxWfXa87BHN00/K99NEi6+Oj
	 nIMo1M2gJDPVZzuv/jIMepQM+Bz0NNB8Q3b1uP/4JxwAfmfBFoLwWn6Ckhdbn0T66U
	 UX94kh8rHx7fbhJ4E6HuKH0dSfj5aa9jKveTDe/bG3hj9+HPAi3ylSf8JUB+L4DB2V
	 BNDIbz43zT9f/HkKJSOI+DF5nhDkCtyfr0GFXEVxwJER1S8jG8dyeFpCF6kUE6vkTn
	 yO8AnnHZaZ2Dg==
Date: Tue, 28 Oct 2025 17:41:18 -0700
Subject: [PATCHSET v6 1/6] fuse2fs: use fuse iomap data paths for better file
 I/O performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169817482.1429568.16747148621305977151.stgit@frogsfrogsfrogs>
In-Reply-To: <20251029002755.GK6174@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
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

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-iomap-fileio
---
Commits in this patchset:
 * fuse2fs: implement bare minimum iomap for file mapping reporting
 * fuse2fs: add iomap= mount option
 * fuse2fs: implement iomap configuration
 * fuse2fs: register block devices for use with iomap
 * fuse2fs: implement directio file reads
 * fuse2fs: add extent dump function for debugging
 * fuse2fs: implement direct write support
 * fuse2fs: turn on iomap for pagecache IO
 * fuse2fs: don't zero bytes in punch hole
 * fuse2fs: don't do file data block IO when iomap is enabled
 * fuse2fs: try to create loop device when ext4 device is a regular file
 * fuse2fs: enable file IO to inline data files
 * fuse2fs: set iomap-related inode flags
 * fuse2fs: configure block device block size
 * fuse4fs: separate invalidation
 * fuse2fs: implement statx
 * fuse2fs: enable atomic writes
---
 configure            |   88 ++
 configure.ac         |   54 +
 fuse4fs/fuse4fs.1.in |    6 
 fuse4fs/fuse4fs.c    | 1780 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/config.h.in      |    6 
 misc/fuse2fs.1.in    |    6 
 misc/fuse2fs.c       | 1845 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 3761 insertions(+), 24 deletions(-)


