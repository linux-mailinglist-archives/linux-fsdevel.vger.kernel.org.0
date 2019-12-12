Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8749F11CDE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 14:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfLLNNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 08:13:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39838 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbfLLNNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mi/YeA+WCgrkkaP3IUCQ5eXMERR2u2J8/KyXlUMxhsE=; b=S2gx1qRERPnBJWKB6odU0gfHJ
        Io+0i7BKBcpoqwishvDmCIx3U83XeZEDzTtyk6o/vY4WNhGGpgMr33r5Xkz8KxPkZmbYkbtLZJdf6
        2H6hG7zJ8uGDO1IquD+xfTW59+narXHB94w5Wz2UVpIVt2sYSUk9jQl/b4nolTM+jgLeg0EKj3f6y
        DcPRlxcpeHAajXYpMtSHKKGRmWMf/vZIDRXY6u5NL14xRMK3JA0gTQvQeEAWDq1GlXYbTTJJUxmp7
        cB3HVp7jTpLleY90VXPi2wTeWEZf5xARINmVaSAPeUXFONfryGgbC+Db61Pu2vV404tywa77Hws7M
        h9/plfWpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifOGw-0000yE-7k; Thu, 12 Dec 2019 13:12:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C9107300F29;
        Thu, 12 Dec 2019 14:11:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D801203BF6F0; Thu, 12 Dec 2019 14:12:47 +0100 (CET)
Date:   Thu, 12 Dec 2019 14:12:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4] sched/core: Preempt current task in favour of bound
 kthread
Message-ID: <20191212131247.GY2827@hirez.programming.kicks-ass.net>
References: <20191209165122.GA27229@linux.vnet.ibm.com>
 <20191209231743.GA19256@dread.disaster.area>
 <20191210054330.GF27253@linux.vnet.ibm.com>
 <20191210172307.GD9139@linux.vnet.ibm.com>
 <20191211173829.GB21797@linux.vnet.ibm.com>
 <20191211224617.GE19256@dread.disaster.area>
 <20191212101031.GV2827@hirez.programming.kicks-ass.net>
 <20191212101424.GH2871@hirez.programming.kicks-ass.net>
 <20191212102327.GI2871@hirez.programming.kicks-ass.net>
 <CAKfTPtCUm5vuvNiWszJ5tWHxmcZ2v_KexOxnBHLUkBcqC-P3fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCUm5vuvNiWszJ5tWHxmcZ2v_KexOxnBHLUkBcqC-P3fw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 12:20:01PM +0100, Vincent Guittot wrote:
> On Thu, 12 Dec 2019 at 11:23, Peter Zijlstra <peterz@infradead.org> wrote:

> > Just for giggles, that'd look something like:
> >
> >         while (!entity_is_task(se) {
> >                 cfs_rq = group_cfs_rq(se);
> >                 se = pick_next_entity(cfs_rq, cfs_rq->curr);
> >         }
> >         p = task_of(se);
> >
> >         if (is_per_cpu_kthread(p))
> >                 ideal_runtime /= 2;
> >
> > the core-scheduling patch set includes the right primitive for this I
> > think, pick_task_fair().
> 
> why not only updating wan_gran() which is the only function which uses
> sysctl_sched_wakeup_granularity ?

I don't see how, it works on se, which need not be a task.

> For per cpu kthread, we could set the gran to sched_min_granularity
> instead of scaling it with thread's priority so per cpu kthread can
> still preempt current ask even if sysctl_sched_wakeup_granularity is
> large

Also, we're not poking at wakeup preemption anymore. That, as explained
by Dave, is not the right thing to do. What we want instead is to make
tick preemption a little more agressive.

And tick based preemption currently purely looks at the leftmost entity
for each runqueue we find while iterating current. IE, it might never
even see the task we tagged with next.

Also, did I say I hates cgroups :-)
