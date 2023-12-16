Return-Path: <linux-fsdevel+bounces-6278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ECE8156F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA29287CA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C9635293;
	Sat, 16 Dec 2023 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P/vP7wM2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187035261
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yds9msKPQXrNBgqP1A765/hKAJrn8l4pd6dR6qihsk=;
	b=P/vP7wM2eOOWDjmrKsXkcidp9QYAwSxsqE8ajgD7Xmirwv0NikZzDG8hCpt/RpRx/Eau+Q
	iOPOyIgcAgWX9iAES67hwP3BH3WPrS6Zyzp0hSd4xGFrXDjwvo7oFv37d/ddblhdtdStlt
	aoL2AQ0g0RXBvj+ySnyxQigup18B6FI=
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
Subject: [PATCH 34/50] mm_types_task.h: Trim dependencies
Date: Fri, 15 Dec 2023 22:32:40 -0500
Message-ID: <20231216033300.3553457-2-kent.overstreet@linux.dev>
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

more sched.h header dependency trimming

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/mm_types_task.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index aa44fff8bb9d..724a731d5c2b 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -9,11 +9,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/threads.h>
-#include <linux/atomic.h>
-#include <linux/cpumask.h>
-
-#include <asm/page.h>
 
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 #include <asm/tlbbatch.h>
@@ -36,6 +31,8 @@ enum {
 	NR_MM_COUNTERS
 };
 
+struct page;
+
 struct page_frag {
 	struct page *page;
 #if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
-- 
2.43.0


