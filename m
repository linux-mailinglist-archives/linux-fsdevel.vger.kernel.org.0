Return-Path: <linux-fsdevel+bounces-11455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD22E853DC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D02F1C22426
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E515363106;
	Tue, 13 Feb 2024 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="C70tT3/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfJ6oPkF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964B6214D;
	Tue, 13 Feb 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861352; cv=none; b=MISIKfJGDbki8WY/Ge/kZlgaRJXSDub7enexA2jv4v1iSvO7XUbK3Difot5n5h6qVC1L78sYWN78qtdMqCC3SP7vcD0HIf+lakh9JEDP4PWOevS+h41vYDlhS6cZIYsUTrgxstS3UeOEKxxP6UgptHIxGAiHYFJqrxmml4WNq0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861352; c=relaxed/simple;
	bh=UqNu37izsdBNbfTcNTy5md1Flo14ewszOLHxEmwptdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/FdOxVoLSb517b3svt4cE8Lj47jBMbCfaZ4p2OXJf4sSDERkZq5JkExqGoz6oyZtYd9ABgCOGRB6V51zgfd+ZNOJTB5ZtTCtlIEop5pB/8Y20HcTanGqOSWMn11i2CW2VSh/9SPafTkJQt1bdCokGRN3/oOBUbZ1RvgLRCVIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=C70tT3/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mfJ6oPkF; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 632325C0112;
	Tue, 13 Feb 2024 16:55:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 13 Feb 2024 16:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1707861349; x=1707947749; bh=w6VhDK8TXvu8VmS0cIwR/bVucmXbgvOXS24
	MFWRb9kQ=; b=C70tT3/hxvmwRWrVgxnS8fozz4YHtS6gPhAjMZn75BqWt0l64Kq
	6NAknIY8hodeTZXxf1TcFW+hmSrY8Ez6UcvgHwAYCo/PzX/kaod9FkQg4YxM6Qap
	+Q0U0w8f96uywhMHVijq7849z79hzfhu9xT1WBbNjbnqePwm5/ZmuWlXZzd9dWG1
	Ihah9K6AUWgSgv9aAkOqam/jPngyvV2GhLW2LtwWP+KQJ+smHMCekknDEyUOxKUI
	uL233jsmWJ9skW3QUzLrpOgUlN4+wsNmJGn6/f3rdboztQfhMVpqShelgfvJGMBK
	BzByecW+/ekBdo0qS4Pd0bLg+VuomGNJegA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707861349; x=1707947749; bh=w6VhDK8TXvu8VmS0cIwR/bVucmXbgvOXS24
	MFWRb9kQ=; b=mfJ6oPkFyNA+mLkOP/AUEVBP9KImpo/pDaBA8WA4QMCAq03CiTz
	492X3jwKiuTbKwuWwNH62NYygt2WBIlP2hxakQ6u0PuV2KIigxiRUrBfckunC0MP
	nt/aNZDy4MAzjFvlZ6uLK75/N92HY+cpE2wE0m34hVBxGSzd/XcVGP8Fya3eleTG
	OdN/SgRo6balkm91Wog9MxEYiVA742kmaYLsnDsEPH9WryD4QW9km77C9HyraNOY
	ktQRHTwI//dgaj4iVwiDumZjJirsDYev9o0Uv1zHeLkNIc7VjvRc0XXR/UwtChiu
	Z5/e6Y2a0o5yXwC0zyZf0TbF28RyZw1gxnQ==
X-ME-Sender: <xms:ZeXLZdi86WnJRo-mjDl7D0cZ257ig2_P_v07HTS8r2adYWjR26e_qA>
    <xme:ZeXLZSCURce1acTSgAxRLm1WJhnZpHsGVUH3cACJ_XSmz0h_Nn0TVN8UYPc9RiF7g
    ubyI0p4FwJr2R_pfw>
X-ME-Received: <xmr:ZeXLZdEplaAkwBVKiDr31O4TenOv95gRZuCDpv8Ehp3qkym6oQoz0xSRFxEJj8RaikT4Br4FJ69ZluLLFDUUnN8L5BlIYlKFmdai3fuf3mB3idGzwzZq70Dm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:ZeXLZSQApHIkMv9os4KBKc-30DBk0eB0MRQL-L3WSUR5vgih0mRXWw>
    <xmx:ZeXLZawraL2iTpJ8B8P9BLsqu5KzQA59757ApDnfXHwcIuokQdct7Q>
    <xmx:ZeXLZY68DShcx-iL8rT9MyDzjZMn52SzX1UU6lTyDOsigjB4Z1tXiA>
    <xmx:ZeXLZWmDaxu6CfMuPY_2dlhAkYdulG4paaE5QEZzRqFH2UmgD-Pv3Q>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 16:55:48 -0500 (EST)
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
Subject: [PATCH v4 3/7] mm: memcg: make memcg huge page split support any order split.
Date: Tue, 13 Feb 2024 16:55:16 -0500
Message-ID: <20240213215520.1048625-4-zi.yan@sent.com>
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

It sets memcg information for the pages after the split. A new parameter
new_order is added to tell the order of subpages in the new page, always 0
for now. It prepares for upcoming changes to support split huge page to
any lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
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
index f079b02f1f59..3d30eccd3a7f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2880,7 +2880,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	int order = folio_order(folio);
 
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order);
+	split_page_memcg(head, order, 0);
 
 	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
 		offset = swp_offset(folio->swap);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 404e529644c0..27d53715d8dc 100644
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
index b6e8fe6fed67..9d4dd41d0647 100644
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
 
@@ -4838,7 +4838,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, order);
-		split_page_memcg(page, order);
+		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);
 
-- 
2.43.0


