Return-Path: <linux-fsdevel+bounces-6276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B94238156EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA21F25943
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8D73419A;
	Sat, 16 Dec 2023 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jkrCZyYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E31A30320
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjGjj9NDld3cpQFTknyiaa4K8L6pikm/7YzJQsi2quo=;
	b=jkrCZyYYqYX0PWqqeqIWBMaHBBPf0yFDGel5bxrrPs4u3HAXTF4hjPGU92N7SowauokwnZ
	JmdYlpe03/qOnMPAlJygeHEmX4G9QfKGkHMHWdQ2nSe7oyrBgmquqotmfQQ8BxXiNGVzCZ
	l9I0Gv1UNMUiTCJ/TwPpBBHBRTK2xZA=
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
Subject: [PATCH 32/50] ipc: Kill bogus dependency on spinlock.h
Date: Fri, 15 Dec 2023 22:29:38 -0500
Message-ID: <20231216032957.3553313-11-kent.overstreet@linux.dev>
In-Reply-To: <20231216032957.3553313-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032957.3553313-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

pruning sched.h dependencies, headers shouldn't pull in more than they
need.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/ipc.h   | 2 +-
 include/linux/sched.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/ipc.h b/include/linux/ipc.h
index e1c9eea6015b..9b1434247aab 100644
--- a/include/linux/ipc.h
+++ b/include/linux/ipc.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_IPC_H
 #define _LINUX_IPC_H
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/uidgid.h>
 #include <linux/rhashtable-types.h>
 #include <uapi/linux/ipc.h>
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8c230f24688b..3a58d3d7d264 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2139,6 +2139,8 @@ extern bool sched_task_on_rq(struct task_struct *p);
 extern unsigned long get_wchan(struct task_struct *p);
 extern struct task_struct *cpu_curr_snapshot(int cpu);
 
+#include <asm/spinlock.h>
+
 /*
  * In order to reduce various lock holder preemption latencies provide an
  * interface to see if a vCPU is currently running or not.
-- 
2.43.0


