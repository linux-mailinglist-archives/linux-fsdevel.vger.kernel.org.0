Return-Path: <linux-fsdevel+bounces-12878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2D86823F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F70B20FE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868213329E;
	Mon, 26 Feb 2024 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="iQ1P+dj1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCNXSmar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C88132466;
	Mon, 26 Feb 2024 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980976; cv=none; b=cxN2InN0wWrPpPwy67s894h/sP00tOwyT4QtttVuG8zUpviw6TH69cywDFCxDEg5C8YCOr7rqUjATiE5xTtpUO0KIVwCgmmAW+iq1nj6SUIWuCYQzZmI7epEpJ5nr+gLHex5F0Bo+F6AiLBdVaKS5F461H5I4m9pjkwxWkzlY48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980976; c=relaxed/simple;
	bh=ZtZL/AFG8WZ7Dh5a7UohfkhMN1n6gq+cssXbZdxud4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFu3ByB/Y+uRpdp6BEpfze6iouc/1jNFpS/k2MHLxx4AW/PF08BfMoj8S2tOr36saQdG0A1tVck5y0enFcvdVR3dxXWXAqwHGU1JrlnOPHGg4m+tBUde6WHF/5RSmCm+0LcRQkXKBT+dF0xyGqEraA7+8s7RFwQCZaQAgknqgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=iQ1P+dj1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RCNXSmar; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 3360F5C00A7;
	Mon, 26 Feb 2024 15:56:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 26 Feb 2024 15:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708980974; x=1709067374; bh=364J4ng7aCg7Ddk79ejWdMNIz/yxFIeeqLK
	xisnieh8=; b=iQ1P+dj1L5/s3YJc1AKNrz35Mc/c79OX4NJp+G2orPz4GZ+6LiT
	Xl80k8xN21LpRMCUqHw/bricLLciGXJIDhrpnfKRnRXASyRj/2JSFN4K2fnQmLx4
	FrzLW8FJUFxwuspkQ+PUdlePmPKJMPJKJuOxU18xO+9IBaOUczy0YQ501H9uXZF7
	yx+zV3HFZazJhvZBqCxEJGTRstJ62E0PRnmswRs//ZJfMZigtnVa05ZfTxNl99hp
	F8TOxc0B9R/IzTp9ciw0z9o7/Obsa81fnnA9hPtSqKwfaqlQoIevp1JrNLQSMGyV
	UresGBjCtv29Vl3UPpQRa8D52ukRMbrzjZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708980974; x=1709067374; bh=364J4ng7aCg7Ddk79ejWdMNIz/yxFIeeqLK
	xisnieh8=; b=RCNXSmarRVqb3zv0tke5KZ3fUqf35Wlyl/Cana7FlGKAfeYU0Ni
	dojnphIkoCOr6OVG+Q2G4sxIQUcSOXY83fToHjB7zmqXFd61QY9M76vppmNyHcUA
	9iRsIYi4cifrC6kHwcuTkhhUeeBeNkoqREbH4PP5nNsVc/FJnHFzqwxsASyU0Z2D
	HqAU3Xz/RIx9Bl7KKQpGkXgXg6PAao9Uas+FDGZcTWJf1E/Itn0q00daT+qTAJAu
	ZoaTWwAZ7CXgZECYTmPAYAFxhLwBEF3hFD3Oj9PeW2CChuj8fy8S6k1KaqtO/+md
	TCQZPteVnqHYenzMsDE7tB8TNyNqb2EoIsA==
X-ME-Sender: <xms:7vrcZU3VNa__jCwseLSReiwHMgtxoFpgUwZStwxg-Qd_RLrH9h3TCA>
    <xme:7vrcZfEbgaibsSNI8V5M2ltmWzCGT_0cxxGGumqx6_rcP7EfhyjSgGgw1doZF4T38
    eLURMgYru2jQTEu3g>
