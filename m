Return-Path: <linux-fsdevel+bounces-19073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D868BFA8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680DE2807BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E91127E07;
	Wed,  8 May 2024 10:03:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209E79950;
	Wed,  8 May 2024 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162586; cv=none; b=fblXjUyzbiRf+s2Kk/+ol402BDkpNVJllRAQa76PNhGc3IHqwcDZtIaQ/oZlmiobCan41c75JqJSqiyQI7DP6kq07sx+16aUBBFtbuv7Lw8Qy85fltSg4gS/YYaRGUeus9r0CVfc1dicA9rqxS7PCZ+K+T0+yR8ounfmtrWJwsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162586; c=relaxed/simple;
	bh=ZsUVZ1MCea5x88351Al5eqA4cJifLCS7D4TehZsMvlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oRlL6MhbYtXVsC8tqvUgG008UHlAClNUbdftNs3bQYIJmrWPh2MU7806hapI3sYFx7/xzupem9QXQRYAKVogpJQJyLz/QJXXLEdCdsCrM0P7lZV+KzkRU6TupmaaZhffZVAScQ67/j5WLypW1fh/I2u1KBKxNWvZxanhulG3lC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-89-663b4a3b41e5
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
Subject: [PATCH v14 23/28] dept: Track PG_locked with dept
Date: Wed,  8 May 2024 18:47:20 +0900
Message-Id: <20240508094726.35754-24-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxjG/b5zek5prDmrZp6hidpIjFfU6PaK8/KP8omamJglZpdsjRxG
	t1LM4VaWmIBUQCoIKFaBaLmkEKiIrRqxVisEBjNgkQZQLgMkaEeBjNluHfVS2PznzS/P+7xP
	nj9eKaW4IwmXqrXJgqhVaZSMjJZNLa7YvDtmd9zWvs71UHR+K/je5NJQftPCgKuhHoHldiYG
	T2s09Pm9COY6n1JgLHEhqBgdouB22zACR+0ZBnrGl4DbN8NAR4mBgayqmwx0TwYxDF4uxlBv
	PQpPCisxOAOvaDB6GCgzZuHQeI0hYK5jwZwRAWO1pSwER7dBx3CvBBwvNsLVa4MMPHB00NB2
	bwxDz/1yBoYt7yXwpK2dBldRvgRuTFcyMOk3U2D2zbDwzGnC0KgPBWX/9U4Cv+Y7MWRX38Lg
	fm5H8DB3BIPV0stAi8+LwWYtoeDfmlYEYwVTLJw9H2ChLLMAgeHsZRr0gzth7p9yZv8u0uKd
	oYjelkYcfhNNfqvkSVPpEEv0D1+wxGRNIbbaDaTqgQeTilmfhFjrzjHEOlvMkrwpNybTXV0s
	ab8yR5NxtxEfC/9a9mWsoFGnCmLk3h9k8cNlNvrUwLe6i+VuNgP5D+ehMCnP7eCL35ahj3xj
	IojnmeHW8f39AWqel3GreVv+hGSeKc4r46u7Ds7zUi6KP5c7tXBLcxG8y2xf8Mu5z3lv3wj+
	L3MVX9/oXNDDQvrzV9MLfgW3k7dnlbJ5SBbyvJHyVx4F/y/xGf+4tp8uRHITWlSHFGptaoJK
	rdmxJT5dq9ZtOZmYYEWhZzKfDn5zD826jjcjToqUi+XO5VFxCokqNSk9oRnxUkq5TN6a80Wc
	Qh6rSv9FEBO/F1M0QlIzWiGllcvl2/1psQruR1Wy8LMgnBLEj1ssDQvPQBlR9n04ct2RPTJN
	9MregcyYyUummgN3cpoMYvNXZ747LJZsPI2ekqzkeFU3W/ip82DDmkd/nrh1SD87eqzwQLuj
	QRe7R7vI0GTZVdrY7tl0cejvPzIvOGXGTh5VBQ3dayhvhO5x9svfc/bf9ay9HiNcsouT2k88
	NQU/BQyKFbpqJZ0Ur9q2gRKTVB8AooWPyUgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRzF+/3u09XqtlZd9I9iZKmRKWR9yQiDHreiCAqMEHLUNYePyaYr
	g8DaMt9koSu1UItlU1M3C8ssUdTM0pXz2dQS0cSp9JhkiuWM/jl8OOdw/josITNSnqwqNl7U
	xCqjFbSElBwP1m8LPhIcEdBnWAPZGQHg+plCQkFFGQ22J6UIyqqvYhhvOgQ9M04Ec+87CDDm
	2BAUfRkgoLp5EEFdyTUaOkdWgt01TUNrTjoN+gcVNHyYmMfgyL2FodRyDNpuFmOonx0jwThO
	Q75RjxflK4ZZk5kBU5I3DJfkMTD/JRBaB7spaLzXSkFd/1a4e99Bw8u6VhKaa4YxdL4ooGGw
	7A8Fbc1vSLBlZ1JQPlVMw8SMiQCTa5qBj/WFGCoNi2vJPxYoaMmsx5D8sAqDva8WwauUzxgs
	Zd00NLqcGKyWHAJ+P2pCMJw1ycD1jFkG8q9mIUi/nkuCwREEc78K6JDdQqNzmhAM1otC3Uwh
	Kbwt5oXneQOMYHjVzwiFlgTBWuInPHg5joWi7y5KsJhTacHy/RYjpE3asTDV3s4Ib+7MkcKI
	3YhPeJ2R7DkvRqt0omb73nBJ5GC+lYz7FHbpdoGdSUIzR9OQB8tzO/jy0XnsZprbwvf2zhJu
	lnMbeWvmKOVmgnNK+IftB928htvNp6ZMIjeTnDdvM9Uu9aXcTt7Z8xn/29zAl1bWL/kei37f
	2NRSX8YF8bX6POYmkhSiZWYkV8XqYpSq6CB/bVRkYqzqkv85dYwFLd7FdGU+uwb97DzUgDgW
	KVZIbXRwhIxS6rSJMQ2IZwmFXNp0Y1eETHpemXhZ1KjPahKiRW0D8mJJxXrpkVAxXMZdUMaL
	UaIYJ2r+p5j18ExC+4fOHG7bY/C69ti4r2vtQqj9tDrktY/8cpPv6mfyLSzrKBo65zA9VRxH
	6UMnOzbk6T0N5sMj5paxzTS0nKre9Dw3njWsOkDohjuX5U/cqXhRrsX9Jf7VzT9CBy5kNHjq
	1F3rvNP831lWdWfd/vY1TqbxCfKJKl1eGVY1OuCrTlCQ2khloB+h0Sr/AvoTEUUqAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes Dept able to track PG_locked waits and events. It's going to be
