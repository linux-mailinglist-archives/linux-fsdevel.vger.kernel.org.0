Return-Path: <linux-fsdevel+bounces-29437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A53E2979B2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 08:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526A91F235FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 06:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6038442AB5;
	Mon, 16 Sep 2024 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="fEab7XNw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941B3BBCC
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726468403; cv=none; b=OJTthaOI1ndr7ozPwykVky0PJPi8EqH6IS/IV78Ck92WU/0hHAnPA5R2F5FxywMVBSMZkaOEgxDtL+u4IaVXV2eIOAQ4Vh9HlEgiTvOVPZzBBzxfWo/X4Sdn7RN+nj7endb3STnANG30p8fqBniJGqCQbk9qrcck8C9qIcBgQkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726468403; c=relaxed/simple;
	bh=DqUYrFG4Enz4+34W0+Vi1GhOjS3l28KXSdLtSsJa/4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/I8zjhbReOOKEMaq2Rrn4MG0XYYBy6kDgczZC7WqOnfVjFbe67xndOc/7b8XYG5xc6BS2CCzIcFsdzW0FSj8JjHccuvQGczp3XbMB7lp5uAh6lCAM45M7t2KE4b/uYE9OjBBlLxJdXEg2qIxTpx064VQvTj0E1PFU1b0IifMFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=fEab7XNw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d87a1f0791so1943358a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 23:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726468401; x=1727073201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XSZMwApg+gmjCJugiWkUy18xuz6LW9w5SgWcaqjuE8w=;
        b=fEab7XNwBicl3kreywesAAHZfEk18jsD0/zz2Ua4qP2CIHVZYko2DvmMG0vUsiAqbh
         RQRRbtlAWCvj7GuGZBMQzUgak5TniNUdaIoJYXlHS6jalMraRogG1KVnS/0SpTGvTdiD
         AcwBvmjNZ9oANcoyQGrgXTMDjsKpwF7OCcWXMCwP2eSs2fXv8YwDXpatLT6jsaw4gEBC
         rYS8uvYxso+UiHbF5wR0/OSlINnWUq6eReTZzba5I8bU+VRCEH0GsJkkbFmYtcMFXbQ2
         gnOj00Xchz3s5QyxsBWcncovvYL+EWQu6roH96bzSC0Tucbj6Do8z+1/55imaMs11Wu5
         mMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726468401; x=1727073201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSZMwApg+gmjCJugiWkUy18xuz6LW9w5SgWcaqjuE8w=;
        b=FHw2FyvCeUYhZ+lAMa36On7XOJbJo1wseSaN4rnbhFSpNkumsJT6Ia/dUR5iHkUzQG
         cPZ6zbe1a8tEdTCPIICauAS2lKCZPBVY5rVkVeR1n4++Jut+cNko8W8roqIgoSO3TnxB
         ef/nUwg6js1eklQQl1UgZaLO9ROjWFE2ywafsiQtwE34yY5Oy5QdaMQ+xmFBNFrsp8UB
         RFOJ3/xfEsDDViefG1duOdXVm6dhPnbxth4rYgCYBqETEGUZlWN1g6nZbHs0xtdlCUvd
         8UOKF7Id0cieyJJFTXjZsMJwSoe/MBhb+8FTVzTFXxaNjYLkpU9s/VzMAu76Wf1VxXZe
         fNRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyRLSMboVjg8E/ZRtkJX312+pyIu8wG4wjEdXOlNBWUN2ivu6pwxAtJd3w/xzJgHE5cjK25mhJXPl3dn9S@vger.kernel.org
X-Gm-Message-State: AOJu0YxlTjbLCxOR/a0VPIaScbvg9KTirSr5M7ydNhEEo92fGmTpuq1V
	vNQWtcQzEvp0+zmxpOxN2RJtJWpTA5QD1cAJ35hzpcY2dVV/ocTvGeyIn4IUZ6Y=
X-Google-Smtp-Source: AGHT+IH4SEadADz/E/S4sALk5BvwV5RWIKEOxqYtfNoR4jCgfo646bDgJygGp2QyNxqm298HKo6Q6g==
X-Received: by 2002:a17:90b:3758:b0:2da:88b3:d001 with SMTP id 98e67ed59e1d1-2dbb9e1d271mr13104116a91.18.1726468401331;
        Sun, 15 Sep 2024 23:33:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d5c9d1sm6465575a91.35.2024.09.15.23.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 23:33:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sq5IU-005oml-09;
	Mon, 16 Sep 2024 16:33:18 +1000
Date: Mon, 16 Sep 2024 16:33:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <ZufRLhUxhMn2HGYB@dread.disaster.area>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com>
 <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <877cbq3g9i.fsf@gmail.com>
 <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
 <877cbkgr04.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cbkgr04.fsf@gmail.com>

