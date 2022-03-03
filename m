Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477624CBAC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 10:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiCCJzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 04:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiCCJzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:55:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F015DB21;
        Thu,  3 Mar 2022 01:54:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C67C71F37E;
        Thu,  3 Mar 2022 09:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646301296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KiLPRDgQGgCu2x95n4UY9Dv1EwVeQLnpZJzpbHdZ9dI=;
        b=1mPxOqNUPjUuRYvM1Jpo88uvj7mHeU0BtX8fI9JJJRyDkVeAKsX335KbaBabw8d3WKe9mU
        HuHiRKWaMepp0G+heG7qzF8nwvdSA7m1dmz7EoPucjPZWYPll95EJxKZn0hqiwT3u8aCta
        gH+QFjpVR9+bskkk3c37kR52I+BOsWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646301296;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KiLPRDgQGgCu2x95n4UY9Dv1EwVeQLnpZJzpbHdZ9dI=;
        b=eSm/KdUai1TPHgQyeg2sJYQkesKT0CqEB9zHNh7ZllJwzw7iMPjlHqVf2VPb2/UGEWSCsY
        8Lo2iLDGhVjto/Bw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5EF4CA3B81;
        Thu,  3 Mar 2022 09:54:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5F3F6A0604; Thu,  3 Mar 2022 10:54:56 +0100 (CET)
Date:   Thu, 3 Mar 2022 10:54:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Jan Kara <jack@suse.cz>, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.com, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report 2 in ext4 and journal based on v5.17-rc1
Message-ID: <20220303095456.kym32pxshwryescx@quack3.lan>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-03-22 10:00:33, Byungchul Park wrote:
> On Mon, Feb 28, 2022 at 11:14:44AM +0100, Jan Kara wrote:
> > On Mon 28-02-22 18:28:26, Byungchul Park wrote:
> > > case 1. Code with an actual circular dependency, but not deadlock.
> > > 
> > >    A circular dependency can be broken by a rescue wakeup source e.g.
> > >    timeout. It's not a deadlock. If it's okay that the contexts
> > >    participating in the circular dependency and others waiting for the
> > >    events in the circle are stuck until it gets broken. Otherwise, say,
> > >    if it's not meant, then it's anyway problematic.
> > > 
> > >    1-1. What if we judge this code is problematic?
> > >    1-2. What if we judge this code is good?
> > > 
> > > case 2. Code with an actual circular dependency, and deadlock.
> > > 
> > >    There's no other wakeup source than those within the circular
> > >    dependency. Literally deadlock. It's problematic and critical.
> > > 
> > >    2-1. What if we judge this code is problematic?
> > >    2-2. What if we judge this code is good?
> > > 
> > > case 3. Code with no actual circular dependency, and not deadlock.
> > > 
> > >    Must be good.
> > > 
> > >    3-1. What if we judge this code is problematic?
> > >    3-2. What if we judge this code is good?
> > > 
> > > ---
> > > 
> > > I call only 3-1 "false positive" circular dependency. And you call 1-1
> > > and 3-1 "false positive" deadlock.
> > > 
> > > I've been wondering if the kernel guys esp. Linus considers code with
> > > any circular dependency is problematic or not, even if it won't lead to
> > > a deadlock, say, case 1. Even though I designed Dept based on what I
> > > believe is right, of course, I'm willing to change the design according
> > > to the majority opinion.
> > > 
> > > However, I would never allow case 1 if I were the owner of the kernel
> > > for better stability, even though the code works anyway okay for now.
> > 
> > So yes, I call a report for the situation "There is circular dependency but
> > deadlock is not possible." a false positive. And that is because in my
> > opinion your definition of circular dependency includes schemes that are
> > useful and used in the kernel.
> > 
> > Your example in case 1 is kind of borderline (I personally would consider
> > that bug as well) but there are other more valid schemes with multiple
> > wakeup sources like:
> > 
> > We have a queue of work to do Q protected by lock L. Consumer process has
> > code like:
> > 
> > while (1) {
> > 	lock L
> > 	prepare_to_wait(work_queued);
> > 	if (no work) {
> > 		unlock L
> > 		sleep
> > 	} else {
> > 		unlock L
> > 		do work
> > 		wake_up(work_done)
> > 	}
> > }
> > 
> > AFAIU Dept will create dependency here that 'wakeup work_done' is after
> > 'wait for work_queued'. Producer has code like:
> 
> First of all, thank you for this good example.
> 
> > while (1) {
> > 	lock L
> > 	prepare_to_wait(work_done)
> > 	if (too much work queued) {
> > 		unlock L
> > 		sleep
> > 	} else {
> > 		queue work
> > 		unlock L
> > 		wake_up(work_queued)
> > 	}
> > }
> > 
> > And Dept will create dependency here that 'wakeup work_queued' is after
> > 'wait for work_done'. And thus we have a trivial cycle in the dependencies
> > despite the code being perfectly valid and safe.
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
> 
> This code leads a deadlock without another wakeup source, say, not safe.

So the scenario you describe above is indeed possible. But the trick is
that the wakeup from 'consumer' as is doing work will remove 'producer'
from the wait queue and change the 'producer' process state to
'TASK_RUNNING'. So when 'producer' calls sleep (in fact schedule()), the
scheduler will just treat this as another preemption point and the
'producer' will immediately or soon continue to run. So indeed we can think
of this as "another wakeup source" but the source is in the CPU scheduler
itself. This is the standard way how waitqueues are used in the kernel...

> Lastly, just for your information, I need to explain how Dept works a
> little more for you not to misunderstand Dept.
> 
> Assuming the consumer and producer guarantee not to lead a deadlock like
> the following, Dept won't report it a problem:
> 
>    consumer			producer
> 
> 				sleep
>    wakeup work_done
> 				queue work
>    sleep
> 				wakeup work_queued
>    do work
> 				sleep
>    wakeup work_done
> 				queue work
>    sleep
> 				wakeup work_queued
>    do work
> 				sleep
>    ...				...
> 
> Dept does not consider all waits preceeding an event but only waits that
> might lead a deadlock. In this case, Dept works with each region
> independently.
> 
>    consumer			producer
> 
> 				sleep <- initiates region 1
>    --- region 1 starts
>    ...				...
>    --- region 1 ends
>    wakeup work_done
>    ...				...
> 				queue work
>    ...				...
>    sleep <- initiates region 2
> 				--- region 2 starts
>    ...				...
> 				--- region 2 ends
> 				wakeup work_queued
>    ...				...
>    do work
>    ...				...
> 				sleep <- initiates region 3
>    --- region 3 starts
>    ...				...
>    --- region 3 ends
>    wakeup work_done
>    ...				...
> 				queue work
>    ...				...
>    sleep <- initiates region 4
> 				--- region 4 starts
>    ...				...
> 				--- region 4 ends
> 				wakeup work_queued
>    ...				...
>    do work
>    ...				...
> 
> That is, Dept does not build dependencies across different regions. So
> you don't have to worry about unreasonable false positives that much.
> 
> Thoughts?

Thanks for explanation! And what exactly defines the 'regions'? When some
process goes to sleep on some waitqueue, this defines a start of a region
at the place where all the other processes are at that moment and wakeup of
the waitqueue is an end of the region?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
