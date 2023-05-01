Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E216F34A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjEARCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 13:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjEARBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 13:01:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8561FD7
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:56:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7553f95dso5490261276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960183; x=1685552183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfMxO5ATd5n4S/fh5B/Nudv/nxDkBrDhDPER315pa0U=;
        b=ebS+MuTL+cQNWT4eZEJvTQOcTARn+QnzuJah4/SMgcb7+qkoUNzC7ex8MrpVKhZRXc
         KgeXlio4zrfdxmOppnmcCQe6TR+hOuBdIc9ihcKiKIEVRbsGHe8ObZbrrM4utujRh9wG
         TqBTS5rCEI/Jizsrf15UbPFacomNmio9VSdaY4o+amTMj91xth7X0uCHsGdXYXQ52AxU
         vnIxBaA8u69160qtwfedxuqqybJKyd5xlJm5XUDfPQCWKc/CaKvS4YCnPYvKKCkeigKq
         aazNcodiJ2//C8yradLEHTJBg1grANJmustwDAaYwDmuE541j3ivI8Z4B8/7N+gU15xY
         5tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960183; x=1685552183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfMxO5ATd5n4S/fh5B/Nudv/nxDkBrDhDPER315pa0U=;
        b=PnAFVyxV98e0DhJHrS22KPIorJMzPuw7Skz9A3L7nxGgWsULMfL4hqUoQJQI6p7bGW
         TFKIz2Zl5HZQqs8oOeWofF5DjL6r6atBNaS1qukRtVRUuwr9vPydcMiDnpkfQcWru6NL
         qJnaengvqhNBI5ZnqWKr7SDNZIvrX3oYFaNtz8X/omHoC7hGXaR7DO4EfqCFer8bQc48
         W2U3+cEJIR0cspM9y+6w0FresFjotqk1ehQqPvYpkYX41XIpy47oMDoK3uCXMZPcpp46
         8yILGAh4fVF3W3I09w6nBoJHa5fa3JvcCJZuLHV8oJeG6pPVKJlNG2XnaqSL4nAcxOBL
         Dxog==
X-Gm-Message-State: AC+VfDyphgqLFkRVEwfjMxgjBDNXOJJfFhTts9nN+0XuY00+NHTP5aDr
        D/ehNyifxfFkA1BMtvv3z/aYmLF2iM8=
X-Google-Smtp-Source: ACHHUZ6mXAn8JgUNXvyGZqHJw9Jv8uWK4VnvTdJsjQhuuRu+wtW4LhhvfSOs0fXoyYvuKXJ26U7UG2NCZPo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:8046:0:b0:b9d:c866:d92d with SMTP id
 a6-20020a258046000000b00b9dc866d92dmr3485899ybn.1.1682960183189; Mon, 01 May
 2023 09:56:23 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:43 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-34-surenb@google.com>
Subject: [PATCH 33/40] move stack capture functionality into a separate
 function for reuse
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

Make save_stack() function part of stackdepot API to be used outside of
page_owner. Also rename task_struct's in_page_owner to in_capture_stack
flag to better convey the wider use of this flag.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/sched.h      |  6 ++--
 include/linux/stackdepot.h | 16 +++++++++
 lib/stackdepot.c           | 68 ++++++++++++++++++++++++++++++++++++++
 mm/page_owner.c            | 52 ++---------------------------
 4 files changed, 90 insertions(+), 52 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 33708bf8f191..6eca46ab6d78 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -942,9 +942,9 @@ struct task_struct {
 	/* Stalled due to lack of memory */
 	unsigned			in_memstall:1;
 #endif
-#ifdef CONFIG_PAGE_OWNER
-	/* Used by page_owner=on to detect recursion in page tracking. */
-	unsigned			in_page_owner:1;
+#ifdef CONFIG_STACKDEPOT
+	/* Used by stack_depot_capture_stack to detect recursion. */
+	unsigned			in_capture_stack:1;
 #endif
 #ifdef CONFIG_EVENTFD
 	/* Recursion prevention for eventfd_signal() */
diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index e58306783d8e..baf7e80cf449 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -164,4 +164,20 @@ depot_stack_handle_t __must_check stack_depot_set_extra_bits(
  */
 unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle);
 
+/**
+ * stack_depot_capture_init - Initialize stack depot capture mechanism
+ *
+ * Return: Stack depot initialization status
+ */
+bool stack_depot_capture_init(void);
+
+/**
+ * stack_depot_capture_stack - Capture current stack trace into stack depot
+ *
+ * @flags:	Allocation GFP flags
+ *
+ * Return: Handle of the stack trace stored in depot, 0 on failure
+ */
+depot_stack_handle_t stack_depot_capture_stack(gfp_t flags);
+
 #endif
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 2f5aa851834e..c7e5e22fcb16 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -539,3 +539,71 @@ unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
 	return parts.extra;
 }
 EXPORT_SYMBOL(stack_depot_get_extra_bits);
