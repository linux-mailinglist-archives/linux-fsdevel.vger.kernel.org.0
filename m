Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3AC22B34C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 18:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgGWQSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 12:18:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:46002 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbgGWQSU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:18:20 -0400
IronPort-SDR: xww9ynMAf3BamWKdU3NyMnmvhx8fzAN9TxPj51rveMlJmASpjp2Ekd91+fT/OYJWKbFbAylzyq
 5KHCeG7QPEbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="215169773"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="215169773"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 09:18:19 -0700
IronPort-SDR: kf2KWN7WI2p4vd74GFsxQMiXONFSvdTEj6bfjU/HaqJRxh3PGZm95T03EkTMNRYV+oRWiqE8bl
 Q0ShhWAOk+TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="311087983"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 09:18:18 -0700
Date:   Thu, 23 Jul 2020 09:18:18 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Weiny Ira <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200723161818.GA77434@romley-ivt3.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 09:21:43AM -0700, Andy Lutomirski wrote:
> On Fri, Jul 17, 2020 at 12:21 AM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > The PKRS MSR is not managed by XSAVE.  It is already preserved through a
> > context switch but this support leaves exception handling code open to
> > memory accesses which the interrupted process has allowed.
> >
> > Close this hole by preserve the current task's PKRS MSR, reset the PKRS
> > MSR value on exception entry, and then restore the state on exception
> > exit.
> 
> Should this live in pt_regs?

The PKRS MSR has been preserved in thread_info during kernel entry. We
don't need to preserve it in another place (i.e. idtentry_state).

To avoid confusion, I think we need to change the above commit message to:

"Exception handling code is open to memory accesses which the interrupted
process has allowed.

Close this hole by reset the PKRS MSR value on exception entry and restore
the state on exception exit. The MSR was preserved in thread_info."

The patch needs to be changed accordingly, I think:

1. No need to define "pks" in struct idtentry_state because the MSR is
   already preserved in thread_info.
2. idt_save_pkrs() could be renamed as idt_reset_pkrs() to reset
   the MSR (no need to save it). "state.pkrs" can be replaced by
   "current->thread_info.pkrs" now.
3. The "pkrs_ref" could be defined in thread_info as well. But I'm not
   sure if it's better than defined in idtentry_state.

Thanks.

-Fenghua
