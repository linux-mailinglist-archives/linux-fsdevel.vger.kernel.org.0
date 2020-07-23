Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38FA22B3F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgGWQwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 12:52:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:61707 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQwG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:52:06 -0400
IronPort-SDR: eCpyblb3JAmn3MY34CfejmwRB9+PzBIrn8b1CDJcbBYQD0+8KJyFZZooXQG75tywt3x9pNah9e
 nHh2xletJfIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="149757227"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="149757227"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 09:52:05 -0700
IronPort-SDR: mAmrUitOfiAg5CS/tsz6tCarSLviqTRzcFRleZL+GG/v8x+OPGmFN8FiKB+3GU/TO5dndgquAI
 CuGW8cd61NtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="311100155"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 09:52:05 -0700
Date:   Thu, 23 Jul 2020 09:52:04 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Weiny Ira <ira.weiny@intel.com>,
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
Message-ID: <20200723165204.GB77434@romley-ivt3.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com>
 <20200723161818.GA77434@romley-ivt3.sc.intel.com>
 <1cdb358b-861a-5f74-8cd0-84ee5265035c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cdb358b-861a-5f74-8cd0-84ee5265035c@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Dave,

On Thu, Jul 23, 2020 at 09:23:13AM -0700, Dave Hansen wrote:
> On 7/23/20 9:18 AM, Fenghua Yu wrote:
> > The PKRS MSR has been preserved in thread_info during kernel entry. We
> > don't need to preserve it in another place (i.e. idtentry_state).
> 
> I'm missing how the PKRS MSR gets preserved in thread_info.  Could you
> explain the mechanism by which this happens and point to the code
> implementing it, please?

[Sorry, my mistake: I mean "thread_struct" instead of "thread_info".
Hopefully the typo doesn't change the essential part in my last email.]

The "saved_pkrs" is defined in thread_struct and context switched in
patch 04/17:
https://lore.kernel.org/lkml/20200717072056.73134-5-ira.weiny@intel.com/

Because there is no XSAVE support the PKRS MSR, we preserve it in
"saved_pkrs" in thread_struct. It's initialized as 0 (init state, no
protection key) in fork() or exec(). It's updated to a right protection
value when a driver calls the updating API. The PKRS MSR is context
switched by "saved_pkrs" when switching to a task (unless optimized if the
cached MSR is the same as the saved one).

Thanks.

-Fenghua
