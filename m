Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C265225B1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 11:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgGTJQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGTJQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:16:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264B3C061794;
        Mon, 20 Jul 2020 02:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LGLWvg6ZDIUlei0ZDQ3T5GmRjQgNLRaVaWwSYGqHGW4=; b=hSBeriNHtlumBJ+DPG5faJaUBK
        xOohGFXtfbnZk6s5lws1YyNCXqeSHDgqdGn6Wo7FyyBA8zVImTRfO722gMZD48RZoXPx+JkfpUVlu
        TKh11UPDMA2/enEZKUwjegXxgRSEG0uJPFvxApi4A1eN+vXlXxim2A/g4A4Ia8LiRgps7RgVk4AUi
        rGStWRJjZ9iLyu5d8pBo3A2cHvvBEYJbweYyDj0/J3K3u6GyAEp3FGfyjWXdvkuJD8/D+udXHtcZh
        qpbn6ZAr/RTIgKpXTPWMwjJeHwjDlkVR6Uv9xhWno3N5yy+Bdjf6QTUGXzF98MYmW1Egoo81znxWW
        dnOw8mjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxRtr-0005wP-Ts; Mon, 20 Jul 2020 09:15:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89F023010C8;
        Mon, 20 Jul 2020 11:15:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B365205A7673; Mon, 20 Jul 2020 11:15:54 +0200 (CEST)
Date:   Mon, 20 Jul 2020 11:15:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
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
Subject: Re: [PATCH RFC V2 04/17] x86/pks: Preserve the PKRS MSR on context
 switch
Message-ID: <20200720091554.GN10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-5-ira.weiny@intel.com>
 <20200717085954.GY10769@hirez.programming.kicks-ass.net>
 <20200717223407.GS3008823@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717223407.GS3008823@iweiny-DESK2.sc.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 03:34:07PM -0700, Ira Weiny wrote:
> On Fri, Jul 17, 2020 at 10:59:54AM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 17, 2020 at 12:20:43AM -0700, ira.weiny@intel.com wrote:
> > > +/*
> > > + * Write the PKey Register Supervisor.  This must be run with preemption
> > > + * disabled as it does not guarantee the atomicity of updating the pkrs_cache
> > > + * and MSR on its own.
> > > + */
> > > +void write_pkrs(u32 pkrs_val)
> > > +{
> > > +	this_cpu_write(pkrs_cache, pkrs_val);
> > > +	wrmsrl(MSR_IA32_PKRS, pkrs_val);
> > > +}
> > 
> > Should we write that like:
> > 
> > void write_pkrs(u32 pkr)
> > {
> > 	u32 *pkrs = get_cpu_ptr(pkrs_cache);
> > 	if (*pkrs != pkr) {
> > 		*pkrs = pkr;
> > 		wrmsrl(MSR_IA32_PKRS, pkr);
> > 	}
> > 	put_cpu_ptrpkrs_cache);
> > }
> > 
> > given that we fundamentally need to serialize againt schedule() here.
> 
> Yes.  That seems better.
> 
> That also means pks_sched_in() can be simplified to just
> 
> static inline void pks_sched_in(void)
> {
> 	write_pkrs(current->thread.saved_pkrs);
> }
> 
> Because of the built WRMSR avoidance.
> 
> However, pkrs_cache is static so I think I need to use {get,put}_cpu_var() here
> don't I?

Or get_cpu_ptr(&pkrs_cache), sorry for the typo :-)
