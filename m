Return-Path: <linux-fsdevel+bounces-51932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26675ADD2E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D7166C37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F222F2341;
	Tue, 17 Jun 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awr/9N48"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF312EF2A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175065; cv=none; b=DfJmEBZ/31l1W/jTOCaCGQniFQjxYbHNghO5IxH1YvttdDMPLfGMq/2z32EeG2k5lgoN3aOijpbzLAzNt8RuFZ6j0UDEUuc6uSleWeNzK1ZqOIiHvuCInAL5JdutBxjAdfrU86SpcR+P/0MvMNJSSqelAWxyIx/ceodRiOdY2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175065; c=relaxed/simple;
	bh=JoPCIxNFhISa/uoEZhmjVFXMY/aHB9zZc630LouBJb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyjAYGuhBnZ40R8AHAldKMcitJaanC588tYt0l/H+v7Znbi3YRqr03AF9KKOKlFFV6w5n1gDFUuV/Ajhfodc8XPEGhSJoeo96EUNghORLzcDXobJRITiDWyy15G6qZBwMcc3iuQK9EDHE3EzUqrduZC3V0xv/4S+bgHKZioNZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awr/9N48; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750175062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLVJGNARtVFI5B2J8se/8/6UXe4Uo6I4yV7PyVAOlF8=;
	b=awr/9N48N1K0HXhB5k6H7unYbZeJnF6338pk0FA99D2G5jnW4Td4mpghU0VfVEseMf+dyK
	XxGJbPFVukkkQQ9bb+4z69zNUlbG5+wWKVX2zcSHJqlUnjKhAMUCpGWnlQAvdi89UlWW1N
	iaBl6+j5CIuyiVnB7p34X8UxbtxXOos=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-oUHPti35O4SjE1RIF9-4TQ-1; Tue, 17 Jun 2025 11:44:21 -0400
X-MC-Unique: oUHPti35O4SjE1RIF9-4TQ-1
X-Mimecast-MFC-AGG-ID: oUHPti35O4SjE1RIF9-4TQ_1750175060
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a56b3dee17so2219304f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 08:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750175060; x=1750779860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLVJGNARtVFI5B2J8se/8/6UXe4Uo6I4yV7PyVAOlF8=;
        b=wjS/OfXS9Nn2lCbaHxL8ShFDN7HpS9VdQlP/oDjwmFuWABJ8D1JHgaBo66zVGcyr6i
         xfcsM1KjKWa9szco5YsxNdwm+tabbrBeD8T2LIIRA/4LUUr+nZg9qaoQJpVrgGBo5fvX
         9Vp9zshbO0xrvRUBf772KGqv9rcEWZimOLxIvFkLXzxXVp/qggy/oSQ7BUsg2Cn1Oz1Y
         /MjoPM502jo4KNVDSmHIHjvpnkaghJ+9ERgRlCnRrVwewaq2ZBxl4aHskAknNWb01CrI
         GiZwbcxVKmfqV2lL2QofwISwKJ+n82+rnogM8Rji6FRnUOJ1OFt038sngjyGLIusyqWp
         vyfA==
X-Gm-Message-State: AOJu0Yz/CXynT0x+fSf1+7FbNSIl8E++n4eRiZBGJzzyrJYz4QT7Ek3D
	CwqPoNXhTlSerQrjNkHTswKI8cTvardM1roxAbxkGXjyifo7RpBb1wPXxcA9Q07RouGSErM8+8b
	1j0z1RodUffkAh/SCdSga+iygw0LrUGzJuqRmNecKoUkSdmGAbfi410xPu1Sa0AlTJzJWU8Qrew
	36+g==
X-Gm-Gg: ASbGncumJeuM1br4Q7Mk4kxWyrhhS75GumE1I4dhSdB2acxItgSLZPWHqS0UvLminHf
	qEbgGCo1JMwIScsV0OkQpltOirKI4mbw64e1QBGTWW1QS6k92eXaIMH42xU79LMiqhc30pPMZ+0
	OdCTYkKN5CqF3NF/SMuIKzwaLGBz+kHNpnfl6OD/2r0h8WFrATfzaqqSfYX/mhg9iwbii4m2Txd
	63xlRvx3oiGt6KYCJyDHOTFIVEAYrify3iEoN1pV0gSEq68Qs940sj1R80suYkPNxiR5+Dy0dCW
	i+aahaPEll9RB7kwNyF1ZDqyKtRnMbeZlgBTivUyGVQDJU7eRJqe/a9Wh7ex156obSRL7k2KL4k
	93tMqww==
