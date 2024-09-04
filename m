Return-Path: <linux-fsdevel+bounces-28665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB7F96CABE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 01:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96151F2853D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 23:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC3617BEA0;
	Wed,  4 Sep 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="M5NBdb9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985215B0FF
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492053; cv=none; b=UgxPaqVjQxbxAPvuf/3kGGSNNLQY3T5jEWLcGYW0rvsqikUlnEMcpKZycvnbn2aGKL0aZzULmZqSO9Dly/MkiBcpQjM2yRINy1f9pK6HqeiO/n1xOeTy4dOgEzAe7VEZV1eonz/d5lneg5Xd90RnFrFiJVhDFScMn2oPLPSxf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492053; c=relaxed/simple;
	bh=HcFDd0H7LbXYeh37GMtCsBrIu9ps3lCC8dBP2ltvvaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuTKDdMqit3sfuScmAScL8KA163fTy1upvrSS8b3gluQKRhORGtySBYwcVi24n/oLP7mhkF2F8qFge6XGRJHkUTj6yN6wJl9HY7oe+1LBn6G8dmF6qsplufE7560CdWyIlquKRKyoKVxPyUKDf6lCx6KPzY1ke04kldIHFOXtuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=M5NBdb9Z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2068a7c9286so1712245ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1725492051; x=1726096851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=do2YRTOoj9GnwWoBDgk0QrUSNsuLuq0vS4jyF1HXMKE=;
        b=M5NBdb9ZRMVOuNdm1cYWlIuWFNz2HjY1Niy778nwKHMGzF7Z3Gnl0WAuqfe0TiUDYk
         8FPfgrwkzS4aUYys9V/buq4fnLizE8agDhv724tTOxI8lZdl5LMoRSBS5GLwNJUQxKC/
         9l6zeO8l6hDUCbnDnVnqy1Azsyii9VfF3N+oAI6RZ73RfL+wZJ3Ye5CAUMR104Rj+on/
         MaN/eUft78Me+0VGq6doiZTglZGrI6YQ72QwbqRYb5J8vxfdmhUuW9xnw4dByK9D9XlS
         G5GwhHlv3uecQHeT+HqOeOyqbNrIqA8zFyjt16z1RncXiy2WUq4ux+rZNEFhdboWF7qT
         nHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725492051; x=1726096851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do2YRTOoj9GnwWoBDgk0QrUSNsuLuq0vS4jyF1HXMKE=;
        b=K1NcCCPzBKSt1Mh2mlzL0PrrpkvFQMReu+icfXXNjAsWjTLgjJN0K/JOQ5ZgYeia6g
         Z1YWhWgHPQIDUgtpFfIT65/5FtRmil4DZVWywjtg57EJWM3ngUCLYTD1p39cKHuHUPiW
         +IbQ1aI6N5Ywh0lD9dIKlL6b3DhZkUR6WX26s90PIfruQzPDZm/VPaBiZw6vcbTXNEQn
         ZYX90zynhD5p0DdxJtM6ns6VOklhEm1on0paclrr/o6ybeXIH6W4ZamzghRxwQgCgmeL
         ocQroBu+h0f6UrZuvAQevxoCG5VAfXu3Ls9ydKfmdHGj6MtlJ4N22NYN/RILjrL/QcvF
         OO+g==
X-Forwarded-Encrypted: i=1; AJvYcCVpEWqHuN+phwxpuOHHwYsGZIzQsTFcncbPOfisqfG7DeWksXA0/ONt9xONL320O9u/n2uepo+zLGFisGJZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzbxxGtFIlVI+0Bam4FRM5YMaPlvKSsPD5gi4NY6HRpCmpYzRF2
	WYMWPSb3hHhjnUnwUC9Mjx4DcHOhspWihNfxI04WfC/5orYsX9VekC3FVVzhvIE=
X-Google-Smtp-Source: AGHT+IHuT2/JPIf3XtWre+GFOUJzFurrIT8snqejnQfLJC9H3VrO6JyW0vpwKFJUAdmNu27h3XvCUQ==
X-Received: by 2002:a17:902:e752:b0:1fb:701b:7298 with SMTP id d9443c01a7336-205841ba17emr139292085ad.32.1725492051426;
        Wed, 04 Sep 2024 16:20:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206b2147b49sm16857895ad.251.2024.09.04.16.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 16:20:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1slzIu-000uGZ-1V;
	Thu, 05 Sep 2024 09:20:48 +1000
