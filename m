Return-Path: <linux-fsdevel+bounces-41132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013CFA2B46E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 22:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FA43A57FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C4B237171;
	Thu,  6 Feb 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIOEFYcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76A23645D;
	Thu,  6 Feb 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738878864; cv=none; b=gmj+4FYoDvMQQgufnWAJ8plRKbiyMf0TmBiLLMui+oMOhFNM4492I6K8i+WwQo+/Fr6bs6rqDkdSokw3H1b/WC252xcO3nOq1dkmQQ7cmMwqihrk60o4USO0abmojCUDakkF56csBBxSGfe+FvB5nsksVQ6pbrWiiaKXipy3Ue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738878864; c=relaxed/simple;
	bh=B231tugVCPWzN9vzBk0pgA7JVKtCX4QjkKBLeDcM4uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8oXN0GeZ2MWuq91lz3DPvf0+x5GoxEMfKmLUk64Q3JaxaSLMgOZyR4VRddnmkCuPnw8A8FtkARAuBRnFXF7AZs+0ERlGEwGQs+YjhlUF+GwXSY26p5bm26QArSq9EOp6KVRUulYxDsf6IaN/6cf0Go/DhSF8xEnH8gHBNjtc7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIOEFYcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCC5C4CEDD;
	Thu,  6 Feb 2025 21:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738878863;
	bh=B231tugVCPWzN9vzBk0pgA7JVKtCX4QjkKBLeDcM4uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIOEFYcMmj92WShJiyDBtChc5W0rHXWp/wt8PZmGMAmMKmIq3L+Tfw6Hkc5lNDVnV
	 Qe7HfCWOTyxgfTJBCkbXgnZgDEKcaMCkOZJhlg6jUKqgvjtEWH93mCS9utpcaQ4zC5
	 +n84jBfFHO20Rt0CaupQgqEuc6tnN9+68ZA30zd8/X+o76AK4hkLR2RaG37qNi1AEB
	 GJDmm33ZuBwGDlFwTgfEcjYQIMQEW1CCBNImfd2gydb3TSEEqdDcD5cU5eTgYnVFrB
	 ajGov/wCADrcA2HT/FxtbP6LGXRoMOuPyx4Zy0IlllQAgrfasiL1c3FDDjw7I/S4Rh
	 xcCNxi7hxdR8g==
Date: Thu, 6 Feb 2025 13:54:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 10/10] xfs: Allow block allocator to take an
 alignment hint
Message-ID: <20250206215422.GZ21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-11-john.g.garry@oracle.com>
 <20250205192039.GU21808@frogsfrogsfrogs>
 <0bcd5bee-132f-417b-b77c-64b80e007c72@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bcd5bee-132f-417b-b77c-64b80e007c72@oracle.com>

On Thu, Feb 06, 2025 at 08:10:24AM +0000, John Garry wrote:
> On 05/02/2025 19:20, Darrick J. Wong wrote:
> > On Tue, Feb 04, 2025 at 12:01:27PM +0000, John Garry wrote:
> > > When issuing an atomic write by the CoW method, give the block allocator a
> > > hint to naturally align the data blocks.
> > > 
> > > This means that we have a better chance to issuing the atomic write via
> > > HW offload next time.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/libxfs/xfs_bmap.c | 7 ++++++-
> > >   fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
> > >   fs/xfs/xfs_reflink.c     | 8 ++++++--
> > >   3 files changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > > index 40ad22fb808b..7a3910018dee 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.c
> > > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > > @@ -3454,6 +3454,12 @@ xfs_bmap_compute_alignments(
> > >   		align = xfs_get_cowextsz_hint(ap->ip);
> > >   	else if (ap->datatype & XFS_ALLOC_USERDATA)
> > >   		align = xfs_get_extsz_hint(ap->ip);
> > > +
> > > +	if (align > 1 && ap->flags & XFS_BMAPI_NALIGN)
> > > +		args->alignment = align;
> > > +	else
> > > +		args->alignment = 1;
> > > +
> > >   	if (align) {
> > >   		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
> > >   					ap->eof, 0, ap->conv, &ap->offset,
> > > @@ -3781,7 +3787,6 @@ xfs_bmap_btalloc(
> > >   		.wasdel		= ap->wasdel,
> > >   		.resv		= XFS_AG_RESV_NONE,
> > >   		.datatype	= ap->datatype,
> > > -		.alignment	= 1,
> > >   		.minalignslop	= 0,
> > >   	};
> > >   	xfs_fileoff_t		orig_offset;
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
> > > index 4b721d935994..d68b594c3fa2 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.h
> > > +++ b/fs/xfs/libxfs/xfs_bmap.h
> > > @@ -87,6 +87,9 @@ struct xfs_bmalloca {
> > >   /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
> > >   #define XFS_BMAPI_NORMAP	(1u << 10)
> > > +/* Try to naturally align allocations */
> > > +#define XFS_BMAPI_NALIGN	(1u << 11)
> > > +
> > >   #define XFS_BMAPI_FLAGS \
> > >   	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
> > >   	{ XFS_BMAPI_METADATA,	"METADATA" }, \
> > > @@ -98,7 +101,8 @@ struct xfs_bmalloca {
> > >   	{ XFS_BMAPI_REMAP,	"REMAP" }, \
> > >   	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
> > >   	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
> > > -	{ XFS_BMAPI_NORMAP,	"NORMAP" }
> > > +	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
> > > +	{ XFS_BMAPI_NALIGN,	"NALIGN" }
> > 
> > Tihs isn't really "naturally" aligned, is it?  It really means "try to
> > align allocations to the extent size hint", which isn't required to be a
> > power of two.
> 
> Sure, so I would expect that the user will set extsize/cowextsize according
> to the size what we want to do atomics for, and we can align to that. I
> don't think that it makes a difference that either extsize isn't mandated to
> be a power-of-2.
> 
> So then I should rename to XFS_BMAPI_EXTSZALIGN or something like that - ok?

Yep.

--D

> Thanks,
> John
> 
> 
> > 
> > --D
> > 
> > >   static inline int xfs_bmapi_aflag(int w)
> > > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> > > index 60c986300faa..198fb5372f10 100644
> > > --- a/fs/xfs/xfs_reflink.c
> > > +++ b/fs/xfs/xfs_reflink.c
> > > @@ -445,6 +445,11 @@ xfs_reflink_fill_cow_hole(
> > >   	int			nimaps;
> > >   	int			error;
> > >   	bool			found;
> > > +	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
> > > +					XFS_BMAPI_PREALLOC;
> > > +
> > > +	if (atomic)
> > > +		bmapi_flags |= XFS_BMAPI_NALIGN;
> > >   	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
> > >   		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
> > > @@ -478,8 +483,7 @@ xfs_reflink_fill_cow_hole(
> > >   	/* Allocate the entire reservation as unwritten blocks. */
> > >   	nimaps = 1;
> > >   	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
> > > -			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0, cmap,
> > > -			&nimaps);
> > > +			bmapi_flags, 0, cmap, &nimaps);
> > >   	if (error)
> > >   		goto out_trans_cancel;
> > > -- 
> > > 2.31.1
> > > 
> > > 
> 
> 

