Return-Path: <linux-fsdevel+bounces-13704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE6987319F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877541F219F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B360BA4;
	Wed,  6 Mar 2024 08:55:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9150D5EE83;
	Wed,  6 Mar 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715340; cv=none; b=nBRO9pvJukS+H3yf08yqGG6qHtC4yd+EOTpPuSOtsDj4Y4eR2NoZaiKrZ9Fxj0JWj3g1yRyf/xaLL4nUFjaMV+f6QCaNGxWEyhtTRorsLk4e9tzebGn3sUJ/ej4Dco39fI/PTOd/ld3QBdvIq6mvpGvs1HdL6efGjvxqM/Ma/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715340; c=relaxed/simple;
	bh=Z/lrsPfinthw0Keb2TOWgQylHJ0tuWxQmHrjSTWrwaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gzuoha344C1zMg2zFtFqPHpJ/8CEw7r/sZUpiN0rh3sFcakQ5yVOL/P7Rwz6H9TSJ9TvrZVHi4jWYlG4yLlukC8NNWBNCMpBup2+HLfMpVR7T8GzhAFd8wGZ86mbLpSMI3+kM6bS3wm4ZqXo1z85J11TTIqidi1K6O4vFdAbk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-98-65e82f7d9635
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
Subject: [PATCH v13 07/27] dept: Apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete()
Date: Wed,  6 Mar 2024 17:54:53 +0900
Message-Id: <20240306085513.41482-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRiA/b5zm8PJaRmdjCgHFhiphcYbmNWfOn+CsD9hhK085cgbM2+V
	aKndNbuopVZTYw0vZZuQptNptLS8zBQzU0kxt6XOtDZarss0+vPywPu8z69XREjrKV+RIv60
	oIyXx8poMSme9arYkhFkEYJvl8ng5vVgsH+/TELZ0xoaTE+qEdTUn8dgfbUP3jtmECx29xJQ
	XGhCUD4+SkC9cQyBXnOBhv5Jbxiwz9HQWXiNhuzKpzT0TbswjBTdwlCt3Q9vCyowGJxmEoqt
	NJQWZ2P3sGBwqqsYUGf5w4SmhAHX+FboHBukQD+8Ge49GKGhWd9JgrFhAkP/izIaxmr+UPDW
	2EGC6WYeBbW2ChqmHWoC1PY5Bt4ZVBjqctyhi99+U/A6z4Dh4qNnGAY+NCFoufwJg7ZmkIaX
	9hkMOm0hAT8fv0IwkT/LQO51JwOl5/MRXMstIiFnJBQWf5TRu3fwL2fmCD5Hl8rrHSqSf1PB
	8Y0lowyf0zLM8CptMq/TBPCVzVbMly/YKV5bdYXmtQu3GP7q7ADmbT09DN9xd5HkJweK8QHf
	SHFYtBCrSBGUQeFHxTGdY5+pxNYVaa7fmVmo3vsq8hRxbAhX3mim/vP0YyuxxDS7iRsaci6z
	D7uB0+VNLTsEOyPmHvXsXeKVbAzXNVqAl5hk/bmHRuOyI2FDudeaPPSvuZ6rrjMsdzzZ7dwN
	2w16iaVupzu73M1it/NDxGn7+ol/B2u4Ns0QWYAkKuRRhaSK+JQ4uSI2JDAmPV6RFng8IU6L
	3L+kznAdbkALpoPtiBUhmZdkt6dZkFLylKT0uHbEiQiZj+Tcz0lBKomWp58RlAlRyuRYIakd
	rRWRstWSbY7UaCl7Un5aOCUIiYLy/xaLPH2z0I6d8o2X7sxnOHThx7q8vhYcORPm9zE5aJfY
	1h8hnUuQlE6t80fWqMimtm5SX2seP9ab0KzIDF41GG1TWn0srVP+qlpLpt3SRRxa21x758v3
	53taE8N95iMbK8N+mc8uOnc+0DFVMpcgVlEnIlR+kpTMNXqrB6PLT7zfkRbWIiOTYuRbAwhl
	kvwvXp6YTUcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSaUiTcRwH8P7/55qrxdO0eqjoGEhUdBgqPzosCvJPUNSLinxRrnrIkc7Y
	zCNamS7xyJqCrsNqHkxRy9oWHTrPWq7DTO1Ercyy4dKoNtKJ5Yze/PjA98v31U9CyQuZORKV
	OkHUqJWxClZKS7evTV+uW/lVXPWybBrknV0Fnl+ZNBTVVLPQfqMKQbXtNAbXw0h47XUj8D17
	ToGxoB1B8cceCmyOXgT2ijQWOvunQ5dnmAVnQQ4L6aU1LLwYHMPQXZiPocqyDZ4YSjA0jgzQ
	YHSxcNmYjifOVwwj5koOzKnB0FdxiYOxjyHg7H3FQMsVJwP2d8vg4tVuFursThocd/swdN4v
	YqG3+g8DTxytNLTn5TJwfaiEhUGvmQKzZ5iDjkYThpv6ibWMn+MMPMptxJBRdgtD19taBPWZ
	HzBYql+x0OJxY7BaCigYLX+IoO/cNw7OnB3h4PLpcwhyzhTSoO8OA9/vInbjGtLiHqaI3ppE
	7F4TTR6XCOTepR6O6OvfccRkOUasFUtJaZ0Lk+IfHoZYKrNYYvmRz5Hsb12YDLW1caT1go8m
	/V1GvGNulHTdITFWlShqVkZES2OcvZ+Zow0zksfGT6Ui2/RsFCAR+FBhsNxF+c3yi4U3b0Ym
	HcQvFKy5Xxi/Kd4tFcratvgdyMcIT3sM2G+aDxauORyTHRkfJjyqyEX/NhcIVTcbJ3cC+HDh
	/NB51m/5ROdZejFrQFITmlKJglTqxDilKjZshfZITIpalbziYHycBU18i1k3lncX/eqMbEa8
	BCmmyTYGDIhyRpmoTYlrRoKEUgTJToz2i3LZIWXKcVETv19zLFbUNqO5EloxW7Z1jxgt5w8r
	E8QjonhU1PxPsSRgTiq6zkXsbe/I94bqaMa4GqlpyhFYtK3Ju3s8bfBazXxGT75HRjU9v7Nv
	Slh9XQ7+Xhv8YEO4/X1TUkP5ZuuWmrwQw50ls3bdjnofl7ReZ3NN1R9ovRFtE73zO4YWjW46
	ORAYb8pYY7NkbU/rSSz1zdxpGPV9crVIde554+vqGn7XKmhtjDJkKaXRKv8C2ya79ykDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes Dept able to track dependencies by
wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index fb2915676574..bd2c207481d6 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/swait.h>
+#include <linux/dept_sdt.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -26,14 +27,33 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
+	struct dept_map dmap;
 };
 
+#define init_completion(x)				\
+do {							\
+	sdt_map_init(&(x)->dmap);			\
+	__init_completion(x);				\
+} while (0)
+
+/*
+ * XXX: No use cases for now. Fill the body when needed.
+ */
 #define init_completion_map(x, m) init_completion(x)
-static inline void complete_acquire(struct completion *x) {}
-static inline void complete_release(struct completion *x) {}
+
+static inline void complete_acquire(struct completion *x)
+{
+	sdt_might_sleep_start(&x->dmap);
+}
+
+static inline void complete_release(struct completion *x)
+{
+	sdt_might_sleep_end();
+}
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), \
+	  .dmap = DEPT_MAP_INITIALIZER(work, NULL), }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -75,13 +95,13 @@ static inline void complete_release(struct completion *x) {}
 #endif
 
 /**
- * init_completion - Initialize a dynamically allocated completion
+ * __init_completion - Initialize a dynamically allocated completion
  * @x:  pointer to completion structure that is to be initialized
  *
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void init_completion(struct completion *x)
+static inline void __init_completion(struct completion *x)
 {
 	x->done = 0;
 	init_swait_queue_head(&x->wait);
-- 
2.17.1


