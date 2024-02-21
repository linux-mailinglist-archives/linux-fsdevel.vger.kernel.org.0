Return-Path: <linux-fsdevel+bounces-12248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6159B85D4D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4401C2167C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E385F486;
	Wed, 21 Feb 2024 09:50:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED04F608;
	Wed, 21 Feb 2024 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509011; cv=none; b=Ch9RfDKsAe11VjsToPA2TcjHwU4Niq2d4Y6NtsECdtfeuCYYADrLDHwwy7vQUPaX2aAMDTMGJVzmxnfvEkiLfndFwCgUgN6Olddyl5k9tqWBcKn8EZVpR+SFB0mvByF8Zv+LSCREDrLfNYC6Hl4VujrYoMb3o/Wk9CUhDPdCTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509011; c=relaxed/simple;
	bh=tC26hq3Ijka0/rt3bw+rfbu4EsnZw7fNBY7MOAe1vjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LkbWMSvDNjWIelz/JSZFuGBTsViP7KT+jBzgIG4EJ5Ss30o/znQcdsdC5RRWn9nWJvQWvO5Ernu+0i/gztfgePrMitawB14ULZBXMrTW1f1j3e01XpJ8gDRN11n9MP8X/uYQxEF4QNZ8tjLq+RFcHMz3cUMh80sojHJr0VdzeWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-08-65d5c73b32cc
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
	viro@zeniv.linux.org.uk,
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
Subject: [PATCH v12 24/27] dept: Track PG_locked with dept
Date: Wed, 21 Feb 2024 18:49:30 +0900
Message-Id: <20240221094933.36348-25-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTVxjGPefee+6lWHfXGXem0ZkmxsVFRaPba9HFZEZPnMYtmm2Zy1gj
	d6MZoGmliMli1aKOD4PGggI6QFM72vlRxKlQ0kH4KASlUhAZEm1kk1isAiXyMbXV+M+bX54n
	z++vV+I0NcJsyZC+WzGm61O1RMWrhqaXL05s7lISDnR9CsfyEiAyeoSH0osuAh0XnAhcV/Zj
	GGzcAHfGQggm229xUGTrQFD+4B4HV5r6EXgcBwh0PpwBgUiYgM+WS+Dg2YsE/I+nMPQVHsfg
	dG+GtoIKDN7x/3goGiRQUnQQR88jDOP2ShHslgUQdBSLMPVgGfj6uwXw9H4Mp870Eaj1+Hho
	uhbE0HmjlEC/66UAbU0tPHQcyxfgzycVBB6P2TmwR8Ii3PaWYbhkjYoOjbwQoDnfi+HQucsY
	AndrENQduY/B7eom0BAJYahy2ziYON+IIHh0SITsvHERSvYfRZCbXcjDrf+bBbD2rYTJ56Vk
	rY41hMIcs1ZlMs9YGc9aKyi7XnxPZNa6XpGVuTNYlWMRO1s7iFn5cERg7srfCHMPHxdZzlAA
	syc3b4qs5eQkzx4GivCXc75TrU5WUg1mxbj0sx9VKcF8O9lVu22Pze8RLWhkXQ6Kk6i8go5M
	TPBv+UTwqhhjIi+kPT3jXIxnyvNpVf6/Qg5SSZx8OJ46nraTWPGerKN3LOdxjHl5AR29/+w1
	q+VPaPWNbvxG+iF1XvK+FsVF8z9KQkKMNfJK2uWv5mJSKh+Ooy0hP3kz+ID+7ejhC5C6DE2r
	RBpDujlNb0hdsSQlK92wZ8mOnWluFH0p+69T26+h4Y6t9UiWkHa6OuWvgKIR9GZTVlo9ohKn
	nanmM6OROlmftVcx7kwyZqQqpno0R+K176uXj2Uma+Sf9buVXxRll2J822IpbrYFfbP2+y0X
	drR3mr8tdFw+PRBef1dnS3y3rnL11aXbuzZxxrlUN1qS+HXry1z/ugSuYbHFJGm/oJM/ZLu2
	tWbEb1pVU23+yTerX/e7yZnX4vVpv0IbI42fs4/2bTzBkgam2gqodc28p2rn1iRf76z4zf/U
	2ZPMZ1bBs4GTTeF39l13aXlTin7ZIs5o0r8C33x9sE4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfb/P83yf63TtUY1nMezMGvmRcfaZMDatR0b+sJkfjZOHbtXV
	7irFWCmhZGquUHHKrtRRLj+ry6npB+uXrvxKyzGkEtU1p/y4Y/5577X3e3v99ZZQngWMj0Sl
	jhU1amWknEhp6ZaAlMUBjV2if321F2Sd8Qf72Cka8suNBNpvliEw3k7G0P84CJ6PDyKYaGmj
	IFfXjuDq2zcU3G7oRWAuOU6g870HWO3DBJp1GQRSisoJdAxMYujJycZQZtoMT88VYrA4PtKQ
	208gLzcFO+MTBoehlAVD0nywlVxiYfLtMmju7WagvqCZAfMrP7h4uYdAjbmZhob7NgydVfkE
	eo2/GXja0ERDe1YmAze+FBIYGDdQYLAPs/DMosdQkeq0pY3+YqAx04Ih7dotDNaX1QhqT/Vh
	MBm7CdTbBzFUmnQU/Ch+jMB2doiFE2ccLOQln0WQcSKHhrafjQyk9ihg4ns+WRcg1A8OU0Jq
	5SHBPK6nhSeFvPDg0htWSK19xQp6U5xQWbJQKKrpx8LVETsjmEpPE8E0ks0K6UNWLHxpbWWF
	pgsTtPDemou3ztopXb1fjFTFi5qla/dKw22ZBhJTsy1B12Fmk9DohnTkJuG5Ffx5213WxYTz
	5V+8cFAu9ubm8pWZH5h0JJVQ3MmpfMnXFuIavLhV/POkYuximpvPj/V9+8sybiV/p6ob/5PO
	4csqLH9Fbs7+et4g42JPTsF3ddyhziGpHk0pRd4qdXyUUhWpWKKNCE9UqxKWhEVHmZDzNIaj
	k1n30VhnUB3iJEjuLgu/ZxU9GWW8NjGqDvESSu4tow85K9l+ZeJhURO9RxMXKWrr0EwJLZ8h
	C94u7vXkDipjxQhRjBE1/1cscfNJQjNDPVbps/23LliTXTetI8riE92v2BcSVDUaksGGLP+a
	8fDDlgHdcOCtmCPqd8mhisBWFBe43n22cZFPU1q8se3K9Hmnj8UkO1436XYwscS3JWzTO13w
	RjgaEXqx+HO6+7OhXdW/RyrWhRVZE3bbfHMKtX41+8bWzhlZ0de19NGBqXo5rQ1XLltIabTK
	P+dXv+4wAwAA
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
 include/linux/page-flags.h | 105 ++++++++++++++++++++++++++++++++-----
 include/linux/pagemap.h    |   7 ++-
 mm/filemap.c               |  26 +++++++++
 mm/mm_init.c               |   2 +
 5 files changed, 129 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 957ce38768b2..5c1112bc7a46 100644
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
index a88e64acebfe..0a498f2c4543 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -198,6 +198,43 @@ enum pageflags {
 
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
+#else
+#define dept_page_set_bit(p, bit_nr)		do { } while (0)
+#define dept_page_clear_bit(p, bit_nr)		do { } while (0)
+#define dept_page_wait_on_bit(p, bit_nr)	do { } while (0)
+#endif
+
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 
@@ -379,44 +416,88 @@ static __always_inline int Page##uname(struct page *page)		\
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
index 06142ff7f9ce..c6683b228b20 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -991,7 +991,12 @@ void folio_unlock(struct folio *folio);
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
index ad5b4aa049a3..241a67a363b0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -45,6 +45,7 @@
 #include <linux/migrate.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/splice.h>
+#include <linux/dept.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1098,6 +1099,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 		if (flags & WQ_FLAG_CUSTOM) {
 			if (test_and_set_bit(key->bit_nr, &key->folio->flags))
 				return -1;
+			dept_page_set_bit(&key->folio->page, key->bit_nr);
 			flags |= WQ_FLAG_DONE;
 		}
 	}
