Return-Path: <linux-fsdevel+bounces-27040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904E495DF65
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 20:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 125BFB21A55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ED23D967;
	Sat, 24 Aug 2024 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k4o7We3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E95EE8D
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522714; cv=none; b=EIVz4vLkMnlk6bG3CeN+AnJO3fO1gTxD4EsHgJ92g3eu8dE5hxpJkCUTa8vpvYDqBCLjYXIY8z+wtm4wu0gHSS4tBWQwTNcNITEdg2j+WpFYJNCY2MQL215Dg55IFUdRxhDUmBk6KncESEQ3vJji2XAYBrO9NDP/ATeHi/qzSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522714; c=relaxed/simple;
	bh=Ouoh5lcfvXcRz9Q+Kr1XBHZYw36GPQXPd+4KUL7NuGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3NNzUE8R+dG3vKlKJalAvB7QBks4ToUulqrMKA4zpxqbw2s9JKHEGq7+AGq+LQ22bo/RwNGJNon9d1Qbtbi8wKsL2LoiTVtBEF/JqIxu3zbrI+H50fAAZXNMZFnO22TMebgRne/dPfC9vLRDBwsBc4Y5FlaWWLfaDAqNt8waYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k4o7We3s; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724522710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHJr4su3KzsflXo6gchJ2B6JfeJstKzSoEoijiSdexY=;
	b=k4o7We3sKOesfMR+pEKMn8mVzaablL1CH7+YQJD9RSiEC3Ri5oZRbNrOJquWBAq2tamp5h
	2UT0wOzU/j+aUAv4UgK0S8mAoqvLgMZGL7ViRLfmOHOKn6/s8YhWX1Qp4H5u/FekuwbZ7j
	ozVhfBGAAfHvNvhHwJflbHV/NCDdxwM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.krenel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/10] percpu: per_cpu_sum()
Date: Sat, 24 Aug 2024 14:04:49 -0400
Message-ID: <20240824180454.3160385-8-kent.overstreet@linux.dev>
In-Reply-To: <20240824180454.3160385-1-kent.overstreet@linux.dev>
References: <20240824180454.3160385-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a little helper to replace open coded versions.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.krenel.org
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/util.h     | 10 ----------
 fs/dcache.c            | 16 +++-------------
 include/linux/percpu.h | 10 ++++++++++
 3 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index fb02c1c36004..e90c2f546007 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -584,16 +584,6 @@ do {									\
 	}								\
 } while (0)
 
-#define per_cpu_sum(_p)							\
-({									\
-	typeof(*_p) _ret = 0;						\
-									\
-	int cpu;							\
-	for_each_possible_cpu(cpu)					\
-		_ret += *per_cpu_ptr(_p, cpu);				\
-	_ret;								\
-})
-
 static inline u64 percpu_u64_get(u64 __percpu *src)
 {
 	return per_cpu_sum(src);
diff --git a/fs/dcache.c b/fs/dcache.c
index 3d8daaecb6d1..64108cbd52f6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -151,29 +151,19 @@ static struct dentry_stat_t dentry_stat = {
  */
 static long get_nr_dentry(void)
 {
-	int i;
-	long sum = 0;
-	for_each_possible_cpu(i)
-		sum += per_cpu(nr_dentry, i);
+	long sum = per_cpu_sum(&nr_dentry);
 	return sum < 0 ? 0 : sum;
 }
 
 static long get_nr_dentry_unused(void)
 {
-	int i;
-	long sum = 0;
-	for_each_possible_cpu(i)
-		sum += per_cpu(nr_dentry_unused, i);
+	long sum = per_cpu_sum(&nr_dentry_unused);
 	return sum < 0 ? 0 : sum;
 }
 
 static long get_nr_dentry_negative(void)
 {
-	int i;
-	long sum = 0;
-
-	for_each_possible_cpu(i)
-		sum += per_cpu(nr_dentry_negative, i);
+	long sum = per_cpu_sum(&nr_dentry_negative);
 	return sum < 0 ? 0 : sum;
 }
 
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 4b2047b78b67..0df28ff54f66 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -162,4 +162,14 @@ extern phys_addr_t per_cpu_ptr_to_phys(void *addr);
 
 extern unsigned long pcpu_nr_pages(void);
 
+#define per_cpu_sum(_p)							\
+({									\
+	typeof(*(_p)) sum = 0;						\
+	int cpu;							\
+									\
+	for_each_possible_cpu(cpu)					\
+		sum += *per_cpu_ptr(_p, cpu);				\
+	sum;								\
+})
+
 #endif /* __LINUX_PERCPU_H */
-- 
2.45.2


