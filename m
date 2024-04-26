Return-Path: <linux-fsdevel+bounces-17920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFBD8B3C7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 18:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4A11C20E50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C08156864;
	Fri, 26 Apr 2024 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LypP9JvO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04215623A
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147966; cv=none; b=OUhnGCVqaOJUs5+AkTuVkHFjJMV98RvLGQbxa4qXwcp6oby0y7NMRzhBtdbWRpxiE2j24QQ9xcYYphBcQFrjHEEby3vev6HSyMwAFAS4ILHJkYln04lk0swoL7D1ctyBzOGif062CF50pVr++p7sMv6I2ZHqR94PX4eamaIH+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147966; c=relaxed/simple;
	bh=VHk3yV3ykPgBDTFB6jGO3B/kKnE4mwuV8+QA4otgjj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWVXiMBc5JcJd0JenkczOeKnjy6L9kshfqPeLMjFQukn6sEe3kz7EwfJFOndR9TiFNTPcBhlI6Yz+1/yz42Pmf+A6QNjl6jDOhfT+sPHGqBlmxaRDm49sN7ma1UL9cVbW3zsyS3K7oH/Fg72bpXHHzUtI6IIoILwqyIIZBwzF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LypP9JvO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714147963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYUqEa4yY2qzSFoFdIvLcLWvg/98iZ7Cq/Vjg2cb5Pg=;
	b=LypP9JvOUwTJ+H67rwONo9wwRCDu7c4QosQU9i/xSC7EmmvETQP+nnNJgYw4vxqKKqI2rT
	p6+9SIKxj7B8VcSqnaf+5p3cIiRNM+TEH2OxbP52yBiEALFUWqq9N6PaG46XJ+JZ/4ZpKC
	y8QXaCCaiIVIz4CAWLMaud9ezd13PoQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-XsmXiaGIN6GsCDi1AZSy6w-1; Fri, 26 Apr 2024 12:12:42 -0400
X-MC-Unique: XsmXiaGIN6GsCDi1AZSy6w-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6eba7dc8f1dso621414a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 09:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714147962; x=1714752762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYUqEa4yY2qzSFoFdIvLcLWvg/98iZ7Cq/Vjg2cb5Pg=;
        b=a89REeK+VELh2xDcPn9yovlGvOyvQeEYC6fFKBSg85J7hMBUgLh4e0nkD4W3HyI94o
         48mYTbKBBOsg+n8Dwr5UpnN/DgJeBpBiFsFEchiu0HJdp7eqWYlQnhTE40LFrDgIrpnV
         QxLX9tNbucT1766m31LJ1tOcoMzNvVKiFqs8WHf/DAqTsCjt1R/WPUkOhgtKYuJinPr6
         bz65JnF9owFmlkiiMkFzDcmkukQ5/VutIdDlWkfw8Ri53R+vNwLx9rlljSqNPNe2l9td
         YNIpd/H4NO6VxopkHzD+Uh93K2SUG28wdHI4pwRelw84fRPc61R2TjBagow7FT4u1sQ5
         eHaA==
X-Forwarded-Encrypted: i=1; AJvYcCWKi1MFcW4PfGuZQRk2x/Mk5iNR54zyxCruWAp6Cbmu7SaR0FiMjEYTuykgR3ykHj0P6113Wp2cTNHsFCWmMGwqpOip/UB2YlYCI1Vsfw==
X-Gm-Message-State: AOJu0YxKL2dabDW9PZky07/k+kCbGV4s4iod77fZrfKGCTmWCOorlCF/
	NGKyRNVF2dLIK6LOb9QoFNIRxjVPP2ooglWU8h0VkB2sAG49t4TNeFTCjTPYEfifPRD3OCq+aCh
	ikBlPlVIBBeNmOFBIJ7UNrirkE7bEW1aSdlFStRAlNiuOvz+0kVDIpNVMjdnGfsw=
X-Received: by 2002:a05:6870:a40f:b0:235:3e97:ed24 with SMTP id m15-20020a056870a40f00b002353e97ed24mr3125233oal.1.1714147961420;
        Fri, 26 Apr 2024 09:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKK09FSsz1w18C9O+QSKywaneNtUpj/aPvoeb+SOH3u9egTJYXPSkxUgqSN3BOrRHAMYNm3w==
X-Received: by 2002:a05:6870:a40f:b0:235:3e97:ed24 with SMTP id m15-20020a056870a40f00b002353e97ed24mr3125169oal.1.1714147960484;
        Fri, 26 Apr 2024 09:12:40 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id m6-20020ac807c6000000b00434fd7d6d00sm8007149qth.2.2024.04.26.09.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 09:12:40 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:12:32 -0400
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
Message-ID: <ZivScN8-Uoi9eye8@x1n>
References: <20240402125516.223131-1-david@redhat.com>
 <20240402125516.223131-2-david@redhat.com>
 <e685c532-8330-4a57-bc08-c67845e0c352@redhat.com>
 <Ziuv2jLY1wgBITiP@x1n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ziuv2jLY1wgBITiP@x1n>

