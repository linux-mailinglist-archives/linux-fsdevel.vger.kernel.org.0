Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED4A2558E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 12:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgH1KwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgH1KwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:52:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D0EC061264;
        Fri, 28 Aug 2020 03:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NVsLC6w+b0vPj3ocKxPMrHUORIUcuSQwIXmvRtgL1Mg=; b=Hsnh0uaWdwDg7CiUZiC+XRNSSr
        9+FWzk4luqqDW2WldQfT+xZ1AGDWS49v6tNPBQNhoKe+BX9AS7E5Z0qqgBOrD6F9kzbGVVMYszK6c
        E0IdOP6uHNZyoAC0Ex6aRwewJFLAofDnlZ3GMssDsyAdANDMOZSyT+U3SE4QUTrU8X1YA3MGexa4f
        dzchMgs+m4mxxdPw+vUDvvYgPqoaLhfl+EILDevPJCbePT6M5GC+Bw+81rjw5HON4/uHpWwMLD09U
        vSAP1QswtjIQeBfFPOEWP0Fv7zyCXnvYvIpovkrimkhV4S58j/diluW9va8tdtRrol0bypigERuAG
        866fIpeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBbz9-0003pI-Jw; Fri, 28 Aug 2020 10:51:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A60233007CD;
        Fri, 28 Aug 2020 12:51:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F91E2C56E661; Fri, 28 Aug 2020 12:51:53 +0200 (CEST)
Date:   Fri, 28 Aug 2020 12:51:53 +0200
From:   peterz@infradead.org
To:     Jan Kara <jack@suse.cz>
Cc:     Xianting Tian <tian.xianting@h3c.com>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        hannes@cmpxchg.org
Subject: Re: [PATCH] aio: make aio wait path to account iowait time
Message-ID: <20200828105153.GV1362448@hirez.programming.kicks-ass.net>
References: <20200828060712.34983-1-tian.xianting@h3c.com>
 <20200828090729.GT1362448@hirez.programming.kicks-ass.net>
 <20200828094129.GF7072@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828094129.GF7072@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 11:41:29AM +0200, Jan Kara wrote:
> On Fri 28-08-20 11:07:29, peterz@infradead.org wrote:
> > On Fri, Aug 28, 2020 at 02:07:12PM +0800, Xianting Tian wrote:
> > > As the normal aio wait path(read_events() ->
> > > wait_event_interruptible_hrtimeout()) doesn't account iowait time, so use
> > > this patch to make it to account iowait time, which can truely reflect
> > > the system io situation when using a tool like 'top'.
> > 
> > Do be aware though that io_schedule() is potentially far more expensive
> > than regular schedule() and io-wait accounting as a whole is a
> > trainwreck.
> 
> Hum, I didn't know that io_schedule() is that much more expensive. Thanks
> for info.

It's all relative, but it can add up under contention. And since these
storage thingies are getting faster every year, I'm assuming these
schedule rates are increasing along with it.

> > When in_iowait is set schedule() and ttwu() will have to do additional
> > atomic ops, and (much) worse, PSI will take additional locks.
> > 
> > And all that for a number that, IMO, is mostly useless, see the comment
> > with nr_iowait().
> 
> Well, I understand the limited usefulness of the system or even per CPU
> percentage spent in IO wait. However whether a particular task is sleeping
> waiting for IO or not

So strict per-task state is not a problem, and we could easily change
get_task_state() to distinguish between IO-wait or not, basically
duplicate S/D state into an IO-wait variant of the same. Although even
this has ABI implications :-(

> is IMO a useful diagnostic information and there are
> several places in the kernel that take that into account (PSI, hangcheck
> timer, cpufreq, ...).

So PSI is the one I hate most. We spend an aweful lot of time to not
have to take the old rq->lock on wakeup, and PSI reintroduced it for
accounting purposes -- I hate accounting overhead. :/

There's a number of high frequency scheduling workloads where it really
adds up, which is the reason we got rid of it in the first place.

OTOH, PSI gives more sensible numbers, although it goes side-ways when
you introduce affinity masks / cpusets.

The menu-cpufreq gov is known crazy and we're all hard working on
replacing it.

And the tick-sched usage is, iirc, the nohz case of iowait.

> So I don't see that properly accounting that a task
> is waiting for IO is just "expensive random number generator" as you
> mention below :). But I'm open to being educated...

It's the userspace iowait, and in particular the per-cpu iowait numbers
that I hate. Only on UP does any of that make sense.

But we can't remove them because ABI :-(

