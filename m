Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AA249D77C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 02:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiA0BbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 20:31:00 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:48319 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231940AbiA0Ba7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:30:59 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.53 with ESMTP; 27 Jan 2022 10:00:57 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.126 with ESMTP; 27 Jan 2022 10:00:57 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
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
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: [RFC 00/14] DEPT(DEPendency Tracker)
Date:   Thu, 27 Jan 2022 10:00:53 +0900
Message-Id: <1643245254-11122-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
References: <1643078204-12663-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+cc

linux-mm@kvack.org
akpm@linux-foundation.org
mhocko@kernel.org
minchan@kernel.org
hannes@cmpxchg.org
vdavydov.dev@gmail.com
sj@kernel.org
jglisse@redhat.com
dennis@kernel.org
cl@linux.com
penberg@kernel.org
rientjes@google.com
vbabka@suse.cz
ngupta@vflare.org
linux-block@vger.kernel.org
axboe@kernel.dk
paolo.valente@linaro.org
josef@toxicpanda.com
linux-fsdevel@vger.kernel.org
viro@zeniv.linux.org.uk
jack@suse.cz
jlayton@kernel.org
dan.j.williams@intel.com
hch@infradead.org
djwong@kernel.org
dri-devel@lists.freedesktop.org
airlied@linux.ie
rodrigosiqueiramelo@gmail.com
melissa.srw@gmail.com
hamohammed.sa@gmail.com

--->8---
From 68ee7ab996fc7d67b6b506f48da106493ca2546a Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Tue, 25 Jan 2022 10:12:54 +0900
Subject: [RFC 00/14] DEPT(DEPendency Tracker)

Hi forks,

I've been developing a tool for detecting deadlock possibilities by
tracking wait/event rather than lock(?) acquisition order to try to
cover all synchonization machanisms. It's done on v5.10 tag. I bet
it would work great! Try it and see what's gonna happen.

Now that there's a porting issue, I made Dept rely on Lockdep. But it
should be separated from Lockdep once it's considered worth having.

Benifit:

	0. Works with all lock primitives.
	1. Works with wait_for_completion()/complete().
	2. Works with 'wait' on PG_locked.
	3. Works with 'wait' on PG_writeback.
	4. Works with swait/wakeup.
	5. Multiple reports are allowed.
	6. Deduplication control on multiple reports.
	7. Withstand false positives thanks to 5.
	8. Easy to tag any wait/event.

Future work:

	0. To make it more stable.
	1. To separates Dept from Lockdep.
	2. To improves performance in terms of time and space.
	3. To use Dept as a dependency engine for Lockdep.
	4. To add any missing tags of wait/event in the kernel.
	5. To deduplicate stack trace.

I hope you guys are gonna be satisfied with Dept. Don't hesitate to
give any feedback. I will adopt any feedbacks if reasonable.

Thanks,
Byungchul

Byungchul Park (14):
  llist: Move llist_{head,node} definition to types.h
  dept: Implement Dept(Dependency Tracker)
  dept: Embed Dept data in Lockdep
  dept: Apply Dept to spinlock
  dept: Apply Dept to mutex families
  dept: Apply Dept to rwlock
  dept: Apply Dept to wait_for_completion()/complete()
  dept: Apply Dept to seqlock
  dept: Apply Dept to rwsem
  dept: Add proc knobs to show stats and dependency graph
  dept: Introduce split map concept and new APIs for them
  dept: Apply Dept to wait/event of PG_{locked,writeback}
  dept: Separate out SDT(Single-event Dependency Tracker) header
  dept: Apply SDT to swait

 include/linux/completion.h        |   48 +-
 include/linux/dept.h              |  541 ++++++++
 include/linux/dept_page.h         |   71 +
 include/linux/dept_sdt.h          |   53 +
 include/linux/hardirq.h           |    3 +
 include/linux/irqflags.h          |   33 +-
 include/linux/llist.h             |    9 +-
 include/linux/lockdep.h           |  156 ++-
 include/linux/lockdep_types.h     |    3 +
 include/linux/mutex.h             |   31 +
 include/linux/page-flags.h        |   26 +-
 include/linux/pagemap.h           |    7 +-
 include/linux/percpu-rwsem.h      |   10 +-
 include/linux/rtmutex.h           |   11 +-
 include/linux/rwlock.h            |   48 +
 include/linux/rwlock_api_smp.h    |    8 +-
 include/linux/rwlock_types.h      |    7 +
 include/linux/rwsem.h             |   31 +
 include/linux/sched.h             |    3 +
 include/linux/seqlock.h           |   19 +-
 include/linux/spinlock.h          |   24 +
 include/linux/spinlock_types.h    |   10 +
 include/linux/swait.h             |    4 +
 include/linux/types.h             |    8 +
 init/init_task.c                  |    2 +
 init/main.c                       |    4 +
 kernel/Makefile                   |    1 +
 kernel/dependency/Makefile        |    5 +
 kernel/dependency/dept.c          | 2593 +++++++++++++++++++++++++++++++++++++
 kernel/dependency/dept_hash.h     |   11 +
 kernel/dependency/dept_internal.h |   26 +
 kernel/dependency/dept_object.h   |   14 +
 kernel/dependency/dept_proc.c     |   97 ++
 kernel/exit.c                     |    1 +
 kernel/fork.c                     |    2 +
 kernel/locking/lockdep.c          |   12 +-
 kernel/module.c                   |    2 +
 kernel/sched/completion.c         |   12 +-
 kernel/sched/swait.c              |    8 +
 kernel/softirq.c                  |    6 +-
 kernel/trace/trace_preemptirq.c   |   19 +-
 lib/Kconfig.debug                 |   21 +
 mm/filemap.c                      |   62 +
 mm/page_ext.c                     |    5 +
 44 files changed, 4009 insertions(+), 58 deletions(-)
 create mode 100644 include/linux/dept.h
 create mode 100644 include/linux/dept_page.h
 create mode 100644 include/linux/dept_sdt.h
 create mode 100644 kernel/dependency/Makefile
 create mode 100644 kernel/dependency/dept.c
 create mode 100644 kernel/dependency/dept_hash.h
 create mode 100644 kernel/dependency/dept_internal.h
 create mode 100644 kernel/dependency/dept_object.h
 create mode 100644 kernel/dependency/dept_proc.c

-- 
1.9.1

