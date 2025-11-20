Return-Path: <linux-fsdevel+bounces-69252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E43CC754FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 17:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5DD34E91BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBBE33A719;
	Thu, 20 Nov 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Ygo5lO9J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F+kzihpN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4933AD99;
	Thu, 20 Nov 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655262; cv=none; b=JZlBSacUERgiHUKUpkbnYYZpbuTuXaadLTwD69+wxw2AEmV57kWRnQ6fY8KBNRVOQwauzpPsZOVBxdUK7blcgQr+hI9Ax3srSY4ooXqZft9RysNa1FwGo4ot7uO5nxVLOoRBw8P5Hispf4vguk5Y+pr/tFuYTuYl3D4/DP5lgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655262; c=relaxed/simple;
	bh=Eszyd/uI4qnp11tVTYuxG+i8aH5e2GbJJgn5IsEzOu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WqXEufa6TAA2ZwF71/XCIYcYgXsuhymZU/Z0WGl8NnVpk6qdAEYSS3rxH3Iq4GqxKRsl0P+VGJvT8Xmk+et+r0itICe08UVpXgtoBnNGbZc3Q2fC/SR2EKTM102yGHJyWFwLM17uNb2nH8AyJEUnEwEpxL1y6zulFPpgzQmAPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Ygo5lO9J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F+kzihpN; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 1593F1301AB6;
	Thu, 20 Nov 2025 11:14:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 20 Nov 2025 11:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1763655258; x=1763662458; bh=w3ITVi2CUU
	n4IEwzmugFVygQp9ksK3seEQUoC2PwEdQ=; b=Ygo5lO9JLp0PQjn0B+/AJFxgK0
	WDJb+5Rl8o0jI+ObDuUSFxNd6bjOVO3bXdIKpPu1YYxZxurvrQ7M84FxqYTbTG1O
	Ac6hEWAvuHLum4PhDCaBPRI0euawIpfWaYFsZLxQ1BxGUosPRPicyoxSRFbcTAUI
	v/IDoDAA3AJpwb1V54wXNd34ZsAbGDcpXYX2NU5U78DXvyaXSc9NLtR5P4Z7yZC9
	k7WuM8G8NU9Lol8hJ6maUzL1SkBjmDT5O86a6PZn6f2AAVMrmd8Yy0cXpPEu+Cz5
	7FqAXVpYlGeQRu7dSwQ91HaS6p2YuL3nLg4/zlcTgE1U3VyatlCP7IxbjVyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763655258; x=1763662458; bh=w3ITVi2CUUn4IEwzmugFVygQp9ksK3seEQU
	oC2PwEdQ=; b=F+kzihpNgyuBkLbA7iNVidrVNmxF/OgnO9jJhjCVgtrDgrzRJUr
	iPnv3AKFdSTbJM8RzUJXYHc/gLean1LiHgtb+sSzQxoPFODKcVl3EvAkgmGx5n/b
	fBDIHJkC2etPRMySWPTJociSZu/QtqutkzUCyM1pmqfK8Fc3YYLsrCBgSNth1c/v
	pzSXsCjZnNs8p0Y9Al8dvyqu2V9noR6t0mh1qKzFYp/izud/3w2VGTZ13Lb4mU9d
	ttSEvHiulESZeEiTOQk0I40mniepHChE0aKrM99hnA2pLPgkRGlRlucJJz++uXsU
	XI+yEjzvdWLAm3dL+VzmHbvH9rV0L3QKoJg==
X-ME-Sender: <xms:WD4faVHy_yPTbqYnOnV8YDHMkPT5jGF_orIt9-49BfpqADWtKHy5mg>
    <xme:WD4faShFI7e3FnwPM3Rc6AWnZRAFeOFQtWs69nIW19nscTyeOogmjbP_OT-R2SCph
    SdI3rXQyAM8lMtCu5XjrDgjbv9UK2997iIY9nFf5MtSo__9OddcoLI>
