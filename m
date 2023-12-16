Return-Path: <linux-fsdevel+bounces-6255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B042F8156BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFAE2864F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57BE748B;
	Sat, 16 Dec 2023 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ovqC1DSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC676D22
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMwo6myaXRyuD1n4NvzHCIXzldbeB8yBA+xdZ14Nwyc=;
	b=ovqC1DSvbgM/1s5GkmtuCtJNGdL8TPYFUK5YmVn4jRfFeWqCuJL5Acyws9kIwpkxNgCn+d
	x+Mdp8cvc+d+WyofC+s1CNtzGDpTiDqHaHce17A9JvvP+9kisqtULP5xGiHpVGFEbCCxDX
	PLjzDLBu7InjnmFzG5vMi+jv2WO3KEo=
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
	brauner@kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 11/50] nodemask: Split out include/linux/nodemask_types.h
Date: Fri, 15 Dec 2023 22:26:10 -0500
Message-ID: <20231216032651.3553101-1-kent.overstreet@linux.dev>
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

sched.h, which defines task_struct, needs nodemask_t - but sched.h is a
frequently used header and ideally shouldn't be pulling in any more code
that it needs to.

This splits out nodemask_types.h which has the definition sched.h needs,
which will avoid a circular header dependency in the alloc tagging patch
series, and as a bonus should speed up kernel build times.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/nodemask.h       |  2 +-
 include/linux/nodemask_types.h | 10 ++++++++++
 include/linux/sched.h          |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/nodemask_types.h

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 8d07116caaf1..b61438313a73 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -93,10 +93,10 @@
 #include <linux/threads.h>
 #include <linux/bitmap.h>
 #include <linux/minmax.h>
+#include <linux/nodemask_types.h>
 #include <linux/numa.h>
 #include <linux/random.h>
 
-typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
 extern nodemask_t _unused_nodemask_arg_;
 
 /**
diff --git a/include/linux/nodemask_types.h b/include/linux/nodemask_types.h
new file mode 100644
index 000000000000..6b28d97ea6ed
--- /dev/null
+++ b/include/linux/nodemask_types.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_NODEMASK_TYPES_H
+#define __LINUX_NODEMASK_TYPES_H
+
+#include <linux/bitops.h>
+#include <linux/numa.h>
+
+typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
+
+#endif /* __LINUX_NODEMASK_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..5a5b7b122682 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -20,7 +20,7 @@
 #include <linux/hrtimer.h>
 #include <linux/irqflags.h>
 #include <linux/seccomp.h>
-#include <linux/nodemask.h>
+#include <linux/nodemask_types.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/resource.h>
-- 
2.43.0


