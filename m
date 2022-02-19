Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1674BC7F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 12:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbiBSK7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 05:59:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiBSK7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:59:11 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 985D269CD5
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 02:58:43 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 19 Feb 2022 19:58:43 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 19 Feb 2022 19:58:42 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
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
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: [PATCH v2 09/18] dept: Apply Dept to seqlock
Date:   Sat, 19 Feb 2022 19:58:22 +0900
Message-Id: <1645268311-24222-10-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1645268311-24222-1-git-send-email-byungchul.park@lge.com>
References: <1645268311-24222-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by seqlock with adding wait
annotation on read side of seqlock.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/seqlock.h | 59 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 37ded6b..6e8ecd7 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -23,6 +23,25 @@
 
 #include <asm/processor.h>
 
+#ifdef CONFIG_DEPT
+#define DEPT_EVT_ALL		((1UL << DEPT_MAX_SUBCLASSES_EVT) - 1)
+#define dept_seq_wait(m, ip)	dept_wait(m, DEPT_EVT_ALL, ip, __func__, 0)
+#define dept_seq_writebegin(m, ip)				\
+do {								\
+	dept_ecxt_enter(m, 1UL, ip, __func__, "write_seqcount_end", 0);\
+	dept_ask_event(m);					\
+} while (0)
+#define dept_seq_writeend(m, ip)				\
+do {								\
+	dept_event(m, 1UL, ip, __func__);			\
+	dept_ecxt_exit(m, ip);					\
+} while (0)
+#else
+#define dept_seq_wait(m, ip)		do { } while (0)
+#define dept_seq_writebegin(m, ip)	do { } while (0)
+#define dept_seq_writeend(m, ip)	do { } while (0)
+#endif
+
 /*
  * The seqlock seqcount_t interface does not prescribe a precise sequence of
  * read begin/retry/end. For readers, typically there is a call to
@@ -148,7 +167,7 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * This lock-unlock technique must be implemented for all of PREEMPT_RT
  * sleeping locks.  See Documentation/locking/locktypes.rst
  */
-#if defined(CONFIG_LOCKDEP) || defined(CONFIG_PREEMPT_RT)
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_DEPT) || defined(CONFIG_PREEMPT_RT)
 #define __SEQ_LOCK(expr)	expr
 #else
 #define __SEQ_LOCK(expr)
@@ -203,6 +222,22 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 	__SEQ_LOCK(locktype	*lock);					\
 } seqcount_##lockname##_t;						\
 									\
+static __always_inline void						\
+__seqprop_##lockname##_wait(const seqcount_##lockname##_t *s)		\
+{									\
+	__SEQ_LOCK(dept_seq_wait(&(lockmember)->dep_map.dmap, _RET_IP_));\
+}									\
+									\
+static __always_inline void						\
+__seqprop_##lockname##_writebegin(const seqcount_##lockname##_t *s)	\
+{									\
+}									\
+									\
+static __always_inline void						\
+__seqprop_##lockname##_writeend(const seqcount_##lockname##_t *s)	\
+{									\
+}									\
+									\
 static __always_inline seqcount_t *					\
 __seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
@@ -271,6 +306,21 @@ static inline void __seqprop_assert(const seqcount_t *s)
 	lockdep_assert_preemption_disabled();
 }
 
+static inline void __seqprop_wait(seqcount_t *s)
+{
+	dept_seq_wait(&s->dep_map.dmap, _RET_IP_);
+}
+
+static inline void __seqprop_writebegin(seqcount_t *s)
+{
+	dept_seq_writebegin(&s->dep_map.dmap, _RET_IP_);
+}
+
+static inline void __seqprop_writeend(seqcount_t *s)
+{
+	dept_seq_writeend(&s->dep_map.dmap, _RET_IP_);
+}
+
 #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
 
 SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
@@ -311,6 +361,9 @@ static inline void __seqprop_assert(const seqcount_t *s)
 #define seqprop_sequence(s)		__seqprop(s, sequence)
 #define seqprop_preemptible(s)		__seqprop(s, preemptible)
 #define seqprop_assert(s)		__seqprop(s, assert)
+#define seqprop_dept_wait(s)		__seqprop(s, wait)
+#define seqprop_dept_writebegin(s)	__seqprop(s, writebegin)
+#define seqprop_dept_writeend(s)	__seqprop(s, writeend)
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
@@ -360,6 +413,7 @@ static inline void __seqprop_assert(const seqcount_t *s)
 #define read_seqcount_begin(s)						\
 ({									\
 	seqcount_lockdep_reader_access(seqprop_ptr(s));			\
+	seqprop_dept_wait(s);						\
 	raw_read_seqcount_begin(s);					\
 })
 
@@ -512,6 +566,7 @@ static inline void do_raw_write_seqcount_end(seqcount_t *s)
 		preempt_disable();					\
 									\
 	do_write_seqcount_begin_nested(seqprop_ptr(s), subclass);	\
+	seqprop_dept_writebegin(s);					\
 } while (0)
 
 static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
@@ -538,6 +593,7 @@ static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 		preempt_disable();					\
 									\
 	do_write_seqcount_begin(seqprop_ptr(s));			\
+	seqprop_dept_writebegin(s);					\
 } while (0)
 
 static inline void do_write_seqcount_begin(seqcount_t *s)
@@ -554,6 +610,7 @@ static inline void do_write_seqcount_begin(seqcount_t *s)
  */
 #define write_seqcount_end(s)						\
 do {									\
+	seqprop_dept_writeend(s);					\
 	do_write_seqcount_end(seqprop_ptr(s));				\
 									\
 	if (seqprop_preemptible(s))					\
-- 
1.9.1

