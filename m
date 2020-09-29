Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E5B27CE73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 15:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgI2NHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 09:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgI2NHC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:07:02 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 579B4207F7;
        Tue, 29 Sep 2020 13:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601384821;
        bh=7KLc+w8RZZNLjtjf6HYJ79RwMDeyJUnvfHtVGdo8qiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GqCIqM7BqT+6pPkJY9utQWj93QJ3bSPfFrqfJHOudSA2n7THcsgAIPdERjDgGYpbv
         3YsHM8vksG2xzKmuaMDxtRxuppf8SFckyt7f4t7JRp6EXb5ekXTVyBUz49dbfKDnNc
         d4WEziQvM+yY9x8NI++tf8P6f980mVqec1FHevs4=
Date:   Tue, 29 Sep 2020 16:06:41 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200929130641.GG2142832@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <8435eff6-7fa9-d923-45e5-d8850e4c6d73@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8435eff6-7fa9-d923-45e5-d8850e4c6d73@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:00:30AM +0200, David Hildenbrand wrote:
> On 25.09.20 09:41, Peter Zijlstra wrote:
> > On Thu, Sep 24, 2020 at 04:29:03PM +0300, Mike Rapoport wrote:
> >> From: Mike Rapoport <rppt@linux.ibm.com>
> >>
> >> Removing a PAGE_SIZE page from the direct map every time such page is
> >> allocated for a secret memory mapping will cause severe fragmentation of
> >> the direct map. This fragmentation can be reduced by using PMD-size pages
> >> as a pool for small pages for secret memory mappings.
> >>
> >> Add a gen_pool per secretmem inode and lazily populate this pool with
> >> PMD-size pages.
> > 
> > What's the actual efficacy of this? Since the pmd is per inode, all I
> > need is a lot of inodes and we're in business to destroy the directmap,
> > no?
> > 
> > Afaict there's no privs needed to use this, all a process needs is to
> > stay below the mlock limit, so a 'fork-bomb' that maps a single secret
> > page will utterly destroy the direct map.
> > 
> > I really don't like this, at all.
> 
> As I expressed earlier, I would prefer allowing allocation of secretmem
> only from a previously defined CMA area. This would physically locally
> limit the pain.

The prevois version contained a patch that allowed reserving a memory
pool for the secretmem at boot time to avpoid splitting pages from the
direct map

> But my suggestion was not well received :)

The disagreemet was only whether to use CMA or simple boot time
reservation :-P

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
