Return-Path: <linux-fsdevel+bounces-6290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE849815708
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268561C24A26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDD7101E0;
	Sat, 16 Dec 2023 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RK/hF5+q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31272538F
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUqwYAx0DDPud63nNEdLEk98WtGqrjOdsdwrtUhwy7M=;
	b=RK/hF5+qNAuTN//SAOHI3R7Lu9Lf4KKbYrkcT/9G7ZF0d+mCv64pZGUkMRZpfq0PJil7/G
	9K/J6HudIs1uYCuuQDHxAZkUyBklxOtXfa5qhuihA7RRVwaGkztuPBEywhIYYfGrmFaPOT
	3b5Jx+8IMm2SxDqdLfIJPieW5co+7gU=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: [PATCH 46/50] preempt.h: Kill dependency on list.h
Date: Fri, 15 Dec 2023 22:35:47 -0500
Message-ID: <20231216033552.3553579-3-kent.overstreet@linux.dev>
In-Reply-To: <20231216033552.3553579-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We really only need types.h, list.h is big.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/preempt.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 9aa6358a1a16..7233e9cf1bab 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -9,7 +9,7 @@
 
 #include <linux/linkage.h>
 #include <linux/cleanup.h>
-#include <linux/list.h>
+#include <linux/types.h>
 
 /*
  * We put the hardirq and softirq counter into the preemption
@@ -360,7 +360,9 @@ void preempt_notifier_unregister(struct preempt_notifier *notifier);
 static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 				     struct preempt_ops *ops)
 {
-	INIT_HLIST_NODE(&notifier->link);
+	/* INIT_HLIST_NODE() open coded, to avoid dependency on list.h */
+	notifier->link.next = NULL;
+	notifier->link.pprev = NULL;
 	notifier->ops = ops;
 }
 
-- 
2.43.0


