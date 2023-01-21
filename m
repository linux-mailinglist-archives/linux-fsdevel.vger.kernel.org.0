Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB3F6763DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 05:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjAUEsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 23:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUEsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 23:48:09 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1DA56F33F
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 20:48:06 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 21 Jan 2023 13:48:04 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 21 Jan 2023 13:48:04 +0900
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
Date:   Sat, 21 Jan 2023 13:47:49 +0900
Message-Id: <1674276469-31793-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <Y8tfgYNZ//feEDvC@Boquns-Mac-mini.local>
References: <Y8tfgYNZ//feEDvC@Boquns-Mac-mini.local>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Boqun wrote:
> On Sat, Jan 21, 2023 at 12:28:14PM +0900, Byungchul Park wrote:
> > On Thu, Jan 19, 2023 at 07:07:59PM -0800, Boqun Feng wrote:
> > > On Thu, Jan 19, 2023 at 06:23:49PM -0800, Boqun Feng wrote:
> > > > On Fri, Jan 20, 2023 at 10:51:45AM +0900, Byungchul Park wrote:
> > 
> > [...]
> > 
> > > > > T0		T1		T2
> > > > > --		--		--
> > > > > unfair_read_lock(A);
> > > > >			write_lock(B);
> > > > >					write_lock(A);
> > > > > write_lock(B);
> > > > >			fair_read_lock(A);
> > > > > write_unlock(B);
> > > > > read_unlock(A);
> > > > >			read_unlock(A);
> > > > >			write_unlock(B);
> > > > >					write_unlock(A);
> > > > > 
> > > > > T0: read_unlock(A) cannot happen if write_lock(B) is stuck by a B owner
> > > > >     not doing either write_unlock(B) or read_unlock(B). In other words:
> > > > > 
> > > > >       1. read_unlock(A) happening depends on write_unlock(B) happening.
> > > > >       2. read_unlock(A) happening depends on read_unlock(B) happening.
> > > > > 
> > > > > T1: write_unlock(B) cannot happen if fair_read_lock(A) is stuck by a A
> > > > >     owner not doing either write_unlock(A) or read_unlock(A). In other
> > > > >     words:
> > > > > 
> > > > >       3. write_unlock(B) happening depends on write_unlock(A) happening.
> > > > >       4. write_unlock(B) happening depends on read_unlock(A) happening.
> > > > > 
> > > > > 1, 2, 3 and 4 give the following dependencies:
> > > > > 
> > > > >     1. read_unlock(A) -> write_unlock(B)
> > > > >     2. read_unlock(A) -> read_unlock(B)
> > > > >     3. write_unlock(B) -> write_unlock(A)
> > > > >     4. write_unlock(B) -> read_unlock(A)
> > > > > 
> > > > > With 1 and 4, there's a circular dependency so DEPT definitely report
> > > > > this as a problem.
> > > > > 
> > > > > REMIND: DEPT focuses on waits and events.
> > > > 
> > > > Do you have the test cases showing DEPT can detect this?
> > > > 
> > > 
> > > Just tried the following on your latest GitHub branch, I commented all
> > > but one deadlock case. Lockdep CAN detect it but DEPT CANNOT detect it.
> > > Feel free to double check.
> > 
> > I tried the 'queued read lock' test cases with DEPT on. I can see DEPT
> > detect and report it. But yeah.. it's too verbose now. It's because DEPT
> > is not aware of the test environment so it's just working hard to report
> > every case.
> > 
> > To make DEPT work with the selftest better, some works are needed. I
> > will work on it later or you please work on it.
> > 
> > The corresponding report is the following.
> > 
> [...]
> > [    4.593037] context A's detail
> > [    4.593351] ---------------------------------------------------
> > [    4.593944] context A
> > [    4.594182]     [S] lock(&rwlock_A:0)
> > [    4.594577]     [W] lock(&rwlock_B:0)
> > [    4.594952]     [E] unlock(&rwlock_A:0)
> > [    4.595341] 
> > [    4.595501] [S] lock(&rwlock_A:0):
> > [    4.595848] [<ffffffff814eb244>] queued_read_lock_hardirq_ER_rE+0xf4/0x170
> > [    4.596547] stacktrace:
> > [    4.596797]       _raw_read_lock+0xcf/0x110
> > [    4.597215]       queued_read_lock_hardirq_ER_rE+0xf4/0x170
> > [    4.597766]       dotest+0x30/0x7bc
> > [    4.598118]       locking_selftest+0x2c6f/0x2ead
> > [    4.598602]       start_kernel+0x5aa/0x6d5
> > [    4.599017]       secondary_startup_64_no_verify+0xe0/0xeb
> > [    4.599562] 
> [...]
> > [    4.608427] [<ffffffff814eb3b4>] queued_read_lock_hardirq_RE_Er+0xf4/0x170
> > [    4.609113] stacktrace:
> > [    4.609366]       _raw_write_lock+0xc3/0xd0
> > [    4.609788]       queued_read_lock_hardirq_RE_Er+0xf4/0x170
> > [    4.610371]       dotest+0x30/0x7bc
> > [    4.610730]       locking_selftest+0x2c41/0x2ead
> > [    4.611195]       start_kernel+0x5aa/0x6d5
> > [    4.611615]       secondary_startup_64_no_verify+0xe0/0xeb
> > [    4.612164] 
> > [    4.612325] [W] lock(&rwlock_A:0):
> > [    4.612671] [<ffffffff814eb3c0>] queued_read_lock_hardirq_RE_Er+0x100/0x170
> > [    4.613369] stacktrace:
> > [    4.613622]       _raw_read_lock+0xac/0x110
> > [    4.614047]       queued_read_lock_hardirq_RE_Er+0x100/0x170
> > [    4.614652]       dotest+0x30/0x7bc
> > [    4.615007]       locking_selftest+0x2c41/0x2ead
> > [    4.615468]       start_kernel+0x5aa/0x6d5
> > [    4.615879]       secondary_startup_64_no_verify+0xe0/0xeb
> > [    4.616607] 
> [...]
> 
> > As I told you, DEPT treats a queued lock as a normal type lock, no
> > matter whether it's a read lock. That's why it prints just
> > 'lock(&rwlock_A:0)' instead of 'read_lock(&rwlock_A:0)'. If needed, I'm
> > gonna change the format.
> > 
> > I checked the selftest code and found, LOCK(B) is transformed like:
> > 
> > 	LOCK(B) -> WL(B) -> write_lock(&rwlock_B)
> > 
> > That's why '&rwlock_B' is printed instead of just 'B', JFYI.
> > 
> 
> Nah, you output shows that you've run at least both function
> 
> 	queued_read_lock_hardirq_RE_Er()
> 	queued_read_lock_hardirq_ER_rE()

Indeed! I'm sorry for that.

> but if you apply my diff
> 
> 	https://lore.kernel.org/lkml/Y8oFj9A19cw3enHB@boqun-archlinux/
> 
> you should only run
> 
> 	queued_read_lock_hardirq_RE_Er()
> 
> one test.

I checked it. DEPT doesn't assume a rwlock switches between recursive
read lock and non-recursive read lock in a run time. Maybe it switches
since read lock needs to switch to recursive one in interrupt context.

By forcing read_lock_is_recursive() to always return false, DEPT works
as we expect. Otherwise, it doesn't.

Probabily I need to fix it.

Thanks.

	Byungchul
