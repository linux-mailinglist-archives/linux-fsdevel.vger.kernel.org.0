Return-Path: <linux-fsdevel+bounces-42255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E219AA3FA90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E99119E14BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930462116FB;
	Fri, 21 Feb 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="Ptk5y1vs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE91FBEB0;
	Fri, 21 Feb 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154169; cv=none; b=RZLVMM+fq0v3aT7DjYMNQ9RwJ4HIT88G0EPq4syKiGIykKMvBYHB/WH3hm4cEDs2F5VMhvqv8tg385zUtjl1XFxZnB7nWT2+/sURBmAG2momVormm9LyXB5yFEPKPaSzzrPADhLbJN1ms61z1dCgBLS3gPC2Bxk5qivZpe6ZeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154169; c=relaxed/simple;
	bh=Pu6HGVQiogGU63MCf6Mx6dL0odXiMy1GgrBdxomprgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3qLb5RSy056hTV3cX53kOeGrHorKzmsvGZrZ8s4hoRuHDbaKesYWB4NharCsmZyVAQWh3yu5kWPRldFYgNu+VCu6hUhbFW1G9mDaAgNk8kUsTPfeQSZ4ExZ7y+2IPNfkWs+n9Zk6uaY1iDBz6yJkMlD1Huz2PLkWWTzUfoMAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=Ptk5y1vs; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740154168; x=1771690168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H8EJounnNVCHbSPBe6inBfgnScOOplPgupbAfsLZMsM=;
  b=Ptk5y1vsvGy7AxAq2YPfZdPqHLqFj+9PtJ2lvZNWuXGC4kMWmyIlhDYn
   NZsb2g1+Cz4JSzeKs/B9s3ExfTkEoreTWUBWDnq6MdbeFVbJ4mh5dHomp
   d2VnxJansec96Mf8KHsN13VHPdHyl32ubs8S38XnFwhw+prNw9fwlP+Yh
   s=;
X-IronPort-AV: E=Sophos;i="6.13,305,1732579200"; 
   d="scan'208";a="379576522"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:09:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:37109]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id 78cc7798-b6c2-4e9f-88b9-8c9c17bd29c6; Fri, 21 Feb 2025 16:09:22 +0000 (UTC)
X-Farcaster-Flow-ID: 78cc7798-b6c2-4e9f-88b9-8c9c17bd29c6
Received: from EX19D003UWB004.ant.amazon.com (10.13.138.24) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 16:09:12 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D003UWB004.ant.amazon.com (10.13.138.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 16:09:12 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 21 Feb 2025 16:09:12 +0000
Received: from ua2d7e1a6107c5b.ant.amazon.com (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id 3843B401F3;
	Fri, 21 Feb 2025 16:09:05 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <rppt@kernel.org>, <david@redhat.com>, <seanjc@google.com>
CC: Patrick Roy <roypat@amazon.co.uk>, <pbonzini@redhat.com>,
	<corbet@lwn.net>, <willy@infradead.org>, <akpm@linux-foundation.org>,
	<song@kernel.org>, <jolsa@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
	<Liam.Howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
	<jannh@google.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <tabba@google.com>, <jgowans@amazon.com>,
	<graf@amazon.com>, <kalyazin@amazon.com>, <xmarcalx@amazon.com>,
	<derekmn@amazon.com>, <jthoughton@google.com>
Subject: [PATCH v4 01/12] mm: introduce AS_NO_DIRECT_MAP
Date: Fri, 21 Feb 2025 16:07:14 +0000
Message-ID: <20250221160728.1584559-2-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221160728.1584559-1-roypat@amazon.co.uk>
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Add AS_NO_DIRECT_MAP for mappings where direct map entries of folios are
set to not present . Currently, mappings that match this description are
secretmem mappings (memfd_secret()). Later, some guest_memfd
configurations will also fall into this category.

Reject this new type of mappings in all locations that currently reject
secretmem mappings, on the assumption that if secretmem mappings are
rejected somewhere, it is precisely because of an inability to deal with
folios without direct map entries.

Use a new flag instead of overloading AS_INACCESSIBLE (which is already
set by guest_memfd) because not all guest_memfd mappings will end up
being direct map removed (e.g. in pKVM setups, parts of guest_memfd that
can be mapped to userspace should also be GUP-able, and generally not
have restrictions on who can access it).

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 include/linux/pagemap.h | 16 ++++++++++++++++
 lib/buildid.c           |  4 ++--
 mm/gup.c                |  6 +++++-
 mm/mlock.c              |  3 ++-
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 47bfc6b1b632..903b41e89cf8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,6 +210,7 @@ enum mapping_flags {
 	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
 				   folio contents */
 	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
+	AS_NO_DIRECT_MAP = 9,	/* Folios in the mapping are not in the direct map */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -335,6 +336,21 @@ static inline bool mapping_inaccessible(struct address_space *mapping)
 	return test_bit(AS_INACCESSIBLE, &mapping->flags);
 }
 
+static inline void mapping_set_no_direct_map(struct address_space *mapping)
+{
+	set_bit(AS_NO_DIRECT_MAP, &mapping->flags);
+}
+
+static inline bool mapping_no_direct_map(struct address_space *mapping)
+{
+	return test_bit(AS_NO_DIRECT_MAP, &mapping->flags);
+}
+
+static inline bool vma_is_no_direct_map(const struct vm_area_struct *vma)
+{
+	return vma->vm_file && mapping_no_direct_map(vma->vm_file->f_mapping);
+}
+
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
 	return mapping->gfp_mask;
diff --git a/lib/buildid.c b/lib/buildid.c
index c4b0f376fb34..80b5d805067f 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -65,8 +65,8 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 
 	freader_put_folio(r);
 
-	/* reject secretmem folios created with memfd_secret() */
-	if (secretmem_mapping(r->file->f_mapping))
+	/* reject secretmem folios created with memfd_secret() or guest_memfd() */
+	if (secretmem_mapping(r->file->f_mapping) || mapping_no_direct_map(r->file->f_mapping))
 		return -EFAULT;
 
 	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
diff --git a/mm/gup.c b/mm/gup.c
index 3883b307780e..7ddaf93c5b6a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1283,7 +1283,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
 		return -EOPNOTSUPP;
 
-	if (vma_is_secretmem(vma))
+	if (vma_is_secretmem(vma) || vma_is_no_direct_map(vma))
 		return -EFAULT;
 
 	if (write) {
@@ -2849,6 +2849,10 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 	 */
 	if (check_secretmem && secretmem_mapping(mapping))
 		return false;
+
+	if (mapping_no_direct_map(mapping))
+		return false;
+
 	/* The only remaining allowed file system is shmem. */
 	return !reject_file_backed || shmem_mapping(mapping);
 }
diff --git a/mm/mlock.c b/mm/mlock.c
index cde076fa7d5e..07a351491d9d 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -474,7 +474,8 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
 	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
-	    vma_is_dax(vma) || vma_is_secretmem(vma) || (oldflags & VM_DROPPABLE))
+	    vma_is_dax(vma) || vma_is_secretmem(vma) || vma_is_no_direct_map(vma) ||
+	    (oldflags & VM_DROPPABLE))
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
 		goto out;
 

base-commit: da40655874b54a2b563f8ceb3ed839c6cd38e0b4
-- 
2.48.1


