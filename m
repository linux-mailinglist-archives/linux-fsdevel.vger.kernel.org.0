Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8188829223D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 07:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgJSFhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 01:37:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:36748 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgJSFhv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 01:37:51 -0400
IronPort-SDR: BCttGlvxXOv8IEMavzW7QCZDOzs1MO3AV/WwrIlbEaiYnCGxWVJREPVdnNqGF0ZSMH0+EnvcXG
 K6A+Vch2xQIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="231162684"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="231162684"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 22:37:46 -0700
IronPort-SDR: RnOUFQmkYUDicpOlOT0tpOrIh/gyVBYXkd84kJDS4ikMZgrYuGPAp0+a9qjCzEuNsRXlsKxGfm
 7ykQey1Ml/Rw==
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="532493630"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 22:37:37 -0700
Date:   Sun, 18 Oct 2020 22:37:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 6/9] x86/entry: Pass irqentry_state_t by reference
Message-ID: <20201019053639.GA3713473@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-7-ira.weiny@intel.com>
 <20201016114510.GO2611@hirez.programming.kicks-ass.net>
 <87lfg6tjnq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfg6tjnq.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 02:55:21PM +0200, Thomas Gleixner wrote:
> On Fri, Oct 16 2020 at 13:45, Peter Zijlstra wrote:
> > On Fri, Oct 09, 2020 at 12:42:55PM -0700, ira.weiny@intel.com wrote:
> >> @@ -238,7 +236,7 @@ noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
> >>  
> >>  	rcu_nmi_exit();
> >>  	lockdep_hardirq_exit();
> >> -	if (restore)
> >> +	if (irq_state->exit_rcu)
> >>  		lockdep_hardirqs_on(CALLER_ADDR0);
> >>  	__nmi_exit();
> >>  }
> >
> > That's not nice.. The NMI path is different from the IRQ path and has a
> > different variable. Yes, this works, but *groan*.
> >
> > Maybe union them if you want to avoid bloating the structure, but the
> > above makes it really hard to read.
> 
> Right, and also that nmi entry thing should not be in x86. Something
> like the untested below as first cleanup.

Ok, I see what Peter was talking about.  I've added this patch to the series.

> 
> Thanks,
> 
>         tglx
> ----
> Subject: x86/entry: Move nmi entry/exit into common code
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Fri, 11 Sep 2020 10:09:56 +0200
> 
> Add blurb here.

How about:

To prepare for saving PKRS values across NMI's we lift the
idtentry_[enter|exit]_nmi() to the common code.  Rename them to
irqentry_nmi_[enter|exit]() to reflect the new generic nature and store the
state in the same irqentry_state_t structure as the other irqentry_*()
functions.  Finally, differentiate the state being stored between the NMI and
IRQ path by adding 'lockdep' to irqentry_state_t.

?

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/entry/common.c         |   34 ----------------------------------
>  arch/x86/include/asm/idtentry.h |    3 ---
>  arch/x86/kernel/cpu/mce/core.c  |    6 +++---
>  arch/x86/kernel/nmi.c           |    6 +++---
>  arch/x86/kernel/traps.c         |   13 +++++++------
>  include/linux/entry-common.h    |   20 ++++++++++++++++++++
>  kernel/entry/common.c           |   36 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 69 insertions(+), 49 deletions(-)
> 

[snip]

> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -343,6 +343,7 @@ void irqentry_exit_to_user_mode(struct p
>  #ifndef irqentry_state
>  typedef struct irqentry_state {
>  	bool	exit_rcu;
> +	bool	lockdep;
>  } irqentry_state_t;

Building on what Peter said do you agree this should be made into a union?

It may not be strictly necessary in this patch but I think it would reflect the
mutual exclusivity better and could be changed easy enough in the follow on
patch which adds the pkrs state.

Ira
