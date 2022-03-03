Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1A64CB62E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 06:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiCCFYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 00:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiCCFYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 00:24:43 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4CC0F4D1C
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 21:23:57 -0800 (PST)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 3 Mar 2022 14:23:55 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 3 Mar 2022 14:23:55 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     tytso@mit.edu
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report 2 in ext4 and journal based on v5.17-rc1
Date:   Thu,  3 Mar 2022 14:23:33 +0900
Message-Id: <1646285013-3934-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <YiAow5gi21zwUT54@mit.edu>
References: <YiAow5gi21zwUT54@mit.edu>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ted wrote:
> On Thu, Mar 03, 2022 at 10:00:33AM +0900, Byungchul Park wrote:
> > 
> > Unfortunately, it's neither perfect nor safe without another wakeup
> > source - rescue wakeup source.
> > 
> >    consumer			producer
> > 
> >				lock L
> >				(too much work queued == true)
> >				unlock L
> >				--- preempted
> >    lock L
> >    unlock L
> >    do work
> >    lock L
> >    unlock L
> >    do work
> >    ...
> >    (no work == true)
> >    sleep
> >				--- scheduled in
> >				sleep
> 
> That's not how things work in ext4.  It's **way** more complicated

You seem to get it wrong. This example is what Jan Kara gave me. I just
tried to explain things based on Jan Kara's example so leaving all
statements that Jan Kara wrote. Plus the example was so helpful. Thanks,
Jan Kara.

> than that.  We have multiple wait channels, one wake up the consumer
> (read: the commit thread), and one which wakes up any processes
> waiting for commit thread to have made forward progress.  We also have
> two spin-lock protected sequence number, one which indicates the
> current commited transaction #, and one indicating the transaction #
> that needs to be committed.
> 
> On the commit thread, it will sleep on j_wait_commit, and when it is
> woken up, it will check to see if there is work to be done
> (j_commit_sequence != j_commit_request), and if so, do the work, and
> then wake up processes waiting on the wait_queue j_wait_done_commit.
> (Again, all of this uses the pattern, "prepare to wait", then check to
> see if we should sleep, if we do need to sleep, unlock j_state_lock,
> then sleep.   So this prevents any races leading to lost wakeups.
> 
> On the start_this_handle() thread, if we current transaction is too
> full, we set j_commit_request to its transaction id to indicate that
> we want the current transaction to be committed, and then we wake up
> the j_wait_commit wait queue and then we enter a loop where do a
> prepare_to_wait in j_wait_done_commit, check to see if
> j_commit_sequence == the transaction id that we want to be completed,
> and if it's not done yet, we unlock the j_state_lock spinlock, and go
> to sleep.  Again, because of the prepare_to_wait, there is no chance
> of a lost wakeup.

The above explantion gives me a clear view about synchronization of
journal things. I appreciate it.

> So there really is no "consumer" and "producer" here.  If you really
> insist on using this model, which really doesn't apply, for one

Dept does not assume "consumer" and "producer" model at all, but Dept
works with general waits and events. *That model is just one of them.*

> thread, it's the consumer with respect to one wait queue, and the
> producer with respect to the *other* wait queue.  For the other
> thread, the consumer and producer roles are reversed.
> 
> And of course, this is a highly simplified model, since we also have a
> wait queue used by the commit thread to wait for the number of active
> handles on a particular transaction to go to zero, and
> stop_this_handle() will wake up commit thread via this wait queue when
> the last active handle on a particular transaction is retired.  (And
> yes, that parameter is also protected by a different spin lock which
> is per-transaction).

This one also gives me a clear view. Thanks a lot.

> So it seems to me that a fundamental flaw in DEPT's model is assuming
> that the only waiting paradigm that can be used is consumer/producer,

No, Dept does not.

> and that's simply not true.  The fact that you use the term "lock" is
> also going to lead a misleading line of reasoning, because properly

"lock/unlock L" comes from the Jan Kara's example. It has almost nothing
to do with the explanation. I just left "lock/unlock L" as a statement
that comes from the Jan Kara's example.

> speaking, they aren't really locks.  We are simply using wait channels

I totally agree with you. *They aren't really locks but it's just waits
and wakeups.* That's exactly why I decided to develop Dept. Dept is not
interested in locks unlike Lockdep, but fouces on waits and wakeup
sources itself. I think you get Dept wrong a lot. Please ask me more if
you have things you doubt about Dept.

Thanks,
Byungchul
