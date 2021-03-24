Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B949347806
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 13:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhCXMPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 08:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhCXMPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:15:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB678C061763;
        Wed, 24 Mar 2021 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=48OjWaig9uawATa25cKrzW5rZ1wrmzf1PaJRwXuIZck=; b=Zhj6svGLgsjzrL1ryRg1Fa/1m4
        z+ylPTkRDOe7bLpQb0F9WiqDkuQTtVh9+Gsj/ncCOgumm3eYmka4fVyzksL7WKVQPQzT1goC4FWmY
        7o9HkKnWi1nRG4H/vyMw+joRzYHAoCCXYQmCphTLMWycMZe4RFoftMcb6PqSr/Cb8Dq9CiyhOgJvx
        +5lBKq8ZLTAN1TkFvEvYclraeiAl2rV7r/JaEdg2ohqHNGSS2KTEj1l7OBW0uujGKc95vOracQDfe
        lugLR5QAVyLdb3tvCunuQ6zwVoC4IrJRVbIc/V778VrKpfW7lDUzY5oLPD36LBZKhIuEOpblA/1Fg
        0mVQajLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP2N0-00BJqL-Ee; Wed, 24 Mar 2021 12:12:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2FEB306099;
        Wed, 24 Mar 2021 13:12:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B973E2BF5B73F; Wed, 24 Mar 2021 13:12:16 +0100 (CET)
Date:   Wed, 24 Mar 2021 13:12:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
Message-ID: <YFssoD5NDl6dFfg/@hirez.programming.kicks-ass.net>
References: <20210323035706.572953-1-joshdon@google.com>
 <YFsIZjhCFbxKyos3@hirez.programming.kicks-ass.net>
 <YFsaYBO/UqMHSpGS@hirez.programming.kicks-ass.net>
 <20210324114224.GP15768@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324114224.GP15768@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 11:42:24AM +0000, Mel Gorman wrote:
> On Wed, Mar 24, 2021 at 11:54:24AM +0100, Peter Zijlstra wrote:
> > On Wed, Mar 24, 2021 at 10:37:43AM +0100, Peter Zijlstra wrote:
> > > Should we perhaps take out all SCHED_DEBUG sysctls and move them to
> > > /debug/sched/ ? (along with the existing /debug/sched_{debug,features,preemp}
> > > files)
> > > 
> > > Having all that in sysctl and documented gives them far too much sheen
> > > of ABI.
> > 
> > ... a little something like this ...
> > 
> 
> I did not read this particularly carefully or boot it to check but some
> of the sysctls moved are expected to exist and should never should have
> been under SCHED_DEBUG.
> 
> For example, I'm surprised that numa_balancing is under the SCHED_DEBUG
> sysctl because there are legimiate reasons to disable that at runtime.
> For example, HPC clusters running various workloads may disable NUMA
> balancing globally for particular jobs without wanting to reboot and
> reenable it when finished.

Yeah, lets say I was pleasantly surprised to find it there :-)

> Moving something like sched_min_granularity_ns will break a number of
> tuning guides as well as the "tuned" tool which ships by default with
> some distros and I believe some of the default profiles used for tuned
> tweak kernel.sched_min_granularity_ns

Yeah, can't say I care. I suppose some people with PREEMPT=n kernels
increase that to make their server workloads 'go fast'. But I'll
absolutely suck rock on anything desktop.

These knobs really shouldn't have been as widely available as they are.

And guides, well, the writes have to earn a living too, right.

> Whether there are legimiate reasons to modify those values or not,
> removing them may generate fun bug reports.

Which I'll close with -EDONTCARE, userspace has to cope with
SCHED_DEBUG=n in any case.
