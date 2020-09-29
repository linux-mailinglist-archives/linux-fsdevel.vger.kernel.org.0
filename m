Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE4327CE64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 15:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgI2NFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 09:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbgI2NFr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:05:47 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CD4820848;
        Tue, 29 Sep 2020 13:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601384746;
        bh=w8jEjdPVhwgAP8ieOGmZq7rvrkzmFW13pl6Bcj/9DDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfoO9Oo/YwKl80W7Ps/3xh0cfYEHin8QOUrn/iFqhLYw+b2DAWHKu9Y+mnqgIAACA
         uQkYtRdB+liRGsxjQlUpAtvTPmGTHbQnf35XbZMDwXCeXkiEteBW7/GT/3ZbUZnHCL
         kuQnBbyQK81Mz6jqRSLbGj/2AcjW0JSpMYmSqJQw=
Date:   Tue, 29 Sep 2020 16:05:29 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20200929130529.GE2142832@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 09:41:25AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 24, 2020 at 04:29:03PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Removing a PAGE_SIZE page from the direct map every time such page is
> > allocated for a secret memory mapping will cause severe fragmentation of
> > the direct map. This fragmentation can be reduced by using PMD-size pages
> > as a pool for small pages for secret memory mappings.
> > 
> > Add a gen_pool per secretmem inode and lazily populate this pool with
> > PMD-size pages.
> 
> What's the actual efficacy of this? Since the pmd is per inode, all I
> need is a lot of inodes and we're in business to destroy the directmap,
> no?
> 
> Afaict there's no privs needed to use this, all a process needs is to
> stay below the mlock limit, so a 'fork-bomb' that maps a single secret
> page will utterly destroy the direct map.

This indeed will cause 1G pages in the direct map to be split into 2M
chunks, but I disagree with 'destroy' term here. Citing the cover letter
of an earlier version of this series:

  I've tried to find some numbers that show the benefit of using larger
  pages in the direct map, but I couldn't find anything so I've run a
  couple of benchmarks from phoronix-test-suite on my laptop (i7-8650U
  with 32G RAM).
  
  I've tested three variants: the default with 28G of the physical
  memory covered with 1G pages, then I disabled 1G pages using
  "nogbpages" in the kernel command line and at last I've forced the
  entire direct map to use 4K pages using a simple patch to
  arch/x86/mm/init.c.  I've made runs of the benchmarks with SSD and
  tmpfs.
  
  Surprisingly, the results does not show huge advantage for large
  pages. For instance, here the results for kernel build with
  'make -j8', in seconds:
  
                        |  1G    |  2M    |  4K
  ----------------------+--------+--------+---------
  ssd, mitigations=on	| 308.75 | 317.37 | 314.9
  ssd, mitigations=off	| 305.25 | 295.32 | 304.92
  ram, mitigations=on	| 301.58 | 322.49 | 306.54
  ram, mitigations=off	| 299.32 | 288.44 | 310.65
  
  All the results I have are available here:
 
  https://docs.google.com/spreadsheets/d/1tdD-cu8e93vnfGsTFxZ5YdaEfs2E1GELlvWNOGkJV2U/edit?usp=sharing

The numbers suggest that using smaller pages in the direct map does not
necessarily leads to performance degradation and some runs produced
better results with smaller pages in the direct map.

> I really don't like this, at all.
> 
> IIRC Kirill looked at merging the directmap. I think he ran into
> performance issues there, but we really need something like that before
> something like this lands.

-- 
Sincerely yours,
Mike.
