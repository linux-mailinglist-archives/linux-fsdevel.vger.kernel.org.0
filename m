Return-Path: <linux-fsdevel+bounces-8723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC2383A8BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AFE28AF55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F85627F3;
	Wed, 24 Jan 2024 12:00:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502960DC5;
	Wed, 24 Jan 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097602; cv=none; b=HIVPmwgSzZ2+zKGoLEwkXvrHDM0tnKUWtmXUNxMHX3/SrIiKpJC27CN1r3cVuH5Loz4amOVHAtCucWCgJsHlWRDjUhvXV+hrRAiL9dJcHhaVi3P44zd6NLHE9OcQLPwARkytG8ZXafCNMrn6cbE9FCfmzsgt3jHPfv6Vk6Mjmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097602; c=relaxed/simple;
	bh=ZnDomY68etRURkOftpc7pgxDDdwCW9QdH8k+FPh35/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sQtIAxlx/a1szzowXynbed5Ad+8U07ne5Mii8PiUoVsqWdETMy/YChIX7NlV0CosX33ocBm6ispEXIRR36GwJS4dl3z26UoMw4R6shoAoksqoPi4oH8NonFC6y3Ej3ZuYpmZf8VJRVs2goxcKWLAYbgLZe7Ijqzq6r9iXdc0GY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-82-65b0fbb4b9cc
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
Subject: [PATCH v11 04/26] dept: Add lock dependency tracker APIs
Date: Wed, 24 Jan 2024 20:59:15 +0900
Message-Id: <20240124115938.80132-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/rtloc1sWjBcVKutEVq5eIMLodCKEoghKqoYccXptpGUQr
	tzIvpXmZN0Kt1piaaxp4WyxFzUS3ctWyaWZRmVuWtqFOrWn15eUHz8OP58MrwCUNZIBAHnOO
	V8TIoqSUiBC55pWuf+w18JuKMiSQlb4J3L9SCCiuqqDA+rAcQUXNFQwGWw7AG48TgbfTgoMm
	14qg9EMvDjWtfQhMuqsUdH+aDzb3MAXtuWkUJN+touDF0CQGjrzbGJQbQ6AjswwD8/gXAjSD
	FBRpkjHf+YrBuFZPg1YZCAO6QhomP2yG9r7XJJh61kHBHQcFjaZ2AlprBzDori+moK/iNwkd
	rc8IsGZlkFD5vYyCIY8WB617mIaX5hIMDCqf6NroNAltGWYMrt17hIHtbQOCJyn9GBgrXlPQ
	7HZiUG3MxWHiQQuCgZsuGtTp4zQUXbmJIE2dR4Blqo0ElWMreMeKqeAdXLNzGOdU1ec5k6eE
	4J6XsVxdYS/NqZ700FyJMYGr1q3l7jYOYlzpiJvkjPobFGccuU1zqS4bxn3v6qK5Z/legvtk
	02CHlpwQ7Qzno+SJvGLjrtOiCJVvXdxXvwv3zUqkROWSVCQUsEwQ+y1liPjP171p+AxTzCrW
	bh+f5YXMcrY64zOZikQCnLk+l9X96KRmggXMbnYqy4lmmGAC2Zbu97MiMbOVzW77iP5Kl7Hl
	BvOsSMhsYysLemY7El+nX3+LnpGyTLKQza7V/Fvhzz7V2YlMJC5Bc/RIIo9JjJbJo4I2RCTF
	yC9sCIuNNiLfS2kvTYbWohHrkSbECJB0njhYX8VLSFlifFJ0E2IFuHSh2O7/kJeIw2VJF3lF
	7ClFQhQf34SWCAipn3iL53y4hDkjO8dH8nwcr/ifYgJhgBIdPdjbOm1Vv9u+0ikMK1C6Vw9Y
	Jppf1ZR5dmlyfoaZL9e9qu2cCs68lLY4dqzj7PDJ56Ia0DS6jSGW7YjdW9cWid/yXzrx0nDY
	sT/f9N5xPKJ+TWWuSx2aE9I/HWAvVMd2EbZJ/4/HwlyRKUWjCXGj2WM/r+6797Z034pIxaLL
	e6REfIRs81pcES/7Aya/SYBOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+//P1dXqsKROFlQrFYosq9VLRrcvHroR9CEqolYdcjlnbHmt
	YObKcmnOUstLeMkl874JZWoMRW1dLZeZmLekFG9hTbLZZRp9efnB8/Dj+fCyhCyH8mFVmvOi
	VqNUy2kJKdkfFL+myl0hrmsr2wymG+vA9f0aCdnlJTS0lBUjKKmKwzDYGAzvJ4YRuF++JiAj
	rQVBXu9HAqqauhDUFV2mobV/LjhdYzQ40ow0xBeU0/BmaApDZ3oqhmLrPnieko/BPvmFhIxB
	GrIy4rHnDGCYNFsYMOt9oa8ok4Gp3kBwdLVR0JDjoKCuYzXcvddJQ22dg4SmR30YWh9n09BV
	8oeC501PSWgxJVFQOppPw9CEmQCza4yBt/ZcDBUGj+3qt98UNCfZMVy9X4nB+aEGwZNrPRis
	JW00NLiGMdisaQT8fNCIoC95hIErNyYZyIpLRmC8kk7C61/NFBg6FeD+kU3vCBIahscIwWCL
	EuomcknhWT4vVGd+ZATDkw5GyLVGCLaiVUJB7SAW8sZdlGC1XKcF63gqIySOOLEw+uoVIzy9
	4yaFfmcGPrDkiGTraVGtihS1a7edkIQYPOvODSyMLrTrkR4VyxKRF8tzG/kEt5GYZprz59vb
	J2fYm1vG25I+U4lIwhJcwmy+6OtLejqYz+3kf5mG0TSTnC/f2NpNTrOUU/C3mj+hf9KlfHGF
	fUbkxW3iS+92zHRknk6P5SaTgiS5aJYFeas0kWFKlVoRoAsNidGoogNOhYdZkedpzJemTI/Q
	99bgesSxSD5HusNSLsooZaQuJqwe8Swh95a2LyoTZdLTyphYURt+XBuhFnX1aDFLyhdKdx8S
	T8i4M8rzYqgonhO1/1PMevno0UnjhmOBqpDy5Tma0abIhoB36akG27fseVOVK2oc1Q+To6pc
	g2xn7Elb5vqgFt+BlWce+k8sGM3Uz4/oTjk8vr1acXDkaPOCdzU3w26rw5dnbSk0bdyTJYsa
	69r7Is7v64WLBfA+QhF6K6EWGzXBvs6E6AeNu9hY/yNnL/ttSfZLPysndSHKwFWEVqf8CxVQ
	taswAwAA
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


