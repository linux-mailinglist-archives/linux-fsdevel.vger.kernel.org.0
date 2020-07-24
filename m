Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5694F22CECD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgGXTn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 15:43:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:28554 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgGXTn5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:43:57 -0400
IronPort-SDR: EfyhiW3llWlszXI3GBFqhly+qsP2rPDJX12B1ZCW1e0fDLHBKP+784TFknVpFI6TXo/vf9mqp7
 UoYWvt582+sA==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="138282996"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="138282996"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 12:43:56 -0700
IronPort-SDR: xw35vgWVMvuh2FxBDPdLOZ98hPNSo7kyjZ00bcaGwKX/k2DG8gIcu2MZetY8wt/D3BJ5XnscaB
 FrmYkinokGDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="272667289"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2020 12:43:56 -0700
Date:   Fri, 24 Jul 2020 12:43:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20200724194355.GA844234@iweiny-DESK2.sc.intel.com>
References: <20200724172344.GO844235@iweiny-DESK2.sc.intel.com>
 <D866BD75-42A2-43B2-B07A-55BCC3781FEC@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D866BD75-42A2-43B2-B07A-55BCC3781FEC@amacapital.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 10:29:23AM -0700, Andy Lutomirski wrote:
> 
> > On Jul 24, 2020, at 10:23 AM, Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> > ﻿On Thu, Jul 23, 2020 at 10:15:17PM +0200, Thomas Gleixner wrote:
> >> Thomas Gleixner <tglx@linutronix.de> writes:
> >> 
> >>> Ira Weiny <ira.weiny@intel.com> writes:
> >>>> On Fri, Jul 17, 2020 at 12:06:10PM +0200, Peter Zijlstra wrote:
> >>>>>> On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
> >>>>> I've been really digging into this today and I'm very concerned that I'm
> >>>>> completely missing something WRT idtentry_enter() and idtentry_exit().
> >>>>> 
> >>>>> I've instrumented idt_{save,restore}_pkrs(), and __dev_access_{en,dis}able()
> >>>>> with trace_printk()'s.
> >>>>> 
> >>>>> With this debug code, I have found an instance where it seems like
> >>>>> idtentry_enter() is called without a corresponding idtentry_exit().  This has
> >>>>> left the thread ref counter at 0 which results in very bad things happening
> >>>>> when __dev_access_disable() is called and the ref count goes negative.
> >>>>> 
> >>>>> Effectively this seems to be happening:
> >>>>> 
> >>>>> ...
> >>>>>    // ref == 0
> >>>>>    dev_access_enable()  // ref += 1 ==> disable protection
> >>>>>        // exception  (which one I don't know)
> >>>>>            idtentry_enter()
> >>>>>                // ref = 0
> >>>>>                _handler() // or whatever code...
> >>>>>            // *_exit() not called [at least there is no trace_printk() output]...
> >>>>>            // Regardless of trace output, the ref is left at 0
> >>>>>    dev_access_disable() // ref -= 1 ==> -1 ==> does not enable protection
> >>>>>    (Bad stuff is bound to happen now...)
> >>> 
> >>> Well, if any exception which calls idtentry_enter() would return without
> >>> going through idtentry_exit() then lots of bad stuff would happen even
> >>> without your patches.
> >>> 
> >>>> Also is there any chance that the process could be getting scheduled and that
> >>>> is causing an issue?
> >>> 
> >>> Only from #PF, but after the fault has been resolved and the tasks is
> >>> scheduled in again then the task returns through idtentry_exit() to the
> >>> place where it took the fault. That's not guaranteed to be on the same
> >>> CPU. If schedule is not aware of the fact that the exception turned off
> >>> stuff then you surely get into trouble. So you really want to store it
> >>> in the task itself then the context switch code can actually see the
> >>> state and act accordingly.
> >> 
> >> Actually thats nasty as well as you need a stack of PKRS values to
> >> handle nested exceptions. But it might be still the most reasonable
> >> thing to do. 7 PKRS values plus an index should be really sufficient,
> >> that's 32bytes total, not that bad.
> > 
> > I've thought about this a bit more and unless I'm wrong I think the
> > idtentry_state provides for that because each nested exception has it's own
> > idtentry_state doesn't it?
> 
> Only the ones that use idtentry_enter() instead of, say, nmi_enter().

Oh agreed...

But with this patch we are still better off than just preserving during context
switch.

I need to update the commit message here to make this clear though.

Thanks,
Ira
