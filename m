Return-Path: <linux-fsdevel+bounces-18464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF298B92ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 02:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D4E1C216FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F10B12B87;
	Thu,  2 May 2024 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="z3JnhcMc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6DDD299
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714611049; cv=none; b=Tz1NixOM/dg8AMCmYP7Rl+ZMPRupQfxBTOjnbz3H2pHI4mCaqkxR9hMWiPdIQzI43TOUHNW8JmTYF9PvmqcTobkeVgRcXt6OOsSg5Q7EfIu6EZGHhnNEIu5lRvTdGpnbWYIIsd9beLkm1/B7YsOHdD95uHuNn2jZPinuuTmbX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714611049; c=relaxed/simple;
	bh=A2sMRVET5TYa3/vVhRzf6iYtSiEMpUna17lSSfqkZGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snLFW5PH7fva9W/KGMyttqrKvrt8rIzlZldZooThE5ZwsaO6oQrzHFDQYNpAPStrkUz5b2SYv9aytLmsAIZvOSisKwKPIIb6fxUGKoGsrI9YZxasuUG7wFrAxGuCYQze7d3IFZ+inlXsSGdLarzRxmDKzqq5R7K8mPqB0CsN0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=z3JnhcMc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso5495245ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2024 17:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714611046; x=1715215846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0yro6mCsnOYESpgiEY/eqEksfYNfYV/p03nQpH383Y=;
        b=z3JnhcMcPs9rxNQNBiDKwX1SGk47U2BwrCTqYYJfqsn8FxIhY9Z5jIkCJ6M2fjMyNK
         JEp7laTb34msmF4gL1ooB5g5fKn4e7HEzu9Vc99dTpSwTQRKtIvkliuYFtNM9cZOGuOV
         5TwbrAh8K19HJiVjQCqrvLuoMOhbM8280qkmkKhg6m40n4gPbdRciQ2JDeMO227LuKyI
         /7RVol4eKdBOjW/RbkxFBCazblvwcXouQfqRRsmjPid6mr5M99B3GfBlfnuFKxK+6Osc
         xPe64o5kWsHdUD21FufE9bgszNQu16YWRTqEVKclGVYbAikX95xKiDaFsl4CwxLNnD30
         fOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714611046; x=1715215846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0yro6mCsnOYESpgiEY/eqEksfYNfYV/p03nQpH383Y=;
        b=k4uhRIB3p75K/TE1HT41A1m7jNbRkm2j6A1N8Y4BRqXsaMa6NdXR1S89ShWuRsDFMw
         6CAGaI7N1yCB3miUYCcnCMUaAMsRECg8faBIQNnBwktVI+Jhjc041BIUTqip4xEPU/zd
         eak+h6RgADflsPR0KuQdVYAHvA8Hgw+fuENcbmdFXlhBIu3u/pAXk5bYAggIQOLVZcQw
         t36O93m9jkqAgx3h5/EJRnuBfN17Vhls1tpPYP1+Tt2BgajUG5+6XbHImkkQYfT3hKPl
         R/78DoB424MAxW/rh327KmccpXw8GR58cAy2+OLzBfev16vvtS/DT5VOzHiNMgSnt1Aw
         mcvw==
X-Forwarded-Encrypted: i=1; AJvYcCXXcJ4u3uHZmJrGCXth0O2zEQyH/LWu0fOutX9apgUDBuftdNdM0ja0QHaxn/BBA5Ura/9jwHia2Ssaq2XuRyNj72dx5KPLCrqXJtatEA==
X-Gm-Message-State: AOJu0YzNJugjX7ElGf5zq1xWBKsAXN3ICYmUnR/PkbSCmhhnc0Qg2Mbq
	EPbuiFitIROftzQt8IyxWo7+PwypkPkpu1VFDXdDMfGGwt/UQJHxHJmOea5WK3o=
X-Google-Smtp-Source: AGHT+IF1CEpl4XkYgWfwAZRE9Iw5tzc1lpvTtka9TKQ8B/BxRJk8eYZOBT9guSPfHkUCxQ+vkMQGmw==
X-Received: by 2002:a17:902:da90:b0:1e3:cfc5:589e with SMTP id j16-20020a170902da9000b001e3cfc5589emr4792731plx.64.1714611045317;
        Wed, 01 May 2024 17:50:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d88500b001e40898e9acsm24733459plz.276.2024.05.01.17.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 17:50:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s2Keo-000M2e-12;
	Thu, 02 May 2024 10:50:42 +1000
Date: Thu, 2 May 2024 10:50:42 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 08/21] xfs: Introduce FORCEALIGN inode flag
Message-ID: <ZjLjYsjTJGSdWZ9q@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-9-john.g.garry@oracle.com>
 <ZjF9RVetf+Xt70BX@dread.disaster.area>
 <cc54060a-2dc3-45e4-b47c-a9926553e59b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc54060a-2dc3-45e4-b47c-a9926553e59b@oracle.com>

