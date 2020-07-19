Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB4224EEF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 06:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgGSENU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 00:13:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:55214 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgGSENU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 00:13:20 -0400
IronPort-SDR: Om92Pvm7Ki8VKpNW5i4fQPk8M0XtmVLVwVWcVksQQbjKzyPDc/6FmxWxqcLBDJh8IURjL6jG7U
 363G7IUZ+wqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="148941748"
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800"; 
   d="scan'208";a="148941748"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 21:13:19 -0700
IronPort-SDR: qwya3Ig/wTKyf8d54/1yGKJAkRrY9AmYdJEot9EFwm2/RcIgOYdir4HGKjpLMSEgmFG1/mx71I
 /P8FqF2oclGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,369,1589266800"; 
   d="scan'208";a="271149876"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2020 21:13:19 -0700
Date:   Sat, 18 Jul 2020 21:13:19 -0700
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
Message-ID: <20200719041319.GA478573@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-14-ira.weiny@intel.com>
 <20200717092139.GC10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717092139.GC10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 11:21:39AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:52AM -0700, ira.weiny@intel.com wrote:
> > @@ -31,6 +32,20 @@ static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
> >  
> >  #include <asm/kmap_types.h>
> >  
> > +static inline void enable_access(struct page *page)
> > +{
> > +	if (!page_is_access_protected(page))
> > +		return;
> > +	dev_access_enable();
> > +}
> > +
> > +static inline void disable_access(struct page *page)
> > +{
> > +	if (!page_is_access_protected(page))
> > +		return;
> > +	dev_access_disable();
> > +}
> 
> These are some very generic names, do we want them to be a little more
> specific?

I had them named kmap_* but Dave (I think it was Dave) thought they did not
really apply strictly to kmap_*.

They are static to this file which I thought may be sufficient to 'uniqify'
them?

I'm ok to change them but that is how I arrived at this name.

Ira
