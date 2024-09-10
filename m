Return-Path: <linux-fsdevel+bounces-28971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF12972793
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 05:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1082284611
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 03:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41216DEA7;
	Tue, 10 Sep 2024 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/+hfiNi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E215FA74;
	Tue, 10 Sep 2024 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725938199; cv=none; b=RjZi1yp/jdYkU0cxFrmEErr38AYe9NkmPC2eyn++nQjQYPfpVle3oajgP+mzfvt+vqV/Ifq9ZgLpDjHu51Huripw+N7Ev6oA+pgioe4aG6q0am5v1QRv/Dn290q7FQLbl7scnGFOMgrCFaryoIInrz1kiquu5V9PsP9YG45fJnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725938199; c=relaxed/simple;
	bh=RI7vaofvvvg8pKNCcQiGiuheIucLz0wnhFCtQ0t4ff4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=dcnrMfvSqKqHHXiIgXYbksv3GWBkrcThWmBcMpLles+JrIFmBSerXR3AvKfBQdKjgiErzrVDK133utHkR0nrLKU2hiIdP6S7RLwbL/qErtBUv/xTN229ETq8iD7XDaKFk11tDg0L8/nN30GQ3UiufcOJhCjDFN7WMOvS/fgw+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/+hfiNi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2068bee21d8so49566495ad.2;
        Mon, 09 Sep 2024 20:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725938197; x=1726542997; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Xriae1tNLH7ACZvKSa9eB14DPc11SseH7yztypTP8I=;
        b=Z/+hfiNiNbjIfj6BuYhhSgX92E6OL/6xXumy2BFJ2EK8so0dh5/5dQfALQ3yHUUQLt
         w8RoMmkeEG6g7dB3aHVtN20ytsCglGLl/BUICHZzUUrQWGv1frYJ8vIn1FdQgJ1uHVja
         KhxnY4AfHMnuSfapiIr1dSQruDI88V5ojbQB20bGijGzhhTZxXyATj76a/WxxQL2pKSi
         Tp+VpDFnBXVjXi0An6L5o8PcRa/1izODLQJGD7QpyXJVAuGBBYtWHmkQBBLDSArVLPGP
         tewLtNTAlwcdhS67uQjH8s1H1pQ87JgFC3m16JAgQV19+3CvTgOdR/tY7UjYTNUQZwH9
         7T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725938197; x=1726542997;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Xriae1tNLH7ACZvKSa9eB14DPc11SseH7yztypTP8I=;
        b=BQZRX4pWAcfMFGgbivtahz33Xm4RGBWg+dFYpIKWnY/MD2HxxEBMrOlztgGSIGu9PD
         uNladeclaMDhep3nFfXdU3LIkEkkWZpwQSTkwuLwRRM3eZ4DbEQwxyvokNCwfZXZx/Kk
         Ye9I3Sj8NKqYHZWfBFos8gx+I9n+v2hcg9bPV4htU2jFVO4ADVLBijg7QdunULGzY+Ae
         Wqb6I9J8BxBRvbzOK2jFtBsNadYZy03sR2n/KSdb+FKHqals/ecZzatMK3+RexwP7QN3
         f0b9sBaacfAtUEp23FSfabVBuNE7EMj1AQ2X70xNqwX6jwukn1pWwnsYwDPaceCizf+h
         5SDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDqQEovVehW0CjKtOr+LBXgzKH55QFpJGsS9jEnMfRL28PHPjDlJeQvvBBheOSW/yqQg2bfc+0rtQaK327@vger.kernel.org, AJvYcCW21REGCdSfZ1kl1drF/S7dSwAaMJlXbwTkN8L5RmTIs3ilSTGHmdoMxTeXhpNzrg+vW5RClteQhV2w@vger.kernel.org, AJvYcCWw3NaIwoZxSiRv+d1NJhJFbAr9YrtahsVRJUSGWz3jI5QghvrBG64HCN2UGHBatoEFqicr365E00IgM32e@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbISlmpvx/9tS7x8VZ8KuOpiFi4TR7tir647oZvGBWxxtkTnd
	O4y9VKuDc1BPDl/Tqtm12MLzupo+xz0KLSPShPllLSZHaBrJZKri
