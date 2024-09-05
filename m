Return-Path: <linux-fsdevel+bounces-28669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C396596CF54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87FA1C2293B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 06:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194A18BB84;
	Thu,  5 Sep 2024 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HP/JwMfM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8EC1FA4
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518013; cv=none; b=FwQg4plsdN26KTyrhHmAwCCOBQm30D2aMo7YZuEJBhzCF3BgG43sPFMdhM7CoMYwIj00HHMqIMc3Db3cHZofXmIONcifsunM4oqAfPop3p6ijoa1ufCW3UIo14yyTlSwCnCVTX6fR8SClTDgyA/7XAMxJ+lTf8jYfIHYxhwujK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518013; c=relaxed/simple;
	bh=bn2hT7LCXxc6ZAJ3sAa1GdVh4sbht0Y2LYPcjvQAWhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQy1YgT9S4wtcpirXYqICXN0ec2OH4GCdp1Oyt5MeDBSyc2sALvFneIl/KN4NwXv08DW0U6TD+5AIl06Oczxm6BxDR29VErX8ZPihp5LkbUbeFUWQEr8WSPS05weWYQHoWgiM+1hCvo2eWXKQ+TzCt6fvJRKfJqUWa1/2juYyY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HP/JwMfM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso288096a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 23:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1725518011; x=1726122811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHrQB9ZzTtd9vlUCSy7LGRdh1BOF/2sydG6GAeYnfi4=;
        b=HP/JwMfMuhWWYvwqSMUORQa07RcXHpwT3SfmvG/DNNzd/nqtwsDdKjCcDk0lpKC5xz
         n6fyfOdccCbqQii7FU8PUCxnwewX3/N3udviniXry7MTMELl9S9j9HCAvWG7G9UkGpL3
         hgfQiZ6r7vwY3dKPEG8cCch/u0B16ySZX3IO0mBpGCNpRert0arrxx0/RDsS599OfOk9
         VKaaFElhXtRuZzES153su18s5nrVZtRT6ywHc/OCJpiOUf9ilr8dM4TmPZjpHUN4s+bx
         awn4wBEQuxmTbrF6pBRYhnZuUe0q1S/0kSzqNOINZ6+DvGplUbwEOptdOATxxVBqDh4+
         ab5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725518011; x=1726122811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHrQB9ZzTtd9vlUCSy7LGRdh1BOF/2sydG6GAeYnfi4=;
        b=ZWmHnrmwZBf0ERTJ3bjIEyyGBXWbeM27yRn0vj7cbD53cAlBnT8btaSYVqqXhx/2ej
         P2I4FEBrY03ZTfk1ACkr5WDBjMuhQEFnorvF6wjbPxx32HPJB24ejOKIE1fM9alvAVcY
         CFFobbI99o03zubuYR+D+HMEyrkBPQuDnX1PqxNMHhsei7jcoa50qOCesR6iUv3BfV/2
         pKyeeV3oz84eHihncATA7FpqHprdLRovF5F+CiEcI9AwWSMZZhkyAMoNp0B2lmqm3qzA
         buJV+f20l7fZLfOq7EmlDODKAEaibvNpjIWz5A6MKp5ioQzg0sAKthFCAD1PRwMxysUD
         Ns7g==
X-Forwarded-Encrypted: i=1; AJvYcCWwg0AdaMNEQLN+Q82nB31boIwQ6IhwZOmCQ4oix52Bbkp+e8Xeg7PyD/xdiXuz65363Odo8x0DQR0EAJB2@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBhpj5R6y45IB3pJYp20ynM8VsXOggDKIjYXpTwiMta/edQua
	ttIUndxQ9FBj/xSc1swuJqvV1YBBan+x1XpX5O9+aX0EMtKKRpNO550ptIlRTa4=
X-Google-Smtp-Source: AGHT+IFudb2jXVi3fyn9fbyDKZGK5M7nd5GbCLtDM63iBtHB1vQH2iGvjD3x2eQ0jr1WruHcNCRMhw==
X-Received: by 2002:a17:90a:ea93:b0:2d3:c87e:b888 with SMTP id 98e67ed59e1d1-2d894453b36mr15951219a91.27.1725518010858;
        Wed, 04 Sep 2024 23:33:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da8f2f1ba0sm2775743a91.25.2024.09.04.23.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 23:33:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sm63b-0012NC-1z;
	Thu, 05 Sep 2024 16:33:27 +1000
Date: Thu, 5 Sep 2024 16:33:27 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com>
 <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <877cbq3g9i.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cbq3g9i.fsf@gmail.com>

