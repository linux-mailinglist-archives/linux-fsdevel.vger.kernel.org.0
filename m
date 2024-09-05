Return-Path: <linux-fsdevel+bounces-28668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77696CE43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9653C287F7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 05:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10F21553AB;
	Thu,  5 Sep 2024 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8MWM6gn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48C2746A;
	Thu,  5 Sep 2024 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725512452; cv=none; b=OOI/G0vLKVVZkmfUAKxyacpPjwLh8FIk+h2MKS78zmRYu6aapQ2sRWfULQ3r6TwaVpTKMWsax6KMQqj5egZNFs0QnRNfL+pMUhPCTgw2G+Nx1Ym1QSafkzigAEPIUUzcWxHdAmzGUHyqXOtDtUi7iZjd4n/znN5TEymX4zfBLEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725512452; c=relaxed/simple;
	bh=szCF6su7n7opOPlg78Ppt6/m/5ItwyNa6v2osPgJfrU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=OuKKaNtHPAjk3C0SBEuKwvJ4OF23Y0rZfgyvDDhnqBnrs0f1ogtH37NtqSRAEAMktLEGQpXSIZbjh/O74ipIdBRN2V4LrLntZNu0VNrM1v/uHRb9sVWPSlfMsy0q8AlwpJGiyZt7rAJF/pN+dYaHFGwTqGcL+GWpnroa9PEDRss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8MWM6gn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2068a7c9286so3319795ad.1;
        Wed, 04 Sep 2024 22:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725512450; x=1726117250; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=crv8/XRMN/yKeUdw0fXjp08+rBf1MQaXNgVe8p0bT+A=;
        b=K8MWM6gnivp8YEJllqFdVBWxbyyKL9ED4mUwMqJkOcKoNrkHBpcxNhci50NwEPYTcO
         zSHJ2IH2ks6LbX6rwQrWY4JD3svxssVL3HqhBKEHazCU/ktGwBafff5V4eByOiUwc439
         sdKR06s6LwCxnnlUh/GEZb6Zl/3GwYzQQEYOp3d5QYcejZpwi1+2uQBYFZQqfmqYji1p
         lx7SlCW8ZvQeATp/gP4TMOPy6JfH95ANO4ZME0f8sQMETMJ3jV/yxvnpjCjvE1pGu6hM
         IT9jWnC6JR0aNwwF3Js2VyVxg8mCL2MvTDmVqwsSO9YMdQR1+4lbildXp0nZ6+Dix06w
         qXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725512450; x=1726117250;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crv8/XRMN/yKeUdw0fXjp08+rBf1MQaXNgVe8p0bT+A=;
        b=Wx5QeHxgD3TMqerJecJmEvYXAHa7ep5xW6L5/2UgwWzdY40ZVAv6NaqRiTWh6DXIyG
         n6bxmjdzMpFNND8Rx5KPX0Kl6LFD7Hkw9e1ssqnEgrYGtjN3+z+2/bnYpro24JwWV461
         0oNW8aMt7vmpmsNdnE+aG32/XXD0YpXnEs93ZgKBZV9GdfRtZ7wAHkFhys5INecKILFb
         rFzEHOvZCVgsZJWQv8bLWK1/Ck0o1msf2yKmpW4DUQydu6OkKIYM1TKU84aPH2tk2bPS
         lpXMCxdNNw4UyNB3eeBL9Qt3OjV/ESf/r3GFsUqZezpNHzgmQCoJK1KZ/g5TiV+l0T5p
         cf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmWHNZqZaH9eNH9ScacbC1BQVH4dzFZu0rB8HM69kvyAxGA5zGQXk2QISP2/Tmgt8ZAzBB8rxzgYHgvykz@vger.kernel.org, AJvYcCWePVB0rV2qzh+aK72k0Cfn/vGXo3l2H7lwVGTmFvToFOtnMANW2foq+oe/zsTLRWwDzpwIn8rohgcS@vger.kernel.org, AJvYcCWwMK2bs+mQA+kGhl9YnMOpLpAgwLELgMvGcF5MWGZDjtAr0nw257Sna3sRHrgv3zSdz3lhDPMq8zxKVBPB@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbWgK0zZV0HsjSKeAQMq47ri884EoB/86p7YyTja908PHCOqU
	+Vc420jU4MYBJpGVJMaKXY1x8z//3rhtNEQttYLsxNO9SQiHt7QJ
X-Google-Smtp-Source: AGHT+IEFMlP7/JJ5LbvvrL9OcjK21ku3sqP/jFwaU62kppK6j76HiNFmFssbVCw07wvWFJ2Of72vDg==
X-Received: by 2002:a17:902:d2ca:b0:205:627c:7ff9 with SMTP id d9443c01a7336-20584223108mr134006525ad.40.1725512449472;
        Wed, 04 Sep 2024 22:00:49 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea65fe6sm20901685ad.257.2024.09.04.22.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 22:00:48 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