X-Received: by 2002:a05:6000:40d9:b0:3a4:e238:6496 with SMTP id ffacd0b85a97d-3a56d827f55mr10918519f8f.18.1750175059796;
        Tue, 17 Jun 2025 08:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQg7GY1Gsteo7GdT4ckbEy0SNxYC91KxvGox3B/Jtg2LOmOg//Pt1oxMAZKf077YGN9lBupw==
X-Received: by 2002:a05:6000:40d9:b0:3a4:e238:6496 with SMTP id ffacd0b85a97d-3a56d827f55mr10918494f8f.18.1750175059294;
        Tue, 17 Jun 2025 08:44:19 -0700 (PDT)
Received: from localhost (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b4c969sm14100737f8f.85.2025.06.17.08.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:44:18 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH RFC 14/14] mm: rename vm_ops->find_special_page() to vm_ops->find_normal_page()
Date: Tue, 17 Jun 2025 17:43:45 +0200
Message-ID: <20250617154345.2494405-15-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617154345.2494405-1-david@redhat.com>
References: <20250617154345.2494405-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... and hide it behind a kconfig option. There is really no need for
any !xen code to perform this check.

The naming is a bit off: we want to find the "normal" page when a PTE
was marked "special". So it's really not "finding a special" page.

Improve the documentation, and add a comment in the code where XEN ends
up performing the pte_mkspecial() through a hypercall. More details can
be found in commit 923b2919e2c3 ("xen/gntdev: mark userspace PTEs as
special on x86 PV guests").

Cc: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/xen/Kconfig              |  1 +
 drivers/xen/gntdev.c             |  5 +++--
 include/linux/mm.h               | 18 +++++++++++++-----
 mm/Kconfig                       |  2 ++
 mm/memory.c                      | 10 ++++++++--
 tools/testing/vma/vma_internal.h | 18 +++++++++++++-----
 6 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 24f485827e039..f9a35ed266ecf 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -138,6 +138,7 @@ config XEN_GNTDEV
 	depends on XEN
 	default m
 	select MMU_NOTIFIER
+	select FIND_NORMAL_PAGE
 	help
 	  Allows userspace processes to use grants.
 
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 61faea1f06630..d1bc0dae2cdf9 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -309,6 +309,7 @@ static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
 	BUG_ON(pgnr >= map->count);
 	pte_maddr = arbitrary_virt_to_machine(pte).maddr;
 
+	/* Note: this will perform a pte_mkspecial() through the hypercall. */
 	gnttab_set_map_op(&map->map_ops[pgnr], pte_maddr, flags,
 			  map->grants[pgnr].ref,
 			  map->grants[pgnr].domid);
@@ -516,7 +517,7 @@ static void gntdev_vma_close(struct vm_area_struct *vma)
 	gntdev_put_map(priv, map);
 }
 
