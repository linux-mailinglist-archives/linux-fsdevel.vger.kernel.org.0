Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9D3641A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbhDSMZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 08:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbhDSMZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:25:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AE3C061760;
        Mon, 19 Apr 2021 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CpUXgyXNu2L6aDoABWkfEW3c8xEi9KV0vjBOP+ZePLk=; b=iQPnFaPBrCivR61heeMKYPHCvt
        pCkxUp9NhouUvSBFQbKd7Fhrz1AZsx3Q2HZw+IDT8EHnokduaSFYutUpfRsDIS9zau7bYybxvA1ff
        pFuhFl2IUQxSd7XRlYtlj+FFgppBw6LQsud2DK1DXCxjC27lUaR1zxXyZRCerN1ljbP11kgtjJLqD
        N3p32/8yEAIzdAsbm2eTCBPbMAghI+Qr4ApaAjdCTvfikAf7G0xc6BI0IOM72rhvFT7X+pD+yabkm
        HNtjrKvSh/m2oRc0ljDrhGv2UnUnfK5uxuGIjbM8MIST4BHLYve7TzvctYq/QernMV8JatSft25WL
        KBRcr6Lg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYSua-00Diet-6d; Mon, 19 Apr 2021 12:22:16 +0000
Date:   Mon, 19 Apr 2021 13:21:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <20210419122156.GZ2531743@casper.infradead.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <20210419112302.GX2531743@casper.infradead.org>
 <YH1v4XVzfXC1dYND@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH1v4XVzfXC1dYND@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 02:56:17PM +0300, Mike Rapoport wrote:
> On Mon, Apr 19, 2021 at 12:23:02PM +0100, Matthew Wilcox wrote:
> > So you're calling page_is_secretmem() on a struct page without having
> > a refcount on it.  That is definitely not allowed.  secretmem seems to
> > be full of these kinds of races; I know this isn't the first one I've
> > seen in it.  I don't think this patchset is ready for this merge window.
> 
> There were races in the older version that did caching of large pages and
> those were fixed then, but this is anyway irrelevant because all that code
> was dropped in the latest respins.
> 
> I don't think that the fix of the race in gup_pte_range is that significant
> to wait 3 more months because of it.

I have no particular interest in secretmem, but it seems that every time
I come across it while looking at something else, I see these kinds of
major mistakes in it.  That says to me it's not ready and hasn't seen
enough review.

> > With that fixed, you'll have a head page that you can use for testing,
> > which means you don't need to test PageCompound() (because you know the
> > page isn't PageTail), you can just test PageHead().
> 
> I can't say I follow you here. page_is_secretmem() is intended to be a
> generic test, so I don't see how it will get PageHead() if it is called
> from other places.

static inline bool head_is_secretmem(struct page *head)
{
	if (PageHead(head))
		return false;
	...
}

static inline bool page_is_secretmem(struct page *page)
{
	if (PageTail(page))
		return false;
	return head_is_secretmem(page);
}

(yes, calling it head is a misnomer, because it's not necessarily a head,
it might be a base page, but until we have a name for pages which might
be a head page or a base page, it'll have to do ...)
