Return-Path: <linux-fsdevel+bounces-54970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11232B05C18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6ADC566C24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 13:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028FF2E7BAA;
	Tue, 15 Jul 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij325BUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12222E7635
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585859; cv=none; b=oE5LFnhg7dNyppDOoUotrAa9PxdSeZAwdES421hf2KsGW8it644LKidByKT2U8XqUqyKsq4TjJbNZtF4XexwNe1Aw7NVZjEvjDPdLY6ovHHXuEpZCV+b97GsQGBIo2eFVkWA0YnpigE+JBOYgdfFGk1MVfNwQWj1zqmWlpAdukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585859; c=relaxed/simple;
	bh=KfY/V2hEUA6C7GlUCahAYYBS9gZ/TXfYbBOyKxGKtEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ux+YATbcUYcj95IyZC7QiPgwjVYagDKacRjbvePQBCdl1a/FhSS6KY8iIWX4DyjA3b3nybY3+JBIcphWvTFlvH+bMVjI1h5cVWNOC5psvfVIByBwf2eGLodO+VFvFy6rbkCe3aKOSvZUX3DhBkwxJTJBDynAsant8+biPaXJyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ij325BUd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQduvI7D6V1Y1gj1ZwNsH+sSV4mM47HI53S/a03rEFE=;
	b=Ij325BUdHXbk35YtamXLu1ySArK76DKT0rOkVCLl/TGJ3VsTT6+osJLVZlAqbbgOmXTSh5
	IPPAm7C2U5kjiI3A2dnbLfyMIPZsNllXQYAotABkuxTiZNDgJgNO2JH/NhDMb0+CIrvjdt
	zSE2prSPpHZkqAGcPUWXYIE20vOiHNk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-fVlvoOZ1PU221w_5QHiQ9w-1; Tue, 15 Jul 2025 09:24:15 -0400
X-MC-Unique: fVlvoOZ1PU221w_5QHiQ9w-1
X-Mimecast-MFC-AGG-ID: fVlvoOZ1PU221w_5QHiQ9w_1752585854
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4538a2f4212so31548985e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 06:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585854; x=1753190654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQduvI7D6V1Y1gj1ZwNsH+sSV4mM47HI53S/a03rEFE=;
        b=BOcEqixaMqaLozSctV80krUFos5wLNyW60nQ9KO1LtmhdnQhHNYG9ewylhlvPDhhL7
         aCDvdl8Ah/zTB/Frz17V4NHf61JyvLWsv1YNPEFesTPZH8+7ETSCFLYBrNv/nzoYAwME
         B8rAdbbs9jmu+rhMQ2PtQ6bnw8B1ygs58yaI+zASlmkIjVqpWukhqFM9wwvm1dcLzEPH
         8GymTlMr9e+DvE9qxmKDWEUTqGbYH8jd+ZJQ1qXhlmM7Cgc8QN1Qyh4JbLntOiTBHmEe
         hvbP5srKgP+MsKI9uWebV1AGBsBWv+vCK2N/ZPXSjYClg3qghkvgZaUGoW6ehdeyhpkf
         rghA==
X-Forwarded-Encrypted: i=1; AJvYcCWPIDEXNtckP+0081nkBvdPLkb60BDbYSHs3lagKSS/kYvXB8iGDlSRWzk/qqloZZG7Y8ibOqwaIQEC7I3p@vger.kernel.org
X-Gm-Message-State: AOJu0YwHTlxqpd8q8tUOXeX1QYFLazZVzMXuPdv+XLZQMF9BknKsgnau
	W6C5enYnx4Vmy4o1TTeMA7nHCtKjtfDCe8vOylnXB6jL0Tlu8anczw33NX87ELeBIpV9SZOAR5+
	On393YWlRqVd3dTz+XGwxass95SCWaRCIwZy4vpb1Wb1to2FEdqndvOMc5lFJg3pXBBo=
X-Gm-Gg: ASbGnctiYnAKqnseYkzpz4MgCq9vjEbv5qHp/uu7Bxrtvs3x7jWE1kw3GWUvwoOztKZ
	96XjmG0b2fKMxCuJ8OaWIc0Vf7yOYpzX2FNYmFyTEEggfFNQzAk+q7VZQzPyV0TI3NM5zqm0TyW
	6kyKLGYQLjtcliNfJounisLePaVR5LNik2PzNf3sWKTFowKKUgGjvV60WqXqLq83lpcQKZwiETd
	VnULx9o8VQbCgjUIPppKwPCLzH+kV4zVCgINvmlVD4KkCjdVAdSDu5SybV3c1kJ1iElooM6P6b7
	uSwRFw6N6iV7GZh3/vdZSqtGBp4n03tqK69t+F5Eje6ukFqo0qA8nL6IHJlzRfVtmZZBpuHhrrE
	t8DkZ0mdeHeZtLWr9ORSuaykT
X-Received: by 2002:a05:600c:4ed0:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-4561a41fd79mr64379245e9.22.1752585854254;
        Tue, 15 Jul 2025 06:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3r8lG85ntU3nBUSpLXqHodEZFoetPf2QpvNAGJr6E2EBer+0dRaC665FuVYarZxx4ibL6Dg==
X-Received: by 2002:a05:600c:4ed0:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-4561a41fd79mr64378845e9.22.1752585853644;
        Tue, 15 Jul 2025 06:24:13 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4560c50b7b4sm100033485e9.25.2025.07.15.06.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:24:13 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>,
	David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH v1 9/9] mm: rename vm_ops->find_special_page() to vm_ops->find_normal_page()
Date: Tue, 15 Jul 2025 15:23:50 +0200
Message-ID: <20250715132350.2448901-10-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715132350.2448901-1-david@redhat.com>
References: <20250715132350.2448901-1-david@redhat.com>
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
 mm/memory.c                      | 12 ++++++++++--
 tools/testing/vma/vma_internal.h | 18 +++++++++++++-----
 6 files changed, 42 insertions(+), 14 deletions(-)

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
index 6877c894fe526..cc3322fce62f4 100644
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
index 0287e8d94aea7..82c281b4f6937 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1397,6 +1397,8 @@ config PT_RECLAIM
 
 	  Note: now only empty user PTE page table pages will be reclaimed.
 
+config FIND_NORMAL_PAGE
+	def_bool n
 
 source "mm/damon/Kconfig"
 
diff --git a/mm/memory.c b/mm/memory.c
index f1834a19a2f1e..d09f2ff4a866e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -619,6 +619,12 @@ static void print_bad_page_map(struct vm_area_struct *vma,
  * trivial. Secondly, an architecture may not have a spare page table
  * entry bit, which requires a more complicated scheme, described below.
  *
+ * With CONFIG_FIND_NORMAL_PAGE, we might have the "special" bit set on
+ * page table entries that actually map "normal" pages: however, that page
+ * cannot be looked up through the PFN stored in the page table entry, but
+ * instead will be looked up through vm_ops->find_normal_page(). So far, this
+ * only applies to PTEs.
+ *
  * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
  * special mapping (even if there are underlying and valid "struct pages").
  * COWed pages of a VM_PFNMAP are always normal.
@@ -716,8 +722,10 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
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
index 991022e9e0d3b..9eecfb1dcc13f 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -465,13 +465,21 @@ struct vm_operations_struct {
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
2.50.1