On Wed, May 01, 2024 at 11:03:06AM +0100, John Garry wrote:
> 
> > > +/* Validate the forcealign inode flag */
> > > +xfs_failaddr_t
> > > +xfs_inode_validate_forcealign(
> > > +	struct xfs_mount	*mp,
> > > +	uint16_t		mode,
> > 
> > 	umode_t			mode,
> 
> ok. BTW, other functions like xfs_inode_validate_extsize() use uint16_t
> 
> > 
> > > +	uint16_t		flags,
> > > +	uint32_t		extsize,
> > > +	uint32_t		cowextsize)
> > 
> > extent sizes are xfs_extlen_t types.
> 
> ok
> 
> > 
> > > +{
> > > +	/* superblock rocompat feature flag */
> > > +	if (!xfs_has_forcealign(mp))
> > > +		return __this_address;
> > > +
> > > +	/* Only regular files and directories */
> > > +	if (!S_ISDIR(mode) && !S_ISREG(mode))
> > > +		return __this_address;
> > > +
> > > +	/* Doesn't apply to realtime files */
> > > +	if (flags & XFS_DIFLAG_REALTIME)
> > > +		return __this_address;
> > 
> > Why not? A rt device with an extsize of 1 fsb could make use of
> > forced alignment just like the data device to allow larger atomic
> > writes to be done. I mean, just because we haven't written the code
> > to do this yet doesn't mean it is an illegal on-disk format state.
> 
> ok, so where is a better place to disallow forcealign for RT now (since we
> have not written the code to support it nor verified it)?

Just don't allow it to be set in the setattr ioctl if the inode is
RT. ANd don't let an inode be marked RT if forcealign is already
set.

> 
> > 
> > > +	/* Requires a non-zero power-of-2 extent size hint */
> > > +	if (extsize == 0 || !is_power_of_2(extsize) ||
> > > +	    (mp->m_sb.sb_agblocks % extsize))
> > > +		return __this_address;
> > 
> > Please do these as indiviual checks with their own fail address.
> 
> ok
> 
> > That way we can tell which check failed from the console output.
> > Also, the agblocks check is already split out below, so it's being
> > checked twice...
> > 
> > Also, why does force-align require a power-of-2 extent size? Why
> > does it require the extent size to be an exact divisor of the AG
> > size? Aren't these atomic write alignment restrictions? i.e.
> > shouldn't these only be enforced when the atomic writes inode flag
> > is set?
> 
> With regards the power-of-2 restriction, I think that the code changes are
> going to become a lot more complex if we don't enforce this for forcealign.
> 
> For example, consider xfs_file_dio_write(), where we check for an unaligned
> write based on forcealign extent mask. It's much simpler to rely on a
> power-of-2 size. And same for iomap extent zeroing.

But it's not more complex - we already do this non-power-of-2
alignment stuff for all the realtime code, so it's just a matter
of not blindly using bit masking in alignment checks.

> So then it can be asked, for what reason do we want to support unorthodox,
> non-power-of-2 sizes? Who would want this?

I'm constantly surprised by the way people use stuff like this
filesystem and storage alignment constraints are not arbitrarily
limited to power-of-2 sizes.

For example, code implementation is simple in RAID setups when you
use power-of-2 chunk sizes and stripe widths. But not all storage
hardware fits power-of-2 configs like 4+1, 4+2, 8+1, 8+2, etc. THis
is pretty common - 2.5" 2U drive trays have 24 drive bays. If you
want to give up 33% of the storage capacity just to use power-of-2
stripe widths then you would use 4x4+2 RAID6 luns. However, most
people don't want to waste that much money on redundancy. They are
much more likely to use 2x10+2 RAID6 luns or 1x21+2 with a hot spare
to maximise the data storage capacity.

If someone wants to force-align allocation to stripe widths on such
a RAID array config rather than trying to rely on the best effort
swalloc mount option, then they need non-power-of-2
alignments to be supported.

It's pretty much a no-brainer - the alignment code already handles
non-power-of-2 alignments, and it's not very much additional code to
ensure we can handle any alignment the user specified.

> As for AG size, again I think that it is required to be aligned to the
> forcealign extsize. As I remember, when converting from an FSB to a DB, if
> the AG itself is not aligned to the forcealign extsize, then the DB will not
> be aligned to the forcealign extsize. More below...
> 
> > 
> > > +	/* Requires agsize be a multiple of extsize */
> > > +	if (mp->m_sb.sb_agblocks % extsize)
> > > +		return __this_address;
> > > +
> > > +	/* Requires stripe unit+width (if set) be a multiple of extsize */
> > > +	if ((mp->m_dalign && (mp->m_dalign % extsize)) ||
> > > +	    (mp->m_swidth && (mp->m_swidth % extsize)))
> > > +		return __this_address;
> > 
> > Again, this is an atomic write constraint, isn't it?
> 
> So why do we want forcealign? It is to only align extent FSBs?

Yes. forced alignment is essentially just extent size guarantees.

This is part of what is needed for atomic writes, but atomic writes
also require specific physical storage alignment between the
filesystem and the device. The filesystem setup has to correctly
align AGs to the physical storage, and stuff like RAID
configurations need to be specifically compatible with the atomic
write capabilities of the underlying hardware.

None of these hardware iand storage stack alignment constraints have
any relevance to the filesystem forced alignment functionality. They
are completely indepedent. All the forced alignment does is
guarantees that allocation is aligned according the extent size hint
on the inode or it fails with ENOSPC.

> > > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > > index d0e2cec6210d..d1126509ceb9 100644
> > > --- a/fs/xfs/xfs_ioctl.c
> > > +++ b/fs/xfs/xfs_ioctl.c
> > > @@ -1110,6 +1110,8 @@ xfs_flags2diflags2(
> > >   		di_flags2 |= XFS_DIFLAG2_DAX;
> > >   	if (xflags & FS_XFLAG_COWEXTSIZE)
> > >   		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
> > > +	if (xflags & FS_XFLAG_FORCEALIGN)
> > > +		di_flags2 |= XFS_DIFLAG2_FORCEALIGN;
> > >   	return di_flags2;
> > >   }
> > > @@ -1146,6 +1148,22 @@ xfs_ioctl_setattr_xflags(
> > >   	if (i_flags2 && !xfs_has_v3inodes(mp))
> > >   		return -EINVAL;
> > > +	/*
> > > +	 * Force-align requires a nonzero extent size hint and a zero cow
> > > +	 * extent size hint.  It doesn't apply to realtime files.
> > > +	 */
> > > +	if (fa->fsx_xflags & FS_XFLAG_FORCEALIGN) {
> > > +		if (!xfs_has_forcealign(mp))
> > > +			return -EINVAL;
> > > +		if (fa->fsx_xflags & FS_XFLAG_COWEXTSIZE)
> > > +			return -EINVAL;
> > > +		if (!(fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
> > > +					FS_XFLAG_EXTSZINHERIT)))
> > > +			return -EINVAL;
> > > +		if (fa->fsx_xflags & FS_XFLAG_REALTIME)
> > > +			return -EINVAL;
> > > +	}
> > 
> > What about if the file already has shared extents on it (i.e.
> > reflinked or deduped?)
> 
> At the top of the function we have this check for RT:
> 
> 	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
> 		/* Can't change realtime flag if any extents are allocated. */
> 		if (ip->i_df.if_nextents || ip->i_delayed_blks)
> 			return -EINVAL;
> 	}
> 
> Would expanding that check for forcealign also suffice? Indeed, later in
> this series I expanded this check to cover atomicwrites (when I really
> intended it for forcealign).

