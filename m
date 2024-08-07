Return-Path: <linux-fsdevel+bounces-25381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1056294B3D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 01:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87012281ED6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A484156237;
	Wed,  7 Aug 2024 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upK82fJx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD684037
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074340; cv=none; b=emNIRZ0/3CcOyYX+c7qntWwKOFTSiV++spKyCtM4EzXvc8t1s38MF606Cpt5UgGVb1uijFOnGaXwYJkyKAeusVZfWJVOjf/UHgnonXbmzjbeWiGBtb0ZcFxP6yMm2m4jwh+XDYIKnwuzP/2vzQQtoUHG5y0Y6V1tgIlH8YBhm7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074340; c=relaxed/simple;
	bh=zaOh2SrN78k13gIAB523hKMDCQwuksmMWM6kmyL4JCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6LVpn6qg7vgKMpMz0MdfCtBSZ2u9QQrg0eMTrj4aMcLNWn1OF4J+6KVupWzt9370e+IE2LhfJV+H0fWJogBmxO5UtI9cXFyaKN0JTWveWp7HJiPsp60TgVTYtSIhhvz3lqaOJEmMdrqCbnTEj5XatxpqfrevXWLooTnE00DwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upK82fJx; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367963ea053so294233f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723074337; x=1723679137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaOh2SrN78k13gIAB523hKMDCQwuksmMWM6kmyL4JCE=;
        b=upK82fJx3fOM49m0lroBGccsssYkfAuK3nkq4Pe4Rjo+LwOMpGQROxuhVzR4FIs7p4
         Bcp3CmojFkxh4/2/2jeUUziD2z4IxIt90SXPVkT6ZqIF6+rYQ8b0i/zLy3z2vgbVsb4g
         xHM+fMLOnLOxy7XoCJ+d5wqNeb+MkGSijwai8BovIhOI+0lCUBXcVunIBtjWP3YK7yQi
         WqO8T4m/beh8Un54qnRXWfLRK3TMS2Kn04OV/UYbPVdJyttphglR5gQo2TrZGBJCaXc1
         ivvET1JqcgkAT8T7FGQ4VmiAwGyFAhvnYciNpnVkyiBGCZEIZdhuMvvFKVtYRPcDdpin
         qANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723074337; x=1723679137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaOh2SrN78k13gIAB523hKMDCQwuksmMWM6kmyL4JCE=;
        b=QInJLWMaehZxM1G+I6auuCwMvrx0eR98aurnu7pALrA+8V31fav7RTSvTIQxgA1C8S
         fWCDu2gXnCtGEOauVkRwacqhd042feamYemDbs7ziibEJzAiw38jRG6jSrS2GHu0xmLi
         fHIJFvO9BI7UPdy6UP1ggdDYpJmQXtRexoo+snGjN4XSNhZbSfGBuaWi9fjJ3t5tWwQU
         XIdJmZprR6wUJIpzDPxeOi81eR2WFE3L7VasbDwRExcgfL1dr5H3lIz37XhWgXLnkDJg
         fjcvLHCp2GSnQQzG3j3JeVJ9mDS5pErbSG+GNDLLFmg8doZi9RInZbgMmUcTq46qlSRe
         xTiA==
X-Forwarded-Encrypted: i=1; AJvYcCUZN6F+SlcCUkBIRebENawzGGdUf4gDB693RtVkdSUERiLmEssgOlYVZWfXrRRAgwZllaWJlSrfewxNBGWj09YGg3mvqDAhs9vFvMnKGg==
X-Gm-Message-State: AOJu0Ywf3JGYfyOVYQSRCe3leCIrQHFayW88/r/JLeT9vfYaa5XCofuo
	4HwUJDhg6xy3noFnt0d6iENzUxHMbbHRpk2jAW6lDkr3wwBWIlbE/j9NofJWGZ/vzHZ7xKOQmzl
	RbaYhIQPBIwdXlupchKqZyfelxoK5HMBnAkfG
X-Google-Smtp-Source: AGHT+IEMy5+rvA8Xz5XXMZ4V8cfK+CB3M8rXAjQ//+EAwYb7kYKY/NsJjZngCQzHzQMhpt1v7lVc4+xra3gtXcLRy7U=
X-Received: by 2002:adf:f842:0:b0:366:f04d:676f with SMTP id
 ffacd0b85a97d-36d274dc2e5mr83350f8f.12.1723074336434; Wed, 07 Aug 2024
 16:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805093245.889357-1-jgowans@amazon.com>
