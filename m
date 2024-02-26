Return-Path: <linux-fsdevel+bounces-12877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7829286823B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F41C23D89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E9E132C26;
	Mon, 26 Feb 2024 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="G0xdGaA+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pUr2/5uN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D5A131E3A;
	Mon, 26 Feb 2024 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980976; cv=none; b=MxtOThdKyyLgGZxiiPqsjfzf3dHDvUc/PnaRdwjA2wos6Y0/uwI2iWs3AijMJyef2Awhu/uXnt0O48WK48EKcWQSO+yaViuLK2JobeoPKuAZWSBSHRsgPKn9ZjhPS/2gTbWL9PI5Zbd9p5nXUR4Wlt6Sxj9vBN2g67+ThG5vN8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980976; c=relaxed/simple;
	bh=tQ/FHG8XnUwWFx1UmtP5Vr1SwbTk4PDYio7TLDjvkVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGFF3ev/9elZ5rHsIbMjdMSTJvjbCFcEj6sy2AdW5PdM+wvUr5tfz/8mqemNNOZ4eLuA74KypLQEL2RV0chgKktPFAIMZIDh6oZg9rLPIuCqrXKql8DVaJ0ihhObseMonN8jxB0af0xoY/hYMW63js+vMldD+MveCGjzbglVJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=G0xdGaA+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pUr2/5uN; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 5D5415C00A6;
	Mon, 26 Feb 2024 15:56:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 26 Feb 2024 15:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708980973; x=1709067373; bh=7C1YvLv3wVMtcqo8/X9e6+Vvqy6Z7pLbOms
	0IX3NOhM=; b=G0xdGaA+uEkADF+wiXa48pt3PQhHb+De9LVKL4DkWp2f+BkyswB
	Xn0t6TOeQSMlGCZdWmNVwylDGYEGktrxuMzFQ6HjOK0MgYNC/7rkylv7Zf+1m5hz
	WNatQYLZu4uE3JehluNE2U1hIC66n0giMdDi9+Dw1BhO1Ndg1P82kkDw8ZleMrtm
	U8A4n7JXXdSwUD4c4a3Ujlj5O3YEjmLM9MAPwBym1VgjGgJyWjEtFDOot+p3UklT
	HD4LQVHaNLIlmjhmMVr1SI/xsVtZ7vCbEiu6KIwctGI9/rAX38UwjVN8OY/1io20
	RqLO8O8vhG7XRsTaPZjD+bm5Fgt+VbrLghw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708980973; x=1709067373; bh=7C1YvLv3wVMtcqo8/X9e6+Vvqy6Z7pLbOms
	0IX3NOhM=; b=pUr2/5uN/u4JfGEQtK5c/fXMKwAQ1WngoArkr9zDevWWHLryFC2
	+D9ry22gMXo9f5eRO4YyqaeFMMZHFj84Cv6cgMhfxiQIi0/0XSQ83NhjHGbF+CXm
	PZvsiMitxw6gqKPR62nWCTs/I1sLcl0aUjVClavOJ5CWyDFz8+YcmtJY6+oz5ZcU
	7j8/Tzrq/ObfcsJ5RuinS2fSzLBOVEeBxv2iiDl0uOxuXBrstQHXJW2+3iu9Kf0H
	uf8RzWoc+ZGH9l3aKlRJFL6qKLp0Omq0O/7Lv6QvdzHaBH7ziXbcBJ09Ee3iI4fc
	qLjBZ3qTLfgOzj1Afn7XMInHh76ed8My0/A==
X-ME-Sender: <xms:7frcZV52btuKwU0laz_HHojOZAXrHWZuyasSTYn4c6zOG0btCkB6WQ>
    <xme:7frcZS72_pbJJH1Q5va5M3zmzelc76gwZAcUK4cW0TqS7vf-W8_r3IM3j_MmiGxWP
    e-XNKUtdMTZ47TROA>
X-ME-Received: <xmr:7frcZcd9hCleiX-2qPHmwJ3guHiGc8kiHbXxJXsqV7iupmgoLyDzWLxO6fCpFNPJNEAEveAVtQl6MbNZp00Kigs5YPazftBAFiyW2iM-LKS2SA1RSDM4RHzF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:7frcZeLDwYCGkeBaNakec_WgWoBz46m3sFQNZoha-VNqSiDFSWHsAw>
    <xmx:7frcZZI3GbUqGDmxo9mtSri9qvV9DgeLxZEhK7bYT_kP0SIIcN4EZg>
    <xmx:7frcZXxxKBsjnMJtbCV_TnwD-3LN-_d2BthdM0X7bjpFVCWEIlSyJg>
    <xmx:7frcZWccrUmzVXSlb-OcBkoNFUPGWUqSrkdXxBhkKPnjtD7MoaLtPg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 15:56:12 -0500 (EST)
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
Subject: [PATCH v5 5/8] mm: memcg: make memcg huge page split support any order split.
Date: Mon, 26 Feb 2024 15:55:31 -0500
Message-ID: <20240226205534.1603748-6-zi.yan@sent.com>
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

It sets memcg information for the pages after the split. A new parameter
new_order is added to tell the order of subpages in the new page, always 0
for now. It prepares for upcoming changes to support split huge page to
any lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memcontrol.h |  4 ++--
 mm/huge_memory.c           |  2 +-
 mm/memcontrol.c            | 11 ++++++-----
 mm/page_alloc.c            |  4 ++--
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 173bbb53c1ec..9a2dea92be0e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1163,7 +1163,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 	rcu_read_unlock();
 }
 
-void split_page_memcg(struct page *head, int order);
+void split_page_memcg(struct page *head, int old_order, int new_order);
 
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
@@ -1621,7 +1621,7 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
 }
 
-static inline void split_page_memcg(struct page *head, int order)
+static inline void split_page_memcg(struct page *head, int old_order, int new_order)
 {
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b95dbc95fae..5d4b7c17b9bc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2894,7 +2894,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unsigned int nr = 1 << order;
 
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order);
+	split_page_memcg(head, order, 0);
 
 	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
 		offset = swp_offset(folio->swap);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1a09f0e77c44..669bc8de3780 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3608,23 +3608,24 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 /*
  * Because page_memcg(head) is not set on tails, set it now.
  */
-void split_page_memcg(struct page *head, int order)
+void split_page_memcg(struct page *head, int old_order, int new_order)
 {
 	struct folio *folio = page_folio(head);
 	struct mem_cgroup *memcg = folio_memcg(folio);
 	int i;
-	unsigned int nr = 1 << order;
+	unsigned int old_nr = 1 << old_order;
+	unsigned int new_nr = 1 << new_order;
 
 	if (mem_cgroup_disabled() || !memcg)
 		return;
 
-	for (i = 1; i < nr; i++)
+	for (i = new_nr; i < old_nr; i += new_nr)
 		folio_page(folio, i)->memcg_data = folio->memcg_data;
 
 	if (folio_memcg_kmem(folio))
-		obj_cgroup_get_many(__folio_objcg(folio), nr - 1);
+		obj_cgroup_get_many(__folio_objcg(folio), old_nr / new_nr - 1);
 	else
-		css_get_many(&memcg->css, nr - 1);
+		css_get_many(&memcg->css, old_nr / new_nr - 1);
 }
 
 #ifdef CONFIG_SWAP
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eae77e76a671..c31a468fe317 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2653,7 +2653,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, order);
-	split_page_memcg(page, order);
+	split_page_memcg(page, order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
 
@@ -4840,7 +4840,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, order);
-		split_page_memcg(page, order);
+		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);
 
-- 
2.43.0


