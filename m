Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D798D290F89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Oct 2020 07:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436625AbgJQFmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Oct 2020 01:42:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:56627 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408934AbgJQFmR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:42:17 -0400
IronPort-SDR: 4knH7JxomiV86CjX5h0Kj2bf2SeKDFDrl1ycf5JYrYMXI4yuTTknG3qIjv8lKBDoN3p7pLqEa/
 6MTSaYJPrVSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="146052110"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="146052110"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:42:16 -0700
IronPort-SDR: bloDPZ1mHCCMDkSL4HTubqN5FZT0XoM6+FUXgp3YTonyMsQFc3Ur7Lotbw2ij0kO5hWgIJ5cfw
 HGUQxgmHfd2w==
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="522528942"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:42:16 -0700
Date:   Fri, 16 Oct 2020 22:42:16 -0700
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
Subject: Re: [PATCH RFC V3 5/9] x86/pks: Add PKS kernel API
Message-ID: <20201017054216.GB3702775@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-6-ira.weiny@intel.com>
 <20201016110747.GM2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016110747.GM2611@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 01:07:47PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 12:42:54PM -0700, ira.weiny@intel.com wrote:
> > +static inline void pks_update_protection(int pkey, unsigned long protection)
> > +{
> > +	current->thread.saved_pkrs = update_pkey_val(current->thread.saved_pkrs,
> > +						     pkey, protection);
> > +	preempt_disable();
> > +	write_pkrs(current->thread.saved_pkrs);
> > +	preempt_enable();
> > +}
> 
> write_pkrs() already disables preemption itself. Wrapping it in yet
> another layer is useless.

I was thinking the update to saved_pkrs needed this protection as well and that
was to be included in the preemption disable.  But that too is incorrect.

I've removed this preemption disable.

Thanks,
Ira
