Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCC3290F62
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Oct 2020 07:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410799AbgJQFgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Oct 2020 01:36:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:18143 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407407AbgJQFgU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:36:20 -0400
IronPort-SDR: z1ObCSkUQYoqiGlpwNCq8A/MaXnj1FTiuLFrq1/JDZcxGV6EnNmzfF4SJGXF6hAbTVQogtmXAD
 WpWT+dBKkNRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="230939350"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="230939350"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:14:11 -0700
IronPort-SDR: 3XRfBEMKtTlYf8Z8qW4rktOEmrz3tfwYHJY64FpmSJj9Yo7F5sdqW0j6CxcMd1S6SrD+tuozbQ
 2OvTFTNMfadw==
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="522523589"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:14:11 -0700
Date:   Fri, 16 Oct 2020 22:14:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20201017051410.GW2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
 <429789d3-ab5b-49c3-65c3-f0fc30a12516@intel.com>
 <20201016111226.GN2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016111226.GN2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 01:12:26PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 13, 2020 at 11:31:45AM -0700, Dave Hansen wrote:
> > > +/**
> > > + * It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
> > > + * serializing but still maintains ordering properties similar to WRPKRU.
> > > + * The current SDM section on PKRS needs updating but should be the same as
> > > + * that of WRPKRU.  So to quote from the WRPKRU text:
> > > + *
> > > + * 	WRPKRU will never execute transiently. Memory accesses
> > > + * 	affected by PKRU register will not execute (even transiently)
> > > + * 	until all prior executions of WRPKRU have completed execution
> > > + * 	and updated the PKRU register.
> > > + */
> > > +void write_pkrs(u32 new_pkrs)
> > > +{
> > > +	u32 *pkrs;
> > > +
> > > +	if (!static_cpu_has(X86_FEATURE_PKS))
> > > +		return;
> > > +
> > > +	pkrs = get_cpu_ptr(&pkrs_cache);
> > > +	if (*pkrs != new_pkrs) {
> > > +		*pkrs = new_pkrs;
> > > +		wrmsrl(MSR_IA32_PKRS, new_pkrs);
> > > +	}
> > > +	put_cpu_ptr(pkrs);
> > > +}
> > > 
> > 
> > It bugs me a *bit* that this is being called in a preempt-disabled
> > region, but we still bother with the get/put_cpu jazz.  Are there other
> > future call-sites for this that aren't in preempt-disabled regions?
> 
> So the previous version had a useful comment that got lost.

Ok Looking back I see what happened...  This comment...

 /*
  * PKRS is only temporarily changed during specific code paths.
  * Only a preemption during these windows away from the default
  * value would require updating the MSR.
  */

... was added to pks_sched_in() but that got simplified down because cleaning
up write_pkrs() made the code there obsolete.

> This stuff
> needs to fundamentally be preempt disabled,

I agree, the update to the percpu cache value and MSR can not be torn.

> so it either needs to
> explicitly do so, or have an assertion that preemption is indeed
> disabled.

However, I don't think I understand clearly.  Doesn't [get|put]_cpu_ptr()
handle the preempt_disable() for us?  Is it not sufficient to rely on that?

Dave's comment seems to be the opposite where we need to eliminate preempt
disable before calling write_pkrs().

FWIW I think I'm mistaken in my response to Dave regarding the
preempt_disable() in pks_update_protection().

Ira
