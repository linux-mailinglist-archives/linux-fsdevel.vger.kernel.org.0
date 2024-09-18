Return-Path: <linux-fsdevel+bounces-29632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C597BA62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 11:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C841F23D91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA517B425;
	Wed, 18 Sep 2024 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="l62ed5r/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2356175D2E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653274; cv=none; b=csnbff9vuCT2H/6Vfr5keVRVB6oYRRhllIZ6ADvuPM0Im+oiYWxHitesrzXmTTMSWMamN1N5nLBixUFqSebxbyh2bH7j+xtG31wtKIXwR4K4nnFfHhRHC0OCh88dCkI6SDdqyTDGs/4Sq0KzzxgOFOJx/ifKq0uClefphKqOmuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653274; c=relaxed/simple;
	bh=hczx1B30LddQG5sqoBf/k9U+8Dd8jt5o+N548Etg0bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQpOPACjTkIWysLzEs5LA1rB53dorBvAYQJXJrM4wSgNKSKIvKudoMoDRfSlCjzmNILZJ2FTczad/Ck/sAdP75oT0lLD5GemXI4TkWk+WqhzSQbKFsKgPD3DI9OL8FpCyPX98Q9TbGto+GSOa3BHbE3nR3m0I+Ez7ZnRhvYXEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=l62ed5r/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d87a0bfaa7so4357659a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726653272; x=1727258072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/VCafIfAu4TzVmJWk9ey780TGQnXStCJMuHQdcUPmI=;
        b=l62ed5r/f23GDyGeClGFYQuRq8E4gzEdCSl0zidvhsjbIQk8ObEJlrquxq3ehtp6jg
         lOSDMKLT+z1VrpxZq8jEY4m/7gXiMTKpsJEYGywY5N3FUeFRB7sF8IHVGUN9CtVjY56a
         QUzF+O5v1IK/YDQaJsWqzztsyVnbRbjmWlbLKRel8cKci/7Dg5ZBpp474Hjp50juBhep
         s0AytMSDjsGDE0lun59gvhrxCf3K4p7kXIlJcj8u8K0SeRE+hEWatntravoeVVo5Su+8
         cn2rgoIi5lyclOQSylz/s3c7MrEz2AgM6I3kcpau4RqdB2shbgBgKaooAi9QJtggq19q
         /Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726653272; x=1727258072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/VCafIfAu4TzVmJWk9ey780TGQnXStCJMuHQdcUPmI=;
        b=QruX5ivn88YxKcphryKP6ZJhEVc8A3OZvY8TppIpo+T+pkiS9piepFniPTMky4IQmK
         uM9pOzoNE00wDc5ZsyHUPpdFbMLSv4zU7JTt3t15+m3IdkkTUGwAi5DV3otzEuHwVlxw
         A9v5g+IdrwvtddcKaNPJUPqIO96AYNJg7Jejs0vPL1evcx66YJACOZ2frTMdAqi28eMy
         ltsOsmgFnbd3RywQKKObt22sdYU8Ix7GZB4FFf79B5VjVfhA8XgQiPESW0rBy6ypAgQo
         tbXx7O9YPcDivHDse609GMMmVwvbDMLMJ0wE+g98hRhTQvjIXKSA6/sHyIWrb7/Dun1R
         A2hg==
X-Forwarded-Encrypted: i=1; AJvYcCVaWW3R/WpP1ChD5WFAeUXzA6UxxJfA3ANUidkN1DYcTdVz+MPRL40kQuSVEyZKQCKttRhTDh1UoKIiMr2J@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2UZmIznGU9WB/hzUR1D8EaRGPBBeCCCUnYJ49IdCA1eSjf6M
	wauaHih+SAcxp2OAT/xYIz5auzhfzsi0ZMiAdKrJO7FJC1nHGJ6cBsh7AaHAvJs=
X-Google-Smtp-Source: AGHT+IEI7yiEk5IiJcitmWeLLauSS6dqRLSeWVvDsuHj1ewoa+0LxE0UBx6ziJqrtHINodWPpK3v3w==
X-Received: by 2002:a17:90a:aa0b:b0:2d8:8920:771c with SMTP id 98e67ed59e1d1-2dbb9f3a6ccmr21926575a91.32.1726653272024;
        Wed, 18 Sep 2024 02:54:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd608dceabsm1141103a91.28.2024.09.18.02.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 02:54:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sqrOF-006kam-2U;
	Wed, 18 Sep 2024 19:54:27 +1000
