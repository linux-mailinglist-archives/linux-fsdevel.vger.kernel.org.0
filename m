Return-Path: <linux-fsdevel+bounces-52329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFE7AE1D7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 16:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F29517242C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2DC296153;
	Fri, 20 Jun 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="StvRTLb4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3227A28DB4A;
	Fri, 20 Jun 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430126; cv=none; b=JP7b0J/1/ccfTKaK0i/qlG4qGyjKb/1/7Q244wNg7yKQbWEjaVOWij8p9OxLAwfqfKfXA5lyITxSsXZAB+dg+fgkDP+ezFaNFuuG0WImRWCkdkiWAqNusGasgXu1WkudEHHPn7Mi1n78xXpcnxeOp5gP/q1DjiiMng9+9Os45GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430126; c=relaxed/simple;
	bh=EL4TXIl0wTV4SSHTGqpn+WTz2TDYE3tlRyN3BHc+P8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIMApm6q+ZdDwqKpkpV+7bd9E3kbV9SOoteX5ej5TveskeH7oO5XzoNQzzYxFsB/8FBXU3ibDtgZyMrH1EiIZ8aT6obUzriHWSWt01Fbc2M2wQw1PS9jJlP1HWPYurcZWJESaxusg3/L4grqXZ35s4D92Kp83POh1cfvHqx/Zds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=StvRTLb4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5N8OW6NrsoPk4+1/5gSQNU23U8kJ2u+aXMV73L1at/w=; b=StvRTLb4aWrJUQEO/rq4YROtMm
	5IGw4QKVcQHHRG6InqF2RDMwYORTcdgppj2BFf8jZ8PbMNYO00OosQqyK1eVrVMJymJam4f84vU5r
	5Al6emIAvP03BfCClO4RGlC612a++MQJ/FRVmZHaHKO4eRWty3D2FJvUT125LfDhtufCVDNLovq/v
	VwAcI3cq3V6k/0FjfV7jwkvjkBrmrL5R4aq7UeBbvMu3xrLBbPGKfrlW8L+yStFPyE5+1hM3djuBV
	VIHiuW/fAlTIAwedGO8fNxH2xYaur4yPooigc3Q2L7f3HkAJ2AGjYudut4nlIHVMY/EbE216/9Ozb
	ByOCFfCw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uScpf-0000000Cp21-1JvZ;
	Fri, 20 Jun 2025 14:35:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Shivank Garg <shivankg@amd.com>,
	seanjc@google.com,
	david@redhat.com,
	vbabka@suse.cz,
	willy@infradead.org,
	akpm@linux-foundation.org,
	shuah@kernel.org,
	pbonzini@redhat.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: ackerleytng@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	pvorel@suse.cz,
	bfoster@redhat.com,
	tabba@google.com,
	vannapurve@google.com,
	chao.gao@intel.com,
	bharata@amd.com,
	nikunj@amd.com,
	michael.day@amd.com,
	yan.y.zhao@intel.com,
	Neeraj.Upadhyay@amd.com,
	thomas.lendacky@amd.com,
	michael.roth@amd.com,
	aik@amd.com,
	jgg@nvidia.com,
	kalyazin@amazon.com,
	peterx@redhat.com,
	jack@suse.cz,
	rppt@kernel.org,
	hch@infradead.org,
	cgzones@googlemail.com,
	ira.weiny@intel.com,
	rientjes@google.com,
	roypat@amazon.co.uk,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	kent.overstreet@linux.dev,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	chao.p.peng@intel.com,
	amit@infradead.org,
	ddutile@redhat.com,
	dan.j.williams@intel.com,
	ashish.kalra@amd.com,
	gshan@redhat.com,
	jgowans@amazon.com,
	pankaj.gupta@amd.com,
	papaluri@amd.com,
	yuzhao@google.com,
	suzuki.poulose@arm.com,
	quic_eberman@quicinc.com,
	aneeshkumar.kizhakeveetil@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [PATCH 1/2] filemap: Add a mempolicy argument to filemap_alloc_folio()
Date: Fri, 20 Jun 2025 15:34:46 +0100
Message-ID: <20250620143502.3055777-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618112935.7629-4-shivankg@amd.com>
References: <20250618112935.7629-4-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

