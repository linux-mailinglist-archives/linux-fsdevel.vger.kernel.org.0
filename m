Return-Path: <linux-fsdevel+bounces-49366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ED4ABB939
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8284F189EC93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCEE280CF6;
	Mon, 19 May 2025 09:19:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093762701C8;
	Mon, 19 May 2025 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646341; cv=none; b=sYFyhOJRMZqGbTqYYj0JgvCbwPUpLeXYbvuz31V3M+R3BuMsEy6WjmYyV+umBHnwqC75tBLKgZwRKhgYhKFf09c0jkQxq8H/vorydn8STKtDmt6QvHErJWI/9stc5q5o6x6a83IEUusStH3Q9Kw43xJiOfsI8tTEg140l77YWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646341; c=relaxed/simple;
	bh=eqhIu4Ytfemwyxgng3iHH4sQt4GfdE3Wth8zaCAgCgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=f3rnHNbmzAtyTv7fivOFuDTJH8PpRHpn9OZRJsD9WZ3uM4e16OB3BRzZHMiRwCMEhSgUxp1yGeO42ypLHC/bLEKkPNQ9kKxWuz4PWbzCZ4no6yttJvICk29oG80D1xDYHV1h9i+CyRFPmlzYv7/n61uwrTL1qHIdY0zkUUdEdXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-5e-682af76f6d09
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
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v16 25/42] dept: track PG_locked with dept
Date: Mon, 19 May 2025 18:18:09 +0900
Message-Id: <20250519091826.19752-26-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfd47leprR9wrLrrVuDlUFIJ4YtQtJmaPLrol24dlftAqb2y1
	XFIUxUQtcgmDQeqlVLFiC6MyWqC2xKCjBGFUwBsqtsCgm3jZkJuptgiCrmD8cvLL/5/zO18O
	R8pa6UhOlXRA1CQp1HJGQkmGw80rk8eilKufemMh8CqXAmONjYGOaisCW20GAQMt34A3OITg
	ze27JBj0HQjMj/pIqHX7ELgqTjDw4Mkc6AyMMtCmz2cgs6yGgXuDkwT0Fp0iwOrYBn9bnlFw
	U1dKgGGAgfOGTCI0/iNg3FLJgkW7FPorilmYfBQDbT4PDa6e5XCupJeBelcbBe66fgIeXDMy
	4LO9o+Gmu5WCYOFC6DhZQEPVSCkDg0ELCZbAKAv3G00EuE3zwZ4VEua8fEvDjYJGAnJ+u0xA
	Z/cfCBpy/yHAYfMw0BwYIsDp0JMwcakFQX/hMAvZv46zcD6jEEF+dhEFWb1r4M3r0OULr2Ig
	46KdgqopD/p6A7aV2BBuHholcZbzEJ4IPGSwK2iicHupgK8W97E4q6GHxSbHQeysiMJl9QME
	NvsDNHZU/sJgh/8Ui/OGOwk8cucO+/0nP0vWJ4hqVZqoWbVxl0SZO2WnU1p3Hb7fP0Jpkfa7
	PBTGCXycMNB+lv3AZTdezDDDfyF0dY2T0xzBfyo4C57ReUjCkbxntuC90I2mi4/4dYJ7TEtM
	M8UvFVo8ZTO5lI8XBnuL0HvpYsFqb5wRhYXynvzmmVzGrxE6rSXUtFTgDWFC362n1PuFBcL1
	ii5Kh6QmNKsSyVRJaYkKlTouWpmepDocvSc50YFC/2U5OrmjDvk7fmhCPIfk4VK760uljFak
	paYnNiGBI+UR0krnMqVMmqBIPyJqkndqDqrF1Ca0kKPkH0tjg4cSZPxexQFxvyimiJoPLcGF
	RWqRMv6zl4bN11ui8x47Pk83Z24pNUSW7710zHiuTle+qJosVv+0ZEVaOYvO3HV7rUZdyfzw
	Iz7SQ/nNJ/XGTc+9l7trt85r3z5RNfeKd/W3urHj3O7YiW27F8dn/5mjkqwt/H3ljziY0kPr
	j/v/2jp1NqLq39NxmmjN9iW+r07vGNv3Qk6lKhUxUaQmVfE/ra0sz1sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX+P13H2cxq/iWlnqExkZR8P87jlJ48bZvOPTn78btVld0kZ
	cymkujxsFaVcxcndxXWnrXC0TqdjSOV6WIVjTStldEcP4sr889lrr/f2fv/zEeFSAzlHpFAm
	8iqlPE5GiQnxzjVpSxN+hgjL7U1zwTOUQcCN+yYKGu8ZEZgepGLQW78FWr39CEZfvcEhP7cR
	QcnHLhweOLoR2MrPUtD8eTq0eAYpcOZmUZBWdp+Ct31jGHTmXcXAaNkB7/U9BLy8XIpBfi8F
	hflpmO98wWBYb6BBr1kI7vICGsY+hoGz20WCvchJgq1jCVwv7qTgsc1JgKPajUHzwxsUdJv+
	kPDS0UCANycAGq9oSagYKKWgz6vHQe8ZpKGpVoeBQzcLzOm+1vM/xkl4rq3F4PytSgxa2h8h
	eJLxAQOLyUWB3dOPgdWSi8PInXoE7pyvNJzLHqahMDUHQda5PALSOyNg9JdvuWgoDFJvmgmo
	+O1CG9ZxpmIT4uz9gziXbj3BjXjeUZzNqyO4F6UsV1PQRXPpTzpoTmc5zlnLQ7iyx70YV/Ld
	Q3IWw0WKs3y/SnOZX1swbuD1a3r3vAPitYf5OEUSr1q2LlosZPw2k8caopOb3AOEBml2ZSI/
	EcuEs2XPv9ETTDGL2ba2YXyC/ZlA1qrtITORWIQzrqlsa1E7mghmMqtZx08NNsEEs5Ctd5VN
	egmzku3rzEP/SuezRnPtZJGfz3dk2Se9lIlgW4zFxGUk1qEpBuSvUCbFyxVxEaHqWCFFqUgO
	jUmItyDfB+lPj12pRkPNW+oQI0KyaRKzLViQkvIkdUp8HWJFuMxfYrAGCVLJYXnKSV6VcFB1
	PI5X16EAESGbLYnaz0dLmaPyRD6W54/xqv8pJvKbo0F3nSujSgvnx4bbosJ7cjpqPux1r254
	FLlnVd72bxJlyubI9cLGS9JnimBvW8TW7HtFrk8a4Vp1zbXAqhkzTNqqI2zyoikLNgZqRzzj
	43Vd/TFrbey7bfSzvWTYvqdLrWOHTjQKlZtyE0tODQeciQw9WWG7XWnUXUgaDcpiVhy8dDRb
	RqgFeVgIrlLL/wK/9ilkPQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes dept able to track PG_locked waits and events, which will be
