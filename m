Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA2149D740
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 02:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiA0BLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 20:11:33 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:46005 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234389AbiA0BLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:11:22 -0500
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 27 Jan 2022 10:11:18 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 27 Jan 2022 10:11:18 +0900
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
Subject: [PATCH on v5.17-rc1 08/14] dept: Apply Dept to seqlock
Date:   Thu, 27 Jan 2022 10:11:06 +0900
Message-Id: <1643245873-15542-8-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1643245873-15542-1-git-send-email-byungchul.park@lge.com>
References: <1643245733-14513-1-git-send-email-byungchul.park@lge.com>
 <1643245873-15542-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by seqlock with adding wait
annotation on read side of seqlock.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/seqlock.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 37ded6b..35929c9 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -23,6 +23,13 @@
 
 #include <asm/processor.h>
 
+#ifdef CONFIG_DEPT
+#define DEPT_EVT_ALL		((1UL << DEPT_MAX_SUBCLASSES_EVT) - 1)
+#define dept_seq_wait(m, ip)	dept_wait(m, DEPT_EVT_ALL, ip, __func__, 0)
+#else
+#define dept_seq_wait(m, ip)	do { } while (0)
+#endif
+
 /*
  * The seqlock seqcount_t interface does not prescribe a precise sequence of
  * read begin/retry/end. For readers, typically there is a call to
@@ -148,7 +155,7 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * This lock-unlock technique must be implemented for all of PREEMPT_RT
  * sleeping locks.  See Documentation/locking/locktypes.rst
  */
-#if defined(CONFIG_LOCKDEP) || defined(CONFIG_PREEMPT_RT)
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_DEPT) || defined(CONFIG_PREEMPT_RT)
 #define __SEQ_LOCK(expr)	expr
 #else
 #define __SEQ_LOCK(expr)
@@ -203,6 +210,12 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 	__SEQ_LOCK(locktype	*lock);					\
 } seqcount_##lockname##_t;						\
 									\
+static __always_inline void						\
+__seqprop_##lockname##_wait(const seqcount_##lockname##_t *s)		\
+{									\
+	__SEQ_LOCK(dept_seq_wait(&(lockmember)->dep_map.dmap, _RET_IP_));\
+}									\
+									\
 static __always_inline seqcount_t *					\
 __seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
@@ -271,6 +284,8 @@ static inline void __seqprop_assert(const seqcount_t *s)
 	lockdep_assert_preemption_disabled();
 }
 
+static inline void __seqprop_wait(const seqcount_t *s) { }
+
 #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
 
 SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
@@ -311,6 +326,7 @@ static inline void __seqprop_assert(const seqcount_t *s)
 #define seqprop_sequence(s)		__seqprop(s, sequence)
 #define seqprop_preemptible(s)		__seqprop(s, preemptible)
 #define seqprop_assert(s)		__seqprop(s, assert)
+#define seqprop_dept_wait(s)		__seqprop(s, wait)
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
@@ -360,6 +376,7 @@ static inline void __seqprop_assert(const seqcount_t *s)
 #define read_seqcount_begin(s)						\
 ({									\
 	seqcount_lockdep_reader_access(seqprop_ptr(s));			\
+	seqprop_dept_wait(s);						\
 	raw_read_seqcount_begin(s);					\
 })
 
-- 
1.9.1

