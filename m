Return-Path: <linux-fsdevel+bounces-17945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D87C8B410D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 23:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F4C1C21958
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 21:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16CD2D054;
	Fri, 26 Apr 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+Z1ADEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90165374EB
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714166432; cv=none; b=gML1nHK6cHoGvszb/cbRoFfdjaz4XF5K0kVlyEVP4I8SUkI/g7iRWR5lCDmN+Kne/vpD+A8CAc2k9FQ9A1SGh1kWqZGyN+IUFypDnHjDDTWwyrUz/OYHc7aa1hObQy5wt1lc3xdu5W0yZxr/w0FaTEgnrdTFfZ68lVakxQ2vnqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714166432; c=relaxed/simple;
	bh=4vfm25pSWYhum0iyZmhm+a6ab8flrVN/ajfV1srkvHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTSaU47bpMXOPgBZYFiTM3HaZ2ZWyFOd3UgbmwCykcUBhDppLDhR388qB6DY1CM4dykvIXW7SIPYSOEvF8T77OI1QJpERM/9KW+DPJkjOKULK2FhPIDzXgqqd98/UCrnoSmzvdAm4Bmqa3FxUKRxATPN/iy7UYLjcThl/wMK7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+Z1ADEJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714166429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YE+xroN3MSFRA2YVeljr0pVRi5jEiA/gyhgABPdlML0=;
	b=K+Z1ADEJ9rSuIz5AQhh4VxCOrbjvoOZGBNavLWxE121+rFBS9Me4U/E7H0fRFKi+iek+5n
	wszxQ7RP6oXLASSBN+SZo4mVCRRibUCcd8t5ni9g52WnQB/47QWwaAlNeRstTBLUAL6vPW
	Gd5SQ2dDiK5pmV6dil5JMAu9USigrQs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-mKqojK9xNHuMP57hvXnyjg-1; Fri, 26 Apr 2024 17:20:28 -0400
X-MC-Unique: mKqojK9xNHuMP57hvXnyjg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a073b075edso2236426d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 14:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714166427; x=1714771227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE+xroN3MSFRA2YVeljr0pVRi5jEiA/gyhgABPdlML0=;
        b=ZrB8KVaaYBG2ztJRxn209qfwIiO+BjznFpaeaZeDEzn6in0sKl5AHA18JBTFRJiPI6
         ionVvnvC6BXurB4SlMrzW+c0gKcwco87n/areV8ZEH4bhRLOwzJLQBamB2Wd3vmljCPS
         2QtNYO11J9xX4IfWePKut3rdv17c2ZGojLFKx4TepQB45RFdq0EURBOpwUP0if/dxEhZ
         MNmBqAbaH0ArexFrE3zbRdQYWDgF8PFexAMaSmFyTWE6TqO80Mvr4blqyCetnoVbwbEh
         W/BWK691HwLFRCSyj9Rzlxp2g738es7L317Alwoc9CvOh7HKD1DzDIMXsoIEeOTof0R7
         XY9A==
X-Forwarded-Encrypted: i=1; AJvYcCXETKcxkty8k0WSdep1BPj5TXn8wP0ufEpJjb0v6Yj3W+BYvD6Om9kk2/UwkdXHOr5/E3K2AaoQo/yaDNrWj7hqW4aqzZ+UgPGqW4J6Pg==
X-Gm-Message-State: AOJu0Yw5uVE6YnnTjNXseOFyNUAK8cUa/VuPEbwl8sNzo9wOkhGT98Bh
	iKanzriwq5Nj+yyCdWzqGVkWWn2hnMexXZNArWfNQ+rPtTf/3B7w+IKVoxq8Va8wWYaaLmR66l6
	Qjyc9x1PoKf8Q1lkyZxuBTW3aWpw4t8lqNbmAf7gmrPvB5R8BauVDn8EP85fwWoE=
X-Received: by 2002:a05:620a:4089:b0:790:8c20:e281 with SMTP id f9-20020a05620a408900b007908c20e281mr4399209qko.4.1714166427247;
        Fri, 26 Apr 2024 14:20:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfzashahVyLrvAJ9qdUfNGidrRIiANL3lMVu3kzLvmX9ZvfaFZoyGy8b+LUj3RVEq076HTsg==
X-Received: by 2002:a05:620a:4089:b0:790:8c20:e281 with SMTP id f9-20020a05620a408900b007908c20e281mr4399166qko.4.1714166426469;
        Fri, 26 Apr 2024 14:20:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id oo8-20020a05620a530800b0078d693c0b4bsm8243842qkn.135.2024.04.26.14.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:20:26 -0700 (PDT)
Date: Fri, 26 Apr 2024 17:20:23 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v1 1/3] mm/gup: consistently name GUP-fast functions
Message-ID: <Ziwal-SucIye3hPM@x1n>
References: <20240402125516.223131-1-david@redhat.com>
 <20240402125516.223131-2-david@redhat.com>
 <e685c532-8330-4a57-bc08-c67845e0c352@redhat.com>
 <Ziuv2jLY1wgBITiP@x1n>
 <ZivScN8-Uoi9eye8@x1n>
 <8b42a24d-caf0-46ef-9e15-0f88d47d2f21@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b42a24d-caf0-46ef-9e15-0f88d47d2f21@redhat.com>

