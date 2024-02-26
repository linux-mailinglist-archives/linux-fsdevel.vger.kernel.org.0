Return-Path: <linux-fsdevel+bounces-12875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2741868233
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7F4289AF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2622813246A;
	Mon, 26 Feb 2024 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="YuhI4fCt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="glx5DJxV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F213172E;
	Mon, 26 Feb 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980974; cv=none; b=a1yJ+ONs5k1wa1PR6FCTBMvHB6bQQKX1LXq4HkCApcUMR2ImG5h8DoeNwALd9Q8eyuqN0wauYHtdp6XjDHpnnjmwe6tqRCdfhLtOzd1oDaybDm8vvDMT3gE+Y6mcrnXWAkrZpYRdYK4gad36yDKJX+1w4Fm21EzYTz7zFX8Jyyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980974; c=relaxed/simple;
	bh=gkVdN6Ju83sqaexnUoOXBzO/NLvcTIiVWHWKKnGtjD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7rhxbKoXo+rx0VZMrZc5IznObuAw6E2TSsxHri3NItTrx3lsBU2+/zABDEVKneCuv7ekNIhPJrRAkO/NEGP1A111FquXFttqapFveKIHvoQifMZX6ikT3cb4Bm77PJ7ivWDOjFLgR+J84g5vNtkGYQ/SQZHSmrHNxjBeYsBw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=YuhI4fCt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=glx5DJxV; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id B3D865C0048;
	Mon, 26 Feb 2024 15:56:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 26 Feb 2024 15:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708980971; x=1709067371; bh=M9xzwbyGsmIoI4XohAUvU/zFDUrkDEXSeps
	On39+bAw=; b=YuhI4fCtxyT7k5hVmSOEXMQbymAhui8JNegspEpvv/VYXQL41Ft
	pj6ydaFD0U8iL9cudlW457UYRQv8fEQ15V4gtUgJTlULXYCw1W+oHH7tpowniDfd
	72lYDV66Ftv8Dihhg5hNlSrvNKyVSES3im67x3NJFo9TOSe5pkEVgSN0kxnXz9iS
	a2jmX5OXUupg8j2TZ0Wn/rQuxuqFPctJ3PsIQ2HiU53bTckPiZG5ROcg/fK+r2rp
	J4N6AHpbL4atGUiQ8tXxdfMqi+gal2Qc5fnKvro8o51nEGdfoFOOE+iuAKvvsSRv
	7s4EaXf/bQ1fq/pkTQTq+ZndUEfxw8ypyqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708980971; x=1709067371; bh=M9xzwbyGsmIoI4XohAUvU/zFDUrkDEXSeps
	On39+bAw=; b=glx5DJxVZIKumkxaIHAXIDP5YXKd5Im2fQ/t9CFv2OmBqMUwTJS
	SnpR5h2I0Ej/cY1kh6BRa4tCtDUgFzifVy7a/5qEul1MiRrxi9sq7VEewBj2bGwE
	dl13XHV1xbfKMBo+3KRdI7QlYUMK59X0qZ9IVut7HFp7dV5/IoM/cAxgFwQFdVgm
	Z77LLs9kJU8sYOmfV9Zm8ZvyR7hriEWUq3flyWvA0MM8r3mveLfT/qRIzqOHuvau
	llFl9HkR6kH1cToAl2JyeQsEJvO7f92ZErYrt3vo0FlHbsQmiSfga0yHN7qGhXbd
	lq6rkbeM3LiWAQWYeyS6T1JVDO69Ksg7fzw==
X-ME-Sender: <xms:6_rcZR9jk4SAPb6k8eRjSso_MIVsT5ynp7Cfz7ZOmbNEOilXKIiLZw>
    <xme:6_rcZVsqWWjy7ohwlerWF0HARe7Sq5Dz_Wsfdx1wBOAcJhHVe6193i3U9g6Ikffq6
    JWrtOwfql3LOwe6xQ>
X-ME-Received: <xmr:6_rcZfAiSXdKgUtIkaPCjzLq2cHWNxVNSLstZrfGuuZHeq8oLwSkYeJwjif63fmWBTNkXIM6MecZQM5w_RLpDclPBD-j6m-KP2IOVg5i42COTJ0H5dSAGZdG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:6_rcZVfsqhmn2SL_dVbzPs5MmRfIav2Ol_labDQnmABP8B9tISYnOQ>
    <xmx:6_rcZWOPlAyZ-GpkbhCqeq--PFCqetp5lAvHbL6zS0UvNBvCK6TWYA>
    <xmx:6_rcZXmbPl7_1mpMjHR_OLYdlPKe0Vk4Le2dZ7-JFdR9ltE-ZBWpmQ>
    <xmx:6_rcZbytBVtTkNh8e14VcSdGq_xBiB98Y30tH-cHnJoPwLWfQb2nsw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 15:56:10 -0500 (EST)
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 3/8] mm/memcg: use order instead of nr in split_page_memcg()
Date: Mon, 26 Feb 2024 15:55:29 -0500
Message-ID: <20240226205534.1603748-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226205534.1603748-1-zi.yan@sent.com>
References: <20240226205534.1603748-1-zi.yan@sent.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/huge_memory.c           | 5 +++--
 mm/memcontrol.c            | 3 ++-
 mm/page_alloc.c            | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

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
index 9840f312c08f..96ac7c62c375 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2889,11 +2889,12 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	struct lruvec *lruvec;
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
-	unsigned int nr = thp_nr_pages(head);
 	int i, nr_dropped = 0;
+	int order = folio_order(folio);
+	unsigned int nr = 1 << order;
 
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, nr);
+	split_page_memcg(head, order);
 
 	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
 		offset = swp_offset(folio->swap);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 95c3fccb321b..1a09f0e77c44 100644
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
index 96839b210abe..a7a96bc97e0b 100644
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
 
@@ -4840,7 +4840,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, 1 << order);
-		split_page_memcg(page, 1 << order);
+		split_page_memcg(page, order);
 		while (page < --last)
 			set_page_refcounted(last);
 
-- 
2.43.0


