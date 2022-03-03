Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1214CB463
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 02:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiCCBhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 20:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCCBhp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:37:45 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC985CE3
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 17:36:57 -0800 (PST)
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 3 Mar 2022 10:36:56 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.126 with ESMTP; 3 Mar 2022 10:36:56 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Thu, 3 Mar 2022 10:36:35 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Theodore Ts'o <tytso@mit.edu>
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
Message-ID: <20220303013635.GC20752@X58A-UD3R>
References: <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-2-git-send-email-byungchul.park@lge.com>
 <20220221190204.q675gtsb6qhylywa@quack3.lan>
 <20220223003534.GA26277@X58A-UD3R>
 <20220223144859.na2gjgl5efgw5zhn@quack3.lan>
 <20220224011102.GA29726@X58A-UD3R>
 <20220224102239.n7nzyyekuacgpnzg@quack3.lan>
 <20220228092826.GA5201@X58A-UD3R>
 <20220228101444.6frl63dn5vmgycbp@quack3.lan>
 <Yh09sIsw5vh+qCeU@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh09sIsw5vh+qCeU@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 04:25:04PM -0500, Theodore Ts'o wrote:
> On Mon, Feb 28, 2022 at 11:14:44AM +0100, Jan Kara wrote:
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
> > > I've been wondering if the kernel guys esp. Linus considers code with
> > > any circular dependency is problematic or not, even if it won't lead to
> > > a deadlock, say, case 1. Even though I designed Dept based on what I
> > > believe is right, of course, I'm willing to change the design according
> > > to the majority opinion.
> > > 
> > > However, I would never allow case 1 if I were the owner of the kernel
> > > for better stability, even though the code works anyway okay for now.
> 
> Note, I used the example of the timeout as the most obvious way of
> explaining that a deadlock is not possible.  There is also the much
> more complex explanation which Jan was trying to give, which is what
> leads to the circular dependency.  It can happen that when trying to
> start a handle, if either (a) there is not enough space in the journal
> for new handles, or (b) the current transaction is so large that if we
> don't close the transaction and start a new hone, we will end up
> running out of space in the future, and so in that case,
> start_this_handle() will block starting any more handles, and then
> wake up the commit thread.  The commit thread then waits for the
> currently running threads to complete, before it allows new handles to
> start, and then it will complete the commit.  In the case of (a) we
> then need to do a journal checkpoint, which is more work to release
> space in the journal, and only then, can we allow new handles to start.

Thank you for the full explanation of how journal things work.

> The botom line is (a) it works, (b) there aren't significant delays,
> and for DEPT to complain that this is somehow wrong and we need to
> completely rearchitect perfectly working code because it doesn't
> confirm to DEPT's idea of what is "correct" is not acceptable.

Thanks to you and Jan Kara, I realized it's not a real dependency in the
consumer and producer scenario but again *ONLY IF* there is a rescue
wakeup source. Dept should track the rescue wakeup source instead in the
case.

I won't ask you to rearchitect the working code. The code looks sane.

Thanks a lot.

Thanks,
Byungchul

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
> > 
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
> Cheers,
> 
> 							- Ted
