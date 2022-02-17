Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D6C4B9E3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 12:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbiBQK6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 05:58:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiBQK6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:58:44 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27CD5297206
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 02:58:01 -0800 (PST)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 17 Feb 2022 19:58:00 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 17 Feb 2022 19:58:00 +0900
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
Subject: [PATCH 12/16] dept: Apply Dept to wait/event of PG_{locked,writeback}
Date:   Thu, 17 Feb 2022 19:57:48 +0900
Message-Id: <1645095472-26530-13-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by PG_{locked,writeback}. For
instance, (un)lock_page() generates that type of dependency.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/dept_page.h       | 78 +++++++++++++++++++++++++++++++++++++++++
 include/linux/page-flags.h      | 45 ++++++++++++++++++++++--
 include/linux/pagemap.h         |  7 +++-
 init/main.c                     |  2 ++
 kernel/dependency/dept_object.h |  2 +-
 lib/Kconfig.debug               |  1 +
 mm/filemap.c                    | 68 +++++++++++++++++++++++++++++++++++
 mm/page_ext.c                   |  5 +++
 8 files changed, 204 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/dept_page.h

diff --git a/include/linux/dept_page.h b/include/linux/dept_page.h
new file mode 100644
index 0000000..d2d093d
--- /dev/null
+++ b/include/linux/dept_page.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_DEPT_PAGE_H
+#define __LINUX_DEPT_PAGE_H
+
+#ifdef CONFIG_DEPT
+#include <linux/dept.h>
+
+extern struct page_ext_operations dept_pglocked_ops;
+extern struct page_ext_operations dept_pgwriteback_ops;
+extern struct dept_map_common pglocked_mc;
+extern struct dept_map_common pgwriteback_mc;
+
+extern void dept_page_init(void);
+extern struct dept_map_each *get_pglocked_me(struct page *page);
+extern struct dept_map_each *get_pgwriteback_me(struct page *page);
+
+#define dept_pglocked_wait(f)					\
+do {								\
+	struct dept_map_each *me = get_pglocked_me(&(f)->page);	\
+								\
+	if (likely(me))						\
+		dept_wait_split_map(me, &pglocked_mc, _RET_IP_, \
+				    __func__, 0);		\
+} while (0)
+
+#define dept_pglocked_set_bit(f)				\
+do {								\
+	struct dept_map_each *me = get_pglocked_me(&(f)->page);	\
+								\
+	if (likely(me))						\
+		dept_ask_event_split_map(me, &pglocked_mc);	\
+} while (0)
+
+#define dept_pglocked_event(f)					\
+do {								\
+	struct dept_map_each *me = get_pglocked_me(&(f)->page);	\
+								\
+	if (likely(me))						\
+		dept_event_split_map(me, &pglocked_mc, _RET_IP_,\
+				     __func__);			\
+} while (0)
+
+#define dept_pgwriteback_wait(f)				\
+do {								\
+	struct dept_map_each *me = get_pgwriteback_me(&(f)->page);\
+								\
+	if (likely(me))						\
+		dept_wait_split_map(me, &pgwriteback_mc, _RET_IP_,\
+				    __func__, 0);		\
+} while (0)
+
+#define dept_pgwriteback_set_bit(f)				\
+do {								\
+	struct dept_map_each *me = get_pgwriteback_me(&(f)->page);\
+								\
+	if (likely(me))						\
+		dept_ask_event_split_map(me, &pgwriteback_mc);\
+} while (0)
+
+#define dept_pgwriteback_event(f)				\
+do {								\
+	struct dept_map_each *me = get_pgwriteback_me(&(f)->page);\
+								\
+	if (likely(me))						\
+		dept_event_split_map(me, &pgwriteback_mc, _RET_IP_,\
+				     __func__);			\
+} while (0)
+#else
+#define dept_page_init()		do { } while (0)
+#define dept_pglocked_wait(f)		do { } while (0)
+#define dept_pglocked_set_bit(f)	do { } while (0)
+#define dept_pglocked_event(f)		do { } while (0)
+#define dept_pgwriteback_wait(f)	do { } while (0)
+#define dept_pgwriteback_set_bit(f)	do { } while (0)
+#define dept_pgwriteback_event(f)	do { } while (0)
+#endif
+
+#endif /* __LINUX_DEPT_PAGE_H */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c3b6e5..066b6a5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -411,7 +411,6 @@ static unsigned long *folio_flags(struct folio *folio, unsigned n)
 #define TESTSCFLAG_FALSE(uname, lname)					\
 	TESTSETFLAG_FALSE(uname, lname) TESTCLEARFLAG_FALSE(uname, lname)
 