On Fri, Apr 26, 2024 at 07:28:31PM +0200, David Hildenbrand wrote:
> On 26.04.24 18:12, Peter Xu wrote:
> > On Fri, Apr 26, 2024 at 09:44:58AM -0400, Peter Xu wrote:
> > > On Fri, Apr 26, 2024 at 09:17:47AM +0200, David Hildenbrand wrote:
> > > > On 02.04.24 14:55, David Hildenbrand wrote:
> > > > > Let's consistently call the "fast-only" part of GUP "GUP-fast" and rename
> > > > > all relevant internal functions to start with "gup_fast", to make it
> > > > > clearer that this is not ordinary GUP. The current mixture of
> > > > > "lockless", "gup" and "gup_fast" is confusing.
> > > > > 
> > > > > Further, avoid the term "huge" when talking about a "leaf" -- for
> > > > > example, we nowadays check pmd_leaf() because pmd_huge() is gone. For the
> > > > > "hugepd"/"hugepte" stuff, it's part of the name ("is_hugepd"), so that
> > > > > stays.
> > > > > 
> > > > > What remains is the "external" interface:
> > > > > * get_user_pages_fast_only()
> > > > > * get_user_pages_fast()
> > > > > * pin_user_pages_fast()
> > > > > 
> > > > > The high-level internal functions for GUP-fast (+slow fallback) are now:
> > > > > * internal_get_user_pages_fast() -> gup_fast_fallback()
> > > > > * lockless_pages_from_mm() -> gup_fast()
> > > > > 
> > > > > The basic GUP-fast walker functions:
> > > > > * gup_pgd_range() -> gup_fast_pgd_range()
> > > > > * gup_p4d_range() -> gup_fast_p4d_range()
> > > > > * gup_pud_range() -> gup_fast_pud_range()
> > > > > * gup_pmd_range() -> gup_fast_pmd_range()
> > > > > * gup_pte_range() -> gup_fast_pte_range()
> > > > > * gup_huge_pgd()  -> gup_fast_pgd_leaf()
> > > > > * gup_huge_pud()  -> gup_fast_pud_leaf()
> > > > > * gup_huge_pmd()  -> gup_fast_pmd_leaf()
> > > > > 
> > > > > The weird hugepd stuff:
> > > > > * gup_huge_pd() -> gup_fast_hugepd()
> > > > > * gup_hugepte() -> gup_fast_hugepte()
> > > > 
> > > > I just realized that we end up calling these from follow_hugepd() as well.
> > > > And something seems to be off, because gup_fast_hugepd() won't have the VMA
> > > > even in the slow-GUP case to pass it to gup_must_unshare().
> > > > 
> > > > So these are GUP-fast functions and the terminology seem correct. But the
> > > > usage from follow_hugepd() is questionable,
> > > > 
> > > > commit a12083d721d703f985f4403d6b333cc449f838f6
> > > > Author: Peter Xu <peterx@redhat.com>
> > > > Date:   Wed Mar 27 11:23:31 2024 -0400
> > > > 
> > > >      mm/gup: handle hugepd for follow_page()
> > > > 
> > > > 
> > > > states "With previous refactors on fast-gup gup_huge_pd(), most of the code
> > > > can be leveraged", which doesn't look quite true just staring the the
> > > > gup_must_unshare() call where we don't pass the VMA. Also,
> > > > "unlikely(pte_val(pte) != pte_val(ptep_get(ptep)" doesn't make any sense for
> > > > slow GUP ...
> > > 
> > > Yes it's not needed, just doesn't look worthwhile to put another helper on
> > > top just for this.  I mentioned this in the commit message here:
> > > 
> > >    There's something not needed for follow page, for example, gup_hugepte()
> > >    tries to detect pgtable entry change which will never happen with slow
> > >    gup (which has the pgtable lock held), but that's not a problem to check.
> > > 
> > > > 
> > > > @Peter, any insights?
> > > 
> > > However I think we should pass vma in for sure, I guess I overlooked that,
> > > and it didn't expose in my tests too as I probably missed ./cow.
> > > 
> > > I'll prepare a separate patch on top of this series and the gup-fast rename
> > > patches (I saw this one just reached mm-stable), and I'll see whether I can
> > > test it too if I can find a Power system fast enough.  I'll probably drop
> > > the "fast" in the hugepd function names too.
> > 
> 
> For the missing VMA parameter, the cow.c test might not trigger it. We never need the VMA to make
> a pinning decision for anonymous memory. We'll trigger an unsharing fault, get an exclusive anonymous page
> and can continue.
> 
> We need the VMA in gup_must_unshare(), when long-term pinning a file hugetlb page. I *think*
> the gup_longterm.c selftest should trigger that, especially:
> 
> # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
> ...
> # [RUN] R/O longterm GUP-fast pin in MAP_SHARED file mapping ... with memfd hugetlb (1048576 kB)
> 
> 
> We need a MAP_SHARED page where the PTE is R/O that we want to long-term pin R/O.
> I don't remember from the top of my head if the test here might have a R/W-mapped
> folio. If so, we could extend it to cover that.

