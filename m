Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F022956A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 11:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgGVJtS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVJtR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:49:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5CAC0619DC;
        Wed, 22 Jul 2020 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CGWeeSRaUSkQ7fRpSaSxceYYgFD1vpes5EtqHWHdpSk=; b=OwoBHanUcjzURwMFxFtVsv9qfg
        SeMEMy/1cgFq/6m+pzEEfSa6Xcdy/FeKvQkAYl0zjdjfLykOJ8qAC+63Dr3qdZ20GQbde7oDVD6Jq
        uawCAOpyJ8G/qXsZEIrjKsaLLf88AFKEvhFUsMYXlAHU6X7PbtkQaQH4eOH9Rzuab+mB/XLsjUTUj
        Kq3qmjssUzDiUOfEnSKuCfvCZsqxbJaT+qKDQHrOTeaZWbVIDB3rYawhHlO9mhq0FjoH+7nyqW6sR
        xdC3UlwPbRuWnsgQBfnNEKRrKuyGQ8HVupyoL8IwxZ9p3A9+yamJ/NCAGw21N1yHcHM1pzHtYIn8N
        VUj0Bt1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyBMw-0007bB-1x; Wed, 22 Jul 2020 09:48:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93C513011C6;
        Wed, 22 Jul 2020 11:48:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D378821A7D50E; Wed, 22 Jul 2020 11:48:53 +0200 (CEST)
Date:   Wed, 22 Jul 2020 11:48:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200722094853.GM10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <20200717100610.GH10769@hirez.programming.kicks-ass.net>
 <20200722052709.GB478587@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722052709.GB478587@iweiny-DESK2.sc.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 10:27:09PM -0700, Ira Weiny wrote:

> I've been really digging into this today and I'm very concerned that I'm
> completely missing something WRT idtentry_enter() and idtentry_exit().
> 
> I've instrumented idt_{save,restore}_pkrs(), and __dev_access_{en,dis}able()
> with trace_printk()'s.
> 
> With this debug code, I have found an instance where it seems like
> idtentry_enter() is called without a corresponding idtentry_exit().  This has
> left the thread ref counter at 0 which results in very bad things happening
> when __dev_access_disable() is called and the ref count goes negative.
> 
> Effectively this seems to be happening:
> 
> ...
> 	// ref == 0
> 	dev_access_enable()  // ref += 1 ==> disable protection
> 		// exception  (which one I don't know)
> 			idtentry_enter()
> 				// ref = 0
> 				_handler() // or whatever code...
> 			// *_exit() not called [at least there is no trace_printk() output]...
> 			// Regardless of trace output, the ref is left at 0
> 	dev_access_disable() // ref -= 1 ==> -1 ==> does not enable protection
> 	(Bad stuff is bound to happen now...)
> ...
> 
> The ref count ends up completely messed up after this sequence...  and the PKRS
> register gets out of sync as well.  This is starting to make some sense of how
> I was getting what seemed like random crashes before.
> 
> Unfortunately I don't understand the idt entry/exit code well enough to see
> clearly what is going on.  Is there any reason idtentry_exit() is not called
> after idtentry_enter()?  Perhaps some NMI/MCE or 'not normal' exception code
> path I'm not seeing?  In my searches I see a corresponding exit for every
> enter.  But MCE is pretty hard to follow.
> 
> Also is there any chance that the process could be getting scheduled and that
> is causing an issue?

Ooh, I think I see the problem. We also use idtentry_enter() for #PF,
and #PF can schedule, exactly as you observed. Argh!

This then means you need to go frob something in
arch/x86/include/asm/idtentry.h, which is somewhat unfortunate.

Thomas, would it make sense to add a type parameter to
idtentry_{enter,exit}() ?
