Return-Path: <linux-fsdevel+bounces-48834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7B6AB512E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FFE16823E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE8245010;
	Tue, 13 May 2025 10:07:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2369C242D77;
	Tue, 13 May 2025 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130868; cv=none; b=h38qKvHnO+IhMrbKVl05YpeJDRAdvC6YU9ynDSVHlMd4dRF/GglaWGiNWVHrgqAKeHybFeFxbiqZhel4YYjuP1L8IYpgH4dOb3cBgyP1/9K4ZpLe9cDvECCpRCbROUwo3RutY+MfCS1T7Kx1dKDbqzA7VaVBQzA/QDqMcTBX6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130868; c=relaxed/simple;
	bh=QBX5hyho5OMfGnKSjp0Bq0FcSRd46hiVm1ArD8Nb7ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WbqRY0D1F4ALJlC66hCrx26aSXwR8iUcj3zAkfEYl0cr2hzfsP+T/cKRspDsayb6omer2UU/EiHXaIzZcfEM5splZemEjJhbCbiuglvlY2XUSkbizq8I/4ls9fjhdmkBTH7HItrb0cqhbiELWN6BuRhVOzGKlF1dhLfI6beUf90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ea-682319edb95d
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
Subject: [PATCH v15 03/43] dept: add single event dependency tracker APIs
Date: Tue, 13 May 2025 19:06:50 +0900
Message-Id: <20250513100730.12664-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxSHfd/7SeWSazV60Tm1xpihIhg0x0SNWTS7M36QLEHFmNnJja0r
	YIqiNS6h8jGHQpgbNApoKUttaCtQyMaQEqilgs5aFbGYgkqcGeFroG1EYFvL9J+TJ+d3znP+
	OSwh76QWs+qMk5I2Q6lR0DJSNhJtWjcSu1KV0JS7GYJvL5BQUWujwXfTisDWqMcw2PEFPA0N
	I5i6/4AAQ6kPQdXLPgIaPf0InJbzNDx+FQPdwTEaukov0pBbXUvDw6FpDIGyyxisjj3w3Pya
	hHslJgyGQRrKDbk4XP7CMGmuYcCcswoGLFcZmH6ZCF39PRQ4n62BK9cCNLQ4u0jwNA1geNxc
	QUO/7V8K7nk6SQgVLwHfj0UU2EdNNAyFzASYg2MMPGozYvAYF0JdXlhY8OYfCu4UtWEo+KUe
	Q3fvLQStF15gcNh6aLgdHMbQ4Cgl4P2NDgQDxSMM5F+aZKBcX4zgYn4ZCXmBjTD1Lny58m0i
	6K/XkWCf6UHbt4q2azYk3h4eI8S8htPi++ATWnSGjKR41ySIv1/tY8S81meMaHScEhsscWJ1
	yyAWqyaClOio+YEWHROXGbFwpBuLo14vk/xJqmxLmqRRZ0va9duOyFR9MwXUiZ+FM67RKSIH
	fT+/EEWxAp8k+P9oZz7yT7kTs0zzqwW/f5KI8AJ+udBQ9JoqRDKW4HvmCk8re1EkmM9/KdRX
	dMwyya8SagNuHGGO3yh4csrp/6XLBGtd26woit8kzNzwkhGWh2dKjFYyIhX48ihh9M/rHxZi
	hXaLnyxBnBHNqUFydUZ2ulKtSYpX6TLUZ+KPZqY7UPi/zN9NH2pCE76vXIhnkSKa6xxcoZJT
	yuwsXboLCSyhWMDpfwu3uDSl7qykzfxae0ojZbnQEpZULOI2hE6nyfljypPSt5J0QtJ+TDEb
	tTgHofzjBrXbObNfu/zI0rLtyQkrtumqvrlzfB7mfk1J3RnHJdcEljXX6w/0ZrcMKfPtjayq
	Iu2crrX9vpE77PEaPk1waSqTPnv+Zvfaz1fGH0zxxZTtG48mz+rcfycWmOy2Zn9sjNc6xzK+
	f1xX7UthYoaS7O6mVPfeg5m32nYFdijILJUyMY7QZin/AyHKe6xbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfZ73Vio1r0jmq8ZbjdFodKJAjnGSfdJHvH8gRoNKI6+2EZC0
	gjI00lGYq9LgBVEoWAEroVWgaESkhhSpMCaiICABFKJklZsCbcbNrXXZl5Nfzv/kd778JVRA
	CbNQooo7LarjFDFyVkpL92xJXTe0YIVyw+Vvi8E9fpEGY6mVheYHFgTWh1oMrrrt0O4ZRDD1
	8hUF2VnNCO70dlPw0NmDwF78KwstH+dAq3uEhYasSyykFpay8HpgGkPXjasYLLbd8N7cT0Nj
	ZgGGbBcLudmp2Dv+wjBhLuHAnLIS+opzOJjuDYKGnjYGavMaGLB3roVb+V0sVNsbaHBW9mFo
	qTKy0GP9h4FGZz0NHsMiaL6SwcD94QIWBjxmCszuEQ7e1JgwOE0/QJnOa00f+8bAi4waDOlF
	5Rha3z1F8OziBww2axsLte5BDBW2LAom79Uh6DMMcZB2eYKDXK0BwaW0GzToukJg6m/v57zx
	INDeLqPh/kwb+jmMWPOtiNQOjlBEV3GGTLrfssTuMdHkjwKBPMnp5ojuWSdHTLYEUlG8hhRW
	uzC5M+pmiK3kd5bYRq9yRD/UislwUxO3b/Eh6U/RYowqUVT/GBYlVXbPpDPx14WzjuEpKgX9
	Nk+P/CQCHyxcSx3lfMzyq4SOjgnKx4H8MqEio5/RI6mE4ttmC+1575AvmMfvEMqNdd+Z5lcK
	pV3PsY9lfIjgTMll/5MuFSxlNd9FfnyoMHOvifZxgPcm02ShM5HUhGaVoEBVXGKsQhUTsl5z
	UpkUpzq7/tipWBvyNsh8fvpKJRpv2e5AvATJ/WX1ruXKAEaRqEmKdSBBQskDZdrH3pUsWpH0
	i6g+dVSdECNqHGiRhJbPl4UfEKMC+BOK0+JJUYwX1f+nWOK3MAWV7w9uP1wUjncnhX96ZDSE
	6bY5jic3fZ06uFr/yWo4pHCV+28rHDMmb22srzvXv2Tdha9BkeaIN9zcTb32kMhBsjNN1Ebx
	uzbnD0Rv9A/uqN9q+ayv6jmo/fLxyJL4u8mhEZWTVXvl1WOe5aF+vQ7yYtoQ/2rfgT+RZsGG
	SPvND4VyWqNUBK2h1BrFv1Hq/mE9AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Wrapped the base APIs for easier annotation on wait and event.  Start