useful in practice.  See the following link that shows dept worked with
PG_locked and detected real issues in practice:

   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h   |   2 +
 include/linux/page-flags.h | 125 +++++++++++++++++++++++++++++++++----
 include/linux/pagemap.h    |  16 ++++-
 mm/filemap.c               |  26 ++++++++
 mm/mm_init.c               |   2 +
 5 files changed, 158 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 56d07edd01f9..7e9d63cef28a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -20,6 +20,7 @@
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
 #include <linux/types.h>
+#include <linux/dept.h>
 
 #include <asm/mmu.h>
 
@@ -224,6 +225,7 @@ struct page {
 	struct page *kmsan_shadow;
 	struct page *kmsan_origin;
 #endif
+	struct dept_ext_wgen pg_locked_wgen;
 } _struct_page_alignment;
 
 /*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index e6a21b62dcce..73cb8a1ad4f3 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -194,6 +194,61 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
+#ifdef CONFIG_DEPT
+#include <linux/kernel.h>
+#include <linux/dept.h>
+
+extern struct dept_map pg_locked_map;
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
+		dept_request_event(&pg_locked_map, &p->pg_locked_wgen);
+}
+
+static inline void dept_page_clear_bit(struct page *p, int bit_nr)
+{
+	if (bit_nr == PG_locked)
+		dept_event(&pg_locked_map, 1UL, _RET_IP_, __func__, &p->pg_locked_wgen);
+}
+
+static inline void dept_page_wait_on_bit(struct page *p, int bit_nr)
+{
+	if (bit_nr == PG_locked)
+		dept_wait(&pg_locked_map, 1UL, _RET_IP_, __func__, 0, -1L);
+}
+
+static inline void dept_folio_set_bit(struct folio *f, int bit_nr)
+{
+	dept_page_set_bit(&f->page, bit_nr);
+}
+
+static inline void dept_folio_clear_bit(struct folio *f, int bit_nr)
+{
+	dept_page_clear_bit(&f->page, bit_nr);
+}
+
+static inline void dept_folio_wait_on_bit(struct folio *f, int bit_nr)
+{
+	dept_page_wait_on_bit(&f->page, bit_nr);
+}
+#else
+#define dept_page_set_bit(p, bit_nr)		do { } while (0)
+#define dept_page_clear_bit(p, bit_nr)		do { } while (0)
+#define dept_page_wait_on_bit(p, bit_nr)	do { } while (0)
+#define dept_folio_set_bit(f, bit_nr)		do { } while (0)
+#define dept_folio_clear_bit(f, bit_nr)		do { } while (0)
+#define dept_folio_wait_on_bit(f, bit_nr)	do { } while (0)
+#endif
+
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 
@@ -415,27 +470,51 @@ static __always_inline bool folio_test_##name(const struct folio *folio) \
 
 #define FOLIO_SET_FLAG(name, page)					\
 static __always_inline void folio_set_##name(struct folio *folio)	\
-{ set_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	set_bit(PG_##name, folio_flags(folio, page));			\
+	dept_folio_set_bit(folio, PG_##name);				\
+}
 
 #define FOLIO_CLEAR_FLAG(name, page)					\
 static __always_inline void folio_clear_##name(struct folio *folio)	\
-{ clear_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	clear_bit(PG_##name, folio_flags(folio, page));			\
+	dept_folio_clear_bit(folio, PG_##name);				\
+}
 
 #define __FOLIO_SET_FLAG(name, page)					\
 static __always_inline void __folio_set_##name(struct folio *folio)	\
-{ __set_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	__set_bit(PG_##name, folio_flags(folio, page));			\
+	dept_folio_set_bit(folio, PG_##name);				\
+}
 
 #define __FOLIO_CLEAR_FLAG(name, page)					\
 static __always_inline void __folio_clear_##name(struct folio *folio)	\
-{ __clear_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	__clear_bit(PG_##name, folio_flags(folio, page));		\
+	dept_folio_clear_bit(folio, PG_##name);				\
+}
 
 #define FOLIO_TEST_SET_FLAG(name, page)					\
 static __always_inline bool folio_test_set_##name(struct folio *folio)	\
-{ return test_and_set_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	bool __ret = test_and_set_bit(PG_##name, folio_flags(folio, page)); \
+									\
+	if (!__ret)							\
+		dept_folio_set_bit(folio, PG_##name);			\
+	return __ret;							\
+}
 
 #define FOLIO_TEST_CLEAR_FLAG(name, page)				\
 static __always_inline bool folio_test_clear_##name(struct folio *folio) \
-{ return test_and_clear_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	bool __ret = test_and_clear_bit(PG_##name, folio_flags(folio, page)); \
+									\
+	if (__ret)							\
+		dept_folio_clear_bit(folio, PG_##name);			\
+	return __ret;							\
+}
 
 #define FOLIO_FLAG(name, page)						\
 FOLIO_TEST_FLAG(name, page)						\
@@ -450,32 +529,54 @@ static __always_inline int Page##uname(const struct page *page)		\
 #define SETPAGEFLAG(uname, lname, policy)				\
 FOLIO_SET_FLAG(lname, FOLIO_##policy)					\
 static __always_inline void SetPage##uname(struct page *page)		\
-{ set_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	set_bit(PG_##lname, &policy(page, 1)->flags);			\
+	dept_page_set_bit(page, PG_##lname);				\
+}
 
 #define CLEARPAGEFLAG(uname, lname, policy)				\
 FOLIO_CLEAR_FLAG(lname, FOLIO_##policy)					\
 static __always_inline void ClearPage##uname(struct page *page)		\
-{ clear_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	clear_bit(PG_##lname, &policy(page, 1)->flags);			\
+	dept_page_clear_bit(page, PG_##lname);				\
+}
 
 #define __SETPAGEFLAG(uname, lname, policy)				\
 __FOLIO_SET_FLAG(lname, FOLIO_##policy)					\
 static __always_inline void __SetPage##uname(struct page *page)		\
-{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	__set_bit(PG_##lname, &policy(page, 1)->flags);			\
+	dept_page_set_bit(page, PG_##lname);				\
+}
 
 #define __CLEARPAGEFLAG(uname, lname, policy)				\
 __FOLIO_CLEAR_FLAG(lname, FOLIO_##policy)				\
 static __always_inline void __ClearPage##uname(struct page *page)	\
-{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	__clear_bit(PG_##lname, &policy(page, 1)->flags);		\
+	dept_page_clear_bit(page, PG_##lname);				\
+}
 
 #define TESTSETFLAG(uname, lname, policy)				\
 FOLIO_TEST_SET_FLAG(lname, FOLIO_##policy)				\
 static __always_inline int TestSetPage##uname(struct page *page)	\
-{ return test_and_set_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	bool ret = test_and_set_bit(PG_##lname, &policy(page, 1)->flags);\
+	if (!ret)							\
+		dept_page_set_bit(page, PG_##lname);			\
+	return ret;							\
+}
 
 #define TESTCLEARFLAG(uname, lname, policy)				\
 FOLIO_TEST_CLEAR_FLAG(lname, FOLIO_##policy)				\
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
index 26baa78f1ca7..c4c9742c7a29 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1097,7 +1097,12 @@ void folio_unlock(struct folio *folio);
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
@@ -1133,6 +1138,15 @@ static inline bool trylock_page(struct page *page)
 static inline void folio_lock(struct folio *folio)
 {
 	might_sleep();
+	/*
+	 * dept_page_wait_on_bit() will be called if __folio_lock() goes
+	 * through a real wait path.  However, for better job to detect
+	 * *potential* deadlocks, let's assume that folio_lock() always
+	 * goes through wait so that dept can take into account all the
+	 * potential cases.
+	 */
+	dept_page_wait_on_bit(&folio->page, PG_locked);
+
 	if (!folio_trylock(folio))
 		__folio_lock(folio);
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index 7b90cbeb4a1a..cab03b41add2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -48,6 +48,7 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/mm.h>
 #include <linux/sysctl.h>
