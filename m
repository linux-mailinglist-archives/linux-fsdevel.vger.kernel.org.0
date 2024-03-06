Return-Path: <linux-fsdevel+bounces-13698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE928873186
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F2828748B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC5B5FB9C;
	Wed,  6 Mar 2024 08:55:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9455DF1D;
	Wed,  6 Mar 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715337; cv=none; b=nCs29rtsaavz8CLr6cU4/Nb3gmlV1gHYSTFGBd8nud286eJVXqfkqMy4swkydHL2012C6sva1INJXspJYQcSll/Dim7nuPXeaU/vS38pfvFNKImXQIj+NUuWeBCXXA2p+1GRptU2mZT7iTUnMLHe20tYeWPewAdWsO+OBhC1H0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715337; c=relaxed/simple;
	bh=icefFzuufstYBdavP0at89nC0mEAcvbdJq+cd4S6B8k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sesCu9teUB53jKZ/Xdm37VnpRUJ86vL1fRHwck6Vc5o9TGwpcBXAPw0xViHqOjevQAgn5BOlVAMvjbNYxjAJ9chpvsJe68ZgKgNgk/L634KaIESONfomsoyhWYIW6bet7ceq1oVPIIUWfcqxjl8T1Iu2s30mkkfMeQAnMFvkhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-28-65e82f7c660e
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v13 00/27] DEPT(Dependency Tracker)
Date: Wed,  6 Mar 2024 17:54:46 +0900
Message-Id: <20240306085513.41482-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0hTYRgH8N73nPOeuVycptXJPhQDCbpoN+GJIgqiXoIu1LciauQhl5dk
	mrauWq7M1FIwyyy81BRdWXNFljPTXDPLrFaZTMlheWkX0DZcSjWLvjz84P/n/+mRMcobXIRM
	k5QqaZPUCSoiZ+Xu0IqlJ6KHpGU9DxdCQe4y8P3IZqG0zkig624tAqM5E8Nw22b45HchmHj9
	hoHioi4E5f29DJitfQgs1WcIvB+YAXafl0B70UUCZyvrCLz9PonBcaUQQ61pK3RcrsDQHBhk
	oXiYwPXiszh4hjAEDDU8GDIiwVldwsNk/3Jo7/vIgaVnMVy76SDQaGlnwfrIieH941ICfcbf
	HHRYbSx0FeRxcMdTQeC738CAwefl4V1zGYZ7WcGhc2O/OHiR14zh3K37GOyfnyBoyv6CwWT8
	SKDV58JQbypi4GdVGwJnvpsHfW6Ah+uZ+Qgu6q+wkOWIgYnxUrJ+NW11eRmaVZ9OLf4ylr6s
	EGlDSS9Ps5p6eFpmOkLrqxfRysZhTMtHfRw11Vwg1DRayNMctx1TT2cnT21XJ1g6YC/GOyJ2
	y9fGSgmaNEkbvW6/PC77/BiX/CbxqM88RjLQ8505KEQmCqtE99dL3H+7zFfJlImwUOzuDjBT
	DhcWiPV53/52GMElF291bppymLBSbAs4/3ZYIVIsLPWgKSuEGLG9ysP+25wv1t5rDnbkQX+R
	iSOVdvwvmCs+q+5mL6PpZWhaDVJqktIS1ZqEVVFxuiTN0agDhxNNKPg0hpOTex6h0a5dLUiQ
	IVWoYn3IoKTk1GkpusQWJMoYVbjixM8BSamIVeuOSdrD+7RHEqSUFjRPxqrmKFb402OVwkF1
	qhQvScmS9n+KZSERGSheP5Y8FP1gJNzuMMbkeeM36t2fwggu2TV7cJu/bqNOFZ89YLOGbqEv
	0jv828w7TKJ164Hxm5sOOfXq2qZDa/N79/6yFozbYso/eFtXzDu9xhz52vHN9vSUe2Z/amZV
	TuPtJfuM4Z7jBdsV92MbcpHOMvL7jsYQ2DDr1ZOIsAcGFZsSp16+iNGmqP8AKKmHhjADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0iTYRgG4N73O83V6msJfhiRjUJKUiOFpwNhdPClExVEUIGO/NCRTtnM
	VIwstdRSVFJLLTzUPM3S6Q/PiadckVouK1NRsdScE9RJSzu4oj8PF9w3969HQsl/084SlTpc
	1KiVwQpWSktP7YvbGeMxKXpO56yG9HueYF1IpCHvuZ6F3mflCPQ1NzFMdfjCh0UzgqU3PRRk
	Z/YiKBgdoqCmcxhBU8ktFvrG14LJOsuCMfMuC3FFz1l4O72MYTArA0O54SS8TivE0GKboCF7
	ioXc7Di8ciYx2HRlHOhit8FYSQ4Hy6O7wDjcz0DbIyMDTQNu8PDxIAuNTUYaOmvHMPTV57Ew
	rP/NwOvOLhp601MYqLAUsjC9qKNAZ53l4F1LPobK+JW12/O/GHiZ0oLh9pMqDKZPDQiaE0cw
	GPT9LLRZzRiqDZkU/CjuQDCWOsNBwj0bB7k3UxHcTciiIX7QG5a+57E+e0mbeZYi8dXXSNNi
	Pk1eFQqkLmeII/HNAxzJN1wl1SU7SFHjFCYFc1aGGMqSWGKYy+BI8owJE0t3N0e6HizRZNyU
	jU9vvCDdHyAGqyJEjccBf2lQ4p15JqwnJNJaM8/GovazychBIvBegrnmAWs3y7sKHz/aKLsd
	eRehOuUrYzfFm6XCk+6jdm/gdwsdtrG/HZrfJmTkWZDdMt5bMBZb6H+bm4XyyhYqDUny0aoy
	5KhSR4QoVcHe7torQVFqVaT75dAQA1p5C9315fRatNDn24p4CVKskfk4TIhyRhmhjQppRYKE
	UjjKYn6Mi3JZgDIqWtSE+mmuBovaVrRRQiucZMfOi/5yPlAZLl4RxTBR8z/FEgfnWHRgYXDE
	+mrN3MUu6dH7butWT1lPBB5psF3KikQuxkM9ExpX8ubg/j3UuHtpbegX09NN37HPoe1hp25w
	4d0Fmfzn9Uv1L2pVVY5BqgK1088E5/vnnPyOp+q9bLmlRWdubN1w2PKtzBv/TErbMlPBRA/5
	vfesUyukGaSwsp03+ckdFLQ2SLlrB6XRKv8As7FxcxIDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