X-ME-Received: <xmr:7vrcZc7Dn3Xc6LNxhroBiWWDSyZJ70V--f8pX6SWDzsPWie4egrTTSZy84xR95gqZNKmUZDquBf-6SMpMHRjAMd2LiGxHk1leAt9ecswjqPlmVczlD2_hOhn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:7vrcZd3evAnlillLhx_6_Vp97OlVds7YPQkWbyWAvqJdN4RCf5nrDg>
    <xmx:7vrcZXE2pSvrpvtDWnJ8Qsecmga2-1fTB_faERnxuIBw1AFzI2rryQ>
    <xmx:7vrcZW9QVLM0YfSbhnYGc51I-GXSwQtaCwOLQgIltLM2fVuLnEpDKA>
    <xmx:7vrcZYII5zB4Wkc7jLYX3uOQ_c_OTxunieDdOl4lJOHfcRmAp-76jg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 15:56:13 -0500 (EST)
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
Subject: [PATCH v5 6/8] mm: page_owner: add support for splitting to any order in split page_owner.
Date: Mon, 26 Feb 2024 15:55:32 -0500
Message-ID: <20240226205534.1603748-7-zi.yan@sent.com>
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

It adds a new_order parameter to set new page order in page owner.
It prepares for upcoming changes to support split huge page to any
lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page_owner.h | 13 ++++++++-----
 mm/huge_memory.c           |  2 +-
 mm/page_alloc.c            |  4 ++--
 mm/page_owner.c            |  7 +++----
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 2b39c8e19d98..debdc25f08b9 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -11,7 +11,8 @@ extern struct page_ext_operations page_owner_ops;
 extern void __reset_page_owner(struct page *page, unsigned short order);
 extern void __set_page_owner(struct page *page,
 			unsigned short order, gfp_t gfp_mask);
-extern void __split_page_owner(struct page *page, int order);
+extern void __split_page_owner(struct page *page, int old_order,
+			int new_order);
 extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
 extern void __dump_page_owner(const struct page *page);
@@ -31,10 +32,11 @@ static inline void set_page_owner(struct page *page,
 		__set_page_owner(page, order, gfp_mask);
 }
 
-static inline void split_page_owner(struct page *page, int order)
+static inline void split_page_owner(struct page *page, int old_order,
+			int new_order)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__split_page_owner(page, order);
+		__split_page_owner(page, old_order, new_order);
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)
 {
@@ -56,10 +58,11 @@ static inline void reset_page_owner(struct page *page, unsigned short order)
 {
 }
 static inline void set_page_owner(struct page *page,
-			unsigned int order, gfp_t gfp_mask)
+			unsigned short order, gfp_t gfp_mask)
 {
 }
-static inline void split_page_owner(struct page *page, int order)
+static inline void split_page_owner(struct page *page, int old_order,
+			int new_order)
 {
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *folio)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5d4b7c17b9bc..b2df788c11fa 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2933,7 +2933,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
 
-	split_page_owner(head, order);
+	split_page_owner(head, order, 0);
 
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c31a468fe317..cc41341c08f4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2652,7 +2652,7 @@ void split_page(struct page *page, unsigned int order)
 
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
-	split_page_owner(page, order);
+	split_page_owner(page, order, 0);
 	split_page_memcg(page, order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -4839,7 +4839,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *page = virt_to_page((void *)addr);
 		struct page *last = page + nr;
 
-		split_page_owner(page, order);
+		split_page_owner(page, order, 0);
 		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index b678f7a6e702..033e349f6479 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -306,19 +306,18 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
 	page_ext_put(page_ext);
 }
 
-void __split_page_owner(struct page *page, int order)
+void __split_page_owner(struct page *page, int old_order, int new_order)
 {
 	int i;
 	struct page_ext *page_ext = page_ext_get(page);
 	struct page_owner *page_owner;
-	unsigned int nr = 1 << order;
 
 	if (unlikely(!page_ext))
 		return;
 
-	for (i = 0; i < nr; i++) {
+	for (i = 0; i < (1 << old_order); i++) {
 		page_owner = get_page_owner(page_ext);
-		page_owner->order = 0;
+		page_owner->order = new_order;
 		page_ext = page_ext_next(page_ext);
 	}
 	page_ext_put(page_ext);
-- 
2.43.0


