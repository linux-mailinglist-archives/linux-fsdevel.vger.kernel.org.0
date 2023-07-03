Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB874591E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjGCJuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjGCJuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:50:01 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FC04BE;
        Mon,  3 Jul 2023 02:49:57 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-6b-64a299b4c184
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
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
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 rebased on v6.4 25/25] dept: Track the potential waits of PG_{locked,writeback}
Date:   Mon,  3 Jul 2023 18:47:52 +0900
Message-Id: <20230703094752.79269-26-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxiGfc/Hew7FmrNq9Kg/po0MUzIFI/rEODXR6JsYE42JJjqj1Z7Y
        ZoDaIoofsVoUrYJg5EsQKc6uaTvBgqZTwA4URaJUQS0EiBAEG760rISvTSlmf55cue/c16+H
        pxVudh6vS0iU9AnqOCWWMbL+6Zaf7+cVa6J9xoWQeSUagv9cZKCgxInBe9eBwFl+lgL/003w
        frgPwfjLBhpysrwILB1tNJTXtiOotJ3D0Ng1A5qCgxjqsi5jMN0uwfC6d4KC1uxrFDhcW6A+
        o5gCz2gPAzl+DPk5JmryfKJg1GrnwGqMgE7bDQ4mOmKgrv0dC5UtUZBX2IqhorKOgVp3JwWN
        DwswtDu/slBf+5wBb2YaC38OFGPoHbbSYA0OcvDGU0RBacqk6MLQfyw8S/NQcOH3exQ0NT9C
        UHXxAwUu5zsMNcE+CspcWTSM/fEUQWd6Pwfnr4xykH82HcHl89kMNPz7jIWU1lgYHynA61aR
        mr5BmqSUHSOVw0UMeVEskr9utHEkpaqFI0Wuo6TMpiK3K/wUsQSCLHHZL2HiClzjiLm/iSID
        r15x5HnuOEO6mnKorfN3yVZrpDhdkqRfumafTPvevONw287jQ4UrjCiXmBHPi8JyscF/xozC
        prA5cJULMRYiRZ9vlA7xLGGBWJbWzZqRjKeF1HDR9vklDhUzhQOixTMwNWCECLHq0ecplgsr
        xIeNQ+x36Y+io9QzJQqbzD+OpKMQK4RYsTWvHYekomAKE8f68unvg7ni3zYfk4HkRWiaHSl0
        CUnxal3c8iXa5ATd8SUHDsW70OQ/WU9P7HajgHd7NRJ4pJwu9520aBSsOsmQHF+NRJ5WzpKb
        Om5pFHKNOvmEpD+0V380TjJUo/k8o5wjXzZ8TKMQDqoTpd8k6bCk/7+l+LB5RrTYsWFmT8XI
        Ro1w5+vsJ0NH9rcw3frrO2r2TWxS1RqdJr+9xdmgLWm+1+OO/rjdcVKMcC/y1melRvpK7apf
        E3N/0fZmZyoN/Xnxp2PXM4tqvoR3wVj3qYyYhaqVdunLDzOchbbNFWtL3Tgy6W1U4HH4T4XJ
        7AO7a2/qNsm552a4kjFo1TEqWm9QfwNgMMjtSwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRiGe9/vNFeLryX0UVEx6GxmmPaAYRGVL4HVDymKoEb7yOGcspVp
        UVhT85CHWWqmmdOYonaa0mlpQ1Ez8VAzM1PJdVI8lTpxaQc1+vNwcd/c169HQslzmKUStfa0
        qNMqNQpWSkv3+xk2VWQXqLxSx73BeNULnOPxNOTeL2Oh9V4pgrKKSxj6awPg3cQggqmmFgqy
        MloRmHq7Kaio60FQWXyZBfvnhdDmHGGhISOJBUPhfRZeD0xj6MpMx1BqCYTGtAIMNtc3GrL6
        WcjJMuCZ04fBZS7hwBy9GhzFNzmY7t0CDT3tDNTcamCgsnMjZOd1sfC8soGGuicODPZnuSz0
        lP1hoLHuJQ2txmQG7g4XsDAwYabA7Bzh4I0tH8ODmBlb3NhvBuqTbRji7jzE0PbeiqAq/iMG
        S1k7CzXOQQzllgwKfhbVInCkDHEQe9XFQc6lFARJsZk0tPyqZyCmywemJnPZnX6kZnCEIjHl
        Z0nlRD5NXhUI5OnNbo7EVHVyJN9yhpQXbyCFz/sxMY06GWIpSWCJZTSdI4lDbZgMNzdz5OWN
        KZp8bsvCB5cflW5XiRp1hKjb7H9CGvwu8VB49+HIsTzfaHSDJCI3icBvFd6PpnKzzPJrhY4O
        FzXL7vwqoTz5K5OIpBKKvzJfKP7exM4Wi/mTgsk2PDeg+dVClfX7HMt4X+GZfYz5J10plD6w
        zYncZvIvkyloluW8j9CV3cOmIWk+mleC3NXaiFClWuPjqQ8JjtKqIz1PhoVa0MzLmC9MG5+g
        cXtANeIlSLFA1nHepJIzygh9VGg1EiSUwl1m6L2tkstUyqhzoi7suO6MRtRXo2USWrFEtu+w
        eELOn1KeFkNEMVzU/W+xxG1pNDricXH3nseu2rg1CZ3dfS/q431/HDfXmUiRdVeNMPRoYJu3
        wvg2Muit3ZFRmrAoemIFSa0/1Woscnj7EQ+PuLPXA7E6hB9qWrj+wLrhyL5fj0ZeHcu+vVG7
        ffneTzs0tH+sq/FDs7/sTmbarjef1gZ6BJgHPYMMk4esP661i4vNVgWtD1Zu2UDp9Mq/vizu
        8S4DAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, Dept only tracks the real waits of PG_{locked,writeback} that
