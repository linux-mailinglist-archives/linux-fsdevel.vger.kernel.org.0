Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02B292DBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 20:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgJSSs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 14:48:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:16370 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbgJSSs7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:48:59 -0400
IronPort-SDR: 2Uu/efrXkwcYfZ13Vh1e4bjXBRJyN9t9x+RU4MYsgiXB2tp3pGHkTIYkhFr3Ho6UuJp57RtEiL
 HnJy6ekHAn/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="167165415"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="167165415"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 11:48:51 -0700
IronPort-SDR: 9Q6lfeqmVXf8xJoZpKKEiMAlLaNRA4+210TknTwmbYMu5RiGfjwSmlxLQWJuXLP/L8JCdm8vZJ
 yjNckI9qdKrw==
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="301476541"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 11:48:49 -0700
Date:   Mon, 19 Oct 2020 11:48:49 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20201019184849.GC3713473@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
 <429789d3-ab5b-49c3-65c3-f0fc30a12516@intel.com>
 <20201016111226.GN2611@hirez.programming.kicks-ass.net>
 <20201017051410.GW2046448@iweiny-DESK2.sc.intel.com>
 <20201019093714.GI2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019093714.GI2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:37:14AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 16, 2020 at 10:14:10PM -0700, Ira Weiny wrote:
> > > so it either needs to
> > > explicitly do so, or have an assertion that preemption is indeed
> > > disabled.
> > 
> > However, I don't think I understand clearly.  Doesn't [get|put]_cpu_ptr()
> > handle the preempt_disable() for us? 
> 
> It does.
> 
> > Is it not sufficient to rely on that?
> 
> It is.
> 
> > Dave's comment seems to be the opposite where we need to eliminate preempt
> > disable before calling write_pkrs().
> > 
> > FWIW I think I'm mistaken in my response to Dave regarding the
> > preempt_disable() in pks_update_protection().
> 
> Dave's concern is that we're calling with with preemption already
> disabled so disabling it again is superfluous.

Ok, thanks, and after getting my head straight I think I agree with him, and
you.

Thanks I've reworked the code to removed the superfluous calls.  Sorry about
being so dense...  :-D

Ira
