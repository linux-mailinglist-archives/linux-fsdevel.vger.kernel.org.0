Return-Path: <linux-fsdevel+bounces-12876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F01868237
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0801C23609
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DEB132496;
	Mon, 26 Feb 2024 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="PsGtgEud";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXQaLIK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207113173A;
	Mon, 26 Feb 2024 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980975; cv=none; b=adio0bnwDO7zp9R+ZmuCsQ/KdMWV6jjod1IuwIV+zKJxgMM1rCZhe1zb7bz2JYl4oEcvmT0ze9uGu7aQXJZxjgICezpqueMDQ6eiQc1TomjOtAKkLnWOW8DshKdS+Z1zzBNzKuRz+d6XkT4wkaOXI1LPSE0Pc1Hpn4XOu6NLfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980975; c=relaxed/simple;
	bh=HbrSwnkkjzgDPr9Qqs/XsufXHKtUIzBk6wsYMI1kzqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZFTAulElikRLo8Aaybe96XnzAE8A7B/OZRPl6QkejgnPKADrxKakUA3iWIZCa8HtIENNhx6HoDnZcfEQ+r2/dOWORhcnLaelkPzdwoImPrOD12rlK+zUQSTsxkUcGDCGzNJ+FMhqi52w1EyGlMOwn6hjnGzpCwoBLYIfWo7qPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=PsGtgEud; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXQaLIK2; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 845035C0083;
	Mon, 26 Feb 2024 15:56:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 26 Feb 2024 15:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708980972; x=1709067372; bh=k4tW1Ix2BuSNkN1WHXYSmN5X0ZeSMgYeZ0g
	G0yp9vIY=; b=PsGtgEudtl5OWZIMN/QmYcFTzFIwskYJv2SShnXgHjfbIBRHd6c
	tLFxkANerh0TDSw0aIJ+BRFw3TtwrtnEWmHqtjReaka5XRT4kCVu+/JxTHJUARVP
	TTaS/ervzETdMoGvlOvQkGU5Vr8k5tDe2HWq4O22UqWyxXceqtEs8oF4xp6w3ILj
	E+Nn7cDMv2KP+WObR1wfXgZt4SVjLn62IgkbUTVyraMDgD4LC0tnPeSgCrhiQXlI
	dpijTzey8JMArvsD76watmwYOLbgBoLoa6lmS0djEggreXdhpxLkoa+zAeqDTiVh
	XpV3/H7xUFtWwTsw2W+RLI8tAthTa0kVP7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708980972; x=1709067372; bh=k4tW1Ix2BuSNkN1WHXYSmN5X0ZeSMgYeZ0g
	G0yp9vIY=; b=MXQaLIK2tOLWX7tSDG9quAtyz0XtE5uEWLvjXAt6WWz4fuCtIq+
	iW5V2mlkR6XtmBDh4IXp0NZH4C8YwuqKervIeM/9EVpHBYcPoWcIkSre/3nQS4z4
	deN9QC9eqGj98qO7roEFIt9SV8tO7akXARi4gsDw06jxzAwz5zubvukbV7i4gDO/
	zRNBPrfZQzljXqj9vbHt0+V2dLDxewtoVWSQgxCBKRL013TC1g1nj0dxzgkun57/
	ZLz8/iUoCZO+anVVQtkHxMUVyw526I4oYS5ikt412Vg+KTvUHxFRAI9uUJp+t7bp
	th0cOJ+ulQTE92LtOYFZ9c3xS3VyDo9UjLA==
X-ME-Sender: <xms:7PrcZU0ifJ4I5pZNbW2NZYN6H3I9UUxki66zGT02yaSocSopZ4iSLA>
    <xme:7PrcZfHkna47spKk2MIVO1mvaOBBGLMfDrKusGknW4XaomOCJNBAZBZ5ouIOszQok
    iH_B-1rg4EzsF4Cmg>
X-ME-Received: <xmr:7PrcZc5YdzjJkD6nMCavHOZ-pRPMLO6wqZd_qEVMsJ-mwUYIjW_wYLF1O9joVoD1fvyG2mD_LC7dHZ4c5BsshCULb0RlezzHIbaFZZ5DH1faQNue3fOt26XU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:7PrcZd1PZQtwQ2j6frYdjibybcNgIfA-565Sop4WbwdFCI61-BIdUQ>
    <xmx:7PrcZXFT42FNg6FwhBuzIn6aqcWYCHPiMJTvJ9n7b5I8_1cvLH6Wcw>
    <xmx:7PrcZW-p1FUxAGvmuOwNcIWKZZL8piXgbbrsRcrmtmbuEUUFFZ__jA>
    <xmx:7PrcZYLZUlOSFD3Sa2LBosbwe86fzuUF9nEUYN4V2WeOmPik1pCPWA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Feb 2024 15:56:11 -0500 (EST)
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
Subject: [PATCH v5 4/8] mm/page_owner: use order instead of nr in split_page_owner()
Date: Mon, 26 Feb 2024 15:55:30 -0500
Message-ID: <20240226205534.1603748-5-zi.yan@sent.com>
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
 include/linux/page_owner.h | 9 ++++-----
 mm/huge_memory.c           | 2 +-
 mm/page_alloc.c            | 4 ++--
 mm/page_owner.c            | 3 ++-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 119a0c9d2a8b..2b39c8e19d98 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -11,7 +11,7 @@ extern struct page_ext_operations page_owner_ops;
 extern void __reset_page_owner(struct page *page, unsigned short order);
 extern void __set_page_owner(struct page *page,
 			unsigned short order, gfp_t gfp_mask);
-extern void __split_page_owner(struct page *page, unsigned int nr);
+extern void __split_page_owner(struct page *page, int order);
 extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
 extern void __dump_page_owner(const struct page *page);
@@ -31,10 +31,10 @@ static inline void set_page_owner(struct page *page,
 		__set_page_owner(page, order, gfp_mask);
 }
 
-static inline void split_page_owner(struct page *page, unsigned int nr)
+static inline void split_page_owner(struct page *page, int order)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__split_page_owner(page, nr);
+		__split_page_owner(page, order);
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)
 {
@@ -59,8 +59,7 @@ static inline void set_page_owner(struct page *page,
 			unsigned int order, gfp_t gfp_mask)
 {
 }
-static inline void split_page_owner(struct page *page,
-			unsigned short order)
+static inline void split_page_owner(struct page *page, int order)
 {
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *folio)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 96ac7c62c375..2b95dbc95fae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2933,7 +2933,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
 
-	split_page_owner(head, nr);
+	split_page_owner(head, order);
 
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a7a96bc97e0b..eae77e76a671 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2652,7 +2652,7 @@ void split_page(struct page *page, unsigned int order)
 
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
-	split_page_owner(page, 1 << order);
+	split_page_owner(page, order);
 	split_page_memcg(page, order);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -4839,7 +4839,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *page = virt_to_page((void *)addr);
 		struct page *last = page + nr;
 
-		split_page_owner(page, 1 << order);
+		split_page_owner(page, order);
 		split_page_memcg(page, order);
 		while (page < --last)
 			set_page_refcounted(last);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index e56c1e92eccf..b678f7a6e702 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -306,11 +306,12 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
 	page_ext_put(page_ext);
 }
 
-void __split_page_owner(struct page *page, unsigned int nr)
+void __split_page_owner(struct page *page, int order)
 {
 	int i;
 	struct page_ext *page_ext = page_ext_get(page);
 	struct page_owner *page_owner;
+	unsigned int nr = 1 << order;
 
 	if (unlikely(!page_ext))
 		return;
-- 
2.43.0