actually happened having gone through __schedule() to avoid false
positives. However, it ends in limited capacity for deadlock detection,
because anyway there might be still way more potential dependencies by
the waits that have yet to happen but may happen in the future so as to
cause a deadlock.

So let Dept assume that when PG_{locked,writeback} bit gets cleared,
there might be waits on the bit to be woken up.

Even though false positives may increase with the aggressive tracking,
it's worth doing it because it's going to be useful in practice. See the
following link for instance:

   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h   |   3 +
 include/linux/page-flags.h | 112 +++++++++++++++++++++++++++++++++----
 include/linux/pagemap.h    |   7 ++-
 mm/filemap.c               |  11 +++-
 mm/mm_init.c               |   3 +
 5 files changed, 121 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..ac5048b66e5c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
+#include <linux/dept.h>
 
 #include <asm/mmu.h>
 
@@ -228,6 +229,8 @@ struct page {
 #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
 	int _last_cpupid;
 #endif
+	struct dept_ext_wgen PG_locked_wgen;
+	struct dept_ext_wgen PG_writeback_wgen;
 } _struct_page_alignment;
 
 /*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 92a2063a0a23..d91e67ed194c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -196,6 +196,50 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
+#ifdef CONFIG_DEPT
+#include <linux/kernel.h>
+#include <linux/dept.h>
+
+extern struct dept_map PG_locked_map;
+extern struct dept_map PG_writeback_map;
+
+/*
+ * Place the following annotations in its suitable point in code:
+ *
+ *	Annotate dept_page_set_bit() around firstly set_bit*()
+ *	Annotate dept_page_clear_bit() around clear_bit*()
+ *	Annotate dept_page_wait_on_bit() around wait_on_bit*()
+ */
+
+static inline void dept_page_set_bit(struct page *p, int bit_nr)
+{
+	if (bit_nr == PG_locked)
+		dept_request_event(&PG_locked_map, &p->PG_locked_wgen);
+	else if (bit_nr == PG_writeback)
+		dept_request_event(&PG_writeback_map, &p->PG_writeback_wgen);
+}
+
+static inline void dept_page_clear_bit(struct page *p, int bit_nr)
+{
+	if (bit_nr == PG_locked)
+		dept_event(&PG_locked_map, 1UL, _RET_IP_, __func__, &p->PG_locked_wgen);
+	else if (bit_nr == PG_writeback)
+		dept_event(&PG_writeback_map, 1UL, _RET_IP_, __func__, &p->PG_writeback_wgen);
+}
+
+static inline void dept_page_wait_on_bit(struct page *p, int bit_nr)
+{
+	if (bit_nr == PG_locked)
+		dept_wait(&PG_locked_map, 1UL, _RET_IP_, __func__, 0, -1L);
+	else if (bit_nr == PG_writeback)
+		dept_wait(&PG_writeback_map, 1UL, _RET_IP_, __func__, 0, -1L);
+}
+#else
+#define dept_page_set_bit(p, bit_nr)		do { } while (0)
+#define dept_page_clear_bit(p, bit_nr)		do { } while (0)
+#define dept_page_wait_on_bit(p, bit_nr)	do { } while (0)
+#endif
+
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 
@@ -377,44 +421,88 @@ static __always_inline int Page##uname(struct page *page)		\
 #define SETPAGEFLAG(uname, lname, policy)				\
 static __always_inline							\
 void folio_set_##lname(struct folio *folio)				\
