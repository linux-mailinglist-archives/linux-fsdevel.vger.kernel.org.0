Return-Path: <linux-fsdevel+bounces-23413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C379E92BEEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454E11F23454
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1EC19D8AB;
	Tue,  9 Jul 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhAxepTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F915C9
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540595; cv=none; b=BdwIxUfif4mEBpLh0WYWbjjc7MZi2z2pCeD5r6SV/f6XB0KIs9a4t9ctrcMelr9DExbcpfgUUyvQQ8pbC7V/xi2EpegnuxFm7Tnwy4otwSRqcZLEinRURnOsHvpGllW2A102nhJbt5vdFCh6hjiVwRMG63OAVgsvN6VGKfQKyHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540595; c=relaxed/simple;
	bh=YsGddLcuzluGh1Z2I/0xBj1FmM9qYjQTWUTyhEnA6/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqXSOdk5yDT+MeLN9hI7OGulyowBUMN1w6IchodPXVjSpAZnbf31QzC4MRSc9S6x8X8Ih5YAD+Pd1aZf/MeFN9Vv53IkAm9x0I5mdbWWrKflE0W1e3/i4NwqljUAcSvmVYvAwLTAyk4Qa/9iAKbQ9G8Z1bsthWUkgIU77BrxhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhAxepTV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720540592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xk2zHQ/YE20jgxtFEdO755E5YwPG0ZQdb2j69TcOV+0=;
	b=WhAxepTVjSu2GiMejjfqoRtbeI5bS2ZoT7U9578ALVaY1atRgue4MB2aIQQACOv6W9kuAh
	MubNNPpCe2S0Zpc3v/h7Vrjsk+ClPXrBNQC5c1qpnSX/4fLhclAZLtVEnsUPzHZZi/wadp
	A6ElXRJ4F4Q0m8taml5pwz92hqJ+cfE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-NEXm9gmkNmKkzBpcLV1ufQ-1; Tue, 09 Jul 2024 11:56:31 -0400
X-MC-Unique: NEXm9gmkNmKkzBpcLV1ufQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3d91995a3c6so119308b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 08:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720540591; x=1721145391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xk2zHQ/YE20jgxtFEdO755E5YwPG0ZQdb2j69TcOV+0=;
        b=MkkkjhT9WiJqZiOe/iGkcJKtjp7MTvsi2JKSOKI+kkATsuhXnsNtai3GD4z/PSONdg
         1uTKZxi8oHa4yRWTrefaHFjm6hWJo+ejcDB5G7baXsct5jLGMFhx/LT2/q8hf+TPPl0o
         SQtB4IkM6EvMZxWneKJzkbsv3m16AEim4YOYdq+k5H+t1JmVU9m/NX78NjZ+HSpT6I4E
         18aeR9mXqUG2vhMBoz3DLhtZLXLkOp0N80l2wgR/7ZKiva3FsmNYEPsvSj/QZ1MEb61X
         tk14zSovh585eXEJ3P3J2FjND7ZqUdFP1C/oQyCYE0OhOgqObbFQnXuQzx+p+UdtRRsy
         07eA==
X-Forwarded-Encrypted: i=1; AJvYcCXEarbV9JHraNTrFP3lQXrmnEEkOPL6X2N0xTUJYn6nMZG72omQrnYMsfB0eUbLKmjKqoY/EYit0KlRH+0cajjLYcK59+CxZu5R1+oGQQ==
X-Gm-Message-State: AOJu0YxNvq93lt5dYlR2ILqRbtT67w1dMaJMeX3YoWdO+ruplC9Z6FSQ
	QD5K3GMz68bd7rwxqxhYUAsUg52xGx69Iy/TB+88Be+wNRWY3c67NGaJFpQxC6YIBSZa8aBUnJY
	++sg7kODyyyB+CsAR33gE72BMnpKKY47G3raOU3EvSNxcZOKXVjh9NwQrBGT597Y=
X-Received: by 2002:a05:6808:148b:b0:3d9:2e1d:2543 with SMTP id 5614622812f47-3d93c0fe45amr2848536b6e.5.1720540590681;
        Tue, 09 Jul 2024 08:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1Ma1rQrmj4Xg5pyldsO8p97ImEEKrUWOUqeogODHc73Oz0DxK2TC+nXJTsvBMv1FTSng1jg==
