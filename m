Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EEC293E50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407912AbgJTOKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 10:10:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:52692 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407842AbgJTOKa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:10:30 -0400
IronPort-SDR: F6UDmgcB74y5Abu1N5mh1hLwJizDX+vUR9iVUW7/DKQWDmr3tGJZ8dayAlPiUURHu9roZ+Xl4b
 fhrzJ4dA//hQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="166435279"
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400"; 
   d="scan'208";a="166435279"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 07:10:29 -0700
IronPort-SDR: 5xB2GYyzejmXwfcx8S0E0keerXvIVZmHeJ9k8p8SkKxbYpm+GEU2CaHzDyn4xNTNrYc7te8yIK
 wI4dOY831O1w==
X-IronPort-AV: E=Sophos;i="5.77,397,1596524400"; 
   d="scan'208";a="533074263"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 07:10:29 -0700
Date:   Tue, 20 Oct 2020 07:10:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V3 6/9] x86/entry: Pass irqentry_state_t by reference
Message-ID: <20201020141029.GE3713473@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-7-ira.weiny@intel.com>
 <20201016114510.GO2611@hirez.programming.kicks-ass.net>
 <87lfg6tjnq.fsf@nanos.tec.linutronix.de>
 <20201019053639.GA3713473@iweiny-DESK2.sc.intel.com>
 <87k0vma7ct.fsf@nanos.tec.linutronix.de>
 <20201019202647.GD3713473@iweiny-DESK2.sc.intel.com>
 <871rhtapir.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rhtapir.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:12:44PM +0200, Thomas Gleixner wrote:
> On Mon, Oct 19 2020 at 13:26, Ira Weiny wrote:
> > On Mon, Oct 19, 2020 at 11:32:50AM +0200, Thomas Gleixner wrote:
> > Sorry, let me clarify.  After this patch we have.
> >
> > typedef union irqentry_state {
> > 	bool	exit_rcu;
> > 	bool	lockdep;
> > } irqentry_state_t;
> >
> > Which reflects the mutual exclusion of the 2 variables.
> 
> Huch? From the patch I gave you:
> 
>  #ifndef irqentry_state
>  typedef struct irqentry_state {
>  	bool    exit_rcu;
> +       bool    lockdep;
>  } irqentry_state_t;
>  #endif
> 
> How is that a union?

I was proposing to make it a union.

> 
> > But then when the pkrs stuff is added the union changes back to a structure and
> > looks like this.
> 
> So you want:
> 
>   1) Move stuff to struct irqentry_state (my patch)
> 
>   2) Change it to a union and pass it as pointer at the same time

No, I would have made it a union in your patch.

Pass by reference would remain largely the same.

> 
>   3) Change it back to struct to add PKRS

Yes.  :-/

> 
> > Is that clear?
> 
> What's clear is that the above is nonsense. We can just do
> 
>  #ifndef irqentry_state
>  typedef struct irqentry_state {
>  	union {
>          	bool    exit_rcu;
>                 bool    lockdep;
>         };        
>  } irqentry_state_t;
>  #endif
> 
> right in the patch which I gave you. Because that actually makes sense.

Ok I'm very sorry.  I was thinking that having a struct containing nothing but
an anonymous union would be unacceptable as a stand alone item in your patch.
In my experience other maintainers would have rejected such a change and
would have asked; 'why not just make it a union'?

I'm very happy skipping the gymnastics on individual patches in favor of making
the whole series work out in the end.

Thank you for your help again.  :-)

Ira