useful in practice. See the following link that shows dept worked with
PG_locked and can detect real issues:

   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h   |   2 +
 include/linux/page-flags.h | 125 +++++++++++++++++++++++++++++++++----
 include/linux/pagemap.h    |   7 ++-
 mm/filemap.c               |  26 ++++++++
 mm/mm_init.c               |   2 +
 5 files changed, 149 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5240bd7bca33..d21b2e298cdd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
+#include <linux/dept.h>
 
 #include <asm/mmu.h>
 
@@ -203,6 +204,7 @@ struct page {
 	struct page *kmsan_shadow;
 	struct page *kmsan_origin;
 #endif
+	struct dept_ext_wgen PG_locked_wgen;
 } _struct_page_alignment;
 
 /*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4bf1c25fd1dc..74cbbf694c18 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -197,6 +197,61 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
+#ifdef CONFIG_DEPT
+#include <linux/kernel.h>
+#include <linux/dept.h>
+
+extern struct dept_map PG_locked_map;
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
+}
+
+static inline void dept_page_clear_bit(struct page *p, int bit_nr)
+{
+	if (bit_nr == PG_locked)
+		dept_event(&PG_locked_map, 1UL, _RET_IP_, __func__, &p->PG_locked_wgen);
+}
+
+static inline void dept_page_wait_on_bit(struct page *p, int bit_nr)
+{
+	if (bit_nr == PG_locked)
+		dept_wait(&PG_locked_map, 1UL, _RET_IP_, __func__, 0, -1L);
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
 
@@ -381,27 +436,51 @@ static __always_inline bool folio_test_##name(const struct folio *folio) \
 
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
@@ -416,32 +495,54 @@ static __always_inline int Page##uname(const struct page *page)		\
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
index 2df35e65557d..a438d8f038de 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1008,7 +1008,12 @@ void folio_unlock(struct folio *folio);
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
index 30de18c4fd28..ceb24a7ee0b1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -46,6 +46,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/splice.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/dept.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1108,6 +1109,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 		if (flags & WQ_FLAG_CUSTOM) {
 			if (test_and_set_bit(key->bit_nr, &key->folio->flags))
 				return -1;
+			dept_page_set_bit(&key->folio->page, key->bit_nr);
 			flags |= WQ_FLAG_DONE;
 		}
 	}
@@ -1191,6 +1193,7 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
 		if (test_and_set_bit(bit_nr, &folio->flags))
 			return false;
+		dept_page_set_bit(&folio->page, bit_nr);
 	} else if (test_bit(bit_nr, &folio->flags))
 		return false;
 
@@ -1201,6 +1204,9 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 /* How many times do we accept lock stealing from under a waiter? */
 int sysctl_page_lock_unfairness = 5;
 
+struct dept_map __maybe_unused PG_locked_map = DEPT_MAP_INITIALIZER(PG_locked_map, NULL);
+EXPORT_SYMBOL(PG_locked_map);
+
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
@@ -1212,6 +1218,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	unsigned long pflags;
 	bool in_thrashing;
 
+	dept_page_wait_on_bit(&folio->page, bit_nr);
+
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
 		delayacct_thrashing_start(&in_thrashing);
@@ -1305,6 +1313,23 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
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
@@ -1481,6 +1506,7 @@ void folio_unlock(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	BUILD_BUG_ON(PG_locked > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	dept_page_clear_bit(&folio->page, PG_locked);
 	if (folio_xor_flags_has_waiters(folio, 1 << PG_locked))
 		folio_wake_bit(folio, PG_locked);
 }
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 549e76af8f82..a0c9069d3740 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -27,6 +27,7 @@
 #include <linux/swap.h>
 #include <linux/cma.h>
 #include <linux/crash_dump.h>
+#include <linux/dept.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -570,6 +571,7 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	page_mapcount_reset(page);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
+	dept_ext_wgen_init(&page->PG_locked_wgen);
 
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
-- 
2.17.1


