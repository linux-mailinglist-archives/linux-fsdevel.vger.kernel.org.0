Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED7E28EBF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 06:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgJOENS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 00:13:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:22958 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgJOENS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 00:13:18 -0400
IronPort-SDR: P+b+AHQqz6bD76LlUBeyV+VfySU0Y9OiN1ll70ninYtEr8Ob9NeD57xynXbqDNv32jVzX4/3vn
 8CfLcZFONi1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="230443564"
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="230443564"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:13:17 -0700
IronPort-SDR: Rl7k8n0kXpoNoqIwrMtUpN8XayQEpRNT0hviQBpmpRIMPeasyhZ2HMFjVvFRrQMIIhpfXjPBuY
 pHwulYaXA35w==
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400"; 
   d="scan'208";a="531099549"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:13:16 -0700
Date:   Wed, 14 Oct 2020 21:13:16 -0700
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
Subject: Re: [PATCH RFC V3 8/9] x86/fault: Report the PKRS state on fault
Message-ID: <20201015041316.GR2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-9-ira.weiny@intel.com>
 <d6546e84-2196-25fd-3d8d-5e65fe22a71c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6546e84-2196-25fd-3d8d-5e65fe22a71c@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 11:56:53AM -0700, Dave Hansen wrote:
> > @@ -548,6 +549,11 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
> >  		 (error_code & X86_PF_PK)    ? "protection keys violation" :
> >  					       "permissions violation");
> >  
> > +#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > +	if (irq_state && (error_code & X86_PF_PK))
> > +		pr_alert("PKRS: 0x%x\n", irq_state->pkrs);
> > +#endif
> 
> This means everyone will see 'PKRS: 0x0', even if they're on non-PKS
> hardware.  I think I'd rather have this only show PKRS when we're on
> cpu_feature_enabled(PKS) hardware.

Good catch, thanks.

> 
> ...
> > @@ -1148,14 +1156,15 @@ static int fault_in_kernel_space(unsigned long address)
> >   */
> >  static void
> >  do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
> > -		   unsigned long address)
> > +		   unsigned long address, irqentry_state_t *irq_state)
> >  {
> >  	/*
> > -	 * Protection keys exceptions only happen on user pages.  We
> > -	 * have no user pages in the kernel portion of the address
> > -	 * space, so do not expect them here.
> > +	 * If protection keys are not enabled for kernel space
> > +	 * do not expect Pkey errors here.
> >  	 */
> 
> Let's fix the double-negative:
> 
> 	/*
> 	 * PF_PK is only expected on kernel addresses whenn
> 	 * supervisor pkeys are enabled:
> 	 */

done. thanks.

> 
> > -	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
> > +	if (!IS_ENABLED(CONFIG_ARCH_HAS_SUPERVISOR_PKEYS) ||
> > +	    !cpu_feature_enabled(X86_FEATURE_PKS))
> > +		WARN_ON_ONCE(hw_error_code & X86_PF_PK);
> 
> Yeah, please stick X86_FEATURE_PKS in disabled-features so you can use
> cpu_feature_enabled(X86_FEATURE_PKS) by itself here..

done.

thanks,
Ira