Date: Wed, 18 Sep 2024 19:54:27 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
	dchinner@redhat.com
Subject: Re: [RFC 0/5] ext4: Implement support for extsize hints
Message-ID: <ZuqjU0KcCptQKrFs@dread.disaster.area>
References: <cover.1726034272.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726034272.git.ojaswin@linux.ibm.com>

On Wed, Sep 11, 2024 at 02:31:04PM +0530, Ojaswin Mujoo wrote:
> This patchset implements extsize hint feature for ext4. Posting this RFC to get
> some early review comments on the design and implementation bits. This feature
> is similar to what we have in XFS too with some differences.
> 
> extsize on ext4 is a hint to mballoc (multi-block allocator) and extent
> handling layer to do aligned allocations. We use allocation criteria 0
> (CR_POWER2_ALIGNED) for doing aligned power-of-2 allocations. With extsize hint
> we try to align the logical start (m_lblk) and length(m_len) of the allocation
> to be extsize aligned. CR_POWER2_ALIGNED criteria in mballoc automatically make
> sure that we get the aligned physical start (m_pblk) as well. So in this way
> extsize can make sure that lblk, len and pblk all are aligned for the allocated
> extent w.r.t extsize.
> 
> Note that extsize feature is just a hinting mechanism to ext4 multi-block
> allocator. That means that if we are unable to get an aligned allocation for
> some reason, than we drop this flag and continue with unaligned allocation to
> serve the request. However when we will add atomic/untorn writes support, then
> we will enforce the aligned allocation and can return -ENOSPC if aligned
> allocation was not successful.
> 
> Comparison with XFS extsize feature -
> =====================================
> 1. extsize in XFS is a hint for aligning only the logical start and the lengh
>    of the allocation v/s extsize on ext4 make sure the physical start of the
>    extent gets aligned as well.

What happens when you can't align the physical start of the extent?
It fails the allocation with ENOSPC?

For XFS, the existing extent size behaviour is a hint, and so we
ignore the hint if we cannot perform the allocation with the
suggested alignment. i.e. We should not fail an allocation with an
extent size hint until we are actually very near ENOSPC.

With the new force-align feature, the physical alignment within an
AG gets aligned to the extent size. In this case, if we can't find
an aligned free extent to allocate, we fail the allocation (ENOSPC).
Hence with forced alignment, we can have ENOSPC occur when there are
large amounts of free space available in the filesystem.

This is almost certainly what most people -don't want-, but it is a
requirement for atomic writes. To make matters worse, this behaviour
will almost certainly get worst as filesystem ages and free space
slowly fragments over time.

IOWs, by making the ext4 extsize have forced alignment semantics by
default, it means users will see ENOSPC at lot more frequently and
in situations where it is most definitely not expected.

We also have to keep in mind that there are applications out there
that set and use extent size hints, and so enabling extsize in ext4
will result in those applications silently starting to use them. If
ext4 supporting extsize hints drastically changes the behaviour of
the filesystem then that is going to cause significant unexpected
regressions for users as they upgrade kernels and filesystems.

Hence I strongly suggest that ext4 implements extent size hints in
the same way that XFS does. i.e. unless forced alignment has been
enabled for the inode, extsize is just a hint that gets discarded if
aligned allocation does not succeed.

Behaviour such as extent size hinting *should* be the same across
all filesystems that provide this functionality.  This makes using
extent size hints much easier for users, admins and application
developers. The last thing I want to hear is application devs tell
me at conferences that "we don't use extent size hints anymore
because ext4..."

> 2. eof allocation on XFS trims the blocks allocated beyond eof with extsize
>    hint. That means on XFS for eof allocations (with extsize hint) only logical
>    start gets aligned.

I'm not sure I understand what you are saying here. XFS does extsize
alignment of both the start and end of post-eof extents the same as
it does for extents within EOF. For example:

# xfs_io -fdc "truncate 0" -c "extsize 16k" -c "pwrite 0 4k" -c "bmap -vvp" foo
wrote 4096/4096 bytes at offset 0
4 KiB, 1 ops; 0.0308 sec (129.815 KiB/sec and 32.4538 ops/sec)
foo:
EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..7]:          256504..256511    0 (256504..256511)     8 000000
   1: [8..31]:         256512..256535    0 (256512..256535)    24 010000
 FLAG Values:
    0100000 Shared extent
    0010000 Unwritten preallocated extent

