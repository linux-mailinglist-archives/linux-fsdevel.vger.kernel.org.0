Return-Path: <linux-fsdevel+bounces-65699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C37C0D566
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 12:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15F4F34CEB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DA12FDC2C;
	Mon, 27 Oct 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="FDUM9yjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y48Rbk1J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2480533D6;
	Mon, 27 Oct 2025 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566211; cv=none; b=ToaNmroPWXHYeR+/fn53JeHq4wbST2Zox6meu8GNXoOXitEVGwvPDokromzVWmhvk0n49p84fAmKOPQuK811gEMY2rnRcfXoWymWQ5ydPTDzb9fMJE5t8CnSCMGy/VjBmsi+8oQ/6kX32/Y6v+C44NFKscpvLEKe5R2v2DQwLnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566211; c=relaxed/simple;
	bh=tt4YGuNiEyO4ChIfz3k6M/qivZfbtbjVzM1DpwDMOOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBmarpj7QSoMU2RVZvjTFTRaOo1oqw2ahHEDhpb9Q0qbSr3Mh3rTqNENm6wFbjX2itGCz4AqnbqBtACA4DxvmAWOf52Mx3DfXmurtWNI5S6czWMrMYueOPSFWY7AgHDl6Ay1ZRng/PvYvpjsENehcergEuh/Xw44sKTnnQc/OwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=FDUM9yjk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y48Rbk1J; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id E4EC8138020E;
	Mon, 27 Oct 2025 07:56:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 07:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761566208; x=
	1761573408; bh=fMNCxaIXhkuB9AFidHwvKyW61Us/jESq3kVR7JAZcns=; b=F
	DUM9yjkZYTKWMjkQ5qHpoXVwltrN/MLnKknNqnXygFJV1IL0PA820zERKWzU4NBf
	b/oTSGssDC3WRY5sjsqEUZm9N+DceSTEnMWNrTIUBxizICEtPivhGWNnZNcs6XAK
	sZQUva2nuDcgf+lx2R41mTXoR2DEgkKGZ/seL8GX30IoOZ20yMmv+87OaCyfmaR0
	hGBGbr4NRMg8z7s0izd+yiAtsYlBOgeaNkiwN8u6ggRakv6IaPn0hsQKqwrW8BSI
	IsqnX0mjs/uHW8N8tm4aWPGpROr3Bt/w5YWtlQCfxnHuexw/6cdkrnhqnglfIGTg
	5+jHYZjzT6H8ZAxnFsxnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761566208; x=1761573408; bh=f
	MNCxaIXhkuB9AFidHwvKyW61Us/jESq3kVR7JAZcns=; b=Y48Rbk1JPIqI8Rfun
	sCoVoc6zqwgg1SZAReucsfVOCrryRUHkR8w8YBCLrmkyqoMVntF+RaEK4l/FIMeM
	C1xTNrYebWcqtU4+qjyy7ruUPSX9oeeeQUW81oL0iHuL612OUIVbKYgCykO6BX+/
	rdYBqZGrTNm2fpWtY10k74bUZqLz3dR3k3ec3WpNglnxYU3fljOMyzO1LW71oXYG
	ic8lJBoflUjKbX4a3jsk02XqpNnSsQLxVdlKj5yzRH1rZd6FKTLqr3QjiSugr2rT
	/EvV1588I4kmsELWCOi/A572Y8Xrm7bnMDELU80CVX2oYNJ0gRY4DXqjh5lITL4E
	qg06A==
X-ME-Sender: <xms:AF7_aMI2TlKuOrNGUdiFc3CbxS-8EF7Z0PaNkFhf1QFOfBSef6J2Mw>
    <xme:AF7_aBCQqAk1FUmhgxuzgT0AxiamaCpZkWfnMSqet1B2xYfH8773gbzsl3L3jpcLB
    p8OHQvci8yP06HtiX8Qd3mqxAMgGV2d09G0fE-W-RTgVHq4S8Wfki8>
