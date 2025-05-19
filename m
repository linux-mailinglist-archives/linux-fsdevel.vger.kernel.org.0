Return-Path: <linux-fsdevel+bounces-49367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D3ABB95C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05927A8000
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948DD283142;
	Mon, 19 May 2025 09:19:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D270927A116;
	Mon, 19 May 2025 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646343; cv=none; b=Hhc+8bsPDa4Z8hthsgfZYkOzB877nuBEqB+sjYLNNoO0Jp76Hw/H3+/m30s30XkHXdxXUvwJPdCsbO9fCrlcJs+OIrsWF1R+2xDLpfEjtMLkFLt0sPF9aNGVP6Ji/ZqCcVYLHLhLV/egIiwmcyIZ/pmJ+zHZW0OA56p6H0Nh66Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646343; c=relaxed/simple;
	bh=XT7wM+AY+fy9b7R9FSPBT0zn1xc+Ht0DfCIhlHeaS6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dP9BlTGRG7o/L/eW6ljnlZMbXquGRkedEFVyXahUhMdrZPq0JeNN7Y0dcbu14g0Tz0LoXGkzhUwUM94N0BHrUwSxVK9a7zIUGzSyrnNxEkC7rhyxRJ2nufd7Of2+NloMObip6JbURc5l2IPKozgk37uW2YikV1ltVQ2Jdj0jJdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-7c-682af76f65b6
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
Subject: [PATCH v16 27/42] locking/lockdep: prevent various lockdep assertions when lockdep_off()'ed
Date: Mon, 19 May 2025 18:18:11 +0900
Message-Id: <20250519091826.19752-28-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG/b93Oqqv79x8FRJNIyiYsbGoOZnTqDHhnxijG9nM5get8GZt
	xi2tFtEsoVqMA4uKqSi3Fhzl0jJL6wdAS5BLBzM4mB0CARTizJBiM6RVpNO1GL+cPHme8/zO
	l8ORQje9llNnHZc0WcoMBSOjZLPR1Z/kvExUfdathcD8eQoqbtoZGPjVhsB+S0/AdE8KPAz6
	ECz2/0FCqWkAQfXkOAm3PBMI3PVnGHjwZDl4A34G+kxFDJy9cZOBwZkQAWNXSwiwOffDI+tT
	Cu5dqiGgdJqB8tKzRHj8Q8CCtZEFa34cTNWXsRCaTIa+iSEa3KOb4XrVGAN33H0UeFqmCHjQ
	VsHAhP0tDfc8vRQEi2Ng4LKRhqbnNQzMBK0kWAN+Fv7ssBDgsXwMDkMYeO7FGxp+M3YQcO6X
	ZgK8I7cRtJ9/TIDTPsRAV8BHgMtpIuF1XQ+CqeJZFgouLLBQri9GUFRwlQLD2FZYfBW+XDmf
	DHqzg4Km/4bQrh3YXmVHuMvnJ7HBlYtfB/5isDtoofDvNSJuLRtnsaF9lMUW5wnsqk/EN+5M
	E7h6LkBjZ+PPDHbOlbC4cNZL4Of377MHY7+XfZkuZah1kubTnUdlqh5/fM7IypNWv5HJR9YV
	hSiKE/kt4mybni5E3JJuajgVsRl+ozg8vEBG9Cp+vegyPg2vyDiSH/pAfFg5giLBh3y62DdT
	QEQ0xceJdd6/lzhyfpv4yhvzDr9OtDk6ljhRYXu0qGupKvBbRa+tioowRd4cJRa31tHvCmvE
	u/XD1CUkt6BljUhQZ+kyleqMLUmqvCz1yaS07EwnCv+W9afQ4RY0N5DaiXgOKaLlDneCSqCV
	Om1eZicSOVKxSt7o2qQS5OnKvFOSJvuI5kSGpO1EMRylWC3/PJibLvA/KI9LP0pSjqR5nxJc
	1Np8tDthU3NZdkD7RKiJX1nx9faL374wdwfxZfOxDqPnC1fvkdjYtJLFfwftV3oM+1MPjGe3
	6Jr3JTwKBR2mwdprTb41B476os3jG/otzx7n7uj9qq3yo28Ce8x7OFsKCjV8d4Y8ZC+f36sT
	TnvzTMKhNL7Wo1s9XNt/WtGqn5xOyVmuoLQqZXIiqdEq/wdVo8PjVwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0jTeRzG+3x/b3erb0vsWxLFoEwjS8p4R4cW3NWHoAgKgvojR35pI52y
	qZdRoTftUtOzyEaZNn80TWeuzcrKDXGprbid5fLXmaX0y9NarG2XP65rC/rn4eF5eL+ef94c
	Ka+nl3JqTaao1ShTFYyUku7eol+b/m+san1XeQwE/GcouNJiZqD3RhMCc2seARNdO2AgOIVg
	9s+/SDCU9yKoHntOQmv3KAJ7w28M9L2aD56AlwFXeTED+toWBp5MzhEwcvE8AU3WXfDC9IaC
	x2U1BBgmGKgw6ImQvCNg2tTIgil3JYw3XGZhbiweXKP9NDgrXTTYh9fApaoRBtrtLgq628YJ
	6Lt3hYFR8/80PO5+SEGwNAp6z5XQ0PyhhoHJoIkEU8DLwtMOIwHdxkiw5Ieopz99oaGnpIOA
	03U3CfAM3UfgOPOSAKu5nwFnYIoAm7WchJn6LgTjpe9ZKDg7zUJFXimC4oKLFOSPJMDs59By
	pT8e8q5aKGj+rx9tTcTmKjPCzikvifNtv+KZwDMG24NGCj+qEfDdy89ZnO8YZrHRmoVtDbG4
	tn2CwNW+AI2tjYUMtvrOs7jovYfAH9xuds+yA9KfUsRUdbaoXZeYLFV1eVdlDC08ZvKWMLnI
	tKAIcZzAbxSarx8vQhKO4aOFwcFpMuwj+BWCreQNXYSkHMn3/yAMVA6hcLGITxFckwVE2FP8
	SqHe85oOc2T8JuGzJyocC/xyocnS8Y0jCcXDxc5vp3I+QfA0VVFlSGpE8xpRhFqTnaZUpybE
	6Y6qcjTqY3GH09OsKPQ+ppNz59qQv29HJ+I5pPhRZrHHqOS0MluXk9aJBI5URMgabatVclmK
	Mue4qE0/pM1KFXWdKIqjFItlO/eLyXL+iDJTPCqKGaL2e0twkqW5CCI/bQje8vmXrB2ovp0+
	6FYeLGv4pT1Wc2P3/X+cQ75HSXfMPbprM9QfFmdFouOLbJ17hVvVI3PsM2j00TbptgeFT/QZ
	hbrsJRsLObzmmu/FljZHpn/MsP1A3KmUvdExSZH+C5Tz5onew3/XXdgsefv7vaTW/cm1WZbp
	lp9nJeijgtKplPGxpFan/Ar3k/K5OgMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