with supporting waiters on each single event.  More general support for
multiple events is a future work.  Do more when the need arises.

How to annotate:

1. Initaialize a map for the interesting wait.

   /*
    * Place along with the wait instance.
    */
   struct dept_map my_wait;

   /*
    * Place in the initialization code.
    */
   sdt_map_init(&my_wait);

2. Place the following at the wait code.

   sdt_wait(&my_wait);

3. Place the following at the event code.

   sdt_event(&my_wait);

That's it!

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_sdt.h | 64 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 include/linux/dept_sdt.h

diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
new file mode 100644
index 000000000000..93d772c71905
--- /dev/null
+++ b/include/linux/dept_sdt.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Single-event Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_SDT_H
+#define __LINUX_DEPT_SDT_H
+
+#include <linux/kernel.h>
+#include <linux/dept.h>
+
+#ifdef CONFIG_DEPT
+#define sdt_map_init(m)							\
+	do {								\
+		static struct dept_key __key;				\
+		dept_map_init(m, &__key, 0, #m);			\
+	} while (0)
+
+#define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
+
+#define sdt_wait(m)							\
+	do {								\
+		dept_request_event(m);					\
+		dept_wait(m, 1UL, _THIS_IP_, __func__, 0);		\
+	} while (0)
+
+/*
+ * sdt_might_sleep() and its family will be committed in __schedule()
+ * when it actually gets to __schedule(). Both dept_request_event() and
+ * dept_wait() will be performed on the commit.
+ */
+
+/*
+ * Use the code location as the class key if an explicit map is not used.
+ */
+#define sdt_might_sleep_start(m)					\
+	do {								\
+		struct dept_map *__m = m;				\
+		static struct dept_key __key;				\
+		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__);\
+	} while (0)
+
+#define sdt_might_sleep_end()		dept_clean_stage()
+
+#define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
+#define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)
+#define sdt_request_event(m)		dept_request_event(m)
+#else /* !CONFIG_DEPT */
+#define sdt_map_init(m)			do { } while (0)
+#define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
+#define sdt_wait(m)			do { } while (0)
+#define sdt_might_sleep_start(m)	do { } while (0)
+#define sdt_might_sleep_end()		do { } while (0)
+#define sdt_ecxt_enter(m)		do { } while (0)
+#define sdt_event(m)			do { } while (0)
+#define sdt_ecxt_exit(m)		do { } while (0)
+#define sdt_request_event(m)		do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_SDT_H */
-- 
2.17.1


