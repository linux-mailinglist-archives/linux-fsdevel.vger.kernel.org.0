Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3664CB513
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 03:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiCCCdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 21:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiCCCd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:33:29 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87AD636C;
        Wed,  2 Mar 2022 18:32:40 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2232WZQO020612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Mar 2022 21:32:36 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7634315C0038; Wed,  2 Mar 2022 21:32:35 -0500 (EST)
Date:   Wed, 2 Mar 2022 21:32:35 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Jan Kara <jack@suse.cz>, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.com, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report 2 in ext4 and journal based on v5.17-rc1
Message-ID: <YiAow5gi21zwUT54@mit.edu>
References: <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-2-git-send-email-byungchul.park@lge.com>
 <20220221190204.q675gtsb6qhylywa@quack3.lan>
 <20220223003534.GA26277@X58A-UD3R>
 <20220223144859.na2gjgl5efgw5zhn@quack3.lan>
 <20220224011102.GA29726@X58A-UD3R>
 <20220224102239.n7nzyyekuacgpnzg@quack3.lan>
 <20220228092826.GA5201@X58A-UD3R>
 <20220228101444.6frl63dn5vmgycbp@quack3.lan>
 <20220303010033.GB20752@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303010033.GB20752@X58A-UD3R>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 03, 2022 at 10:00:33AM +0900, Byungchul Park wrote:
> 
> Unfortunately, it's neither perfect nor safe without another wakeup
> source - rescue wakeup source.
> 
>    consumer			producer
> 
> 				lock L
> 				(too much work queued == true)
> 				unlock L
> 				--- preempted
>    lock L
>    unlock L
>    do work
>    lock L
>    unlock L
>    do work
>    ...
>    (no work == true)
>    sleep
> 				--- scheduled in
> 				sleep

That's not how things work in ext4.  It's **way** more complicated
than that.  We have multiple wait channels, one wake up the consumer
(read: the commit thread), and one which wakes up any processes
waiting for commit thread to have made forward progress.  We also have
two spin-lock protected sequence number, one which indicates the
current commited transaction #, and one indicating the transaction #
that needs to be committed.

On the commit thread, it will sleep on j_wait_commit, and when it is
woken up, it will check to see if there is work to be done
(j_commit_sequence != j_commit_request), and if so, do the work, and
then wake up processes waiting on the wait_queue j_wait_done_commit.
(Again, all of this uses the pattern, "prepare to wait", then check to
see if we should sleep, if we do need to sleep, unlock j_state_lock,
then sleep.   So this prevents any races leading to lost wakeups.

On the start_this_handle() thread, if we current transaction is too
full, we set j_commit_request to its transaction id to indicate that
we want the current transaction to be committed, and then we wake up
the j_wait_commit wait queue and then we enter a loop where do a
prepare_to_wait in j_wait_done_commit, check to see if
j_commit_sequence == the transaction id that we want to be completed,
and if it's not done yet, we unlock the j_state_lock spinlock, and go
to sleep.  Again, because of the prepare_to_wait, there is no chance
of a lost wakeup.

So there really is no "consumer" and "producer" here.  If you really
insist on using this model, which really doesn't apply, for one
thread, it's the consumer with respect to one wait queue, and the
producer with respect to the *other* wait queue.  For the other
thread, the consumer and producer roles are reversed.

And of course, this is a highly simplified model, since we also have a
wait queue used by the commit thread to wait for the number of active
handles on a particular transaction to go to zero, and
stop_this_handle() will wake up commit thread via this wait queue when
the last active handle on a particular transaction is retired.  (And
yes, that parameter is also protected by a different spin lock which
is per-transaction).

So it seems to me that a fundamental flaw in DEPT's model is assuming
that the only waiting paradigm that can be used is consumer/producer,
and that's simply not true.  The fact that you use the term "lock" is
also going to lead a misleading line of reasoning, because properly
speaking, they aren't really locks.  We are simply using wait channels
to wake up processes as necessary, and then they will check other
variables to decide whether or not they need to sleep or not, and we
have an invariant that when these variables change indicating forward
progress, the associated wait channel will be woken up.

Cheers,

						- Ted


P.S.  This model is also highly simplified since there are other
reasons why the commit thread can be woken up, some which might be via
a timeout, and some which is via the j_wait_commit wait channel but
not because j_commit_request has been changed, but because file system
is being unmounted, or the file system is being frozen in preparation
of a snapshot, etc.  These are *not* necessary to prevent a deadlock,
because under normal circumstances the two wake channels are
sufficient of themselves.  So please don't think of them as "rescue
wakeup sources"; again, that's highly misleading and the wrong way to
think of them.

And to make things even more complicated, we have more than 2 wait
channel --- we have *five*:

	/**
	 * @j_wait_transaction_locked:
	 *
	 * Wait queue for waiting for a locked transaction to start committing,
	 * or for a barrier lock to be released.
	 */
	wait_queue_head_t	j_wait_transaction_locked;

	/**
	 * @j_wait_done_commit: Wait queue for waiting for commit to complete.
	 */
	wait_queue_head_t	j_wait_done_commit;

	/**
	 * @j_wait_commit: Wait queue to trigger commit.
	 */
	wait_queue_head_t	j_wait_commit;

	/**
	 * @j_wait_updates: Wait queue to wait for updates to complete.
	 */
	wait_queue_head_t	j_wait_updates;

	/**
	 * @j_wait_reserved:
	 *
	 * Wait queue to wait for reserved buffer credits to drop.
	 */
	wait_queue_head_t	j_wait_reserved;

	/**
	 * @j_fc_wait:
	 *
	 * Wait queue to wait for completion of async fast commits.
	 */
	wait_queue_head_t	j_fc_wait;


"There are more things in heaven and Earth, Horatio,
 Than are dreamt of in your philosophy."
      	  	    - William Shakespeare, Hamlet
