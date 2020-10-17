Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8FF290F6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Oct 2020 07:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411842AbgJQFhf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Oct 2020 01:37:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:54619 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411565AbgJQFhf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:37:35 -0400
IronPort-SDR: d+auaUoau+kMHS4utnqPjz5oDbG6bGQh5OZbCpOsUol+jk14KPSllLMAZPuJUuChmYgqzV7stV
 EPPeHvKaAGog==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="166820635"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="166820635"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:37:34 -0700
IronPort-SDR: Ty1fM6Vbx2+YqgAFSfiZo7vOUTz9OdV+8hAXKYG3AIQEYKvwVWfnceXqF2oJSEM79KD2hC0opy
 pucoh92Qu6uQ==
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="531984870"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:37:33 -0700
Date:   Fri, 16 Oct 2020 22:37:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20201017053733.GA3702775@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
 <20201016110636.GL2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016110636.GL2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 01:06:36PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 12:42:53PM -0700, ira.weiny@intel.com wrote:
> 
> > @@ -644,6 +663,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
> >  
> >  	if ((tifp ^ tifn) & _TIF_SLD)
> >  		switch_to_sld(tifn);
> > +
> > +	pks_sched_in();
> >  }
> >  
> 
> You seem to have lost the comment proposed here:
> 
>   https://lkml.kernel.org/r/20200717083140.GW10769@hirez.programming.kicks-ass.net
> 
> It is useful and important information that the wrmsr normally doesn't
> happen.

Added back in here.

> 
> > diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> > index 3cf8f775f36d..30f65dd3d0c5 100644
> > --- a/arch/x86/mm/pkeys.c
> > +++ b/arch/x86/mm/pkeys.c
> > @@ -229,3 +229,31 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
> >  
> >  	return pk_reg;
> >  }
> > +
> > +DEFINE_PER_CPU(u32, pkrs_cache);
> > +
> > +/**
> > + * It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
> > + * serializing but still maintains ordering properties similar to WRPKRU.
> > + * The current SDM section on PKRS needs updating but should be the same as
> > + * that of WRPKRU.  So to quote from the WRPKRU text:
> > + *
> > + * 	WRPKRU will never execute transiently. Memory accesses
> > + * 	affected by PKRU register will not execute (even transiently)
> > + * 	until all prior executions of WRPKRU have completed execution
> > + * 	and updated the PKRU register.
> 
> (whitespace damage; space followed by tabstop)

Fixed thanks.

> 
> > + */
> > +void write_pkrs(u32 new_pkrs)
> > +{
> > +	u32 *pkrs;
> > +
> > +	if (!static_cpu_has(X86_FEATURE_PKS))
> > +		return;
> > +
> > +	pkrs = get_cpu_ptr(&pkrs_cache);
> > +	if (*pkrs != new_pkrs) {
> > +		*pkrs = new_pkrs;
> > +		wrmsrl(MSR_IA32_PKRS, new_pkrs);
> > +	}
> > +	put_cpu_ptr(pkrs);
> > +}
> 
> looks familiar that... :-)

Added you as a co-developer if that is ok?

Ira
