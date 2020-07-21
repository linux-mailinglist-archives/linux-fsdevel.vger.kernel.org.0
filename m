Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9812285B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGUQbx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:31:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:46226 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbgGUQbw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:31:52 -0400
IronPort-SDR: o0NiPHrTuxyP+q0NerB5nLFWmpMBzzujbGJ4Xpay4EJr9vBcrn0nyDvKIft1+P0zWUc9RAxnLz
 YlsnXg+/tuqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147673884"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="147673884"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 09:31:52 -0700
IronPort-SDR: QIqyg569mkeyzGevueJJ0WqfJG1wbbgWKT8l7gfSm5T3TqYGXngLSHY7sbeaPpwcZZol3ESKK7
 P6/eMlyR/hZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="270482086"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2020 09:31:52 -0700
Date:   Tue, 21 Jul 2020 09:31:52 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20200721163151.GA643353@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-14-ira.weiny@intel.com>
 <20200717092139.GC10769@hirez.programming.kicks-ass.net>
 <20200719041319.GA478573@iweiny-DESK2.sc.intel.com>
 <20200720091740.GP10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720091740.GP10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 11:17:40AM +0200, Peter Zijlstra wrote:
> On Sat, Jul 18, 2020 at 09:13:19PM -0700, Ira Weiny wrote:
> > On Fri, Jul 17, 2020 at 11:21:39AM +0200, Peter Zijlstra wrote:
> > > On Fri, Jul 17, 2020 at 12:20:52AM -0700, ira.weiny@intel.com wrote:
> > > > @@ -31,6 +32,20 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
> > > >  
> > > >  #include <asm/kmap_types.h>
> > > >  
> > > > +static inline void enable_access(struct page *page)
> > > > +{
> > > > +	if (!page_is_access_protected(page))
> > > > +		return;
> > > > +	dev_access_enable();
> > > > +}
> > > > +
> > > > +static inline void disable_access(struct page *page)
> > > > +{
> > > > +	if (!page_is_access_protected(page))
> > > > +		return;
> > > > +	dev_access_disable();
> > > > +}
> > > 
> > > These are some very generic names, do we want them to be a little more
> > > specific?
> > 
> > I had them named kmap_* but Dave (I think it was Dave) thought they did not
> > really apply strictly to kmap_*.
> > 
> > They are static to this file which I thought may be sufficient to 'uniqify'
> > them?
> 
> They're static to a .h, which means they're all over the place ;-)

I've thought about it a bit.  I think I agree with both you and Dave.

How about:

dev_page_{en,dis}able_access()

??

I've made that change for now.

Thanks,
Ira