I'm happy to see that DEPT reports a real problem in practice. See:

   https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/

I added a document describing DEPT, that would help you understand what
DEPT is and how DEPT works. You can use DEPT just with CONFIG_DEPT on
and by checking dmesg in runtime.

---

Hi Linus and folks,

I've been developing a tool for detecting deadlock possibilities by
tracking wait/event rather than lock acquisition order to try to cover
all synchonization machanisms.

Benifit:

	0. Works with all lock primitives.
	1. Works with wait_for_completion()/complete().
	2. Works with PG_locked.
	3. Works with swait/wakeup.
	4. Works with waitqueue.
	5. Works with wait_bit.
	6. Multiple reports are allowed.
	7. Deduplication control on multiple reports.
	8. Withstand false positives thanks to 7.
	9. Easy to tag any wait/event.

Future work:

	0. To make it more stable.
	1. To separates Dept from Lockdep.
	2. To improves performance in terms of time and space.
	3. To use Dept as a dependency engine for Lockdep.
	4. To add any missing tags of wait/event in the kernel.
	5. To deduplicate stack trace.

How to interpret reports:

	[S] the start of the event context or the requestor having asked
	    the event context to go
	[W] the wait disturbing the event from triggering
	[E] the event that cannot be reachable

Thanks,
Byungchul

---

