Return-Path: <linux-fsdevel+bounces-12231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF4485D47F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2497E1C22F9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529AD45018;
	Wed, 21 Feb 2024 09:50:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AC13D998;
	Wed, 21 Feb 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508999; cv=none; b=PQlz0BHluIorRCG68L6l4R50agwmloadsCenFvZptQNUjF3ChtZ2w8r6Cd6cf+h6UEtESrKrGzHnao/XtbU9Bn/iwTWzyFKi2wLE7piDys8uA9J//CiaU/uk9oDQcOmI5QUTghLDhIgGZKi4misb4dvhK9jw2CLD+wsVdPp8Qzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508999; c=relaxed/simple;
	bh=Z/lrsPfinthw0Keb2TOWgQylHJ0tuWxQmHrjSTWrwaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Zzxp5vTk90drJazPHOubyHaEuy8gqBzpxDNkDUQbD9+VZKDl4EN4aCKSHREhNoyF/u6pSkSo40y1FmMvTtygXNCYN20ttMfBzuBIyzJvp3tcMP/gMzKOueAZZYg2TN+rd5Ad2lMqWfyyjSVKr64DWzD3mNAL0zW7qUAoo5z4UDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-f7-65d5c7395078
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
Subject: [PATCH v12 07/27] dept: Apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete()
Date: Wed, 21 Feb 2024 18:49:13 +0900
Message-Id: <20240221094933.36348-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSWUyTaRSG/b5/pVLz2yHhVy/QJobEnQH0SNToqOG7MZp4YeLEaJXfabVF
	0rLIZBzBIjIgLhhaBRSKk1qhLhSI6AhWUKBuFG0ddIAog0sVRNGiLKKtM96cPHnPe56rw1OK
	OmYqr0lMlvSJKq2SldGy/lDL3MUtXmlB08lwOHpwAfg/5NBQcsHOgvt8JQJ7TSYG3814+Huo
	D8Ho3TYKzIVuBJanXRTUNHcjqLftY+FB7yTw+AdYcBXmsWA8fYGF9tdjGDpNBRgqHWvg9pFy
	DM7hFzSYfSwUm404MF5iGLZWcGDNmAk9tiIOxp5Ggav7IQP1j2fDiVOdLFytd9HQXNeD4cGV
	Eha67V8YuN3cSoP7aD4D596Us/B6yEqB1T/AwX1nGYaLWQFR9vtxBlrynRiy/6zC4Hn0F4KG
	nCcYHPaHLDT5+zBUOwopGDlzE0HPoX4O9h8c5qA48xCCvP0mGto+tzCQ1RkLo59K2OVxpKlv
	gCJZ1WmkfqiMJrfKRXK5qIsjWQ2POVLmSCHVtlnk9FUfJpZBP0McFX+wxDFYwJHcfg8mb+7d
	40jr8VGa9HrMeN20jbIlCZJWkyrp5y/bIlO7up8xSdcm7x4b35uBaiblohBeFGLE0vc9dC7i
	v/HHqg3BmBUixY6OYSrIYcJ0sTr/OZOLZDwlHJgo2t7eZYP9HwS1OJIdHezQwkzR+KiUDbJc
	iBVv7cvG/+kjxMqLzm+eEGGheLa4jwmyItDxttdSQacoGENEh9f5/8EU8bqtgz6C5GVoQgVS
	aBJTdSqNNmaeOj1Rs3vetl06Bwr8k3XP2M91aNC9vhEJPFKGytWXPJKCUaUa0nWNSOQpZZic
	TgtE8gRV+q+SftdmfYpWMjSiaTytDJf/OJSWoBB+USVLOyUpSdJ/32I+ZGoGiv/Np9uzN/yJ
	y3RJ5s5bv6hr7Zwzq39aOMdSmbNq64doT8PJ2pHLsdft0QO/e7dvnGBKau893LxjhiUsqkBx
	pU13zBWX/M+qog3mqvgbixZnrl3+qpSUFEWk73xXEXfDcG68ZcqJTdaIpRmRKStbzXcmrnju
	jfT9q1hRG0NM2lCFzvhZSRvUqqhZlN6g+gpNMSk1SwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzH+36f5/k+T8fxSHhGhtvMpoSRfYxhRr5jjM1mMxs3nnXHddld
	RTYTnSgVIUeFU3ZyRbrLoh+61fpxLKJDLDdufkWqpSun/Liz+ee91z6f195/vQUmLJ+bKmj1
	ibJBr9apiIJVbFqWNm9py3N5gTkVQW7WAvANnmShsLyMQPvtUgRllUcxdDetg5dDPQhG2p4w
	YM5rR3Dt3RsGKps9COpKjhHoeD8O3L4+Aq68UwTSissJPP06iqHrwlkMpfaN8OhMEQan/xML
	5m4CBeY0HIjPGPxWGw/W1NngLcnnYfTdQnB5XnDQeNnFQd3rSLh0pYtAbZ2LheZ7Xgwd1YUE
	PGV/OHjU3MpCe242B7d6iwh8HbIyYPX18fDMacFwxxRoS//+m4OWbCeG9OsVGNyvahA8OPkW
	g73sBYFGXw8Ghz2PgZ83mhB4c77xcDzLz0PB0RwEp45fYOHJrxYOTF0xMPKjkKxaRht7+hhq
	chygdUMWlj4skuj9/Dc8NT14zVOLPYk6SubS4tpuTK8N+Dhqt2UQah84y9PMb25Mex8/5mnr
	xRGWvneb8eaI7Yrle2SdNlk2zF+xS6FxeT5w++snHBz9fSQVVY7LRIIgiYul4YptmShUIOIc
	qbPTzwQ5XJwpObI/cplIITDiiTFSSX8bCfoTRY30M31R0GHF2VLaq6skyEoxRnp4LB0HWRJn
	SKV3nP96QsUl0s2CHi7IYQHn+dO7zBmksKAQGwrX6pPj1VpdTLRxnyZFrz0YvTsh3o4Ci7Ee
	Hs29hwY71jUgUUCqsUpNlVsO49TJxpT4BiQJjCpcyR4InJR71CmHZEPCTkOSTjY2oGkCq5qi
	XL9N3hUmxqkT5X2yvF82/P9iIXRqKjq/Wm+LSHmmi20frN1hkSO9aHjWrJWfFI2e/iavrheq
	byXQGgPZXbM0LiSj4Fz9irVtpcOSp5gbH7UkIsO7fQez17am/37i1ljzlmLHZCnkUNTHAVNL
	RaslujsrdiwzeTo3422Gk3wpzxEvn94QOqnKvzFqS63BWp/U+Wto63wVa9SoF85lDEb1X3Bj
	TTotAwAA
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


