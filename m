Return-Path: <linux-fsdevel+bounces-11456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02991853DCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272A71C2188C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B892C6312F;
	Tue, 13 Feb 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="yYAQgjcj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bMCcmwqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D268626D5;
	Tue, 13 Feb 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861353; cv=none; b=DNwaTxYaUsicxjXAOakZhlybrhlZg2b018ETyBk/VZ0IASycSuakCTAaMokXHjmlCsx/tnjg1LEBEjB6YyltamRKuoB6CEDaoOTVwdbDpiLHla4qZJpT+3vunOmT3ouxNh7I2TZHHCDg9+08dfOFIp6I2qIao2e1MUzDW4ZVxwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861353; c=relaxed/simple;
	bh=VGiJshFlzfJTNo+URBKg1KnL/Ou65I9YBkQp0I3HlGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttDoqXW3MXfYHBt7HBrJ8Lh89VHag67JgwUO8BMmNzTfjlKCLkZh8FEpI7HAYNvoE+SLxNPAglZYMB+oD/o7BmukjccKlsxRqo9E367ANnhZpIxrMLUf1XQskfU+kGSlOtZAZBdfP+GNkzusj9c/Fcef1lyNir+yjFqInYOTjyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=yYAQgjcj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bMCcmwqi; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 2BFDE5C0114;
	Tue, 13 Feb 2024 16:55:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 13 Feb 2024 16:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1707861350; x=1707947750; bh=DFD67uQnb+ulb8US39wkV47wjWKTPIuVZ3E
	M1gZxQmo=; b=yYAQgjcjAjFkviiP5bDanth4ua6xtOef0fKzglSx07B9qGYi4dU
	mPqMNB+SAAhrcBNQAN/KKoYP2UPpagFwfqCyVHPlnH7gmgbi6z9CLg/dYiJ8JF0g
	j3iZGL7breFfiA0Q+JqtaRwazEhflTjXY9a7tfB+iefqXsUMySJOOwzZS1i0ThPY
	lL/XoDxyTlaXoCDtZXMNEoef0LMMKkKzPvFg6MBITMX182wUCADfrwVnru1eFfb5
	B2NZ20NtFl3uKbAZqI2BC+GkMjhPc6z9bcHqG4bPHQseCdZfwmJAMnINX2Ay48C5
	Lie+IbPo4PaG+33kaocLN+5h7sZUeVPONdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707861350; x=1707947750; bh=DFD67uQnb+ulb8US39wkV47wjWKTPIuVZ3E
	M1gZxQmo=; b=bMCcmwqij0ogO6M9GovWN06DDA9lmOzsRXUQ61nkq8KevW/A5rH
	VRaHwVra8JutQ9WL90i+sPClYOXvFHmA6KPK+C0nfApz8y3ISz/oBcygKF+/s0Mm
	akx1a2AGUdLT8mJDekRmk+DIOY2njm64l4iIb6i4KvOL2OVtYCGDqXZYsHCgO9yd
	2ZzR5BcYQrI1iLNVzysnwfR10n+8hePLkZT17+ReRFaIDVxiABMDAM+ie7qreYqn
	tU21tFmNAV6R93PrejHiUOQBkR1cUTnd8p1r6/RITbkIHOQT7gsLlzaGOPu/ffTe
	KLm2OrTFVnzTGguYUazByunjCCRKq6/KZnw==
X-ME-Sender: <xms:ZeXLZQx8Zrz-yNo1DbksiFNli8URUfZAXNPTfI-cAYu75ogXjaA-AQ>
    <xme:ZeXLZUS1G1ZEImJZEknPU8EvwDitzUKcNfwRxhMQOQaofDtEJ2p_3C2boJr5hVWnL
    4DLqTIQPGg_k6S_1Q>