Changes from v12:

	1. Refine the whole document for DEPT.
	2. Add 'Interpret DEPT report' section in the document, using a
	   deadlock report obtained in practice. Hope this version of
	   document helps guys understand DEPT better.

	   https://lore.kernel.org/lkml/6383cde5-cf4b-facf-6e07-1378a485657d@I-love.SAKURA.ne.jp/#t
	   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/

Changes from v11:

	1. Add 'Dept' documentation describing the concept of Dept.
	2. Rewrite the commit messages of the following commits for
	   using weaker lockdep annotation, for better description.

	   fs/jbd2: Use a weaker annotation in journal handling
	   cpu/hotplug: Use a weaker annotation in AP thread

	   (feedbacked by Thomas Gleixner)

Changes from v10:

	1. Fix noinstr warning when building kernel source.
	2. Dept has been reporting some false positives due to the folio
	   lock's unfairness. Reflect it and make Dept work based on
	   dept annotaions instead of just wait and wake up primitives.
	3. Remove the support for PG_writeback while working on 2. I
	   will add the support later if needed.
	4. Dept didn't print stacktrace for [S] if the participant of a
	   deadlock is not lock mechanism but general wait and event.
	   However, it made hard to interpret the report in that case.
	   So add support to print stacktrace of the requestor who asked
	   the event context to run - usually a waiter of the event does
	   it just before going to wait state.
	5. Give up tracking raw_local_irq_{disable,enable}() since it
	   totally messed up dept's irq tracking. So make it work in the
	   same way as Lockdep does. I will consider it once any false
	   positives by those are observed again.
	6. Change the manual rwsem_acquire_read(->j_trans_commit_map)
	   annotation in fs/jbd2/transaction.c to the try version so
	   that it works as much as it exactly needs.
	7. Remove unnecessary 'inline' keyword in dept.c and add
	   '__maybe_unused' to a needed place.

Changes from v9:

	1. Fix a bug. SDT tracking didn't work well because of my big
	   mistake that I should've used waiter's map to indentify its
	   class but it had been working with waker's one. FYI,
	   PG_locked and PG_writeback weren't affected. They still
	   worked well. (reported by YoungJun)
	
Changes from v8:

	1. Fix build error by adding EXPORT_SYMBOL(PG_locked_map) and
	   EXPORT_SYMBOL(PG_writeback_map) for kernel module build -
	   appologize for that. (reported by kernel test robot)
	2. Fix build error by removing header file's circular dependency
	   that was caused by "atomic.h", "kernel.h" and "irqflags.h",
	   which I introduced - appolgize for that. (reported by kernel
	   test robot)

Changes from v7:

	1. Fix a bug that cannot track rwlock dependency properly,
	   introduced in v7. (reported by Boqun and lockdep selftest)
	2. Track wait/event of PG_{locked,writeback} more aggressively
	   assuming that when a bit of PG_{locked,writeback} is cleared
	   there might be waits on the bit. (reported by Linus, Hillf
	   and syzbot)
	3. Fix and clean bad style code e.i. unnecessarily introduced
	   a randome pattern and so on. (pointed out by Linux)
	4. Clean code for applying DEPT to wait_for_completion().

Changes from v6:

	1. Tie to task scheduler code to track sleep and try_to_wake_up()
	   assuming sleeps cause waits, try_to_wake_up()s would be the
	   events that those are waiting for, of course with proper DEPT
	   annotations, sdt_might_sleep_weak(), sdt_might_sleep_strong()
	   and so on. For these cases, class is classified at sleep
	   entrance rather than the synchronization initialization code.
	   Which would extremely reduce false alarms.
	2. Remove the DEPT associated instance in each page struct for
	   tracking dependencies by PG_locked and PG_writeback thanks to
	   the 1. work above.
	3. Introduce CONFIG_DEPT_AGGRESIVE_TIMEOUT_WAIT to suppress
	   reports that waits with timeout set are involved, for those
	   who don't like verbose reporting.
	4. Add a mechanism to refill the internal memory pools on
	   running out so that DEPT could keep working as long as free
	   memory is available in the system.
	5. Re-enable tracking hashed-waitqueue wait. That's going to no
	   longer generate false positives because class is classified
	   at sleep entrance rather than the waitqueue initailization.
	6. Refactor to make it easier to port onto each new version of
	   the kernel.
	7. Apply DEPT to dma fence.
	8. Do trivial optimizaitions.

