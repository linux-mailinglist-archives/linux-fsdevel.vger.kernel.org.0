Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F41C6F346A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 18:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjEAQ7v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 12:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjEAQ67 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:58:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4624530D7
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:56:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so3225153276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960158; x=1685552158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+1Ptlsu3HrvWcynZoOK0ZqIIaOTUmOtwKZY5J1VaLvs=;
        b=7gQ7i/dAC1G0h1XxKulN+zlGUyuRlgFLhf3t4U3ldYpJ9ZDjgqW3Y7teulwLUtCfTD
         /VnlwalgQGiFZbmlj07JbUX6Sp54fAN7SxMoxkItZT8pyryAeS9XmoLet1E+NORYJiar
         iYyZW8dCc0lMzuXcFL3U4QE+FrlZuAGGckHXyur/pD6//ulYUoFzkf8zDD0aROPp40k/
         xmTrCxx3e3E9BLeb2nij/r9kqOJAFZfyDKOq1UGUdyyy0zgGTjg9yGYmpyEbnJHJf0ZV
         W5qYg5oFjenWEcOuTpD8cYePEcPbJSlpmAYb7YzYWjMWXvtbqAw/EQzvEU6N9zSkiTXv
         C/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960158; x=1685552158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1Ptlsu3HrvWcynZoOK0ZqIIaOTUmOtwKZY5J1VaLvs=;
        b=Ety+Ds5yS4I3M/nVKaEW5Fhu60maD6HAQehfrByj6lwSRg73wyPPlz5Pk3+FLUEbyk
         fFurVMY7P7dxQ7DPNCA2Aqp/3oAUL2sKlEWPU9YHBSr5ScEwrE0J6L91jpYy8HjaT1HR
         mWLVQK/NxJ4/b3wFxbsp0NMxHKRPzS0776Q0+PeaRw+nTgszJPgaWM+LqlPJQKH49V5U
         9jW0UmP3vgUON3agEN9ZKwyWBgMlbVSAQERiO9aer7j49Dgs5JHgWrrcaEIkq8PfxyXe
         YVUWBQl+c6CUsfk9bsI7O5BwBhgSTg8yMjTln6hoON3vYrRJgx7eqWUc+6z8xfb6lMI5
         sfwA==
X-Gm-Message-State: AC+VfDzGc4iEvhPx4/Oh66HzWt79hQAhPey0CRvcQtP5BJNRtqULyw4M
        FwPnHmQG6cf7MBtQwoS5HRzasn/GbW8=
X-Google-Smtp-Source: ACHHUZ7r1ycZ9itNH1qfXqxuYbQFcFPivnhoEDNh4tWwK8chvFvWCKKjG1ErV0+LZWXbi1M27uOVRiApR9A=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a05:6902:1028:b0:b8c:607:7669 with SMTP id
 x8-20020a056902102800b00b8c06077669mr8930549ybt.5.1682960158430; Mon, 01 May
 2023 09:55:58 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:32 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-23-surenb@google.com>
Subject: [PATCH 22/40] mm: create new codetag references during page splitting
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
index 567327c1c46f..0cbba13869b5 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -52,11 +52,41 @@ static inline void pgalloc_tag_dec(struct page *page, unsigned int order)
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
 
 static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
 static inline void put_page_tag_ref(union codetag_ref *ref) {}
 #define pgalloc_tag_dec(__page, __size)		do {} while (0)
+static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 624671aaa60d..221cce0052a2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -37,6 +37,7 @@
 #include <linux/page_owner.h>
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
+#include <linux/pgalloc_tag.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -2557,6 +2558,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, nr);
+	pgalloc_tag_split(head, nr);
 
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index edd35500f7f6..8cf5a835af7f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2796,6 +2796,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, 1 << order);
+	pgalloc_tag_split(page, 1 << order);
 	split_page_memcg(page, 1 << order);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -5012,6 +5013,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, 1 << order);
+		pgalloc_tag_split(page, 1 << order);
 		split_page_memcg(page, 1 << order);
 		while (page < --last)
 			set_page_refcounted(last);
-- 
2.40.1.495.gc816e09b53d-goog

