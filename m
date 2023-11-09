Return-Path: <linux-fsdevel+bounces-2463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3E47E62AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 04:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3781C20847
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 03:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E86AA6;
	Thu,  9 Nov 2023 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hPDBsLer"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E95668
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 03:31:32 +0000 (UTC)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0132726B0
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:31:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699500351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7QgHrHMcQgDYNH9cSurCrN2io0udjYc/RXiOMn9HQo=;
	b=hPDBsLerGi2CsDGvsyury3Y7/vRfFLrFqniLSN9fLNoEOxsjniR6+2yoRufgY/ESIOkfDC
	hxgIyJGxT8EIAg3Nr3sL0jfaPGEsQ1/mwz0+sPIkno1r/+6iBvJyla6Ek+XO8p+oMuiCTj
	AyxVNGd5WlH4qVnpOxDC3n3Jp4lJhz8=
From: Jeff Xie <jeff.xie@linux.dev>
To: akpm@linux-foundation.org,
	iamjoonsoo.kim@lge.com,
	vbabka@suse.cz,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	willy@infradead.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chensong_2000@189.cn,
	xiehuan09@gmail.com,
	Jeff Xie <jeff.xie@linux.dev>
Subject: [RFC][PATCH 1/4] mm, page_owner: add folio allocate post callback for struct page_owner to make the owner clearer
Date: Thu,  9 Nov 2023 11:25:18 +0800
Message-Id: <20231109032521.392217-2-jeff.xie@linux.dev>
In-Reply-To: <20231109032521.392217-1-jeff.xie@linux.dev>
References: <20231109032521.392217-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

adding a callback function in the struct page_owner to let the slab layer or the
anon/file handler layer or any other memory-allocated layers to implement what
they would like to tell.

Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
---
 include/linux/page_owner.h |  9 +++++++++
 mm/page_owner.c            | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 119a0c9d2a8b..71698d82df7c 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -4,6 +4,9 @@
 
 #include <linux/jump_label.h>
 
+typedef int (folio_alloc_post_page_owner_t)(struct folio *folio, struct task_struct *tsk,
+			void *data, char *kbuf, size_t count);
+
 #ifdef CONFIG_PAGE_OWNER
 extern struct static_key_false page_owner_inited;
 extern struct page_ext_operations page_owner_ops;
@@ -17,6 +20,8 @@ extern void __set_page_owner_migrate_reason(struct page *page, int reason);
 extern void __dump_page_owner(const struct page *page);
 extern void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 					pg_data_t *pgdat, struct zone *zone);
+extern void set_folio_alloc_post_page_owner(struct folio *folio,
+		folio_alloc_post_page_owner_t *folio_alloc_post_page_owner, void *data);
 
 static inline void reset_page_owner(struct page *page, unsigned short order)
 {
@@ -72,5 +77,9 @@ static inline void set_page_owner_migrate_reason(struct page *page, int reason)
 static inline void dump_page_owner(const struct page *page)
 {
 }
+static inline void set_folio_alloc_post_page_owner(struct folio *folio,
+		folio_alloc_post_page_owner_t *folio_alloc_post_page_owner, void *data)
+{
+}
 #endif /* CONFIG_PAGE_OWNER */
 #endif /* __LINUX_PAGE_OWNER_H */
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 4f13ce7d2452..4de03a7a10d4 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -32,6 +32,9 @@ struct page_owner {
 	char comm[TASK_COMM_LEN];
 	pid_t pid;
 	pid_t tgid;
+	folio_alloc_post_page_owner_t *folio_alloc_post_page_owner;
+	/* for folio_alloc_post_page_owner function parameter */
+	void *data;
 };
 
 static bool page_owner_enabled __initdata;
@@ -152,6 +155,8 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		page_owner = get_page_owner(page_ext);
 		page_owner->free_handle = handle;
 		page_owner->free_ts_nsec = free_ts_nsec;
+		page_owner->folio_alloc_post_page_owner = NULL;
+		page_owner->data = NULL;
 		page_ext = page_ext_next(page_ext);
 	}
 	page_ext_put(page_ext);
@@ -256,6 +261,8 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
 	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
 	strcpy(new_page_owner->comm, old_page_owner->comm);
+	new_page_owner->folio_alloc_post_page_owner = old_page_owner->folio_alloc_post_page_owner;
+	new_page_owner->data = old_page_owner->data;
 
 	/*
 	 * We don't clear the bit on the old folio as it's going to be freed
@@ -272,6 +279,25 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	page_ext_put(old_ext);
 }
 
+void set_folio_alloc_post_page_owner(struct folio *folio,
+		folio_alloc_post_page_owner_t *folio_alloc_post_page_owner, void *data)
+{
+	struct page *page;
+	struct page_ext *page_ext;
+	struct page_owner *page_owner;
+
+	page = &folio->page;
+	page_ext = page_ext_get(page);
+	if (unlikely(!page_ext))
+		return;
+
+	page_owner = get_page_owner(page_ext);
+	page_owner->folio_alloc_post_page_owner = folio_alloc_post_page_owner;
+	page_owner->data = data;
+
+	page_ext_put(page_ext);
+}
+
 void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 				       pg_data_t *pgdat, struct zone *zone)
 {
@@ -400,6 +426,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		depot_stack_handle_t handle)
 {
 	int ret, pageblock_mt, page_mt;
+	struct task_struct *tsk;
 	char *kbuf;
 
 	count = min_t(size_t, count, PAGE_SIZE);
@@ -414,6 +441,15 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 			page_owner->tgid, page_owner->comm,
 			page_owner->ts_nsec);
 
+	if (page_owner->folio_alloc_post_page_owner) {
+		rcu_read_lock();
+		tsk = find_task_by_pid_ns(page_owner->pid, &init_pid_ns);
+		rcu_read_unlock();
+		ret += page_owner->folio_alloc_post_page_owner(page_folio(page), tsk, page_owner->data,
+				kbuf + ret, count - ret);
+	} else
+		ret += scnprintf(kbuf + ret, count - ret, "OTHER_PAGE\n");
+
 	/* Print information relevant to grouping pages by mobility */
 	pageblock_mt = get_pageblock_migratetype(page);
 	page_mt  = gfp_migratetype(page_owner->gfp_mask);
-- 
2.34.1


