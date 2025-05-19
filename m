Return-Path: <linux-fsdevel+bounces-49349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E18ABB8CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FA5188BF99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7530F274667;
	Mon, 19 May 2025 09:18:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3693726D4F8;
	Mon, 19 May 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646333; cv=none; b=bai6IUGEs6fV1uQ+rE2Bk/t7Jt3NpyC2SAE/C66Cu7G2Cjje2cgX0g/+I8t+/ndp5NS5zV8nFy53jEP4OXBgUWsQZr30PPcQVUbsXuAJl+Co6iDPF4wZI2KPfL3byPo0s01J72f27AfQwyluGaSn+QPqiG7rkanMdtCfIkyc8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646333; c=relaxed/simple;
	bh=RX0BVWE27Cost6W7zXdbtvLSq8FC7lANMhyhh7fOZCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iOXj6GhrZq3lCVVkZpVEZecACw/MfBGM0aExdm+Yj1Jy21CEpob9C7bMNDa6+jFUSzacuMQKXBD9OZorPUnbgtmmH+lv7hCVhsHldMgVwIP5j+TF9xFubcfGjF4J5s7JIDKpQXMiEs5/H13tVsG5K2MJ61s3by+Y+vuaAUUvNK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-88-682af76e3e16
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
Subject: [PATCH v16 04/42] dept: add lock dependency tracker APIs
Date: Mon, 19 May 2025 18:17:48 +0900
Message-Id: <20250519091826.19752-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHed5rW6150+n2KCYzLV5gGYqB5czLNuMHn0RNTPxghKh0452t
	lkpaBTExgoIXGAQxpU6lFnBdpVVYq4tOS5DOIopasOM2YIMsKEJlAVqt4raC88vJL/n/z+98
	ORJa4WMXSLT6/aJBr9YpORkjC86u+lT/MkGzom1IBaHJkwxcqHNy4L/qQOC8lk/B8N0N0Bke
	RfDm4WMazCY/gqqBPhqu+foReOxHOXjy1xwIhMY4aDEVc3Cspo6DtpEpCnoryilwuDbDH7Yh
	Bh6UVVNgHubgvPkYFR3PKIjYanmw5S2GQfs5HqYGkqClv4MFT88n8L2ll4PbnhYGfDcGKXjy
	ywUO+p3/svDAd4+BcGks+E+XsHDlRTUHI2EbDbbQGA/tjVYKfNYPob4gKjw+8Q8LzSWNFBy/
	9BMFge5bCBpO/kmBy9nBgTc0SoHbZaLh9Y93EQyWBnko/C7Cw/n8UgTFhRUMFPSmwJtX0cuV
	k0mQf7GegStvO9BXa4nT4kTEOzpGkwJ3Dnkd+o0jnrCVIferMbl5ro8nBQ09PLG6DhC3PYHU
	3B6mSNV4iCWu2lMccY2X86QoGKDIi0eP+C0LU2VrMkSdNls0LP8iXaYZaf86qxIfzH/uYPNQ
	QFGEpBIsJOOxy2bqPQf9rfw0c8JS3NUVoad5rrAIu0uG2CIkk9BCxyzcWdmNpoMPhHW486iZ
	mWZGWIy99t9nRHIhBf/wrP1/6cfYUd84I5IKn+GeYu/MriLaCTgszLvOGSm2VK54x/PxHXsX
	U4bkVhRTixRafXamWqtLTtTk6rUHE7/Zl+lC0e+yHZ5Ku4HG/VubkCBBytnyek+8RsGqs425
	mU0IS2jlXHmte5lGIc9Q5x4SDft2GQ7oRGMTipUwyo/kK8M5GQpht3q/uFcUs0TD+5SSSBfk
	ofIlqp3xa+Jb519ETyOW3k2kbdvKhWd1934tnDWQCV6T1pzimuxLmShTSb9NG8nxT1xPL1m9
	8VZy1qEKHFNcuD5uouXt36rRvsgcZeud3TdXmbZtjTvVfGL9KmlD7HheSLVhT6lwZvthbNR2
	ueNqtl+P2eGomtf9+eMjR4I/r/4y1a5kjBp1UgJtMKr/AwUD32NZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+/3ua65WlyV5e1EMpDIyDY0DRRRE3swiIggiqJWXNpzTtjKN
	Ik17qZMUVCpny2ytbdXapKczc2Qt8zWXlpmVlGm+Ip1p2mMr+ufwge/3fM4/R0RIr1NzREr1
	QUGjlqtktJgUb1mVuSzxe5gioiwfg2/kDAklt6w0NN20ILBWZGDofRIDbaP9CCbqGwkoLmxC
	cPnDWwIqajsROE0naGj5OB28viEa3IU5NGReuUVDc98kho6iAgwW+2Z4Z+wmoe5cGYbiXhou
	Fmdi/+jBMG40M2BMD4Uu0wUGJj9EgruzlQKX3k2Bs30pnC/toKHS6Sah9l4XhpYHJTR0Wn9T
	UFf7jITRvLnQlK+j4MZgGQ19o0YCjL4hBjzVBgy1hllgy/JbTw3/ouCprhrDqfLbGLyvHyKo
	OvMeg93aSoPL14/BYS8k4Me1Jwi68gYYOJk7zsDFjDwEOSeLSMjqiIaJMf9l/UgkZFyykXDj
	Zytau4a3lloR7+ofIvgsx2H+h+8lzTtHDST/vIzj7194y/BZVe0Mb7Af4h2mMP5KZS/mL3/z
	UbzdfJbm7d8KGD57wIv5wYYGZuv8neLV8YJKmSJolq/ZI1b0efYm67nUjC8WKh15pdkoSMSx
	UdxA0wsmwDS7iHv1apwIcDC7kHPouqlsJBYRbOtUrk3/GgWCmew6ru1EMRlgkg3lXKY3OMAS
	Npq72uPB/6QLOIut+q8oiF3Jtee4/u5K/R2vpZQ8h8QGNMWMgpXqlES5UhUdrk1QpKmVqeH7
	khLtyP9AxmOT+ffQSEtMDWJFSDZNYnMuUUgpeYo2LbEGcSJCFiwxOxYrpJJ4edoRQZO0W3NI
	JWhr0FwRKQuRxO4Q9kjZ/fKDQoIgJAua/ykWBc1JRxHl5XW76u2f5sXE6j1JURvaqgy6RQO2
	XG/97pDGr4/jmmXO4/qPLmPJbJWvIUSy/deO3m7m5wpZ1Ontm47mP+gJNc1vbrwdPLYx7o5y
	cFvyi62PwjYU3V844+GENuLZtOHYsbu6hJDKgrgD6vXYszjXvNnxeTjcSEe7E85zqTGbkmSk
	ViGPDCM0WvkfHkKg8jwDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Wrap the base APIs for easier annotation on typical lock.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_ldt.h | 78 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 include/linux/dept_ldt.h

diff --git a/include/linux/dept_ldt.h b/include/linux/dept_ldt.h
new file mode 100644
index 000000000000..8047d0a531f1
--- /dev/null
+++ b/include/linux/dept_ldt.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lock Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
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


