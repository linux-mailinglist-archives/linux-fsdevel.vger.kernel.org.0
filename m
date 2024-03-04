Return-Path: <linux-fsdevel+bounces-13554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0DC870BED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 21:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D249283306
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF6C10A01;
	Mon,  4 Mar 2024 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="EWWtdYk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376CF111AD
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585774; cv=none; b=LHs1CxjN+pVtV+G8RVamJ3kEIa/wgQiBX4XBSHuuwOIMFa9HtEkpK38dowcR5BG4wY8rwYYfmEJi1xGoCADSaPjXbVS4k6AkOxmeyOcaZlNDGkZ2G0AhvzqElK6t0O5PGuAMjKlISNKqS28ycshMr0CnqffrOKuEuR7C/LOVQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585774; c=relaxed/simple;
	bh=CP0H49h6PImwBY9HzAXfxRkiMR7GOTLQlVtBFzqCp4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfLkhO5uinC3DPPCfUMhdsF+EJuHs0+N+jWrXLn1s/37yJ5Lja9KJSO7MpcRBo1C+mZY0jsaCNCD+H/maT9vsVTX/ln+ZsW2/wmnt33IZSKFqM6zD88uTbxEwHFIw2CybZGPxNxmJcDenEk1/aJ430UNN5Gyh7Vkd9N4yxI/TyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=EWWtdYk3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc29f1956cso38832695ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 12:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709585771; x=1710190571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVCNhjf4zZDdqEabUMp85XLKsFJ6OP2P3h23DUArUwA=;
        b=EWWtdYk3nPFd6hSCfJLbKGdjMWHhQ01YVbb9C1sqO2vstTDUvsTkKsUYe4Zj6UQzXP
         NGiz0P42pDrbnUahXYWSlhiFlSxaJ66ZWUhpO9EaY+grx4XOfSN+3mVnxZP/hBjs1cjY
         T7hoT6XyrYIMY6/0erBAv5IanUjW5fT4vEfurMqY5LzUzL3hsPdLTi7G4I09bUFHPl9G
         2LN5hrBb9IBKQyAM9j1wOEkqGCQDGT2Dc3Y6XNwDLE8ryf4En2FfJ2zv+QcyK5B2IE7N
         ZIwqwJvnuEVEiR+4Zza+awzjMdl2+/IpvhBU2R2u1CF5+odAfs3a8lfUp31rTvlhTsES
         7JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709585771; x=1710190571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVCNhjf4zZDdqEabUMp85XLKsFJ6OP2P3h23DUArUwA=;
        b=oBx87z9qlNGwZBGixFnmYWQAzvWsTMyZXtGX7HyKLi4JYHYTtzGF0GSF6yvNw0FKSc
         5pmd+GCruyOkNgivMk+zpojkIUwhNsknz4W5a58LsXtXZ5vTGx2u8czCdQCz/L5bFWFY
         nT+6cdWEIDoo5L8n2v+tmymVeu12m+E6FzU8BL9XljMWmNNVmTf4W7TiSlkUiH8nW2V7
         WT8SHyoFUOynYhQZTIVMJ24S3AAMX0WatndaYGKV5b3OWo1kvoDo+D9hIu3yUDKJwAqG
         3H+hlZvdZCainPgiPXV/o/XBXVvQVI8fZd1MFb8WjArr5t1dwrH2/KbQdzJBqnzSTFrU
         0bKg==
X-Gm-Message-State: AOJu0YzUTpk6jUYPskrzvALtPq9ZDyz8gmPu218KIP/LAgQxuuV4hLra
	ZmMvE2pwoIWTiX+ELqvI8+OCtnAS0BviioEuZJb3RCrYe3iOKGt2Gu3IpDCHSb4=
X-Google-Smtp-Source: AGHT+IG/9Q5UDZV9qa/PcGqEZGm21zejhEFIVtLdGJu+GHF44GLDYBrpl2XrHkq9Vf0UhBVDHUNdRg==
X-Received: by 2002:a17:902:cf0a:b0:1dc:a84c:987c with SMTP id i10-20020a170902cf0a00b001dca84c987cmr10669074plg.10.1709585771529;
        Mon, 04 Mar 2024 12:56:11 -0800 (PST)
Received: from dread.disaster.area (pa49-181-192-230.pa.nsw.optusnet.com.au. [49.181.192.230])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001dc0d1fb3b1sm8935406plh.58.2024.03.04.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:56:11 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhFM0-00F3zC-0B;
	Tue, 05 Mar 2024 07:56:08 +1100
Date: Tue, 5 Mar 2024 07:56:08 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/8] iomap: Add atomic write support for direct-io
Message-ID: <ZeY1aEce6rZwGeV1@dread.disaster.area>
References: <ZeUhCbT4sbucOT3L@dread.disaster.area>
 <87frx64l3v.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frx64l3v.fsf@doe.com>