-__PAGEFLAG(Locked, locked, PF_NO_TAIL)
 PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
 PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
 PAGEFLAG(Referenced, referenced, PF_HEAD)
@@ -459,7 +458,6 @@ static unsigned long *folio_flags(struct folio *folio, unsigned n)
  * risky: they bypass page accounting.
  */
 TESTPAGEFLAG(Writeback, writeback, PF_NO_TAIL)
-	TESTSCFLAG(Writeback, writeback, PF_NO_TAIL)
 PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
 
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
@@ -542,6 +540,49 @@ static __always_inline bool PageSwapCache(struct page *page)
 PAGEFLAG_FALSE(SkipKASanPoison, skip_kasan_poison)
 #endif
 
+#ifdef CONFIG_DEPT
+TESTPAGEFLAG(Locked, locked, PF_NO_TAIL)
+__CLEARPAGEFLAG(Locked, locked, PF_NO_TAIL)
+TESTCLEARFLAG(Writeback, writeback, PF_NO_TAIL)
+
+#include <linux/dept_page.h>
+
+static __always_inline
+void __folio_set_locked(struct folio *folio)
+{
+	dept_pglocked_set_bit(folio);
+	__set_bit(PG_locked, folio_flags(folio, FOLIO_PF_NO_TAIL));
+}
+
+static __always_inline void __SetPageLocked(struct page *page)
+{
+	dept_pglocked_set_bit(page_folio(page));
+	__set_bit(PG_locked, &PF_NO_TAIL(page, 1)->flags);
+}
+
+static __always_inline
+bool folio_test_set_writeback(struct folio *folio)
+{
+	bool ret = test_and_set_bit(PG_writeback, folio_flags(folio, FOLIO_PF_NO_TAIL));
+
+	if (!ret)
+		dept_pgwriteback_set_bit(folio);
+	return ret;
+}
+
+static __always_inline int TestSetPageWriteback(struct page *page)
+{
+	int ret = test_and_set_bit(PG_writeback, &PF_NO_TAIL(page, 1)->flags);
+
+	if (!ret)
+		dept_pgwriteback_set_bit(page_folio(page));
+	return ret;
+}
+#else
+__PAGEFLAG(Locked, locked, PF_NO_TAIL)
+TESTSCFLAG(Writeback, writeback, PF_NO_TAIL)
+#endif
+
 /*
  * PageReported() is used to track reported free pages within the Buddy
  * allocator. We can use the non-atomic version of the test and set
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 270bf51..9ff11a1 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -15,6 +15,7 @@
 #include <linux/bitops.h>
 #include <linux/hardirq.h> /* for in_interrupt() */
 #include <linux/hugetlb_inline.h>
+#include <linux/dept_page.h>
 
 struct folio_batch;
 
@@ -761,7 +762,11 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 
 static inline bool folio_trylock(struct folio *folio)
 {
-	return likely(!test_and_set_bit_lock(PG_locked, folio_flags(folio, 0)));
+	int ret = test_and_set_bit_lock(PG_locked, folio_flags(folio, 0));
+
+	if (likely(!ret))
+		dept_pglocked_set_bit(folio);
+	return likely(!ret);
 }
 
 /*
diff --git a/init/main.c b/init/main.c
index ca96e11..4818c75 100644
--- a/init/main.c
+++ b/init/main.c
@@ -100,6 +100,7 @@
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
+#include <linux/pagemap.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -1072,6 +1073,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 
 	lockdep_init();
 	dept_init();
+	dept_page_init();
 
 	/*
 	 * Need to run this when irqs are enabled, because it wants
diff --git a/kernel/dependency/dept_object.h b/kernel/dependency/dept_object.h
index ad5ff57..f3f1cfe 100644
--- a/kernel/dependency/dept_object.h
+++ b/kernel/dependency/dept_object.h
@@ -6,7 +6,7 @@
  * nr: # of the object that should be kept in the pool.
  */
 
