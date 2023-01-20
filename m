Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF267490B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 02:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjATBwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 20:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjATBwE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:52:04 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D482345F46
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 17:52:01 -0800 (PST)
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.53 with ESMTP; 20 Jan 2023 10:51:58 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.126 with ESMTP; 20 Jan 2023 10:51:58 +0900
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
Date:   Fri, 20 Jan 2023 10:51:45 +0900
Message-Id: <1674179505-26987-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <Y8mZHKJV4FH17vGn@boqun-archlinux>
References: <Y8mZHKJV4FH17vGn@boqun-archlinux>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Boqun wrote:
> On Thu, Jan 19, 2023 at 01:33:58PM +0000, Matthew Wilcox wrote:
> > On Thu, Jan 19, 2023 at 03:23:08PM +0900, Byungchul Park wrote:
> > > Boqun wrote:
> > > > *Looks like the DEPT dependency graph doesn't handle the
> > > > fair/unfair readers as lockdep current does. Which bring the
> > > > next question.
> > > 
> > > No. DEPT works better for unfair read. It works based on wait/event. So
> > > read_lock() is considered a potential wait waiting on write_unlock()
> > > while write_lock() is considered a potential wait waiting on either
> > > write_unlock() or read_unlock(). DEPT is working perfect for it.
> > > 
> > > For fair read (maybe you meant queued read lock), I think the case
> > > should be handled in the same way as normal lock. I might get it wrong.
> > > Please let me know if I miss something.
> > 
> > From the lockdep/DEPT point of view, the question is whether:
> > 
> >	read_lock(A)
> >	read_lock(A)
> > 
> > can deadlock if a writer comes in between the two acquisitions and
> > sleeps waiting on A to be released.  A fair lock will block new
> > readers when a writer is waiting, while an unfair lock will allow
> > new readers even while a writer is waiting.
> > 
> 
> To be more accurate, a fair reader will wait if there is a writer
> waiting for other reader (fair or not) to unlock, and an unfair reader
> won't.

What a kind guys, both of you! Thanks.

I asked to check if there are other subtle things than this. Fortunately,
I already understand what you guys shared.

> In kernel there are read/write locks that can have both fair and unfair
> readers (e.g. queued rwlock). Regarding deadlocks,
> 
> 	T0		T1		T2
> 	--		--		--
> 	fair_read_lock(A);
> 			write_lock(B);
> 					write_lock(A);
> 	write_lock(B);
> 			unfair_read_lock(A);

With the DEPT's point of view (let me re-write the scenario):

	T0		T1		T2
	--		--		--
	fair_read_lock(A);
			write_lock(B);
					write_lock(A);
	write_lock(B);
			unfair_read_lock(A);
	write_unlock(B);
	read_unlock(A);
			read_unlock(A);
			write_unlock(B);
					write_unlock(A);

T0: read_unlock(A) cannot happen if write_lock(B) is stuck by a B owner
    not doing either write_unlock(B) or read_unlock(B). In other words:

      1. read_unlock(A) happening depends on write_unlock(B) happening.
      2. read_unlock(A) happening depends on read_unlock(B) happening.

T1: write_unlock(B) cannot happen if unfair_read_lock(A) is stuck by a A
    owner not doing write_unlock(A). In other words:

      3. write_unlock(B) happening depends on write_unlock(A) happening.

1, 2 and 3 give the following dependencies:

    1. read_unlock(A) -> write_unlock(B)
    2. read_unlock(A) -> read_unlock(B)
    3. write_unlock(B) -> write_unlock(A)

There's no circular dependency so it's safe. DEPT doesn't report this.

> the above is not a deadlock, since T1's unfair reader can "steal" the
> lock. However the following is a deadlock:
> 
> 	T0		T1		T2
> 	--		--		--
> 	unfair_read_lock(A);
> 			write_lock(B);
> 					write_lock(A);
> 	write_lock(B);
> 			fair_read_lock(A);
> 
> , since T'1 fair reader will wait.

With the DEPT's point of view (let me re-write the scenario):

	T0		T1		T2
	--		--		--
	unfair_read_lock(A);
			write_lock(B);
					write_lock(A);
	write_lock(B);
			fair_read_lock(A);
	write_unlock(B);
	read_unlock(A);
			read_unlock(A);
			write_unlock(B);
					write_unlock(A);

T0: read_unlock(A) cannot happen if write_lock(B) is stuck by a B owner
    not doing either write_unlock(B) or read_unlock(B). In other words:

      1. read_unlock(A) happening depends on write_unlock(B) happening.
      2. read_unlock(A) happening depends on read_unlock(B) happening.

T1: write_unlock(B) cannot happen if fair_read_lock(A) is stuck by a A
    owner not doing either write_unlock(A) or read_unlock(A). In other
    words:

      3. write_unlock(B) happening depends on write_unlock(A) happening.
      4. write_unlock(B) happening depends on read_unlock(A) happening.

1, 2, 3 and 4 give the following dependencies:

    1. read_unlock(A) -> write_unlock(B)
    2. read_unlock(A) -> read_unlock(B)
    3. write_unlock(B) -> write_unlock(A)
    4. write_unlock(B) -> read_unlock(A)

With 1 and 4, there's a circular dependency so DEPT definitely report
this as a problem.

REMIND: DEPT focuses on waits and events.

> FWIW, lockdep is able to catch this (figuring out which is deadlock and
> which is not) since two years ago, plus other trivial deadlock detection
> for read/write locks. Needless to say, if lib/lock-selftests.c was given
> a try, one could find it out on one's own.
> 
> Regards,
> Boqun
> 
