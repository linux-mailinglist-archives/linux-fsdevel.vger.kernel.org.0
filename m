Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D95E364121
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 13:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbhDSL5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 07:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233519AbhDSL5E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:57:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03A2761221;
        Mon, 19 Apr 2021 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618833395;
        bh=6A/ev0xWFu6QEr1qRdJmTLcg7g1Q5yOrYX9lSKkBwrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxO9956IYPxD7CWbXB3fSSCXGQTBGoPbq8d0e6mudSqUOOR9D/a/frTDdxrhpXp3T
         u3HOTCCCGMxCE/5oFsDEE7CL7oJo0UiFyE8XATL/PtjV1UyIMF3EyMmtXChnpmANf3
         xvGP/jZELsbTCSFAeN0de19xcjENeBafkHrYYT3aIAMpwGMCplJXdJyijY7bDsnsxV
         /MOKSwyo2LLpN1+M7yhhDDA1uJNr6IoUGDX83ZilzKhM+0TcMHp8KZpuLjiLSDsEjb
         4PrIm8F9iUjdT44aR4dOTbKzDBo3Crs7XfVqwdx02xV+XZiDVN4SXOnKlpH/im2nqn
         6aIPJA3ZtmO0Q==
Date:   Mon, 19 Apr 2021 14:56:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
Message-ID: <YH1v4XVzfXC1dYND@kernel.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <20210419112302.GX2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419112302.GX2531743@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 12:23:02PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 19, 2021 at 11:42:18AM +0300, Mike Rapoport wrote:
> > The perf profile of the test indicated that the regression is caused by
> > page_is_secretmem() called from gup_pte_range() (inlined by gup_pgd_range):
> 
> Uhh ... you're calling it in the wrong place!
> 
>                 VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>                 page = pte_page(pte);
> 
>                 if (page_is_secretmem(page))
>                         goto pte_unmap;
> 
>                 head = try_grab_compound_head(page, 1, flags);
>                 if (!head)
>                         goto pte_unmap;
> 
> So you're calling page_is_secretmem() on a struct page without having
> a refcount on it.  That is definitely not allowed.  secretmem seems to
> be full of these kinds of races; I know this isn't the first one I've
> seen in it.  I don't think this patchset is ready for this merge window.

There were races in the older version that did caching of large pages and
those were fixed then, but this is anyway irrelevant because all that code
was dropped in the latest respins.

I don't think that the fix of the race in gup_pte_range is that significant
to wait 3 more months because of it.
 
> With that fixed, you'll have a head page that you can use for testing,
> which means you don't need to test PageCompound() (because you know the
> page isn't PageTail), you can just test PageHead().

I can't say I follow you here. page_is_secretmem() is intended to be a
generic test, so I don't see how it will get PageHead() if it is called
from other places.

-- 
Sincerely yours,
Mike.