X-ME-Received: <xmr:ZeXLZSWet5hahhEFP4JKtbOPTxLheATVJMj5kB-942oLHnyYwSwwd0kCguWkFDnXaKxJpY09V1aBohRSQnGHrVaddJiKMEMmXRZBZWe5KBZDACUzc9GGOpKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:ZuXLZej_QiNwohp9PD7Wn7x1ikRn4XaFK5b-lX0fyplD7ls-f3lC0A>
    <xmx:ZuXLZSAqlYvOr0MGaki9prTXsg4h0xJT8VMLN68iiU0WWz3OrUPU9Q>
    <xmx:ZuXLZfJLwoi4HBaPEPi0utO7KnKRxXonkZLxbceWSSdearnIcqVFdQ>
    <xmx:ZuXLZa3Qvgn5H6hLAbZLuMGRxc5_H2Fqi9uw1FaXq-xqEhk-tFDSgg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 16:55:49 -0500 (EST)
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
Subject: [PATCH v4 4/7] mm: page_owner: add support for splitting to any order in split page_owner.
Date: Tue, 13 Feb 2024 16:55:17 -0500
Message-ID: <20240213215520.1048625-5-zi.yan@sent.com>
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

It adds a new_order parameter to set new page order in page owner.
It prepares for upcoming changes to support split huge page to any
lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page_owner.h | 10 +++++-----
 mm/huge_memory.c           |  2 +-
 mm/page_alloc.c            |  4 ++--
 mm/page_owner.c            |  9 +++++----
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index d7878523adfc..a784ba69f67f 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -11,7 +11,7 @@ extern struct page_ext_operations page_owner_ops;
 extern void __reset_page_owner(struct page *page, unsigned short order);
 extern void __set_page_owner(struct page *page,
 			unsigned short order, gfp_t gfp_mask);
-extern void __split_page_owner(struct page *page, int order);
+extern void __split_page_owner(struct page *page, int old_order, int new_order);
 extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
 extern void __dump_page_owner(const struct page *page);
@@ -31,10 +31,10 @@ static inline void set_page_owner(struct page *page,
 		__set_page_owner(page, order, gfp_mask);
 }
 
-static inline void split_page_owner(struct page *page, int order)
+static inline void split_page_owner(struct page *page, int old_order, int new_order)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__split_page_owner(page, order);
+		__split_page_owner(page, old_order, new_order);
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)
 {
@@ -56,11 +56,11 @@ static inline void reset_page_owner(struct page *page, unsigned short order)
 {
 }
 static inline void set_page_owner(struct page *page,
-			unsigned int order, gfp_t gfp_mask)
+			unsigned short order, gfp_t gfp_mask)
 {
 }
 static inline void split_page_owner(struct page *page,
-			int order)
+			int old_order, int new_order)
 {
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *folio)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3d30eccd3a7f..ad7133c97428 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2919,7 +2919,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
 
-	split_page_owner(head, order);
+	split_page_owner(head, order, 0);
 
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9d4dd41d0647..e0f107b21c98 100644
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
@@ -4837,7 +4837,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *page = virt_to_page((void *)addr);
 		struct page *last = page + nr;
 
-		split_page_owner(page, order);
+		split_page_owner(page, order, 0);
 		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 1319e402c2cf..ebbffa0501db 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -292,19 +292,20 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
 	page_ext_put(page_ext);
 }
 
-void __split_page_owner(struct page *page, int order)
+void __split_page_owner(struct page *page, int old_order, int new_order)
 {
 	int i;
 	struct page_ext *page_ext = page_ext_get(page);
 	struct page_owner *page_owner;
-	unsigned int nr = 1 << order;
+	unsigned int old_nr = 1 << old_order;
+	unsigned int new_nr = 1 << new_order;
 
 	if (unlikely(!page_ext))
 		return;
 
-	for (i = 0; i < nr; i++) {
+	for (i = 0; i < old_nr; i += new_nr) {
 		page_owner = get_page_owner(page_ext);
-		page_owner->order = 0;
+		page_owner->order = new_order;
 		page_ext = page_ext_next(page_ext);
 	}
 	page_ext_put(page_ext);
-- 
2.43.0


