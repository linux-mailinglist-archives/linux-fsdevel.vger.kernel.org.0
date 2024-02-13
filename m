Return-Path: <linux-fsdevel+bounces-11453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE27853DC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708801F2CD7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763AFD29B;
	Tue, 13 Feb 2024 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="LTPl4PvC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NS1rZYqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1062178;
	Tue, 13 Feb 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861350; cv=none; b=eKGkKXpYeE6nTpHeL1oAMR8dqOGF+elVWfRUh0tXfr0gIQd+HCCZ263zciuQEXzHBzIy2CgID3Giqw3KZdPcQTovge1vuLyHzAmXAGGy4opQPc6n6q64xtrz6tLJ4H9DyCAW2vfActqWqmn7Q08/PzzkPqdGhLFxzqZ5P/gnHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861350; c=relaxed/simple;
	bh=38MdZLYuG2AJ1aXCJFRm5FPXaorCtatf6d4mFy+wv+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBrtBNJNVooWeLlVzjEMv/XQoeSsv94NBjBrWEeCTkjXSSbig8RtZpno/2DRu4/39BY1XH9aSIqqzaqmTZz8jvlz+4gfpO/Tb8UKPwXSD5gmjahh61FxJHtDdCXu2ehBnABdaxlYuwtFvHrHf74wHwnF+YkN6XE1VtKOkIZHCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=LTPl4PvC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NS1rZYqI; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id D43925C00CA;
	Tue, 13 Feb 2024 16:55:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 16:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1707861347; x=1707947747; bh=43KUO5pZ3osjy6nQRy6LW8cIMJ14A3p6oz8
	yC6ceQKk=; b=LTPl4PvCEFNUWDJZquJqdFcLG0owwHI9iL4COQiteBUhernnnNq
	LH6fO88G1V9ARLPVrpl41dw2Mvmbe7Dms1ZpgNKVpUx87Aw9LUnOSgvBw4+bcsbg
	Qts6nhxjVNsTFvJweIWEM8CzHPQin02SRUS+uxKYa8DO4jig+rm6zQMQSmM1gEmt
	JsRgaojL5wKkQqVb27ss0mEt3a+AdAxzleU7U+eGn6OrZMm3jMkUh7cmxMyzseoC
	UUG/n1QCRbZVEaCZEfaxkshdDkPg+XubSSDrDsUYGTbBl6axSRhmQBh9o6uW9Gi5
	RBJ31EzlPhh4FML7qpweqDqojd6i9V4NVYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707861347; x=1707947747; bh=43KUO5pZ3osjy6nQRy6LW8cIMJ14A3p6oz8
	yC6ceQKk=; b=NS1rZYqIDbBEaDSWg1X5bjk05SdO55tD+MgK8/KdvNjyX8L853q
	F9BmuErnawsM7nwDrkc7O3CFyEdZ6NkLWoNMUhlDOlWsbXuvOZl0MXQUdG4767R3
	YN+egUo2h0XSD/tneJAwXP1569DVxKjnBpm1uCubpskQ4od7IPdHexduhByAfv9y
	a+JtAMDrL5trG/bCgFoqqGWga0eeMUDDEHdQAqfQnMdf2IUh0wJaq/kMBZ7PSgxW
	N/tZhT2zmPU1YsfUei38gjBePrKNQQH0Q2n4N4SX1FjCUUDajeiT11CuFsFk1yM8
	50BlGNcQjabvDCvofI5zW4XvuKdaFuoV20w==
X-ME-Sender: <xms:Y-XLZRHTFlVIJexY-4UvRW2UW1L5Y9NI41j_sK3Z-b5XzL9j67Cacw>
    <xme:Y-XLZWVA-1VTWyUcVyOrQhU_KuRvhgn4efE8p_RTlwYbYO60cQHXENhDm-gshMtpz
    24T_M0L_MeMuwCKGA>
X-ME-Received: <xmr:Y-XLZTKBUULDRM0n_9pfANe7rz0CeOxh--6PtUmT6rwDGwI8bNH7nO3j6TCYODQ7as5YKGtAFUF9BBvZLCGNBNj-6aiT-enkqtB2KLpIZgiI2-cAj9PVD2st>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:Y-XLZXFawjEAoUwdqEEFErcuE0PlXf4-NeoupjNOO0YoD_8yR_FrbQ>
    <xmx:Y-XLZXXMcWd9zd6qEkJTx-rPLDTEETp6OTLIc41poGLQwNPEysilhw>
    <xmx:Y-XLZSPI57vReVl_GI59qjrS8Y91tIef4J6lgiwtVxvmJTPK9mwI0A>
    <xmx:Y-XLZZaP-8Q-uSzl9cGboMu89OVpo6vLP88VlE9aSB2QMbzc4i0kAA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 16:55:46 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Zach O'Keefe" <zokeefe@google.com>,
	Hugh Dickins <hughd@google.com>,
	Mcgrof Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 1/7] mm/memcg: use order instead of nr in split_page_memcg()
Date: Tue, 13 Feb 2024 16:55:14 -0500
Message-ID: <20240213215520.1048625-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213215520.1048625-1-zi.yan@sent.com>
References: <20240213215520.1048625-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

We do not have non power of two pages, using nr is error prone if nr
is not power-of-two. Use page order instead.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/huge_memory.c           | 3 ++-
 mm/memcontrol.c            | 3 ++-
 mm/page_alloc.c            | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4e4caeaea404..173bbb53c1ec 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1163,7 +1163,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 	rcu_read_unlock();
 }
 
-void split_page_memcg(struct page *head, unsigned int nr);
+void split_page_memcg(struct page *head, int order);
 
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
@@ -1621,7 +1621,7 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
 }
 
-static inline void split_page_memcg(struct page *head, unsigned int nr)
+static inline void split_page_memcg(struct page *head, int order)
 {
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 016e20bd813e..0cd5fba0923c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2877,9 +2877,10 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unsigned long offset = 0;
 	unsigned int nr = thp_nr_pages(head);
 	int i, nr_dropped = 0;
+	int order = folio_order(folio);
 
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, nr);
+	split_page_memcg(head, order);
 
 	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
 		offset = swp_offset(folio->swap);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 93ad8640b741..404e529644c0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3608,11 +3608,12 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 /*
  * Because page_memcg(head) is not set on tails, set it now.
  */
-void split_page_memcg(struct page *head, unsigned int nr)
+void split_page_memcg(struct page *head, int order)
 {
 	struct folio *folio = page_folio(head);
 	struct mem_cgroup *memcg = folio_memcg(folio);
 	int i;
+	unsigned int nr = 1 << order;
 
 	if (mem_cgroup_disabled() || !memcg)
 		return;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7ae4b74c9e5c..7c927b84e16c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2653,7 +2653,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, 1 << order);
-	split_page_memcg(page, 1 << order);
+	split_page_memcg(page, order);
 }
 EXPORT_SYMBOL_GPL(split_page);
 
@@ -4838,7 +4838,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, 1 << order);
-		split_page_memcg(page, 1 << order);
+		split_page_memcg(page, order);
 		while (page < --last)
 			set_page_refcounted(last);
 
-- 
2.43.0


