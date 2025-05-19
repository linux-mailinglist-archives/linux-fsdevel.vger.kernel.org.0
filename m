Return-Path: <linux-fsdevel+bounces-49347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E29ABB8C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D34F7AB970
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AFD270ED6;
	Mon, 19 May 2025 09:18:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6BC26657D;
	Mon, 19 May 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646331; cv=none; b=ce0EJtwpYJuXYBQHqIhvJVmDLm0mxuiF0HYAjtWX9VXXfcKvM3S1eTMKwZUqvpRfjyghc2QLwcqtSmP4DVp/HmGWtDVHquK0sfnBnYOAGk/GTBExpFE8MPedSZIVTlMXrO8HBru6CcmU6O4X2ah/l6eb3JGEX83Efr8Qz3/0Qog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646331; c=relaxed/simple;
	bh=7s1NGY+0taVVLGCaGeZpYQO8VebthwKwiBfZuZTjF3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=H2XuvlgPgEbOlM9RkUcZcGxG6wGDfVNWdzfVtmRcBDwYPtSH5wpW/yX+XR/vEuP3z1OQuhH+9zktHGhlnf3WrJp8A9sLWZIGGX9UXQjCZYpBivJkzHDvkBh6lzqtibTaVGpPPrH2J+w7DzjiARsQvP54uOn19uBiUovRAOfTCEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-94-682af76e9ead
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
Subject: [PATCH v16 12/42] dept: record the latest one out of consecutive waits of the same class
Date: Mon, 19 May 2025 18:17:56 +0900
Message-Id: <20250519091826.19752-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfZ772krNTWHbHSyZqXMqRicLbmdTlsUvPkt8mVkWI27ZbuTG
	VqGwVlCWmICik3ZU0RUmUCw4L7Wtii2J3bQGKYJocCgMgQGbuJEhb47ZOpC9lM59OfnlnPP/
	nS+Hp7StTCJvMO6RTUYpU8eqafV4XM0K45Nk/arSxkUQfnyEhqoLXhY6znsQeBsKMYxcXw/3
	ImMInrZ/T0G5vQNBzf0BChpaBhEEXQdY6PxlAXSFJ1los1tZOHj6Agt3Rmcx9Jcdx+DxbYSf
	lGEabh2rxVA+wkJl+UEcLb9hmFbcHCgFi2HIVcHB7P0UaBvsZiDYtxxOVvezcCXYRkNLYAhD
	53dVLAx6/2HgVssNGiK2JOgoLWHg3EQtC6MRhQIlPMnB3UYnhhbn81BfFBUe/uNvBlpLGjEc
	/uYihq7eywiuHvkZg8/bzUIoPIbB77NTMFN3HcGQbZyDQ19Oc1BZaENgPVRGQ1H/anj6Z/Sy
	43EKFJ6qp+HcX93o3TTirfYiEhqbpEiRfy+ZCf/AkmDESZObtSL5tmKAI0VX+zji9OUSvyuZ
	nL4ygknNVJghPncxS3xTxzliGe/CZOL2be79l9LVazPkTEOebHrtnU/V+puFE2zOr/P3Wdoc
	uAA1qyyI50UhVaxyr7UgVQzPTHWiOWaFJWJPzzQ1xwnCQtFfMsxYkJqnhO754j1Hb2wpXpDE
	R4FRPMe0sFisc/0eY43whtg7aGf+k74seuobYyJVtN9nDcWyWmG12OWppuekolCpEuvOhp4F
	XhSvuXroY0jjRPPcSGsw5mVJhszUlfp8o2Hfyh3ZWT4UfS9l/+z2AJrq+KAJCTzSxWnqg8v0
	WkbKM+dnNSGRp3QJGrd/qV6ryZDyP5dN2Z+YcjNlcxNK4mndC5rXI3sztMJOaY+8W5ZzZNP/
	U8yrEgtQ+nROgdknzTzkS3PHHvz4qCwQP7puc25OXOtXCWknh1tfbU74MGNm6NIrbzJvbWh+
	zt5uDoR3vbftRFCudG2puGaLJ8oG5evdb/eHbZ60Jw8+2nVpgfVjTXrSQKkju26N1bDuqEO5
	XLxp05qt3tq+s+3FiUyq2PBZ8fg27YH0/FD5FzrarJdSkimTWfoXSiC0w1oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfZ73VorV10r0VbY4m4BaL4PEmmM2jZ/w2ZI5wxcUb7yZ72wj
	FNMKAw0LCBqEQdCl4gVYBS2kLYgtS5hSJKDVghc2ugoIKMQZG24OaRnK1ILxy8kv53/O73w5
	MkppZZbLdPqjkkEvJqtYOS3f8VXuev2UWhvT7scQmMynoeyanYXOOhsCe0MOBv+d7fA4OILg
	7YNHFJSaOhFcHuynoME9gMBVc4KFrucLwBsYZ8FjKmQht+oaC38Oz2DoO3cWg83xHTy1vKCh
	o6QSQ6mfhUuluThUXmKYtlg5sGRHwVDNRQ5mBmPBM+BjoK3cw4Crdy1cqOhjocnlocHdOISh
	60YZCwP29wx0uO/RECyOhM4zRQzUjlWyMBy0UGAJjHPwV4sZg9u8BOrzQtZTr98xcLeoBcOp
	K9cxeHtuImjOf4bBYfex0BYYweB0mCh4U30HwVDxKAcnf5nm4FJOMYLCk+doyOvTwNv/QpfL
	J2Mh57d6Gmr/96FtW4m9wo5I28g4RfKcP5E3gb9Z4gqaadJeKZA/LvZzJK+5lyNmRxpx1qhJ
	VZMfk8sTAYY4rKdZ4pg4y5GCUS8mYw8fcjs/T5R/fVBK1qVLhi+3Jsm17Tlj7JF/wjMKPOU4
	G90OK0BhMoHfKFyd6EKzzPKrhO7uaWqWI/gvBGfRC6YAyWUU7wsXHpf3zA0t5kXhVeMwnmWa
	jxKqa/6dYwW/SegZMDEfpSsEW33LnCgs1O8tbJvbVfIawWuroEuQ3IzmWVGETp+eIuqSNRuM
	h7WZel3Ghh9SUxwo9EGWrJkzjWiya3sr4mVINV9R71qjVTJiujEzpRUJMkoVobA6V2uVioNi
	5jHJkHrAkJYsGVtRpIxWLVV8myAlKflD4lHpsCQdkQyfUiwLW56NqvjwFUkxC33rEjc/9930
	H890T+Tf/6abMVmzdL/GNzzxxHk7VtqyprLT5+8e3a9hv/feqt5ML/OfJ4diftTsrV3irfy9
	LGJL9C2XxbNI68zw1/Xrd0TeiCsJuqJvi1WJa3xxi2eCjHyQ01urK3JPpFqebNrzc7R6n5CQ
	GP/ZLrWKNmrFWDVlMIofAJeO0hA9AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The current code records all the waits for later use to track relation