On Mon, Mar 04, 2024 at 11:03:24AM +0530, Ritesh Harjani wrote:
> Dave Chinner <david@fromorbit.com> writes:
> 
> > On Sat, Mar 02, 2024 at 01:12:00PM +0530, Ritesh Harjani (IBM) wrote:
> >> This adds direct-io atomic writes support in iomap. This adds -
> >> 1. IOMAP_ATOMIC flag for iomap iter.
> >> 2. Sets REQ_ATOMIC to bio opflags.
> >> 3. Adds necessary checks in iomap_dio code to ensure a single bio is
> >>    submitted for an atomic write request. (since we only support ubuf
> >>    type iocb). Otherwise return an error EIO.
> >> 4. Adds a common helper routine iomap_dio_check_atomic(). It helps in
> >>    verifying mapped length and start/end physical offset against the hw
> >>    device constraints for supporting atomic writes.
> >> 
> >> This patch is based on a patch from John Garry <john.g.garry@oracle.com>
> >> which adds such support of DIO atomic writes to iomap.
> 
> Please note this comment above. I will refer this in below comments.
> 
> >> 
> >> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  fs/iomap/direct-io.c  | 75 +++++++++++++++++++++++++++++++++++++++++--
> >>  fs/iomap/trace.h      |  3 +-
> >>  include/linux/iomap.h |  1 +
> >>  3 files changed, 75 insertions(+), 4 deletions(-)
> >
> > Ugh. Now we have two competing sets of changes to bring RWF_ATOMIC
> > support to iomap. One from John here:
> 
> Not competing changes (and neither that was the intention). As you see I have
> commented above saying that this patch is based on a previous patch in
> iomap from John. 

That's not the same as co-ordinating development or collaboration on
common aspects of the functionality required.

> So why did I send this one?  
> 1. John's latest patch series v5 was on "block atomic writes" [1], which
> does not have these checks in iomap (as it was not required). 
> 
> 2. For sake of completeness for ext4 atomic write support, I needed to
> include this change along with this series. I have also tried to address all
> the review comments he got on [2] (along with an extra function iomap_dio_check_atomic())
> 
> [1]: https://lore.kernel.org/all/20240226173612.1478858-1-john.g.garry@oracle.com/
> [2]: https://lore.kernel.org/linux-fsdevel/20240124142645.9334-1-john.g.garry@oracle.com/

Yes, but you've clearly not seen the feedback that John has been
given because otherwise you would not have implemented things the
way you did.

That's my point - you're operating in isolation, and forcing
reviewers now to deal with two separate patch sets with overlapping
funcitonality and similar problems.

> > https://lore.kernel.org/linux-fsdevel/20240124142645.9334-1-john.g.garry@oracle.com/
> >
> > and now this one.
> >
> > Can the two of you please co-ordinate your efforts and based your
> > filesysetm work off the same iomap infrastructure changes?
> 
> Sure Dave, make sense. But we are cc'ing each other in this effort
> together so that we are aware of what is being worked upon. 

"ccing each other" is not the same as actively collaborating on
development.

