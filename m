Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476FD26D372
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 08:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIQGKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 02:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgIQGKc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:10:32 -0400
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 02:10:30 EDT
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0884208A9;
        Thu, 17 Sep 2020 06:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600322537;
        bh=CIn6WbP0PnrQ3swBmqoXOV/7IIFuke5wts27Oqfqgg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vux4kkpHuXcUr7JNEHn4Ta2uTVvfxtbJ9itAdl2PBkK6QyIeLEPF/IgXqabss0x27
         PzEi/Ljvi7tKISYtA19lM11TCsz3Xb6kP/FhycSx/lQzYL5iW0K3kS8LlY4wG3QD8o
         sB0DVP4rSIY6tB2sseLZOZLHziJ/3k7brwfFikrY=
Date:   Thu, 17 Sep 2020 09:02:04 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
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
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH v5 0/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200917060204.GO2142832@kernel.org>
References: <20200916073539.3552-1-rppt@kernel.org>
 <20200916162020.0d68c2bd6711024cfcaa8bd7@linux-foundation.org>
 <CAKgNAkiSRDoZWKkBLB03X_knOeoeKVTy2oLmMopZ5vK8UZSAPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkiSRDoZWKkBLB03X_knOeoeKVTy2oLmMopZ5vK8UZSAPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 07:46:12AM +0200, Michael Kerrisk (man-pages) wrote:
> On Thu, 17 Sep 2020 at 01:20, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 16 Sep 2020 10:35:34 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> >
> > > This is an implementation of "secret" mappings backed by a file descriptor.
> > > I've dropped the boot time reservation patch for now as it is not strictly
> > > required for the basic usage and can be easily added later either with or
> > > without CMA.
> >
> > It seems early days for this, especially as regards reviewer buyin.
> > But I'll toss it in there to get it some additional testing.
> >
> > A test suite in tools/testging/selftests/ would be helpful, especially
> > for arch maintainers.
> >
> > I assume that user-facing manpage alterations are planned?

> I was just about to write a mail into this thread when I saw this :-).
> 
> So far, I don't think I saw a manual page patch. Mike, how about it?

It is planned :)

I have a draft, but I'm waiting for consensus about the uncached
mappings before sending it out.

-- 
Sincerely yours,
Mike.