lockdep provides APIs for assertion only if lockdep is enabled at the
moment asserting to avoid unnecessary confusion, using the following
condition, debug_locks && !this_cpu_read(lockdep_recursion).

However, lockdep_{off,on}() are also used for disabling and enabling
lockdep for a simular purpose.  Add !lockdep_recursing(current) that is
updated by lockdep_{off,on}() to the condition so that the assertions
are aware of !__lockdep_enabled if lockdep_off()'ed.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/lockdep.h  |  3 ++-
 kernel/locking/lockdep.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index ef03d8808c10..c83fe95199db 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -303,6 +303,7 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
 	lockdep_assert_once(!current->lockdep_depth)
 
 #define lockdep_recursing(tsk)	((tsk)->lockdep_recursion)
+extern bool lockdep_recursing_current(void);
 
 #define lockdep_pin_lock(l)	lock_pin_lock(&(l)->dep_map)
 #define lockdep_repin_lock(l,c)	lock_repin_lock(&(l)->dep_map, (c))
@@ -630,7 +631,7 @@ DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 DECLARE_PER_CPU(unsigned int, lockdep_recursion);
 
-#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursion))
+#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursion) && !lockdep_recursing_current())
 
 #define lockdep_assert_irqs_enabled()					\
 do {									\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6c984a55d5ed..d2805ce250cb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6889,3 +6889,13 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
+
+/*
+ * For avoiding header dependency when using (struct task_struct *)current
+ * and lockdep_recursing() at the same time.
+ */
+noinstr bool lockdep_recursing_current(void)
+{
+	return lockdep_recursing(current);
+}
+EXPORT_SYMBOL_GPL(lockdep_recursing_current);
-- 
2.17.1


