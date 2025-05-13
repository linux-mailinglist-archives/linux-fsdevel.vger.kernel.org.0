Return-Path: <linux-fsdevel+bounces-48846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881F1AB517B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7119E179D09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705DB25D524;
	Tue, 13 May 2025 10:07:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5662522B2;
	Tue, 13 May 2025 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130877; cv=none; b=aDAp/57gUKvGRdim4WeyhWHa5JipZFo4poSlCjAVETVD+5tiNUO64uKkUnzVJHNMPeAu9HsftPWZU6Hog/sXJEaPJH3kNJpODiIQLjPZtoMrfr2IcAqudciOV4cBCup991TBOD+lnGCN6meWk76XHybz7tkXbwRIJ5cDmAgQpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130877; c=relaxed/simple;
	bh=mVczWw5AJvTGaUa2k+kGuAdITLqzYAqLiO2CNQ+CNGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EhJSowfW9Q7Im0Xbub+cVqTdtO3XfUsGL3vOYSv6bLjFuTZsLrnwNffYeiA8yymTRLX9gx96rwwyMqzOnP0fProm/jPRy0afBFG+Z8Mm517D1jnwqBSlMT73QbxgJelKBpGv8cp3raP+3rTgB8u/MHM6SlUJOo3jeoUTKhm6KAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-8c-682319ef1729
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
Subject: [PATCH v15 13/43] dept: apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete()
Date: Tue, 13 May 2025 19:07:00 +0900
Message-Id: <20250513100730.12664-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSWUxTaRTH/b67tkPJtSBz3aJTYkwgLhCdHBPH6IPxPmjU+OaYaCPXaR1A
	LViExIQCEgcFEQVcQAtqrbQMnbaJjtIGyrAJYpVFVEApE0MHsIq2Y1nUVuLLyS+//8n/vByW
	kLdSi1h1arqoSVUmK2gpKZ2IqF7lWxirWvugZin4P54moaLOTIP7TxMCs12Hwdu8DZ4FxhFM
	P3pMQHmpG0HV8CAB9pYhBA5jDg3d/0ZCj99HQ3vpGRpyb9TR8GRsBsNAWQkGk3UHvDK8IaGj
	uBpDuZeGq+W5ODRGMQQNNQwYsleAx3iFgZnhBGgf6qPA8SIeLl8boKHe0U5Cyz0Phu77FTQM
	mb9Q0NHSRkKgaDG4zxdSUPu2moaxgIEAg9/HwNMGPYYWfQxY8kKF+R8+U9Ba2IAh/+ZfGHqe
	P0DgPP0ag9XcR0OTfxyDzVpKwNTtZgSeogkGTp0NMnBVV4TgzKkyEvIG1sP0p9Dlyo8JoLtu
	IaF2tg9t/kUwXzMjoWncRwh5tgxhyt9LC46AnhQeVvPC31cGGSHP+YIR9Nbjgs0YJ9yo92Kh
	atJPCdaaP2jBOlnCCAUTPVh429XF7FqyV7oxSUxWa0XNmk0HpKppVwE+6ph/YrTXjbKRLbIA
	SVieW8fPDjbT37muuxOHmeZW8v39QSLM0dxy3lb4hipAUpbg+n7gn1U+R+EgilPxOleQCjPJ
	reA7s///5mXcz/yrW5+pudJlvMnS8K1IEvKzt7vIMMu59Xyx3kTO7ZRLePudiDleyDca+8li
	JNOjeTVIrk7VpijVyetWqzJT1SdWHzySYkWh9zKcnPn1Hpp073EhjkWKCFmb9yeVnFJq0zJT
	XIhnCUW0THc3pGRJyswsUXNkv+Z4spjmQotZUvGjLDGQkSTnflOmi7+L4lFR8z3FrGRRNjq3
	cuJQ7zThJEbRlljJtovR/9TvWGaO3v5uY3pZpGf4U0VMTFPQaI/cp21c4O7wZXg4Jh857fLE
	qJdbuw7+1xln0OuzanOkWs31L5dyRpipSq+rZPeGiCd31jRaH12wECWHx95XmdbGjlxMjKfY
	7p2DufYDd4ecWcfGRyy9jgUKMk2lTIgjNGnKrw3Z7yFaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUiTaxjHu+/n1dXsycSetKwW0Ru9GGdxQYc6Hw50ExVFQdGHctRTG+mM
	rUwLO1u6MHVigUm+1LSapjN1E7NyIZPM9WLWnGWZlpQovkE5a2nrbB3Ol4sfvz/8/18unoqo
	ZKJ5jfakpNOqEhSsjJbt3JS+Znz+UvV6bx8DvolMGoprbCx03KlCYKs3Yhh6tBVeT44gmHr+
	goKC/A4EpR/fU1Df2ovAWXGeBc+ncOj0jbPgzs9mIf1GDQsvh6cx9Fy5jKHKvgP6rAM0PM0r
	w1AwxEJRQToOnkEMfmslB1bDMuivKORg+mMcuHu7GGgpcTPgfLsarl7rYaHJ6aahtbEfg+d+
	MQu9tl8MPG1to2EyNwY6LpkZqB4rY2F40kqB1TfOwatmC4ZWSxTUZgRbL3wNMPDY3Izhws06
	DJ3dDxA8zPyAwW7rYqHFN4LBYc+n4Ef5IwT9uaMcmHL8HBQZcxFkm67QkNGjhKnvweWSiTgw
	Xq+lofpnF/prM7FdsyHSMjJOkQzHafLD52WJc9JCkydlIrlX+J4jGQ/fcsRiP0UcFavIjaYh
	TEq/+Bhir7zIEvuXyxzJGu3EZKy9ndu18IDszyNSgiZZ0q3bHC9TT7my8AnnnJRBbwcyIEd4
	FgrjReEPscbzDIeYFZaLb974qRBHCotFh3mAyUIynhK6ZoqvS7pRKJgrqEWjy8+EmBaWic8M
	3357ubBR7LsVYP4rXSRW1Tb/LgoL+p/l7XSIIwSlmGepovOQzIJmVKJIjTY5UaVJUK7VH1en
	ajUpaw8nJdpR8IOsadOXGtGEZ6sLCTxSzJK3DS1RRzCqZH1qoguJPKWIlBvvBpX8iCr1jKRL
	OqQ7lSDpXSiGpxXz5Nv2SfERwjHVSem4JJ2QdP+nmA+LNqCyBf7uxsPNB9sG238Nh11VGgsM
	0VHaOsrkUULMudjBFdmHineWxzxJ227e85lPy4xdeDfnXVQ85TYlbXcH+AYdPtdUXHQndtQ7
	dn+NN67001mT7+I/O3JI0krHlin3frah+nqfVBd+OzCwF5PZKUfXB5o2vMtd7jIbvH+/2l2o
	oPVqVdwqSqdX/QsZd9PJPQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by wait_for_completion()/complete().

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


