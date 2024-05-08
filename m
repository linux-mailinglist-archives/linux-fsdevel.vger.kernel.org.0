Return-Path: <linux-fsdevel+bounces-19048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9F8BFA17
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13895B233C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0367F484;
	Wed,  8 May 2024 10:03:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3DA7E107
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162581; cv=none; b=O1cRZ2iufCPS5QnipdZMcRrnNTMldkGU9WQC83aYFJpC3d8gqhW9C7G3fF4ywm32eikNq5OO4gNUygt1PtG20530duaY68/s6bg1tiR4c22y1LbqzDrb/DVCblLU/40JhAiGo+6NomYqHLJV/A09GzfJUAKqLHUUD1EcdohTNZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162581; c=relaxed/simple;
	bh=ZnDomY68etRURkOftpc7pgxDDdwCW9QdH8k+FPh35/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eZ+p3Q01kIwHoy1Oozy14CU9hzlpFzugGH7S8wOwafeTsBkWz1urPS2TIVLJjG5fo2cfG6m3SvOnHuHYQ4AO02dKL1BpUn6BkKrwrxbueN54YNfTj3OjM4YYXobIXekeKpeOuBBg/uI2GvKhyl8LFasOsXD3AsybpJ6tBHVRj8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-55-663b4a39ddb3
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
Subject: [PATCH v14 04/28] dept: Add lock dependency tracker APIs
Date: Wed,  8 May 2024 18:47:01 +0900
Message-Id: <20240508094726.35754-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+//P2TlztDjMyJNRxsAsK9Our92oPughioryS9HlkEc3vCSb
	l4wCzdllplmkM5OYZlO8pG1FN2dTcXkhW7VKRVeKeMmpYc0yJZtGX15+vO/zPDwfXjEheyzy
	Fitj4wVVLB8tpySkZGR+4drgvdsiArsqPeHGtUBw/bhCQkFVBQW2B+UIKh6lYhhqDIVPE04E
	U6/fEKDLsSEo7Okm4JHVgcBcepGC930LwO4ao6A5J4OCtHtVFLwdnsbQlXsTQ7lxP7RmF2Gw
	TA6QoBui4I4uDbvHIIZJQxkNhhRf6C3Np2G6JwiaHR9FYO5cDbfvdlFQY24mwfq0F8P75wUU
	OCpmRNBqbSLBdiNTBJWjRRQMTxgIMLjGaHhn0WOo1riDLn3/I4JXmRYMl4ofYrB3vEBQe+UL
	BmPFRwoaXE4MJmMOAb9LGhH0Zo3QkH5tkoY7qVkIMtJzSdB0bYKpXwXUrmCuwTlGcBpTEmee
	0JNcSxHLPcvvpjlNbSfN6Y0JnKnUn7tXM4S5wnGXiDOWXaU44/hNmtOO2DE32tZGc015UyTX
	Z9fhg95HJdvDhWhloqBat/OURKFxF4sb9Dp735KCUlC5TIs8xCyzkXVZRsj//DN3QDTLFOPH
	trdPErO8kFnOmjL75/YE45SwxW0hs+zJ7GZrcv7MeUnGl3V8GUSzLGU2sfqZ6/hfpg9bXm2Z
	y/FgNrMdA6NzGplb8yItn9YiiVszI2YfWlvQP8Nitq60ncxGUj2aV4ZkytjEGF4ZvTFAkRyr
	PBtw+kyMEbmfyXBh+thTNG47XI8YMZLPl1q8tkbIRHyiOjmmHrFiQr5Q2nh5S4RMGs4nnxNU
	Z06qEqIFdT1aIiblXtL1E0nhMiaSjxeiBCFOUP2/YrGHdwoKSt8aFh51yKvzm1Z3pDI44GWf
	vehTCO/Zn6YO6F0a4mdaUbJP0XrqZJD/Kp8ntq/K4yeSTh/20WYcEM6HDPRlf/7qPWj1K67j
	SxQf4l/XOe3DO+I8arKizJZlRHzH7dCmhoQ9jOBLtYQ1rJCF3U+95djQrele1Pgrck1P/4/I
	vJVyUq3gg/wJlZr/C/69brJIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/p+vm7OdkfjLLbszz06Z8yBrN+C0P6x9r8w9Hv6tTd9pd
	xdlY6YSeKK4j4Qqn1REX5qFrp3QVeqCkqKMW1To16SKl3GX++ey1z+e91z5/vEWE1Ej5iZTq
	OEGjlsfIaDEp3h2UvBJCgxRrrjs2QFb6GnAPnyEhr8RCQ+PdYgSWB0kY+qq2w/sRF4KxugYC
	jIZGBPmdHQQ8cDgR2ApP0tDUPQOa3YM01BrSaEi+UULDm/5xDO052RiKrbvg1fkCDPbRHhKM
	fTRcMSZjz+jFMGouYsCcuAi6CnMZGO9cC7XOFgoqr9ZSYPuwHC5fa6ehzFZLguNxF4amp3k0
	OC2TFLxy1JDQmJVBwZ2BAhr6R8wEmN2DDLy1mzDc03tsKT8mKKjOsGNIuXkfQ3PbMwTlZz5j
	sFpaaKh0uzCUWg0E/L5dhaAr8xsDp9JHGbiSlIkg7VQOCfr2ABj7lUdv3shXugYJXl96hLeN
	mEj+ZQHHP8ntYHh9+QeGN1nj+dLCZfyNsj7M5w+5Kd5adJbmrUPZDJ/6rRnzA/X1DF9zaYzk
	u5uNOGzeXvGmCCFGmSBoVgfvF0fpPY/F9s45esueiBJRsTQV+Yg4dh33M6eH8jLNLuZaW0cJ
	L/uyC7jSjK9Te4J1ibmb9du8PIvdwpUZJkgvk+wizvm5F3lZwgZwpslz+J/Tnyu+Z5/y+LCB
	XFvPwFRG6sk8S85lziOxCU0rQr5KdYJKrowJWKWNjtKplUdXHTyssiJPXczHx7Meo+Gm7RWI
	FSHZdEkjHaSQUvIErU5VgTgRIfOVVJ1er5BKIuS6Y4Lm8D5NfIygrUDzRKRsjiQ0XNgvZSPl
	cUK0IMQKmv9XLPLxS0TzU+Mz2yJ3q3dInoc9igy+tLh17gVX9C+V0+/hurDw6tklNUtXH/z+
	8d2T7ukvst8+HRhO+ap4/V434Y6YDE173rGgLbbhnMJf6W/7w/osXFG+YX3gp5kh9Z2Gh6qK
	QMnWyiXGL/kndHvs4TmO6iHZiZ2KQ7K6Ax1ESHRCfvBFC4qQykhtlHztMkKjlf8FVpLjJyoD
	AAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Wrapped the base APIs for easier annotation on typical lock.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_ldt.h | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 include/linux/dept_ldt.h

