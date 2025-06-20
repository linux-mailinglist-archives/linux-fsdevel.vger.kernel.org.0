Return-Path: <linux-fsdevel+bounces-52328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932CAAE1D80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 16:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552A35A4262
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 14:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51F293B42;
	Fri, 20 Jun 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BGgl4Ywg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF63288525;
	Fri, 20 Jun 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430124; cv=none; b=e2TUWwFhY7+4L/+bU7WnyVHr4a19/gIs4YuGv7wT8f6arnEF0AD2UytcqZRR8mTHq2N7C5qFr2T9Yh8OhQj3VT4LROM6CMSmfmk2VGpHjo3yjugIQ+/Zadvq30DpINvYR3RGq0TKUMUra6FbQqbMNZ6L+r5dTqhmhhFF1uzHWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430124; c=relaxed/simple;
	bh=RtkWVneWxxFISg2NArFo0KlUHpDus0XfHjoC434GXpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPtliYKoZ7dt/eAeRo6CeNMT3jX8h9L2ZaLZsKC77ffIRv8H1ZX0hLGD9bwKDedyhQk14RO79vXCxbFhX+sGSfZRFIaBDpOIVRZKUn0m8+TXaUi+1IJM22mqlLqm7ECa3FUOum72Bk11ENmvBj98L/2kcGyD7cOfHqornKo257g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BGgl4Ywg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lZQBciVA5OeuYh81fOodmLtcu/a9Fi/yqGjigdSt1Mo=; b=BGgl4YwgEEN+I8ASQH7sJo/B2c
	/XhsGsO3TF72+OIV0HR9tNfAZ+ljUT6Jcgtb9mEOGFzb96ZTz2u03RVtT2HXWKzRzgU7NClpipVOP
	/SGN3ap6410IbUhuzW0THqudwb6uvcoe1bikju6ejzIKmKfxG2CfptYyMOPRpxrCGmiH9Y1W6GfpY
	Md5fd5CxKkwOxqVBLNvuzGQrG4sqSjL1++nZBAJqtMUKwp07ru0QCV0KLRazLakI9rOBW153ul9iT
	/k3tvfKxxkKuUw+7bKgro5jtbJutMi8W1J+ekn+kGM7f0aglk6IbwCbguJDV8O6cJqDXd1LgJz9Hj
	CmZo4iXw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uScpf-0000000Cp24-1qme;
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
Subject: [PATCH 2/2] filemap: Add __filemap_get_folio_mpol()
Date: Fri, 20 Jun 2025 15:34:47 +0100
Message-ID: <20250620143502.3055777-2-willy@infradead.org>
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

This allows guest_memfd to pass in a memory policy.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 10 ++++++++--
 mm/filemap.c            | 10 ++++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c176aeeb38db..1cfbf7b8f573 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -745,11 +745,17 @@ static inline fgf_t fgf_set_order(size_t size)
 }
 
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp);
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgf_flags, gfp_t gfp, struct mempolicy *);
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		fgf_t fgp_flags, gfp_t gfp);
 
+static inline struct folio *__filemap_get_folio(struct address_space *mapping,
+		pgoff_t index, fgf_t fgf_flags, gfp_t gfp)
+{
+	return __filemap_get_folio_mpol(mapping, index, fgf_flags, gfp, NULL);
+}
+
 /**
  * filemap_get_folio - Find and get a folio.
  * @mapping: The address_space to search.
diff --git a/mm/filemap.c b/mm/filemap.c
index a26df313207d..597d146cbb3a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1896,11 +1896,12 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 }
 
 /**
- * __filemap_get_folio - Find and get a reference to a folio.
+ * __filemap_get_folio_mpol - Find and get a reference to a folio.
  * @mapping: The address_space to search.
  * @index: The page index.
  * @fgp_flags: %FGP flags modify how the folio is returned.
  * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
+ * @policy: NUMA memory allocation policy to follow.
  *
  * Looks up the page cache entry at @mapping & @index.
  *
@@ -1911,8 +1912,9 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
  *
  * Return: The found folio or an ERR_PTR() otherwise.
  */
-struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
-		fgf_t fgp_flags, gfp_t gfp)
+struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
+		pgoff_t index, fgf_t fgp_flags, gfp_t gfp,
+		struct mempolicy *policy)
 {
 	struct folio *folio;
 
@@ -1982,7 +1984,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			err = -ENOMEM;
 			if (order > min_order)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
-			folio = filemap_alloc_folio(alloc_gfp, order, NULL);
+			folio = filemap_alloc_folio(alloc_gfp, order, policy);
 			if (!folio)
 				continue;
 
-- 
2.47.2