X-Google-Smtp-Source: AGHT+IGvb6xXL3VBFMKGimtbpm8nNpUqoPcGgEmsTaD6ZrtVPkudnvh0GC9uLlmFgrICJntK2YSkQA==
X-Received: by 2002:a17:902:e552:b0:207:17f6:9efc with SMTP id d9443c01a7336-20717f69f77mr147502105ad.25.1725938196944;
        Mon, 09 Sep 2024 20:16:36 -0700 (PDT)
Received: from dw-tp ([171.76.84.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e123d1sm40139775ad.53.2024.09.09.20.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 20:16:36 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
In-Reply-To: <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
Date: Tue, 10 Sep 2024 08:21:55 +0530
Message-ID: <877cbkgr04.fsf@gmail.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com> <87frqf2smy.fsf@gmail.com> <ZtjrUI+oqqABJL2j@dread.disaster.area> <877cbq3g9i.fsf@gmail.com> <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Thu, Sep 05, 2024 at 09:26:25AM +0530, Ritesh Harjani wrote:
>> Dave Chinner <david@fromorbit.com> writes:
>> > On Wed, Sep 04, 2024 at 11:44:29PM +0530, Ritesh Harjani wrote:
>> >> 3. It is the FORCEALIGN feature which _mandates_ both allocation
>> >> (by using extsize hint) and de-allocation to happen _only_ in
>> >> extsize chunks.
>> >>
>> >>    i.e. forcealign mandates -
>> >>    - the logical and physical start offset should be aligned as
>> >>    per args->alignment
>> >>    - extent length be aligned as per args->prod/mod.
>> >>      If above two cannot be satisfied then return -ENOSPC.
>> >
>> > Yes.
>> >
>> >> 
>> >>    - Does the unmapping of extents also only happens in extsize
>> >>    chunks (with forcealign)?
>> >
>> > Yes, via use of xfs_inode_alloc_unitsize() in the high level code
>> > aligning the fsbno ranges to be unmapped.
>> >
>> > Remember, force align requires both logical file offset and
>> > physical block number to be correctly aligned,
>> 
>> This is where I would like to double confirm it again. Even the
>> extsize hint feature (w/o FORCEALIGN) will try to allocate aligned
>> physical start and logical start file offset and length right?
>
> No.
>
>> (Or does extsize hint only restricts alignment to logical start file
>> offset + length and not the physical start?)
>
> Neither.
>

Yes, thanks for the correction. Indeed extsize hint does not take care
of the physical start alignment at all.

> extsize hint by itself (i.e. existing behaviour) has no alignment
> effect at all. All it affects is -size- of the extent. i.e. once
> the extent start is chosen, extent size hints will trim the length
> of the extent to a multiple of the extent size hint. Alignment is
> not considered at all.
>

Please correct me I wrong here... but XFS considers aligning the logical
start and the length of the allocated extent (for extsize) as per below
code right? 

i.e.
1) xfs_direct_write_iomap_begin()
{
    <...>
    if (offset + length > XFS_ISIZE(ip))
		end_fsb = xfs_iomap_eof_align_last_fsb(ip, end_fsb);
                  => xfs_fileoff_t aligned_end_fsb = roundup_64(end_fsb, align);
                     return aligned_end_fsb
}

2) xfs_bmap_compute_alignments()
{
    <...>
    	else if (ap->datatype & XFS_ALLOC_USERDATA)
		     align = xfs_get_extsz_hint(ap->ip);

        if (align) {
            if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
                        ap->eof, 0, ap->conv, &ap->offset,
                        &ap->length))
                ASSERT(0);
            ASSERT(ap->length);

            args->prod = align;
            div_u64_rem(ap->offset, args->prod, &args->mod);
            if (args->mod)
                args->mod = args->prod - args->mod;
        }
        <...>
}

So args->prod and args->mod... aren't they use to align the logical
start and the length of the extent?


However, I do notice that when the file is closed XFS trims the length
allocated beyond EOF boundary (for extsize but not for forcealign from
the new forcealign series) i.e.

xfs_file_release() -> xfs_release() -> xfs_free_eofblocks()

I guess that is because xfs_can_free_eofblocks() does not consider
alignment for extsize in this function 

xfs_can_free_eofblocks()
{
<...>
	end_fsb = xfs_inode_roundup_alloc_unit(ip,
			XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip)));
<...>
}