Changes from v5:

	1. Use just pr_warn_once() rather than WARN_ONCE() on the lack
	   of internal resources because WARN_*() printing stacktrace is
	   too much for informing the lack. (feedback from Ted, Hyeonggon)
	2. Fix trivial bugs like missing initializing a struct before
	   using it.
	3. Assign a different class per task when handling onstack
	   variables for waitqueue or the like. Which makes Dept
	   distinguish between onstack variables of different tasks so
	   as to prevent false positives. (reported by Hyeonggon)
	4. Make Dept aware of even raw_local_irq_*() to prevent false
	   positives. (reported by Hyeonggon)
	5. Don't consider dependencies between the events that might be
	   triggered within __schedule() and the waits that requires
	    __schedule(), real ones. (reported by Hyeonggon)
	6. Unstage the staged wait that has prepare_to_wait_event()'ed
	   *and* yet to get to __schedule(), if we encounter __schedule()
	   in-between for another sleep, which is possible if e.g. a
	   mutex_lock() exists in 'condition' of ___wait_event().
	7. Turn on CONFIG_PROVE_LOCKING when CONFIG_DEPT is on, to rely
	   on the hardirq and softirq entrance tracing to make Dept more
	   portable for now.

Changes from v4:

	1. Fix some bugs that produce false alarms.
	2. Distinguish each syscall context from another *for arm64*.
	3. Make it not warn it but just print it in case Dept ring
	   buffer gets exhausted. (feedback from Hyeonggon)
	4. Explicitely describe "EXPERIMENTAL" and "Dept might produce
	   false positive reports" in Kconfig. (feedback from Ted)

Changes from v3:

	1. Dept shouldn't create dependencies between different depths
	   of a class that were indicated by *_lock_nested(). Dept
	   normally doesn't but it does once another lock class comes
	   in. So fixed it. (feedback from Hyeonggon)
	2. Dept considered a wait as a real wait once getting to
	   __schedule() even if it has been set to TASK_RUNNING by wake
	   up sources in advance. Fixed it so that Dept doesn't consider
	   the case as a real wait. (feedback from Jan Kara)
	3. Stop tracking dependencies with a map once the event
	   associated with the map has been handled. Dept will start to
	   work with the map again, on the next sleep.

Changes from v2:

	1. Disable Dept on bit_wait_table[] in sched/wait_bit.c
	   reporting a lot of false positives, which is my fault.
	   Wait/event for bit_wait_table[] should've been tagged in a
	   higher layer for better work, which is a future work.
	   (feedback from Jan Kara)
	2. Disable Dept on crypto_larval's completion to prevent a false
	   positive.

Changes from v1:

	1. Fix coding style and typo. (feedback from Steven)
	2. Distinguish each work context from another in workqueue.
	3. Skip checking lock acquisition with nest_lock, which is about
	   correct lock usage that should be checked by Lockdep.

Changes from RFC(v0):

	1. Prevent adding a wait tag at prepare_to_wait() but __schedule().
	   (feedback from Linus and Matthew)
	2. Use try version at lockdep_acquire_cpus_lock() annotation.
	3. Distinguish each syscall context from another.

