Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F021FC14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbgGNTG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:06:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:45257 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731196AbgGNTGR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:06:17 -0400
IronPort-SDR: 27iBeCfoeLRrVUeRTy/BI0zBGPcmN+PmJoub48PPOgpH+618PXlf6ue/5i8667iiPyfSDqvbOY
 ES4o41RqYn5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="148148363"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="148148363"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 12:06:16 -0700
IronPort-SDR: 372ah54Muur1nzmIJ6WpFVvasq6EKc/XBygmqwb4njk9NqFeHdl/Vb7u58xf0Grd72pTvNiTPg
 ndEouPAOrQ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="324632815"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2020 12:06:16 -0700
Date:   Tue, 14 Jul 2020 12:06:16 -0700
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
Subject: Re: [RFC PATCH 12/15] kmap: Add stray write protection for device
 pages
Message-ID: <20200714190615.GC3008823@iweiny-DESK2.sc.intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-13-ira.weiny@intel.com>
 <20200714084451.GQ10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714084451.GQ10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:44:51AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 14, 2020 at 12:02:17AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Device managed pages may have additional protections.  These protections
> > need to be removed prior to valid use by kernel users.
> > 
> > Check for special treatment of device managed pages in kmap and take
> > action if needed.  We use kmap as an interface for generic kernel code
> > because under normal circumstances it would be a bug for general kernel
> > code to not use kmap prior to accessing kernel memory.  Therefore, this
> > should allow any valid kernel users to seamlessly use these pages
> > without issues.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  include/linux/highmem.h | 32 +++++++++++++++++++++++++++++++-
> >  1 file changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> > index d6e82e3de027..7f809d8d5a94 100644
> > --- a/include/linux/highmem.h
> > +++ b/include/linux/highmem.h
> > @@ -8,6 +8,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/hardirq.h>
> > +#include <linux/memremap.h>
> >  
> >  #include <asm/cacheflush.h>
> >  
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
> So, if I followed along correctly, you're proposing to do a WRMSR per
> k{,un}map{_atomic}(), sounds like excellent performance all-round :-(

Only to pages which have this additional protection, ie not DRAM.

User mappings of this memory is not affected (would be covered by User PKeys if
desired).  User mappings to persistent memory are the primary use case and the
performant path.

Ira