>> Also it looks like there is no difference with ATOMIC_WRITE AND
>> FORCEALIGN feature with XFS, correct? (except that ATOMIC_WRITE is
>> adding additional natural alignment restrictions on pos and len). 
>
> Atomic write requires additional hardware support, and it restricts
> the valid sizes of extent size hints that can be set. Only atomic
> writes can be done on files marked as configured for atomic writes;
> force alignment can be done on any file...
>
>> So why maintain 2 separate on disk inode flags for FORCEALIGN AND
>> ATOMIC_WRITE?
>
> the atomic write flag indicates that a file has been set up
> correctly for atomic writes to be able to issues reliably. force
> alignment doesn't guarantee that - it's just a mechanism that tells
> the allocator to behave a specific way.
>
>> - Do you foresee FORCEALIGN to be also used at other places w/o
>> ATOMIC_WRITE where feature differentiation between the two on an
>> inode is required?
>
> The already exist. For example, reliably allocating huge page
> mappings on DAX filesystems requires 2MB forced alignment. 
>
>> - Does the same reasoning will hold for XFS_SB_FEAT_RO_COMPAT_FORCEALIGN
>> & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES too?
>
> Same as above.
>
>> - But why ro_compact for ATOMICWRITES? There aren't any on disk metadata
>> changes within XFS filesystem to support atomic writes, right? 
>
> Because if you downgrade the kernel to something that doesn't
> support atomic writes, then non-atomic sized/aligned data can be
> written to the file and/or torn writes can occur.
>
> Worse, extent size hints that don't match the underlying hardware
> support could be set up for inodes, and when the kernel is upgraded
> again then atomic writes will fail on inodes that have atomic write
> flags set on them....
>
>> Is it something to just prevent users from destroying their own data
>> by not allowing a rw mount from an older kernel where users could do
>> unaligned writes to files marked for atomic writes?
>> Or is there any other reasoning to prevent XFS filesystem from becoming
>> inconsistent if an older kernel does a rw mount here.
>
> The older kernel does not know what the unknown inode flag means
> (i.e. atomic writes) and so, by definition, we cannot allow it to
> modify metadata or file data because it may not modify it in the
> correct way for that flag being set on the inode.
>
> Kernels that don't understand feature flags need to treat the
> filesystem as read-only, no matter how trivial the feature addition
> might seem.
>
>> > so unmap alignment
>> > has to be set up correctly at file offset level before we even know
>> > what extents underly the file range we need to unmap....
>> >
>> >>      If the start or end of the extent which needs unmapping is
>> >>      unaligned then we convert that extent to unwritten and skip,
>> >>      is it? (__xfs_bunmapi())
>> >
>> > The high level code should be aligning the start and end of the
>> > file range to be removed via xfs_inode_alloc_unitsize(). Hence 
>> > the low level __xfs_bunmapi() code shouldn't ever be encountering
>> > unaligned unmaps on force-aligned inodes.
>> >
>> 
>> Yes, but isn't this code snippet trying to handle a case when it finds an
>> unaligned extent during unmap?
>
> It does exactly that.
>
>> And what we are essentially trying to 
>> do here is leave the unwritten extent as is and if the found extent is
>> written then convert to unwritten and skip it (goto nodelete). This
>> means with forcealign if we encounter an unaligned extent then the file
>> will have this space reserved as is with extent marked unwritten. 
>> 
>> Is this understanding correct?
>
> Yes, except for the fact that this code is not triggered by force
> alignment.
>
> This code is preexisting realtime file functionality. It is used
> when the rtextent size is larger than a single filesytem block.
>
> In these configurations, we do allocation in rtextsize units, but we
> track written/unwritten extents in the BMBT on filesystem block
> granularity. Hence we can have unaligned written/unwritten extent
> boundaries, and if we aren't unmapping a whole rtextent then we
> simply mark the unused portion of it as unwritten in the BMBT to
> indicate it contains zeroes.
>
> IOWs, existing RT files have different IO alignment and
> written/unwritten extent conversion behaviour to the new forced
> alignment feature. The implementation code is shared in many places,
> but the higher level forced alignment functionality ensures there
> are never unaligned unwritten extents created or unaligned
> unmappings asked for. Hence this code does not trigger for the
> forced alignment cases.
>
> i.e. we have multiple seperate allocation alignment behaviours that
> share an implementation, but they do not all behave exactly the same
> way or provide the same alignment guarantees....
>

Thanks for taking time and explaining this. 

-ritesh