Byungchul Park (27):
  llist: Move llist_{head,node} definition to types.h
  dept: Implement Dept(Dependency Tracker)
  dept: Add single event dependency tracker APIs
  dept: Add lock dependency tracker APIs
  dept: Tie to Lockdep and IRQ tracing
  dept: Add proc knobs to show stats and dependency graph
  dept: Apply sdt_might_sleep_{start,end}() to
    wait_for_completion()/complete()
  dept: Apply sdt_might_sleep_{start,end}() to swait
  dept: Apply sdt_might_sleep_{start,end}() to waitqueue wait
  dept: Apply sdt_might_sleep_{start,end}() to hashed-waitqueue wait
  dept: Distinguish each syscall context from another
  dept: Distinguish each work from another
  dept: Add a mechanism to refill the internal memory pools on running
    out
  cpu/hotplug: Use a weaker annotation in AP thread
  dept: Apply sdt_might_sleep_{start,end}() to dma fence wait
  dept: Track timeout waits separately with a new Kconfig
  dept: Apply timeout consideration to wait_for_completion()/complete()
  dept: Apply timeout consideration to swait
  dept: Apply timeout consideration to waitqueue wait
  dept: Apply timeout consideration to hashed-waitqueue wait
  dept: Apply timeout consideration to dma fence wait
  dept: Record the latest one out of consecutive waits of the same class
  dept: Make Dept able to work with an external wgen
  dept: Track PG_locked with dept
  dept: Print event context requestor's stacktrace on report
  fs/jbd2: Use a weaker annotation in journal handling
  dept: Add documentation for Dept

 Documentation/dependency/dept.txt   |  735 +++++++
 arch/arm64/kernel/syscall.c         |    3 +
 arch/x86/entry/common.c             |    4 +
 drivers/dma-buf/dma-fence.c         |    5 +
 fs/jbd2/transaction.c               |    2 +-
 include/linux/completion.h          |   30 +-
 include/linux/dept.h                |  617 ++++++
 include/linux/dept_ldt.h            |   77 +
 include/linux/dept_sdt.h            |   66 +
 include/linux/hardirq.h             |    3 +
 include/linux/irqflags.h            |    7 +-
 include/linux/llist.h               |    8 -
 include/linux/local_lock_internal.h |    1 +
 include/linux/lockdep.h             |  102 +-
 include/linux/lockdep_types.h       |    3 +
 include/linux/mm_types.h            |    2 +
 include/linux/mutex.h               |    1 +
 include/linux/page-flags.h          |  105 +-
 include/linux/pagemap.h             |    7 +-
 include/linux/percpu-rwsem.h        |    2 +-
 include/linux/rtmutex.h             |    1 +
 include/linux/rwlock_types.h        |    1 +
 include/linux/rwsem.h               |    1 +
 include/linux/sched.h               |    3 +
 include/linux/seqlock.h             |    2 +-
 include/linux/spinlock_types_raw.h  |    3 +
 include/linux/srcu.h                |    2 +-
 include/linux/swait.h               |    3 +
 include/linux/types.h               |    8 +
 include/linux/wait.h                |    3 +
 include/linux/wait_bit.h            |    3 +
 init/init_task.c                    |    2 +
 init/main.c                         |    2 +
 kernel/Makefile                     |    1 +
 kernel/cpu.c                        |    2 +-
 kernel/dependency/Makefile          |    4 +
 kernel/dependency/dept.c            | 3175 +++++++++++++++++++++++++++
 kernel/dependency/dept_hash.h       |   10 +
 kernel/dependency/dept_internal.h   |   26 +
 kernel/dependency/dept_object.h     |   13 +
 kernel/dependency/dept_proc.c       |   93 +
 kernel/exit.c                       |    1 +
 kernel/fork.c                       |    2 +
 kernel/locking/lockdep.c            |   22 +
 kernel/module/main.c                |    4 +
 kernel/sched/completion.c           |    2 +-
 kernel/sched/core.c                 |   10 +
 kernel/workqueue.c                  |    3 +
 lib/Kconfig.debug                   |   37 +
 lib/locking-selftest.c              |    2 +
 mm/filemap.c                        |   26 +
 mm/mm_init.c                        |    2 +
 52 files changed, 5195 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/dependency/dept.txt
 create mode 100644 include/linux/dept.h
 create mode 100644 include/linux/dept_ldt.h
 create mode 100644 include/linux/dept_sdt.h
 create mode 100644 kernel/dependency/Makefile
 create mode 100644 kernel/dependency/dept.c
 create mode 100644 kernel/dependency/dept_hash.h
 create mode 100644 kernel/dependency/dept_internal.h
 create mode 100644 kernel/dependency/dept_object.h
 create mode 100644 kernel/dependency/dept_proc.c


base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
2.17.1


