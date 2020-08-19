Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDC24A4FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 19:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHSReB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 13:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgHSReA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:34:00 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E536206FA;
        Wed, 19 Aug 2020 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597858440;
        bh=1Kuiv8iGgm6SalVVkZfBiL4OHWxQAxShozxNk+zBolU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfCq2RYoBnpI+rRZ0w6qSWuewp0KRf89Aalz44HYo9TFEhrDUQICW5QIJCrh8Ca0K
         uLAW8PYxM/i8eVvlbksIuqNR9MKaOckhfOZhXePVk3EU37CkhLrBof1KFmHs22XZC0
         sszvftR/cJX4BhW1GWf6wauiWhaZ3R/1Xv2rD11Y=
Date:   Wed, 19 Aug 2020 20:33:47 +0300
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
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v4 6/6] mm: secretmem: add ability to reserve memory at
 boot
Message-ID: <20200819173347.GW752365@kernel.org>
References: <20200818141554.13945-1-rppt@kernel.org>
 <20200818141554.13945-7-rppt@kernel.org>
 <03ec586d-c00c-c57e-3118-7186acb7b823@redhat.com>
 <20200819115335.GU752365@kernel.org>
 <10bf57a9-c3c2-e13c-ca50-e872b7a2db0c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10bf57a9-c3c2-e13c-ca50-e872b7a2db0c@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:10:43PM +0200, David Hildenbrand wrote:
> On 19.08.20 13:53, Mike Rapoport wrote:
> > On Wed, Aug 19, 2020 at 12:49:05PM +0200, David Hildenbrand wrote:
> >> On 18.08.20 16:15, Mike Rapoport wrote:
> >>> From: Mike Rapoport <rppt@linux.ibm.com>
> >>>
> >>> Taking pages out from the direct map and bringing them back may create
> >>> undesired fragmentation and usage of the smaller pages in the direct
> >>> mapping of the physical memory.
> >>>
> >>> This can be avoided if a significantly large area of the physical memory
> >>> would be reserved for secretmem purposes at boot time.
> >>>
> >>> Add ability to reserve physical memory for secretmem at boot time using
> >>> "secretmem" kernel parameter and then use that reserved memory as a global
> >>> pool for secret memory needs.
> >>
> >> Wouldn't something like CMA be the better fit? Just wondering. Then, the
> >> memory can actually be reused for something else while not needed.
> > 
> > The memory allocated as secret is removed from the direct map and the
> > boot time reservation is intended to reduce direct map fragmentatioan
> > and to avoid splitting 1G pages there. So with CMA I'd still need to
> > allocate 1G chunks for this and once 1G page is dropped from the direct
> > map it still cannot be reused for anything else until it is freed.
> > 
> > I could use CMA to do the boot time reservation, but doing the
> > reservesion directly seemed simpler and more explicit to me.
> 
> Well, using CMA would give you the possibility to let the memory be used
> for other purposes until you decide it's the right time to take it +
> remove the direct mapping etc.

I still can't say I follow you here. If I reseve a CMA area as a pool
for secret memory 1G pages, it is still reserved and it still cannot be
used for other purposes, right?

> I wonder if a sane approach would be to require to allocate a pool
> during boot and only take pages ever from that pool. That would avoid
> spilling many unmovable pages all over the place, locally limiting them
> to your area here.

That's what I tried to implement. The pool reserved at boot time is in a
way similar to booting with mem=X and then splitting the remaining
memory between the VMs.
In this case, the memory reserved at boot is never in the direct map and
allocations from such pool will not cause fragmentation.

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
