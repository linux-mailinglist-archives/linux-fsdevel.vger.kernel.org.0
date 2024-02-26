Return-Path: <linux-fsdevel+bounces-12874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFFD868230
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E445A28994F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD98131E50;
	Mon, 26 Feb 2024 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="T5xeqRqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bp4JhDO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1223130E3E;
	Mon, 26 Feb 2024 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980973; cv=none; b=kYmAGOTe7d4JbKWZfhjQwrkKef55gXew71DavrRWFJIjG6fgNy7SyktUS7A17KxB0wSP6zduxKZHTWg7IWyqb7ia+TSIMVCpIUD/CBIXKSqd5sBc60080gd0cEFwQfdBkbMQuoVnUVIdli6R/Et91ireEw4EWi9xZGOmFJjmQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980973; c=relaxed/simple;
	bh=6UZCu34iqxVetVOw3hYJVWt8DkK1Q3+qX0MxlTlzkTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVLYRZpiSJ0mc0HCbsA+DjYr397x0l+v2shA9Qn0KyguF5HahBNCQWTGean2fpgHj085kBoheAo3Ce7WMeRnF4QkCRP9MOOokGBfy/abZzNJ11K3oT+5Okf3NzLUEHIOq+nvMHfheMUVMnW5rjIflZfDPhe+c+ZwfzYWF5ST9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=T5xeqRqY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bp4JhDO6; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id CE54C5C00A4;
	Mon, 26 Feb 2024 15:56:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 26 Feb 2024 15:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708980970; x=1709067370; bh=ODE0ROICHsjD0yZP7iLxwoRZvmdJZzbZs1w
	Z6FX7X9k=; b=T5xeqRqYOCyBPMLYOa3Br+G8KABMxRYqzZHOqItB1AZrzBWc5++
	v+Y7er2Z+fEtOY1M/UnNBzfbkuRk6ewQ6+GDS0M+g8TVhKmRbqYnUvTSSYENgpdl
	12S7nVi060wPvZWE00vlxyzNriF+sFFCE/S+KC5feMd22qZNmgdU3fy5tMtsHfvV
	HT2RBYHADtA7sl/kk2Myd4K/s/xtjY5JP3jJkKGHEW4wIWZnQzJzlBw4hVValEJI
	pF1ogC001UIVIud1NFAAmMHBXEFLAMxinZXdOZVBdBQDgReZA/38hv+a2tRczoQt
	LOte/EUa97kieD8yiSWrp9rgQ2oOOQERj3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708980970; x=1709067370; bh=ODE0ROICHsjD0yZP7iLxwoRZvmdJZzbZs1w
	Z6FX7X9k=; b=bp4JhDO6+sHuaMDjp3R19HRVAcTJ3cT1Z+YMXxBHek2OtVWeSIe
	bSoGWccfFZxHU/vp1hRV/Wx+/NGe2Nwi5VqPnD17ZmX+OO0h9nYYxtd5cYNsJpSZ
	k6g2gwk3TgcZZC/YqlkL5NwFr75VwxrFdHv/h4jJiey1C3KamfbEuZhqUTmIB1gT
	VqM+UEkjuQX2hgvT083qH5JYaQ5FeWxw3SNFXooaEzMoAAkw/w+VQ0Z7HSqLEbl8
	wYgwWMCVwHlAZFQ5egIrbRKFj6xvh9Sln31XLTY/XDq2FTFETb5D5nn822mnX2BK
	oyJKkW5yKnszzEI9XSdKRE0NE9iNtLkdlEA==
X-ME-Sender: <xms:6vrcZYFe3Yldi8VGj0J4j3_AyJog8Xt4uM8pk47LtuaNCmgnLCCZkg>
    <xme:6vrcZRU_C9uWLmPZ2YLCqxAScXt7L-kAARU3P3t3rqLRKrC3Kchy-P6X5BEbLYNl7
    27JTyq_YrB__BukKg>
