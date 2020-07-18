Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0222D224918
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 07:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgGRFvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jul 2020 01:51:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:11135 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgGRFvF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:51:05 -0400
IronPort-SDR: AYj5vi9SRqf90NzlG1PtvIWR5kP8GG2xKuSQJMNrukWUMpeW1xa+p5v6uCymiFzQveeMn9wzGH
 rTUZnN7GJfGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="137186390"
X-IronPort-AV: E=Sophos;i="5.75,365,1589266800"; 
   d="scan'208";a="137186390"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 22:51:04 -0700
IronPort-SDR: Bc8yS/Mga/P/JELyDS9maVNQZIck4wfEmlGO3VkOyOrNQb8SVgJAdVZL/lTq/KBuOwtXK2wrMt
 piSYLWsQeJ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,365,1589266800"; 
   d="scan'208";a="282993538"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga003.jf.intel.com with ESMTP; 17 Jul 2020 22:51:04 -0700
Date:   Fri, 17 Jul 2020 22:51:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 12/17] memremap: Add zone device access protection
Message-ID: <20200718055103.GU3008823@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-13-ira.weiny@intel.com>
 <20200717091718.GA10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717091718.GA10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 11:17:18AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 17, 2020 at 12:20:51AM -0700, ira.weiny@intel.com wrote:
> > +void dev_access_disable(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	if (!static_branch_unlikely(&dev_protection_static_key))
> > +		return;
> > +
> > +	local_irq_save(flags);
> > +	current->dev_page_access_ref--;
> > +	if (current->dev_page_access_ref == 0)
> 
> 	if (!--current->dev_page_access_ref)

It's not my style but I'm ok with it.

> 
> > +		pks_update_protection(dev_page_pkey, PKEY_DISABLE_ACCESS);
> > +	local_irq_restore(flags);
> > +}
> > +EXPORT_SYMBOL_GPL(dev_access_disable);
> > +
> > +void dev_access_enable(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	if (!static_branch_unlikely(&dev_protection_static_key))
> > +		return;
> > +
> > +	local_irq_save(flags);
> > +	/* 0 clears the PKEY_DISABLE_ACCESS bit, allowing access */
> > +	if (current->dev_page_access_ref == 0)
> > +		pks_update_protection(dev_page_pkey, 0);
> > +	current->dev_page_access_ref++;
> 
> 	if (!current->dev_page_access_ref++)

Sure.

> 
> > +	local_irq_restore(flags);
> > +}
> > +EXPORT_SYMBOL_GPL(dev_access_enable);
> 
> 
> Also, you probably want something like:
> 
> static __always_inline devm_access_disable(void)

Yes that is better.

However, again Dan and I agree devm is not the right prefix here.

I've updated.

Thanks!
Ira

> {
> 	if (static_branch_unlikely(&dev_protection_static_key))
> 		__devm_access_disable();
> }
> 
> static __always_inline devm_access_enable(void)
> {
> 	if (static_branch_unlikely(&dev_protection_static_key))
> 		__devm_access_enable();
> }
