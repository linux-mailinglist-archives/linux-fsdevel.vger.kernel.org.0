Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD556731BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 07:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjASGXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 01:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjASGX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:23:26 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AFC8654CB
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 22:23:23 -0800 (PST)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 19 Jan 2023 15:23:21 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 19 Jan 2023 15:23:21 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        longman@redhat.com
Subject: Re: [PATCH RFC v7 00/23] DEPT(Dependency Tracker)
Date:   Thu, 19 Jan 2023 15:23:08 +0900
Message-Id: <1674109388-6663-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <Y8bmeffIQ3iXU3Ux@boqun-archlinux>
References: <Y8bmeffIQ3iXU3Ux@boqun-archlinux>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Boqun wrote:
> On Mon, Jan 16, 2023 at 10:00:52AM -0800, Linus Torvalds wrote:
> > [ Back from travel, so trying to make sense of this series..  ]
> > 
> > On Sun, Jan 8, 2023 at 7:33 PM Byungchul Park <byungchul.park@lge.com> wrote:
> > >
> > > I've been developing a tool for detecting deadlock possibilities by
> > > tracking wait/event rather than lock(?) acquisition order to try to
> > > cover all synchonization machanisms. It's done on v6.2-rc2.
> > 
> > Ugh. I hate how this adds random patterns like
> > 
> >         if (timeout == MAX_SCHEDULE_TIMEOUT)
> >                 sdt_might_sleep_strong(NULL);
> >         else
> >                 sdt_might_sleep_strong_timeout(NULL);
> >    ...
> >         sdt_might_sleep_finish();
> > 
> > to various places, it seems so very odd and unmaintainable.
> > 
> > I also recall this giving a fair amount of false positives, are they all fixed?
> > 
> 
> From the following part in the cover letter, I guess the answer is no?

I fixed what we found anyway.

> 	...
> 	6. Multiple reports are allowed.
> 	7. Deduplication control on multiple reports.
> 	8. Withstand false positives thanks to 6.
> 	...
> 
> seems to me that the logic is since DEPT allows multiple reports so that
> false positives are fitlerable by users?

At lease, it's needed until DEPT is considered stable because stronger
detection inevitably has more chance of false alarms unless we do manual
fix on each, which is the same as Lockdep.

> > Anyway, I'd really like the lockdep people to comment and be involved.
> 
> I never get Cced, so I'm unware of this for a long time...

Sorry I missed it. I will cc you from now on.

> A few comments after a quick look:
> 
> *	Looks like the DEPT dependency graph doesn't handle the
> 	fair/unfair readers as lockdep current does. Which bring the
> 	next question.

No. DEPT works better for unfair read. It works based on wait/event. So
read_lock() is considered a potential wait waiting on write_unlock()
while write_lock() is considered a potential wait waiting on either
write_unlock() or read_unlock(). DEPT is working perfect for it.

For fair read (maybe you meant queued read lock), I think the case
should be handled in the same way as normal lock. I might get it wrong.
Please let me know if I miss something.

> *	Can DEPT pass all the selftests of lockdep in
> 	lib/locking-selftests.c?
> 
> *	Instead of introducing a brand new detector/dependency tracker,
> 	could we first improve the lockdep's dependency tracker? I think

At the beginning of this work, of course I was thinking to improve
Lockdep but I decided to implement a new tool because:

	1. What we need to check for deadlock detection is no longer
	   lock dependency but more fundamental dependency by wait/event.
	   A better design would have a separate dependency engine for
	   that, not within Lockdep. Remind lock/unlock are also
	   wait/event after all.

	2. I was thinking to revert the revert of cross-release. But it
	   will start to report false alarms as Lockdep was at the
	   beginning, and require us to keep fixing things until being
	   able to see what we are interested in, maybe for ever. How
	   can we control that situation? I wouldn't use this extention.

	3. Okay. Let's think about modifying the current Lockdep to make
	   it work similar to DEPT. It'd require us to pay more effort
	   than developing a new simple tool from the scratch with the
	   basic requirement.

	4. Big change at once right away? No way. The new tool need to
	   be matured and there are ones who want to make use of DEPT at
	   the same time. The best approach would be I think to go along
	   together for a while.

Please don't look at each detail but the big picture, the architecture.
Plus, please consider I introduce a tool only focucing on fundamental
dependency itself that Lockdep can make use of. I wish great developers
like you would join improve the common engine togather.

> 	Byungchul also agrees that DEPT and lockdep should share the
> 	same dependency tracker and the benefit of improving the

I agree that both should share a single tracker.

> 	existing one is that we can always use the self test to catch
> 	any regression. Thoughts?

I imagine the follownig look for the final form:

     Lock correctness checker(LOCKDEP)
     +-----------------------------------------+
     | Lock usage correctness check            |
     |                                         |
     |                                         |
     |       (Request dependency check)        |
     |                           T             |
     +---------------------------|-------------+
                                 |
     Dependency tracker(DEPT)    V
     +-----------------------------------------+
     | Dependency check                        |
     | (by tracking wait and event context)    |
     +-----------------------------------------+

> Actually the above sugguest is just to revert revert cross-release
> without exposing any annotation, which I think is more practical to
> review and test.

Reverting the revert of cross-release is not bad. But I'd suggest a
nicer design for the reasons I explained above.

	Byungchul

> I'd sugguest we 1) first improve the lockdep dependency tracker with
> wait/event in mind and then 2) introduce wait related annotation so that
> users can use, and then 3) look for practical ways to resolve false
> positives/multi reports with the help of users, if all goes well,
> 4) make it all operation annotated.
> 
> Thoughts?
> 
> Regards,
> Boqun