> And as I mentioned, this change is not competing with John's change. If
> at all it is only complementing his initial change, since this iomap change
> addresses review comments from others on the previous one and added one
> extra check (on mapped physical extent) which I wanted people to provide feedback on.
> 
> >
> > .....
> >
> >> @@ -356,6 +360,11 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >>  	if (need_zeroout) {
> >>  		/* zero out from the start of the block to the write offset */
> >>  		pad = pos & (fs_block_size - 1);
> >> +		if (unlikely(pad && atomic_write)) {
> >> +			WARN_ON_ONCE("pos not atomic write aligned\n");
> >> +			ret = -EINVAL;
> >> +			goto out;
> >> +		}
> >
> > This atomic IO should have been rejected before it even got to
> > the layers where the bios are being built. If the IO alignment is
> > such that it does not align to filesystem allocation constraints, it
> > should be rejected at the filesystem ->write_iter() method and not
> > even get to the iomap layer.
> 
> I had added this mainly from iomap sanity checking perspective. 
> We are offloading some checks to be made by the filesystem before
> submitting the I/O request to iomap. 
> These "common" checks in iomap layer are mainly to provide sanity checking
> to make sure FS did it's job, before iomap could form/process the bios and then
> do submit_bio to the block layer. 

If you read the feedback John had been given, you'd know that
alignment verification for atomic writes belongs in the filesystem
before it even calls into iomap. See these two patches in the XFS
series he just sent out:

https://lore.kernel.org/linux-xfs/20240304130428.13026-11-john.g.garry@oracle.com/T/#u
https://lore.kernel.org/linux-xfs/20240304130428.13026-14-john.g.garry@oracle.com/T/#u

> > .....
> >
> >> @@ -516,6 +535,44 @@ static loff_t iomap_dio_iter(const struct iomap_iter *iter,
> >>  	}
> >>  }
> >>  
> >> +/*
> >> + * iomap_dio_check_atomic:	DIO Atomic checks before calling bio submission.
> >> + * @iter:			iomap iterator
> >> + * This function is called after filesystem block mapping and before bio
> >> + * formation/submission. This is the right place to verify hw device/block
> >> + * layer constraints to be followed for doing atomic writes. Hence do those
> >> + * common checks here.
> >> + */
> >> +static bool iomap_dio_check_atomic(struct iomap_iter *iter)
> >> +{
> >> +	struct block_device *bdev = iter->iomap.bdev;
> >> +	unsigned long long map_len = iomap_length(iter);
> >> +	unsigned long long start = iomap_sector(&iter->iomap, iter->pos)
> >> +						<< SECTOR_SHIFT;
> >> +	unsigned long long end = start + map_len - 1;
> >> +	unsigned int awu_min =
> >> +			queue_atomic_write_unit_min_bytes(bdev->bd_queue);
> >> +	unsigned int awu_max =
> >> +			queue_atomic_write_unit_max_bytes(bdev->bd_queue);
> >> +	unsigned long boundary =
> >> +			queue_atomic_write_boundary_bytes(bdev->bd_queue);
> >> +	unsigned long mask = ~(boundary - 1);
> >> +
> >> +
> >> +	/* map_len should be same as user specified iter->len */
> >> +	if (map_len < iter->len)
> >> +		return false;
> >> +	/* start should be aligned to block device min atomic unit alignment */
> >> +	if (!IS_ALIGNED(start, awu_min))
> >> +		return false;
> >> +	/* If top bits doesn't match, means atomic unit boundary is crossed */
> >> +	if (boundary && ((start | mask) != (end | mask)))
> >> +		return false;
> >> +
> >> +	return true;
> >> +}
> >
> > I think you are re-implementing stuff that John has already done at
> > higher layers and in a generic manner. i.e.
> > generic_atomic_write_valid() in this patch:
> >
> > https://lore.kernel.org/linux-fsdevel/20240226173612.1478858-4-john.g.garry@oracle.com/
> >
> > We shouldn't be getting anywhere near the iomap layer if the IO is
> > not properly aligned to atomic IO constraints...
> 
> So current generic_atomic_write_valid() function mainly checks alignment
> w.r.t logical offset and iter->len. 
> 
> What this function was checking was on the physical block offset and
> mapped extent length. Hence it was made after iomap_iter() call.
> i.e. ...

The filesystem is supposed to guarantee the alignment of the iomap
returned for mapping requests on inodes configured for atomic
writes. IOWs, if the filesystem returns an unaligned or short extent
for an atomic write enabled inode, the filesystem mapping operation
is buggy. If it can't map aligned extents, then it should return an
error, not leave crap for the iomap infrastructure to have to clean
up.

> 
>  +	/* map_len should be same as user specified iter->len */
>  +	if (map_len < iter->len)
>  +		return false;
>  +	/* start should be aligned to block device min atomic unit alignment */
>  +	if (!IS_ALIGNED(start, awu_min))
>  +		return false;
> 
> 
> But I agree, that maybe we can improve generic_atomic_write_valid()
> to be able to work on both logical and physical offset and
> iter->len + mapped len. 
> Let me think about it. 
> 
> However, the point on which I would like a feedback from others is - 
> 1. After filesystem has returned the mapped extent in iomap_iter() call,
> iomap will be forming a bio to be sent to the block layer.
> So do we agree to add a check here in iomap layer to verify that the
> mapped physical start and len should satisfy the requirements for doing
> atomic writes?

That's entirely the problem about you working on this in isolation:
we've already had that discussion and the simplest solution is that
this is a filesystem problem, not an iomap problem. That is, if the
filesystem cannot return a correctly aligned and sized extent for an
atomic write enabled inode, it must return an error and not a
malformed iomap.

IOWs, it's not the job of the iomap IO routines to enforce mapping
alignment on these inodes - the extent alignment must always be
correct for atomic writes regardless of whether an atomic write IO
is being done or not. Failure to align any extent in the inode
correctly will result in future atomic writes to that offset being
impossible to issue.

Hence if the inode is configured for atomic writes, it *must* return
aligned and sized iomaps that atomic writes can be issued against.
It's a filesystem implementation bug if this invariant is violated,
so the filesystem implementation is where all the debug checks need
to be to ensure it never returns an invalid mapping to the iomap
infrastructure.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

