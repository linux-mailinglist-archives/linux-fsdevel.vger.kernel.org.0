Return-Path: <linux-fsdevel+bounces-8726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE183A8CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656B71C22E8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3378563133;
	Wed, 24 Jan 2024 12:00:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E2B612C5;
	Wed, 24 Jan 2024 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097605; cv=none; b=HKYBNZ+BwlpIMh3jZd4dsLHc0GoPtccn6GILA4H0jkd/NgWcBqg07lzlqeCghv2rOwmiDVZlQEVUGvO2FKKYDt0GEJAAxJp96N8I7uKXvtycAdXDd5JlsFN/uZCyoEWTVGgFl49A9BB1dd8DGwDqOqF5lXbt4ju8MV2A/FuJo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097605; c=relaxed/simple;
	bh=Z/lrsPfinthw0Keb2TOWgQylHJ0tuWxQmHrjSTWrwaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m7mqMV3n7hkmlB4Tz2eULc5bIzAqeGrz2nPNJqjvnUGXJwgZDwt+LjFmDK3R6Lem9c9rG/NtNkGO45mK3oDsOcZcccmBZFHp054NI4uvDNPxpzXhPkAm1dzldGDWfa9nMjCFqCOBJcrlTWSfaRV3AWVTn+O0niAN21leRjOkHzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-b5-65b0fbb512f0
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
Subject: [PATCH v11 07/26] dept: Apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete()
Date: Wed, 24 Jan 2024 20:59:18 +0900
Message-Id: <20240124115938.80132-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMcRjHfb4/r+P4OjbfmLFbzWQkqj3MLGbzMT/G/GMYjr5zN3XlUmQz
	3ZVECllOP3CVnXMd5XvHUHGyUlEdtZyWVimkn0vXnBJ3mX+evfa8n+f111tCyp/R8yVqzQlB
	q1FGKRgpJR2YUbD80XipsFKfFgJXL60E92gaBfklVgacD4oRWO06AnqrNsOHsX4E4/WNJBiy
	nQgKOj+RYK9uR1Bh1jPQ1D0Tmt1DDNRmpzOQXFTCwLu+CQLarmcRUCxuhzdXCglweL5SYOhl
	IM+QTHjHNwI8JgsLpqRA6DLnsjDRGQK17S00VLQug5xbbQyUV9RSUP2ki4CmZ/kMtFv/0PCm
	uoYC59UMGu4PFjLQN2YiweQeYuG9w0hAaYpXlPpjkobXGQ4CUu88JKD5YxmC52kdBIjWFgZe
	ufsJsInZJPy6W4WgK3OAhXOXPCzk6TIRpJ+7TkHj79c0pLSFwfjPfCZiLX7VP0TiFNtJXDFm
	pHBdIY+f5n5iccrzVhYbxXhsMwfhovJeAheMuGksWi4wWBzJYvHFgWYCDzY0sLjmxjiFu5sN
	xM4Fe6XrIoUodYKgDV5/SKqqbe+hY1/MPjUxeTYJ2WdeRH4Sngvly85b0X/ObNDTPma4JbzL
	5SF9PJdbzNsyvnj3UgnJnZ/Om4frGV8wh1PxrQ29U0xxgXyhwz4lknFhfPmLYvqfdBFfXOqY
	Evlx4fz9nFbKx3LvTYflMuuT8lyyH+/ILWL/PfjzL80u6gqSGdE0C5KrNQnRSnVU6ApVokZ9
	asWRmGgReRtlOjOx7wkace6uRJwEKWbIIiwlgpxWJsQlRlciXkIq5spc/g8EuSxSmXha0MYc
	1MZHCXGVaIGEUsyTrRo7GSnnjipPCMcEIVbQ/k8Jid/8JLR/y657uvCN3FO9+pgx4ABZpLFu
	7dGpNn3Ub5y1ZlcP3X9tx+qqL31ZTeLhDS835Jnc8QGmwNCbb22Pt12OaNnjH3T8tj14+eh6
	g9gtLlWKYqqnLmcytkuKs9oSB0oGv3+LqF9UFjzsvD1cs7kvbDRg4a/sztTPdbdcZHqg7vji
	NQoqTqUMCSK1ccq/nZYfxk0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX+P13H5dcJPnm9rJpNI+hijf6zvPI3ZPM2mGz86rthdjphJ
	RVF3ZMsl4Tp2bleUK+ah41YunfRALZUctUJKWbqbdB7umH8+e+39fu/110dESgvoEJEiMUlQ
	JcqVMkZMidcvS5t/d7RUiDB7J0NOdgS4hzMpKCgpZqDxdhGC4vKTBPQ6YuG1px/BaF0DCfrc
	RgSFnW9JKK92IbCZUxlo6g6EZvcgA87cLAbSrpcw8LLPS0DHxQsEFFnXQe15IwH2kY8U6HsZ
	uKxPI3znEwEjJgsLppRQ6DLns+DtXAhOVwsNVVecNNja58Glqx0MVNicFFTf7yKg6WEBA67i
	3zTUVtdQ0JijpeHWgJGBPo+JBJN7kIVXdgMBpek+2+lvv2h4prUTcPrGHQKa2x4heJz5ngBr
	cQsDVe5+AsqsuST8uOlA0KX7wsKp7BEWLp/UIcg6dZGChp/PaEjviILR7wVMzDJc1T9I4vSy
	w9jmMVD4uZHHD/Lfsjj9cTuLDdZDuMwchq9X9BK4cMhNY6vlDIOtQxdYfPZLM4EH6utZXJM3
	SuHuZj2xYdp28fLdglKhEVQLVsSJ452uHvrgk6Aj3l8nUlB54FkUIOK5xbyuPpX2M8PN4Vtb
	R0g/B3Oz+DLtB18uFpFcxlje/LWO8RcTuHi+vb73L1NcKG+0lyM/S7govuJJEf1POpMvKrX/
	FQVwS/hbl9opP0t9m/eWc+x5JDagMRYUrEjUJMgVyqhw9f745ETFkfBdBxKsyPczpuPenPto
	uCm2EnEiJBsnibGUCFJarlEnJ1QiXkTKgiWtU24LUsluefJRQXVgp+qQUlBXoqkiSjZZsnqL
	ECfl9sqThP2CcFBQ/W8JUUBICnrp6O/RGHuCFk3qyIyMvLYmfPqMb9vr5IPad66W2d4b27QZ
	A8c6dVWRXbiPHaOmYuduLgyKvjmnbV/a8zzb1GhPd/6E8dGf25I2vfjpqandOm+NO+Pum2sT
	d3wtiWswOp5+3rQyIkDfY1pKdt9TV6buWaWhlGsdoYaEjTG2sKEQ3bCMUsfLF4aRKrX8D8Uv
	ZDsvAwAA
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