+#include <linux/dept.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1145,6 +1146,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 		if (flags & WQ_FLAG_CUSTOM) {
 			if (test_and_set_bit(key->bit_nr, &key->folio->flags))
 				return -1;
+			dept_page_set_bit(&key->folio->page, key->bit_nr);
 			flags |= WQ_FLAG_DONE;
 		}
 	}
@@ -1228,6 +1230,7 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
 		if (test_and_set_bit(bit_nr, &folio->flags))
 			return false;
+		dept_page_set_bit(&folio->page, bit_nr);
 	} else if (test_bit(bit_nr, &folio->flags))
 		return false;
 
@@ -1235,6 +1238,9 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 	return true;
 }
 
+struct dept_map __maybe_unused pg_locked_map = DEPT_MAP_INITIALIZER(pg_locked_map, NULL);
+EXPORT_SYMBOL(pg_locked_map);
+
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
@@ -1246,6 +1252,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	unsigned long pflags;
 	bool in_thrashing;
 
+	dept_page_wait_on_bit(&folio->page, bit_nr);
+
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
 		delayacct_thrashing_start(&in_thrashing);
@@ -1339,6 +1347,23 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		break;
 	}
 
+	/*
+	 * dept_page_set_bit() might have been called already in
+	 * folio_trylock_flag(), wake_page_function() or somewhere.
+	 * However, call it again to reset the wgen of dept to ensure
+	 * dept_page_wait_on_bit() is called prior to
+	 * dept_page_set_bit().
+	 *
+	 * Remind dept considers all the waits between
+	 * dept_page_set_bit() and dept_page_clear_bit() as potential
+	 * event disturbers. Ensure the correct sequence so that dept
+	 * can make correct decisions:
+	 *
+	 *	wait -> acquire(set bit) -> release(clear bit)
+	 */
+	if (wait->flags & WQ_FLAG_DONE)
+		dept_page_set_bit(&folio->page, bit_nr);
+
 	/*
 	 * If a signal happened, this 'finish_wait()' may remove the last
 	 * waiter from the wait-queues, but the folio waiters bit will remain
@@ -1496,6 +1521,7 @@ void folio_unlock(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	BUILD_BUG_ON(PG_locked > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	dept_page_clear_bit(&folio->page, PG_locked);
 	if (folio_xor_flags_has_waiters(folio, 1 << PG_locked))
 		folio_wake_bit(folio, PG_locked);
 }
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 327764ca0ee4..39cf0bc355ba 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -31,6 +31,7 @@
 #include <linux/execmem.h>
 #include <linux/vmstat.h>
 #include <linux/hugetlb.h>
+#include <linux/dept.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -586,6 +587,7 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	atomic_set(&page->_mapcount, -1);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
+	dept_ext_wgen_init(&page->pg_locked_wgen);
 
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
-- 
2.17.1