X-ME-Received: <xmr:6vrcZSISM7Oo1Nu1BWqOAEWKOU35anBm1KoWmoRwzVDXJJYEis60M1K9UmOP7WBsqpIoxpcGGn55CPM2Y3-_JdxFhcxl3Y3dUNYQtlInUqNHow_Cs-JL2QaF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucdnrfhurhgthhgrshgvucdluddtmdenucfjughrpe
    fhvfevufffkffojghfrhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggrnhcu
    oeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeettdekjeffke
    ejudelhfeuteekieejieehjeefvdefiefhteevgeejheegkefggfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:6vrcZaGwRKf_w5frOA90i49CKbEsl0SxHYzObzwCMSR7l9tkBinF-g>
    <xmx:6vrcZeWen53UAhkbLRBIdDsW0EA_0-caYMUKPYkR98WRMLZATdE5Qg>
    <xmx:6vrcZdMBuxdwv0JEFAMua9q9Hw62vJ_8C9ZzdjlYi6hwi2AMvEM66nqxBnsY2s0>
    <xmx:6vrcZcbnE0TO7PBM6HhyDsWaWCKMerbh1APMOOhAN1YGtAcOanz-1g>
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
Subject: [PATCH v5 2/8] mm: Support order-1 folios in the page cache
Date: Mon, 26 Feb 2024 15:55:28 -0500
Message-ID: <20240226205534.1603748-3-zi.yan@sent.com>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Folios of order 1 have no space to store the deferred list.  This is
not a problem for the page cache as file-backed folios are never
placed on the deferred list.  All we need to do is prevent the core
MM from touching the deferred list for order 1 folios and remove the
code which prevented us from allocating order 1 folios.

Link: https://lore.kernel.org/linux-mm/90344ea7-4eec-47ee-5996-0c22f42d6a6a@google.com/
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/filemap.c     |  2 --
 mm/huge_memory.c | 19 +++++++++++++++----
 mm/internal.h    |  3 +--
 mm/readahead.c   |  3 ---
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b7a21551fbc7..b4858d89f1b1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1912,8 +1912,6 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp_t alloc_gfp = gfp;
 
 			err = -ENOMEM;
-			if (order == 1)
-				order = 0;
 			if (order > 0)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
 			folio = filemap_alloc_folio(alloc_gfp, order);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b20e535e874c..9840f312c08f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -790,8 +790,10 @@ struct deferred_split *get_deferred_split_queue(struct folio *folio)
 
 void folio_prep_large_rmappable(struct folio *folio)
 {
-	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
-	INIT_LIST_HEAD(&folio->_deferred_list);
+	if (!folio || !folio_test_large(folio))
+		return;
+	if (folio_order(folio) > 1)
+		INIT_LIST_HEAD(&folio->_deferred_list);
 	folio_set_large_rmappable(folio);
 }
 
@@ -3114,7 +3116,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
-		if (!list_empty(&folio->_deferred_list)) {
+		if (folio_order(folio) > 1 &&
+		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
 			list_del(&folio->_deferred_list);
 		}
@@ -3165,6 +3168,9 @@ void folio_undo_large_rmappable(struct folio *folio)
 	struct deferred_split *ds_queue;
 	unsigned long flags;
 
+	if (folio_order(folio) <= 1)
+		return;
+
 	/*
 	 * At this point, there is no one trying to add the folio to
 	 * deferred_list. If folio is not in deferred_list, it's safe
@@ -3190,7 +3196,12 @@ void deferred_split_folio(struct folio *folio)
 #endif
 	unsigned long flags;
 
-	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
+	/*
+	 * Order 1 folios have no space for a deferred list, but we also
+	 * won't waste much memory by not adding them to the deferred list.
+	 */
+	if (folio_order(folio) <= 1)
+		return;
 
 	/*
 	 * The try_to_unmap() in page reclaim path might reach here too,
diff --git a/mm/internal.h b/mm/internal.h
index 2b7efffbe4d7..c4853ebfa030 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -420,8 +420,7 @@ static inline struct folio *page_rmappable_folio(struct page *page)
 {
 	struct folio *folio = (struct folio *)page;
 
-	if (folio && folio_order(folio) > 1)
-		folio_prep_large_rmappable(folio);
+	folio_prep_large_rmappable(folio);
 	return folio;
 }
 
diff --git a/mm/readahead.c b/mm/readahead.c
index 1e74455f908e..130c0e7df99f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -514,9 +514,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		/* Don't allocate pages past EOF */
 		while (index + (1UL << order) - 1 > limit)
 			order--;
-		/* THP machinery does not support order-1 */
-		if (order == 1)
-			order = 0;
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
 			break;
-- 
2.43.0


