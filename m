Return-Path: <linux-fsdevel+bounces-19053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB3B8BFA26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05B8282AC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9DE81724;
	Wed,  8 May 2024 10:03:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD617E583;
	Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162583; cv=none; b=H4msbsUj/yWsJ27lSl317ANff1TaM8JIB/BcA9EkvkwYpLEyLeAUCAYwcYvTW33aJ+cG2ACERGO0o7mBHNB8/rj0mBz0vYjuJicL6Wc1u4hLM7mOxg0W9M0CZQLDXNbdg40jhGv7ZCk2sC3r7C5QpoAa2OKYjoEszFLDc5ACuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162583; c=relaxed/simple;
	bh=TSPxdh3H9mjhA/wDLLlJUz6YZTY7hYg5ulgpaHBJJSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gLbxsl5g0Gmj/uwaPqmU5X7PR7qPN7aA/aL8ymEKrUbFGL3aympNZE7UU3Fj6JPAcSN96k0da+uo9+VmdygAXHt2ZZH20SNheQSVxzw0KWtExcFOTkMMfQMQxKK9XzB+yQNTrnR0SHzYqMc2yvfHh5gvizIWsqVMbZT7b/qAMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-27-663b4a3ac0a8
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
Subject: [PATCH v14 17/28] dept: Apply timeout consideration to wait_for_completion()/complete()
Date: Wed,  8 May 2024 18:47:14 +0900
Message-Id: <20240508094726.35754-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfb/Pz26Ox2E98ofcZkZE5sfH718bDxsamyGTZ3rSzXW4FNlM
	6YQUYXXUaVfs3OpS7tJCccqlQyk10hJuDc1VpGuXzo8r889nr73fn8/rrw9LKMqoIFalOSJp
	NaJaSctIWffo/NlLNi6NnpvkWwSX0ueCp/8sCYYSCw2Nt4sQWMqSMXQ51sObATeCofqXBOiz
	GhHkf3xHQFltB4Iq8ykamjvHQIunlwZn1nkaUm6U0ND01YehPfsyhiLrJnieWYDBPviZBH0X
	Dbn6FOwfXzAMmgoZMCVNA5c5hwHfxzBwdrymoKotBK7ltdNQWeUkobbChaH5voGGDssfCp7X
	1pHQeCmDguKeAhq+DpgIMHl6GXhlN2Io1flFqT9+U/A0w44h9eYdDC1vHyB4ePYDBqvlNQ01
	HjcGmzWLgJ+3HAhcF7oZOJ0+yEBu8gUE509nk6BrXwBDXgO9arFQ4+4lBJ3tqFA1YCSFZwW8
	cC/nHSPoHrYxgtEaL9jMM4UblV1YyO/zUIK18BwtWPsuM0JadwsWehoaGKHu6hApdLbocXjQ
	LtmyKEmtSpC0c1bslcVYXl1jDuXJjtnONeEk9IFNQwEsz83ncyy/6f/c/74ODTPNTedbWweJ
	YZ7ABfO2jE/UMBOcW8bfbFg3zOO5vfy971kjOclN4085L+I0xLJybiHvKk/4p5zCF5XaRzQB
	/vjt554RvYJbwD9IyWHSkMy/42V5d3069e9gEv/Y3EpmIrkRjSpECpUmIVZUqeeHxiRqVMdC
	9x2MtSL/L5lO+CIqUF/jtmrEsUg5Wm4PXBKtoMSEuMTYasSzhHKC3HFmUbRCHiUmHpe0ByO1
	8WoprhpNZklloHzewNEoBbdfPCIdkKRDkvZ/i9mAoCSk0PyKTy/Lvi4mh3fXepfdDfdmvrhO
	FetWO9Z0NlzZ0X94zwaXV0wxVH5bG+HQTznT1Bm826QL5GvyxtoNBfrC1O3BmzfmRkw02qeW
	hqxsnr7/if1iZPty8zjnlljfyaFHGQFLR9VP2rM7LGSr5eWGcHqW71lb+YzlU7XqxzuZ9Zov
	SjIuRgybSWjjxL+bzZlHRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/x47jt9PmNy3sLCyrGPGhhs3wlSmPs9lMN/3S0QN3lbLZ
	4iqKo1ilB7lip9Uhd2ZIudU6nYeUWiU9uSHHqUnXpIbK/PPea+/39vrrzVOKXGYur46NlzSx
	qmglK6NloUE6v7UhQZHLvo8oIfvCMnAPn6Oh6K6JhaY7FQhM909jcNZvgfYRF4KxV68pyMtp
	QlDyvpuC+7YeBNVlZ1ho+TATWt2DLNhzzrOgu3GXheav4xi6ci9jqDBvhxdZpRiso/005DlZ
	KMzT4Yn4jGHUWM6BMcUHHGUFHIy/Xw72njYG6q7ZGajuXAr5xV0sPKm202B76MDQ8riIhR7T
	HwZe2BpoaMrWM3B7oJSFryNGCozuQQ7eWA0YKlMnbOk/fjPwTG/FkH7zHobWt1UIas71YTCb
	2lioc7swWMw5FPy6VY/AcfEbB2kXRjkoPH0Rwfm0XBpSuwJh7GcRu2EtqXMNUiTVcoJUjxho
	8rxUJI8KujmSWtPJEYM5gVjKfMmNJ05MSobcDDGXZ7DEPHSZI5nfWjEZaGzkSMPVMZp8aM3D
	O7z2y4IjpGh1oqQJWBcuizK9yeeOFcuSLBnNOAX18ZnIgxeFleJwbwOaZFZYLHZ0jFKT7Cks
	EC36T8wkU4JLJt5s3DzJs4Vw8dH3nKmeFnzEM/ZLOBPxvFxYJToeJP5TzhcrKq1TGo+J+m3/
	wJReIQSKVboCLgvJDGhaOfJUxybGqNTRgf7ao1HJseok/0NxMWY08RbjqfHsh2i4ZUstEnik
	nCFvYoMiFYwqUZscU4tEnlJ6yuvPro5UyCNUySclTdxBTUK0pK1FXjytnCMP2SeFK4TDqnjp
	qCQdkzT/V8x7zE1BaZ0/zbvyXz7esyTrRxGUWBm7fvfODNfHbUnvHFt9AhI2zrRp7+yU7T1y
	Pb6U7AgTnVWG8DW6AI8I58JF3jXTOv0zpvuejXkaur99aN6wV8Lek1dOBW+bo++7vt62aeUu
	vy/Eftwz3Y/zTreFiAfiZ62Y79PvrHTMDqtrDi7sDVzlraS1UarlvpRGq/oLHG6EWikDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 4 ++--
 kernel/sched/completion.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bd2c207481d6..3200b741de28 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -41,9 +41,9 @@ do {							\
  */
 #define init_completion_map(x, m) init_completion(x)
 
-static inline void complete_acquire(struct completion *x)
+static inline void complete_acquire(struct completion *x, long timeout)
 {
-	sdt_might_sleep_start(&x->dmap);
+	sdt_might_sleep_start_timeout(&x->dmap, timeout);
 }
 
 static inline void complete_release(struct completion *x)
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 3561ab533dd4..499b1fee9dc1 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -110,7 +110,7 @@ __wait_for_common(struct completion *x,
 {
 	might_sleep();
 
-	complete_acquire(x);
+	complete_acquire(x, timeout);
 
 	raw_spin_lock_irq(&x->wait.lock);
 	timeout = do_wait_for_common(x, action, timeout, state);
-- 
2.17.1


