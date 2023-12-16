Return-Path: <linux-fsdevel+bounces-6261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 485B38156C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8A71C24888
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C939F18EB6;
	Sat, 16 Dec 2023 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j6ZPXCGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2115EA6
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVQvq92zNWowFmQB2GI0mP9AbBZYVi5uCFShyHJBgic=;
	b=j6ZPXCGPupzUUJnhIsAwv8oHEvVc0w9O/utpKK+o4imk+jWaN9F7GYOuw7A+c6hdx8YpfO
	ybPZO30FOXihZJAgJBazpezKLNlpNFEY/AQPKJoKuAZQqhJlLB5adz6B/XlpDGSd/OBPOF
	bxtKvHGv6L54wlPtCN/TCdYe9/ZAJNE=
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
Subject: [PATCH 17/50] ktime.h: move ktime_t to types.h
Date: Fri, 15 Dec 2023 22:26:16 -0500
Message-ID: <20231216032651.3553101-7-kent.overstreet@linux.dev>
In-Reply-To: <20231216032651.3553101-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

ktime.h pulls in quite a few headers recursively (including printk.h) -
this is going to help with trimming sched.h dependencies.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/ktime.h | 8 +++-----
 include/linux/types.h | 3 +++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 73f20deb497d..3a4e723eae0f 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -21,12 +21,10 @@
 #ifndef _LINUX_KTIME_H
 #define _LINUX_KTIME_H
 
-#include <linux/time.h>
-#include <linux/jiffies.h>
 #include <asm/bug.h>
-
-/* Nanosecond scalar representation for kernel time values */
-typedef s64	ktime_t;
+#include <linux/jiffies.h>
+#include <linux/time.h>
+#include <linux/types.h>
 
 /**
  * ktime_set - Set a ktime_t variable from a seconds/nanoseconds value
diff --git a/include/linux/types.h b/include/linux/types.h
index 253168bb3fe1..2bc8766ba20c 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -120,6 +120,9 @@ typedef s64			int64_t;
 #define aligned_be64		__aligned_be64
 #define aligned_le64		__aligned_le64
 
+/* Nanosecond scalar representation for kernel time values */
+typedef s64	ktime_t;
+
 /**
  * The type used for indexing onto a disc or disc partition.
  *
-- 
2.43.0


