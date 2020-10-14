Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3026428D83C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 04:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgJNCI3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 22:08:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:22912 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJNCI3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:08:29 -0400
IronPort-SDR: yBPi+WL7a4DNdUvyrh1MJhTW+GyOOMVGIX1S38Tc37EzWAxgs4WvuDTApBhoYjxT5xoHjKRQD/
 ifcKXwlt0QhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145879786"
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="145879786"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 19:08:27 -0700
IronPort-SDR: inQ4qbS0lmxsXC1fa/JBY45Zh6JLJm29uxHgtI4QzSetpkgZ6qu/XIxzj094gWeTQWPgLeSmUk
 brKTQAX3Hb1w==
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="530644675"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 19:08:26 -0700
Date:   Tue, 13 Oct 2020 19:08:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 3/9] x86/pks: Enable Protection Keys Supervisor
 (PKS)
Message-ID: <20201014020825.GM2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-4-ira.weiny@intel.com>
 <cfd8e361-9d5b-5b24-08d4-31ad3d392255@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd8e361-9d5b-5b24-08d4-31ad3d392255@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 11:23:08AM -0700, Dave Hansen wrote:
> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> > +/*
> > + * PKS is independent of PKU and either or both may be supported on a CPU.
> > + * Configure PKS if the cpu supports the feature.
> > + */
> 
> Let's at least be consistent about CPU vs. cpu in a single comment. :)

Sorry, done.

> 
> > +static void setup_pks(void)
> > +{
> > +	if (!IS_ENABLED(CONFIG_ARCH_HAS_SUPERVISOR_PKEYS))
> > +		return;
> > +	if (!cpu_feature_enabled(X86_FEATURE_PKS))
> > +		return;
> 
> If you put X86_FEATURE_PKS in disabled-features.h, you can get rid of
> the explicit CONFIG_ check.

Done.

> 
> > +	cr4_set_bits(X86_CR4_PKS);
> > +}
> > +
> >  /*
> >   * This does the hard work of actually picking apart the CPU stuff...
> >   */
> > @@ -1544,6 +1558,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
> >  
> >  	x86_init_rdrand(c);
> >  	setup_pku(c);
> > +	setup_pks();
> >  
> >  	/*
> >  	 * Clear/Set all flags overridden by options, need do it
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 6c974888f86f..1b9bc004d9bc 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -822,6 +822,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
> >  	bool
> >  config ARCH_HAS_PKEYS
> >  	bool
> > +config ARCH_HAS_SUPERVISOR_PKEYS
> > +	bool
> >  
> >  config PERCPU_STATS
> >  	bool "Collect percpu memory statistics"
> > 
> 
