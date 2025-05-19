Return-Path: <linux-fsdevel+bounces-49348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E77DABB8C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A307A1895028
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7246272E4D;
	Mon, 19 May 2025 09:18:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7EA26A0BA;
	Mon, 19 May 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646331; cv=none; b=CpnHSRhqrVztvKHsLx0MZx6SK25B0PexEZVYHZn3mb4dH0wuqEw+F8dqH+clyifm8liB8qDS65B8zt7iVZNzntorzGBwrOZabU+lHJ8VGAuNqJBybLt5NibGSFWy9UdyzHsiBtYmb5FlT6KE9vhrPuPgqwLUzT9gEGzOS1Fm41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646331; c=relaxed/simple;
	bh=UPgrUdj2zJuIcM2CRwF3Ndg48wh45GAuitrkG1THTag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Y2Jd0iqX19oi9SH5Xo4C6mWgqqtxZYQ4UMtjZPTuOsx5lKIqtQd8q+bexlg9xf0XlzfqBuUr2iUDu+h3bzmWPEyBcoIZ1kEHcUsfdvL47Oc3ugVNDuWXap/dwWcqo7L3XyHJUH2cIctdKsKgFE5fls8gdPd20wyMGu6wLfz3CDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-70-682af76d4e9d
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
Subject: [PATCH v16 03/42] dept: add single event dependency tracker APIs
Date: Mon, 19 May 2025 18:17:47 +0900
Message-Id: <20250519091826.19752-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSWUwTYRDH/Xa3u22huKnXKhq0EQ+MKF6ZGM948Pmg8YoPGpVGVtsI1bSK
	oMGAHHJ7JEAUrLVIbWiR2qLiUYIQLg9EwXIIKKgEwhXRVkE8CpGXyS8z8//NywhJaZVghlCp
	OsWrVfIQGS2mxH2e+sWqH36KpfkDc8D5PYGC7AIzDbV3TQjMhdEEdJcHQoOrF8GvV69JyEyv
	RXCrvZWEwoo2BHbjBRrqPntBvXOAhur0ZBpicgpoeNMzQkBLxlUCTNbt8MHQScGLy3oCMrtp
	yMqMIdyli4AhQx4Dhihf6DBeZ2CkPQCq2xwCsDcvgmvaFhqe2qspqCjqIKDucTYNbea/AnhR
	UUWBK80baq+kCiC/X09Dj8tAgsE5wMDbEh0BFbqpYIl1C+O//RFAZWoJAfG37xFQ3/QEQXHC
	RwKsZgcNZc5eAmzWdBKG75Qj6EjrYyAuZYiBrOg0BMlxGRTEtqyEXz/dl298D4DomxYK8n87
	0Ia12Kw1I1zWO0DiWNsZPOx8R2O7S0fh53oOP7reyuDY4mYG66ynsc3oh3OedhP41qBTgK15
	iTS2Dl5lcFJfPYH7a2qYnTP3i9cE8yHKMF69ZF2QWPHtTQF58iUXrm+zUFHINikJiYQcu4Kr
	evgQjbOzrokaZZqdzzU2DpGjPJmdzdlSOwVJSCwkWYcH13CjaSwwid3G5TpqxgIU68sN2h/Q
	oyxhV3JV9y79l/pwJkvJmEjEruKak8vG+lL3Tr1JS41KOTZLxP18a/kfmM49MzZSl5FEhybk
	IalSFRYqV4as8FdEqJTh/kdOhFqR+78MkSMHitBg7Z5SxAqRzFNisS9USAXyME1EaCnihKRs
	siTPtkAhlQTLI87y6hOH1adDeE0p8hZSsmmSZa4zwVL2mPwUf5znT/Lq8SkhFM2IQtrdre1I
	XZj7O6txb9S81+8OafdVWjZvvd8/uzgmZjhyy4NkyZevu1ZvGOn+8inFdLD9qGRj4qvlc6Z5
	SX2au/YGpbV6LnJWn4e5kRfBE3/0PR+XQRsmvt+xPmVWz/3yHecKNjV4G70e25ZNSfWwBSVu
	tvcY/4iGf+BAqkiT8CzbRyqjNAp5gB+p1sj/AV5ct3JbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0xTaRDH/c6das1JJXq8BdPEqBgvGKtDNIT4IJ+a3bjG4OVFGz3axoLY
	CopmI9iCLFAQIrCiYEGtWIqUFu+UIChaLwiCRQhWIayCoESkrBUUC8aXyS/zn/nNy3CkzELP
	4tTRh0VttFIjZySU5M81+iWa/4NVy1uzAbxDKRScL7cy0HitFIG1MpGA3gcR0Drcj2Dk2XMS
	8nIaERR1viahst6DwFlykoHm7qnQ4h1gwJWTxoD+YjkDTX2jBHTkZhNQav8D3pjfUfDkdDEB
	eb0MnMvTE/7SQ4DPbGHBnDAfukryWRjtDAGXx01DXYGLBmf7Yjhb2MFAldNFQf2tLgKa75xn
	wGMdo+FJ/SMKhjNmQ2OWkYayT8UM9A2bSTB7B1h4UWMioN40HWwGvzX5yw8aHhprCEi+VEFA
	S9tdBNUpbwmwW90M1Hn7CXDYc0j4duUBgq6MjywkpftYOJeYgSAtKZcCQ4cCRr76LxcMhUDi
	BRsFZd/dKDwMWwutCNf1D5DY4DiCv3lfMtg5bKLw42IB385/zWJDdTuLTfZY7CgJxhereglc
	NOilsd3yD4Ptg9ksTv3YQuBPDQ3s5rk7JWv3ihp1nKhdFrZbovrSVE7GPBWOFntsVAJyTEtF
	AZzArxS8zW3UODP8AuHVKx85zoH8PMFhfEenIglH8u7JQmtBGxoPpvEbhMvuhokFip8vDDpv
	MOMs5RXCo4pM9EsaJJTaaiZEAfwqoT2tbqIv88+0lBZSp5HEhCZZUKA6Oi5KqdYoluoOqOKj
	1UeX7jkYZUf+DzL/PZp1Cw01R9QinkPyKVKbc5FKRivjdPFRtUjgSHmg1OJYqJJJ9yrjj4na
	g7u0sRpRV4tmc5R8hnTjNnG3jN+vPCweEMUYUfs7JbiAWQlo/fvH2SVhc9Kn/3V8pjFra9Cm
	8BlBJ07d69zi6r+Px/IjNpcd8awLtd8c3FHZLSXXNRlWrc46k/6f4qqy73pkQLcvcju3KOlu
	rr5t/79FxorMrytCZUW96fqx2Ji3oRkjTaNJ+sU+uiL5ekrm2Z6b+w6tGLn6QVHl2Hcq/Pvn
	7hs9c6rllE6lDAkmtTrlTyrxfgA9AwAA
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
 include/linux/dept_sdt.h | 65 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 include/linux/dept_sdt.h

diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
new file mode 100644
index 000000000000..0535f763b21b
--- /dev/null
+++ b/include/linux/dept_sdt.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Single-event Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
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


