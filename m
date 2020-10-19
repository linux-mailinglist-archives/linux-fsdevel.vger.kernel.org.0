Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C7E2924AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 11:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgJSJfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJSJfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:35:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B16C0613CE;
        Mon, 19 Oct 2020 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zox4iuTUh5FhfHMfr5Q1+3mfA7F/sioi7RToa5+WOak=; b=1cTRPkWVb54NZZ9RoS/xBCH//y
        bQ8J6UD4Msz4eTlusz0Mg0XUPKXXee9CpA39JXkycYwfkuyW38XvZxx+Ov+bC+orngC/knAgKRe+V
        RSUEzGr/pQne1U7t+uJT4Ysxl9Fpg7ljYx9s0FfTJaon0FQp5khD6hZW6u9s5G0zQWlm88iGLMExl
        F7eXrCeoL/Iljfckg/PyFFE4SBgQQ6pDjaupvcpSCYQez3wm478Lf2zsTglmh+ANgPSXtxSN1OpD6
        gPVw+tJxsfEjTgFZbH/pINcQlGxLK7zMigefRp0S20SP1O49vayTSnvv+EhM8QiQl4oc6BbeVvwcB
        veDuI0Gw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kURZL-0005n6-V6; Mon, 19 Oct 2020 09:35:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C3083011E6;
        Mon, 19 Oct 2020 11:35:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E27A21447780; Mon, 19 Oct 2020 11:35:02 +0200 (CEST)
Date:   Mon, 19 Oct 2020 11:35:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
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
Message-ID: <20201019093502.GH2628@hirez.programming.kicks-ass.net>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-3-ira.weiny@intel.com>
 <20201016105743.GK2611@hirez.programming.kicks-ass.net>
 <20201017033202.GV2046448@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017033202.GV2046448@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 08:32:03PM -0700, Ira Weiny wrote:
> On Fri, Oct 16, 2020 at 12:57:43PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 09, 2020 at 12:42:51PM -0700, ira.weiny@intel.com wrote:
> > > From: Fenghua Yu <fenghua.yu@intel.com>
> > > 
> > > Define a helper, update_pkey_val(), which will be used to support both
> > > Protection Key User (PKU) and the new Protection Key for Supervisor
> > > (PKS) in subsequent patches.
> > > 
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > > ---
> > >  arch/x86/include/asm/pkeys.h |  2 ++
> > >  arch/x86/kernel/fpu/xstate.c | 22 ++++------------------
> > >  arch/x86/mm/pkeys.c          | 21 +++++++++++++++++++++
> > >  3 files changed, 27 insertions(+), 18 deletions(-)
> > 
> > This is not from Fenghua.
> > 
> >   https://lkml.kernel.org/r/20200717085442.GX10769@hirez.programming.kicks-ass.net
> > 
> > This is your patch based on the code I wrote.
> 
> Ok, I apologize.  Yes the code below was all yours.
> 
> Is it ok to add?
> 
> Co-developed-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> 

Sure, thanks!
