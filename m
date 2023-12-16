Return-Path: <linux-fsdevel+bounces-6293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1581570E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F6B281B6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195C215E94;
	Sat, 16 Dec 2023 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qxY+wHmx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A2134D9
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=850nIVdU/aZ+9UNxKyDC6+ms+COezKJHu/54VC5PeQc=;
	b=qxY+wHmxOFVeWSzvjapHXJMiZ8z/5+3XLBv4Zxe1O9zHPBcEu05pL0085Fb2ALCvaqgp1l
	EKpcrQg3yY+jiz+KJ1Ga3SmSAnVvGIW0PBDkb8U44EX1PMESjWCmHLFF7SRzsIs8cfDX0A
	LQBD1olLoqijXr/khW6yfgWu1gjdHv4=
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
Subject: [PATCH 49/50] kill unnecessary thread_info.h include
Date: Fri, 15 Dec 2023 22:35:50 -0500
Message-ID: <20231216033552.3553579-6-kent.overstreet@linux.dev>
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

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 arch/x86/include/asm/fpu/types.h | 2 ++
 arch/x86/include/asm/preempt.h   | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index eb810074f1e7..3dad7cf25505 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -5,6 +5,8 @@
 #ifndef _ASM_X86_FPU_H
 #define _ASM_X86_FPU_H
 
+#include <asm/page_types.h>
+
 /*
  * The legacy x87 FPU state format, as saved by FSAVE and
  * restored by the FRSTOR instructions:
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 4527e1430c6d..af77235fded6 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -6,7 +6,6 @@
 #include <asm/percpu.h>
 #include <asm/current.h>
 
-#include <linux/thread_info.h>
 #include <linux/static_call_types.h>
 
 /* We use the MSB mostly because its available */
-- 
2.43.0


