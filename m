Return-Path: <linux-fsdevel+bounces-10340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FD284A04B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 18:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FDE1F22E99
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047940C1B;
	Mon,  5 Feb 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9pbUy83"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A491405EB
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153054; cv=none; b=Fg2JGHsV3EiobDnvBlqRRGZLTSxWpKquNm2AU6tHBA6uQT16Yk+mP3UBA1Vuw5xeQCrrexsKYrLbvq7yWJyhwzgsNLyKp9TjowLfNowgbYEmmf36vJxfBb81PgopCzvEbelm6oaaTH2RacFiKppG/mPlAFIOpyGZFIpGuLIWlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153054; c=relaxed/simple;
	bh=ODwmGDdiDxOvkOyAmymCN3LJTH31LAEQLeBQKZmod8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AknRD+rxXCQzQG7s1iTTQ5W29nFf0xK3QMXGfIm5tft9QOa6GGC9qXKITlDY4tQeIf2xiNqSiToRsw6lhh9/HuVOeqxsVQmvXJKX+5jmXdoLKmSBKBbqa9yN1L0OYArAE+qVJhWrgy+RMCquqXy4nfZscg/MRoyFMxiGwylSS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9pbUy83; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707153051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nib0yoG7JD+ruvR7gXIaxGBKD+thIgHlJNkxehoiOFo=;
	b=R9pbUy83KKum4S8GvR5bUxwqNQL/wJ+SqDVc1gZ/fAmcGHGtPh9ltDcQ76hHs7zOlpOStx
	qEM8sem1pIOXPQu61jO8jOzQkI1edbdzSuZnvLt4y5MxyuBc9GpaoEE5WmbcGLtJ71XjNh
	YSmRPKYQJIqvuUmOogx4KdNGFrrxOoY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-kTyHKrgxN9-S8Q8p7EVEOg-1; Mon, 05 Feb 2024 12:10:50 -0500
X-MC-Unique: kTyHKrgxN9-S8Q8p7EVEOg-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf7e0c973eso417067539f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 09:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153044; x=1707757844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nib0yoG7JD+ruvR7gXIaxGBKD+thIgHlJNkxehoiOFo=;
        b=eO+dg49MoDZa9avjmAP9czf1nIjvU4odiTTbOByzGFdQunZ/kDJIsdGUxLFAWAccGi
         q4LTrImYd+hVvBK+fKAwgTFc30oqmKBMaCcW5hBLkSm9R0XONYkj/TmbvzOdtabVimvw
         twYUx7v1zJoovIwxh0NBhFWNDa+bTO1xnmDdyJqwvRJfZC+e/Tk0K1YbUccmXXTEJllj
         affqcI0JgeqymBfkz35LquyFSgzLrx2dUrcI+QELXVKr84cueSXKR8C+3GkZ4NSz6Zew
         IAh7vn/Bf9zV6KhQjlDZfkvyGJXKp/wZzJqEhqmcLLFrbcCNDKypuWDNYZk7XziUhwUD
         5uVA==
X-Gm-Message-State: AOJu0Yw/Jq57mYVqSfseRMc7Lv107TC6S05V+WOTMBNYKLsca9aW4LfN
	RF6nzR6pTPwz5db5ezB8VLqc7Ng16JHQHvG2796BNozrAKobT66QxShdT+XQRjY1SUw/+Wu/WHy
	qdwfrlb8Au0XurV54dc16bXgfSHchvYQkLpMGvrB/RxHegpHLHM4Axj9eWVqAJ78=
X-Received: by 2002:a5d:8412:0:b0:7bf:d163:1e96 with SMTP id i18-20020a5d8412000000b007bfd1631e96mr249405ion.6.1707153044192;
        Mon, 05 Feb 2024 09:10:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKO6hYWmFvS2Su2hWC7d0u3LRIxzLHVbwvno39Gi77SDx3aRVHZqwBPccEE5VURYheXi903w==
