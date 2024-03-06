Return-Path: <linux-fsdevel+bounces-13723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE8A873202
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404E91C20F6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EBD71B33;
	Wed,  6 Mar 2024 08:55:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE53657C1;
	Wed,  6 Mar 2024 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715352; cv=none; b=QkEVobbOds1rqRCeqQ939yo2bvSwNiHY9Hcma3OeUXjwq6CA6x+O5l2oq7MQvZZjTdHHxmtOoNF01cxQTl2R4i/oqwwob73zPxDfIT4ax8X955CEWSVr/GYWZhxbYFC5Qv+KK2fbUgAwGb0E8ejo1s4AWyoGNpR5UsmYfCAgBAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715352; c=relaxed/simple;
	bh=tC26hq3Ijka0/rt3bw+rfbu4EsnZw7fNBY7MOAe1vjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BU4nlhn6YsKSvshrHWSyjX6T5v7JnPk3Q1RJSbNhkwixwRpn8WUosI8hYYu3RQGpK2gj343wjBFjd33lNblOcWOYJsFTT5W4PKB5/ljhwdftdfC10ORIVbqwKi5DLTgSUV6rftNVjdIfhaFVwIczuPxdo9oRkFwNBKPSkbAxhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-aa-65e82f7ffbc0
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
Subject: [PATCH v13 24/27] dept: Track PG_locked with dept
Date: Wed,  6 Mar 2024 17:55:10 +0900
Message-Id: <20240306085513.41482-25-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSW0xTaRAHcL/vnH6nNNScVOMe8UFtIuttAS9sBqJGjcr3YmJ2ffAat7En
	trGAKYhl4wWhGESKigG8IAuItQEEtsWoa9tUDAi4YtGKqNAoIVwUSkRLrDRq6+Vl8svM5J95
	GCmjuCGJkmpT0kV9ikqnJDJWNhZZ+dux2GEx7qUrEc4WxIH/Qx4LZQ11BNz1tQjqmo5jGGlJ
	gmeTowimHj5ioLTYjaDydR8DTa1eBA5LNoEnA9PB4x8n0F58ikDOlQYCXW+DGHpLijDUWjfD
	gzNVGFyBIRZKRwhcKs3BoTKMIWCu4cCctQD6LRc5CL5eBu3ebgk4XiyBC+W9BOyOdhZab/Vj
	ePJfGQFv3RcJPGhtY8F91iSB674qAm8nzQyY/eMcPHZVYGg0hoJOvP8sgfsmF4YT1f9i8Dy/
	g8CZ9wqDta6bwD3/KAabtZiBT9daEPQXjnGQWxDg4NLxQgSncktYMPbGw9THMrI2gd4bHWeo
	0XaIOiYrWNpRJdDbF/s4anS+4GiF9SC1WRbTK/YRTCsn/BJqrTlJqHWiiKP5Yx5MfZ2dHG07
	P8XSAU8p3hK1Q7ZKLeq0GaI+ds1fMk2/yUwO2LcairscXBZ6vyEfRUgFfqVw1fIG/3TD/2Yu
	bML/KvT0BJiwZ/LzBJtpUBI2w4/KhOrOTWHP4BOFl0VNbNgsv0C45r35zXL+d+F6/QX2e+Zc
	obbR9S0nItQ/7TtNwlbw8cLDnMqQZaGdL1Khz+f9ccRs4a6lhz2D5BVoWg1SaFMyklVa3coY
	TWaK1hCzNzXZikLPZD4S3HkLTbj/bEa8FCkj5WsjhkSFRJWRlpncjAQpo5wpP/xpQFTI1arM
	v0V96h79QZ2Y1ozmSFnlL/Llk4fUCn6fKl3cL4oHRP3PKZZGRGWhzbXZBb7c+MLL5TUb86ca
	g/q8llfMH+VD6pKFxLXo+eP5SvpPdL0OD+ZGp1bzRzu68o3r1q0fDurn7lqY0JY0x+M02Feb
	NB3RtrjPKxKcs7Jj1OdMu3M05qTbVb1292Fv4vbZRwOD05wnl6Q7ZkyP3WaIjGruePfUsHzI
	urTb2Klk0zSqZYsZfZrqK4PCUGRIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSe0hTcRTA8X738btzNLtNoUsFxeiFlillHCxCovJHZET0gAhq5CVHc9pW
	lj0tnVlpPsKmaeGL5bPVnfR0YZorM01zmZlZDUnNpWVNMu3hiv45fDgHvn8dGa00sdNlGt1+
	Ua9Ta1VYzsg3LE9YdGJxnxiY1KGCjJRAcH9LZiDPUoGh5Vo5goqqkxT014fByxEXgrGmZzSY
	sloQFLx/Q0OVvRuBreQUhrYeb3C4hzA0ZJ3DkFBkwdA6ME5B18VMCsqlcGhML6SgZrSXAVM/
	hlxTAjUx+igYNZdxYI6fC86SSxyMvw+Chu52FuouN7Bg6/SHnCtdGKptDQzYbzspaLubh6G7
	4jcLjfbHDLRkpLJQOViIYWDETIPZPcTB85p8Cq4nTtSSvv5i4VFqDQVJxTcocLy6h+B+8jsK
	pIp2DHVuFwVWKYuGH1frETjPf+LAmDLKQe7J8wjOGS8ykNgVDGPf83BoCKlzDdEk0XqQ2Eby
	GfKkUCB3Lr3hSOL9To7kSweItcSPFFX3U6Rg2M0SqewMJtJwJkfOfnJQZLC5mSOPs8cY0uMw
	URtnbJeviBC1mlhRv3jlLnmkM9WMY6o3H8pqtXHx6Ovqs8hLJvBLBctTM+cx5ucLHR2jtMe+
	/GzBmvqB9ZjmXXKhuHmtxz58iPA6s4rxmOHnCle7b/21gl8mVF7LYf41Zwnl12v+drwm9mmD
	adhjJR8sNCUU4HQkz0eTypCvRhcbpdZogwMMeyPjdJpDAbujoyQ08S7mY+MZt9G3trBaxMuQ
	arIi1KtXVLLqWENcVC0SZLTKV3H0R4+oVESo4w6L+uid+gNa0VCLZsgY1TTFum3iLiW/R71f
	3CuKMaL+/5WSeU2PR5ct6jnmYqNR9zZpRd/H9HrFmh3Hs2PygqaNHB//vqXOvsB+9OCXF+GZ
	4d7W0LaUm2un+E8tX1MU+5R0li5Z6h2+NYRulFY/zN2wcNhn1ZPPvZUffF94P8+ZaWxdt6pw
	oH/9rCOlD05nQ7JUeSGiaZ7jWdoDrZ+8/WfGBee+MJfcskmjYgyR6iA/Wm9Q/wGkiCB6KgMA
	AA==
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


