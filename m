Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBB43640D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhDSLsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 07:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhDSLsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:48:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B3CC06174A;
        Mon, 19 Apr 2021 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bwPuhmLV9iDdbBtA80aP2NeOoPck37vPl2v0l8S8dJw=; b=ZKgd+wiWxB4OjJM0AIDMQSKXxR
        mK2R/z3oqKh1PUQkJXhvcIcCeNtKgp8OXUyGgAszjnbvM4jRpHJ8CjWbc7hBN1U6HbdDGK+UorYOc
        MFcMKMdSOPfBZbD7GWLjHFe+LP+3z+b1cJWnPckDm478VhnIuObWzbqtK9sHaZ8jwmo1+eWrdBGQa
        v1kBE40Vi4xvSvLhZ0bnDkcLGvuPRT/cK5/47tFYec+ZGcwN2cVCQO61pGGxpuB3lYinJPup2TnB4
        GZ/ajfYkgk2Tj5Ry8+D2ggrOGM4MLh5XgrDlBR0M9Vx/aMmMy+8h8RgjgqInD8p/8jeX+er7cc13j
        MOHIVxrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYSJB-00Dg11-HM; Mon, 19 Apr 2021 11:43:29 +0000
Date:   Mon, 19 Apr 2021 12:43:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20210419114317.GY2531743@casper.infradead.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
 <YH1PE4oWeicpJT9g@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH1PE4oWeicpJT9g@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 12:36:19PM +0300, Mike Rapoport wrote:
> Well, most if the -4.2% of the performance regression kbuild reported were
> due to repeated compount_head(page) in page_mapping(). So the whole point
> of this patch is to avoid calling page_mapping().

It's quite ludicrous how many times we call compound_head() in
page_mapping() today:

 page = compound_head(page);
 if (__builtin_expect(!!(PageSlab(page)), 0))
 if (__builtin_expect(!!(PageSwapCache(page)), 0)) {

TESTPAGEFLAG(Slab, slab, PF_NO_TAIL) expands to:

static __always_inline int PageSlab(struct page *page)
{
	PF_POISONED_CHECK(compound_head(page));
	return test_bit(PG_slab, &compound_head(page));
}

static __always_inline int PageSwapCache(struct page *page)
{
        page = compound_head(page);
        return PageSwapBacked(page) && test_bit(PG_swapcache, &page->flags);
}

but then!

TESTPAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL) also expands like Slab does.

So that's six calls to compound_head(), depending what Kconfig options
you have enabled.

And folio_mapping() is one of the functions I add in the first batch of
patches, so review, etc will be helpful.
