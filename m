Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804DE21FDC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgGNTtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgGNTtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:49:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2ACC061755;
        Tue, 14 Jul 2020 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q7NrJBulspMdgxi2cducPGZ39YVyw0D0jNEe7CHNFek=; b=pR+q0ltz9wN4EMOYLJfOx0i96Z
        fflfRrIqJ/FjDcRjkjnXWWtoHOwwXb5VsxdrGuZS+CvUr+oUVlTyCv7gRGycAnTBa73nx/ZZzxraY
        82iJarBVL45tJXSN9iBukFBmkrK9TjFwkyynR9lgHVj3P/pTN95GAdES3IngOKWCc/IT/AJeExrws
        B1iS+MFHhiV2wqkcQPS+4cu4PIVmyzJ5wPbo1+MD1rYtVpUtTpPR4NAyL3Qe+F1StOpbl5ZlMwm/d
        zltUaTYbLueeel/jU/1kBjn+57c1OiyIkuqs9kUC5wGlwJjyFjRHU5uwW598uj7Fo2AqOiGYpCTQs
        STKoB0Qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQva-0008SY-R4; Tue, 14 Jul 2020 19:49:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA5909817E0; Tue, 14 Jul 2020 21:49:21 +0200 (CEST)
Date:   Tue, 14 Jul 2020 21:49:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [RFC PATCH 12/15] kmap: Add stray write protection for device
 pages
Message-ID: <20200714194921.GJ5523@worktop.programming.kicks-ass.net>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-13-ira.weiny@intel.com>
 <20200714084451.GQ10769@hirez.programming.kicks-ass.net>
 <20200714190615.GC3008823@iweiny-DESK2.sc.intel.com>
 <20200714192930.GH5523@worktop.programming.kicks-ass.net>
 <50d472d8-e4d9-dd35-f31f-268aa69c76e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50d472d8-e4d9-dd35-f31f-268aa69c76e2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:42:11PM -0700, Dave Hansen wrote:
> On 7/14/20 12:29 PM, Peter Zijlstra wrote:
> > On Tue, Jul 14, 2020 at 12:06:16PM -0700, Ira Weiny wrote:
> >> On Tue, Jul 14, 2020 at 10:44:51AM +0200, Peter Zijlstra wrote:
> >>> So, if I followed along correctly, you're proposing to do a WRMSR per
> >>> k{,un}map{_atomic}(), sounds like excellent performance all-round :-(
> >> Only to pages which have this additional protection, ie not DRAM.
> >>
> >> User mappings of this memory is not affected (would be covered by User PKeys if
> >> desired).  User mappings to persistent memory are the primary use case and the
> >> performant path.
> > Because performance to non-volatile memory doesn't matter? I think Dave
> > has a better answer here ...
> 
> So, these WRMSRs are less evil than normal.  They're architecturally
> non-serializing instructions,

Excellent, that should make these a fair bit faster than regular MSRs.

> But, either way, this *will* make accessing PMEM more expensive from the
> kernel.  No escaping that. 

There's no free lunch, it's just that regular MSRs are fairly horrible.
