Return-Path: <linux-fsdevel+bounces-42257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C57A3FAF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484E8706FBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F458214A82;
	Fri, 21 Feb 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="VBuFyyQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209FA212D8A;
	Fri, 21 Feb 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154173; cv=none; b=FrMHLOo8lJAkIXHYd9yCWebBSTqK5R12nKvSmAaQ9AW1FcmDFws0yRh6kz4Op9HkXXu/KhIviGKRypBbQPakhtN/+NTCYeVAoC6TbjowJRYz8cTk03WOTXqm0vJhZI5jCPj9AR4+T2OZnbQylAEJw4bElir1vu0OcZLgQUmGkFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154173; c=relaxed/simple;
	bh=XBeY8+oEwhKifncEyH8TEyPQTC55c9NIYUhaXkomxbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3m0ignA867CMxfnQsX1y3+fGGmRhn9uoGqFZylirwZZ8k6CYb+H6QGBFulU3at03TjlWQeVeLWSm2e+SPZzf+mv93qLmorvZ9ecZ3uon+xUimLJ/r/r4+mWlcgOlcI668F5tRE3J7Y/hKC3YhBqytyUqpyE02WlBCLsdBYoPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=VBuFyyQ/; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740154172; x=1771690172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kfd1Zplwy2qRjve62vAKobnSTBEdWZ73b7NbT1dhvg4=;
  b=VBuFyyQ/RiXrGxoRFd3jFqQl8VOZN+JzF5X4U/SzWP6JTRDu8edc9N0R
   hj+eR1ftKjUquf2N2bETwqewzYMSxZvGS7HCC/lW4Ei1b7E1kvOZ7KZjA
   bDU8kVh37biKiWzeR/aiBajKIXN+pbed1AKK13fG1yQ6mJYofsQ/WPQwS
   g=;
X-IronPort-AV: E=Sophos;i="6.13,305,1732579200"; 
   d="scan'208";a="800876125"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:09:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:57570]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id 034d3b2a-db78-4a01-a02f-f39d1fe30c84; Fri, 21 Feb 2025 16:09:26 +0000 (UTC)
X-Farcaster-Flow-ID: 034d3b2a-db78-4a01-a02f-f39d1fe30c84
Received: from EX19D020UWA003.ant.amazon.com (10.13.138.254) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 16:09:21 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D020UWA003.ant.amazon.com (10.13.138.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 16:09:20 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 21 Feb 2025 16:09:20 +0000
Received: from ua2d7e1a6107c5b.ant.amazon.com (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id 05B8B401F3;
	Fri, 21 Feb 2025 16:09:12 +0000 (UTC)
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
Subject: [PATCH v4 02/12] mm/secretmem: set AS_NO_DIRECT_MAP instead of special-casing
Date: Fri, 21 Feb 2025 16:07:15 +0000
Message-ID: <20250221160728.1584559-3-roypat@amazon.co.uk>
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

Make secretmem set AS_NO_DIRECT_MAP on its struct address_space, to drop
all the vma_is_secretmem()/secretmem_mapping() checks that are based on
checking explicitly for the secretmem ops structures.

This drops a optimization in gup_fast_folio_allowed() where
secretmem_mapping() was only called if CONFIG_SECRETMEM=y. secretmem is
enabled by default since commit b758fe6df50d ("mm/secretmem: make it on
by default"), so the secretmem check did not actually end up elided in
most cases anymore anyway.

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 include/linux/secretmem.h | 18 ------------------
 lib/buildid.c             |  2 +-
 mm/gup.c                  | 14 +-------------
 mm/mlock.c                |  3 +--
 mm/secretmem.c            |  6 +-----
 5 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index e918f96881f5..0ae1fb057b3d 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -4,28 +4,10 @@
 
 #ifdef CONFIG_SECRETMEM
 
-extern const struct address_space_operations secretmem_aops;
-
-static inline bool secretmem_mapping(struct address_space *mapping)
-{
-	return mapping->a_ops == &secretmem_aops;
-}
-
-bool vma_is_secretmem(struct vm_area_struct *vma);
 bool secretmem_active(void);
 
 #else
 
-static inline bool vma_is_secretmem(struct vm_area_struct *vma)
-{
-	return false;
-}
-
-static inline bool secretmem_mapping(struct address_space *mapping)
-{
-	return false;
-}
-
 static inline bool secretmem_active(void)
 {
 	return false;
diff --git a/lib/buildid.c b/lib/buildid.c
index 80b5d805067f..33f173a607ad 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -66,7 +66,7 @@ static int freader_get_folio(struct freader *r, loff_t file_off)
 	freader_put_folio(r);
 
 	/* reject secretmem folios created with memfd_secret() or guest_memfd() */
-	if (secretmem_mapping(r->file->f_mapping) || mapping_no_direct_map(r->file->f_mapping))
+	if (mapping_no_direct_map(r->file->f_mapping))
 		return -EFAULT;
 
 	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
diff --git a/mm/gup.c b/mm/gup.c
index 7ddaf93c5b6a..b1483a876740 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1283,7 +1283,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
 		return -EOPNOTSUPP;
 
-	if (vma_is_secretmem(vma) || vma_is_no_direct_map(vma))
+	if (vma_is_no_direct_map(vma))
 		return -EFAULT;
 
 	if (write) {
@@ -2786,7 +2786,6 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 {
 	bool reject_file_backed = false;
 	struct address_space *mapping;
-	bool check_secretmem = false;
 	unsigned long mapping_flags;
 
 	/*
@@ -2798,14 +2797,6 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 		reject_file_backed = true;
 
 	/* We hold a folio reference, so we can safely access folio fields. */
-
-	/* secretmem folios are always order-0 folios. */
-	if (IS_ENABLED(CONFIG_SECRETMEM) && !folio_test_large(folio))
-		check_secretmem = true;
-
-	if (!reject_file_backed && !check_secretmem)
-		return true;
-
 	if (WARN_ON_ONCE(folio_test_slab(folio)))
 		return false;
 
@@ -2847,9 +2838,6 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 	 * At this point, we know the mapping is non-null and points to an
 	 * address_space object.
 	 */
-	if (check_secretmem && secretmem_mapping(mapping))
-		return false;
-
 	if (mapping_no_direct_map(mapping))
 		return false;
 
diff --git a/mm/mlock.c b/mm/mlock.c
index 07a351491d9d..a43f308be70d 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -474,8 +474,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
 	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
-	    vma_is_dax(vma) || vma_is_secretmem(vma) || vma_is_no_direct_map(vma) ||
-	    (oldflags & VM_DROPPABLE))
+	    vma_is_dax(vma) || vma_is_no_direct_map(vma) || (oldflags & VM_DROPPABLE))
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
 		goto out;
 
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1b0a214ee558..ea4c04d469b1 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -136,11 +136,6 @@ static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
-bool vma_is_secretmem(struct vm_area_struct *vma)
-{
-	return vma->vm_ops == &secretmem_vm_ops;
-}
-
 static const struct file_operations secretmem_fops = {
 	.release	= secretmem_release,
 	.mmap		= secretmem_mmap,
@@ -214,6 +209,7 @@ static struct file *secretmem_file_create(unsigned long flags)
 
 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 	mapping_set_unevictable(inode->i_mapping);
+	mapping_set_no_direct_map(inode->i_mapping);
 
 	inode->i_op = &secretmem_iops;
 	inode->i_mapping->a_ops = &secretmem_aops;
-- 
2.48.1


