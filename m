Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E07E2ADDC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 19:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgKJSHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 13:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgKJSHD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:07:03 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35F820781;
        Tue, 10 Nov 2020 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605031623;
        bh=bAkJ6qFghBqAmYDEu7geL4WoAC5U+zvSUa3tfgn5GqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsCfawPZ7PZXYREKxvAae+uk/8IQqHbGnFjdff7AGzyGjc4x/SKxcILYVT/rLCce9
         nmpcocs0Se3KfPVLk80KrhXz6x5Oy3hYomKMAGm/YGBiEJSxYFnSu9uNQghCJwavMR
         lgeiRSDZJxGsficIgAw5m1qVpszWlc3MZZCq7S1w=
Date:   Tue, 10 Nov 2020 20:06:48 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v8 2/9] mmap: make mlock_future_check() global
Message-ID: <20201110180648.GB4758@kernel.org>
References: <20201110151444.20662-1-rppt@kernel.org>
 <20201110151444.20662-3-rppt@kernel.org>
 <9e2fafd7-abb0-aa79-fa66-cd8662307446@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e2fafd7-abb0-aa79-fa66-cd8662307446@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 06:17:26PM +0100, David Hildenbrand wrote:
> On 10.11.20 16:14, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > It will be used by the upcoming secret memory implementation.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >   mm/internal.h | 3 +++
> >   mm/mmap.c     | 5 ++---
> >   2 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/internal.h b/mm/internal.h
> > index c43ccdddb0f6..ae146a260b14 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -348,6 +348,9 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
> >   extern void mlock_vma_page(struct page *page);
> >   extern unsigned int munlock_vma_page(struct page *page);
> > +extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
> > +			      unsigned long len);
> > +
> >   /*
> >    * Clear the page's PageMlocked().  This can be useful in a situation where
> >    * we want to unconditionally remove a page from the pagecache -- e.g.,
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 61f72b09d990..c481f088bd50 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1348,9 +1348,8 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
> >   	return hint;
> >   }
> > -static inline int mlock_future_check(struct mm_struct *mm,
> > -				     unsigned long flags,
> > -				     unsigned long len)
> > +int mlock_future_check(struct mm_struct *mm, unsigned long flags,
> > +		       unsigned long len)
> >   {
> >   	unsigned long locked, lock_limit;
> > 
> 
> So, an interesting question is if you actually want to charge secretmem
> pages against mlock now, or if you want a dedicated secretmem cgroup
> controller instead?

Well, with the current implementation there are three limits an
administrator can use to control secretmem limits: mlock, memcg and
kernel parameter.

The kernel parameter puts a global upper limit for secretmem usage,
memcg accounts all secretmem allocations, including the unused memory in
large pages caching and mlock allows per task limit for secretmem
mappings, well, like mlock does.

I didn't consider a dedicated cgroup, as it seems we already have enough
existing knobs and a new one would be unnecessary.

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