X-Received: by 2002:a5d:8412:0:b0:7bf:d163:1e96 with SMTP id i18-20020a5d8412000000b007bfd1631e96mr249387ion.6.1707153043817;
        Mon, 05 Feb 2024 09:10:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWUROPDRa6RoGBSp9QutzWYcyTeRIdJnA0Df9tmn5T6EJ9EZ88g1ohF0e/fnZSxZQrQFn+/2hdmYMlqjYVdeThrOmJN7KwQ7qP5XCd48a58oHdeZD6stx9QdKZV6841AdpV0mG+bR8JBtfyzStjQq034bCONz8sut7uj9NSBCBkusITyKnMb2hDJjnwXhuB2/vi2yaK+yI+OBNBv7XE46aql/hixSc79mLyTbxp5DUzgklAk1XT4UUv1gnu1vRmR3xNiq1cpuql8NkcIDAKxxrMTefHuj/IBpKL22I1i6a4KmCMjW09KpFBbtIHExKtZpiMswUN8aO02L/ol0M6rzsRogec85lp0IaEmfTcbzplo05/WLc6nD9N978SbAbOhDW3P4YhZSIvL/mliRmY8/5vO19EUjkcQv/3ELnDrazDG2GFdl+KawQbQTyaKEBn1CVWUVzF7vkP7SrQRKtox5EcsN51TPrkbw3PACreFd0yt9BFSLhMY+rpQl5EuBV5O3gW/JBhDvLbIgqNMyhKnShjQQB4nDdSEh3XS1VARwk0D5QExe2lbVJfw7QUZ7vKXG0wcqRdNrceDPoSsiyUgj8BfJH0E1T7WBLgOTNRc5hSmS/nnbron5l1wd1nbZPoYdUxR/tKGL0ogMt5FqfVBUw3G7CdT3MHG8flOLKlRMeC+9dEVXg5O03/wWZV7UnInULor7aljDWz+XY7zXnCZUHOht7D/+fq/GXpPSn+IUiPXJQk
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id h16-20020a056638063000b0047123b547d4sm51622jar.55.2024.02.05.09.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:10:41 -0800 (PST)
Date: Mon, 5 Feb 2024 10:10:40 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: James Gowans <jgowans@amazon.com>
Cc: <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 <kexec@lists.infradead.org>, "Joerg Roedel" <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, <iommu@lists.linux.dev>, Alexander Viro
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, <kvm@vger.kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Alexander Graf
 <graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, "Jan H .
 Schoenherr" <jschoenh@amazon.de>, Usama Arif <usama.arif@bytedance.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, Stanislav Kinsburskii
 <skinsburskii@linux.microsoft.com>, <madvenka@linux.microsoft.com>,
 <steven.sistare@oracle.com>, <yuleixzhang@tencent.com>
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
Message-ID: <20240205101040.5d32a7e4.alex.williamson@redhat.com>
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Feb 2024 12:01:45 +0000
James Gowans <jgowans@amazon.com> wrote:

> This RFC is to solicit feedback on the approach of implementing support f=
or live
> update via an in-memory filesystem responsible for storing all live updat=
e state
> as files in the filesystem.
>=20
> Hypervisor live update is a mechanism to support updating a hypervisor vi=
a kexec
> in a way that has limited impact to running virtual machines. This is don=
e by
> pausing/serialising running VMs, kexec-ing into a new kernel, starting ne=
w VMM
> processes and then deserialising/resuming the VMs so that they continue r=
unning
> from where they were. Virtual machines can have PCI devices passed throug=
h and
> in order to support live update it=E2=80=99s necessary to persist the IOM=
MU page tables
> so that the devices can continue to do DMA to guest RAM during kexec.
>=20
> This RFC is a follow-on from a discussion held during LPC 2023 KVM MC
> which explored ways in which the live update problem could be tackled;
> this was one of them:
> https://lpc.events/event/17/contributions/1485/
>=20
> The approach sketched out in this RFC introduces a new in-memory filesyst=
em,
> pkernfs. Pkernfs takes over ownership separate from Linux memory
> management system RAM which is carved out from the normal MM allocator
> and donated to pkernfs. Files are created in pkernfs for a few purposes:
> There are a few things that need to be preserved and re-hydrated after
> kexec to support this:
>=20
> * Guest memory: to be able to restore the VM its memory must be
> preserved.  This is achieved by using a regular file in pkernfs for guest=
 RAM.