@@ -1181,6 +1183,7 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
 		if (test_and_set_bit(bit_nr, &folio->flags))
 			return false;
+		dept_page_set_bit(&folio->page, bit_nr);
 	} else if (test_bit(bit_nr, &folio->flags))
 		return false;
 
@@ -1191,6 +1194,9 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 /* How many times do we accept lock stealing from under a waiter? */
 int sysctl_page_lock_unfairness = 5;
 
+struct dept_map __maybe_unused PG_locked_map = DEPT_MAP_INITIALIZER(PG_locked_map, NULL);
+EXPORT_SYMBOL(PG_locked_map);
+
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
@@ -1202,6 +1208,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	unsigned long pflags;
 	bool in_thrashing;
 
+	dept_page_wait_on_bit(&folio->page, bit_nr);
+
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
 		delayacct_thrashing_start(&in_thrashing);
@@ -1295,6 +1303,23 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
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
@@ -1471,6 +1496,7 @@ void folio_unlock(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	BUILD_BUG_ON(PG_locked > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	dept_page_clear_bit(&folio->page, PG_locked);
 	if (folio_xor_flags_has_waiters(folio, 1 << PG_locked))
 		folio_wake_bit(folio, PG_locked);
 }
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 077bfe393b5e..fc150d7a3686 100644
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
@@ -564,6 +565,7 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	page_mapcount_reset(page);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
+	dept_ext_wgen_init(&page->PG_locked_wgen);
 
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
-- 
2.17.1


