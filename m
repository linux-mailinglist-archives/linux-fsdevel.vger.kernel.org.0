Return-Path: <linux-fsdevel+bounces-12238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D970A85D49E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3F31F22129
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1184D58A;
	Wed, 21 Feb 2024 09:50:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3524596F;
	Wed, 21 Feb 2024 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509003; cv=none; b=fNStzsc41HSP6RWnq5Cb3PTFJkF1RR6yA+S3bYh5cxYV711f6XTRZHeh9Qjy5j4Veqpauj3pms8UK+jMKicD0372ktxkIkebXLdEaYlthF3Zzo+3Bv1ZtBnG4KEvSLcOkQHaIsXbS5YG4bHW/Qpg1KBbvSMkla5MxM33GoOkmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509003; c=relaxed/simple;
	bh=t4Qh0s/9NGiebNos8RWbTI6PuT087Z/eTqnpXervcDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=how7qUS24LbkjNtNTPy3YTDtVTuXnXLuwC4QeWPFk4X/X1C58ZBKOjWab0eKmYe2mFyfWL2HjvJIpWyQTQe55sLPlZXMhfXj24AiyiTjtaFAtW7sKTpfv+UhhnlTFYScVPAwjpF96xIsgNGivA8iK1C0VnoMQjsmIJxLJpMvjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-78-65d5c73a3e19
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
Subject: [PATCH v12 15/27] dept: Apply sdt_might_sleep_{start,end}() to dma fence wait
Date: Wed, 21 Feb 2024 18:49:21 +0900
Message-Id: <20240221094933.36348-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0zMcRzHfX//O85+uzI/ekA3jbFSUftoGPPA74k/Y5nxgFM/7ri77Krr
	j7V15G9/RluFQnVcp6K6EuEsnUoopStJmg4l3ZXF3TpF7jRPPnvv/X5/Xp8nHwaX1JOLGYU6
	XtCoZUopJSJEjnnFQZEt3UJI731/uJQZAs6f5wgorKygoONuOYKKWh0GI01b4a3LjmCq7TUO
	+bkdCIoHP+BQ2zyAwGw8SUHX5/lgdY5T0JqbQcEpfSUFnaPTGPTn5WBQbtoGLy+WYNDgHiYg
	f4SCgvxTmGd8xcBtKKPBkBYINuNVGqYHQ6F1oIcEc98quHK9n4LH5lYCmh/YMOh6WEjBQMUM
	CS+bnxPQcSmLhDtjJRSMugw4GJzjNLxpKMKgKt0DOvPjDwktWQ0YnLlZjYH13SMET859xMBU
	0UOBxWnHoMaUi8Ov0iYEtmwHDacz3TQU6LIRZJzOI+D17xYS0vvDYWqykNoUyVvs4zifXpPI
	m11FBP+ihOPrr36g+fQnfTRfZErga4wref3jEYwvnnCSvKnsPMWbJnJo/oLDivFj7e00//zy
	FMF/tuZjO/33idbHCEqFVtCs3nhQJM9+346O68RJpht0GvoiuoB8GI5dy01+Gyb/6/fTv2iv
	ptjlXG+vG/dqP3YpV5M15OmIGJw9O5czfm+jvIEvu4f7VHfbU2IYgg3kbrVpvbaYjeDyJoeo
	WeYSrryq4R/Hx+PfLrD/uyVhw7nuznu4l8mxMwzXaamiZxcWcU+NvcRFJC5Cc8qQRKHWqmQK
	5dpgebJakRQcHasyIc9DGVKn9z9AEx27GxHLIOk8sfy+VZCQMm1csqoRcQwu9RMTiR5LHCNL
	ThE0sQc0CUohrhH5M4R0oTjMlRgjYY/I4oVjgnBc0PxPMcZncRry2dGqjXY7YuWbizUK46t1
	kkhze21beGqPjSgtKHRofv+4EbCkWRW8d9fqspwNvgFJ17hRvbluxnBApVtmEavHFl77GR1o
	jJrbVL1ie3yGUpqiz6g+FLVM98y46+EJuz42M2hLxN2wo/VRvpui1/iF2SpdWZfZJEvKAvn5
	w+FduVIiTi4LXYlr4mR/ASk1HedMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSeUiTcRjH+723q8XbknozKVmFZGgWGQ8ZURT00oVBGUmQo95y6Ky2tIwC
	l1q2qangkUd5tTzWNe2wnIrmVWias9Mkl0fiPDAnTle2Ff3z8OH7/fL562FwSTbpxsjDzwvK
	cFmYlBIRogP+Md5bmroEX7ONgJQEX7BOxhOQ81BPQfuDMgT6CjUGQw274cOUBcFs61scMtLa
	EeT3fsWhorEHgbH4KgWdfQvBZB2joCVNS0FM4UMKOobtGHSnp2JQZtgPb5ILMKi1DRKQMURB
	dkYM5jg/MLDpSmnQRa8Bc3EWDfbeDdDS856E+twWEoyf18Gt290UVBlbCGh8bsag80UOBT36
	ORLeNDYT0J6SSML90QIKhqd0OOisYzS8q83D4FGsw3bt528SmhJrMbhW9BgD06eXCKrjv2Fg
	0L+noN5qwaDckIbDzL0GBOakERriEmw0ZKuTEGjj0gl4+6uJhNhuP5idzqG2+/P1ljGcjy2/
	wBun8gj+dQHHV2Z9pfnY6s80n2eI4MuLvfjCqiGMz5+wkryh9AbFGyZSaV4zYsL40bY2mm/O
	nCX4PlMGFuAeJNp6UgiTRwrK9duCRSFJX9rQWbX4ouEOHY36RRrkwnDsJu6LfYZ2MsV6ch8/
	2nAnu7IeXHniAKlBIgZnr8/nisdbKWexmA3kvj8tcYwYhmDXcHdbI52xmN3MpU8PUP+cK7my
	R7V/PS6OvCTbQjpZwvpxXR1P8GQkykPzSpGrPDxSIZOH+fmoQkOiwuUXfU6cURiQ42V0V+wp
	z9Fk5+46xDJIukAc8swkSEhZpCpKUYc4Bpe6iokLjkh8UhZ1SVCeOa6MCBNUdWg5Q0iXivcc
	EYIl7GnZeSFUEM4Kyv8txri4RSNv4pBR0HQUzezdqJ/epdDaIRg0lZsI26qcVwqFj7qsgAhc
	ttbd/KuofXXJIqOHIqhSEtFwMGVxaWC/C+3VtUIa0Csa1F4KrqnsTvO0bNx/eV/FimNZubTc
	NryEXXj8nDqh8PDRmy9X7xTXVGkb5nrYcWGHpr95LrNa/tR6SiolVCGyDV64UiX7A1jZPJ4u
	AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes Dept able to track dma fence waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 8aa8f8cb7071..76dba11f0dab 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -16,6 +16,7 @@
 #include <linux/dma-fence.h>
 #include <linux/sched/signal.h>
 #include <linux/seq_file.h>
+#include <linux/dept_sdt.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dma_fence.h>
@@ -783,6 +784,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
+	sdt_might_sleep_start(NULL);
 	while (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -796,6 +798,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	if (!list_empty(&cb.base.node))
 		list_del(&cb.base.node);
@@ -885,6 +888,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
+	sdt_might_sleep_start(NULL);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -899,6 +903,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	__set_current_state(TASK_RUNNING);
 
-- 
2.17.1


