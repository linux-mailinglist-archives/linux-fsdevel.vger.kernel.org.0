Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B23292F5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 22:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbgJSU04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 16:26:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:57322 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgJSU04 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:26:56 -0400
IronPort-SDR: 8TFm2G0Ct4qS09L9pbh7G//3KgY/jYdOCwEH5HG2ej1epMPPhCRp2WMBRNHRaYMEzBEWsqV57U
 xHTqT82olcnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="154886284"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="154886284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 13:26:48 -0700
IronPort-SDR: SgB75YQa+F2iajmvUwI65OmEVIx+I01kcvx0mKBDuURPbpXUjIoi32NAdRXxv8Fn4Nuvmc21LQ
 OPUZr38TIc1g==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="523235144"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 13:26:48 -0700
Date:   Mon, 19 Oct 2020 13:26:47 -0700
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
Message-ID: <20201019202647.GD3713473@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-7-ira.weiny@intel.com>
 <20201016114510.GO2611@hirez.programming.kicks-ass.net>
 <87lfg6tjnq.fsf@nanos.tec.linutronix.de>
 <20201019053639.GA3713473@iweiny-DESK2.sc.intel.com>
 <87k0vma7ct.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0vma7ct.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:32:50AM +0200, Thomas Gleixner wrote:
> On Sun, Oct 18 2020 at 22:37, Ira Weiny wrote:
> > On Fri, Oct 16, 2020 at 02:55:21PM +0200, Thomas Gleixner wrote:
> >> Subject: x86/entry: Move nmi entry/exit into common code
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> Date: Fri, 11 Sep 2020 10:09:56 +0200
> >> 
> >> Add blurb here.
> >
> > How about:
> >
> > To prepare for saving PKRS values across NMI's we lift the
> > idtentry_[enter|exit]_nmi() to the common code.  Rename them to
> > irqentry_nmi_[enter|exit]() to reflect the new generic nature and store the
> > state in the same irqentry_state_t structure as the other irqentry_*()
> > functions.  Finally, differentiate the state being stored between the NMI and
> > IRQ path by adding 'lockdep' to irqentry_state_t.
> 
> No. This has absolutely nothing to do with PKRS. It's a cleanup valuable
> by itself and that's how it should have been done right away.
> 
> So the proper changelog is:
> 
>   Lockdep state handling on NMI enter and exit is nothing specific to
>   X86. It's not any different on other architectures. Also the extra
>   state type is not necessary, irqentry_state_t can carry the necessary
>   information as well.
> 
>   Move it to common code and extend irqentry_state_t to carry lockdep
>   state.

Ok sounds good, thanks.

> 
> >> --- a/include/linux/entry-common.h
> >> +++ b/include/linux/entry-common.h
> >> @@ -343,6 +343,7 @@ void irqentry_exit_to_user_mode(struct p
> >>  #ifndef irqentry_state
> >>  typedef struct irqentry_state {
> >>  	bool	exit_rcu;
> >> +	bool	lockdep;
> >>  } irqentry_state_t;
> >
> > Building on what Peter said do you agree this should be made into a union?
> >
> > It may not be strictly necessary in this patch but I think it would reflect the
> > mutual exclusivity better and could be changed easy enough in the follow on
> > patch which adds the pkrs state.
> 
> Why the heck should it be changed in a patch which adds something
> completely different?

Because the PKRS stuff is used in both NMI and IRQ state.

> 
> Either it's mutually exclusive or not and if so it want's to be done in
> this patch and not in a change which extends the struct for other
> reasons.

Sorry, let me clarify.  After this patch we have.

typedef union irqentry_state {
	bool	exit_rcu;
	bool	lockdep;
} irqentry_state_t;

Which reflects the mutual exclusion of the 2 variables.

But then when the pkrs stuff is added the union changes back to a structure and
looks like this.

typedef struct irqentry_state {
#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
        u32 pkrs;
        u32 thread_pkrs;
#endif  
	union {
		bool    exit_rcu;
		bool	lockdep;
	};
} irqentry_state_t;

Because the pkrs information is in addition to exit_rcu OR lockdep.

So this is what I meant by 'could be changed easy enough in the follow on
patch'.

Is that clear?

Ira