X-ME-Received: <xmr:WD4faedzTxpzLXZHeFnhRREi82DyiWNSHHYaNIhu7yobPHpUPodSu7JK27j0gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepteffudduheevjeefudegkedttdevtdfhheefheetffelteeiveehvdef
    gedtheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedvgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunh
    gurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifihhllh
    ihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhl
    ihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtg
    hpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:WD4faYwJ2xAl3WaP8MMmACe7XZYqLOp7aeFcdch-MO9GmGEis4KFLw>
    <xmx:WD4faYYHiYU3eYlPfEoUfWNjBH0JgbhU4B-e6elz8YP4XgizSDKQoQ>
    <xmx:WD4faWLk7EOLTDbLMUrasTTVH_fgOieMiGXhbNzs_pSDVCmLRCndzw>
    <xmx:WD4faf3kwdqwsn4y7l-i280L89u1D2nelmphZRyVKB94uxuDnU1TkQ>
    <xmx:Wj4faddSi4rte6x2oQ_oQRHUv3odrGH19LUpfwiXaFJ3LNAewiFALoT1>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 11:14:15 -0500 (EST)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>,
	Chris Mason <clm@meta.com>
Subject: [PATCH] mm/filemap: Fix logic around SIGBUS in filemap_map_pages()
Date: Thu, 20 Nov 2025 16:14:11 +0000
Message-ID: <20251120161411.859078-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

Chris noticed that filemap_map_pages() calculates can_map_large only
once for the first page in the fault around range. The value is not
valid for the following pages in the range and must be recalculated.

Instead of recalculating can_map_large on each iteration, pass down
file_end to filemap_map_folio_range() and let it make the decision on
what can be mapped.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: Chris Mason <clm@meta.com>
Fixes: 74207de2ba10 ("mm/memory: do not populate page table entries beyond i_size")h
---
 mm/filemap.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2f1e7e283a51..024b71da5224 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3682,8 +3682,9 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			struct folio *folio, unsigned long start,
 			unsigned long addr, unsigned int nr_pages,
 			unsigned long *rss, unsigned short *mmap_miss,
-			bool can_map_large)
+			pgoff_t file_end)
 {
+	struct address_space *mapping = folio->mapping;
 	unsigned int ref_from_caller = 1;
 	vm_fault_t ret = 0;
 	struct page *page = folio_page(folio, start);
@@ -3692,12 +3693,16 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	unsigned long addr0;
 
 	/*
-	 * Map the large folio fully where possible.
+	 * Map the large folio fully where possible:
 	 *
-	 * The folio must not cross VMA or page table boundary.
+	 *  - The folio is fully within size of the file or belong
+	 *    to shmem/tmpfs;
+	 *  - The folio doesn't cross VMA boundary;
+	 *  - The folio doesn't cross page table boundary;
 	 */
 	addr0 = addr - start * PAGE_SIZE;
-	if (can_map_large && folio_within_vma(folio, vmf->vma) &&
+	if ((file_end >= folio_next_index(folio) || shmem_mapping(mapping)) &&
+	    folio_within_vma(folio, vmf->vma) &&
 	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK)) {
 		vmf->pte -= start;
 		page -= start;
@@ -3812,7 +3817,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	unsigned long rss = 0;
 	unsigned int nr_pages = 0, folio_type;
 	unsigned short mmap_miss = 0, mmap_miss_saved;
-	bool can_map_large;
 
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
@@ -3823,16 +3827,14 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	end_pgoff = min(end_pgoff, file_end);
 
 	/*
-	 * Do not allow to map with PTEs beyond i_size and with PMD
-	 * across i_size to preserve SIGBUS semantics.
+	 * Do not allow to map with PMD across i_size to preserve
+	 * SIGBUS semantics.
 	 *
 	 * Make an exception for shmem/tmpfs that for long time
 	 * intentionally mapped with PMDs across i_size.
 	 */
-	can_map_large = shmem_mapping(mapping) ||
-		file_end >= folio_next_index(folio);
-
-	if (can_map_large && filemap_map_pmd(vmf, folio, start_pgoff)) {
+	if ((file_end >= folio_next_index(folio) || shmem_mapping(mapping)) &&
+	    filemap_map_pmd(vmf, folio, start_pgoff)) {
 		ret = VM_FAULT_NOPAGE;
 		goto out;
 	}
@@ -3861,8 +3863,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		else
 			ret |= filemap_map_folio_range(vmf, folio,
 					xas.xa_index - folio->index, addr,
-					nr_pages, &rss, &mmap_miss,
-					can_map_large);
+					nr_pages, &rss, &mmap_miss, file_end);
 
 		folio_unlock(folio);
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
-- 
2.51.0