diff --git a/include/linux/dept_ldt.h b/include/linux/dept_ldt.h
new file mode 100644
index 000000000000..062613e89fc3
--- /dev/null
+++ b/include/linux/dept_ldt.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lock Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_LDT_H
+#define __LINUX_DEPT_LDT_H
+
+#include <linux/dept.h>
+
+#ifdef CONFIG_DEPT
+#define LDT_EVT_L			1UL
+#define LDT_EVT_R			2UL
+#define LDT_EVT_W			1UL
+#define LDT_EVT_RW			(LDT_EVT_R | LDT_EVT_W)
+#define LDT_EVT_ALL			(LDT_EVT_L | LDT_EVT_RW)
+
+#define ldt_init(m, k, su, n)		dept_map_init(m, k, su, n)
+#define ldt_lock(m, sl, t, n, i)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_L, i, "trylock", "unlock", sl);\
+		else {							\
+			dept_wait(m, LDT_EVT_L, i, "lock", sl);		\
+			dept_ecxt_enter(m, LDT_EVT_L, i, "lock", "unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_rlock(m, sl, t, n, i, q)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_R, i, "read_trylock", "read_unlock", sl);\
+		else {							\
+			dept_wait(m, q ? LDT_EVT_RW : LDT_EVT_W, i, "read_lock", sl);\
+			dept_ecxt_enter(m, LDT_EVT_R, i, "read_lock", "read_unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_wlock(m, sl, t, n, i)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_W, i, "write_trylock", "write_unlock", sl);\
+		else {							\
+			dept_wait(m, LDT_EVT_RW, i, "write_lock", sl);	\
+			dept_ecxt_enter(m, LDT_EVT_W, i, "write_lock", "write_unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_unlock(m, i)		dept_ecxt_exit(m, LDT_EVT_ALL, i)
+
+#define ldt_downgrade(m, i)						\
+	do {								\
+		if (dept_ecxt_holding(m, LDT_EVT_W))			\
+			dept_map_ecxt_modify(m, LDT_EVT_W, NULL, LDT_EVT_R, i, "downgrade", "read_unlock", -1);\
+	} while (0)
+
+#define ldt_set_class(m, n, k, sl, i)	dept_map_ecxt_modify(m, LDT_EVT_ALL, k, 0UL, i, "lock_set_class", "(any)unlock", sl)
+#else /* !CONFIG_DEPT */
+#define ldt_init(m, k, su, n)		do { (void)(k); } while (0)
+#define ldt_lock(m, sl, t, n, i)	do { } while (0)
+#define ldt_rlock(m, sl, t, n, i, q)	do { } while (0)
+#define ldt_wlock(m, sl, t, n, i)	do { } while (0)
+#define ldt_unlock(m, i)		do { } while (0)
+#define ldt_downgrade(m, i)		do { } while (0)
+#define ldt_set_class(m, n, k, sl, i)	do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_LDT_H */
-- 
2.17.1