> As this guest RAM is not part of the normal linux core mm allocator and
> has no struct pages, it can be removed from the direct map which
> improves security posture for guest RAM. Similar to memfd_secret.
>=20
> * IOMMU root page tables: for the IOMMU to have any ability to do DMA
> during kexec it needs root page tables to look up per-domain page
> tables. IOMMU root page tables are stored in a special path in pkernfs:
> iommu/root-pgtables.  The intel IOMMU driver is modified to hook into
> pkernfs to get the chunk of memory that it can use to allocate root
> pgtables.
>=20
> * IOMMU domain page tables: in order for VM-initiated DMA operations to
> continue running while kexec is happening the IOVA to PA address
> translations for persisted devices needs to continue to work. Similar to
> root pgtables the per-domain page tables for persisted devices are
> allocated from a pkernfs file so they they are also persisted across
> kexec. This is done by using pkernfs files for IOMMU domain page
> tables. Not all devices are persistent, so VFIO is updated to support
> defining persistent page tables on passed through devices.
>=20
> * Updates to IOMMU and PCI are needed to make device handover across
> kexec work properly. Although not fully complete some of the changed
> needed around avoiding device re-setting and re-probing are sketched
> in this RFC.
>=20
> Guest RAM and IOMMU state are just the first two things needed for live u=
pdate.
> Pkernfs opens the door for other kernel state which can improve kexec or =
add
> more capabilities to live update to also be persisted as new files.
>=20
> The main aspect we=E2=80=99re looking for feedback/opinions on here is th=
e concept of
> putting all persistent state in a single filesystem: combining guest RAM =
and
> IOMMU pgtables in one store. Also, the question of a hard separation betw=
een
> persistent memory and ephemeral memory, compared to allowing arbitrary pa=
ges to
> be persisted. Pkernfs does it via a hard separation defined at boot time,=
 other
> approaches could make the carving out of persistent pages dynamic.
>=20
> Sign-offs are intentionally omitted to make it clear that this is a
> concept sketch RFC and not intended for merging.
>=20
> On CC are folks who have sent RFCs around this problem space before, as
> well as filesystem, kexec, IOMMU, MM and KVM lists and maintainers.
>=20
> =3D=3D Alternatives =3D=3D
>=20
> There have been other RFCs which cover some aspect of the live update pro=
blem
> space. So far, all public approaches with KVM neglected device assignment=
 which
> introduces a new dimension of problems. Prior art in this space includes:
>=20
> 1) Kexec Hand Over (KHO) [0]: This is a generic mechanism to pass kernel =
state
> across kexec. It also supports specifying persisted memory page which cou=
ld be
> used to carve out IOMMU pgtable pages from the new kernel=E2=80=99s buddy=
 allocator.
>=20
> 2) PKRAM [1]: Tmpfs-style filesystem which dynamically allocates memory w=
hich can
> be used for guest RAM and is preserved across kexec by passing a pointer =
to the
> root page.
>=20
> 3) DMEMFS [2]: Similar to pkernfs, DMEMFS is a filesystem on top of a res=
erved
> chunk of memory specified via kernel cmdline parameter. It is not persist=
ent but
> aims to remove the need for struct page overhead.
>=20
> 4) Kernel memory pools [3, 4]: These provide a mechanism for kernel modul=
es/drivers
> to allocate persistent memory, and restore that memory after kexec. They =
do do
> not attempt to provide the ability to store userspace accessible state or=
 have a
