Return-Path: <linux-fsdevel+bounces-39799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F01A18778
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 22:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C42162890
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 21:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8CD1F8674;
	Tue, 21 Jan 2025 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MoLSitJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C47188CAE
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495954; cv=none; b=bI08Y8VMgVsoxc2ykBhOjg3tBzuNKZgnlKmXZ38b4az+OlZSwy9M58Ep8cse0yGan3VpAsxpoFV593X3F/VPv9T0QqyHZ2LLDi0AqlAyvBXu3G/Rw8n+Kv5bpNMAJ32o27Hu/HmXzX/WZ52PntctPdHl4M4nmvLn2EFN/F7nb48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495954; c=relaxed/simple;
	bh=MdelfwhRVSlyuiMYo7TZFBdCeacX1jO9e/qmO8vEwS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u743v+BqgtF9lnxVS9QB74znXl85lNAmIl5xjXTSM5HfuQjQPlgdPFgpMIXA6kUNNfl1MGdT2ipLUzOdvdR4xKoxBk3m9wjaW/r68U616/pSRsgJW716LnuFWFrHdRWPOIEyaVecGDUHSNnfijK4IKIzGxT9UJRls+7GBnra7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MoLSitJH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4368a290e0dso4205e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 13:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737495950; x=1738100750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB+n+UwMfOQKwDrhAEMfJsdUytMHaeQlkJXVZX3WDwU=;
        b=MoLSitJH3j7qcvK+QqZ1lRY0XwQZk/K8oOdCxZWSJFVSzUkclR4qP0oVQ+RCnMb8iM
         QIlvWYuH1rHcityvXWnnPDdYnelS4+QY1MLSuwJuaTWtt89cK+wa7bE03VQG0ZsID893
         K1+93Rsw9/9QJUtTMUoCFETecEJw1Ym6c1mGLOs8+dRNbvOqFTRRdgGkXFR421kFt1qY
         gjXDUiMXcRRd4EcyskAK0L5JVPf3Bfj3gBkVwm9KiSLc+sHg1ZPKcmVc+5j0lZsz2vQ3
         HDQHz82XVdqRJm+Il1Nmp5lNYY5k7qG1E3EnIK8lXXLAEJjQNegAg5jg76XU/zrWTAJp
         wqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737495950; x=1738100750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cB+n+UwMfOQKwDrhAEMfJsdUytMHaeQlkJXVZX3WDwU=;
        b=T7bJ0FPoGgsTxcvi50f8C4fv/jjB2jk+ODNtbMQ+LBML+pN3vHvGjxv5q8ALcvtzwJ
         scvGSvZfb9vmO2IMfyp0lYNaeL9eH2TTPQhlobewg6G7KhQi4UkpTWQtaejskaniKFLO
         SC+gLEbx0lf7Nw52sukrnXkD2A1ld6ytpBJFbwONTuh/8s+846kHpTCBwEQcCTYUtXAK
         Rcpo+Gzsaml6nCobMrQZCWVeKtDH9ugxFboRdKB2gUplLKgEC3ABIEDKrWqwCnuVg9Pe
         wgaoPBziq3BevRz3iXnix/z6/JgfRsJgRo+MDRwvw+r0OkO1ZwPtpbfBa7zyaQLa4Fmj
         yhoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmrPHPHVPmnUb60hCB05BofGRjAeKourx1K8nPnPuquRGsLUv/Hb/mkACkVNPlgiMEe17wbYpAkpZBH/ve@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuBL13jbgNUVeufGW0fDVC68wxwZBACK9bSEsEkSC2/pv3/EB
	rLwFtm9PaxvpBPebWDUh7bE7JzcykG9W8u2H07x0TCgMb7qgxNTNU6NPDQO7CmEWs7e+r9kph9M
	HfnANSPZL5dDk6vzsH+nz3xwDtqQeQOsTm8Qy
X-Gm-Gg: ASbGncvZZA+rVguIEZH/LxAMSgCZqoTinkHiMADXXsOuipa8xPHfQ/uN8tN2cSLLuyp
	FOHGp9C8sCUq1uFSEYYiFV6NabbJTYMh7hk9nhKfQG3HbrK0PwAbwKr8vnGh5S3S/YZ7TdNZbZb
	7Oy1JRZ24Hy0i5fsyF
X-Google-Smtp-Source: AGHT+IH80POj0hbosYX61iNSRjHaP12pPVexa8wrDuJ3S0IOQG/dVdndrqqXXCuLXrtM4NwDvMUJLbrro+bva/MntBE=
X-Received: by 2002:a05:600c:231a:b0:434:9e1d:44ef with SMTP id
 5b1f17b1804b1-438b2dc5bd8mr42875e9.7.1737495950175; Tue, 21 Jan 2025 13:45:50
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118231549.1652825-1-jiaqiyan@google.com> <20250120172626.GO5556@nvidia.com>
In-Reply-To: <20250120172626.GO5556@nvidia.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 21 Jan 2025 13:45:38 -0800
X-Gm-Features: AbW1kvbNFTqyJFDZKnImh5XWoL6jWAktGiJggZRRRKZ8MreCoDvxFC5bNOYgKiU
Message-ID: <CACw3F531Mdmvf1mxUCU_7mwhmHA5VrM4wrereTxHq3ACG49fJA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, tony.luck@intel.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, jane.chu@oracle.com, 
	akpm@linux-foundation.org, osalvador@suse.de, rientjes@google.com, 
	duenwen@google.com, jthoughton@google.com, ankita@nvidia.com, 
	peterx@redhat.com, sidhartha.kumar@oracle.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jason, your comments are very much appreciated. I replied to
