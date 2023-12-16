Return-Path: <linux-fsdevel+bounces-6279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE48F8156F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A0D288105
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944A637D09;
	Sat, 16 Dec 2023 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qP6dWkWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17135294
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwnREAuVN4OPHPun4TeRCrssO9sPJ33n6iud3s07kG4=;
	b=qP6dWkWYpw7oW2OJmZ+1xot5mAafow0AqE9tcjCelsxfjfPXBgKDnkp/JYEN5EbZb2GAtV
	Kcpk7JrNDkh1PfABeJwPOiozUfq/6/m0SK0oUW1sDCc4y14WJzUAiBYOeUk5t79yNntRcA
	ZbnHN+qPYOKqOHfVxGm4Kif1uB7/D2I=
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
Subject: [PATCH 35/50] cpumask: Split out cpumask_types.h
Date: Fri, 15 Dec 2023 22:32:41 -0500
Message-ID: <20231216033300.3553457-3-kent.overstreet@linux.dev>
In-Reply-To: <20231216033300.3553457-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

More sched.h dependency trimming: this will help to kill the printk.h
dependency.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 arch/x86/include/asm/tlbbatch.h |  2 +-
 include/linux/cpumask.h         |  4 +---
 include/linux/cpumask_types.h   | 12 ++++++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/cpumask_types.h

diff --git a/arch/x86/include/asm/tlbbatch.h b/arch/x86/include/asm/tlbbatch.h
index 1ad56eb3e8a8..0550dea70c0f 100644
--- a/arch/x86/include/asm/tlbbatch.h
+++ b/arch/x86/include/asm/tlbbatch.h
@@ -2,7 +2,7 @@
 #ifndef _ARCH_X86_TLBBATCH_H
 #define _ARCH_X86_TLBBATCH_H
 
-#include <linux/cpumask.h>
+#include <linux/cpumask_types.h>
 
 struct arch_tlbflush_unmap_batch {
 	/*
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..b710dc4cd858 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -14,9 +14,7 @@
 #include <linux/bug.h>
 #include <linux/gfp_types.h>
 #include <linux/numa.h>
-
-/* Don't assign or return these: may not be this big! */
-typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
+#include <linux/cpumask_types.h>
 
 /**
  * cpumask_bits - get the bits in a cpumask
diff --git a/include/linux/cpumask_types.h b/include/linux/cpumask_types.h
new file mode 100644
index 000000000000..f4c032c9a81a
--- /dev/null
+++ b/include/linux/cpumask_types.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_CPUMASK_TYPES_H
+#define __LINUX_CPUMASK_TYPES_H
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/threads.h>
+
+/* Don't assign or return these: may not be this big! */
+typedef struct cpumask { DECLARE_BITMAP(bits, NR_CPUS); } cpumask_t;
+
+#endif /* __LINUX_CPUMASK_TYPES_H */
-- 
2.43.0


