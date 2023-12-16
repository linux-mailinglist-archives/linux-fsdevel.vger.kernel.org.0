Return-Path: <linux-fsdevel+bounces-6292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D99081570C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAA3283A50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF113FEA;
	Sat, 16 Dec 2023 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eq5ynikG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D541118B
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxvqaxrdjqIZpV18yuEOiGDA6WPBowU+ZtiCF/cYqpM=;
	b=eq5ynikG7aXEh6Wl2qNFNspAUNLPUKuuSZkYAM8mRcc9I/D6+KXkpqCFFkaUh5XcyNu/wI
	0jDvO1DVSEpdKkrdnhXCQ7HWBiE/jFlguUb9/g3KueG54u3XtLojaST1LNOYUbnJAtKg18
	R/xt9RtELiUb0ZrPxw3JBXxl7/TUMKk=
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
Subject: [PATCH 48/50] Kill unnecessary kernel.h include
Date: Fri, 15 Dec 2023 22:35:49 -0500
Message-ID: <20231216033552.3553579-5-kent.overstreet@linux.dev>
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

More trimming down unnecessary includes.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 arch/x86/include/asm/current.h | 1 +
 arch/x86/include/asm/percpu.h  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index a1168e7b69e5..dd4b67101bb7 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_CURRENT_H
 #define _ASM_X86_CURRENT_H
 
+#include <linux/build_bug.h>
 #include <linux/compiler.h>
 
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 20624b80f890..5e01883eb51e 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -24,8 +24,8 @@
 
 #else /* ...!ASSEMBLY */
 
-#include <linux/kernel.h>
 #include <linux/stringify.h>
+#include <asm/asm.h>
 
 #ifdef CONFIG_SMP
 #define __percpu_prefix		"%%"__stringify(__percpu_seg)":"
-- 
2.43.0


