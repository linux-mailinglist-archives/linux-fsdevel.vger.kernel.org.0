Return-Path: <linux-fsdevel+bounces-19067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A209B8BFA73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6127B22432
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC485954;
	Wed,  8 May 2024 10:03:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD327E11E;
	Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162585; cv=none; b=RQIBmmWLAcUeTQBfGqRwPUJbF2zziUMh7krqlKxAzDdmnsEURRGd5rXpJBW4UPjZ0QFX/Xq1ThvB6FdtlL0u487JTQ5PWUgKljYirWRllkChyCnW8dr7vL6JwSuTkk2sg47wtN3Ubq6wg0sgIMvqqcgS0HLdz5cr7DONM8Lv67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162585; c=relaxed/simple;
	bh=yYyo9J9LbrfncpB2CWVjqJhM6aD/eyXV6B0l1bR9NkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bx7MTKAwffy3bd0r14NS5gjJn/kHrpgQEAJsv/SyFg0vvROSxLIDg5q0x3BMYJL8XN2EOqxy0pt3BCEd6yFCLrSbN/ytwk1nQxzPVNm/jea1V4zQ+AF7ID4OVZyxtvOogCdFySjsXspn6lhA3ogHnm7hK76pcD7X88uKCThTuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-45-663b4a3836b1
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
Subject: [PATCH v14 03/28] dept: Add single event dependency tracker APIs
Date: Wed,  8 May 2024 18:47:00 +0900
Message-Id: <20240508094726.35754-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH9zz3lTs6r5XIFT64dFETDSoG9PgSs8RE74y6RY0f9ANWe7HV
	gloERWMCUhgW0WrEbpUpINYGqmBrjC+AtaQoELFqVTCUCKljjVC02moFpwXjl5Nfzvn/f58O
	S8gdVBKryd4n6bKVWgXNkdxwfHXK4tVLM+dfHOXg5LH5EH5fSkJlg40Gz5V6BLZrhRgC7lXw
	PDKEYPTBQwJMFR4E1f0+Aq619SFoth6h4Yn/J/CGR2horyijoehCAw2PXo9h6D1zCkO9fS10
	GmswOKODJJgCNJw1FeHY+A9D1FLHgKVgBgxYzQyM9adCe98zCppfzIG/z/XS0NTcTkLbjQEM
	T25V0tBn+0JBZ9t9Ejwnyym4HKyh4XXEQoAlPMLAY2cVhkZ9TFTy7n8K7pU7MZTUXsXg7bmN
	oKX0JQa77RkNreEhDA57BQGfLrkRDBwfZqD4WJSBs4XHEZQVnyFB35sOox8r6V8Xi61DI4So
	d+wXmyNVpNhRI4g3zT5G1Le8YMQqe67osM4WLzQFsFgdClOive4oLdpDpxjRMOzFYrCrixHv
	/zVKin6vCf+RtJlbppK0mjxJN2/5Vk7tMpqpPc8TD0RM0wuQV25AcazApwldw6+I7/zWYptg
	mp8ldHdHJziB/1lwlP9LjTPBD3FCbdfKcZ7C/yY8bXzDGBDLkvwMocc4ZXwt49OFPl8n/qac
	LtQ3Oic0cfxCoWcwiMZZHsvcLjLHqlws85EVzJYg9a0wTbhr7SaNSFaFfqhDck12XpZSo02b
	q87P1hyYu313lh3FXslyeGzLDRTybHAhnkWKeJkzcUmmnFLm5eRnuZDAEooEmfvPRZlymUqZ
	f1DS7c7Q5WqlHBdKZklFomxBZL9Kzu9Q7pN2SdIeSff9itm4pAKkTVQd8oMv/s670KdJCTO5
	8/0dq93qvRt/8Y/9s+5Ex4Ied/pggff6j7lrjCo20KRsXbc+dXmywW8XHC69j9u0xaFLNzxc
	Mblw79Q3DbRnfeDSTtNp98vP1schfbItJa32Q0YwevpDKabLplkNRb8XZuDiRUtajpblq0v4
	lM/bFGSOWpk6m9DlKL8Cl/UHnUYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+//P1dnqMCUP+cEYdMFIk7RetDthpyipT0UENfKYS52xqWVo
	WFNT09BAV17CSy3RVTbNrDSW4tIss1zpTFeaZNLSbhst18UVfXn58TwPv08vS8iKqYWsUpUk
	qlWKeDktISVREdoVsD0iZmW/IwSK8leC41sOCeU3DDT0Xa9HYGg6hWGycysMOO0IZp48JUBX
	3IeganSEgCazDUFb7Wka+sfngcUxTUN38VkatDU3aHj2wY1huOQ8hnrjTugprMZgck2QoJuk
	oUynxbPnPQaXvo4BfcZiGKstZcA9GgLdtpcUdFR0U9A2tBwuXhqmobWtmwRzyxiG/rvlNNgM
	vynoMXeR0FdUQMG1qWoaPjj1BOgd0ww8N1ViaMictWV//UXBwwIThuzLNzFYrPcQ3M95g8Fo
	eElDh8OOodFYTMCPq50Ixs59ZCAr38VA2alzCM5mlZCQORwGM9/L6Y3hQod9mhAyG48Jbc5K
	UnhUzQt3SkcYIfP+ECNUGpOFxtpAoaZ1EgtVXxyUYKzLpQXjl/OMkPfRgoWp3l5G6LowQwrj
	Fh3e5b9PsjZajFemiOrg9Qclse2FpdTRAb/jTl1ABrLI8pAXy3Oh/Ge9gfAwzS3lBwddf9mX
	W8Q3FryjPExwdgl/uTfSwz7cNv5FwycmD7EsyS3mrYU+nljKhfG2kR78TxnA1zeY/mq8uNW8
	dWIKeVg2u7mnLWUKkaQSzalDvkpVSoJCGR8WpImLTVUpjwcdSkwwotln0ae7i1rQt/6t7Yhj
	kXyutI+OiJFRihRNakI74llC7ivtPLMmRiaNVqSeENWJB9TJ8aKmHfmzpNxPun2PeFDGHVYk
	iXGieFRU/28x67UwA+2TOVOhaUVGy25r8o7DEYMtFa+cri0ynb8k3b3Otlb6uOzW5qr5reb1
	u3NfaJWbUqrqLHRIbqItMHf/kYAN7gfRzeFBWwzWS2yFd7B3GsoPDm2+ElewyGEPjEyf9yZ8
	geL2yZ+R3hO39pY8cS9JOyBvjqqGZa2rxNdvs0wq81iUnNTEKkICCbVG8QdySKOkKAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Wrapped the base APIs for easier annotation on wait and event. Start
with supporting waiters on each single event. More general support for
multiple events is a future work. Do more when the need arises.

How to annotate (the simplest way):

1. Initaialize a map for the interesting wait.

   /*
    * Recommand to place along with the wait instance.
    */
   struct dept_map my_wait;

   /*
    * Recommand to place in the initialization code.
    */
   sdt_map_init(&my_wait);

2. Place the following at the wait code.

   sdt_wait(&my_wait);

3. Place the following at the event code.

   sdt_event(&my_wait);

That's it!

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_sdt.h | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/linux/dept_sdt.h

diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
new file mode 100644
index 000000000000..12a793b90c7e
--- /dev/null
+++ b/include/linux/dept_sdt.h
@@ -0,0 +1,62 @@
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
+#else /* !CONFIG_DEPT */
+#define sdt_map_init(m)			do { } while (0)
+#define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
+#define sdt_wait(m)			do { } while (0)
+#define sdt_might_sleep_start(m)	do { } while (0)
+#define sdt_might_sleep_end()		do { } while (0)
+#define sdt_ecxt_enter(m)		do { } while (0)
+#define sdt_event(m)			do { } while (0)
+#define sdt_ecxt_exit(m)		do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_SDT_H */
-- 
2.17.1


