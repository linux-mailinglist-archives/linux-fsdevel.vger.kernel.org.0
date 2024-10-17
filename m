Return-Path: <linux-fsdevel+bounces-32168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F519A1A0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 06:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084FB28614D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 04:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AA51779AE;
	Thu, 17 Oct 2024 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccweTbJ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F916BE0D
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 04:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140835; cv=none; b=u0Jgzz2q4KC+VTjRCVOgtQNzqB/ZRTjPi+nAoYDgf4Hrlk9HAs/s7lYPCQhnyI4EkdTxtvebHum0N/dHrj+lK9mcRkCVq9A/LqbIc+BjTpvl0itMk8EuuFLGAc6R7bGu1aQTLAlEP7D/KMEaladNMDMTvpw889lou0XgZvMcNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140835; c=relaxed/simple;
	bh=97DNx9gdVThlibrCf7mEAf4DJ7ZUx62BwJubMb0Yg7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3q2mYfgMAAk7I8na/sbklvccwlR5Ao+zVhu+7tBeMj9PzSjjXF9cf9d9prqidocO8MaaTCcYzzDFhT3f9g9j1yaG1YTsZBct0Qlnj+BKD+8ftEqCCS4R9E4YcIi3sXkx2Y4bpCfURzi92JEdjLSff9g1G0ycus6w2lhXqMdmKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccweTbJ1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so15739a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 21:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729140832; x=1729745632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnKl1QwbwUsKFMP4HLrcYnPjaoTQ17Jib2qe3x9b52Q=;
        b=ccweTbJ1kl/T162izeTUMnGFo+V4NXz1Hr+FY+3DBkttEJyrHOlYQl6/PZLdZSnGza
         FPoBu1r9JzsfNbqwg/+5/JClDErWaVUYmWAJqoZMGqsQuYTeJdNTiT5B2cnO1mMDpBcb
         VrgAaD/cLniKfDDCocaM7mGhRYzT2Q42xJfg+6yIDuJol1EMt1d5cyLlp7wr90C9zhxK
         CqIR+cyIUIbGg0LUX9PiXp4VEiTBQoOsntZoHP3/M00zkGOF8O7rn3yUumFpwoO0A5v/
         /Gqh5xyPlW7hT9gX5OUkJmjDRZS7xivNlv+Dc37wqQw4qSeRg+sH5KAB8y0crcVsVFOZ
         pTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729140832; x=1729745632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnKl1QwbwUsKFMP4HLrcYnPjaoTQ17Jib2qe3x9b52Q=;
        b=r3jBfBrxgNqgchnKxJCLrjQiTdJO54U9WvIaewB3E6pYo7hJSRcpVj/IlV+AGB7ScO
         ixjPo/+RUQkgxYQU5tYC/q3FR+YzANvnuVgt2/XqTxMZH/SxcATDU5FHSQmwBPXmxhtj
         caulSgilgnV/l0xEkOfuW4Qme0TYOV76RR5H/FPlzHxs13XDFP+Il/yALvPE3mFQzL6m
         L3w72S6MGZDa8QxxHp3/SSS6FVk2vFWV0yqHWvsVfa5oXCFKuCB40j8KPmZPIGHN3Yz1
         PrgURZmKj36KvPonq56wudmNFUTViZIpkVhy3TMWe80PPIj99qz3mMC6zyuIup4Jeplk
         B+UA==
X-Forwarded-Encrypted: i=1; AJvYcCVg60cW3+6NE58TE0MQRUBFuP7EzN0IchexIh8fVXsnmOP3TOqWwLlc9o/csdCoTfo2e/aumL4A0RvMutCI@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAcEqKGYYuT4NrnrnQ+pFBmwDallyvtS2S7x/OG2ldKpihRh3
	7DUL0KDIocr3OmUxoXMaY8h8grdbYY3nIO1zWUe55G9J5PpEm2v/QtK36eLcvjS/w8vnOMTx0VN
	eb2yGgYG7+BPjjTYJZ+ksp1HuyGNl2qqKK0Nb
X-Google-Smtp-Source: AGHT+IFCcmMy3OXU8QksT8UF+eXw1a4ADFyOFkBS5bVywWQA6mQyQwUxzFuW9jnMvnjqseJvwvlsa8cfN9d+elGiJq8=
X-Received: by 2002:a05:6402:2355:b0:5c8:84b5:7e78 with SMTP id
 4fb4d7f45d1cf-5c9a6613d7fmr307679a12.4.1729140831633; Wed, 16 Oct 2024
 21:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805093245.889357-1-jgowans@amazon.com>
In-Reply-To: <20240805093245.889357-1-jgowans@amazon.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Thu, 17 Oct 2024 10:23:38 +0530
Message-ID: <CAGtprH949pMq0GrQzyMvHNCFet+5MrcYBd=qPEscW1KtV5LjXg@mail.gmail.com>
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
	Paul Durrant <pdurrant@amazon.co.uk>, Nicolas Saenz Julienne <nsaenz@amazon.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 3:03=E2=80=AFPM James Gowans <jgowans@amazon.com> wr=
ote:
>
> In this patch series a new in-memory filesystem designed specifically
> for live update is implemented. Live update is a mechanism to support
> updating a hypervisor in a way that has limited impact to running
> virtual machines. This is done by pausing/serialising running VMs,
> kexec-ing into a new kernel, starting new VMM processes and then
> deserialising/resuming the VMs so that they continue running from where
> they were. To support this, guest memory needs to be preserved.
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

