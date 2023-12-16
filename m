Return-Path: <linux-fsdevel+bounces-6288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 347DC815704
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86501F20C3D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC40539E;
	Sat, 16 Dec 2023 03:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o5z+wqYo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0146B9
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lx23CvYqmL3FO1BOdwPl48m+Gd9mJQDDIFCAY3/8fI0=;
	b=o5z+wqYoQdVXnS6r4OdqyH4lRXwr0g2HIUjv8a7lcCqCHk8hjzGHrHivbx+/4XXYNf+9iX
	jsKIbs3P6Pz4RkTLhnbgRjwjpqqommU0D4BNVnMaAIh4umFxfUm48xktMPocCRXv+mkS6J
	CEJBFfkTi5mQDSL7GRewP4jN4NPtyhI=
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
Subject: [PATCH 44/50] restart_block: Trim includes
Date: Fri, 15 Dec 2023 22:35:45 -0500
Message-ID: <20231216033552.3553579-1-kent.overstreet@linux.dev>
In-Reply-To: <20231216024834.3510073-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We don't actually use any timekeeping types, no need to pull in
time64.h.

Also, sched.h uses restart_block; add it as a direct dependency.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/restart_block.h | 2 +-
 include/linux/sched.h         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index 980a65594412..13f17676c5f4 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -7,8 +7,8 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <linux/time64.h>
 
+struct __kernel_timespec;
 struct timespec;
 struct old_timespec32;
 struct pollfd;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 98885e3a81e8..ec739277c39b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -33,6 +33,7 @@
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers_types.h>
+#include <linux/restart_block.h>
 #include <linux/rseq.h>
 #include <linux/seqlock_types.h>
 #include <linux/kcsan.h>
-- 
2.43.0


