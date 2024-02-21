Return-Path: <linux-fsdevel+bounces-12235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C3F85D494
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552D61C2309C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAC54C62A;
	Wed, 21 Feb 2024 09:50:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D869440BFA;
	Wed, 21 Feb 2024 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509003; cv=none; b=uqzA5H8KmuBNmyOBUrLa+GnOLoLlNsTb/OZGKMRUU5gusN0fUgyzXEtEKTRLJd2YFUW2mAMyJJQGWM+kTw7VsLRqRKjrk3QmHipTHCh0QQZ8Q/RYnoLAQokPKbdiV1/4bsYfFPddo7bjTal2iEfBFubtGzKkDTz/Jr92kDrZ2Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509003; c=relaxed/simple;
	bh=7Na745h6mqt6szPtcPf56L4nwkzcVctpfLScpiam1ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=td8pYmZqjS1UfmX9zIJJCZngNJfo0P8nYUGFxtRdndA5QGFcrT2rNMV/UTd41UwGql8rZLQ+MBisC7YXX4jcdL7Cf92cLO8sekicAOx/TWaQq4YbOiqeIcSogA27eilQBWzTca/Pqe1Xqu6yNpwKHfjzZGYcRvcOdNwMrFtirrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-48-65d5c739e041
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
Subject: [PATCH v12 12/27] dept: Distinguish each work from another
Date: Wed, 21 Feb 2024 18:49:18 +0900
Message-Id: <20240221094933.36348-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0yTZxjHfd/v2I6az4L6TWM0TZxRAuoA84xsi4eLvbtYYmK8GRejjk+p
	cpCiHEwWUaqyIgxYEAfEcFhqgTqwRQWkWDGCqIV2VDkjoE47wBLWdquwQ6vZzZNf/v/8f1cP
	TynbmXW8Ju2EpE1Tp6hYOS2fD6uNiu99Iu0YKsVQenEH+LwFNFQ3m1hw/NKEwNR6BoP7/hcw
	5J9DsGQfoKCi3IGgdnqCgtaeSQRW41kWBl+sBJfPw0JfeSEL+fXNLDhnlzGMXyrD0GT+Ch6V
	1GGwBV7RUOFmoaoiHwfPawwBQyMHhrzNMGOs5GB5eif0TT5lwDoaCT9dGWeh09pHQ0/bDIbB
	jmoWJk3/MvCo5wENjtIiBq69qWNh1m+gwODzcPCrrQZDiy4oOv/HPwz0FtkwnP/5OgbXyG0E
	XQVTGMympyzc881hsJjLKXh79T6CmeJ5Ds5dDHBQdaYYQeG5SzQM/N3LgG48Dpb+qmZ3x5N7
	cx6K6CzZxOqvocnDOpG0V05wRNc1ypEa80liMW4j9Z1uTGoXfQwxN37PEvNiGUf08y5M3vT3
	c+TB5SWavHBV4P3rv5Z/miSlaLIk7fbPE+XJlU4POv57eM5w2w9UHmoQ9EjGi0KseFlnxHrE
	v+OX3pWhmBW2iMPDASrEEcIm0VL0G6NHcp4SLnwgGhfsbKgIF/aJY3llXIhpYbP49mYxFfIo
	hF3ignP1e/1GsanF9s4jC8YNVXNMiJVCnPjEeYMKOUXhgkx0Xp2i3w8+FO8ah+kSpKhBKxqR
	UpOWlarWpMRGJ+emaXKiv01PNaPgQxm+W05oQ4uOA91I4JEqTJF8yyUpGXVWZm5qNxJ5ShWh
	oLODkSJJnXtK0qZ/oz2ZImV2o/U8rVqr+NifnaQUjqhPSMck6bik/b/FvGxdHtpz+BTZesdz
	9JOhDc59p/+UolYZRsa7Erx7D9r6YHfMQiET7emNLzF5nr8s+Kjj7PP+wcLpLd4SOqsy0n13
	bbo9cteXnx3a8GO7ce+1bH/MmpxEq94hC7NPhKdeX3Rr872HriTxgxmPH7ftsQR0G1fXZczm
	229xsRHoWUPr6c4xuYrOTFbv3EZpM9X/ARgKPolMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSeUiTcRjH+723s8mLWb0dkI7sMNMEraeMiA56CQwJoqg/cuhbLq/Y1JwQ
	zNSO2UwnZjqrqbVMLWuaWamJlmfe08wrG5VZ1qSc5NGxBf3z8OHzhc9fD4M768jljCwyWpBH
	SsMllIgQHfBP3Li1sVfYZE71gPTLm8A6dZGA3NISCjrvFyMoKU/AYPzlPng9PYFgrq0Dh6zM
	TgR574ZxKG8YQVBdeI6CnvdOYLJaKGjOTKEgsaCUgq4v8xgMXdViUGwMgNa0fAxqZ8YIyBqn
	QJeViNnOJwxmDEU0GFTuYC7MoWH+nQ80j/SRUH+9mYTqgQ2QfWOIgqrqZgIaKs0Y9DzNpWCk
	5A8JrQ1NBHSma0i49y2fgi/TBhwMVgsN3bV6DB4k2Wrnf/wmoVFTi8H5Ww8xML15hqDm4igG
	xpI+CuqtExiUGTNxmL3zEoE59SsNyZdnaNAlpCJISb5KQMevRhKShvxg7mcutdOfr5+w4HxS
	2Rm+elpP8C35HP8kZ5jmk2oGaF5vjOHLCj34gqpxjM/7biV5Y9Elijd+19K8+qsJ47+1t9N8
	07U5gn9vysICVx4VbQ8RwmWxgtx7R5AoNKfLgk5/XhTXX3kFV6G7rBoxDMf6ch+mnNTIgaHY
	tVx//wxuZxfWlSvTfCTVSMTg7AVHrnCyjbIPi9jd3KBKS9uZYN252YpU3N4Rs5u5ya7Fds2x
	q7jiB7X/Og42fVc3QdrZmfXjerse4WlIpEcLipCLLDI2QioL9/NShIUqI2VxXsFREUZkexnD
	2fn0SjTVs68OsQySLBSHPjYJzqQ0VqGMqEMcg0tcxMQZmxKHSJXxgjzquDwmXFDUoRUMIVkq
	3n9YCHJmT0qjhTBBOC3I/68Y47BchTIeBWd0H5kclb1oLW3bEljhL1buGR9ep3+77Lb/2HFJ
	svcuh4LZBbLRIl1B/OD6JcdCtgSZW/I9HeVrNmrWZ7/K9VZZPvhoyoN/HZS47n1+o8Vt0K34
	gtot8YCnV9wJz6hV25Sn7ufNa31zDqVpzwWsximXSknbzZR4devY75i3ZJWEUIRKfTxwuUL6
	FwSUBtwuAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Workqueue already provides concurrency control. By that, any wait in a
work doesn't prevents events in other works with the control enabled.
Thus, each work would better be considered a different context.

So let Dept assign a different context id to each work.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     |  2 ++
 kernel/dependency/dept.c | 10 ++++++++++
 kernel/workqueue.c       |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 4e359f76ac3c..319a5b43df89 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -509,6 +509,7 @@ extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
 extern void dept_kernel_enter(void);
+extern void dept_work_enter(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -559,6 +560,7 @@ struct dept_task { };
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
 #define dept_kernel_enter()				do { } while (0)
+#define dept_work_enter()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 9aba9eb22760..a8e693fd590f 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1933,6 +1933,16 @@ void noinstr dept_hardirqs_off(void)
 	dept_task()->hardirqs_enabled = false;
 }
 
+/*
+ * Assign a different context id to each work.
+ */
+void dept_work_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
+}
+
 void noinstr dept_kernel_enter(void)
 {
 	struct dept_task *dt = dept_task();
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..4452864b918b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -53,6 +53,7 @@
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
+#include <linux/dept.h>
 
 #include "workqueue_internal.h"
 
@@ -2549,6 +2550,8 @@ __acquires(&pool->lock)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	dept_work_enter();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
-- 
2.17.1