For the moment, yes.

> > > @@ -1263,7 +1283,19 @@ xfs_ioctl_setattr_check_extsize(
> > >   	failaddr = xfs_inode_validate_extsize(ip->i_mount,
> > >   			XFS_B_TO_FSB(mp, fa->fsx_extsize),
> > >   			VFS_I(ip)->i_mode, new_diflags);
> > > -	return failaddr != NULL ? -EINVAL : 0;
> > > +	if (failaddr)
> > > +		return -EINVAL;
> > > +
> > > +	if (new_diflags2 & XFS_DIFLAG2_FORCEALIGN) {
> > > +		failaddr = xfs_inode_validate_forcealign(ip->i_mount,
> > > +				VFS_I(ip)->i_mode, new_diflags,
> > > +				XFS_B_TO_FSB(mp, fa->fsx_extsize),
> > > +				XFS_B_TO_FSB(mp, fa->fsx_cowextsize));
> > > +		if (failaddr)
> > > +			return -EINVAL;
> > > +	}
> > 
> > Oh, it's because you're trying to use on-disk format validation
> > routines for user API validation. That, IMO, is a bad idea because
> > the on-disk format and kernel/user APIs should not be tied
> > together as they have different constraints and error conditions.
> > 
> > That also explains why xfs_inode_validate_forcealign() doesn't just
> > get passed the inode to validate - it's because you want to pass
> > information from the user API to it. This results in sub-optimal
> > code for both on-disk format validation and user API validation.
> > 
> > Can you please separate these and put all the force align user API
> > validation checks in the one function?
> > 
> 
> ok, fine. But it would be good to have clarification on function of
> forcealign, above, i.e. does it always align extents to disk blocks?

No, it doesn't. XFS has never done this - physical extent alignment
is always done relative to the start of the AG, not the underlying
disk geometry.

IOWs, forced alignement is not aligning to disk blocks at all - it
is aligning extents logically to file offset and physically to the
offset from the start of the allocation group.  Hence there are no
real constraints on forced alignment - we can do any sort of
alignment as long it is smaller than half the max size of a physical
extent.

For allocation to then be aligned to physical storage, we need mkfs
to physically align the start of each AG to the geometry of the
underlying storage. We already do this for filesystems with a stripe
unit defined, hence stripe aligned allocation is physically aligned
to the underlying storage.

However, if mkfs doesn't get the physical layout of AGs right, there
is nothing the mounted filesystem can do to guarantee extent
allocation is aligned to physical disk blocks regardless of whether
forced alignment is enabled or not...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

