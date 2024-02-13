Return-Path: <linux-fsdevel+bounces-11407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041168538F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0741C26A20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D8605A7;
	Tue, 13 Feb 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7tP/T9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E8604D4;
	Tue, 13 Feb 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846631; cv=none; b=LtNxrhs3j1Z8Bs8cmg8bJYdIaztTZrNBRt7WowtRaP+1nxshYr6g7obQjQptwEKnF4PSv/i9BZc50dzCr+enBC+Qawd5g8ZAF8YwwFsZz8Q65HqLnGMcY7rl9R9k3HMqpm4FkQxZm4HjviRpFPAcDpmytrkRqiFDsTEJJ5y7zfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846631; c=relaxed/simple;
	bh=5C6J2AoGti6fVk51X5hb7PlrcA7riKG8jWDj230jXh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROXTUwYoMxFfYSXrT833LsWufV4Fk3V7BCQUGSrdcoHOvTBk4bM+wrT2gnytxe9Yr22zOgMsnGNvRclB7LiBKq8tQdD9O7B3gYxet7i+40BGgKReYFwnAO2JQgit/ahIVP5NEzr6SnQk8KVzU3tlVkAe4poxbdiUm0KgGqCgiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7tP/T9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AE4C433A6;
	Tue, 13 Feb 2024 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707846631;
	bh=5C6J2AoGti6fVk51X5hb7PlrcA7riKG8jWDj230jXh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7tP/T9iMSHjzKBiYtzmws53ZK7Z+90BzS76f/jbm7+5+7hJps4zsT41q7KJaDAS5
	 loE3MzRwneIsuAvoiTBguhrmMK5rots642mz0UaK89wWIt9RPsyOkb1zHhKelntdW1
	 oDKUyvWXMOGY4MjZeaQfl9QdWY6PmvFmMKhbkO93GdJIqqgpp+9KNUEHF0VHNBu9hH
	 eo2R49cMH048iwhFuhuW7iynhDkCj3f52bZzBjnSkDb9gZgInyB8VcSQXJSq37oFd4
	 MP0sp0Wvk1jnE9gJ5DiSZD8xWWg7vlKiH/nuos+6Vn57F6PnOe+bL/ZOzLY07pG/1p
	 yJwJZWp+13smw==
Date: Tue, 13 Feb 2024 09:50:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
Message-ID: <20240213175030.GC6184@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-6-john.g.garry@oracle.com>
 <20240202184758.GA6226@frogsfrogsfrogs>
 <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>