In-Reply-To: <20240805093245.889357-1-jgowans@amazon.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 7 Aug 2024 16:45:07 -0700
Message-ID: <CALzav=ddnKykNSH1WVM5i74MFHSj7BO+bZWkfQpRO0fc0g8_mQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory filesystem
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Steve Sistare <steven.sistare@oracle.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-fsdevel@vger.kernel.org, 
	Usama Arif <usama.arif@bytedance.com>, kvm@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Paul Durrant <pdurrant@amazon.co.uk>, Nicolas Saenz Julienne <nsaenz@amazon.es>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Mon, Aug 5, 2024 at 2:33=E2=80=AFAM James Gowans <jgowans@amazon.com> wr=
ote:
>
> In this patch series a new in-memory filesystem designed specifically
> for live update is implemented. Live update is a mechanism to support
> updating a hypervisor in a way that has limited impact to running
> virtual machines. This is done by pausing/serialising running VMs,
> kexec-ing into a new kernel, starting new VMM processes and then
> deserialising/resuming the VMs so that they continue running from where
> they were. To support this, guest memory needs to be preserved.

How do you envision VM state (or other userspace state) being
preserved? I guess it could just be regular files on this filesystem
but I wonder if that would become inefficient if the files are
(eventually) backed with PUD-sized allocations.

>
> Guestmemfs implements preservation acrosss kexec by carving out a large
> contiguous block of host system RAM early in boot which is then used as
> the data for the guestmemfs files. As well as preserving that large
> block of data memory across kexec, the filesystem metadata is preserved
> via the Kexec Hand Over (KHO) framework (still under review):
> https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com/
>
> Filesystem metadata is structured to make preservation across kexec
> easy: inodes are one large contiguous array, and each inode has a
> "mappings" block which defines which block from the filesystem data
> memory corresponds to which offset in the file.
>
> There are additional constraints/requirements which guestmemfs aims to
> meet:
>
> 1. Secret hiding: all filesystem data is removed from the kernel direct
> map so immune from speculative access. read()/write() are not supported;
> the only way to get at the data is via mmap.
>
> 2. Struct page overhead elimination: the memory is not managed by the
> buddy allocator and hence has no struct pages.

I'm curious if there any downsides of eliminating struct pages? e.g.
Certain operations/features in the kernel relevant for running VMs
that do not work?

>
> 3. PMD and PUD level allocations for TLB performance: guestmemfs
> allocates PMD-sized pages to back files which improves TLB perf (caveat
> below!). PUD size allocations are a next step.
>
> 4. Device assignment: being able to use guestmemfs memory for
> VFIO/iommufd mappings, and allow those mappings to survive and continue
> to be used across kexec.
>
>
> Next steps
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The idea is that this patch series implements a minimal filesystem to
> provide the foundations for in-memory persistent across kexec files.
> One this foundation is in place it will be extended:
>
> 1. Improve the filesystem to be more comprehensive - currently it's just
> functional enough to demonstrate the main objective of reserved memory
> and persistence via KHO.
>
> 2. Build support for iommufd IOAS and HWPT persistence, and integrate
> that with guestmemfs. The idea is that if VMs have DMA devices assigned
> to them, DMA should continue running across kexec. A future patch series
> will add support for this in iommufd and connect iommufd to guestmemfs
> so that guestmemfs files can remain mapped into the IOMMU during kexec.
>
> 3. Support a guest_memfd interface to files so that they can be used for
> confidential computing without needing to mmap into userspace.
>
> 3. Gigantic PUD level mappings for even better TLB perf.
>
> Caveats
> =3D=3D=3D=3D=3D=3D=3D
>
> There are a issues with the current implementation which should be
> solved either in this patch series or soon in follow-on work:
>
> 1. Although PMD-size allocations are done, PTE-level page tables are
> still created. This is because guestmemfs uses remap_pfn_range() to set
> up userspace pgtables. Currently remap_pfn_range() only creates
> PTE-level mappings. I suggest enhancing remap_pfn_range() to support
> creating higher level mappings where possible, by adding pmd_special
> and pud_special flags.

This might actually be beneficial.

Creating PTEs for userspace mappings would make it for UserfaultFD to
intercept at PAGE_SIZE granularity. A big pain point for Google with
using HugeTLB is the inability to use UsefaultFD to intercept at
PAGE_SIZE for the post-copy phase of VM Live Migration.

As long as the memory is physically contiguous it should be possible
for KVM to still map it into the guest with PMD or PUD mappings.
KVM/arm64 already even has support for that for VM_PFNMAP VMAs.