On Fri, Apr 26, 2024 at 09:44:58AM -0400, Peter Xu wrote:
> On Fri, Apr 26, 2024 at 09:17:47AM +0200, David Hildenbrand wrote:
> > On 02.04.24 14:55, David Hildenbrand wrote:
> > > Let's consistently call the "fast-only" part of GUP "GUP-fast" and rename
> > > all relevant internal functions to start with "gup_fast", to make it
> > > clearer that this is not ordinary GUP. The current mixture of
> > > "lockless", "gup" and "gup_fast" is confusing.
> > > 
> > > Further, avoid the term "huge" when talking about a "leaf" -- for
> > > example, we nowadays check pmd_leaf() because pmd_huge() is gone. For the
> > > "hugepd"/"hugepte" stuff, it's part of the name ("is_hugepd"), so that
> > > stays.
> > > 
> > > What remains is the "external" interface:
> > > * get_user_pages_fast_only()
> > > * get_user_pages_fast()
> > > * pin_user_pages_fast()
> > > 
> > > The high-level internal functions for GUP-fast (+slow fallback) are now:
> > > * internal_get_user_pages_fast() -> gup_fast_fallback()
> > > * lockless_pages_from_mm() -> gup_fast()
> > > 
> > > The basic GUP-fast walker functions:
> > > * gup_pgd_range() -> gup_fast_pgd_range()
> > > * gup_p4d_range() -> gup_fast_p4d_range()
> > > * gup_pud_range() -> gup_fast_pud_range()
> > > * gup_pmd_range() -> gup_fast_pmd_range()
> > > * gup_pte_range() -> gup_fast_pte_range()
> > > * gup_huge_pgd()  -> gup_fast_pgd_leaf()
> > > * gup_huge_pud()  -> gup_fast_pud_leaf()
> > > * gup_huge_pmd()  -> gup_fast_pmd_leaf()
> > > 
> > > The weird hugepd stuff:
> > > * gup_huge_pd() -> gup_fast_hugepd()
> > > * gup_hugepte() -> gup_fast_hugepte()
> > 
> > I just realized that we end up calling these from follow_hugepd() as well.
> > And something seems to be off, because gup_fast_hugepd() won't have the VMA
> > even in the slow-GUP case to pass it to gup_must_unshare().
> > 
> > So these are GUP-fast functions and the terminology seem correct. But the
> > usage from follow_hugepd() is questionable,
> > 
> > commit a12083d721d703f985f4403d6b333cc449f838f6
> > Author: Peter Xu <peterx@redhat.com>
> > Date:   Wed Mar 27 11:23:31 2024 -0400
> > 
> >     mm/gup: handle hugepd for follow_page()
> > 
> > 
> > states "With previous refactors on fast-gup gup_huge_pd(), most of the code
> > can be leveraged", which doesn't look quite true just staring the the
> > gup_must_unshare() call where we don't pass the VMA. Also,
> > "unlikely(pte_val(pte) != pte_val(ptep_get(ptep)" doesn't make any sense for
> > slow GUP ...
> 
> Yes it's not needed, just doesn't look worthwhile to put another helper on
> top just for this.  I mentioned this in the commit message here:
> 
>   There's something not needed for follow page, for example, gup_hugepte()
>   tries to detect pgtable entry change which will never happen with slow
>   gup (which has the pgtable lock held), but that's not a problem to check.
> 
> > 
> > @Peter, any insights?
> 
> However I think we should pass vma in for sure, I guess I overlooked that,
> and it didn't expose in my tests too as I probably missed ./cow.
> 
> I'll prepare a separate patch on top of this series and the gup-fast rename
> patches (I saw this one just reached mm-stable), and I'll see whether I can
> test it too if I can find a Power system fast enough.  I'll probably drop
> the "fast" in the hugepd function names too.

Hmm, so when I enable 2M hugetlb I found ./cow is even failing on x86.

  # ./cow  | grep -B1 "not ok"
  # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
  not ok 161 No leak from parent into child
  --
  # [RUN] vmsplice() + unmap in child with mprotect() optimization ... with hugetlb (2048 kB)
  not ok 215 No leak from parent into child
  --
  # [RUN] vmsplice() before fork(), unmap in parent after fork() ... with hugetlb (2048 kB)
  not ok 269 No leak from child into parent
  --
  # [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 kB)
  not ok 323 No leak from child into parent

And it looks like it was always failing.. perhaps since the start?  We
didn't do the same on hugetlb v.s. normal anon from that regard on the
vmsplice() fix.

I drafted a patch to allow refcount>1 detection as the same, then all tests
pass for me, as below.

David, I'd like to double check with you before I post anything: is that
your intention to do so when working on the R/O pinning or not?

Thanks,

=========
From 7300c249738dadda1457c755b597c1551dfe8dc6 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 26 Apr 2024 11:41:12 -0400
Subject: [PATCH] mm/hugetlb: Fix vmsplice case on memory leak once more

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 417fc5cdb6ee..1ca102013561 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5961,10 +5961,13 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 
 retry_avoidcopy:
 	/*
-	 * If no-one else is actually using this page, we're the exclusive
-	 * owner and can reuse this page.
+	 * If the page is marked exlusively owned (e.g. longterm pinned),
+	 * we can reuse it.  Otherwise if no-one else is using this page,
+	 * we can savely set the exclusive bit and reuse it.
 	 */
-	if (folio_mapcount(old_folio) == 1 && folio_test_anon(old_folio)) {
+	if (folio_test_anon(old_folio) &&
+	    (PageAnonExclusive(&old_folio->page) ||
+	     folio_ref_count(old_folio) == 1)) {
 		if (!PageAnonExclusive(&old_folio->page)) {
 			folio_move_anon_rmap(old_folio, vma);
 			SetPageAnonExclusive(&old_folio->page);
-- 
2.44.0


-- 
Peter Xu