-static struct page *gntdev_vma_find_special_page(struct vm_area_struct *vma,
+static struct page *gntdev_vma_find_normal_page(struct vm_area_struct *vma,
 						 unsigned long addr)
 {
 	struct gntdev_grant_map *map = vma->vm_private_data;
@@ -527,7 +528,7 @@ static struct page *gntdev_vma_find_special_page(struct vm_area_struct *vma,
 static const struct vm_operations_struct gntdev_vmops = {
 	.open = gntdev_vma_open,
 	.close = gntdev_vma_close,
-	.find_special_page = gntdev_vma_find_special_page,
+	.find_normal_page = gntdev_vma_find_normal_page,
 };
 
 /* ------------------------------------------------------------------ */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 022e8ef2c78ef..b01475f3dca99 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -646,13 +646,21 @@ struct vm_operations_struct {
 	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
 					unsigned long addr, pgoff_t *ilx);
 #endif
+#ifdef CONFIG_FIND_NORMAL_PAGE
 	/*
-	 * Called by vm_normal_page() for special PTEs to find the
-	 * page for @addr.  This is useful if the default behavior
-	 * (using pte_page()) would not find the correct page.
+	 * Called by vm_normal_page() for special PTEs in @vma at @addr. This
+	 * allows for returning a "normal" page from vm_normal_page() even
+	 * though the PTE indicates that the "struct page" either does not exist
+	 * or should not be touched: "special".
+	 *
+	 * Do not add new users: this really only works when a "normal" page
+	 * was mapped, but then the PTE got changed to something weird (+
+	 * marked special) that would not make pte_pfn() identify the originally
+	 * inserted page.
 	 */
-	struct page *(*find_special_page)(struct vm_area_struct *vma,
-					  unsigned long addr);
+	struct page *(*find_normal_page)(struct vm_area_struct *vma,
+					 unsigned long addr);
+#endif /* CONFIG_FIND_NORMAL_PAGE */
 };
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/mm/Kconfig b/mm/Kconfig
index c6194d1f9d170..607a3f9672bdb 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1390,6 +1390,8 @@ config PT_RECLAIM
 
 	  Note: now only empty user PTE page table pages will be reclaimed.
 
+config FIND_NORMAL_PAGE
+	def_bool n
 
 source "mm/damon/Kconfig"
 
diff --git a/mm/memory.c b/mm/memory.c
index 6c65f51248250..1eba95fcde096 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -619,6 +619,10 @@ static inline struct page *vm_normal_page_pfn(struct vm_area_struct *vma,
  * If an architecture does not support pte_special(), this function is less
  * trivial and more expensive in some cases.
  *
+ * With CONFIG_FIND_NORMAL_PAGE, we might have pte_special() set on PTEs that
+ * actually map "normal" pages: however, that page cannot be looked up through
+ * pte_pfn(), but instead will be looked up through vm_ops->find_normal_page().
+ *
  * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
  * special mapping (even if there are underlying and valid "struct pages").
  * COWed pages of a VM_PFNMAP are always normal.
@@ -639,8 +643,10 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 	unsigned long pfn = pte_pfn(pte);
 
 	if (unlikely(pte_special(pte))) {
-		if (vma->vm_ops && vma->vm_ops->find_special_page)
-			return vma->vm_ops->find_special_page(vma, addr);
+#ifdef CONFIG_FIND_NORMAL_PAGE
+		if (vma->vm_ops && vma->vm_ops->find_normal_page)
+			return vma->vm_ops->find_normal_page(vma, addr);
+#endif /* CONFIG_FIND_NORMAL_PAGE */
 		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 			return NULL;
 		if (is_zero_pfn(pfn))
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 51dd122b8d501..c5bf041036dd7 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -470,13 +470,21 @@ struct vm_operations_struct {
 	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
 					unsigned long addr, pgoff_t *ilx);
 #endif
+#ifdef CONFIG_FIND_NORMAL_PAGE
 	/*
-	 * Called by vm_normal_page() for special PTEs to find the
-	 * page for @addr.  This is useful if the default behavior
-	 * (using pte_page()) would not find the correct page.
+	 * Called by vm_normal_page() for special PTEs in @vma at @addr. This
+	 * allows for returning a "normal" page from vm_normal_page() even
+	 * though the PTE indicates that the "struct page" either does not exist
+	 * or should not be touched: "special".
+	 *
+	 * Do not add new users: this really only works when a "normal" page
+	 * was mapped, but then the PTE got changed to something weird (+
+	 * marked special) that would not make pte_pfn() identify the originally
+	 * inserted page.
 	 */
-	struct page *(*find_special_page)(struct vm_area_struct *vma,
-					  unsigned long addr);
+	struct page *(*find_normal_page)(struct vm_area_struct *vma,
+					 unsigned long addr);
+#endif /* CONFIG_FIND_NORMAL_PAGE */
 };
 
 struct vm_unmapped_area_info {
-- 
2.49.0


