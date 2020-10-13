Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314C828D4D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 21:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgJMToH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 15:44:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:48130 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgJMToH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:44:07 -0400
IronPort-SDR: Bb3xQNoTS7eEQX6Z7Gxj35PFz5/+t3zi/NM9KV4iTUwjgrmz4U1Eq1eUgZ5DCRxujHA9DSdtKn
 Ss/5ZNw06q8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="230152748"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="230152748"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 12:44:06 -0700
IronPort-SDR: FYowcW5TgJ16AeEVdPPfqP9JnqqAhtCUVoZalbg+Ng0NVMQ+PjkvJjQyjlNEqhvyQc+O17Jzhv
 jpaAnfNZjUOw==
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="530539601"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 12:44:05 -0700
Date:   Tue, 13 Oct 2020 12:44:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 1/9] x86/pkeys: Create pkeys_common.h
Message-ID: <20201013194405.GG2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-2-ira.weiny@intel.com>
 <0305912d-891f-839a-e861-49f5fada62b1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0305912d-891f-839a-e861-49f5fada62b1@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:46:16AM -0700, Dave Hansen wrote:
> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> > Protection Keys User (PKU) and Protection Keys Supervisor (PKS) work
> > in similar fashions and can share common defines.
> 
> Could we be a bit less abstract?  PKS and PKU each have:
> 1. A single control register
> 2. The same number of keys
> 3. The same number of bits in the register per key
> 4. Access and Write disable in the same bit locations
> 
> That means that we can share all the macros that synthesize and
> manipulate register values between the two features.

Sure.  Done.

> 
> > +++ b/arch/x86/include/asm/pkeys_common.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_X86_PKEYS_INTERNAL_H
> > +#define _ASM_X86_PKEYS_INTERNAL_H
> > +
> > +#define PKR_AD_BIT 0x1
> > +#define PKR_WD_BIT 0x2
> > +#define PKR_BITS_PER_PKEY 2
> > +
> > +#define PKR_AD_KEY(pkey)	(PKR_AD_BIT << ((pkey) * PKR_BITS_PER_PKEY))
> 
> Now that this has moved away from its use-site, it's a bit less
> self-documenting.  Let's add a comment:
> 
> /*
>  * Generate an Access-Disable mask for the given pkey.  Several of these
>  * can be OR'd together to generate pkey register values.
>  */

Fair enough. done.

> 
> Once that's in place, along with the updated changelog:
> 
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks,
Ira