I am guessing this goal was before we discussed the need of supporting
mmap on guest_memfd for confidential computing usecases to support
hugepages [1]. This series [1] as of today tries to leverage hugetlb
allocator functionality to allocate huge pages which seems to be along
the lines of what you are aiming for. There are also discussions to
support NUMA mempolicy [2] for guest memfd. In order to use
guest_memfd to back non-confidential VMs with hugepages, core-mm will
need to support PMD/PUD level mappings in future.

David H's suggestion from the other thread to extend guest_memfd to
support guest memory persistence over kexec instead of introducing
guestmemfs as a parallel subsystem seems appealing to me.

[1] https://lore.kernel.org/kvm/cover.1726009989.git.ackerleytng@google.com=
/T/
[2] https://lore.kernel.org/kvm/47476c27-897c-4487-bcd2-7ef6ec089dd1@amd.co=
m/T/

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
>
> 2. NUMA support is currently non-existent. To make this more generally
> useful it's necessary to have NUMA-awareness. One thought on how to do
> this is to be able to specify multiple allocations with wNUMA affinity
> on the kernel cmdline and have multiple mount points, one per NUMA node.
> Currently, for simplicity, only a single contiguous filesystem data
> allocation and a single mount point is supported.
>
> 3. MCEs are currently not handled - we need to add functionality for
> this to be able to track block ownership and deliver an MCE correctly.
>
> 4. Looking for reviews from filesystem experts to see if necessary
> callbacks, refcounting, locking, etc, is done correctly.
>
> Open questions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> It is not too clear if or how guestmemfs should use DAX as a source of
> memory. Seeing as guestmemfs has an in-memory design, it seems that it
> is not necessary to use DAX as a source of memory, but I am keen for
> guidance/input on whether DAX should be used here.
>
> The filesystem data memory is removed from the direct map for secret
> hiding, but it is still necessary to mmap it to be accessible to KVM.
> For improving secret hiding even more a guest_memfd-style interface
> could be used to remove the need to mmap. That introduces a new problem
> of the memory being completely inaccessible to KVM for this like MMIO
> instruction emulation. How can this be handled?
>
> Related Work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> There are similarities to a few attempts at solving aspects of this
> problem previously.
>
> The original was probably PKRAM from Oracle; a tempfs filesystem with
> persistence:
> https://lore.kernel.org/kexec/1682554137-13938-1-git-send-email-anthony.y=
znaga@oracle.com/
> guestmemfs will additionally provide secret hiding, PMD/PUD allocations
> and a path to DMA persistence and NUMA support.
>
> Dmemfs from Tencent aimed to remove the need for struct page overhead:
> https://lore.kernel.org/kvm/cover.1602093760.git.yuleixzhang@tencent.com/
> Guestmemfs provides this benefit too, along with persistence across
> kexec and secret hiding.
>
> Pkernfs attempted to solve guest memory persistence and IOMMU
> persistence all in one:
> https://lore.kernel.org/all/20240205120203.60312-1-jgowans@amazon.com/
> Guestmemfs is a re-work of that to only persist guest RAM in the
> filesystem, and to use KHO for filesystem metadata. IOMMU persistence
> will be implemented independently with persistent iommufd domains via
> KHO.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> The testing for this can be seen in the Documentation file in this patch
> series. Essentially it is using a guestmemfs file for a QEMU VM's RAM,
> doing a kexec, restoring the QEMU VM and confirming that the VM picked
> up from where it left off.
>
> James Gowans (10):
>   guestmemfs: Introduce filesystem skeleton
>   guestmemfs: add inode store, files and dirs
>   guestmemfs: add persistent data block allocator
>   guestmemfs: support file truncation
>   guestmemfs: add file mmap callback
>   kexec/kho: Add addr flag to not initialise memory
>   guestmemfs: Persist filesystem metadata via KHO
>   guestmemfs: Block modifications when serialised
>   guestmemfs: Add documentation and usage instructions
>   MAINTAINERS: Add maintainers for guestmemfs
>
>  Documentation/filesystems/guestmemfs.rst |  87 +++++++
>  MAINTAINERS                              |   8 +
>  arch/x86/mm/init_64.c                    |   2 +
>  fs/Kconfig                               |   1 +
>  fs/Makefile                              |   1 +
>  fs/guestmemfs/Kconfig                    |  11 +
>  fs/guestmemfs/Makefile                   |   8 +
>  fs/guestmemfs/allocator.c                |  40 +++
>  fs/guestmemfs/dir.c                      |  43 ++++
>  fs/guestmemfs/file.c                     | 106 ++++++++
>  fs/guestmemfs/guestmemfs.c               | 160 ++++++++++++
>  fs/guestmemfs/guestmemfs.h               |  60 +++++
>  fs/guestmemfs/inode.c                    | 189 ++++++++++++++
>  fs/guestmemfs/serialise.c                | 302 +++++++++++++++++++++++
>  include/linux/guestmemfs.h               |  16 ++
>  include/uapi/linux/kexec.h               |   6 +
>  kernel/kexec_kho_in.c                    |  12 +-
>  kernel/kexec_kho_out.c                   |   4 +
>  18 files changed, 1055 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/filesystems/guestmemfs.rst
>  create mode 100644 fs/guestmemfs/Kconfig
>  create mode 100644 fs/guestmemfs/Makefile
>  create mode 100644 fs/guestmemfs/allocator.c
>  create mode 100644 fs/guestmemfs/dir.c
>  create mode 100644 fs/guestmemfs/file.c
>  create mode 100644 fs/guestmemfs/guestmemfs.c
>  create mode 100644 fs/guestmemfs/guestmemfs.h
>  create mode 100644 fs/guestmemfs/inode.c
>  create mode 100644 fs/guestmemfs/serialise.c
>  create mode 100644 include/linux/guestmemfs.h
>
> --
> 2.34.1
>
>

