Return-Path: <linux-fsdevel+bounces-27052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B005E95DFBD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 21:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF921C20CF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 19:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E459313D530;
	Sat, 24 Aug 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="il4cNM1/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D6770F3
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724526638; cv=none; b=eNHJk5N4tYC4eXHsr5YkB6IazwOC4RYbtdD0WPMBMtFSjx0EzImi5ww+X0j26P8wgdUNsceuPU9niGzkw60z6zTrQvyhXanmOSU1TATzNbgGFEVw64LAVTa/31Diz+BzFYXxLNqhV4gIz8F75yH0C2MfcUqXi6z3347UBhC87Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724526638; c=relaxed/simple;
	bh=Ouoh5lcfvXcRz9Q+Kr1XBHZYw36GPQXPd+4KUL7NuGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odmYJ8uQCRPozGKIhHinGj5oUCcAMx7mDF8xVesR1710qPuAAuK2PIG0J7qc21FSsiliS6M1BgZCywvQNN3ucm6YZ/jr1R99/Xk5R38/XjaIjywWtBZv+2ig6xhka1MPjt4VYzA5PhDfzMV+5Ykcjgy1AsMBC6cTOnFhq0r/KGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=il4cNM1/; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724526634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHJr4su3KzsflXo6gchJ2B6JfeJstKzSoEoijiSdexY=;
	b=il4cNM1/7oj7XYsuHh1W1JNzs4Oq8+fDTy6JvD4Z511p+2xPkkP9wOvvzwe4YnQoziTFYw
	r0FkAsv8qjNLoGwPvEttI9Y6Q+RRSVD1WBAfURE9dCu6369wU2dC//Sp+tP23BA3CWrQfj
	Uxn9vImAHZ/0ZmIV1TedThnII+RIVw8=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.krenel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/10] percpu: per_cpu_sum()
Date: Sat, 24 Aug 2024 15:10:14 -0400
Message-ID: <20240824191020.3170516-8-kent.overstreet@linux.dev>
In-Reply-To: <20240824191020.3170516-1-kent.overstreet@linux.dev>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
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


