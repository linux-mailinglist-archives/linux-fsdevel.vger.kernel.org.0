Return-Path: <linux-fsdevel+bounces-49602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C322AC00D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 01:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE348C46AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 23:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ECF23DEAD;
	Wed, 21 May 2025 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmRjjF2Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CFDF58;
	Wed, 21 May 2025 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747871918; cv=none; b=sZS9noGY5SOqNaT9/bueJK+BdFUk07MiHUJzEmmspySRnImOt9zlT2UVrtzhew2Z5RTldZikJIl3k1js7clBCumSZ1HAPP45Bp4FVALXwFfyQ7dJ0a9JbRo1kE46cGDm+P9y+RbrCwBNfNgH2wr0D91fci8b/I7RI5u596EpRLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747871918; c=relaxed/simple;
	bh=XxnITmLEgTxgxgky1YBwl8m3pp6pz5NHYObmexV15vc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mpf3ZGYMiNav/ksaKmj5XYEOAsMfQKgNPdN5H2La81cyVfhX6Pl4GILfuhuup/odJpX8cXdxh5YbxUvg2YzUd/yxh0kZmVKs6OwkdJqCTpf87a5zPUulX/lewTJU+qryM8PzC8LfP/OoKldPQRM5AK8kGnfh8nRqV9hG+HqVkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmRjjF2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFC8C4CEE4;
	Wed, 21 May 2025 23:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747871918;
	bh=XxnITmLEgTxgxgky1YBwl8m3pp6pz5NHYObmexV15vc=;
	h=Date:From:To:Cc:Subject:From;
	b=MmRjjF2Q0TpLehJi00JUQrnClsvlGwi+kwzU5i9q1jCCokPtFSS838j4Ut12vEOqy
	 vs025p+xy9hbvZCXEns6tSHJ3//QVQRzpocwGiFRLdvUA6+PvYdJTSjkW42oVRasxQ
	 8Mnrpjc7vdF+2OOQ94WUr+mMQzihXb4DCatmsD7ta0mIM+8Y8H+KdQvOIG4lqs862d
	 YyZ3yqIQLUwlriy8ijBRixS+hozsxCcYCruX/vw8NqYOg2swcY9vQA981x00wJ5gsh
	 HxqXf/vGwCSpsMzWqvJpj8gFm0H76+q6sJOOiMF45ysGJnPjerCcEvn4yAyKCmYkS9
	 EvRiCWZQaQK/Q==
Date: Wed, 21 May 2025 16:58:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: John@groves.net, bernd@bsbernd.com, miklos@szeredi.hu,
	joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250521235837.GB9688@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

DO NOT MERGE THIS.

This is the very first request for comments of a prototype to connect
the Linux fuse driver to fs-iomap for regular file IO operations to and
from files whose contents persist to locally attached storage devices.

Why would you want to do that?  Most filesystem drivers are seriously
vulnerable to metadata parsing attacks, as syzbot has shown repeatedly
over almost a decade of its existence.  Faulty code can lead to total
kernel compromise, and I think there's a very strong incentive to move
all that parsing out to userspace where we can containerize the fuse
server process.

willy's folios conversion project (and to a certain degree RH's new
mount API) have also demonstrated that treewide changes to the core
mm/pagecache/fs code are very very difficult to pull off and take years
because you have to understand every filesystem's bespoke use of that
core code.  Eeeugh.

The fuse command plumbing is very simple -- the ->iomap_begin,
->iomap_end, and iomap ioend calls within iomap are turned into upcalls
to the fuse server via a trio of new fuse commands.  This is suitable
for very simple filesystems that don't do tricky things with mappings
(e.g. FAT/HFS) during writeback.  This isn't quite adequate for ext4,
but solving that is for the next sprint.

With this overly simplistic RFC, I am to show that it's possible to
build a fuse server for a real filesystem (ext4) that runs entirely in
userspace yet maintains most of its performance.  At this early stage I
get about 95% of the kernel ext4 driver's streaming directio performance
on streaming IO, and 110% of its streaming buffered IO performance.
Random buffered IO suffers a 90% hit on writes due to unwritten extent
conversions.  Random direct IO is about 60% as fast as the kernel; see
the cover letter for the fuse2fs iomap changes for more details.

There are some major warts remaining:

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

--Darrick

