Return-Path: <linux-fsdevel+bounces-64724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F017BF26FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 18:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087A1188406D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D957928F948;
	Mon, 20 Oct 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="K17103B6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EW3kYtdN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B5283CB0;
	Mon, 20 Oct 2025 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977866; cv=none; b=iUpaWpN+IoQkR2Qpb2ilLIbI18eZ8HaR31KlwIoHWFQTy0C+sRYFkwy1ocNzQXUANN6bX8RtI4iCTT5CVKQq0+PzPyEJTlBjHtJpJp72pDHjufUvwSpgPPWdDuNtsNHjslh3kzqbGEPN+AqVA7g3RdEeoWXZzUQNvQdm1mACJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977866; c=relaxed/simple;
	bh=V9NNa4vV+3A9kVRjNsq1xZDpduW8Yz5GvnvS/EjVVoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZbXpEWsA50LS0xig+fX3mC1pgNXuGWzJX96ZBchqVqlZGudSUd8JHxjJjGn+/Xbp9/+UHznVFuyRzH6n+mI41SnzyoFCkPdhVSd4VsOUUi0quuksHfRcjXsxWGeGprZ2zYxJpDFz/ML94CEAMzCmGRmkJDytznw9O/vd1HnpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=K17103B6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EW3kYtdN; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 62C3C13803F8;
	Mon, 20 Oct 2025 12:31:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 20 Oct 2025 12:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1760977862; x=
	1760985062; bh=PGqcVqKR37HNE2kQKYG8FgWXCrKH2WKrmZjwByhBbVU=; b=K
	17103B6I93DTSHsItocCMFP7e1TRjkCoVCGyjn6o0q/iDjG0vmeAI3eGFeIGzj0I
	tzNHMMPGfVGOvuFkU6WpgEPW2yhBaQxTJ9ktKNe6Zt8m6YK/RoOgXsR1p/OHyb8h
	FbiRU+/NyqTnjDVC4ewuC00HO6wrBnz+/sf/QIloMtlFwKymLc06nhgOWGaWZiku
	xyO8XXttN0c8YNW6iOKQB51WBLIUUVeClyH+HQKI2+47In1/hMyUrHuxlU5xQkI7
	RGlo8okrEj24XrtDjGmz41/ziBfw3CcgRRw19huoPTFqgJnqchpyfC7Mzb69zZ4m
	ONig+TAZiIUWgAc9aL4gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760977862; x=1760985062; bh=P
	GqcVqKR37HNE2kQKYG8FgWXCrKH2WKrmZjwByhBbVU=; b=EW3kYtdNaJ6Fo6ome
	VJTG8Ovfve8B/ydL5KkoA3IUIFx9K9Z9LiGPfZFGJV3NYuYnydpQvCSJ6f8nGiFg
	7OOaPYn9Ibm8G2oDIGGNPDIAxhzIhWvVJP+8GBf6VftMMekzevv/K48IPATJUp7+
	BI+3vvc+B3clxgcrb0Cgs900mO/gLcSX/fRSkWHT8szG5CazI+PIiLHBVF610iiA
	sctnEGw8h/h4lPGK7tDXQuH5HaMWRPsRviA8SVpgDCZO8aFFmKeUUk/EeO7oohAx
	jodXoCZRq7pfN3OR7LLQlWTBeOS3e3db5VQKXUjqIMVu5gjOJyrdZsIj7KHaE+Rl
	jAV5w==
X-ME-Sender: <xms:xWP2aKQY9yl0h4WLVdi9KNZBGRB2ehcZIW9BitM471FFccdxTURPOQ>
    <xme:xWP2aM8sweMLC2ViVVwl7X5iCGqIB_M5I5K3jM_V-Jq6k9zh0NzC0Kq_DXyslMcFT
    bvF6nMCz6AYNopMDTtjzzK85hAKw7fvO3b5qOopuYB6c3BZmuZ-dFg>
