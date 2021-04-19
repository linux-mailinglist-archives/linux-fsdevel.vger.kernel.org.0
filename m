Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF84364086
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 13:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbhDSL1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 07:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhDSL1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:27:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08BDC06174A;
        Mon, 19 Apr 2021 04:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8kRAoc0QBubKYge5PVOcpXOSqRAXAMW8YeZW9/WtJU8=; b=Q4iGwzjsJleF1GjQOjyti4BwEQ
        kMflgbMlKiSgpC29OgqfVgGrZttP1HwPBGt8N93ehv3ya+xnOskH/kBy+D0N5vT5yUe/+g1v9z/Ma
        Cp4tIDAseOedgjInQg5yHqOEvZbooQDFHeYs8Sryde6A4fQ5slcDMthytLKrH2OJz/4qJDzam9eBn
        p6bjarnH+CdB1hRK/wAvjCp96Ow2EiDF9/3ydKwZwqane+/kvenBjEPU7O5eAiYLGTdXKzhzt0PGo
        DvZtg4i6iUXZmGxEIMN7nGJNjQ60ITQJypATNUfusbk15xxeHMt+n9rKsreyAJad/2eA7Z5Mlaiyn
        rBuUX32A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYRza-00Dec0-Ty; Mon, 19 Apr 2021 11:23:12 +0000
Date:   Mon, 19 Apr 2021 12:23:02 +0100
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
Message-ID: <20210419112302.GX2531743@casper.infradead.org>
References: <20210419084218.7466-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419084218.7466-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 11:42:18AM +0300, Mike Rapoport wrote:
> The perf profile of the test indicated that the regression is caused by
> page_is_secretmem() called from gup_pte_range() (inlined by gup_pgd_range):

Uhh ... you're calling it in the wrong place!

                VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
                page = pte_page(pte);

                if (page_is_secretmem(page))
                        goto pte_unmap;

                head = try_grab_compound_head(page, 1, flags);
                if (!head)
                        goto pte_unmap;

So you're calling page_is_secretmem() on a struct page without having
a refcount on it.  That is definitely not allowed.  secretmem seems to
be full of these kinds of races; I know this isn't the first one I've
seen in it.  I don't think this patchset is ready for this merge window.

With that fixed, you'll have a head page that you can use for testing,
which means you don't need to test PageCompound() (because you know the
page isn't PageTail), you can just test PageHead().
