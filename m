Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE0278468
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 11:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgIYJu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 05:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgIYJu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:50:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47002C0613CE;
        Fri, 25 Sep 2020 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=28F9ogfbtjbZVl/n21rnRnyA08/27VBA9tFd1Emv+00=; b=eDtTZJcKIKXiogPX8IEoroVaur
        XW7EI4ZB21PTkWWr9eWrFNLyAkJMplmIZMrBeAnSzW1ixnZ6BrvaKgafONbS0Joxy2CeX/wnHxrF3
        QqwrtXqNNoROvt9GzJImRgUczIUwWbo+Q/n6g6pLgQxTCohc5HZjzKY9ukoT8pzxVga7MCJTci00u
        0GD1c38oFcQp82w8s0Sb1WyrTVLELnCaIlpKcH9QKL4xD5S/TA24mg6YoIDwpyhlh+50WQmGXx9t3
        Am6sBfG2czlVMfNPRh2C6JExGJ+N5gbSe/yCFv0CGD1FP+tm8XQ/O71XwgOzhlYZ/Xlfujol8O6M7
        B2891KUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLkN6-0000zO-FY; Fri, 25 Sep 2020 09:50:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5927301A27;
        Fri, 25 Sep 2020 11:50:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BEFA320104626; Fri, 25 Sep 2020 11:50:29 +0200 (CEST)
Date:   Fri, 25 Sep 2020 11:50:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
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
Message-ID: <20200925095029.GX2628@hirez.programming.kicks-ass.net>
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

Given that this thing doesn't have a migrate hook, that seems like an
eminently reasonable contraint. Because not only will it mess up the
directmap, it will also destroy the ability of the page-allocator /
compaction to re-form high order blocks by sprinkling holes throughout.

Also, this is all very close to XPFO, yet I don't see that mentioned
anywhere.

Further still, it has this HAVE_SECRETMEM_UNCACHED nonsense which is
completely unused. I'm not at all sure exposing UNCACHED to random
userspace is a sane idea.
