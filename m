Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985FD2834D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJELTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 07:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJELTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:19:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED0C0613CE;
        Mon,  5 Oct 2020 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ra1YPs5Ur9GmtKp6lL+9W2Oo4CFvG8xsosvNRMWmnLY=; b=V66/orP3bwMW/YEzkQN47EHpD0
        ZHYBKXwFpZjN1JhOy9tkZOghvamu5T3Xn0IC3/1aT+Ov6tncf/sfxBH43pTa8WPtZ9mE6bv4Dpkrs
        2ll0hJz5kXjlhB29PBgIL9r0MHsTl5moUvqWlCgs69PnX/c3lK2Mq1pXoB8WMUrmlouauK1PHtFSb
        9ZIBHXKXEvl82+Tyy6wPJeNLYf1gPAFbY331j42cE1K5aZaFBJegF5nzybQs3ZqTdT5M35NKUSAzJ
        uncFb5gRUMbtuwwcwEfLS/EI+pEaVfSJPsPTJWUBds9Kb1Z6FKddw+lVuhGZ6XPsNhf44tduhmXoh
        NiQh4hmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPOWZ-0006Pv-K0; Mon, 05 Oct 2020 11:19:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8C17300B22;
        Mon,  5 Oct 2020 13:19:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE5B020C19001; Mon,  5 Oct 2020 13:19:20 +0200 (CEST)
Date:   Mon, 5 Oct 2020 13:19:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xi Wang <xii@google.com>
Cc:     Paul Turner <pjt@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
Message-ID: <20201005111920.GO2611@hirez.programming.kicks-ass.net>
References: <20200304213941.112303-1-xii@google.com>
 <20200305075742.GR2596@hirez.programming.kicks-ass.net>
 <CAPM31RJdNtxmOi2eeRYFyvRKG9nofhqZfPgZGA5U7u8uZ2WXwA@mail.gmail.com>
 <20200306084039.GC12561@hirez.programming.kicks-ass.net>
 <CAOBoifiWWcodi9HddxVsKUahTSdAS5OiQOcapDJ-4p+HufRzeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBoifiWWcodi9HddxVsKUahTSdAS5OiQOcapDJ-4p+HufRzeQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 02:34:20PM -0800, Xi Wang wrote:
> On Fri, Mar 6, 2020 at 12:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Mar 05, 2020 at 02:11:49PM -0800, Paul Turner wrote:
> > > The goal is to improve jitter since we're constantly periodically
> > > preempting other classes to run the watchdog.   Even on a single CPU
> > > this is measurable as jitter in the us range.  But, what increases the
> > > motivation is this disruption has been recently magnified by CPU
> > > "gifts" which require evicting the whole core when one of the siblings
> > > schedules one of these watchdog threads.
> > >
> > > The majority outcome being asserted here is that we could actually
> > > exercise pick_next_task if required -- there are other potential
> > > things this will catch, but they are much more braindead generally
> > > speaking (e.g. a bug in pick_next_task itself).
> >
> > I still utterly hate what the patch does though; there is no way I'll
> > have watchdog code hook in the scheduler like this. That's just asking
> > for trouble.
> >
> > Why isn't it sufficient to sample the existing context switch counters
> > from the watchdog? And why can't we fix that?
> 
> We could go to pick next and repick the same task. There won't be a
> context switch but we still want to hold the watchdog. I assume such a
> counter also needs to be per cpu and inside the rq lock. There doesn't
> seem to be an existing one that fits this purpose.

Sorry, your reply got lost, but I just ran into something that reminded
me of this.

There's sched_count. That's currently schedstat, but if you can find a
spot in a hot cacheline (from schedule()'s perspective) then it
should be cheap to incremenent unconditionally.

If only someone were to write a useful cacheline perf tool (and no that
c2c trainwreck doesn't count).

