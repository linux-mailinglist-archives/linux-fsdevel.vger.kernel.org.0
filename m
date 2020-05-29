Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA391E8360
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 18:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgE2QPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 12:15:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58682 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2QPb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 12:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xKE4iU4tL+hNaGx/FSTJV5asiZmclaundn7b5eVYaJA=; b=V2vJfvPFWaLSd/C8i8efXx0Oae
        8eabsyjI/uaqb/8MWLPjD2t7RHs6xqCboxmyOZvHENqIOnPQ9SITwT+8+nrq+etzD4SDYffWmv9uG
        RBw6KKbt6WdM9PofbYUY1/XPERVENziT80bPAeONAW7O/EnmRvpDPjiQ0N9K/LkHWaQnn2EkfkLeF
        VhGKawKxETn6Bk0ZOXhohHvuang7C6oCETIY7kIELtmWZh2HZhrYMeHn5c6OawEHV9NvFn8CjEnWP
        1SnJlGWzCwlGglVUV/kJtIkWGnwmOQt8yOfx2qAvuP3zREApQz9oZm/lYFW7TMbJws6Bio4+zLwME
        bIrqxtjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jehct-0000rm-3K; Fri, 29 May 2020 16:12:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A7AC30047A;
        Fri, 29 May 2020 18:12:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 418422BABEA78; Fri, 29 May 2020 18:12:53 +0200 (CEST)
Date:   Fri, 29 May 2020 18:12:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: mmotm 2020-05-13-20-30 uploaded (objtool warnings)
Message-ID: <20200529161253.GD706460@hirez.programming.kicks-ass.net>
References: <20200514033104.kRFL_ctMQ%akpm@linux-foundation.org>
 <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
 <20200528172005.GP2483@worktop.programming.kicks-ass.net>
 <20200529135750.GA1580@lst.de>
 <20200529143556.GE706478@hirez.programming.kicks-ass.net>
 <20200529145325.GB706518@hirez.programming.kicks-ass.net>
 <20200529153336.GC706518@hirez.programming.kicks-ass.net>
 <20200529160514.cyaytn33thphb3tz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529160514.cyaytn33thphb3tz@treble>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 11:05:14AM -0500, Josh Poimboeuf wrote:

> It looks to me like GCC is doing the right thing.  That likely()
> translates to:
> 
> #  define likely(x)	(__branch_check__(x, 1, __builtin_constant_p(x)))
> 
> which becomes:
> 
> #define __branch_check__(x, expect, is_constant) ({			\
> 			long ______r;					\
> 			static struct ftrace_likely_data		\
> 				__aligned(4)				\
> 				__section(_ftrace_annotated_branch)	\
> 				______f = {				\
> 				.data.func = __func__,			\
> 				.data.file = __FILE__,			\
> 				.data.line = __LINE__,			\
> 			};						\
> 			______r = __builtin_expect(!!(x), expect);	\
> 			ftrace_likely_update(&______f, ______r,		\
> 					     expect, is_constant);	\
> 			______r;					\
> 		})
> 
> Here 'x' is the call to user_access_begin().  It evaluates 'x' -- and
> thus calls user_access_begin() -- before the call to
> ftrace_likely_update().
> 
> So it's working as designed, right?  The likely() just needs to be
> changed to likely_notrace().

But if !x (ie we fail user_access_begin()), we should not pass STAC() on
the way to out_err. OTOH if x, we should not be jumping to out_err.

I'm most confused... must not stare at asm for a while.