> filesystem interface.
>=20
> =3D=3D How to use =3D=3D
>=20
> Use the mmemap and pkernfs cmd line args to carve memory out of system RA=
M and
> donate it to pkernfs. For example to carve out 1 GiB of RAM starting at p=
hysical
> offset 1 GiB:
>   memmap=3D1G%1G nopat pkernfs=3D1G!1G
>=20
> Mount pkernfs somewhere, for example:
>   mount -t pkernfs /mnt/pkernfs
>=20
> Allocate a file for guest RAM:
>   touch /mnt/pkernfs/guest-ram
>   truncate -s 100M /mnt/pkernfs/guest-ram
>=20
> Add QEMU cmdline option to use this as guest RAM:
>   -object memory-backend-file,id=3Dpc.ram,size=3D100M,mem-path=3D/mnt/pke=
rnfs/guest-ram,share=3Dyes
>   -M q35,memory-backend=3Dpc.ram
>=20
> Allocate a file for IOMMU domain page tables:
>   touch /mnt/pkernfs/iommu/dom-0
>   truncate -s 2M /mnt/pkernfs/iommu/dom-0
>=20
> That file must be supplied to VFIO when creating the IOMMU container, via=
 the
> VFIO_CONTAINER_SET_PERSISTENT_PGTABLES ioctl. Example: [4]
>=20
> After kexec, re-mount pkernfs, re-used those files for guest RAM and IOMMU
> state. When doing DMA mapping specify the additional flag
> VFIO_DMA_MAP_FLAG_LIVE_UPDATE to indicate that IOVAs are set up already.
> Example: [5].
>=20
> =3D=3D Limitations =3D=3D
>=20
> This is a RFC design to sketch out the concept so that there can be a dis=
cussion
> about the general approach. There are many gaps and hacks; the idea is to=
 keep
> this RFC as simple as possible. Limitations include:
>=20
> * Needing to supply the physical memory range for pkernfs as a kernel cmd=
line
> parameter. Better would be to allocate memory for pkernfs dynamically on =
first
> boot and pass that across kexec. Doing so would require additional integr=
ation
> with memblocks and some ability to pass the dynamically allocated ranges
> across. KHO [0] could support this.
>=20
> * A single filesystem with no support for NUMA awareness. Better would be=
 to
> support multiple named pkernfs mounts which can cover different NUMA node=
s.
>=20
> * Skeletal filesystem code. There=E2=80=99s just enough functionality to =
make it usable to
> demonstrate the concept of using files for guest RAM and IOMMU state.
>=20
> * Use-after-frees for IOMMU mappings. Currently nothing stops the pkernfs=
 guest
> RAM files being deleted or resized while IOMMU mappings are set up which =
would
> allow DMA to freed memory. Better integration with guest RAM files and
> IOMMU/VFIO is necessary.
>=20
> * Needing to drive and re-hydrate the IOMMU page tables by defining an IO=
MMU file.
> Really we should move the abstraction one level up and make the whole VFIO
> container persistent via a pkernfs file. That way you=E2=80=99d "just" re=
-open the VFIO
> container file and all of the DMA mappings inside VFIO would already be s=
et up.

Note that the vfio container is on a path towards deprecation, this
should be refocused on vfio relative to iommufd.  There would need to
be a strong argument for a container/type1 extension to support this,
iommufd would need to be the first class implementation.  Thanks,

