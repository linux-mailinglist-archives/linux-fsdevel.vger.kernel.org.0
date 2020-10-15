Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB528EC01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 06:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgJOESK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 00:18:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:44018 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgJOESK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 00:18:10 -0400
IronPort-SDR: AD5fzz89jB62x5ocJkZoD8dYWhzJvyNE1u1q1TlVOet6L34xBR36bCUv79JYU682zC/lJf8m2I
 4gEUmP1vHd0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="145561348"
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="145561348"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:18:09 -0700
IronPort-SDR: v7spRh8MuASRkdNNr0ZHoNczdFMxX2I1ak7xY7gos/SeU28ARiQ6EMmXTm9vqvcAGZ60oslnd3
 9cmkDq9PvUXw==
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="531100241"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:18:08 -0700
Date:   Wed, 14 Oct 2020 21:18:08 -0700
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
Message-ID: <20201015041808.GS2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-8-ira.weiny@intel.com>
 <6006a4c8-32bd-04ca-95cc-b2736a5cef72@intel.com>
 <20201015034645.GQ2046448@iweiny-DESK2.sc.intel.com>
 <a3cb045e-3d27-eaca-c78d-d30d9a045e02@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3cb045e-3d27-eaca-c78d-d30d9a045e02@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:06:44PM -0700, Dave Hansen wrote:
> On 10/14/20 8:46 PM, Ira Weiny wrote:
> > On Tue, Oct 13, 2020 at 11:52:32AM -0700, Dave Hansen wrote:
> >> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> >>> @@ -341,6 +341,9 @@ noinstr void irqentry_enter(struct pt_regs *regs, irqentry_state_t *state)
> >>>  	/* Use the combo lockdep/tracing function */
> >>>  	trace_hardirqs_off();
> >>>  	instrumentation_end();
> >>> +
> >>> +done:
> >>> +	irq_save_pkrs(state);
> >>>  }
> >> One nit: This saves *and* sets PKRS.  It's not obvious from the call
> >> here that PKRS is altered at this site.  Seems like there could be a
> >> better name.
> >>
> >> Even if we did:
> >>
> >> 	irq_save_set_pkrs(state, INIT_VAL);
> >>
> >> It would probably compile down to the same thing, but be *really*
> >> obvious what's going on.
> > I suppose that is true.  But I think it is odd having a parameter which is the
> > same for every call site.
> 
> Well, it depends on what you optimize for.  I'm trying to optimize for
> the code being understood quickly the first time someone reads it.  To
> me, that's more important than minimizing the number of function
> parameters (which are essentially free).
>

Agreed.  Sorry I was not trying to be confrontational.  There is just enough
other things which are going to take me time to get right I need to focus on
them...  :-D

Sorry,
Ira