In-Reply-To: <ZtjrUI+oqqABJL2j@dread.disaster.area>
Date: Thu, 05 Sep 2024 09:26:25 +0530
Message-ID: <877cbq3g9i.fsf@gmail.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com> <87frqf2smy.fsf@gmail.com> <ZtjrUI+oqqABJL2j@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Thanks Dave for quick response. 

Dave Chinner <david@fromorbit.com> writes:

> On Wed, Sep 04, 2024 at 11:44:29PM +0530, Ritesh Harjani wrote:
>> John Garry <john.g.garry@oracle.com> writes:
>> 
>> > This series is being spun off the block atomic writes for xfs
>> > series at [0].
>> >
>> > That series got too big.
>> >
>> > The actual forcealign patches are roughly the same in this
>> > series.
>> >
>> > Why forcealign?  In some scenarios to may be required to
>> > guarantee extent alignment and granularity.
>> >
>> > For example, for atomic writes, the maximum atomic write unit
>> > size would be limited at the extent alignment and granularity,
>> > guaranteeing that an atomic write would not span data present in
>> > multiple extents.
>> >
>> > forcealign may be useful as a performance tuning optimization in
>> > other scenarios.
>> >
>> > I decided not to support forcealign for RT devices here.
>> > Initially I thought that it would be quite simple of implement.
>> > However, I discovered through much testing and subsequent debug
>> > that this was not true, so I decided to defer support to
>> > later.
>> >
>> > Early development xfsprogs support is at:
>> > https://github.com/johnpgarry/xfsprogs-dev/commits/atomic-writes/
>> >
>> 
>> Hi John,
>> 
>> Thanks for your continued work on atomic write.  I went over the
>> XFS patch series and this is my understanding + some queries.
>> Could you please help with these.
>
> Hi Ritesh - to make it easier for everyone to read and reply to you
> emails, can you please word wrap the text at 72 columns?
>

argh! Sorry about that. I had formed my queries in a separate notes
application and copy pasted it here. Hopefully this time it will be ok.

>> 1. As I understand XFS untorn atomic write support is built on top
>> of FORCEALIGN feature (which this series is adding) which in turn
>> uses extsize hint feature underneath.
>
> Yes.
>
>>    Now extsize hint mainly controls the alignment of both
>>    "physical start" & "logical start" offset and extent length,
>>    correct?
>
> Yes.
>
>>    This is done using args->alignment for start aand
>>    args->prod/mode variables for extent length. Correct?
>
> Yes.
>
>>    - If say we are not able to allocate an aligned physical start?
>>    Then since extsize is just a hint we go ahead with whatever
>>    best available extent is right?
>
> No. The definition of "forced alignment" is that we guarantee
> aligned allocation to the extent size hint. i.e the extent size hint
> is not a hint anymore - it defines the alignment we are guaranteeing
> allocation will achieve.
>
> hence if we can't align the extent to the alignment provided, we
> fail the alignment.
>
>>    - also extsize looks to be only providing allocation side of hints. (not de-allocation). Correct?
>
> No. See the use of xfs_inode_alloc_unitsize() in all the places
> where we free space. Forced alignment extends this function to
> return the extent size, not the block size.
>

Sorry for not being explicit. For queries in point 1. above, I was
referring to extent size hint feature w/o FORCEALIGN. But I got the
gist from your response. Thanks!

>> 2. If say there is an append write i.e. the allocation is needed
>> to be done at EOF. Then we try for an exact bno (from eof block)
>> and aligned extent length, right?
>
> Yes. This works because the previous extent is exactly aligned,
> hence a contiguous allocation will continue to be correctly aligned
> due to the forced alignment constraints.
>
>>    i.e. xfs_bmap_btalloc_filestreams() ->
>>    xfs_bmap_btalloc_at_eof(ap, args); If it is not available then
>>    we try for nearby bno xfs_alloc_vextent_near_bno(args, target)
>>    and similar...
>
> yes, that's just the normal aligned allocation fallback path when
> exact allocation fails.
>
>> 3. It is the FORCEALIGN feature which _mandates_ both allocation
>> (by using extsize hint) and de-allocation to happen _only_ in
>> extsize chunks.
>>
>>    i.e. forcealign mandates -
>>    - the logical and physical start offset should be aligned as
>>    per args->alignment
>>    - extent length be aligned as per args->prod/mod.
>>      If above two cannot be satisfied then return -ENOSPC.
>
> Yes.
>
>> 
>>    - Does the unmapping of extents also only happens in extsize
>>    chunks (with forcealign)?
>
> Yes, via use of xfs_inode_alloc_unitsize() in the high level code
> aligning the fsbno ranges to be unmapped.
>
> Remember, force align requires both logical file offset and
> physical block number to be correctly aligned,

