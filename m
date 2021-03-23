Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A913464DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 17:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhCWQVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 12:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhCWQUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:20:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD964C061574;
        Tue, 23 Mar 2021 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LsoqY/Vbr0roq3HT0l6ahhm+8UPgKl2dxZXa/dA+n00=; b=qZhDkGk/Yszs1506UIx2iBE83r
        duVI5h9Vycel+gut4I4mlE//20ppU2tCFzmGiwQbH45zimKDUNsJwYpQ/GqpJKfmxJCJuEn+hnmfa
        vyUlZ84lyjhnfDDE2x72ig+YvyPdh6Uw0JMosEhnDOvdMW0MA0staU1/IlJhWQ+9qU1eOgdST9NgF
        P8jXgLxPBYCYnhR8nxTk9Tt5+IEN+9S8bcJR4WdkqJG+5WQIn6wcBs0up/QLY7JnvlPT5hKb/e9gn
        jtlP3qeXa1pTHA+8XKLXlQaORk8Ax2lLkj6KS+O6nXyQxZdVdMPl9rXB1qb5SiC3oUi8vNhOC5/NG
        u+F8plSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOjkj-00AGgi-S7; Tue, 23 Mar 2021 16:19:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C53EF301A7A;
        Tue, 23 Mar 2021 17:19:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FF7625E587B4; Tue, 23 Mar 2021 17:19:32 +0100 (CET)
Date:   Tue, 23 Mar 2021 17:19:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, glider@google.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, christian@brauner.io,
        dvyukov@google.com, jannh@google.com, axboe@kernel.dk,
        mascasa@google.com, pcc@google.com, irogers@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 8/8] selftests/perf: Add kselftest for
 remove_on_exec
Message-ID: <YFoVFM+xltCUGR/Q@hirez.programming.kicks-ass.net>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com>
 <YFjI5qU0z3Q7J/jF@hirez.programming.kicks-ass.net>
 <YFm6aakSRlF2nWtu@elver.google.com>
 <YFnDo7dczjDzLP68@hirez.programming.kicks-ass.net>
 <YFn/I3aKF+TOjGcl@hirez.programming.kicks-ass.net>
 <YFoQLfsZXPn9zuT4@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFoQLfsZXPn9zuT4@elver.google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 04:58:37PM +0100, Marco Elver wrote:
> On Tue, Mar 23, 2021 at 03:45PM +0100, Peter Zijlstra wrote:
> > On Tue, Mar 23, 2021 at 11:32:03AM +0100, Peter Zijlstra wrote:
> > > And at that point there's very little value in still using
> > > perf_event_exit_event()... let me see if there's something to be done
> > > about that.
> > 
> > I ended up with something like the below. Which then simplifies
> > remove_on_exec() to:
> > 
> [...]
> > 
> > Very lightly tested with that {1..1000} thing.
> > 
> > ---
> > 
> > Subject: perf: Rework perf_event_exit_event()
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Tue Mar 23 15:16:06 CET 2021
> > 
> > Make perf_event_exit_event() more robust, such that we can use it from
> > other contexts. Specifically the up and coming remove_on_exec.
> > 
> > For this to work we need to address a few issues. Remove_on_exec will
> > not destroy the entire context, so we cannot rely on TASK_TOMBSTONE to
> > disable event_function_call() and we thus have to use
> > perf_remove_from_context().
> > 
> > When using perf_remove_from_context(), there's two races to consider.
> > The first is against close(), where we can have concurrent tear-down
> > of the event. The second is against child_list iteration, which should
> > not find a half baked event.
> > 
> > To address this, teach perf_remove_from_context() to special case
> > !ctx->is_active and about DETACH_CHILD.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Very nice, thanks! It seems to all hold up to testing as well.
> 
> Unless you already have this on some branch somewhere, I'll prepend it
> to the series for now. I'll test some more and try to get v3 out
> tomorrow.

I have not queued it, so please keep it in your series so it stays
together (and tested).

Thanks!
