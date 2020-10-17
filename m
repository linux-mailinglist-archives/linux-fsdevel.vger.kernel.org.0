Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2581290F5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Oct 2020 07:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408233AbgJQFfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Oct 2020 01:35:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:43562 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409430AbgJQFfS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:35:18 -0400
IronPort-SDR: RXH8Q+dOWLdkHKyiD1mnGpbys3Efva8uFXdh1cQEs5Gn+pMZMMsNDAQBRD4RcawbjgLSC08fi2
 jj3u1XCjZPiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="251422269"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="251422269"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 20:32:03 -0700
IronPort-SDR: kvyfzP2MmHEewAuij6J97fqoPkF27+6ntcl4pUo67Y0ey7WhiD8GVW1pnB6mjR8DSQp0w+kBVn
 R3ZScB5JlEAA==
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="521393708"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 20:32:03 -0700
Date:   Fri, 16 Oct 2020 20:32:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 2/9] x86/fpu: Refactor arch_set_user_pkey_access()
 for PKS support
Message-ID: <20201017033202.GV2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-3-ira.weiny@intel.com>
 <20201016105743.GK2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016105743.GK2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 12:57:43PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 12:42:51PM -0700, ira.weiny@intel.com wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > 
> > Define a helper, update_pkey_val(), which will be used to support both
> > Protection Key User (PKU) and the new Protection Key for Supervisor
> > (PKS) in subsequent patches.
> > 
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > ---
> >  arch/x86/include/asm/pkeys.h |  2 ++
> >  arch/x86/kernel/fpu/xstate.c | 22 ++++------------------
> >  arch/x86/mm/pkeys.c          | 21 +++++++++++++++++++++
> >  3 files changed, 27 insertions(+), 18 deletions(-)
> 
> This is not from Fenghua.
> 
>   https://lkml.kernel.org/r/20200717085442.GX10769@hirez.programming.kicks-ass.net
> 
> This is your patch based on the code I wrote.

Ok, I apologize.  Yes the code below was all yours.

Is it ok to add?

Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>

?

Thanks,
Ira

> 
> > diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> > index f5efb4007e74..3cf8f775f36d 100644
> > --- a/arch/x86/mm/pkeys.c
> > +++ b/arch/x86/mm/pkeys.c
> > @@ -208,3 +208,24 @@ static __init int setup_init_pkru(char *opt)
> >  	return 1;
> >  }
> >  __setup("init_pkru=", setup_init_pkru);
> > +
> > +/*
> > + * Update the pk_reg value and return it.
> > + *
> > + * Kernel users use the same flags as user space:
> > + *     PKEY_DISABLE_ACCESS
> > + *     PKEY_DISABLE_WRITE
> > + */
> > +u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
> > +{
> > +	int pkey_shift = pkey * PKR_BITS_PER_PKEY;
> > +
> > +	pk_reg &= ~(((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift);
> > +
> > +	if (flags & PKEY_DISABLE_ACCESS)
> > +		pk_reg |= PKR_AD_BIT << pkey_shift;
> > +	if (flags & PKEY_DISABLE_WRITE)
> > +		pk_reg |= PKR_WD_BIT << pkey_shift;
> > +
> > +	return pk_reg;
> > +}
> > -- 
> > 2.28.0.rc0.12.gb6a658bd00c9
> > 