This is where I would like to double confirm it again. Even the
extsize hint feature (w/o FORCEALIGN) will try to allocate aligned
physical start and logical start file offset and length right?

(Or does extsize hint only restricts alignment to logical start file
offset + length and not the physical start?)


Also it looks like there is no difference with ATOMIC_WRITE AND
FORCEALIGN feature with XFS, correct? (except that ATOMIC_WRITE is
adding additional natural alignment restrictions on pos and len). 
So why maintain 2 separate on disk inode flags for FORCEALIGN AND
ATOMIC_WRITE?
- Do you foresee FORCEALIGN to be also used at other places w/o
ATOMIC_WRITE where feature differentiation between the two on an
inode is required?

- Does the same reasoning will hold for XFS_SB_FEAT_RO_COMPAT_FORCEALIGN
& XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES too?

- But why ro_compact for ATOMICWRITES? There aren't any on disk metadata
changes within XFS filesystem to support atomic writes, right? 
Is it something to just prevent users from destroying their own data
by not allowing a rw mount from an older kernel where users could do
unaligned writes to files marked for atomic writes?
Or is there any other reasoning to prevent XFS filesystem from becoming
inconsistent if an older kernel does a rw mount here.



> so unmap alignment
> has to be set up correctly at file offset level before we even know
> what extents underly the file range we need to unmap....
>
>>      If the start or end of the extent which needs unmapping is
>>      unaligned then we convert that extent to unwritten and skip,
>>      is it? (__xfs_bunmapi())
>
> The high level code should be aligning the start and end of the
> file range to be removed via xfs_inode_alloc_unitsize(). Hence 
> the low level __xfs_bunmapi() code shouldn't ever be encountering
> unaligned unmaps on force-aligned inodes.
>

Yes, but isn't this code snippet trying to handle a case when it finds an
unaligned extent during unmap? And what we are essentially trying to 
do here is leave the unwritten extent as is and if the found extent is
written then convert to unwritten and skip it (goto nodelete). This
means with forcealign if we encounter an unaligned extent then the file
will have this space reserved as is with extent marked unwritten. 

Is this understanding correct?

__xfs_bunmapi(...) 
{
    unsigned int alloc_fsb = xfs_inode_alloc_fsbsize(ip);
    <...>
    while (end != (xfs_fileoff_t)-1 && end >= start &
          (nexts == 0 || extno < nexts)) {
          <...>

          if (alloc_fsb == 1 || (flags & XFS_BMAPI_REMAP))
                goto delete;

         mod = xfs_bmap_alloc_unit_offset(ip, alloc_fsb,
                         del.br_startblock + del.br_blockcount);
         if (mod) {
                 /*
                  * Not aligned to allocation unit on the end.
                  * The extent could have been split into written
                  * and unwritten pieces, or we could just be
                  * unmapping part of it.  But we can't really
                  * get rid of part of an extent.
                  */
                 if (del.br_state == XFS_EXT_UNWRITTEN) {
                         /*
                          * This piece is unwritten, or we're not
                          * using unwritten extents.  Skip over it.
                          */
                         ASSERT((flags & XFS_BMAPI_REMAP) || end >= mod);
                         end -= mod > del.br_blockcount ?
                                 del.br_blockcount : mod;
                         if (end < got.br_startoff &&
                             !xfs_iext_prev_extent(ifp, &icur, &got)) {
                                 done = true;
                                 break;
                         }
                         continue;
                 }
                 /*
                  * It's written, turn it unwritten.
                  * This is better than zeroing it.
                  */
                 ASSERT(del.br_state == XFS_EXT_NORM);
                 ASSERT(tp->t_blk_res > 0);
                 /*
                  * If this spans an extent boundary, chop it back to
                  * the start of the one we end at.
                  */
                 if (del.br_blockcount > mod) {
                         del.br_startoff += del.br_blockcount - mod;
                         del.br_startblock += del.br_blockcount - mod;
                         del.br_blockcount = mod;
                 }
                 del.br_state = XFS_EXT_UNWRITTEN;
                 error = xfs_bmap_add_extent_unwritten_real(tp, ip,
                                 whichfork, &icur, &cur, &del,
                                 &logflags);
                 if (error)
                         goto error0;
                 goto nodelete;
         }

         mod = xfs_bmap_alloc_unit_offset(ip, alloc_fsb,
                                 del.br_startblock);
         if (mod) {
            // handle it for unaligned start block
            <...>
         }
    }
}

> -Dave.


Thanks a lot for answering the queries.

-ritesh

