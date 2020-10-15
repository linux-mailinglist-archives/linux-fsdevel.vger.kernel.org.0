Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBCC28EBBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 05:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgJODqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 23:46:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:19759 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbgJODqq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:46:46 -0400
IronPort-SDR: oqXXNKu6P/DWlqnbFJQN/3W5BEe+cUTAQc62mFUJ4eOu11uxTB1rGIl7Nz3Skg62oOoQYh9E4R
 hSPkgNwu9Mhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="166313689"
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="166313689"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 20:46:45 -0700
IronPort-SDR: frVKPMJAzb1m9jivZ/XfXNx7VCqDkNNADy0hOKKQpIfrYnJ8mOjxbWGy/FPBq9IrrLYbuNMuZF
 XeLLSEBZdFVw==
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="531094057"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 20:46:45 -0700
Date:   Wed, 14 Oct 2020 20:46:45 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 7/9] x86/entry: Preserve PKRS MSR across exceptions
Message-ID: <20201015034645.GQ2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-8-ira.weiny@intel.com>
 <6006a4c8-32bd-04ca-95cc-b2736a5cef72@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6006a4c8-32bd-04ca-95cc-b2736a5cef72@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 11:52:32AM -0700, Dave Hansen wrote:
> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> > @@ -341,6 +341,9 @@ noinstr void irqentry_enter(struct pt_regs *regs, irqentry_state_t *state)
> >  	/* Use the combo lockdep/tracing function */
> >  	trace_hardirqs_off();
> >  	instrumentation_end();
> > +
> > +done:
> > +	irq_save_pkrs(state);
> >  }
> 
> One nit: This saves *and* sets PKRS.  It's not obvious from the call
> here that PKRS is altered at this site.  Seems like there could be a
> better name.
> 
> Even if we did:
> 
> 	irq_save_set_pkrs(state, INIT_VAL);
> 
> It would probably compile down to the same thing, but be *really*
> obvious what's going on.

I suppose that is true.  But I think it is odd having a parameter which is the
same for every call site.

But I'm not going to quibble over something like this.

Changed,
Ira

> 
> >  void irqentry_exit_cond_resched(void)
> > @@ -362,7 +365,12 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t *state)
> >  	/* Check whether this returns to user mode */
> >  	if (user_mode(regs)) {
> >  		irqentry_exit_to_user_mode(regs);
> > -	} else if (!regs_irqs_disabled(regs)) {
> > +		return;
> > +	}
> > +
> > +	irq_restore_pkrs(state);
> > +
> > +	if (!regs_irqs_disabled(regs)) {
> >  		/*
> >  		 * If RCU was not watching on entry this needs to be done
> >  		 * carefully and needs the same ordering of lockdep/tracing
> > 
> 
