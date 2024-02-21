Return-Path: <linux-fsdevel+bounces-12332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BBE85E803
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9511F250CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B5114C5AB;
	Wed, 21 Feb 2024 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdCkcLjx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287F14A087
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544501; cv=none; b=vFRNWZBcp9aOxaA2XytoduVpScsmiQRuTL5le5m/nWuukkAIVFhsHa0IQkZ4x9WDjdzLxetFUAa4Mp/I2OvzOCtYYwFJBY0xXPps+p1xTL0irmjppIccYm8R/UupGMCUIKsykr6Ryz4039OcywPH54rvY4wk8+lc/IU2TiPlTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544501; c=relaxed/simple;
	bh=vicr63sJKc1o/siGbzRTyI8A3E1968FkjrlbTO/oYk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kAb69hT3g2wlA2PYf/D1gZYpsndGHhvszZEs4UgZOU5zcMSWV/190A1ioeX5gaunv9+E4KWzhnvLEnKUpjd7wADdtjhCrOd2M2weuepbmc+WMvJO2mnV4IVEG9Tt4mLdRzl9FHLgG5jh7HyQpzDnrTjbaQ4ouD5ZRkk80eypklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HdCkcLjx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so2066394276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544498; x=1709149298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hWNqJFIgMmzuIRMCt7lzLBdngxXaEaZ9g59MUlptRo=;
        b=HdCkcLjxJ4Wizup2+9U7O6tdGXX0GcXUUQR8MMyrWK+3lb0LUb9CPJgk96yNeW7jZf
         cv9mPFE/FImSsOSpnLgOoaqxCaNuCMq4699Vfj5OI4/tx19iWipTRrytKstxOMcrXc3Y
         FkevKNDf6LVq/Jq4lZ4+14FMmXq2+DZYQxuKSH1I3Rbk2udt/zJuqs6eLAXlJ2l+V6GU
         fbI2UGRKa3lp80Te2z7/cZMY5hpMHg8q5QBiTGOABMDhTegPN5Mr5kDJvyjzEvnI5eQK
         NivwmS/wrDr9eCdx0MXJ7PZ1XCOcx072pXbq5VEOpo0yxFDbOqNXHJ+GPV6qaCx5cdqw
         vMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544498; x=1709149298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hWNqJFIgMmzuIRMCt7lzLBdngxXaEaZ9g59MUlptRo=;
        b=VFuGW7xeC8q8bYm5G/X9JosGveJFlUVNJQAt89NrvvPE/sAWUD6oWALqjBZp/PVkWH
         drlaz4U1EcrictqupkUY5CsVjssheTnlCipElSBQJ5D8OqQYQOA4IXQOPTHHfLv9tx4O
         Y+fkIrDMwrCqrjarvpJJYBF2WVH6nuadpcHjjQDNt0MAIYYS5oo07jtrYHjYCL2k2hLz
         xr4l/Q75so0R15ifsP020+5Dr49vjNytqTCV0SFMSRwDBwr/SQW+arroTwP+8Rys8BKA
         hO3EH/9FlDAeDUzqr8d6b1U94zZUKT0HZ17B1UniWmcrXcvHVAcdIGZW9WjAWSqUTPff
         rQgA==
X-Forwarded-Encrypted: i=1; AJvYcCVS4j5PxB39RrK6RdtjftQjj1Y5HVihtYTFfMOwnJeKx5A3tafKns5qMtozRzU1l0X+S4UmBk1wXovZftnAGWBnW0gUj4EIm9lIBh9xIw==
X-Gm-Message-State: AOJu0Yw9UP9ezhg6CL2A5ILvCO9uXh6/4xcS7TTQ9+22Igoi8zzmtkjV
	U7xHRodZuUQtUA2+iKuAiYiGqz93HKgsiMKxLt8ktppXyn4RqWq8u0EAGdm2DWdszgEsPYP46+l
	HGQ==
X-Google-Smtp-Source: AGHT+IF+lk/FYOD/Yxg3sPkq6eArvA9PdzVkhKYXiOVnRPx3H40+bQfIfbP0HZr0UMzCJhoN0p6KojopSmw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a05:6902:18d6:b0:dc6:dfc6:4207 with SMTP id
 ck22-20020a05690218d600b00dc6dfc64207mr68537ybb.10.1708544498016; Wed, 21 Feb
 2024 11:41:38 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:32 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-20-surenb@google.com>
Subject: [PATCH v4 19/36] mm: create new codetag references during page splitting
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a high-order page is split into smaller ones, each newly split
page should get its codetag. The original codetag is reused for these
pages but it's recorded as 0-byte allocation because original codetag
already accounts for the original high-order allocated page.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/pgalloc_tag.h | 30 ++++++++++++++++++++++++++++++
 mm/huge_memory.c            |  2 ++
 mm/page_alloc.c             |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index b49ab955300f..9e6ad8e0e4aa 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -67,11 +67,41 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int order)
 	}
 }
 
+static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
+{
+	int i;
+	struct page_ext *page_ext;
+	union codetag_ref *ref;
+	struct alloc_tag *tag;
+
+	if (!mem_alloc_profiling_enabled())
+		return;
+
+	page_ext = page_ext_get(page);
+	if (unlikely(!page_ext))
+		return;
+
+	ref = codetag_ref_from_page_ext(page_ext);
+	if (!ref->ct)
+		goto out;
+
+	tag = ct_to_alloc_tag(ref->ct);
+	page_ext = page_ext_next(page_ext);
+	for (i = 1; i < nr; i++) {
+		/* Set new reference to point to the original tag */
+		alloc_tag_ref_set(codetag_ref_from_page_ext(page_ext), tag);
+		page_ext = page_ext_next(page_ext);
+	}
+out:
+	page_ext_put(page_ext);
+}
+
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int order) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
+static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94c958f7ebb5..86daae671319 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -38,6 +38,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/compat.h>
+#include <linux/pgalloc_tag.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -2899,6 +2900,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, nr);
+	pgalloc_tag_split(head, nr);
 
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 58c0e8b948a4..4bc5b4720fee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2621,6 +2621,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, 1 << order);
+	pgalloc_tag_split(page, 1 << order);
 	split_page_memcg(page, 1 << order);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -4806,6 +4807,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, 1 << order);
+		pgalloc_tag_split(page, 1 << order);
 		split_page_memcg(page, 1 << order);
 		while (page < --last)
 			set_page_refcounted(last);
-- 
2.44.0.rc0.258.g7320e95886-goog


