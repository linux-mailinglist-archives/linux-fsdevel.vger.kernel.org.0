Return-Path: <linux-fsdevel+bounces-29018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7673E973875
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4BC1F218C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE671922E1;
	Tue, 10 Sep 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaVY7oGn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8415674E;
	Tue, 10 Sep 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974311; cv=none; b=BNzNHpSGkroe7T5ExwcSeDGIQG1+HBwZlsVdHrYf8u9XoxaDHc31ym+xfAq1FDpnvltySiEmEIJ9rFKipdkj0rIEy3bbmVglET9FdtRYF+2eoV+Lht+bMIINzRuKipCLYT/AVHT38L9kaZsllG3y0sOong50xoSGgkUXUQPQRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974311; c=relaxed/simple;
	bh=IOI0mwJULIalAjY5tAYle02KG6qoQq1/4/vmstLws20=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=A+Eo/TFu6/nNZTU5+E3bHYHcg5XUD3BE1qvZZQ9w+JchzqMkP7PEjQDgtQ6RCGHbReKtwP4sV1GOdj7iKHUQbS+IvpAccwRRj6dcJVlNZhm/oiHE/a5+iKjfeynUXOZFBP22n7TLpNfwbuP2xyNaBhAaBL44pGAuoM/dSveJnD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaVY7oGn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d91eef2eso2745787b3a.1;
        Tue, 10 Sep 2024 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725974309; x=1726579109; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GZSCd6+9c94uE7g9eY8EW7ZyFVJE0bJLRo9INXMYKaY=;
        b=WaVY7oGnW6j+PBIDcE1wlhAFjNn74kwUAOC3iyfEoq0CakzNovu1c3v1YIbUTog7/w
         BT0xTb3jH7/pW3y0DYor/wLqMS8xxBj396A4iyBpAQBRxPqQdSqZgzZeimJ9WobXghDR
         hK6yqp2DsLK8DHUcKXKeABv/d8WY/80ixB0vAmkVHOimXhjoLPo5RKcq40QJTZIkUMVQ
         nrmueFN0rqZdf7Cr59FxhFoO+5BcFEVPRw7QmWULN4uNthN1g6SK/EwQp79DyNqhR72W
         wCvq4JHt9gc8wpn2KwcfCHK3NFFS+Yzt30G5TT3sn4ca6X3BiC2kn0ZOk8OBRi8DEDFC
         puQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725974309; x=1726579109;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZSCd6+9c94uE7g9eY8EW7ZyFVJE0bJLRo9INXMYKaY=;
        b=LQqXF4feJbRWiXqehli3G0dbu6/BlXBZ43E2OG+dhSVm2kc09fq5AVpneukl+WexFT
         xZU7zGCkWDOSMQtNpJcCAv3sFl9lYqbdvLM5573pOHaMylCPc83tH2nOzcjVR/H4E30k
         ukN3EdY4h4DDmDT1qsE6jD8NouHs8PSuDN8HaBK5yCL4m66YlpmF50SZRs7IXwQK6mfZ
         EgZxCNdL+15oZ5FcYiHObBVnV1NwG3TD1CHJLkKAafJYERIx/aFZpvSpcDKAdjwK6k1J
         aTOEsQh3hulQLwLpxpAVRIkpap5Y8VSnvB9ecAVMWDr6XTp13KsatckyW9NiqNpYmRDx
         YUWw==
X-Forwarded-Encrypted: i=1; AJvYcCU79ejSdV9Q96Wz6bfusorLohEiBpCCTm1BC1WIdGwVkvHND98IujRf/YOV+WzQ/eQ1AoUXPtDeNMAi@vger.kernel.org, AJvYcCVSFnDlXvsWJ3+9E0WfAQRNXetvdcmc/P+rGocVZ5Vc7EKYFhsbSUlr4zCysZzTrh6VrzSguQ3eqBudb/N1@vger.kernel.org, AJvYcCVfeFxQ/bOaXHFFMTGnMXmjHoaX20HhBTDsvo712/OtTUmvGJ60EG2CWuoqGv3OJfguVZuEahnsUePN3cCc@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2u/XKvBiwkbLGeZdKLuGriDKdLaSMMDhLqXmXej8TB5E5g3H
	HUbWGPURuNp6e7JiF1f3R+0LlDmB/cCc7dAHOxhyb7oxPNMbKHSZ
X-Google-Smtp-Source: AGHT+IFYMIl2DfFThQL0MS1eR55Gv9drM5or7sHiHBvgh5wilqXFLTjSDanBiPTDBZf4mLOZQUJZQw==
X-Received: by 2002:a05:6a00:66e4:b0:707:fa61:1c6a with SMTP id d2e1a72fcca58-71907f0f6ddmr4484924b3a.10.1725974308849;
        Tue, 10 Sep 2024 06:18:28 -0700 (PDT)
Received: from dw-tp ([171.76.84.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8255dc20fsm4784462a12.65.2024.09.10.06.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 06:18:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>, John Garry <john.g.garry@oracle.com>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
In-Reply-To: <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
Date: Tue, 10 Sep 2024 18:03:12 +0530
Message-ID: <8734m7henr.fsf@gmail.com>
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
> extsize hint by itself (i.e. existing behaviour) has no alignment
> effect at all. All it affects is -size- of the extent. i.e. once
> the extent start is chosen, extent size hints will trim the length
> of the extent to a multiple of the extent size hint. Alignment is
> not considered at all.
>
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

1. Will it require a fresh formatting of filesystem with mkfs.xfs for
enabling atomic writes (/forcealign) on XFS?
  a. Is that because reflink is not support with atomic writes
  (/forcealign) today?

As I understand for setting forcealign attr on any inode it checks for
whether xfs_has_forcealign(mp). That means forcealign can _only_ be
enabled during mkfs time and it also needs reflink to be disabled with
-m reflink=0. Right?

-ritesh

