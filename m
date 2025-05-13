Return-Path: <linux-fsdevel+bounces-48859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA4CAB521E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86735866B85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3D027FD4B;
	Tue, 13 May 2025 10:08:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E727054F;
	Tue, 13 May 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130887; cv=none; b=NdovQ3TalsUVzqMNMnHXPM5nAG7IkkHdF1W4Q8ooygKc3OswIhNQU2dkoLrbmuYFgdX8H5BqmYqgAMFR5aW4JSALTPocC+3dwmPRwgqSmObMzz0fT/3ynUK5yPRlGgUy/0caVN/ghAPFS/ArZxVaw6pbXK+OxwsULHMA6Y/gWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130887; c=relaxed/simple;
	bh=tIR4uGZ5TyiPjwbijfaMoNqyjNLvTfkFnTPvc6vFuyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ohrmNMTz6EIQNpDA0aa21L2f5W7tIryxYV0knYrufvwA9X2QR84e72QQtDtBAJ42MO1c8JNRTRZG7i+d9kZqeDde0cXMWOZ54HC5tTA5OZI12eFzkipggw4V07QE3lG6KO6uDL/jMp2QN3eaffJWbfH9EV9otCermxvgl58P7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-4c-682319f04bc3
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
Subject: [PATCH v15 25/43] dept: track PG_locked with dept
Date: Tue, 13 May 2025 19:07:12 +0900
Message-Id: <20250513100730.12664-26-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMcRjHfT7fn52Oryt8/Ri5mI35UWTPDGNmvoZh/svPm766m0q7q6sM
	uyPph275kRtXuYor11GujChL1imthOrSTnJ+TFOadEcULq1/nr32fp7n9fzzsISsjprJqmLi
	RHWMIkpOS0hJn3/+km8zgpXLnWcJ8AymkpBTaqOh5XYJAluFHkNP3WZwensR/G56ToAxuwVB
	/rs3BFQ4uhBUF5+i4dWHSdDq6aehITuDhtOFpTS8+DKMwXX5AoYS+3Z4a/lEQmNWAQZjDw0m
	42nsK58xDFmsDFh0C8BdfJWB4Xch0NDVTkF152K4kueioaq6gQTHfTeGVw9yaOiy/aWg0VFP
	gtcwC1rOZ1Jw62sBDV+8FgIsnn4GXtaYMTjM06As2SdM+f6HgqeZNRhSrt/B0Pr6IYJHqd0Y
	7LZ2Gp54ejGU27MJ+FVUh8Bt6GPgzLkhBkx6A4KMM5dJSHaFwe+fvsu5gyGgv1ZGwq2RdrR+
	rWDLsyHhSW8/ISSXJwi/PG20UO01k8KzAl6ovPqGEZIfdTKC2R4vlBcvEgqrerCQP+ChBLs1
	jRbsAxcYIb2vFQtfm5uZnbPDJWsixCiVVlQvW3dQomwrOhxr2JtoeLBZh+5uTUd+LM+t5NPc
	Q8Q43/04+J9pbiHf0TGWB3JBfHnmJyodSViCa5/IO3Nfo3TEsgHcar7gZ/joDMkt4O1DJmaU
	pdwq/mbbc2rMOZcvKav57/Hz5SNFzeQoy7gwPstcQo46ee6iH2/trKDHFmbwj4s7yCwkNaMJ
	ViRTxWijFaqolUuVSTGqxKWHjkbbke+5LCeG99xHAy27axHHIrm/tL5nnlJGKbSapOhaxLOE
	PFCqv+eLpBGKpGOi+ugBdXyUqKlFs1hSPl0a6k2IkHGRijjxiCjGiurxLmb9ZurQpf1TIkI3
	VU75M4w8+0LrS1OOvfhRNdm11hMQPO1k4rbKhydN7OfvTYlNJhx+Y/YGWpMXpptwYkfmTseu
	SItsk/59ArZumKNy48CtW7TdamOQMXKJK9Xp3C8LzvXfeKW133ldXdb74eUKbeOkQXb+SPwe
	S32hYV3s8aycqbqDcQFyUqNUhCwi1BrFP3HkxPlYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX/PHWc/afxkhrM0NRFln8WwmfWbp9oszGx19ONOV7jjyDyU
	TqPcLSZNj9fFXeokvzRKWevWkYdKz1mi0KSUh+7WEbmYfz577f3+7PX558PgnhbSm1HGHRXU
	cXKVjJIQkm2rk5Z+mbNIsdxoWQKO0QsEZN+xUtBUUozAei8Rg4G6UOhwDiH4+aIRh4z0JgT5
	va9xuGfvQVBdeI6ClvfTodUxQkF9eioFSQV3KHg5OI5B97UrGBSLW+GNuZ+AZ2kmDDIGKMjK
	SMLc4yMGLnMRDeYEH+grzKRhvDcQ6nvaSbDl1JNQ/cofrud2U1BVXU+A/UEfBi2V2RT0WCdI
	eGZ/QoDTMBeaLutJuD1somDQacbB7BihobnGiIHdOAtKdW5r8vffJDzW12CQfOMuBq1dDxE8
	uvAWA9HaToHNMYRBmZiOww9LHYI+w2cazl9y0ZCVaECQev4aAbruYPg55r6cMxoIiXmlBNz+
	1Y7Wr+WtuVbE24ZGcF5Xdpz/4Wij+GqnkeCfmji+IvM1zesevaJ5o3iMLyv04wuqBjA+/5uD
	5MWiixQvfrtC8ymfWzF+uKGBDp+3W7ImWlAptYJ62dooiaLNsv+wYc8JQ2VoAirfnII8GI4N
	4so/jOKTTLG+XGen6y97sQu4Mn0/mYIkDM62T+U6crpQCmKYmWwIZxrbPblDsD6c6MqiJ1nK
	ruJutTWS/5zzueLSmr8eD3f+y9JATLInG8ylGYuJNCQxoilFyEsZp42VK1XBAZoYRXyc8kTA
	vkOxInK/j/n0+OUHaLQltBaxDJJNkz4ZWKjwJOVaTXxsLeIYXOYlTbzvjqTR8viTgvpQpPqY
	StDUorkMIZst3bRTiPJkD8iPCjGCcFhQ/28xxsM7Ab1tjszPNsdoz064/L3oyL16bfOMcd93
	U6qWWJOjp5XsstoPDs7a0jtzf0K4RZ9aG3pznS4oKL23fDtpeh7lr2O88y5Fq2xUY8e7vRFf
	w/wqXF+ViPqUe6Zuw4qNYyMTtiOaiB2LK0OOOLMPhIWH+E09FT4sOgv6G8OulihXOtseywiN
	Qh7oh6s18j9Xr7hVOgMAAA==
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
 include/linux/pagemap.h    |   7 ++-
 mm/filemap.c               |  26 ++++++++
 mm/mm_init.c               |   2 +
 5 files changed, 149 insertions(+), 13 deletions(-)

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
index 26baa78f1ca7..f31cd68f2935 100644
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


