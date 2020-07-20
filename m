Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC14226E62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgGTSfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 14:35:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:45970 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgGTSfQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:35:16 -0400
IronPort-SDR: wrdPvR2QQD5zVs+dlH2xBbA0Vt5zMGyPslee2clS8w7ZNH5VY12LfsWELbf08p7253hzgYUI2B
 Mrr5waAIgsXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="168130225"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="168130225"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 11:35:16 -0700
IronPort-SDR: wK7wo3tDMannoMaWGv9oSkwguhLqP6DavKpuU2XXsLRCL8yJhaDeTIBrq75zM686eRl+HmbVUR
 EPP//W3JMNMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="309946010"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2020 11:35:16 -0700
Date:   Mon, 20 Jul 2020 11:35:16 -0700
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
Subject: Re: [PATCH RFC V2 04/17] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200720183515.GF478573@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-5-ira.weiny@intel.com>
 <20200717085954.GY10769@hirez.programming.kicks-ass.net>
 <20200717223407.GS3008823@iweiny-DESK2.sc.intel.com>
 <20200720091554.GN10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720091554.GN10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 11:15:54AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 03:34:07PM -0700, Ira Weiny wrote:
> > On Fri, Jul 17, 2020 at 10:59:54AM +0200, Peter Zijlstra wrote:
> > > On Fri, Jul 17, 2020 at 12:20:43AM -0700, ira.weiny@intel.com wrote:
> > > > +/*
> > > > + * Write the PKey Register Supervisor.  This must be run with preemption
> > > > + * disabled as it does not guarantee the atomicity of updating the pkrs_cache
> > > > + * and MSR on its own.
> > > > + */
> > > > +void write_pkrs(u32 pkrs_val)
> > > > +{
> > > > +	this_cpu_write(pkrs_cache, pkrs_val);
> > > > +	wrmsrl(MSR_IA32_PKRS, pkrs_val);
> > > > +}
> > > 
> > > Should we write that like:
> > > 
> > > void write_pkrs(u32 pkr)
> > > {
> > > 	u32 *pkrs = get_cpu_ptr(pkrs_cache);
> > > 	if (*pkrs != pkr) {
> > > 		*pkrs = pkr;
> > > 		wrmsrl(MSR_IA32_PKRS, pkr);
> > > 	}
> > > 	put_cpu_ptrpkrs_cache);
> > > }
> > > 
> > > given that we fundamentally need to serialize againt schedule() here.
> > 
> > Yes.  That seems better.
> > 
> > That also means pks_sched_in() can be simplified to just
> > 
> > static inline void pks_sched_in(void)
> > {
> > 	write_pkrs(current->thread.saved_pkrs);
> > }
> > 
> > Because of the built WRMSR avoidance.
> > 
> > However, pkrs_cache is static so I think I need to use {get,put}_cpu_var() here
> > don't I?
> 
> Or get_cpu_ptr(&pkrs_cache), sorry for the typo :-)

Ah I see...  sorry, yes that will work.

Done,
Ira
