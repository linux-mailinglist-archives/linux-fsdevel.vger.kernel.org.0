Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B34CCB72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 02:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiCDB6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 20:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiCDB6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:58:03 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5095017BC7B
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Mar 2022 17:57:14 -0800 (PST)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 4 Mar 2022 10:57:13 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 4 Mar 2022 10:57:13 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 4 Mar 2022 10:56:51 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Jan Kara <jack@suse.cz>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
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
Message-ID: <20220304015650.GC6112@X58A-UD3R>
References: <1645096204-31670-2-git-send-email-byungchul.park@lge.com>
 <20220221190204.q675gtsb6qhylywa@quack3.lan>
 <20220223003534.GA26277@X58A-UD3R>
 <20220223144859.na2gjgl5efgw5zhn@quack3.lan>
 <20220224011102.GA29726@X58A-UD3R>
 <20220224102239.n7nzyyekuacgpnzg@quack3.lan>
 <20220228092826.GA5201@X58A-UD3R>
 <20220228101444.6frl63dn5vmgycbp@quack3.lan>
 <20220303010033.GB20752@X58A-UD3R>
 <20220303095456.kym32pxshwryescx@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303095456.kym32pxshwryescx@quack3.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 03, 2022 at 10:54:56AM +0100, Jan Kara wrote:
> On Thu 03-03-22 10:00:33, Byungchul Park wrote:
> > Unfortunately, it's neither perfect nor safe without another wakeup
> > source - rescue wakeup source.
> > 
> >    consumer			producer
> > 
> > 				lock L
> > 				(too much work queued == true)
> > 				unlock L
> > 				--- preempted
> >    lock L
> >    unlock L
> >    do work
> >    lock L
> >    unlock L
> >    do work
> >    ...
> >    (no work == true)
> >    sleep
> > 				--- scheduled in
> > 				sleep
> > 
> > This code leads a deadlock without another wakeup source, say, not safe.
> 
> So the scenario you describe above is indeed possible. But the trick is
> that the wakeup from 'consumer' as is doing work will remove 'producer'
> from the wait queue and change the 'producer' process state to
> 'TASK_RUNNING'. So when 'producer' calls sleep (in fact schedule()), the
> scheduler will just treat this as another preemption point and the
> 'producer' will immediately or soon continue to run. So indeed we can think
> of this as "another wakeup source" but the source is in the CPU scheduler
> itself. This is the standard way how waitqueues are used in the kernel...

Nice! Thanks for the explanation. I will take it into account if needed.

> > Lastly, just for your information, I need to explain how Dept works a
> > little more for you not to misunderstand Dept.
> > 
> > Assuming the consumer and producer guarantee not to lead a deadlock like
> > the following, Dept won't report it a problem:
> > 
> >    consumer			producer
> > 
> > 				sleep
> >    wakeup work_done
> > 				queue work
> >    sleep
> > 				wakeup work_queued
> >    do work
> > 				sleep
> >    wakeup work_done
> > 				queue work
> >    sleep
> > 				wakeup work_queued
> >    do work
> > 				sleep
> >    ...				...
> > 
> > Dept does not consider all waits preceeding an event but only waits that
> > might lead a deadlock. In this case, Dept works with each region
> > independently.
> > 
> >    consumer			producer
> > 
> > 				sleep <- initiates region 1
> >    --- region 1 starts
> >    ...				...
> >    --- region 1 ends
> >    wakeup work_done
> >    ...				...
> > 				queue work
> >    ...				...
> >    sleep <- initiates region 2
> > 				--- region 2 starts
> >    ...				...
> > 				--- region 2 ends
> > 				wakeup work_queued
> >    ...				...
> >    do work
> >    ...				...
> > 				sleep <- initiates region 3
> >    --- region 3 starts
> >    ...				...
> >    --- region 3 ends
> >    wakeup work_done
> >    ...				...
> > 				queue work
> >    ...				...
> >    sleep <- initiates region 4
> > 				--- region 4 starts
> >    ...				...
> > 				--- region 4 ends
> > 				wakeup work_queued
> >    ...				...
> >    do work
> >    ...				...
> > 
> > That is, Dept does not build dependencies across different regions. So
> > you don't have to worry about unreasonable false positives that much.
> > 
> > Thoughts?
> 
> Thanks for explanation! And what exactly defines the 'regions'? When some
> process goes to sleep on some waitqueue, this defines a start of a region
> at the place where all the other processes are at that moment and wakeup of
> the waitqueue is an end of the region?

Yes. Let me explain it more for better understanding.
(I copied it from the talk I did with Matthew..)


   ideal view
   -----------
   context X			context Y

   request event E		...
      write REQUESTEVENT	when (notice REQUESTEVENT written)
   ...				   notice the request from X [S]

				--- ideally region 1 starts here
   wait for the event		...
      sleep			if (can see REQUESTEVENT written)
   				   it's on the way to the event
   ...				
   				...
				--- ideally region 1 ends here

				finally the event [E]

Dept basically works with the above view with regard to wait and event.
But it's very hard to identify the ideal [S] point in practice. So Dept
instead identifies [S] point by checking WAITSTART with memory barriers
like the following, which would make Dept work conservatively.


   Dept's view
   ------------
   context X			context Y

   request event E		...
      write REQUESTEVENT	when (notice REQUESTEVENT written)
   ...				   notice the request from X

				--- region 2 Dept gives up starts
   wait for the event		...
      write barrier
      write WAITSTART		read barrier
      sleep			when (notice WAITSTART written)
				   ensure the request has come [S]

				--- region 2 Dept gives up ends
				--- region 3 starts here
				...
				if (can see WAITSTART written)
				   it's on the way to the event
   ...				
   				...
				--- region 3 ends here

   				finally the event [E]

In short, Dept works with region 3.

Thanks,
Byungchul