guest_memfd needs to support memory policies so add an argument
to filemap_alloc_folio().  All existing users pass NULL, the first
user will show up later in this series.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/bcachefs/fs-io-buffered.c |  2 +-
 fs/btrfs/compression.c       |  3 ++-
 fs/btrfs/verity.c            |  2 +-
 fs/erofs/zdata.c             |  2 +-
 fs/f2fs/compress.c           |  2 +-
 include/linux/pagemap.h      |  6 +++---
 mm/filemap.c                 | 13 +++++++++----
 mm/readahead.c               |  2 +-
 8 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index 66bacdd49f78..392344232b16 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -124,7 +124,7 @@ static int readpage_bio_extend(struct btree_trans *trans,
 			if (folio && !xa_is_value(folio))
 				break;
 
-			folio = filemap_alloc_folio(readahead_gfp_mask(iter->mapping), order);
+			folio = filemap_alloc_folio(readahead_gfp_mask(iter->mapping), order, NULL);
 			if (!folio)
 				break;
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 48d07939fee4..8430ccf70887 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -475,7 +475,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		}
 
 		folio = filemap_alloc_folio(mapping_gfp_constraint(mapping,
-								   ~__GFP_FS), 0);
+								   ~__GFP_FS),
+				0, NULL);
 		if (!folio)
 			break;
 
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index b7a96a005487..c43a789ba6d2 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -742,7 +742,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 	}
 
 	folio = filemap_alloc_folio(mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS),
-				    0);
+				    0, NULL);
 	if (!folio)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index fe8071844724..00e9160a0d24 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -562,7 +562,7 @@ static void z_erofs_bind_cache(struct z_erofs_frontend *fe)
 			 * Allocate a managed folio for cached I/O, or it may be
 			 * then filled with a file-backed folio for in-place I/O
 			 */
-			newfolio = filemap_alloc_folio(gfp, 0);
+			newfolio = filemap_alloc_folio(gfp, 0, NULL);
 			if (!newfolio)
 				continue;
 			newfolio->private = Z_EROFS_PREALLOCATED_FOLIO;
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index b3c1df93a163..7ef937dd7624 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1942,7 +1942,7 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 		return;
 	}
 
-	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0);
+	cfolio = filemap_alloc_folio(__GFP_NOWARN | __GFP_IO, 0, NULL);
 	if (!cfolio)
 		return;
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e63fbfbd5b0f..c176aeeb38db 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -646,9 +646,9 @@ static inline void *detach_page_private(struct page *page)
 }
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
+struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order, struct mempolicy *policy);
 #else
-static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order, struct mempolicy *policy)
 {
 	return folio_alloc_noprof(gfp, order);
 }
@@ -659,7 +659,7 @@ static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int o
 
 static inline struct page *__page_cache_alloc(gfp_t gfp)
 {
-	return &filemap_alloc_folio(gfp, 0)->page;
+	return &filemap_alloc_folio(gfp, 0, NULL)->page;
 }
 
 static inline gfp_t readahead_gfp_mask(struct address_space *x)
diff --git a/mm/filemap.c b/mm/filemap.c
index bada249b9fb7..a26df313207d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -989,11 +989,16 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 EXPORT_SYMBOL_GPL(filemap_add_folio);
 
 #ifdef CONFIG_NUMA
-struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
+struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
+		struct mempolicy *policy)
 {
 	int n;
 	struct folio *folio;
 
+	if (policy)
+		return folio_alloc_mpol_noprof(gfp, order, policy,
+				NO_INTERLEAVE_INDEX, numa_node_id());
+
 	if (cpuset_do_page_mem_spread()) {
 		unsigned int cpuset_mems_cookie;
 		do {
@@ -1977,7 +1982,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order);
+			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
 			if (!folio)
 				continue;
 
@@ -2516,7 +2521,7 @@ static int filemap_create_folio(struct kiocb *iocb, struct folio_batch *fbatch)
 	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 		return -EAGAIN;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order, NULL);
 	if (!folio)
 		return -ENOMEM;
 	if (iocb->ki_flags & IOCB_DONTCACHE)
@@ -3854,7 +3859,7 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
 		folio = filemap_alloc_folio(gfp,
-					    mapping_min_folio_order(mapping));
+				mapping_min_folio_order(mapping), NULL);
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		index = mapping_align_index(mapping, index);
diff --git a/mm/readahead.c b/mm/readahead.c
index 20d36d6b055e..0b2aec0231e6 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -183,7 +183,7 @@ static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 {
 	struct folio *folio;
 
-	folio = filemap_alloc_folio(gfp_mask, order);
+	folio = filemap_alloc_folio(gfp_mask, order, NULL);
 	if (folio && ractl->dropbehind)
 		__folio_set_dropbehind(folio);
 
-- 
2.47.2


