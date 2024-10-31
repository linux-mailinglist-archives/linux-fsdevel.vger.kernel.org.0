Return-Path: <linux-fsdevel+bounces-33378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B649B85D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 23:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0971C22252
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B211CEABA;
	Thu, 31 Oct 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeE8aZve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E019B3CB;
	Thu, 31 Oct 2024 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412108; cv=none; b=ByrYHWKwzTuRurI29ezyGxPO74MDpKrn8LAj33wa2TEEokis0heYKN/0n8wLiCthcoah4G1zB45fUABrDDn7ewpIGkdeG6VA0J49FJK1Oo9zWeBh2lVho8Jxy5WvBbTQdT+rwKOfB3fhL/7zZhVrkXpQrrGDLovfpMYaTPaoeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412108; c=relaxed/simple;
	bh=+KErsZIPojez5gVdFx2LEHdy76Mrm3FGs9JwwUfXIEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7Rqciu0OQRSguBJlc81+s/sbUNWicRlonXwVJricGwNdVz2bjcJwPcl3PWG0hbCJdpr7FoqwMmsD+trrw8wgKULpeaIyKSGauqAG05m+XGSCZX5AUUNmuHYyZokscBoT+b7cFEXfad3THQCOz3nF9vcVhXozBOLkXUTqT4Negs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeE8aZve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAF1C4CEC3;
	Thu, 31 Oct 2024 22:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730412108;
	bh=+KErsZIPojez5gVdFx2LEHdy76Mrm3FGs9JwwUfXIEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeE8aZveFfL156p2krInUvKCQyF8wWe69NaroUq3U3qZn8NhyC898/4Gu6rR/u0P5
	 eAndLl74rtIntSMz8i5hu+x3tToayBjriocQDLr4wmHAihukpUyyD+kI5G6MabBM6u
	 GHjL/Ulto5cQh+IXD09D82GAcZKKIuYJXy2YCzA6ueiIFptuJONKFLSR7iDqPZY26l
	 LW20uVikDfOhfmFtorYEBs1DSmcmyERhQQna1vJ3YdouJIo8aP+lWi0gqEviDn5nGR
	 Wgv3lAhORJO32hcnwwk+8th/r95TQN/rE/CqVfeitBS8MMmlNpx2Z9QY0K/T0OwoJw
	 myPyRBGvry+Ww==
Date: Thu, 31 Oct 2024 15:01:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] ext4: Add atomic writes support for DIO
Message-ID: <20241031220147.GG21832@frogsfrogsfrogs>
References: <cover.1730286164.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730286164.git.ritesh.list@gmail.com>

On Wed, Oct 30, 2024 at 09:27:37PM +0530, Ritesh Harjani (IBM) wrote:

Assuming Ted acks this series, I have a fun question: Can we merge this
for 6.13 alongside the single-fsblock xfs implementation?

And how do we want to merge this?  It looks like Jens took only the
first three patches from John's series, leaving this:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-6.13/block-atomic

[PATCH v10 4/8] fs: Export generic_atomic_write_valid() John Garry
[PATCH v10 5/8] fs: iomap: Atomic write support John Garry
[PATCH v10 6/8] xfs: Support atomic write for statx John Garry
[PATCH v10 7/8] xfs: Validate atomic writes John Garry
[PATCH v10 8/8] xfs: Support setting FMODE_CAN_ATOMIC_WRITE John Garry

Note the fs and iomap stuff is not in that branch.

So should xfs create a 6.13 merge branch from block-atomic containing
all of its new stuff including the xfs atomic writes changes?  And then
I guess merge the ext4 changes too??  ext4 code coming in via xfs, yuck.

Or should cem just create a 6.13 merge branch with everything *except*
the atomic writes stuff?  Call that branch "xfs-6.13-merge".  Then one
of us with commit privileges creates a separate branch off of
block-atomic, add both the xfs series and then the ext4 series?  Call
that branch "fs-atomic-writes".

Then I guess cem could create a third branch from xfs-6.13-merge, merge
the fs-atomic-writes branch into that third branch, and push that third
branch to for-next on git.kernel.org so it can get picked up by
rothwell's for-next and fs-next?

(Note that Ted could do likewise with ext4; cem doesn't have to be part
of this.)

Does that work for people?  The "sending multiple branches to linus" way
is the best method I can think of, though it's more release manager
work.

--D

> v2 -> v3:
> ==========
> 1. Patch-1 adds an "experimental" string in dmesg log during mount when EXT4
>    detects that it is capable of doing DIO atomic writes on a given device
>    with min and max unit details.
> 2. Patch-4 has been updated to avoid returning -ENOTBLK (in ext4_iomap_end)
>    if the request belongs to atomic write. This patch also adds a WARN_ON_ONCE()
>    if atomic write ever fallback to buffered-io (to catch any unwanted bugs in the future).
>    More details in the commit log of patch-4.
> 3. Collected RBs tag from John for Patch 2 & 3.
> 
> [v2]: https://lore.kernel.org/linux-ext4/cover.1729944406.git.ritesh.list@gmail.com/
> 
> Previous cover letter log:
> 
> In v2, we had split the series and this one only takes care of
> atomic writes for single fsblock.
> That means for now this gets only enabled on bs < ps systems on ext4.
> Enablement of atomic writes for bigalloc (multi-fsblock support) is still
> under discussion and may require general consensus within the filesystem
> community [1].
> 
> This series adds the base feature support to enable atomic writes in
> direct-io path for ext4. We advertise the minimum and the maximum atomic
> write unit sizes via statx on a regular file.
> 
> This series allows users to utilize atomic write support using -
> 1. on bs < ps systems via - mkfs.ext4 -F -b 16384 /dev/sda
> 
> This can then be utilized using -
> 	xfs_io -fdc "pwrite -V 1 -A -b16k 0 16k" /mnt/f1
> 
> This is built on top of John's DIO atomic write series for XFS [2].
> The VFS and block layer enablement for atomic writes were merged already.
> 
> 
> [1]: https://lore.kernel.org/linux-ext4/87jzdvmqfz.fsf@gmail.com
> [2]: https://lore.kernel.org/linux-xfs/20241019125113.369994-1-john.g.garry@oracle.com/
> 
> 
> Changelogs:
> ===========
> PATCH -> PATCH v2:
> - addressed review comments from John and Darrick.
> - renamed ext4_sb_info variables names: fs_awu* -> s_awu*
> - [PATCH]: https://lore.kernel.org/linux-ext4/cover.1729825985.git.ritesh.list@gmail.com/
> 
> RFC -> PATCH:
> - Dropped RFC tag
> - Last RFC was posted a while ago but back then a lot of VFS and block layer
>   interfaces were still not merged. Those are now merged, thanks to John and
>   everyone else.
> - [RFC] - https://lore.kernel.org/linux-ext4/cover.1709356594.git.ritesh.list@gmail.com/
> 
> 
> 
> Ritesh Harjani (IBM) (4):
>   ext4: Add statx support for atomic writes
>   ext4: Check for atomic writes support in write iter
>   ext4: Support setting FMODE_CAN_ATOMIC_WRITE
>   ext4: Do not fallback to buffered-io for DIO atomic write
> 
>  fs/ext4/ext4.h  |  9 +++++++++
>  fs/ext4/file.c  | 24 ++++++++++++++++++++++++
>  fs/ext4/inode.c | 28 +++++++++++++++++++++++-----
>  fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+), 5 deletions(-)
> 
> --
> 2.46.0
> 
> 

