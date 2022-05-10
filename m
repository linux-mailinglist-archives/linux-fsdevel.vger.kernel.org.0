Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACCC520D3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 07:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiEJFnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 01:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiEJFnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 01:43:20 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54D58259F8A
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 22:39:19 -0700 (PDT)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 10 May 2022 14:39:17 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 10 May 2022 14:39:17 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     tytso@mit.edu
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com,
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
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Subject: Re: [PATCH RFC v6 00/21] DEPT(Dependency Tracker)
Date:   Tue, 10 May 2022 14:37:40 +0900
Message-Id: <1652161060-26531-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <YnnAnzPFZZte/UR8@mit.edu>
References: <YnnAnzPFZZte/UR8@mit.edu>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ted wrote:
> On Tue, May 10, 2022 at 09:32:13AM +0900, Byungchul Park wrote:
> > Yes, right. DEPT has never been optimized. It rather turns on
> > CONFIG_LOCKDEP and even CONFIG_PROVE_LOCKING when CONFIG_DEPT gets on
> > because of porting issue. I have no choice but to rely on those to
> > develop DEPT out of tree. Of course, that's what I don't like.
> 
> Sure, but blaming the overhead on unnecessary CONFIG_PROVE_LOCKING
> overhead can explain only a tiny fraction of the slowdown.  Consider:
> if time to first test (time to boot the kernel, setup the test
> environment, figure out which tests to run, etc.) is 12 seconds w/o
> LOCKDEP, 49 seconds with LOCKDEP/PROVE_LOCKING and 602 seconds with
> DEPT, you can really only blame 37 seconds out of the 602 seconds of
> DEPT on unnecessary PROVE_LOCKING overhead.
> 
> So let's assume we can get rid of all of the PROVE_LOCKING overhead.
> We're still talking about 12 seconds for time-to-first test without
> any lock debugging, versus ** 565 ** seconds for time-to-first test
> with DEPT.  That's a factor of 47x for DEPT sans LOCKDEP overhead,
> compared to a 4x overhead for PROVE_LOCKING.

Okay. I will work on it.

> > Plus, for now, I'm focusing on removing false positives. Once it's
> > considered settled down, I will work on performance optimizaition. But
> > it should still keep relying on Lockdep CONFIGs and adding additional
> > overhead on it until DEPT can be developed in the tree.
> 
> Well, please take a look at the false positive which I reported.  I
> suspect that in order to fix that particular false positive, we'll
> either need to have a way to disable DEPT on waiting on all page/folio
> dirty bits, or it will need to treat pages from different inodes
> and/or address spaces as being entirely separate classes, instead of
> collapsing all inode dirty bits, and all of various inode's mutexes
> (such as ext4's i_data_sem) as being part of a single object class.

I'd rather solve it by assigning different classes to different types of
inode. This is the right way.

> > DEPT is tracking way more objects than Lockdep so it's inevitable to be
> > slower, but let me try to make it have the similar performance to
> > Lockdep.
> 
> In order to eliminate some of these false positives, I suspect it's
> going to increase the number of object classes that DEPT will need to
> track even *more*.  At which point, the cost/benefit of DEPT may get
> called into question, especially if all of the false positives can't
> be suppressed.

Look. Let's talk in general terms. There's no way to get rid of the
false positives all the way. It's a decision issue for *balancing*
between considering potential cases and only real ones. Definitely,
potential is not real. The more potential things we consider, the higher
the chances are, that false positives appear.

But yes. The advantage we'd take by detecting potential ones should be
higher than the risk of being bothered by false ones. Do you think a
tool is useless if it produces a few false positives? Of course, it'd
be a problem if it's too many, but otherwise, I think it'd be a great
tool if the advantage > the risk.

Don't get me wrong here. It doesn't mean DEPT is perfect for now. The
performance should be improved and false alarms that appear should be
removed, of course. I'm talking about the direction.

For now, there's no tool to track wait/event itself in Linux kernel -
a subset of the functionality exists tho. DEPT is the 1st try for that
purpose and can be a useful tool by the right direction.

I know what you are concerning about. I bet it's false positives that
are going to bother you once merged. I'll insist that DEPT shouldn't be
used as a mandatory testing tool until considered stable enough. But
what about ones who would take the advantage use DEPT. Why don't you
think of folks who will take the advantage from the hints about
dependency of synchronization esp. when their subsystem requires very
complicated synchronization? Should a tool be useful only in a final
testing stage? What about the usefulness during development stage?

It's worth noting DEPT works with any wait/event so any lockups e.g.
even by HW-SW interface, retry logic or the like can be detected by DEPT
once all waits and events are tagged properly. I believe the advantage
by that is much higher than the bad side facing false alarms. It's just
my opinion. I'm goning to respect the majority opinion.

	Byungchul
> 
> 					- Ted
> 
