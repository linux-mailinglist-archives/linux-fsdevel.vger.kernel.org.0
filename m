Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB8224659
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 00:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgGQWeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 18:34:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:49086 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgGQWeI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:34:08 -0400
IronPort-SDR: N6PXGVbL9Nm2n2WT61S7xBMhTrgGfpDFQkgzxM/PbjIuza0WdXZzdOFALg9UycVlTls8FvJzNS
 p+aos1ATWC5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="151049456"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="151049456"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 15:34:08 -0700
IronPort-SDR: kthQsGLObtwSWoOzzNwTRSgtMFbfQX/Q/Mq09Zc/Drf8BGiuQ5/EGHNB8Hy/cRd2302wOqsyVi
 VatOSgUZMZjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="487118249"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2020 15:34:07 -0700
Date:   Fri, 17 Jul 2020 15:34:07 -0700
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
Message-ID: <20200717223407.GS3008823@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-5-ira.weiny@intel.com>
 <20200717085954.GY10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717085954.GY10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:59:54AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:43AM -0700, ira.weiny@intel.com wrote:
> > +/*
> > + * Write the PKey Register Supervisor.  This must be run with preemption
> > + * disabled as it does not guarantee the atomicity of updating the pkrs_cache
> > + * and MSR on its own.
> > + */
> > +void write_pkrs(u32 pkrs_val)
> > +{
> > +	this_cpu_write(pkrs_cache, pkrs_val);
> > +	wrmsrl(MSR_IA32_PKRS, pkrs_val);
> > +}
> 
> Should we write that like:
> 
> void write_pkrs(u32 pkr)
> {
> 	u32 *pkrs = get_cpu_ptr(pkrs_cache);
> 	if (*pkrs != pkr) {
> 		*pkrs = pkr;
> 		wrmsrl(MSR_IA32_PKRS, pkr);
> 	}
> 	put_cpu_ptrpkrs_cache);
> }
> 
> given that we fundamentally need to serialize againt schedule() here.

Yes.  That seems better.

That also means pks_sched_in() can be simplified to just

static inline void pks_sched_in(void)
{
	write_pkrs(current->thread.saved_pkrs);
}

Because of the built WRMSR avoidance.

However, pkrs_cache is static so I think I need to use {get,put}_cpu_var() here
don't I?

Thanks!
Ira

