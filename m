Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BA22FAD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 22:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgG0U7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 16:59:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:50925 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0U7L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:59:11 -0400
IronPort-SDR: McrCKUqe+uaAfMZEA7ugCeCtRsJYkFtgka8tdgvu1ynZ1o5URYJ9qMHrNU2w488P8YStwujOuV
 KcNuayNZvAmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="152368198"
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; 
   d="scan'208";a="152368198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 13:59:10 -0700
IronPort-SDR: F6x4TaH2xUbkqcHOlkYVCRLa84X160LomB+gQPSLrqqclZ5rkG41zSJgbumVGi5uDGCsUe7wk1
 4OgHP9BbFWkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,403,1589266800"; 
   d="scan'208";a="320157680"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2020 13:59:10 -0700
Date:   Mon, 27 Jul 2020 13:59:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200727205909.GP844235@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <87r1t2vwi7.fsf@nanos.tec.linutronix.de>
 <20200723220435.GI844235@iweiny-DESK2.sc.intel.com>
 <87mu3pvly7.fsf@nanos.tec.linutronix.de>
 <874kpwtxlh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kpwtxlh.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:24:58PM +0200, Thomas Gleixner wrote:
> Ira,
> 
> Thomas Gleixner <tglx@linutronix.de> writes:
> > Ira Weiny <ira.weiny@intel.com> writes:
> >> On Thu, Jul 23, 2020 at 09:53:20PM +0200, Thomas Gleixner wrote:
> >> I think, after fixing my code (see below), using idtentry_state could still
> >> work.  If the per-cpu cache and the MSR is updated in idtentry_exit() that
> >> should carry the state to the new cpu, correct?
> >
> > I'm way too tired to think about that now. Will have a look tomorrow
> > with brain awake.
> 
> Not that I'm way more awake now, but at least I have the feeling that my
> brain is not completely useless.
> 
> Let me summarize what I understood:
> 
>   1) A per CPU cache which shadows the current state of the MSR, i.e. the
>      current valid key. You use that to avoid costly MSR writes if the
>      key does not change.

Yes

> 
>   2) On idtentry you store the key on entry in idtentry_state, clear it
>      in the MSR and shadow state if necessary and restore it on exit.

Yes, but I've subsequently found a bug here but yea that was the intention.
:-D

I also maintain the ref count of the number of nested calls to kmap to ensure
that kmap_atomic() is nestable during an exception independent of the number
of nested calls of the interrupted thread.

>   3) On context switch out you save the per CPU cache value in the task
>      and on context switch in you restore it from there.

yes

> 
> Yes, that works (see below for #2) and sorry for my confusion yesterday
> about storing this in task state.

No problem.

> 
> #2 requires to handle the exceptions which do not go through
> idtentry_enter/exit() seperately, but that's a manageable amount. It's
> the ones which use IDTENTRY_RAW or a variant of it.
> 
> #BP, #MC, #NMI, #DB, #DF need extra local storage as all the kernel
> entries for those use nmi_enter()/exit(). So you just can create
> wrappers around those. Somehting like this
> 
> static __always_inline idtentry_state_t idtentry_nmi_enter(void)
> {
>      	idtentry_state_t state = {};
> 
>         nmi_enter();
>         instrumentation_begin();
>         state.key = save_and_clear_key();
>         instrumentation_end();
> }
> 
> static __always_inline void idtentry_nmi_exit(idtentry_state_t state)
> {
>         instrumentation_begin();
>         restore_key(state.key);
>         instrumentation_end();
>         nmi_exit();
> }
> 

Thanks!

> #UD and #PF are using the raw entry variant as well but still invoke
> idtentry_enter()/exit(). #PF does not need any work. #UD handles
> WARN/BUG without going through idtentry_enter() first, but I don't think
> that's an issue unless a not 0 key would prevent writing to the console
> device. You surely can figure that out.
> 
> Hope that helps.

Yes it does thank you.  I'm also trying to simplify the API per Peters
comments while refactoring this.

Ira

