Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A65A28D73B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 01:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbgJMX5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 19:57:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:3817 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387742AbgJMX5C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:57:02 -0400
IronPort-SDR: oEilyMO80P99tUtBvHQyfBsYB4QsCq0vGk+hR2alHfoiSdoawQZ4FytKdy52kewP9KCgT6aTHo
 l0/LYbpLM+vQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="230182065"
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="230182065"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 16:57:00 -0700
IronPort-SDR: lCvdsHw4cNTMWJa/vna7fQPxd5RyrFTF13wYh2AkHf4SXv0mM4ELq6g5e3ZAT7t1A0eXxCnwi8
 qz1MFAWCB0PA==
X-IronPort-AV: E=Sophos;i="5.77,372,1596524400"; 
   d="scan'208";a="463687969"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 16:56:59 -0700
Date:   Tue, 13 Oct 2020 16:56:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 2/9] x86/fpu: Refactor arch_set_user_pkey_access()
 for PKS support
Message-ID: <20201013235658.GL2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-3-ira.weiny@intel.com>
 <7ed91cb5-93e5-67ad-ad35-8489d16d283f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed91cb5-93e5-67ad-ad35-8489d16d283f@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:50:05AM -0700, Dave Hansen wrote:
> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> > +/*
> > + * Update the pk_reg value and return it.
> 
> How about:
> 
> 	Replace disable bits for @pkey with values from @flags.

Done.

> 
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
> 
> I still think this deserves two lines of comments:
> 
> 	/* Mask out old bit values */
> 
> 	/* Or in new values */

Sure, done.
Ira

