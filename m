Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA614225B29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 11:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgGTJRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 05:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgGTJRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:17:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D03C061794;
        Mon, 20 Jul 2020 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9k1ombCB/XhICcqxKFVOjQ1AGpkCxpa4eC8EdBJWgkY=; b=BwLB0hGgSaqBkwLtMWDBnHXKfa
        y7KAxz2bvDvF28yAcByni6ft1LZoY+n7qXz+5Poaoi7g+/6sfr6GteFHgRvelLQIKZNHsgFcjyqz1
        /AqTtFK1HwwxUaSbQIh77cuNL+w4fZNtWq+ryKADWQMt+4pqOMsCSvXicIUyJItyjjRkCcN18/M4m
        sIKPVkl/Toz0xyLQqTr4OjhenYlHlihU5FH2u4zr7B5dyinii+jIF/lP/ajnPkCRs9UrZkovvo0dH
        cbu7HHK7n/aOJC7/YrfYdPuIfqJK6w6DvqqGIsmDvMd7NIWQv8IueXLrH7qkCHuXA1pIwiFCtIwDh
        UYlS5ZNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxRvZ-00061o-To; Mon, 20 Jul 2020 09:17:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B6F05301AC6;
        Mon, 20 Jul 2020 11:17:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A63AA205A7673; Mon, 20 Jul 2020 11:17:40 +0200 (CEST)
Date:   Mon, 20 Jul 2020 11:17:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 13/17] kmap: Add stray write protection for device
 pages
Message-ID: <20200720091740.GP10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-14-ira.weiny@intel.com>
 <20200717092139.GC10769@hirez.programming.kicks-ass.net>
 <20200719041319.GA478573@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719041319.GA478573@iweiny-DESK2.sc.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 18, 2020 at 09:13:19PM -0700, Ira Weiny wrote:
> On Fri, Jul 17, 2020 at 11:21:39AM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 17, 2020 at 12:20:52AM -0700, ira.weiny@intel.com wrote:
> > > @@ -31,6 +32,20 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
> > >  
> > >  #include <asm/kmap_types.h>
> > >  
> > > +static inline void enable_access(struct page *page)
> > > +{
> > > +	if (!page_is_access_protected(page))
> > > +		return;
> > > +	dev_access_enable();
> > > +}
> > > +
> > > +static inline void disable_access(struct page *page)
> > > +{
> > > +	if (!page_is_access_protected(page))
> > > +		return;
> > > +	dev_access_disable();
> > > +}
> > 
> > These are some very generic names, do we want them to be a little more
> > specific?
> 
> I had them named kmap_* but Dave (I think it was Dave) thought they did not
> really apply strictly to kmap_*.
> 
> They are static to this file which I thought may be sufficient to 'uniqify'
> them?

They're static to a .h, which means they're all over the place ;-)