Date: Thu, 5 Sep 2024 09:20:48 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <ZtjrUI+oqqABJL2j@dread.disaster.area>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frqf2smy.fsf@gmail.com>

On Wed, Sep 04, 2024 at 11:44:29PM +0530, Ritesh Harjani wrote:
> John Garry <john.g.garry@oracle.com> writes:
> 
> > This series is being spun off the block atomic writes for xfs
> > series at [0].
> >
> > That series got too big.
> >
> > The actual forcealign patches are roughly the same in this
> > series.
> >
> > Why forcealign?  In some scenarios to may be required to
> > guarantee extent alignment and granularity.
> >
> > For example, for atomic writes, the maximum atomic write unit
> > size would be limited at the extent alignment and granularity,
> > guaranteeing that an atomic write would not span data present in
> > multiple extents.
> >
> > forcealign may be useful as a performance tuning optimization in
> > other scenarios.
> >
> > I decided not to support forcealign for RT devices here.
> > Initially I thought that it would be quite simple of implement.
> > However, I discovered through much testing and subsequent debug
> > that this was not true, so I decided to defer support to
> > later.
> >
> > Early development xfsprogs support is at:
> > https://github.com/johnpgarry/xfsprogs-dev/commits/atomic-writes/
> >
> 
> Hi John,
> 
> Thanks for your continued work on atomic write.  I went over the
> XFS patch series and this is my understanding + some queries.
> Could you please help with these.

Hi Ritesh - to make it easier for everyone to read and reply to you
emails, can you please word wrap the text at 72 columns?

> 1. As I understand XFS untorn atomic write support is built on top
> of FORCEALIGN feature (which this series is adding) which in turn
> uses extsize hint feature underneath.

Yes.

>    Now extsize hint mainly controls the alignment of both
>    "physical start" & "logical start" offset and extent length,
>    correct?

Yes.

>    This is done using args->alignment for start aand
>    args->prod/mode variables for extent length. Correct?

Yes.

>    - If say we are not able to allocate an aligned physical start?
>    Then since extsize is just a hint we go ahead with whatever
>    best available extent is right?

No. The definition of "forced alignment" is that we guarantee
aligned allocation to the extent size hint. i.e the extent size hint
is not a hint anymore - it defines the alignment we are guaranteeing
allocation will achieve.

hence if we can't align the extent to the alignment provided, we
fail the alignment.

>    - also extsize looks to be only providing allocation side of hints. (not de-allocation). Correct?

No. See the use of xfs_inode_alloc_unitsize() in all the places
where we free space. Forced alignment extends this function to
return the extent size, not the block size.

> 2. If say there is an append write i.e. the allocation is needed
> to be done at EOF. Then we try for an exact bno (from eof block)
> and aligned extent length, right?

Yes. This works because the previous extent is exactly aligned,
hence a contiguous allocation will continue to be correctly aligned
due to the forced alignment constraints.

>    i.e. xfs_bmap_btalloc_filestreams() ->
>    xfs_bmap_btalloc_at_eof(ap, args); If it is not available then
>    we try for nearby bno xfs_alloc_vextent_near_bno(args, target)
>    and similar...

yes, that's just the normal aligned allocation fallback path when
exact allocation fails.

> 3. It is the FORCEALIGN feature which _mandates_ both allocation
> (by using extsize hint) and de-allocation to happen _only_ in
> extsize chunks.
>
>    i.e. forcealign mandates -
>    - the logical and physical start offset should be aligned as
>    per args->alignment
>    - extent length be aligned as per args->prod/mod.
>      If above two cannot be satisfied then return -ENOSPC.

Yes.

> 
>    - Does the unmapping of extents also only happens in extsize
>    chunks (with forcealign)?

Yes, via use of xfs_inode_alloc_unitsize() in the high level code
aligning the fsbno ranges to be unmapped.

Remember, force align requires both logical file offset and
physical block number to be correctly aligned, so unmap alignment
has to be set up correctly at file offset level before we even know
what extents underly the file range we need to unmap....

>      If the start or end of the extent which needs unmapping is
>      unaligned then we convert that extent to unwritten and skip,
>      is it? (__xfs_bunmapi())

The high level code should be aligning the start and end of the
file range to be removed via xfs_inode_alloc_unitsize(). Hence 
the low level __xfs_bunmapi() code shouldn't ever be encountering
unaligned unmaps on force-aligned inodes.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

