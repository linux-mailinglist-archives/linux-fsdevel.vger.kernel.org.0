Return-Path: <linux-fsdevel+bounces-11454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E944F853DC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E5629144A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCFE6280A;
	Tue, 13 Feb 2024 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="IFte4mTO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OUf61+g9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53A86217C;
	Tue, 13 Feb 2024 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861351; cv=none; b=KApB2vSCBMkaPKcwGah88sH6SwMhT2yIeFDg2h6DdBYrFVO/x8UEuqxq5urz3zrA1n7ysgrcZb/ZpSvnxA5zx9RkbuTJtTzYupMNlepIDCN7VhYNZke89Owf89a4t/2sEPxUktpwXcsLRcg0rb2kOqk170zNow4Owl8jY4veTJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861351; c=relaxed/simple;
	bh=W+t9ky4Cs9vVz5Q7cEU44YRwRv+9h4htLo26lHE7ZEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aunpMtXRo2FaTf281ZZ8zyIVKIS8iz42YQgGmRst4s8g7dBx7G/LBx1XNBt1sG9jfUYssdNSolIyJ12cxAjN9sBiLEUbJSbcNNyMc1A/Th09j3dJm+ib6TnAcZWyU2Ut+P2MKWutHx6N457LS0+SYnXLRQ3Qig5CrEGVnbP8fSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=IFte4mTO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OUf61+g9; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9DBE15C010A;
	Tue, 13 Feb 2024 16:55:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 16:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1707861348; x=1707947748; bh=wJBfeFCeCXlsVboyNZCAlUASDo+mI/mq6x/
	aZS6p7CI=; b=IFte4mTOyYLgDFzhTe1Wzq+D8KLldWfEdKzAAWhih+Jc94YdTIO
	R0BPQL5lKaXGs6sCl8paJTtefcKhm9m0bRwd/i6kdUFAuiPIMec2zURErXQ9n9sl
	kS6nagE2F7UorEzQnFoYn61dJNGJG5pkVoMNakmIrcraDu19kx5UHG5A9ynE67xO
	7Uo/+Y2qjRm6uGlG13h3taJdK72R2jbLwghg9moZPJsmub8Q3Uzx3DI65/NFjREL
	of/pmsNfUj1phFgchBQ069nJ6mI4Q0BTUPTITAJQMiR5BKhmq8T6VS4FJsbBZsas
	arxVzg3miTSIGfy9pFSECe+I8Y6WQ4ia+bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707861348; x=1707947748; bh=wJBfeFCeCXlsVboyNZCAlUASDo+mI/mq6x/
	aZS6p7CI=; b=OUf61+g9RDW6eTwtmDEW0Y+9JYoyVi7jrk/8UURdj3XuQ8gJdqi
	D+Wm7S4JwLfZft36Xex237rwqqDOrYIAB8Vn4FC1eTEZrVPqTBeoYBltVx/8FyCb
	Xo2zmq/GKvveXx+/iA1jH7puduI3eQGrFpDrnHVFY/zhrVQvaXV/E/vlZ9POzSLY
	fyA1PPAPdyI/pN/tA1j+iaX5D2ROugh0o6JwgzqGQVLuppBadE1gVPR4m3NFqSNS
	m6QQvw7RO1QIS/sA9XMFPYx9i4liYS94t6zWHI9cCo4SHbXczMt38B7vVW/oZH6/
	NIpeymsD6Ee0PX4V35EFUeGscJb/jyKAx+w==
X-ME-Sender: <xms:ZOXLZcpm1mgTi37G1C2V3oSZLzJgPFrbL7yDk46WB7DejCrTMBCocQ>
    <xme:ZOXLZSpc0XkZaYmjhUALP2Kl2yXPk-1McHrY56V4CvZwNOsXeHyZY5NDYoLZiXfHP
    S2EyaHIbPu231UTTA>
X-ME-Received: <xmr:ZOXLZRNSClE6WK54DUBump4IrDgHZSlN0agzI3hOs_I8ZUVp4rrpXXwyV_88LXdm1y4v2u4WmXvSjXTKi3rA3MYjUtYXle3mn2uLj70DUGkTyEbOmFjZ__qZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:ZOXLZT5wiS8owo9xLi1Xe_o3mk3M8ypnG4qTLVSeTW8LeWYBeYxy6Q>
    <xmx:ZOXLZb5CyDHjNy_heZYTiy7eMlmX4ATBKXi4QDt9OxYGy43a67uDmw>
    <xmx:ZOXLZTi7SeoqINz0Mkwcfvz-UIjhDf1mccRwR6MzijemswekJZJsyQ>
    <xmx:ZOXLZUMnwnQDbw1fbL3zNBUZ_S53S85HcZDyCihpl5MA8d2Ua0n0Ng>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 16:55:47 -0500 (EST)
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
Subject: [PATCH v4 2/7] mm/page_owner: use order instead of nr in split_page_owner()
Date: Tue, 13 Feb 2024 16:55:15 -0500
Message-ID: <20240213215520.1048625-3-zi.yan@sent.com>
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
 include/linux/page_owner.h | 8 ++++----
 mm/huge_memory.c           | 2 +-
 mm/page_alloc.c            | 4 ++--
 mm/page_owner.c            | 3 ++-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 119a0c9d2a8b..d7878523adfc 100644
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
@@ -60,7 +60,7 @@ static inline void set_page_owner(struct page *page,
 {
 }
 static inline void split_page_owner(struct page *page,
-			unsigned short order)
+			int order)
 {
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *folio)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0cd5fba0923c..f079b02f1f59 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2919,7 +2919,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
 
-	split_page_owner(head, nr);
+	split_page_owner(head, order);
 
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7c927b84e16c..b6e8fe6fed67 100644
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
@@ -4837,7 +4837,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *page = virt_to_page((void *)addr);
 		struct page *last = page + nr;
 
-		split_page_owner(page, 1 << order);
+		split_page_owner(page, order);
 		split_page_memcg(page, order);
 		while (page < --last)
 			set_page_refcounted(last);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index c4f9e5506e93..1319e402c2cf 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -292,11 +292,12 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
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


