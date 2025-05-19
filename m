Return-Path: <linux-fsdevel+bounces-49373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DA3ABB96D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A3E7A125A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA92853FC;
	Mon, 19 May 2025 09:19:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B775A27F16F;
	Mon, 19 May 2025 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646344; cv=none; b=gZxJE5JaBNGI878e0XBsLcXsCuVZR8G1690Vo9jmcZ2+OVgInDNVrM1TZih3jX9ZiZqUEAsPynmvAEUA7Asd3mJBk6KcGKuYYxoA7n60cDSpB8ztUa/z/nQ/5dD3vJjShSbfI4sOvm4A67k2PjNbCOVCGzh1isAB6T1l+59ALPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646344; c=relaxed/simple;
	bh=96XOFp5m0WCi1dCnE/wsAjz4TPWG2W3rMJRjru4SmyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kpE/U/tEedGiUnIvc/XzZlI9JOZLtyqWrbzdL+zC2ZvvbnZVmFjxG+StiS+byrfBEAgTa0NwgWAdQUbe6SiPAD5z5MdepZPGt6eOK6EcKUS5HcysWzI7w8W0TW5iQC+S1cbOQFjhV760exPj9qFgxhKVPvN8yXqIY78BelmXQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-d8-682af770b4b4
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
Subject: [PATCH v16 33/42] dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
Date: Mon, 19 May 2025 18:18:17 +0900
Message-Id: <20250519091826.19752-34-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0xTaRDH/c7lO4dqzdku6lE3izZhVTZeMGImUdl9Mftll41GJTH6oFVO
	bCM3C3IxMaGC2i2CrHJbBCzFHLFUxZYooiVAFUSDVoWCpKISY8SCJGirSNUtGF8mv8zM/zcv
	w9OqTnYBr0tOl/TJmkQ1VjCK0Vk1y1M/RGlXlbxZB/73RgYqL9swuC/VI7A1GigYvv0H9AVG
	EEx2P6ChrMSNoObFUxoaOwYROOuOYHj8cjb0+McwdJXkY8itvYzhoS9Igbf0FAX19r/hmfyK
	gXtFFgrKhjGcKculQuU1BROylQM5JxKG6io4CL6Ihq5BDwvOgV/hv2ovhpvOLgY6moYoeNxc
	iWHQ9pWFex13GAgULgT3vwUsXHxrweALyDTI/jEOHrWaKegwz4WGvJDw2LsvLHQWtFJw7NwV
	Cnqe3EDQYnxOgd3mweDyj1DgsJfQ8On8bQRDhaMcHD0xwcEZQyGC/KOlDOR5Y2DyY+hy1fto
	MJxtYODiZw/6fQOxVdsQcY2M0STPkUk++XsxcQbMDLlrEcn1iqccyWsZ4IjZfpA46qJI7c1h
	itSM+1lit/6DiX38FEdMoz0UeXv/Prf5px2K9QlSoi5D0q+M3a3Qlg/msqnlS7KqrC6cgyoj
	TCiMF4U1YpvXR33nTt8JboqxsETs75+gpzhcWCQ6Cl6xJqTgacEzU+yreoKmBj8K28UmS+80
	M0KkWNxtDAV4XimsFe9c3fTNGSHWN7ROe8JC7YF81/S6SogRe+qrmSmnKJwOE2W5G38LzBfb
	6vqZIqQ0oxlWpNIlZyRpdIlrVmizk3VZK/amJNlR6L3kw8GdTWjcvbUdCTxSz1I2OJdpVawm
	Iy07qR2JPK0OV1odS7UqZYIm+5CkT9mlP5gopbWjhTyjnqdcHchMUAn7NOnSfklKlfTfpxQf
	tiAHmVrif9nbHL9xBt9b9du+H9q6y3G6u+bPa7eKhZHXusasa+pNcbEDpqY9jeXF2TbN3A1s
	8LpicW0w/+4B+uPLisj42j2+N38VxUwGIh4dz4w715wSuXbxFYOrL46UXg0fn2PdFjfpKTWe
	3G7MUp0lW+yGnAveZeKB0x9ij1v2O3+W1UyaVhMdRevTNP8DAQpVeFoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMcRjH+3x/d5x9dxrfMcNZi/xsE89E/IG+FIU/0IZu+s7dVHKXlNHK
	dXZKTU0/6Icrds51/XCHha61jkssoqTfFDtSNHRHSVyZf5699ryf5/X88zC45CY5h1HExAnK
	GFmUlBIRop0B6uWxP3zlq7QFHDhHtAQUVpooaK4oQ2C6nYLBwKMgeO0aQvCr6TkOeTnNCEr6
	enC4be9FYDWcpaDl/QxodQ5T0JiTToH6WiUFLwbHMejOzcagzLwD3ugdBDy9WIpB3gAFBXlq
	zF0+YjCqN9KgT/aGfsMVGsb7/KCxt40EW1EjCdbOpXC5uJuCGmsjAfbqfgxa7hdS0Gv6Q8JT
	+2MCXJlzoTkrg4TyL6UUDLr0OOidwzS8rNNhYNfNgqpUt/Xc9wkSGjLqMDh3/RYGrR0PENRq
	32JgNrVRYHMOYWAx5+AwduMRgv7MzzRoLozSUJCSiSBdk0tAarc//Prpvlw04gcpV6sIKP/d
	hjYF8qZiE+JtQ8M4n2o5yY85X1G81aUj+CelHH/vSg/Np9Z20rzOfIK3GHz5azUDGF/yzUny
	ZuN5ijd/y6b5tM+tGP/l2TM6bF64aH2kEKWIF5QrAyNE8vxeNRmb75NQZLRRyahwfhryZDh2
	NdcweIGeZIr14drbR/FJ9mIXcJYMB5mGRAzOtk3jXhd1oMlgJruPqy59NcUE681datK6FxhG
	zK7hHt8N/eecz5VV1U15PN3tznTb1LiE9eday4qJi0ikQx5G5KWIiY+WKaL8V6iOyhNjFAkr
	Dh+LNiP3A+nPjGdVo5GWoHrEMkg6XVxlXSKXkLJ4VWJ0PeIYXOolNloWyyXiSFniKUF57JDy
	RJSgqkdzGUI6W7x9rxAhYY/I4oSjghArKP+nGOM5JxkFb/bY5VO3hzFpsiO8A+4z9gPH54k6
	dnSpFzmR77Kur8MVW2rbsXfrloX+mdjY44i0ZHW81YwlPUxezR5vyWlgTksfnG33qOgqNGTu
	3+C/7YDLGhdcc4qmtUGVCzUGmTYpLMw+IdrtsJeEircOhNjupHxtcoSs/bDHue2gsS/8k5RQ
	yWV+vrhSJfsLLmraaTwDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

