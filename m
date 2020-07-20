Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED243225B08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 11:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgGTJOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgGTJOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:14:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90358C0619D2;
        Mon, 20 Jul 2020 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EpGd6SEaYQtDfwRuX/5QX4nSgxOOCJks5zLX/RcylHI=; b=o2uXRpBUKCj/3z9C8xL2NxsLDH
        rKrqEdke9+y7xe207kiZRU9MC379GI4gZovgu/FmbG8gR4nxsro7LQolBc01s12sEEIchddhnfxqX
        4jvm2gzcB0p4+cybVE9RXmvefsfzt+TJzrw4vh31pRkw3wYYWOHR58N1G9eRMxyMfSV0cBNxHPVTs
        dcl+yj/dT4hQbBaJBaRevoQTSOhR1OCJy4AfJvmbxWldkPMMaIvh4YXDb8kYYQL/TUyMLrLp14kAw
        x44frFLYDRGbXy3JcYGVMHEuSC28p3zVgHSHp9eYgwXrRvBo4vQxaRluocS9a3q41UoK9ZFf2Azor
        X4lLH7RQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxRsb-0005jK-4L; Mon, 20 Jul 2020 09:14:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BED2A306CEE;
        Mon, 20 Jul 2020 11:14:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0D04205A7673; Mon, 20 Jul 2020 11:14:35 +0200 (CEST)
Date:   Mon, 20 Jul 2020 11:14:35 +0200
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
Subject: Re: [PATCH RFC V2 02/17] x86/fpu: Refactor
 arch_set_user_pkey_access() for PKS support
Message-ID: <20200720091435.GM10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-3-ira.weiny@intel.com>
 <20200717085442.GX10769@hirez.programming.kicks-ass.net>
 <20200717205254.GQ3008823@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717205254.GQ3008823@iweiny-DESK2.sc.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:52:55PM -0700, Ira Weiny wrote:
> On Fri, Jul 17, 2020 at 10:54:42AM +0200, Peter Zijlstra wrote:

> > Then we at least have a little clue wtf the thing does.. Yes I started
> > with a rename and then got annoyed at the implementation too.
> 
> On the code I think this is fair.  I've also updated the calling function to be
> a bit cleaner as well.
> 
> However, I think the name 'update' is a bit misleading.  Here is the new
> calling code:
> 
> ...
>         pkru = read_pkru();
> 	pkru = update_pkey_reg(pkru, pkey, init_val);
> 	write_pkru(pkru);
> ...
> 
> 
> I think it is odd to have a function called update_pkey_reg() called right
> before a write_pkru().  Can we call this update_pkey_value?  or just 'val'?
> Because write_pkru() actually updates the register.

Fair enough, update_pkey_val() works fine for me.
