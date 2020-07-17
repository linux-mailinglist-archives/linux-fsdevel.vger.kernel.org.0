Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB992245EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 23:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGQVjd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 17:39:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:24888 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgGQVjb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:39:31 -0400
IronPort-SDR: aBZHDjghD0crMd+R/XDYtcqWhPJ5nLUfrgPhoHmUF6bdbc8D8ucG/UNxn1ggygKf0OWYn6BtiC
 YUpWjjmzkOdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="234532583"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="234532583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 14:39:30 -0700
IronPort-SDR: AU7pg9gP52qGosMkjj44f+xwiuRZBXuNXBPORBl/nIscyOnQkujZOX7iJDcTIOdgYz9TXvt9wD
 p6bhZiX9j/bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="460984872"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 14:39:30 -0700
Date:   Fri, 17 Jul 2020 14:39:30 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 04/17] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200717213929.GR3008823@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-5-ira.weiny@intel.com>
 <20200717083140.GW10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717083140.GW10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:31:40AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:43AM -0700, ira.weiny@intel.com wrote:
> 
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index f362ce0d5ac0..d69250a7c1bf 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -42,6 +42,7 @@
> >  #include <asm/spec-ctrl.h>
> >  #include <asm/io_bitmap.h>
> >  #include <asm/proto.h>
> > +#include <asm/pkeys_internal.h>
> >  
> >  #include "process.h"
> >  
> > @@ -184,6 +185,36 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
> >  	return ret;
> >  }
> >  
> > +/*
> > + * NOTE: We wrap pks_init_task() and pks_sched_in() with
> > + * CONFIG_ARCH_HAS_SUPERVISOR_PKEYS because using IS_ENABLED() fails
> > + * due to the lack of task_struct->saved_pkrs in this configuration.
> > + * Furthermore, we place them here because of the complexity introduced by
> > + * header conflicts introduced to get the task_struct definition in the pkeys
> > + * headers.
> > + */
> 
> I don't see anything much useful in that comment.

I'm happy to delete.  Internal reviews questioned the motive here so I added
the comment to inform why this style was chosen rather than the preferred
IS_ENABLED().

I've deleted it now.

> 
> > +#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > +DECLARE_PER_CPU(u32, pkrs_cache);
> > +static inline void pks_init_task(struct task_struct *tsk)
> > +{
> > +	/* New tasks get the most restrictive PKRS value */
> > +	tsk->thread.saved_pkrs = INIT_PKRS_VALUE;
> > +}
> > +static inline void pks_sched_in(void)
> > +{
> > +	u64 current_pkrs = current->thread.saved_pkrs;
> > +
> > +	/* Only update the MSR when current's pkrs is different from the MSR. */
> > +	if (this_cpu_read(pkrs_cache) == current_pkrs)
> > +		return;
> > +
> > +	write_pkrs(current_pkrs);
> 
> Should we write that like:
> 
> 	/*
> 	 * PKRS is only temporarily changed during specific code paths.
> 	 * Only a preemption during these windows away from the default
> 	 * value would require updating the MSR.
> 	 */
> 	if (unlikely(this_cpu_read(pkrs_cache) != current_pkrs))
> 		write_pkrs(current_pkrs);
> 
> ?

Yes I think the unlikely is better.

Thanks,
Ira

> 
> > +}
> > +#else
> > +static inline void pks_init_task(struct task_struct *tsk) { }
> > +static inline void pks_sched_in(void) { }
> > +#endif
