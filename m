Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50F21DDFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgGMQzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMQzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:55:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB39C061794;
        Mon, 13 Jul 2020 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HuDdCAe7E/MURwBsmW1Ls9iUs+3VUz9I3ziwdok6E+A=; b=LWb7VIGpl0H9u+jUhBSNqsfnkh
        bI7HOZD2MHbpne8P2z3FF2pANyq/O8ttXKz04u7N2xaiedmLEqGd7qOcFY968v9TUKHQcTqqL20Pj
        xg7dow/Qn1uV2dvTd1URZW80j6On7agD3JZkY64Vl13C7EVuq5rvK8R3oosHdsHeal3ejwztgJoAq
        QlFoNCgY1gQ5BnT1IW9JY3YBcnbg78ejezNjzOSS3rtMjNoBARVCMx5ckbwcX3Ig7VBuWikmnkQEI
        GBZE8bahcF2hRsRXOQeIN67F1ZxxHaiCnIX0mnSlZoZdfbE0vIseds6GoqtLPbjxMMHoM7S1LZr7s
        ro7N6bwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jv1jA-00043K-2o; Mon, 13 Jul 2020 16:54:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E60EE303A02;
        Mon, 13 Jul 2020 18:54:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCBF020D28BB0; Mon, 13 Jul 2020 18:54:49 +0200 (CEST)
Date:   Mon, 13 Jul 2020 18:54:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Doug Anderson <dianders@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200713165449.GM10769@hirez.programming.kicks-ass.net>
References: <20200706142839.26629-1-qais.yousef@arm.com>
 <20200706142839.26629-2-qais.yousef@arm.com>
 <20200713112125.GG10769@hirez.programming.kicks-ass.net>
 <20200713121246.xjif3g4zpja25o5r@e107158-lin.cambridge.arm.com>
 <20200713133558.GK10769@hirez.programming.kicks-ass.net>
 <20200713142754.tri5jljnrzjst2oe@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713142754.tri5jljnrzjst2oe@e107158-lin.cambridge.arm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:27:55PM +0100, Qais Yousef wrote:
> On 07/13/20 15:35, Peter Zijlstra wrote:
> > > I protect this with rcu_read_lock() which as far as I know synchronize_rcu()
> > > will ensure if we do the update during this section; we'll wait for it to
> > > finish. New forkees entering the rcu_read_lock() section will be okay because
> > > they should see the new value.
> > > 
> > > spinlocks() and mutexes seemed inferior to this approach.
> > 
> > Well, didn't we just write in another patch that p->uclamp_* was
> > protected by both rq->lock and p->pi_lock?
> 
> __setscheduler_uclamp() path is holding these locks, not sure by design or it
> just happened this path holds the lock. I can't see the lock in the
> uclamp_fork() path. But it's hard sometimes to unfold the layers of callers,
> especially not all call sites are annotated for which lock is assumed to be
> held.
> 
> Is it safe to hold the locks in uclamp_fork() while the task is still being
> created? My new code doesn't hold it of course.
> 
> We can enforce this rule if you like. Though rcu critical section seems lighter
> weight to me.
> 
> If all of this does indeed start looking messy we can put the update in
> a delayed worker and schedule that instead of doing synchronous setup.

sched_fork() doesn't need the locks, because at that point the task
isn't visible yet. HOWEVER, sched_post_fork() is after pid-hash (per
design) and thus the task is visible, so we can race against
sched_setattr(), so we'd better hold those locks anyway.