X-ME-Received: <xmr:xWP2aMWGDVCzaL4--ehaeVcIJQNJjTm2XafKpw5BneAnBPJrrOguQ-LDmSPlZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepgeevhedtgfdvhfdugeffueduvdegveejhfevveeghfdvveeiveet
    iedvheejhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:xWP2aCNnPGYqoXOH7sYAWr3mQ2mudDWjUOZPOfBSconJvzMBooK4IQ>
    <xmx:xWP2aEdBZ6EL7vhKmMpp3j5R_4zFojS4JPzT_fHcTZVCZ8IBOKxrJA>
    <xmx:xWP2aBw8IgNDPdaSUfwOAIyHXWmE8c5-DGl824CYowEN7OMojuG2hw>
    <xmx:xWP2aFhcX5fCuBgvYpb3zfCAIf5OAAhZXnTmwlZGCNiD2C9oNrBOTA>
    <xmx:xmP2aHWz9CFkk4kk49CWeTfiXu9T-_M-elqIr2JcTTa3lBKZU0LoxV-v>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 12:31:01 -0400 (EDT)
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
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH 1/2] mm/memory: Do not populate page table entries beyond i_size.
Date: Mon, 20 Oct 2025 17:30:53 +0100
Message-ID: <20251020163054.1063646-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020163054.1063646-1-kirill@shutemov.name>
References: <20251020163054.1063646-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
supposed to generate SIGBUS.

Recent changes attempted to fault in full folio where possible. They did
not respect i_size, which led to populating PTEs beyond i_size and
breaking SIGBUS semantics.

Darrick reported generic/749 breakage because of this.

However, the problem existed before the recent changes. With huge=always
tmpfs, any write to a file leads to PMD-size allocation. Following the
fault-in of the folio will install PMD mapping regardless of i_size.

Fix filemap_map_pages() and finish_fault() to not install:
  - PTEs beyond i_size;
  - PMD mappings across i_size;

Not-yet-signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Reported-by: "Darrick J. Wong" <djwong@kernel.org>
---
 mm/filemap.c | 18 ++++++++++--------
 mm/memory.c  | 12 ++++++++++--
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 13f0259d993c..0d251f6ab480 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3681,7 +3681,8 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			struct folio *folio, unsigned long start,
 			unsigned long addr, unsigned int nr_pages,
-			unsigned long *rss, unsigned short *mmap_miss)
+			unsigned long *rss, unsigned short *mmap_miss,
+			pgoff_t file_end)
 {
 	unsigned int ref_from_caller = 1;
 	vm_fault_t ret = 0;
@@ -3697,7 +3698,8 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	 */
 	addr0 = addr - start * PAGE_SIZE;
 	if (folio_within_vma(folio, vmf->vma) &&
-	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK)) {
+	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK) &&
+	    file_end >= folio_next_index(folio)) {
 		vmf->pte -= start;
 		page -= start;
 		addr = addr0;
@@ -3817,7 +3819,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	if (!folio)
 		goto out;
 
-	if (filemap_map_pmd(vmf, folio, start_pgoff)) {
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	end_pgoff = min(end_pgoff, file_end);
+
+	if (file_end >= folio_next_index(folio) &&
+	    filemap_map_pmd(vmf, folio, start_pgoff)) {
 		ret = VM_FAULT_NOPAGE;
 		goto out;
 	}
@@ -3830,10 +3836,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
-	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
-	if (end_pgoff > file_end)
-		end_pgoff = file_end;
-
 	folio_type = mm_counter_file(folio);
 	do {
 		unsigned long end;
@@ -3850,7 +3852,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		else
 			ret |= filemap_map_folio_range(vmf, folio,
 					xas.xa_index - folio->index, addr,
-					nr_pages, &rss, &mmap_miss);
+					nr_pages, &rss, &mmap_miss, file_end);
 
 		folio_unlock(folio);
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
diff --git a/mm/memory.c b/mm/memory.c
index 74b45e258323..dfa5b437c9d9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5480,6 +5480,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	int type, nr_pages;
 	unsigned long addr;
 	bool needs_fallback = false;
+	pgoff_t file_end = -1UL;
 
 fallback:
 	addr = vmf->address;
@@ -5501,8 +5502,14 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return ret;
 	}
 
+	if (vma->vm_file) {
+		struct inode *inode = vma->vm_file->f_mapping->host;
+		file_end = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	}
+
 	if (pmd_none(*vmf->pmd)) {
-		if (folio_test_pmd_mappable(folio)) {
+		if (folio_test_pmd_mappable(folio) &&
+		    file_end >= folio_next_index(folio)) {
 			ret = do_set_pmd(vmf, folio, page);
 			if (ret != VM_FAULT_FALLBACK)
 				return ret;
@@ -5533,7 +5540,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		if (unlikely(vma_off < idx ||
 			    vma_off + (nr_pages - idx) > vma_pages(vma) ||
 			    pte_off < idx ||
-			    pte_off + (nr_pages - idx)  > PTRS_PER_PTE)) {
+			    pte_off + (nr_pages - idx)  > PTRS_PER_PTE ||
+			    file_end < folio_next_index(folio))) {
 			nr_pages = 1;
 		} else {
 			/* Now we can set mappings for the whole large folio. */
-- 
2.50.1