between waits and events within each context.  However, since the same
class is handled the same way, it'd be okay to record only one on behalf
of the others if they all have the same class.

Even though it's the ideal to search the whole history buffer for that,
since it'd cost too high, alternatively, let's keep the latest one when
the same class'ed waits consecutively appear.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/dept.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index ad443e063fdc..a2384f3148c5 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1486,9 +1486,28 @@ static struct dept_wait_hist *new_hist(void)
 	return wh;
 }
 
+static struct dept_wait_hist *last_hist(void)
+{
+	int pos_n = hist_pos_next();
+	struct dept_wait_hist *wh_n = hist(pos_n);
+
+	/*
+	 * This is the first try.
+	 */
+	if (!pos_n && !wh_n->wait)
+		return NULL;
+
+	return hist(pos_n + DEPT_MAX_WAIT_HIST - 1);
+}
+
 static void add_hist(struct dept_wait *w, unsigned int wg, unsigned int ctxt_id)
 {
-	struct dept_wait_hist *wh = new_hist();
+	struct dept_wait_hist *wh;
+
+	wh = last_hist();
+
+	if (!wh || wh->wait->class != w->class || wh->ctxt_id != ctxt_id)
+		wh = new_hist();
 
 	if (likely(wh->wait))
 		put_wait(wh->wait);
-- 
2.17.1