-{ set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }		\
+{									\
+	set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy));	\
+	dept_page_set_bit(&folio->page, PG_##lname);			\
+}									\
 static __always_inline void SetPage##uname(struct page *page)		\
-{ set_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	set_bit(PG_##lname, &policy(page, 1)->flags);			\
+	dept_page_set_bit(page, PG_##lname);				\
+}
 
 #define CLEARPAGEFLAG(uname, lname, policy)				\
 static __always_inline							\
 void folio_clear_##lname(struct folio *folio)				\
-{ clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }		\
+{									\
+	clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy));	\
+	dept_page_clear_bit(&folio->page, PG_##lname);			\
+}									\
 static __always_inline void ClearPage##uname(struct page *page)		\
-{ clear_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	clear_bit(PG_##lname, &policy(page, 1)->flags);			\
+	dept_page_clear_bit(page, PG_##lname);				\
+}
 
 #define __SETPAGEFLAG(uname, lname, policy)				\
 static __always_inline							\
 void __folio_set_##lname(struct folio *folio)				\
-{ __set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }		\
+{									\
+	__set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy));	\
+	dept_page_set_bit(&folio->page, PG_##lname);			\
+}									\
 static __always_inline void __SetPage##uname(struct page *page)		\
-{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	__set_bit(PG_##lname, &policy(page, 1)->flags);			\
+	dept_page_set_bit(page, PG_##lname);				\
+}
 
 #define __CLEARPAGEFLAG(uname, lname, policy)				\
 static __always_inline							\
 void __folio_clear_##lname(struct folio *folio)				\
-{ __clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); }	\
+{									\
+	__clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy));	\
+	dept_page_clear_bit(&folio->page, PG_##lname);			\
+}									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
-{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	__clear_bit(PG_##lname, &policy(page, 1)->flags);		\
+	dept_page_clear_bit(page, PG_##lname);				\
+}
 
 #define TESTSETFLAG(uname, lname, policy)				\
 static __always_inline							\
 bool folio_test_set_##lname(struct folio *folio)			\
-{ return test_and_set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
+{									\
+	bool ret = test_and_set_bit(PG_##lname, folio_flags(folio, FOLIO_##policy));\
+	if (!ret)							\
+		dept_page_set_bit(&folio->page, PG_##lname);		\
+	return ret;							\
+}									\
 static __always_inline int TestSetPage##uname(struct page *page)	\
-{ return test_and_set_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	bool ret = test_and_set_bit(PG_##lname, &policy(page, 1)->flags);\
+	if (!ret)							\
+		dept_page_set_bit(page, PG_##lname);			\
+	return ret;							\
+}
 
 #define TESTCLEARFLAG(uname, lname, policy)				\
 static __always_inline							\
 bool folio_test_clear_##lname(struct folio *folio)			\
-{ return test_and_clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy)); } \
+{									\
+	bool ret = test_and_clear_bit(PG_##lname, folio_flags(folio, FOLIO_##policy));\
+	if (ret)							\
+		dept_page_clear_bit(&folio->page, PG_##lname);		\
+	return ret;							\
+}									\
 static __always_inline int TestClearPage##uname(struct page *page)	\
-{ return test_and_clear_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	bool ret = test_and_clear_bit(PG_##lname, &policy(page, 1)->flags);\
+	if (ret)							\
+		dept_page_clear_bit(page, PG_##lname);			\
+	return ret;							\
+}
 
 #define PAGEFLAG(uname, lname, policy)					\
 	TESTPAGEFLAG(uname, lname, policy)				\
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a56308a9d1a4..a88e2430f415 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -915,7 +915,12 @@ void folio_unlock(struct folio *folio);
  */
 static inline bool folio_trylock(struct folio *folio)
 {
-	return likely(!test_and_set_bit_lock(PG_locked, folio_flags(folio, 0)));
+	bool ret = !test_and_set_bit_lock(PG_locked, folio_flags(folio, 0));
+
+	if (ret)
+		dept_page_set_bit(&folio->page, PG_locked);
+
+	return likely(ret);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index eed64dc88e43..f05208bb50dc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1101,6 +1101,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 		if (flags & WQ_FLAG_CUSTOM) {
 			if (test_and_set_bit(key->bit_nr, &key->folio->flags))
 				return -1;
+			dept_page_set_bit(&key->folio->page, key->bit_nr);
 			flags |= WQ_FLAG_DONE;
 		}
 	}
@@ -1210,6 +1211,7 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
 		if (test_and_set_bit(bit_nr, &folio->flags))
 			return false;
+		dept_page_set_bit(&folio->page, bit_nr);
 	} else if (test_bit(bit_nr, &folio->flags))
 		return false;
 
@@ -1220,8 +1222,10 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 /* How many times do we accept lock stealing from under a waiter? */
 int sysctl_page_lock_unfairness = 5;
 
-static struct dept_map __maybe_unused PG_locked_map = DEPT_MAP_INITIALIZER(PG_locked_map, NULL);
-static struct dept_map __maybe_unused PG_writeback_map = DEPT_MAP_INITIALIZER(PG_writeback_map, NULL);
+struct dept_map __maybe_unused PG_locked_map = DEPT_MAP_INITIALIZER(PG_locked_map, NULL);
+struct dept_map __maybe_unused PG_writeback_map = DEPT_MAP_INITIALIZER(PG_writeback_map, NULL);
+EXPORT_SYMBOL(PG_locked_map);
+EXPORT_SYMBOL(PG_writeback_map);
 
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
@@ -1234,6 +1238,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	unsigned long pflags;
 	bool in_thrashing;
 
+	dept_page_wait_on_bit(&folio->page, bit_nr);
 	if (bit_nr == PG_locked)
 		sdt_might_sleep_start(&PG_locked_map);
 	else if (bit_nr == PG_writeback)
@@ -1331,6 +1336,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		wait->flags |= WQ_FLAG_DONE;
 		break;
 	}
+	dept_page_set_bit(&folio->page, bit_nr);
 
 	/*
 	 * If a signal happened, this 'finish_wait()' may remove the last
@@ -1538,6 +1544,7 @@ void folio_unlock(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	BUILD_BUG_ON(PG_locked > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	dept_page_clear_bit(&folio->page, PG_locked);
 	if (clear_bit_unlock_is_negative_byte(PG_locked, folio_flags(folio, 0)))
 		folio_wake_bit(folio, PG_locked);
 }
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7f7f9c677854..a339f0cbe1b2 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/swap.h>
 #include <linux/cma.h>
+#include <linux/dept.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -558,6 +559,8 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	page_mapcount_reset(page);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
+	dept_ext_wgen_init(&page->PG_locked_wgen);
+	dept_ext_wgen_init(&page->PG_writeback_wgen);
 
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
-- 
2.17.1