On Mon, Feb 05, 2024 at 01:36:03PM +0000, John Garry wrote:
> On 02/02/2024 18:47, Darrick J. Wong wrote:
> > On Wed, Jan 24, 2024 at 02:26:44PM +0000, John Garry wrote:
> > > Ensure that when creating a mapping that we adhere to all the atomic
> > > write rules.
> > > 
> > > We check that the mapping covers the complete range of the write to ensure
> > > that we'll be just creating a single mapping.
> > > 
> > > Currently minimum granularity is the FS block size, but it should be
> > > possibly to support lower in future.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > > I am setting this as an RFC as I am not sure on the change in
> > > xfs_iomap_write_direct() - it gives the desired result AFAICS.
> > > 
> > >   fs/xfs/xfs_iomap.c | 41 +++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 41 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index 18c8f168b153..758dc1c90a42 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -289,6 +289,9 @@ xfs_iomap_write_direct(
> > >   		}
> > >   	}
> > > +	if (xfs_inode_atomicwrites(ip))
> > > +		bmapi_flags = XFS_BMAPI_ZERO;
> > 
> > Why do we want to write zeroes to the disk if we're allocating space
> > even if we're not sending an atomic write?
> > 
> > (This might want an explanation for why we're doing this at all -- it's
> > to avoid unwritten extent conversion, which defeats hardware untorn
> > writes.)
> 
> It's to handle the scenario where we have a partially written extent, and
> then try to issue an atomic write which covers the complete extent. In this
> scenario, the iomap code will issue 2x IOs, which is unacceptable. So we
> ensure that the extent is completely written whenever we allocate it. At
> least that is my idea.
> 
> > 
> > I think we should support IOCB_ATOMIC when the mapping is unwritten --
> > the data will land on disk in an untorn fashion, the unwritten extent
> > conversion on IO completion is itself atomic, and callers still have to
> > set O_DSYNC to persist anything.
> 
> But does this work for the scenario above?
> 
> > Then we can avoid the cost of
> > BMAPI_ZERO, because double-writes aren't free.
> 
> About double-writes not being free, I thought that this was acceptable to
> just have this write zero when initially allocating the extent as it should
> not add too much overhead in practice, i.e. it's one off.
> 
> > 
> > > +
> > >   	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
> > >   			rblocks, force, &tp);
> > >   	if (error)
> > > @@ -812,6 +815,44 @@ xfs_direct_write_iomap_begin(
> > >   	if (error)
> > >   		goto out_unlock;
> > > +	if (flags & IOMAP_ATOMIC) {
> > > +		xfs_filblks_t unit_min_fsb, unit_max_fsb;
> > > +		unsigned int unit_min, unit_max;
> > > +
> > > +		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
> > > +		unit_min_fsb = XFS_B_TO_FSBT(mp, unit_min);
> > > +		unit_max_fsb = XFS_B_TO_FSBT(mp, unit_max);
> > > +
> > > +		if (!imap_spans_range(&imap, offset_fsb, end_fsb)) {
> > > +			error = -EINVAL;
> > > +			goto out_unlock;
> > > +		}
> > > +
> > > +		if ((offset & mp->m_blockmask) ||
> > > +		    (length & mp->m_blockmask)) {
> > > +			error = -EINVAL;
> > > +			goto out_unlock;
> > > +		}
> > > +
> > > +		if (imap.br_blockcount == unit_min_fsb ||
> > > +		    imap.br_blockcount == unit_max_fsb) {
> > > +			/* ok if exactly min or max */
> > > +		} else if (imap.br_blockcount < unit_min_fsb ||
> > > +			   imap.br_blockcount > unit_max_fsb) {
> > > +			error = -EINVAL;
> > > +			goto out_unlock;
> > > +		} else if (!is_power_of_2(imap.br_blockcount)) {
> > > +			error = -EINVAL;
> > > +			goto out_unlock;
> > > +		}
> > > +
> > > +		if (imap.br_startoff &&
> > > +		    imap.br_startoff & (imap.br_blockcount - 1)) {
> > 
> > Not sure why we care about the file position, it's br_startblock that
> > gets passed into the bio, not br_startoff.
> 
> We just want to ensure that the length of the write is valid w.r.t. to the
> offset within the extent, and br_startoff would be the offset within the
> aligned extent.

Yes, I understand what br_startoff is, but this doesn't help me
understand why this code is necessary.  Let's say you have a device that
supports untorn writes of 16k in length provided the LBA of the write
command is also aligned to 16k, and the fs has 4k blocks.

Userspace issues an 16k untorn write at offset 13k in the file, and gets
this mapping:

[startoff: 13k, startblock: 16k, blockcount: 16k]

Why should this IO be rejected?  The physical space extent satisfies the
alignment requirements of the underlying device, and the logical file
space extent does not need aligning at all.

> > I'm also still not convinced that any of this validation is useful here.
> > The block device stack underneath the filesystem can change at any time
> > without any particular notice to the fs, so the only way to find out if
> > the proposed IO would meet the alignment constraints is to submit_bio
> > and see what happens.
> 
> I am not sure what submit_bio() would do differently. If the block device is
> changing underneath the block layer, then there is where these things need
> to be checked.

Agreed.

> > 
> > (The "one bio per untorn write request" thing in the direct-io.c patch
> > sound sane to me though.)
> > 
> 
> ok
> 
> Thanks,
> John
> 

