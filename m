Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B312921FA89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgGNSx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 14:53:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:43539 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730626AbgGNSxY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:53:24 -0400
IronPort-SDR: 1fV2sjGxhfIIrmYdRIGsuPzZPRGWZ8Q7/l9/XE9GhF22y4AbDkhq/zODkTmJnsLY8r8J+dCiYr
 7M4lYHM7d5Mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="148142821"
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="148142821"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 11:53:23 -0700
IronPort-SDR: K8KPclbMvzgCpNFSFhz9Nn0YwCcdCbQhJi73NeRnxAdxCClsbyjKHY02fk6MDlf/UteP15gYg8
 6LDggwpzlYUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,352,1589266800"; 
   d="scan'208";a="307978346"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2020 11:53:23 -0700
Date:   Tue, 14 Jul 2020 11:53:22 -0700
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
Subject: Re: [RFC PATCH 04/15] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200714185322.GB3008823@iweiny-DESK2.sc.intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-5-ira.weiny@intel.com>
 <20200714082701.GO10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714082701.GO10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:27:01AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 14, 2020 at 12:02:09AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The PKRS MSR is defined as a per-core register.  This isolates memory
> > access by CPU.  Unfortunately, the MSR is not preserved by XSAVE.
> > Therefore, We must preserve the protections for individual tasks even if
> > they are context switched out and placed on another cpu later.
> 
> This is a contradiction and utter trainwreck.

I don't understand where there is a contradiction?  Perhaps I should have said
the MSR is not XSAVE managed vs 'preserved'?

> We're not going to do more
> per-core MSRs and pretend they make sense per-task.

I don't understand how this does not make sense.  The PKRS register is
controlling the task's access to kernel memory and is designed to be restricted
to that task.  Put another way, this is similar to CR3 which ultimately
controls tasks memory access.  Per-process mm is inherent to memory access
control and is per-task.  So how is this any different?  Many MSRs are like
this.

I suppose an alternative might be to disallow a context switch while the PKRS
value is not the default but I don't see this being very desirable at all.

Ira
