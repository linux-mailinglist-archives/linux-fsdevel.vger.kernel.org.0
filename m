Return-Path: <linux-fsdevel+bounces-11224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D428520AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE3F1F2289B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB085F861;
	Mon, 12 Feb 2024 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WsgFZffW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3365EE99
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707774048; cv=none; b=qe48K0iMcCXZyWdle2KeKLveFiz40P3JXgsq6EbB7FEPnVcM14WTBOpCC9XjTtz8BoL9hn89uCCYBmLa+j7D5qTpdFMR+/gnf0s4ZnAj/gyqCQe3sGZRTRdtCBajGT0T8kD5zRKyBzBzNYe72hT7YqOrSAGpRxA2YXN8ito43k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707774048; c=relaxed/simple;
	bh=YSv5f7I2dnKMkhKo6foFZjKi7C7ZfZQ0Dh90Hrbid3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ESmyK5at56cB/5UYavji3J8t0Q6cwA5dIcDlFaMgXgvu+uWQymEmBi+aGiGy7bE2KnOmx62ZyZckHOqebuol+WFfQjAGgCPENBu0KBtQPevtDCiQZ11wA1S4fh6v5XVdTrt6dWWXUGXQ56W68umbXvhpbHkyWgGyFfixVjC459k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WsgFZffW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60781e8709eso1278887b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707774044; x=1708378844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DSEwnOfj2VuhpdkIHZ8VNVuKfvBXo1I5xAUr9MF0J1M=;
        b=WsgFZffWHCiunhFYSG85Wdx2weLmuEGaHGH/oFm0cnp13Tgcs+IsI6oF7WEQE3bQEt
         EPDCLJnwpDPx55RZmEsDVdVh15RPQsQb9xc8Q7IaET2M9DsneYgj5Jkd7PFHezyeFmwO
         5XoihY+LwxyPZi4IElVPJKsOoVelm9IIGyz4difZP+HLL3vR58cVP1Pm2M8cf/+W2LVq
         Ka5vviUmim9ni/d7HeBLUdIQIJ/kdCXheL2xmwnztZ1lmwNc+dZMw5ut71vPpSCLQ4k9
         6zQTbQuCLYr+VYv2tSBalNYWcmibDuviev8d3yYCmSvQ9LwWRiTtH9Rpt+0IaE/6LHGp
         atOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707774044; x=1708378844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSEwnOfj2VuhpdkIHZ8VNVuKfvBXo1I5xAUr9MF0J1M=;
        b=RW5ipdUJ6l0ElTgaCfZVa6ThbRO2UEHKkvVRAKmxCJ4YMUs5c1s3hLTtFw/bwyQwMd
         7ItYAfQd99Xfgj70qRrI5r5vGpVDu6r0DZsuZ43eNH6LaQUGwn61W5YRc7g2q2HkF72b
         8NktHHeMtEi/vRKZpcLk1ToP8tOP0FUkJfsMZ9W4aAj+8KzVgEvc5He0bG7aD0oozarJ
         tqNDj4EZlD4dgQCJhcG6havNkMJWHP0C21Qn+Yj/WBIlUKKdeZIeJ781NtdrUolST7IM
         ItjjKHica0gYfdx1xhyf7u5Osm7OJs5BzfQq46krMAatJKwNC7kNhiIb+M4V0b4ND7Xr
         4cxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOrKwTTraTZnT4vG6E4ximIhCTJCMtnMw/QlEHFQLFEWSCKBiq5zBoVEKyEnEl2Ki653YGpvgzM88w889KiKttKPcDd5xMozQr2fSNuw==
X-Gm-Message-State: AOJu0YwOCjeE1rH1Bkqin6eJMPCW1dtghJpDdWztsdYjRbZt8gBQ3Un/
	3DUOeBQ3d9fEdmYA8N5a7ucc6reiCKAC5rhwQBrusXsjwFE0pgH1d9EHyDfBK/cGLkCuXfhLRe2
	HDA==
X-Google-Smtp-Source: AGHT+IFtNaKOZcDNkW8O/y0IS6dfwCCkuRAaS6+IZN21h1P/6QI7aHSb74NpkK/DZ6QgX1s1BGxeLh90Utw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a0d:e8c2:0:b0:607:79be:9120 with SMTP id
 r185-20020a0de8c2000000b0060779be9120mr169543ywe.0.1707774044127; Mon, 12 Feb
 2024 13:40:44 -0800 (PST)
Date: Mon, 12 Feb 2024 13:39:19 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-34-surenb@google.com>
Subject: [PATCH v3 33/35] codetag: debug: mark codetags for reserved pages as empty
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

To avoid debug warnings while freeing reserved pages which were not
allocated with usual allocators, mark their codetags as empty before
freeing.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/alloc_tag.h   | 2 ++
 include/linux/mm.h          | 8 ++++++++
 include/linux/pgalloc_tag.h | 2 ++
 mm/mm_init.c                | 9 +++++++++
 4 files changed, 21 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 1f3207097b03..102caf62c2a9 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -95,6 +95,7 @@ static inline void set_codetag_empty(union codetag_ref *ref)
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline bool is_codetag_empty(union codetag_ref *ref) { return false; }
+static inline void set_codetag_empty(union codetag_ref *ref) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
@@ -155,6 +156,7 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes) {}
 static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_t bytes) {}
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
 				 size_t bytes) {}
+static inline void set_codetag_empty(union codetag_ref *ref) {}
 
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..ac1b661987ed 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
+#include <linux/pgalloc_tag.h>
 #include <linux/bug.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
@@ -3112,6 +3113,13 @@ extern void reserve_bootmem_region(phys_addr_t start,
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void free_reserved_page(struct page *page)
 {
+	union codetag_ref *ref;
+
+	ref = get_page_tag_ref(page);
+	if (ref) {
+		set_codetag_empty(ref);
+		put_page_tag_ref(ref);
+	}
 	ClearPageReserved(page);
 	init_page_count(page);
 	__free_page(page);
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 0174aff5e871..ae9b0f359264 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -93,6 +93,8 @@ static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
+static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
+static inline void put_page_tag_ref(union codetag_ref *ref) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int order) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index e9ea2919d02d..f5386632fe86 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2566,6 +2566,7 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
 							unsigned int order)
 {
+	union codetag_ref *ref;
 
 	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
 		int nid = early_pfn_to_nid(pfn);
@@ -2578,6 +2579,14 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 		/* KMSAN will take care of these pages. */
 		return;
 	}
+
+	/* pages were reserved and not allocated */
+	ref = get_page_tag_ref(page);
+	if (ref) {
+		set_codetag_empty(ref);
+		put_page_tag_ref(ref);
+	}
+
 	__free_pages_core(page, order);
 }
 
-- 
2.43.0.687.g38aa6559b0-goog