On Tue, Sep 10, 2024 at 08:21:55AM +0530, Ritesh Harjani wrote:
> Dave Chinner <david@fromorbit.com> writes:
> 
> > On Thu, Sep 05, 2024 at 09:26:25AM +0530, Ritesh Harjani wrote:
> >> Dave Chinner <david@fromorbit.com> writes:
> >> > On Wed, Sep 04, 2024 at 11:44:29PM +0530, Ritesh Harjani wrote:
> >> >> 3. It is the FORCEALIGN feature which _mandates_ both allocation
> >> >> (by using extsize hint) and de-allocation to happen _only_ in
> >> >> extsize chunks.
> >> >>
> >> >>    i.e. forcealign mandates -
> >> >>    - the logical and physical start offset should be aligned as
> >> >>    per args->alignment
> >> >>    - extent length be aligned as per args->prod/mod.
> >> >>      If above two cannot be satisfied then return -ENOSPC.
> >> >
> >> > Yes.
> >> >
> >> >> 
> >> >>    - Does the unmapping of extents also only happens in extsize
> >> >>    chunks (with forcealign)?
> >> >
> >> > Yes, via use of xfs_inode_alloc_unitsize() in the high level code
> >> > aligning the fsbno ranges to be unmapped.
> >> >
> >> > Remember, force align requires both logical file offset and
> >> > physical block number to be correctly aligned,
> >> 
> >> This is where I would like to double confirm it again. Even the
> >> extsize hint feature (w/o FORCEALIGN) will try to allocate aligned
> >> physical start and logical start file offset and length right?
> >
> > No.
> >
> >> (Or does extsize hint only restricts alignment to logical start file
> >> offset + length and not the physical start?)
> >
> > Neither.
> >
> 
> Yes, thanks for the correction. Indeed extsize hint does not take care
> of the physical start alignment at all.
> 
> > extsize hint by itself (i.e. existing behaviour) has no alignment
> > effect at all. All it affects is -size- of the extent. i.e. once
> > the extent start is chosen, extent size hints will trim the length
> > of the extent to a multiple of the extent size hint. Alignment is
> > not considered at all.
> >
> 
> Please correct me I wrong here... but XFS considers aligning the logical
> start and the length of the allocated extent (for extsize) as per below
> code right? 

Sorry, I was talking about physical alignment, not logical file
offset alignment. The logical file offset alignment that is done
for extent size hints is much more convoluted and dependent on
certain preconditions existing for it to function as forced
alignment/atomic writes require.

> 
> i.e.
> 1) xfs_direct_write_iomap_begin()
> {
>     <...>
>     if (offset + length > XFS_ISIZE(ip))
> 		end_fsb = xfs_iomap_eof_align_last_fsb(ip, end_fsb);
>                   => xfs_fileoff_t aligned_end_fsb = roundup_64(end_fsb, align);
>                      return aligned_end_fsb
> }

That's calculating the file offset of the end of the extent for an
extending write. It's not really an alignment - it's simply
calculating the file offset the allocation needs to cover to allow
for aligned allocation. This length needs to be fed into the
transaction reservation (i.e. ENOSPC checks) before we start the
allocation, so we have to have some idea of the extent size we are
going to allocate here...


> 2) xfs_bmap_compute_alignments()
> {
>     <...>
>     	else if (ap->datatype & XFS_ALLOC_USERDATA)
> 		     align = xfs_get_extsz_hint(ap->ip);
> 
>         if (align) {
>             if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>                         ap->eof, 0, ap->conv, &ap->offset,
>                         &ap->length))
>                 ASSERT(0);
>             ASSERT(ap->length);
> 
>             args->prod = align;
>             div_u64_rem(ap->offset, args->prod, &args->mod);
>             if (args->mod)
>                 args->mod = args->prod - args->mod;
>         }
>         <...>
> }
> 
> So args->prod and args->mod... aren't they use to align the logical
> start and the length of the extent?

Nope. They are only used way down in xfs_alloc_fix_len(), which
trims the length of the selected *physical* extent to the required
length.

Look further up - ap->offset is the logical file offset the
allocation needs to cover.  Logical alignment of the offset (i.e.
determining where in the file the physical extent will be placed) is
done in xfs_bmap_extsize_align(). As i said above, it's not purely
an extent size alignment calculation....

> However, I do notice that when the file is closed XFS trims the length
> allocated beyond EOF boundary (for extsize but not for forcealign from
> the new forcealign series) i.e.
> 
> xfs_file_release() -> xfs_release() -> xfs_free_eofblocks()
> 
> I guess that is because xfs_can_free_eofblocks() does not consider
> alignment for extsize in this function 

Of course - who wants large chunks of space allocated beyond EOF
when you are never going to write to the file again?

i.e. If you have large extsize hints then the post-eof tail can
consume a -lot- of space that won't otherwise get freed. This can
lead to rapid, unexpected ENOSPC, and it's not clear to users what
the cause is.

Hence we don't care if extsz is set on the inode or not when we
decide to remove post-eof blocks - reclaiming the unused space is
much more important that an occasional unaligned or small extent.

Forcealign changes that equation, but if you choose forcealign you
are doing it for a specific reason and likely not applying it to the
entire filesystem.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