Let me try both then.

> 
> > Hmm, so when I enable 2M hugetlb I found ./cow is even failing on x86.
> > 
> >    # ./cow  | grep -B1 "not ok"
> >    # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
> >    not ok 161 No leak from parent into child
> >    --
> >    # [RUN] vmsplice() + unmap in child with mprotect() optimization ... with hugetlb (2048 kB)
> >    not ok 215 No leak from parent into child
> >    --
> >    # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with hugetlb (2048 kB)
> >    not ok 269 No leak from child into parent
> >    --
> >    # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 kB)
> >    not ok 323 No leak from child into parent
> > 
> > And it looks like it was always failing.. perhaps since the start?  We
> 
> Yes!
> 
> commit 7dad331be7816103eba8c12caeb88fbd3599c0b9
> Author: David Hildenbrand <david@redhat.com>
> Date:   Tue Sep 27 13:01:17 2022 +0200
> 
>     selftests/vm: anon_cow: hugetlb tests
>     Let's run all existing test cases with all hugetlb sizes we're able to
>     detect.
>     Note that some tests cases still fail. This will, for example, be fixed
>     once vmsplice properly uses FOLL_PIN instead of FOLL_GET for pinning.
>     With 2 MiB and 1 GiB hugetlb on x86_64, the expected failures are:
>      # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
>      not ok 23 No leak from parent into child
>      # [RUN] vmsplice() + unmap in child ... with hugetlb (1048576 kB)
>      not ok 24 No leak from parent into child
>      # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with hugetlb (2048 kB)
>      not ok 35 No leak from child into parent
>      # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with hugetlb (1048576 kB)
>      not ok 36 No leak from child into parent
>      # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 kB)
>      not ok 47 No leak from child into parent
>      # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (1048576 kB)
>      not ok 48 No leak from child into parent
> 
> As it keeps confusing people (until somebody cares enough to fix vmsplice), I already
> thought about just disabling the test and adding a comment why it happens and
> why nobody cares.

I think we should, and when doing so maybe add a rich comment in
hugetlb_wp() too explaining everything?

> 
> > didn't do the same on hugetlb v.s. normal anon from that regard on the
> > vmsplice() fix.
> > 
> > I drafted a patch to allow refcount>1 detection as the same, then all tests
> > pass for me, as below.
> > 
> > David, I'd like to double check with you before I post anything: is that
> > your intention to do so when working on the R/O pinning or not?
> 
> Here certainly the "if it's easy it would already have done" principle applies. :)
> 
> The issue is the following: hugetlb pages are scarce resources that cannot usually
> be overcommitted. For ordinary memory, we don't care if we COW in some corner case
> because there is an unexpected reference. You temporarily consume an additional page
> that gets freed as soon as the unexpected reference is dropped.
> 
> For hugetlb, it is problematic. Assume you have reserved a single 1 GiB hugetlb page
> and your process uses that in a MAP_PRIVATE mapping. Then it calls fork() and the
> child quits immediately.
> 
> If you decide to COW, you would need a second hugetlb page, which we don't have, so
> you have to crash the program.
> 
> And in hugetlb it's extremely easy to not get folio_ref_count() == 1:
> 
> hugetlb_fault() will do a folio_get(folio) before calling hugetlb_wp()!
> 
> ... so you essentially always copy.

Hmm yes there's one extra refcount. I think this is all fine, we can simply
take all of them into account when making a CoW decision.  However crashing
an userspace can be a problem for sure.

> 
> 
> At that point I walked away from that, letting vmsplice() be fixed at some point. Dave
> Howells was close at some point IIRC ...
> 
> I had some ideas about retrying until the other reference is gone (which cannot be a
> longterm GUP pin), but as vmsplice essentially does without FOLL_PIN|FOLL_LONGTERM,
> it's quit hopeless to resolve that as long as vmsplice holds longterm references the wrong
> way.
> 
> ---
> 
> One could argue that fork() with hugetlb and MAP_PRIVATE is stupid and fragile: assume
> your child MM is torn down deferred, and will unmap the hugetlb page deferred. Or assume
> you access the page concurrently with fork(). You'd have to COW and crash the program.
> BUT, there is a horribly ugly hack in hugetlb COW code where you *steal* the page form
> the child program and crash your child. I'm not making that up, it's horrible.

I didn't notice that code before; doesn't sound like a very responsible
parent..

Looks like either there come a hugetlb guru who can make a decision to
break hugetlb ABI at some point, knowing that nobody will really get
affected by it, or that's the uncharted area whoever needs to introduce
hugetlb v2.

Thanks,

-- 
Peter Xu