There's a 4k written extent at 0, and a 12k unwritten extent
beyond EOF at 4k. I.e. we have an extent of 16kB as the hint
required that is correctly aligned beyond EOF.

If I then write another 4k at 20k (beyond both EOF and the unwritten
extent beyond EOF:

# xfs_io -fdc "truncate 0" -c "extsize 16k" -c "pwrite 0 4k" -c "pwrite 20k 4k" -c "bmap -vvp" foo
wrote 4096/4096 bytes at offset 0
4 KiB, 1 ops; 0.0210 sec (190.195 KiB/sec and 47.5489 ops/sec)
wrote 4096/4096 bytes at offset 20480
4 KiB, 1 ops; 0.0001 sec (21.701 MiB/sec and 5555.5556 ops/sec)
foo:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..7]:          180000..180007    0 (180000..180007)     8 000000
   1: [8..39]:         180008..180039    0 (180008..180039)    32 010000
   2: [40..47]:        180040..180047    0 (180040..180047)     8 000000
   3: [48..63]:        180048..180063    0 (180048..180063)    16 010000
 FLAG Values:
    0100000 Shared extent
    0010000 Unwritten preallocated extent

You can see we did contiguous allocation of another 16kB at offset
16kB, and then wrote to 20k for 4kB.. i.e. the new extent was
correctly aligned at both sides as the extsize hint says it should
be....

>    However extsize hint in ext4 for eof allocation is not
>    supported in this version of the series.

If you can't do extsize aligned allocations for EOF extension, then
how to applications use atomic writes to atomically extend the file?

> 3. XFS allows extsize to be set on file with no extents but delayed data.

It does?

<looks>

Yep, it doesn't check ip->i_delayed_blks is zero when changing
extsize.

I think that's simply a bug, not intended behaviour, because
delalloc will not have reserved space for the extsize hint rounding
needed when writeback occurs. Can you send a patch to add this
check?

>    However, ext4 don't allow that for simplicity. The user is expected to set
>    it on a file before changing it's i_size.

We don't actually care about i_size in XFS - the determining factor
is whether there are extents allocated on disk. i.e. we can truncate
up and then set the extent size hint because there are no extents
allocated even though the size is non-zero. 

There are almost certainly applications out there that change extent
size after truncating to a non-zero size, so this needs to work on
ext4 the same way it does on XFS. Otherwise people are going to
complain that their applications suddenly stop working properly on
ext4....

> 4. XFS allows non-power-of-2 values for extsize but ext4 does not, since we
>    primarily would like to support atomic writes with extsize.

Yes, ext4 can make that restriction if desired.

Keep in mind that the XFS atomic write support is still evolving,
and I think the way we are using extent size hints isn't fully
solidified yet.

Indeed, I think that we can allow non-power-of-2 extent sizes for
atomic writes, because integer multiples of the atomic write unit
will still ensure that physical extents are properly aligned for
atomic writes to succeed.  e.g. 24kB extent size is compatible with
8kB atomic write sizes.

To make that work efficiently unwritten extent boundaries need to be
maintained at atomic write alignments (8kB), not extent size
alignment (24kB), but other than that I don't think anything else is
needed....

This is desirable because it will allow extent size hints to remain
usable for their original purposes even with atomic writes on XFS.
i.e. fragmentation minimisation for small random DIO write worklaods
(exactly the sort of IO you'd consider using atomic writes for!),
alignment of extents to [non-power-of-2] RAID stripe geometry, etc.

> 5. In ext4 we chose to store the extsize value in SYSTEM_XATTR rather than an
>    inode field as it was simple and most flexible, since there might be more
>    features like atomic/untorn writes coming in future.

Does that mean you can query and set it through the user xattr
interfaces? If so, how do you enforce the values users set are
correct?

> 6. In buffered-io path XFS switches to non-delalloc allocations for extsize hint.
>    The same has been kept for EXT4 as well.

That's an internal XFS implementation detail that you don't need to
replicate. Historically speaking, we didn't use unwritten extents
for delayed allocation and so we couldn't do within-EOF extsize
unaligned writes without adding special additional zero-around code to
ensure that we never exposed stale data to userspace from the extra
allocation that the data write did not cover.

We now use unwritten extents for delalloc conversion, so this istale
data exposure issue no longer exists. We should really switch this
code back to using delalloc because it is much faster and less
fragmentation prone than direct extsize allocation....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

