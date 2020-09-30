Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFAF27EBE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgI3PKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 11:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbgI3PKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:10:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1ABC0613D0;
        Wed, 30 Sep 2020 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5MQ9wWjMl2wFlC5FFeBBoGdxqFKxERQlgHCfOe6SJqc=; b=BuH49sEnpXdPdqBuzbVs2V633x
        nj0QNsnZGyV7Ur1XjcD+GgLOUPiioSSgYAd5LQANsJHnqdR8DPJWazR4b6fyMIXitNoG7i2qACEk+
        x90zdteFRAk01MpO/bR6H/INrJI1XI2Z43TfeD0w4o67kW8JKU7F7v72SRgVVditUoo8hvSGVzDht
        IAsFpsrXy2rohggWiPlFlZ49/3gB8uDSMyALzcjv+0EyTng6cu9mrYkRLaKyDQJSYJSgaeqtXpg7T
        r4qwLvOvtVk6qnTcZdu5tJ+aiAkiq/I/XPzY9EzutGsKlZpzzVHG+lZEakQO08fZJbB9Z3UwWnHbB
        qlCH3W+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNdjU-0007EC-6u; Wed, 30 Sep 2020 15:09:28 +0000
Date:   Wed, 30 Sep 2020 16:09:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20200930150928.GR20115@casper.infradead.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <20200929130529.GE2142832@kernel.org>
 <20200929141216.GO2628@hirez.programming.kicks-ass.net>
 <20200929145813.GA3226834@linux.ibm.com>
 <20200929151552.GS2628@hirez.programming.kicks-ass.net>
 <20200930102745.GC3226834@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930102745.GC3226834@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 30, 2020 at 01:27:45PM +0300, Mike Rapoport wrote:
> On Tue, Sep 29, 2020 at 05:15:52PM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 29, 2020 at 05:58:13PM +0300, Mike Rapoport wrote:
> > > On Tue, Sep 29, 2020 at 04:12:16PM +0200, Peter Zijlstra wrote:
> > 
> > > > It will drop them down to 4k pages. Given enough inodes, and allocating
> > > > only a single sekrit page per pmd, we'll shatter the directmap into 4k.
> > > 
> > > Why? Secretmem allocates PMD-size page per inode and uses it as a pool
> > > of 4K pages for that inode. This way it ensures that
> > > __kernel_map_pages() is always called on PMD boundaries.
> > 
> > Oh, you unmap the 2m page upfront? I read it like you did the unmap at
> > the sekrit page alloc, not the pool alloc side of things.
> > 
> > Then yes, but then you're wasting gobs of memory. Basically you can pin
> > 2M per inode while only accounting a single page.
> 
> Right, quite like THP :)

Huh?  THP accounts every page it allocates.  If you allocate 2MB,
it accounts 512 pages.  And THP are reclaimable by vmscan, this is
obviously not.