X-ME-Received: <xmr:AF7_aKTHH5VK67Fa5GDWFeBetl7JII3v_Q0e3jSV8LVlZvXnrEFfAaFQRzxJsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepgeevhedtgfdvhfdugeffueduvdegveejhfevveeghfdvveeiveet
    iedvheejhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:AF7_aLcouFswoHir9shIm9U9pJHaIA7h5zzqHSPW1djRsUHuXN4QSw>
    <xmx:AF7_aCgZ-lj7BHqc-ISGKdj2zJ5o-tM_S4WkJUPBZEjVq6Q6_ubMAQ>
    <xmx:AF7_aG_tIER7-G7-tmYsTFVUjvWIkTOuSQ7vQUrtvNVEWR8k9rsq7g>
    <xmx:AF7_aCkSaAQVQfcgtkODiprQSXTOyMZlAzxdvFsWJld6QPbCvNMdtg>
    <xmx:AF7_aKwRQzcm7Sf8MQi9_6EnTaJx0gLXo1ZbvcS2oNfSQcB4ixJIBZ0w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:56:47 -0400 (EDT)
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
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCHv3 1/2] mm/memory: Do not populate page table entries beyond i_size
Date: Mon, 27 Oct 2025 11:56:35 +0000
Message-ID: <20251027115636.82382-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027115636.82382-1-kirill@shutemov.name>
References: <20251027115636.82382-1-kirill@shutemov.name>
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

Make an exception for shmem/tmpfs that for long time intentionally
mapped with PMDs across i_size.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
Fixes: 01c70267053d ("fs: add a filesystem flag for THPs")
Reported-by: "Darrick J. Wong" <djwong@kernel.org>
---
 mm/filemap.c | 28 ++++++++++++++++++++--------
 mm/memory.c  | 20 +++++++++++++++++++-
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b7b297c1ad4f..ff75bd89b68c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3690,7 +3690,8 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			struct folio *folio, unsigned long start,
 			unsigned long addr, unsigned int nr_pages,
-			unsigned long *rss, unsigned short *mmap_miss)
+			unsigned long *rss, unsigned short *mmap_miss,
+			bool can_map_large)
 {
 	unsigned int ref_from_caller = 1;
 	vm_fault_t ret = 0;
@@ -3705,7 +3706,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	 * The folio must not cross VMA or page table boundary.
 	 */
 	addr0 = addr - start * PAGE_SIZE;
-	if (folio_within_vma(folio, vmf->vma) &&
+	if (can_map_large && folio_within_vma(folio, vmf->vma) &&
 	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK)) {
 		vmf->pte -= start;
 		page -= start;
@@ -3820,13 +3821,27 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	unsigned long rss = 0;
 	unsigned int nr_pages = 0, folio_type;
 	unsigned short mmap_miss = 0, mmap_miss_saved;
+	bool can_map_large;
 
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
 	if (!folio)
 		goto out;
 
-	if (filemap_map_pmd(vmf, folio, start_pgoff)) {
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	end_pgoff = min(end_pgoff, file_end);
+
+	/*
+	 * Do not allow to map with PTEs beyond i_size and with PMD
+	 * across i_size to preserve SIGBUS semantics.
+	 *
+	 * Make an exception for shmem/tmpfs that for long time
+	 * intentionally mapped with PMDs across i_size.
+	 */
+	can_map_large = shmem_mapping(mapping) ||
+		file_end >= folio_next_index(folio);
+
+	if (can_map_large && filemap_map_pmd(vmf, folio, start_pgoff)) {
 		ret = VM_FAULT_NOPAGE;
 		goto out;
 	}
@@ -3839,10 +3854,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
-	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
-	if (end_pgoff > file_end)
-		end_pgoff = file_end;
-
 	folio_type = mm_counter_file(folio);
 	do {
 		unsigned long end;
@@ -3859,7 +3870,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		else
 			ret |= filemap_map_folio_range(vmf, folio,
 					xas.xa_index - folio->index, addr,
-					nr_pages, &rss, &mmap_miss);
+					nr_pages, &rss, &mmap_miss,
+					can_map_large);
 
 		folio_unlock(folio);
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
diff --git a/mm/memory.c b/mm/memory.c
index 39e21688e74b..1a3eb070f8df 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -77,6 +77,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/pgalloc.h>
 #include <linux/uaccess.h>
+#include <linux/shmem_fs.h>
 
 #include <trace/events/kmem.h>
 
@@ -5545,8 +5546,25 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return ret;
 	}
 
+	if (!needs_fallback && vma->vm_file) {
+		struct address_space *mapping = vma->vm_file->f_mapping;
+		pgoff_t file_end;
+
+		file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
+
+		/*
+		 * Do not allow to map with PTEs beyond i_size and with PMD
+		 * across i_size to preserve SIGBUS semantics.
+		 *
+		 * Make an exception for shmem/tmpfs that for long time
+		 * intentionally mapped with PMDs across i_size.
+		 */
+		needs_fallback = !shmem_mapping(mapping) &&
+			file_end < folio_next_index(folio);
+	}
+
 	if (pmd_none(*vmf->pmd)) {
-		if (folio_test_pmd_mappable(folio)) {
+		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
 			ret = do_set_pmd(vmf, folio, page);
 			if (ret != VM_FAULT_FALLBACK)
 				return ret;
-- 
2.50.1