commit eb1cfd09f788e (lockdep: Add lock_set_cmp_fn() annotation) has
been added to address the issue that lockdep was not able to detect a
true deadlock like the following:

   https://lore.kernel.org/lkml/20220510232633.GA18445@X58A-UD3R/

The approach is only for lockdep but dept should work being aware of it
because the new annotation is already used to avoid false positive of
lockdep in the code.

Make dept aware of the new lockdep annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 10 +++++++++
 kernel/dependency/dept.c | 48 +++++++++++++++++++++++++++++++++++-----
 kernel/locking/lockdep.c |  1 +
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index b6dc4ff19537..8b4d97fc4627 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -130,6 +130,11 @@ struct dept_map {
 	const char			*name;
 	struct dept_key			*keys;
 
+	/*
+	 * keep lockdep map to handle lockdep_set_lock_cmp_fn().
+	 */
+	void				*lockdep_map;
+
 	/*
 	 * subclass that can be set from user
 	 */
@@ -156,6 +161,7 @@ struct dept_map {
 {									\
 	.name = #n,							\
 	.keys = (struct dept_key *)(k),					\
+	.lockdep_map = NULL,						\
 	.sub_u = 0,							\
 	.map_key = { .classes = { NULL, } },				\
 	.wgen = 0U,							\
@@ -427,6 +433,8 @@ extern void dept_softirqs_on_ip(unsigned long ip);
 extern void dept_hardirqs_on(void);
 extern void dept_softirqs_off(void);
 extern void dept_hardirqs_off(void);
+
+#define dept_set_lockdep_map(m, lockdep_m) ({ (m)->lockdep_map = lockdep_m; })
 #else /* !CONFIG_DEPT */
 struct dept_key { };
 struct dept_map { };
@@ -469,5 +477,7 @@ struct dept_ext_wgen { };
 #define dept_hardirqs_on()				do { } while (0)
 #define dept_softirqs_off()				do { } while (0)
 #define dept_hardirqs_off()				do { } while (0)
+
+#define dept_set_lockdep_map(m, lockdep_m)		do { } while (0)
 #endif
 #endif /* __LINUX_DEPT_H */
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index dc3effabfab4..b154c1bb4ee5 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1615,9 +1615,39 @@ static int next_wgen(void)
 	return atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
 }
 
-static void add_wait(struct dept_class *c, unsigned long ip,
-		     const char *w_fn, int sub_l, bool sched_sleep,
-		     bool timeout)
+/*
+ * XXX: This is a temporary patch needed until lockdep stops tracking
+ * dependency in wrong way.  lockdep has added an annotation to specify
+ * a callback to determin whether the given lock aquisition order is
+ * okay or not in its own way.  Even though dept is already working
+ * correctly with sub class on that issue, it needs to be aware of the
+ * annotation anyway.
+ */
+static bool lockdep_cmp_fn(struct dept_map *prev, struct dept_map *next)
+{
+	/*
+	 * Assumes the cmp_fn thing comes from struct lockdep_map.
+	 */
+	struct lockdep_map *p_lock = (struct lockdep_map *)prev->lockdep_map;
+	struct lockdep_map *n_lock = (struct lockdep_map *)next->lockdep_map;
+	struct lock_class *p_class = p_lock ? p_lock->class_cache[0] : NULL;
+	struct lock_class *n_class = n_lock ? n_lock->class_cache[0] : NULL;
+
+	if (!p_class || !n_class)
+		return false;
+
+	if (p_class != n_class)
+		return false;
+
+	if (!p_class->cmp_fn)
+		return false;
+
+	return p_class->cmp_fn(p_lock, n_lock) < 0;
+}
+
+static void add_wait(struct dept_map *m, struct dept_class *c,
+		unsigned long ip, const char *w_fn, int sub_l,
+		bool sched_sleep, bool timeout)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
@@ -1658,8 +1688,13 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 		if (!eh->ecxt)
 			continue;
 
-		if (eh->ecxt->class != c || eh->sub_l == sub_l)
-			add_dep(eh->ecxt, w);
+		if (eh->ecxt->class == c && eh->sub_l != sub_l)
+			continue;
+
+		if (i == dt->ecxt_held_pos - 1 && lockdep_cmp_fn(eh->map, m))
+			continue;
+
+		add_dep(eh->ecxt, w);
 	}
 
 	wg = next_wgen();
@@ -2145,6 +2180,7 @@ void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u,
 	m->name = n;
 	m->wgen = 0U;
 	m->nocheck = !valid_key(k);
+	m->lockdep_map = NULL;
 
 	dept_exit_recursive(flags);
 }
@@ -2366,7 +2402,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 		if (!c)
 			continue;
 
-		add_wait(c, ip, w_fn, sub_l, sched_sleep, timeout);
+		add_wait(m, c, ip, w_fn, sub_l, sched_sleep, timeout);
 	}
 }
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d2805ce250cb..acab023eb015 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5036,6 +5036,7 @@ void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn cmp_fn,
 		class->print_fn = print_fn;
 	}
 
+	dept_set_lockdep_map(&lock->dmap, lock);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
-- 
2.17.1