some of them, and need more thoughts for the others.

On Mon, Jan 20, 2025 at 9:26=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Sat, Jan 18, 2025 at 11:15:46PM +0000, Jiaqi Yan wrote:
> > In the experimental case, all the setups are identical to the baseline
> > case, however 25% of the guest memory is split from THP to 4K pages due
> > to the memory failure recovery triggered by MADV_HWPOISON. I made some
> > minor changes in the kernel so that the MADV_HWPOISON-ed pages are
> > unpoisoned, and afterwards the in-guest MemCycle is still able to read
> > and write its data. The final aggregate rate is 16,355.11, which is
> > decreased by 5.06% compared to the baseline case. When 5% of the guest
> > memory is split after MADV_HWPOISON, the final aggregate rate is
> > 16,999.14, a drop of 1.20% compared to the baseline case.
>
> I think it was mentioned in one of the calls, but this is good data on
> the CPU side, but for VMs doing IO, the IO performance is impacted
> also. IOTLB miss on (random) IO performance, especially with two
> dimensional IO paging, tends to have a performance curve that drops
> off a cliff once the IOTLB is too small for the workload.
>
> Specifically, systems seem to be designed to require high IOTLB hit
> rate to maintain their target performance and IOTLB miss is much more
> expensive than CPU TLB miss.
>
> So, I would view MemCycle as something of a best case work load that
> is not as sensitive to TLB size. A worst case is a workload that just
> fits inside the TLB and reducing the page sizes pushes it to no longer
> fit.

I think a guest IO benchmarking could be valuable (I wasn't able to
conduct it along with the MemCycler experiment due to resource reason)
so it is added to my TODO list. I think if the number comes out really
bad, it may affect the default behavior of MFR, or at least people's
preference.

Do you know if there is an existing benchmark like memcycler that I
can run in VM, and that exercises the two dimensional IO paging?

>
> > Per-memfd MFR Policy associates the userspace MFR policy with a memfd
> > instance. This approach is promising for the following reasons:
> > 1. Keeping memory with UE mapped to a process has risks if the process
> >    does not do its duty to prevent itself from repeatedly consuming UER=
.
> >    The MFR policy can be associated with a memfd to limit such risk to =
a
> >    particular memory space owned by a particular process that opts in
> >    the policy. This is much preferable than the Global MFR Policy
> >    proposed in the initial RFC, which provides no granularity
> >    whatsoever.
>
> Yes, very much agree
>
> > 3. Although MFR policy allows the userspace process to keep memory UE
> >    mapped, eventually these HWPoison-ed folios need to be dealt with by
> >    the kernel (e.g. split into smallest chunk and isolated from
> >    future allocation). For memfd once all references to it are dropped,
> >    it is automatically released from userspace, which is a perfect
> >    timing for the kernel to do its duties to HWPoison-ed folios if any.
> >    This is also a big advantage to the Global MFR Policy, which breaks
> >    kernel=E2=80=99s protection to HWPoison-ed folios.
>
> iommufd will hold the memory pinned for the life of the VM, is that OK
> for this plan?

At appearance, pinned memory (i.e. folio_maybe_dma_pinned=3Dtrue) by
definition should not be offlined / reclaimed in many places,
including the handling of HWPoison at any stage.

>
> > 4. Given memfd=E2=80=99s anonymous semantic, we don=E2=80=99t need to w=
orry about that
> >    different threads can have different and conflicting MFR policies. I=
t
> >    allows a simpler implementation than the Per-VMA MFR Policy in the
> >    initial RFC [1].
>
> Your policy is per-memfd right?

Yes, basically per-memfd, no VMA involved.

>
> > However, the affected memory will be immediately protected and isolated
> > from future use by both kernel and userspace once the owning memfd is
> > gone or the memory is truncated. By default MFD_MF_KEEP_UE_MAPPED is no=
t
> > set, and kernel hard offlines memory having UEs. Kernel immediately
> > poisons the folios for both cases.
>
> I'm reading this and thinking that today we don't have any callback
> into the iommu to force offline the memory either, so a guest can
> still do DMA to it.
>
> > Part2: When a AS_MF_KEEP_UE_MAPPED memfd is about to be released, or
> > when the userspace process truncates a range of memory pages belonging
> > to a AS_MF_KEEP_UE_MAPPED memfd:
> > * When the in-memory file system is evicting the inode corresponding to
> >   the memfd, it needs to prepare the HWPoison-ed folios that are easily
> >   identifiable with the PG_HWPOISON flag. This operation is implemented
> >   by populate_memfd_hwp_folios and is exported to file systems.
> > * After the file system removes all the folios, there is nothing else
> >   preventing MFR from dealing with HWPoison-ed folios, so the file
> >   system forwards them to MFR. This step is implemented by
> >   offline_memfd_hwp_folios and is exported to file systems.
>
> As above, iommu won't release its refcount after truncate or zap.