On Thu, Sep 05, 2024 at 09:26:25AM +0530, Ritesh Harjani wrote:
> Dave Chinner <david@fromorbit.com> writes:
> > On Wed, Sep 04, 2024 at 11:44:29PM +0530, Ritesh Harjani wrote:
> >> 3. It is the FORCEALIGN feature which _mandates_ both allocation
> >> (by using extsize hint) and de-allocation to happen _only_ in
> >> extsize chunks.
> >>
> >>    i.e. forcealign mandates -
> >>    - the logical and physical start offset should be aligned as
> >>    per args->alignment
> >>    - extent length be aligned as per args->prod/mod.
> >>      If above two cannot be satisfied then return -ENOSPC.
> >
> > Yes.
> >
> >> 
> >>    - Does the unmapping of extents also only happens in extsize
> >>    chunks (with forcealign)?
> >
> > Yes, via use of xfs_inode_alloc_unitsize() in the high level code
> > aligning the fsbno ranges to be unmapped.
> >
> > Remember, force align requires both logical file offset and
> > physical block number to be correctly aligned,
> 
> This is where I would like to double confirm it again. Even the
> extsize hint feature (w/o FORCEALIGN) will try to allocate aligned
> physical start and logical start file offset and length right?

No.

> (Or does extsize hint only restricts alignment to logical start file
> offset + length and not the physical start?)

Neither.

extsize hint by itself (i.e. existing behaviour) has no alignment
effect at all. All it affects is -size- of the extent. i.e. once
the extent start is chosen, extent size hints will trim the length
of the extent to a multiple of the extent size hint. Alignment is
not considered at all.

> Also it looks like there is no difference with ATOMIC_WRITE AND
> FORCEALIGN feature with XFS, correct? (except that ATOMIC_WRITE is
> adding additional natural alignment restrictions on pos and len). 

Atomic write requires additional hardware support, and it restricts
the valid sizes of extent size hints that can be set. Only atomic
writes can be done on files marked as configured for atomic writes;
force alignment can be done on any file...

> So why maintain 2 separate on disk inode flags for FORCEALIGN AND
> ATOMIC_WRITE?

the atomic write flag indicates that a file has been set up
correctly for atomic writes to be able to issues reliably. force
alignment doesn't guarantee that - it's just a mechanism that tells
the allocator to behave a specific way.

> - Do you foresee FORCEALIGN to be also used at other places w/o
> ATOMIC_WRITE where feature differentiation between the two on an
> inode is required?

The already exist. For example, reliably allocating huge page
mappings on DAX filesystems requires 2MB forced alignment. 

> - Does the same reasoning will hold for XFS_SB_FEAT_RO_COMPAT_FORCEALIGN
> & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES too?

Same as above.

> - But why ro_compact for ATOMICWRITES? There aren't any on disk metadata
> changes within XFS filesystem to support atomic writes, right? 

Because if you downgrade the kernel to something that doesn't
support atomic writes, then non-atomic sized/aligned data can be
written to the file and/or torn writes can occur.

Worse, extent size hints that don't match the underlying hardware
support could be set up for inodes, and when the kernel is upgraded
again then atomic writes will fail on inodes that have atomic write
flags set on them....

> Is it something to just prevent users from destroying their own data
> by not allowing a rw mount from an older kernel where users could do
> unaligned writes to files marked for atomic writes?
> Or is there any other reasoning to prevent XFS filesystem from becoming
> inconsistent if an older kernel does a rw mount here.

The older kernel does not know what the unknown inode flag means
(i.e. atomic writes) and so, by definition, we cannot allow it to
modify metadata or file data because it may not modify it in the
correct way for that flag being set on the inode.

Kernels that don't understand feature flags need to treat the
filesystem as read-only, no matter how trivial the feature addition
might seem.

> > so unmap alignment
> > has to be set up correctly at file offset level before we even know
> > what extents underly the file range we need to unmap....
> >
> >>      If the start or end of the extent which needs unmapping is
> >>      unaligned then we convert that extent to unwritten and skip,
> >>      is it? (__xfs_bunmapi())
> >
> > The high level code should be aligning the start and end of the
> > file range to be removed via xfs_inode_alloc_unitsize(). Hence 
> > the low level __xfs_bunmapi() code shouldn't ever be encountering
> > unaligned unmaps on force-aligned inodes.
> >
> 
> Yes, but isn't this code snippet trying to handle a case when it finds an
> unaligned extent during unmap?

It does exactly that.

> And what we are essentially trying to 
> do here is leave the unwritten extent as is and if the found extent is
> written then convert to unwritten and skip it (goto nodelete). This
> means with forcealign if we encounter an unaligned extent then the file
> will have this space reserved as is with extent marked unwritten. 
> 
> Is this understanding correct?

Yes, except for the fact that this code is not triggered by force
alignment.

This code is preexisting realtime file functionality. It is used
when the rtextent size is larger than a single filesytem block.

In these configurations, we do allocation in rtextsize units, but we
track written/unwritten extents in the BMBT on filesystem block
granularity. Hence we can have unaligned written/unwritten extent
boundaries, and if we aren't unmapping a whole rtextent then we
simply mark the unused portion of it as unwritten in the BMBT to
indicate it contains zeroes.

IOWs, existing RT files have different IO alignment and
written/unwritten extent conversion behaviour to the new forced
alignment feature. The implementation code is shared in many places,
but the higher level forced alignment functionality ensures there
are never unaligned unwritten extents created or unaligned
unmappings asked for. Hence this code does not trigger for the
forced alignment cases.

i.e. we have multiple seperate allocation alignment behaviours that
share an implementation, but they do not all behave exactly the same
way or provide the same alignment guarantees....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

