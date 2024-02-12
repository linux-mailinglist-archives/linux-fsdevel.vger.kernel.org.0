Return-Path: <linux-fsdevel+bounces-11209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D326F852053
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D001C22CF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF95645E;
	Mon, 12 Feb 2024 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMMRIghA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE0A55E55
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774015; cv=none; b=ij3O1Wv9tDsvcf53dhwf1Z6DwWa+a1+Fcg91KCdelqsybfehYX73dwkqN1JC3O0yClP1Trf0h0yNu9puqS8OJV3jBrSXCHptmajIyjck/n7+xheGoEn4H0eKf2NpzBvab9CWXJpzqZNB/lBTfPAYCGwznRTIVhV4uU7V3C+Tcc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774015; c=relaxed/simple;
	bh=4k57aS8GXMk2iiyKPx5CmNXvPcq94eqkm08DeOX77O0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fV9H7bCSfS+R73WcCE0SatrFMmtkd1dsdThGL/UJp6TSAfzD+N70/olgAZnsSr4KkCAXUcGzHVkHp6v53ItghcluK0EH2J9rMVEVk0Q1P++294CDhsjzlDVY+LK1vVpV2EJDuA7HQxL9mlp5swj55pGLWV7i7SC0yBGTESL1Czg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMMRIghA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso6231710276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774012; x=1708378812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrBz9DyywfwO606ZQMwpTbc2aylPEGoXqCQTswmuPUY=;
        b=OMMRIghA3WxmjiTZ3CP9/pkJhKKeCdPMwJR2nWzu8M7EcfU5lL2pejbzPFJTTdubAa
         wVLjkMLvmxqdGp8uzdu9dem8137vtGW/RS01ddLsipTYPYQO5qnL6Gp83yWI6aBEGQqP
         1jhEMKuEf7sqxESWm/wHqm0ycrm9BIaD8ve8ivgOTE4eKUuk2zJc86w/7smqz59YDAgV
         +paBKr7e/6ARk2885w1hiqOvbvAruUf3qEC61nwvpFCtQKmkL1M/5v4c+tg4+jldl0yD
         Eecy0WeETwGAYzPcN59c2h4BFJNwBri5rcW3a3lcM9/biWpZvoGtzB/NmUzFgHi5MfU7
         UYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774012; x=1708378812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrBz9DyywfwO606ZQMwpTbc2aylPEGoXqCQTswmuPUY=;
        b=GjPMgOBOFSXlDcBa5zafHuaipHx9CFtbpsJTpw84KIb0odECyRkUBH5z8iUjCMgXgi
         WgUVLt29U1YlQBra+0yPZHCoW3m2pbCoFRN0hlBuJV72r8MWZ+bUOnMmc5QYfNenyz1w
         5V9ajjuFJ3JhtyZQhL2VNytufYUcZDVU2bE0qQpWNPc3nzzFXSNAc2PD9nIZaAngpvnG
         cGg1TB+CTMiK7qhPnO9oSI4tc3FYiPiMUjZnF0sPH65deW2KH3F5cLEjVqlpiRwr3T9k
         1UxJKz8U+HgNJf6DNhek81H9xU7QDlRcg5MEr5FGDm0XRsD+/NsQdM0xi2d9+5jND752
         8wCg==
X-Forwarded-Encrypted: i=1; AJvYcCWhnnTVzlWqN9uLxbRvdVfuWxb8wJO9CwjFmI2tQom7WwTA3eVx+0v97+lWPNhXgtAKY5gF3RseAlYz3voNi8iBrQRmdw6/+9uY6HiOpg==
X-Gm-Message-State: AOJu0YwHsaVOVLz0Mz9CqQXFq7UNQFm0Ld/H6NJANGefoKLilpqrQn+I
	IEq0ynuumLZNDSST+lsK7Ym5fnfdxS1MwpHWpErkLYBxkb3vQGrSFdedLba4Bs7ES4BvuT7o7iL
	eHA==
X-Google-Smtp-Source: AGHT+IGdELNRz/U7g++PhfoEsyUKyEa0DYZtdFbwbl9fcNHM0h9+fVLMKP8bhlCRwXrMrONYMoTWo6orz2A=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a25:ad02:0:b0:dcc:2267:796e with SMTP id
 y2-20020a25ad02000000b00dcc2267796emr133364ybi.2.1707774012029; Mon, 12 Feb
 2024 13:40:12 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:04 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-19-surenb@google.com>
Subject: [PATCH v3 18/35] mm: create new codetag references during page splitting
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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
index a060c26eb449..0174aff5e871 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -62,11 +62,41 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int order)
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
+		/* New reference with 0 bytes accounted */
+		alloc_tag_add(codetag_ref_from_page_ext(page_ext), tag, 0);
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
2.43.0.687.g38aa6559b0-goog