Due to the pinning behavior, or something else? Then I think not
offlining the HWPoison folio (i.e. no op) after truncate is expected
behavior, or a return of EBUSY from offline_memfd_hwp_folios.

Taking HugeTLB as an example, I used to think the folio will be
dissovled into 4k pages after truncate. However, it seems today the
huge folio is just isolated from freed and reused[*], like a hugepage
is "leaked" (after truncation, nr_hugepages is not decreased, but
free_hugepages is reduced, as if the exit process or mm still hold
that hugepage).

[*] https://lore.kernel.org/linux-mm/20250119180608.2132296-3-jiaqiyan@goog=
le.com/T/#m54be295de1144eead4ab73c3cc9077b6dd14050f

>
> > * MFR has been holding refcount(s) of each HWPoison-ed folio. After
> >   dropping the refcounts, a HWPoison-ed folio should become free and ca=
n
> >   be disposed of.
>
> So you have to deal with "should" being "won't" in cases where VFIO is
> being used...
>
> > In V2 I can probably offline each folio as they get remove, instead of
> > doing this in batch. The advantage is we can get rid of
> > populate_memfd_hwp_folios and the linked list needed to store poisoned
> > folios. One way is to insert filemap_offline_hwpoison_folio into
> > somewhere in folio_batch_release, or into per file system's free_folio
> > handler.
>
> That sounds more workable given the above, though we keep getting into
> cases where people want to hook free_folio..
>
> > 2. In react to later fault to any part of the HWPoison-ed folio, guest
> >    memfd returns KVM_PFN_ERR_HWPOISON, and KVM sends SIGBUS to VMM. Thi=
s
> >    is good enough for actual hardware corrupted PFN backed GFNs, but no=
t
> >    ideal for the healthy PFNs =E2=80=9Cofflined=E2=80=9D together with =
the error PFNs.
> >    The userspace MFR policy can be useful if VMM wants KVM to 1. Keep
> >    these GFNs mapped in the stage-2 page table 2. In react to later
> >    access to the actual hardware corrupted part of the HWPoison-ed
> >    folio, there is going to be a (repeated) poison consumption event,
> >    and KVM returns KVM_PFN_ERR_HWPOISON for the actual poisoned PFN.
>
> I feel like the guestmemfd version of this is not about userspace
> mappings but about what is communicated to the secure world.
>
> If normal memfd would leave these pages mapped to the VMA then I'd
> think the guestmemfd version would be to leave the pages mapped to the
> secure world?
>
> Keep in mind that guestmemfd is more complex that kvm today as several
> of the secure world implementations are sharing the stage2/ept
> translation between CPU and IOMMU HW. So you can't just unmap 1G of
> memory without completely breaking the guest.
>
> > This RFC [4] proposes a MFR framework for VFIO device managed userspace
> > memory (i.e. memory regions mapped by remap_pfn_region). The userspace
> > MFR policy can instruct the device driver to keep all PFN mapped in a
> > VMA (i.e. don=E2=80=99t unmap_mapping_range).
>
> Ankit has some patches that cause the MFR framework to send the
> poision events for non-struct page memory to the device driver that
> owns the memory.

But it seems the driver itself has not yet been in charge of unmapping
or not. Instead, MFR framework made the call. I think it is probably
fine the MFR framework can just continue to make the call with a piece
of new info, mapping_mf_keep_ue_mapped/AS_MF_KEEP_UE_MAPPED (in RFC
PATCH 1/3).

>
> > * IOCTL to the VFIO Device File. The device driver usually expose a
> >   file-like uAPI to its managed device memory (e.g. PCI MMIO BAR)
> >   directly with the file to the VFIO device. AS_MF_KEEP_UE_MAPPED can b=
e
> >   placed in the address_space of the file to the VFIO device. Device
> >   driver can implement a specific IOCTL to the VFIO device file for
> >   userspace to set AS_MF_KEEP_UE_MAPPED.
>
> I don't think address spaces are involved in the MFR path after Ankit's
> patch? The dispatch is done entirely on phys_addr_t.

I think strictly speaking Ankit's patch is built around
pfn_address_space[*], and the driver does include address_space when
it registers to core mm. So if the driver wants to be the one make the
call of unmapping or not, it should still be able to access
AS_MF_KEEP_UE_MAPPED.

[*] https://lore.kernel.org/lkml/20231123003513.24292-2-ankita@nvidia.com/

>
> What happens will be up to the driver that owns the memory.
>
> You could have a VFIO feature that specifies one behavior or the

Do you mean a new one under the VFIO_DEVICE_FEATURE IOCTL?

> other, but perhaps VFIO just always keeps things mapped. I don't know.

I think a proper VFIO guest benchmarking can help tell which behavior is be=
tter.

>
> Jason

