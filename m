Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1782224565
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 22:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGQUw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 16:52:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:46328 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgGQUw4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:52:56 -0400
IronPort-SDR: ccA0VIC++hRfB2yVjVzT0UNATUk+loJD2acJHKdhTFZ4OKGwpEK+F83LJq+fQWDJm9Ked4c9Mb
 kMNsLfgJyHVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="137785235"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="137785235"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 13:52:55 -0700
IronPort-SDR: 690U0n6opbZ/Ur7zkVu//anEQ7MRj2sHCRzWpKkvX0jU9VzxrjihvaQr+xK5iBUfhEQqvlrfq5
 HGUS8jcEky3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="326947980"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2020 13:52:55 -0700
Date:   Fri, 17 Jul 2020 13:52:55 -0700
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
Subject: Re: [PATCH RFC V2 02/17] x86/fpu: Refactor
 arch_set_user_pkey_access() for PKS support
Message-ID: <20200717205254.GQ3008823@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-3-ira.weiny@intel.com>
 <20200717085442.GX10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717085442.GX10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:54:42AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:41AM -0700, ira.weiny@intel.com wrote:
> > +/*
> > + * Get a new pkey register value from the user values specified.
> > + *
> > + * Kernel users use the same flags as user space:
> > + *     PKEY_DISABLE_ACCESS
> > + *     PKEY_DISABLE_WRITE
> > + */
> > +u32 get_new_pkr(u32 old_pkr, int pkey, unsigned long init_val)
> > +{
> > +	int pkey_shift = (pkey * PKR_BITS_PER_PKEY);
> > +	u32 new_pkr_bits = 0;
> > +
> > +	/* Set the bits we need in the register:  */
> > +	if (init_val & PKEY_DISABLE_ACCESS)
> > +		new_pkr_bits |= PKR_AD_BIT;
> > +	if (init_val & PKEY_DISABLE_WRITE)
> > +		new_pkr_bits |= PKR_WD_BIT;
> > +
> > +	/* Shift the bits in to the correct place: */
> > +	new_pkr_bits <<= pkey_shift;
> > +
> > +	/* Mask off any old bits in place: */
> > +	old_pkr &= ~((PKR_AD_BIT | PKR_WD_BIT) << pkey_shift);
> > +
> > +	/* Return the old part along with the new part: */
> > +	return old_pkr | new_pkr_bits;
> > +}
> 
> This is unbelievable junk...
> 
> How about something like:
> 
> u32 update_pkey_reg(u32 pk_reg, int pkey, unsigned int flags)
> {
> 	int pkey_shift = pkey * PKR_BITS_PER_PKEY;
> 
> 	pk_reg &= ~(((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift);
> 
> 	if (flags & PKEY_DISABLE_ACCESS)
> 		pk_reg |= PKR_AD_BIT << pkey_shift;
> 	if (flags & PKEY_DISABLE_WRITE)
> 		pk_reg |= PKR_WD_BIT << pkey_shift;
> 
> 	return pk_reg;
> }
> 
> Then we at least have a little clue wtf the thing does.. Yes I started
> with a rename and then got annoyed at the implementation too.

On the code I think this is fair.  I've also updated the calling function to be
a bit cleaner as well.

However, I think the name 'update' is a bit misleading.  Here is the new
calling code:

...
        pkru = read_pkru();
	pkru = update_pkey_reg(pkru, pkey, init_val);
	write_pkru(pkru);
...


I think it is odd to have a function called update_pkey_reg() called right
before a write_pkru().  Can we call this update_pkey_value?  or just 'val'?
Because write_pkru() actually updates the register.

Thanks for the review,
Ira

