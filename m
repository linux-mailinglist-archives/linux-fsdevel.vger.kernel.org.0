Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89CC2287E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 20:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgGUSBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 14:01:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:38274 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgGUSBk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 14:01:40 -0400
IronPort-SDR: Mt9Ob7Eu820fSF1U5wsrv/CMNDOzfKJNHwTePWqjlfxtZViSdVqLPrtwOoAWVWmEywQZ8qTsMa
 KZ/qTC+eq3fQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="149364673"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="149364673"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 11:01:39 -0700
IronPort-SDR: qe5k1fK528+7itSbwwwS6IKZcJvdlZH1lFT8UQ253GQI2FZOjz37hTraZvX/V9KC4se8G7enQF
 XJPuNvtJfimA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="362445458"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2020 11:01:35 -0700
Date:   Tue, 21 Jul 2020 11:01:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20200721180134.GB643353@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <20200717093041.GF10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717093041.GF10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 11:30:41AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
> > +static void noinstr idt_save_pkrs(idtentry_state_t state)
> 
> noinstr goes in the same place you would normally put inline, that's
> before the return type, not after it.
>

Sorry about that.  But that does not look to be consistent.

10:57:35 > git grep 'noinstr' arch/x86/entry/common.c
...
arch/x86/entry/common.c:idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
arch/x86/entry/common.c:void noinstr idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
arch/x86/entry/common.c:void noinstr idtentry_enter_user(struct pt_regs *regs)
arch/x86/entry/common.c:void noinstr idtentry_exit_user(struct pt_regs *regs)
...

Are the above 'wrong'?  Is it worth me sending a patch?

I've changed my code,
Ira