Alex
=20
> * Inefficient use of filesystem space. Every mappings block is 2 MiB whic=
h is both
> wasteful and an hard upper limit on file size.
>=20
> [0] https://lore.kernel.org/kexec/20231213000452.88295-1-graf@amazon.com/
> [1] https://lore.kernel.org/kexec/1682554137-13938-1-git-send-email-antho=
ny.yznaga@oracle.com/
> [2] https://lkml.org/lkml/2020/12/7/342
> [3] https://lore.kernel.org/all/169645773092.11424.7258549771090599226.st=
git@skinsburskii./
> [4] https://lore.kernel.org/all/2023082506-enchanted-tripping-d1d5@gregkh=
/#t
> [5] https://github.com/jgowans/qemu/commit/e84cfb8186d71f797ef1f72d57d873=
222a9b479e
> [6] https://github.com/jgowans/qemu/commit/6e4f17f703eaf2a6f1e4cb2576d616=
83eaee02b0
>=20
>=20
> James Gowans (18):
>   pkernfs: Introduce filesystem skeleton
>   pkernfs: Add persistent inodes hooked into directies
>   pkernfs: Define an allocator for persistent pages
>   pkernfs: support file truncation
>   pkernfs: add file mmap callback
>   init: Add liveupdate cmdline param
>   pkernfs: Add file type for IOMMU root pgtables
>   iommu: Add allocator for pgtables from persistent region
>   intel-iommu: Use pkernfs for root/context pgtable pages
>   iommu/intel: zap context table entries on kexec
>   dma-iommu: Always enable deferred attaches for liveupdate
>   pkernfs: Add IOMMU domain pgtables file
>   vfio: add ioctl to define persistent pgtables on container
>   intel-iommu: Allocate domain pgtable pages from pkernfs
>   pkernfs: register device memory for IOMMU domain pgtables
>   vfio: support not mapping IOMMU pgtables on live-update
>   pci: Don't clear bus master is persistence enabled
>   vfio-pci: Assume device working after liveupdate
>=20
>  drivers/iommu/Makefile           |   1 +
>  drivers/iommu/dma-iommu.c        |   2 +-
>  drivers/iommu/intel/dmar.c       |   1 +
>  drivers/iommu/intel/iommu.c      |  93 +++++++++++++---
>  drivers/iommu/intel/iommu.h      |   5 +
>  drivers/iommu/iommu.c            |  22 ++--
>  drivers/iommu/pgtable_alloc.c    |  43 +++++++
>  drivers/iommu/pgtable_alloc.h    |  10 ++
>  drivers/pci/pci-driver.c         |   4 +-
>  drivers/vfio/container.c         |  27 +++++
>  drivers/vfio/pci/vfio_pci_core.c |  20 ++--
>  drivers/vfio/vfio.h              |   2 +
>  drivers/vfio/vfio_iommu_type1.c  |  51 ++++++---
>  fs/Kconfig                       |   1 +
>  fs/Makefile                      |   3 +
>  fs/pkernfs/Kconfig               |   9 ++
>  fs/pkernfs/Makefile              |   6 +
>  fs/pkernfs/allocator.c           |  51 +++++++++
>  fs/pkernfs/dir.c                 |  43 +++++++
>  fs/pkernfs/file.c                |  93 ++++++++++++++++
>  fs/pkernfs/inode.c               | 185 +++++++++++++++++++++++++++++++
>  fs/pkernfs/iommu.c               | 163 +++++++++++++++++++++++++++
>  fs/pkernfs/pkernfs.c             | 115 +++++++++++++++++++
>  fs/pkernfs/pkernfs.h             |  61 ++++++++++
>  include/linux/init.h             |   1 +
>  include/linux/iommu.h            |   6 +-
>  include/linux/pkernfs.h          |  38 +++++++
>  include/uapi/linux/vfio.h        |  10 ++
>  init/main.c                      |  10 ++
>  29 files changed, 1029 insertions(+), 47 deletions(-)
>  create mode 100644 drivers/iommu/pgtable_alloc.c
>  create mode 100644 drivers/iommu/pgtable_alloc.h
>  create mode 100644 fs/pkernfs/Kconfig
>  create mode 100644 fs/pkernfs/Makefile
>  create mode 100644 fs/pkernfs/allocator.c
>  create mode 100644 fs/pkernfs/dir.c
>  create mode 100644 fs/pkernfs/file.c
>  create mode 100644 fs/pkernfs/inode.c
>  create mode 100644 fs/pkernfs/iommu.c
>  create mode 100644 fs/pkernfs/pkernfs.c
>  create mode 100644 fs/pkernfs/pkernfs.h
>  create mode 100644 include/linux/pkernfs.h
>=20