X-Received: by 2002:a05:6808:148b:b0:3d9:2e1d:2543 with SMTP id 5614622812f47-3d93c0fe45amr2848435b6e.5.1720540589482;
        Tue, 09 Jul 2024 08:56:29 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b26f7bsm11708091cf.6.2024.07.09.08.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:56:29 -0700 (PDT)
Date: Tue, 9 Jul 2024 11:56:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 11/13] huge_memory: Remove dead vmf_insert_pXd code
Message-ID: <Zo1dqTPLn_gosrSO@x1n>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <400a4584f6f628998a7093aee49d9f86c592754b.1719386613.git-series.apopple@nvidia.com>
 <ZogCDpfSyCcjVXWH@x1n>
 <87zfqrw69i.fsf@nvdebian.thelocal>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfqrw69i.fsf@nvdebian.thelocal>

On Tue, Jul 09, 2024 at 02:07:31PM +1000, Alistair Popple wrote:
> 
> Peter Xu <peterx@redhat.com> writes:
> 
> > Hi, Alistair,
> >
> > On Thu, Jun 27, 2024 at 10:54:26AM +1000, Alistair Popple wrote:
> >> Now that DAX is managing page reference counts the same as normal
> >> pages there are no callers for vmf_insert_pXd functions so remove
> >> them.
> >> 
> >> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> >> ---
> >>  include/linux/huge_mm.h |   2 +-
> >>  mm/huge_memory.c        | 165 +-----------------------------------------
> >>  2 files changed, 167 deletions(-)
> >> 
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index 9207d8e..0fb6bff 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -37,8 +37,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >>  		    pmd_t *pmd, unsigned long addr, pgprot_t newprot,
> >>  		    unsigned long cp_flags);
> >>  
> >> -vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
> >> -vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
> >>  vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write);
> >>  vm_fault_t dax_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write);
> >
> > There's a plan to support huge pfnmaps in VFIO, which may still make good
> > use of these functions.  I think it's fine to remove them but it may mean
> > we'll need to add them back when supporting pfnmaps with no memmap.
> 
> I'm ok with that. If we need them back in future it shouldn't be too
> hard to add them back again. I just couldn't find any callers of them
> once DAX stopped using them and the usual policy is to remove unused
> functions.

True.  Currently the pmd/pud helpers are only used in dax.

> 
> > Is it still possible to make the old API generic to both service the new
> > dax refcount plan, but at the meantime working for pfn injections when
> > there's no page struct?
> 
> I don't think so - this new dax refcount plan relies on having a struct
> page to take references on so I don't think it makes much sense to
> combine it with something that doesn't have a struct page. It sounds
> like the situation is the analogue of vm_insert_page()
> vs. vmf_insert_pfn() - it's possible for both to exist but there's not
> really anything that can be shared between the two APIs as one has a
> page and the other is just a raw PFN.

I still think most of the codes should be shared on e.g. most of sanity
checks, pgtable injections, pgtable deposits (for pmd) and so on.

To be explicit, I wonder whether something like below diff would be
applicable on top of the patch "huge_memory: Allow mappings of PMD sized
pages" in this series, which introduced dax_insert_pfn_pmd() for dax:

$ diff origin new
1c1
< vm_fault_t dax_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
---
> vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool write)
55,58c55,60
<       folio = page_folio(page);
<       folio_get(folio);
<       folio_add_file_rmap_pmd(folio, page, vma);
<       add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
---
>         if (page) {
>                 folio = page_folio(page);
>                 folio_get(folio);
>                 folio_add_file_rmap_pmd(folio, page, vma);
>                 add_mm_counter(mm, mm_counter_file(folio), HPAGE_PMD_NR);
>         }

As most of the rest look very similar to what pfn injections would need..
and in the PoC of ours we're using vmf_insert_pfn_pmd/pud().

That also reminds me on whether it'll be easier to implement the new dax
support for page struct on top of vmf_insert_pfn_pmd/pud, rather than
removing the 1st then adding the new one.  Maybe it'll reduce code churns,
and would that also make reviews easier?

It's also possible I missed something important so the old function must be
removed.

Thanks,

-- 
Peter Xu