+
+static depot_stack_handle_t recursion_handle;
+static depot_stack_handle_t failure_handle;
+
+static __always_inline depot_stack_handle_t create_custom_stack(void)
+{
+	unsigned long entries[4];
+	unsigned int nr_entries;
+
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	return stack_depot_save(entries, nr_entries, GFP_KERNEL);
+}
+
+static noinline void register_recursion_stack(void)
+{
+	recursion_handle = create_custom_stack();
+}
+
+static noinline void register_failure_stack(void)
+{
+	failure_handle = create_custom_stack();
+}
+
+bool stack_depot_capture_init(void)
+{
+	static DEFINE_MUTEX(stack_depot_capture_init_mutex);
+	static bool utility_stacks_ready;
+
+	mutex_lock(&stack_depot_capture_init_mutex);
+	if (!utility_stacks_ready) {
+		register_recursion_stack();
+		register_failure_stack();
+		utility_stacks_ready = true;
+	}
+	mutex_unlock(&stack_depot_capture_init_mutex);
+
+	return utility_stacks_ready;
+}
+
+/* TODO: teach stack_depot_capture_stack to use off stack temporal storage */
+#define CAPTURE_STACK_DEPTH (16)
+
+depot_stack_handle_t stack_depot_capture_stack(gfp_t flags)
+{
+	unsigned long entries[CAPTURE_STACK_DEPTH];
+	depot_stack_handle_t handle;
+	unsigned int nr_entries;
+
+	/*
+	 * Avoid recursion.
+	 *
+	 * Sometimes page metadata allocation tracking requires more
+	 * memory to be allocated:
+	 * - when new stack trace is saved to stack depot
+	 * - when backtrace itself is calculated (ia64)
+	 */
+	if (current->in_capture_stack)
+		return recursion_handle;
+	current->in_capture_stack = 1;
+
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
+	handle = stack_depot_save(entries, nr_entries, flags);
+	if (!handle)
+		handle = failure_handle;
+
+	current->in_capture_stack = 0;
+	return handle;
+}
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 8b6086c666e6..9fafbc290d5b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -15,12 +15,6 @@
 
 #include "internal.h"
 
-/*
- * TODO: teach PAGE_OWNER_STACK_DEPTH (__dump_page_owner and save_stack)
- * to use off stack temporal storage
- */
-#define PAGE_OWNER_STACK_DEPTH (16)
-
 struct page_owner {
 	unsigned short order;
 	short last_migrate_reason;
@@ -37,8 +31,6 @@ struct page_owner {
 static bool page_owner_enabled __initdata;
 DEFINE_STATIC_KEY_FALSE(page_owner_inited);
 
-static depot_stack_handle_t dummy_handle;
-static depot_stack_handle_t failure_handle;
 static depot_stack_handle_t early_handle;
 
 static void init_early_allocated_pages(void);
@@ -68,16 +60,6 @@ static __always_inline depot_stack_handle_t create_dummy_stack(void)
 	return stack_depot_save(entries, nr_entries, GFP_KERNEL);
 }
 
-static noinline void register_dummy_stack(void)
-{
-	dummy_handle = create_dummy_stack();
-}
-
-static noinline void register_failure_stack(void)
-{
-	failure_handle = create_dummy_stack();
-}
-
 static noinline void register_early_stack(void)
 {
 	early_handle = create_dummy_stack();
@@ -88,8 +70,7 @@ static __init void init_page_owner(void)
 	if (!page_owner_enabled)
 		return;
 
-	register_dummy_stack();
-	register_failure_stack();
+	stack_depot_capture_init();
 	register_early_stack();
 	static_branch_enable(&page_owner_inited);
 	init_early_allocated_pages();
@@ -107,33 +88,6 @@ static inline struct page_owner *get_page_owner(struct page_ext *page_ext)
 	return (void *)page_ext + page_owner_ops.offset;
 }
 
-static noinline depot_stack_handle_t save_stack(gfp_t flags)
-{
-	unsigned long entries[PAGE_OWNER_STACK_DEPTH];
-	depot_stack_handle_t handle;
-	unsigned int nr_entries;
-
-	/*
-	 * Avoid recursion.
-	 *
-	 * Sometimes page metadata allocation tracking requires more
-	 * memory to be allocated:
-	 * - when new stack trace is saved to stack depot
-	 * - when backtrace itself is calculated (ia64)
-	 */
-	if (current->in_page_owner)
-		return dummy_handle;
-	current->in_page_owner = 1;
-
-	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 2);
-	handle = stack_depot_save(entries, nr_entries, flags);
-	if (!handle)
-		handle = failure_handle;
-
-	current->in_page_owner = 0;
-	return handle;
-}
-
 void __reset_page_owner(struct page *page, unsigned short order)
 {
 	int i;
@@ -146,7 +100,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	if (unlikely(!page_ext))
 		return;
 
-	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
+	handle = stack_depot_capture_stack(GFP_NOWAIT | __GFP_NOWARN);
 	for (i = 0; i < (1 << order); i++) {
 		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 		page_owner = get_page_owner(page_ext);
@@ -189,7 +143,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 	struct page_ext *page_ext;
 	depot_stack_handle_t handle;
 
-	handle = save_stack(gfp_mask);
+	handle = stack_depot_capture_stack(gfp_mask);
 
 	page_ext = page_ext_get(page);
 	if (unlikely(!page_ext))
-- 
2.40.1.495.gc816e09b53d-goog

