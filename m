Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D498363EA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 11:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhDSJhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 05:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237771AbhDSJhH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:37:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE5486101D;
        Mon, 19 Apr 2021 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618824997;
        bh=gKvvGKT7gwRRGsoZvfcNRGcz0Uq+afSf3EpowR/OLNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3lkwvjW/R0feyjsaGtC46WUvSA5fINd83XuQt+ZESQgLmLjszsOUu+LDUHEcKzFK
         sigplCcojQ4mBEu6rER8dXQGEZqUGKDoigx7QfRx9QLVtR+aRgfcwkGniPnNZcwK1Y
         esYRQZkAPosCP1G+VuLB3y59ckxByt6ogqqNClQC0M2eiZ92c2ENWNcdwDNmkJaobH
         Q6eesP5D30kBeyc+SuhpDLAJuFI3pxzWfEnJtG1/zLkGk9o8TBN3uAS9cvmcCI24LT
         EfVn9mOhYvqkGR2hQgso12puyTHP9lzT9F9imFG/PQhcsS3AMAg4DeKSgo5cUC9n88
         820gRflNkMWuw==
Date:   Mon, 19 Apr 2021 12:36:19 +0300
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
Message-ID: <YH1PE4oWeicpJT9g@kernel.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 11:15:02AM +0200, David Hildenbrand wrote:
> On 19.04.21 10:42, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Kernel test robot reported -4.2% regression of will-it-scale.per_thread_ops
> > due to commit "mm: introduce memfd_secret system call to create "secret"
> > memory areas".
> > 
> > The perf profile of the test indicated that the regression is caused by
> > page_is_secretmem() called from gup_pte_range() (inlined by gup_pgd_range):
> > 
> >   27.76  +2.5  30.23       perf-profile.children.cycles-pp.gup_pgd_range
> >    0.00  +3.2   3.19 ± 2%  perf-profile.children.cycles-pp.page_mapping
> >    0.00  +3.7   3.66 ± 2%  perf-profile.children.cycles-pp.page_is_secretmem
> > 
> > Further analysis showed that the slow down happens because neither
> > page_is_secretmem() nor page_mapping() are not inline and moreover,
> > multiple page flags checks in page_mapping() involve calling
> > compound_head() several times for the same page.
> > 
> > Make page_is_secretmem() inline and replace page_mapping() with page flag
> > checks that do not imply page-to-head conversion.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> > 
> > @Andrew,
> > The patch is vs v5.12-rc7-mmots-2021-04-15-16-28, I'd appreciate if it would
> > be added as a fixup to the memfd_secret series.
> > 
> >   include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
> >   mm/secretmem.c            | 12 +-----------
> >   2 files changed, 26 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> > index 907a6734059c..b842b38cbeb1 100644
> > --- a/include/linux/secretmem.h
> > +++ b/include/linux/secretmem.h
> > @@ -4,8 +4,32 @@
> >   #ifdef CONFIG_SECRETMEM
> > +extern const struct address_space_operations secretmem_aops;
> > +
> > +static inline bool page_is_secretmem(struct page *page)
> > +{
> > +	struct address_space *mapping;
> > +
> > +	/*
> > +	 * Using page_mapping() is quite slow because of the actual call
> > +	 * instruction and repeated compound_head(page) inside the
> > +	 * page_mapping() function.
> > +	 * We know that secretmem pages are not compound and LRU so we can
> > +	 * save a couple of cycles here.
> > +	 */
> > +	if (PageCompound(page) || !PageLRU(page))
> > +		return false;
> 
> I'd assume secretmem pages are rare in basically every setup out there. So
> maybe throwing in a couple of likely()/unlikely() might make sense.

I'd say we could do unlikely(page_is_secretmem()) at call sites. Here I can
hardly estimate which pages are going to be checked.
 
> > +
> > +	mapping = (struct address_space *)
> > +		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
> > +
> 
> Not sure if open-coding page_mapping is really a good idea here -- or even
> necessary after the fast path above is in place. Anyhow, just my 2 cents.

Well, most if the -4.2% of the performance regression kbuild reported were
due to repeated compount_head(page) in page_mapping(). So the whole point
of this patch is to avoid calling page_mapping().

> The idea of the patch makes sense to me.

-- 
Sincerely yours,
Mike.