-OBJECT(dep, 1024 * 8)
+OBJECT(dep, 1024 * 16)
 OBJECT(class, 1024 * 4)
 OBJECT(stack, 1024 * 32)
 OBJECT(ecxt, 1024 * 4)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 309b275..c7c2510 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1242,6 +1242,7 @@ config DEPT
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
+	select PAGE_EXTENSION
 	select TRACE_IRQFLAGS
 	select STACKTRACE
 	select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86
diff --git a/mm/filemap.c b/mm/filemap.c
index ad8c39d..4f004c4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1148,6 +1148,11 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 	unsigned long flags;
 	wait_queue_entry_t bookmark;
 
+	if (bit_nr == PG_locked)
+		dept_pglocked_event(folio);
+	else if (bit_nr == PG_writeback)
+		dept_pgwriteback_event(folio);
+
 	key.folio = folio;
 	key.bit_nr = bit_nr;
 	key.page_match = 0;
@@ -1227,6 +1232,10 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
 		if (test_and_set_bit(bit_nr, &folio->flags))
 			return false;
+		else if (bit_nr == PG_locked)
+			dept_pglocked_set_bit(folio);
+		else if (bit_nr == PG_writeback)
+			dept_pgwriteback_set_bit(folio);
 	} else if (test_bit(bit_nr, &folio->flags))
 		return false;
 
@@ -1248,6 +1257,11 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	bool delayacct = false;
 	unsigned long pflags;
 
+	if (bit_nr == PG_locked)
+		dept_pglocked_wait(folio);
+	else if (bit_nr == PG_writeback)
+		dept_pgwriteback_wait(folio);
+
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
 		if (!folio_test_swapbacked(folio)) {
@@ -1340,6 +1354,11 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		if (unlikely(test_and_set_bit(bit_nr, folio_flags(folio, 0))))
 			goto repeat;
 
+		if (bit_nr == PG_locked)
+			dept_pglocked_set_bit(folio);
+		else if (bit_nr == PG_writeback)
+			dept_pgwriteback_set_bit(folio);
+
 		wait->flags |= WQ_FLAG_DONE;
 		break;
 	}
@@ -3960,3 +3979,52 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 	return try_to_free_buffers(&folio->page);
 }
 EXPORT_SYMBOL(filemap_release_folio);
+
+#ifdef CONFIG_DEPT
+static bool need_dept_pglocked(void)
+{
+	return true;
+}
+
+struct page_ext_operations dept_pglocked_ops = {
+	.size = sizeof(struct dept_map_each),
+	.need = need_dept_pglocked,
+};
+
+struct dept_map_each *get_pglocked_me(struct page *p)
+{
+	struct page_ext *e = lookup_page_ext(p);
+
+	return e ? (void *)e + dept_pglocked_ops.offset : NULL;
+}
+EXPORT_SYMBOL(get_pglocked_me);
+
+static bool need_dept_pgwriteback(void)
+{
+	return true;
+}
+
+struct page_ext_operations dept_pgwriteback_ops = {
+	.size = sizeof(struct dept_map_each),
+	.need = need_dept_pgwriteback,
+};
+
+struct dept_map_each *get_pgwriteback_me(struct page *p)
+{
+	struct page_ext *e = lookup_page_ext(p);
+
+	return e ? (void *)e + dept_pgwriteback_ops.offset : NULL;
+}
+EXPORT_SYMBOL(get_pgwriteback_me);
+
+struct dept_map_common pglocked_mc;
+EXPORT_SYMBOL(pglocked_mc);
+struct dept_map_common pgwriteback_mc;
+EXPORT_SYMBOL(pgwriteback_mc);
+
+void dept_page_init(void)
+{
+	dept_split_map_common_init(&pglocked_mc, NULL, "pglocked");
+	dept_split_map_common_init(&pgwriteback_mc, NULL, "pgwriteback");
+}
+#endif
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 2e66d93..b7f5b0d 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -9,6 +9,7 @@
 #include <linux/page_owner.h>
 #include <linux/page_idle.h>
 #include <linux/page_table_check.h>
+#include <linux/dept_page.h>
 
 /*
  * struct page extension
@@ -79,6 +80,10 @@ static bool need_page_idle(void)
 #ifdef CONFIG_PAGE_TABLE_CHECK
 	&page_table_check_ops,
 #endif
+#ifdef CONFIG_DEPT
+	&dept_pglocked_ops,
+	&dept_pgwriteback_ops,
+#endif
 };
 
 unsigned long page_ext_size = sizeof(struct page_ext);
-- 
1.9.1

