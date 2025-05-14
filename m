Return-Path: <linux-fsdevel+bounces-49054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8110FAB79F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4693B8050
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72214254868;
	Wed, 14 May 2025 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MR/OPrIA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0506E253B64
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266224; cv=none; b=JRE3oMS+R2/SiXjx2YQ+ePtKpITaSjSDt40w77tmQ2ezuru8VB6TXt3FN0JJJ8UFRxFpJGs/kAUMAMOAZq3xVzETQMyyowCmDy2FcIza0RdSIj9s9fSr+PU+BXyHhy/Q3azasUutCBaXEgfuqVaWb8R4vsOr8vxjrAnMUYEudsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266224; c=relaxed/simple;
	bh=fQP8LrPdftVt1PEYQDzvx7ve03WT9tehNqYvFsWXy74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ebygivFWq8EcttrIBfMiraQE+21gzDQEk3AJTmazAu5RyIUoVs9kqM+GszWTHGXF+B4LAR+eBeTrcch1Y+JscbxxQQw1SZ7otbTICDYbHNtvm7y6wYazDVUnD2RWqcnesVQYEqds5SpdAiiuO0vxoWEILdCk7Vj3uEjTal57Yq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MR/OPrIA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30a91c0745bso1244397a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266222; x=1747871022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YO6uWak20yIpwl5SkrA91BElV/aTzcnCIZVjpZ5wsSs=;
        b=MR/OPrIAe8NmsBIzcqor6wDkODVin2qHToT28J9RdTgmrVTkjErkIqWP48AcRdCJLi
         yFewlfP9kq+fbGqp8F1JrILYrJUjLa95W5z071I/16KLfbsUT2zjKl6gnDw2XJosuPcm
         wNpStp8W+EyuS2NSDk/IApKszWW3+JmFkNDkoi4pM6oE74qAh+CT5vmUkppOQSuBc4ZJ
         paMmysEJ4kb5zipdk60uv1ZRJmU3AamMWTw1pVBreCP03IAt0/K8FjQB74RznN+GVFoH
         XAfP2ivMJk6BnG1Fdrw6L10PUHpZvJ4K8PWeQibQWA7H4hapRAPcRK2Wn7JK+BMiOj/D
         EKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266222; x=1747871022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YO6uWak20yIpwl5SkrA91BElV/aTzcnCIZVjpZ5wsSs=;
        b=f4PbsEhrKUqAAujgXw9ZisGEo9qkvpaA8jzYnSVmzOX2dLPNdHbc2EHUB2V/JQObp8
         HhBa8XkJDsJqg9YT/zuJ7l2/XB7q8DzT7EYHi7PNRB5GxlLZUxxN1ONzu/7rACwNv79p
         rE5TU3JCMkU2AQgzy8TehCG4RdA8FZAWJHYw1UhQatNVB5RF1gdQ7WTKvlE7bwYV/kCF
         PlzOQO1EBhsA7mzI0nzjxTqKysL232gnvLkMf2sL4Fmds6zQ9jKawVtzZ8Nh7fe9bKsp
         YXKXuAZzPH8CplAGZbL/1I5iJmVqGb3ydZwQhSfvPRGAD+kS55uQ0E6yG+wED7bVlgX/
         vQrA==
X-Forwarded-Encrypted: i=1; AJvYcCUkpazH6bM8Ru5q/Os7NpYg71SnMsjcpAF8gyZNSehRMC1zH6voh9Ppqs0TklDLFuJeElZIVLImnHwXzwAW@vger.kernel.org
X-Gm-Message-State: AOJu0YyYlVOvDUXUf3RFwSzCMbxDWHsCkmRH0RXZej6/zQq7PdJILqop
	d7bPj5NJ/52ddajaHsrepMdbGHnQ4Dtus6yetBwH1H16iGq7qtm3vrIeJbfjFien8DdzYQ1Lbf+
	HAnk2kxty3iCRsIIPA8bRJw==
X-Google-Smtp-Source: AGHT+IGl3WmzH+yO2/mQx4qb1kBF9dOrq8V3rB8nhLLZwxphKAU+/jLPzMK1piBiMErLawYA7pQKxljtm90DB1S9Bg==
X-Received: from pjbtb15.prod.google.com ([2002:a17:90b:53cf:b0:2ff:4be0:c675])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1811:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-30e4db11d0amr1980560a91.5.1747266222377;
 Wed, 14 May 2025 16:43:42 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:08 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <b3c2da681c5bf139e2eaf0ea82c7422f972f6288.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 29/51] mm: guestmem_hugetlb: Wrap HugeTLB as an
 allocator for guest_memfd
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

guestmem_hugetlb is an allocator for guest_memfd. It wraps HugeTLB to
provide huge folios for guest_memfd.

This patch also introduces guestmem_allocator_operations as a set of
operations that allocators for guest_memfd can provide. In a later
patch, guest_memfd will use these operations to manage pages from an
allocator.

The allocator operations are memory-management specific and are placed
in mm/ so key mm-specific functions do not have to be exposed
unnecessarily.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Change-Id: I3cafe111ea7b3c84755d7112ff8f8c541c11136d
---
 include/linux/guestmem.h      |  20 +++++
 include/uapi/linux/guestmem.h |  29 +++++++
 mm/Kconfig                    |   5 +-
 mm/guestmem_hugetlb.c         | 159 ++++++++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/guestmem.h
 create mode 100644 include/uapi/linux/guestmem.h

diff --git a/include/linux/guestmem.h b/include/linux/guestmem.h
new file mode 100644
index 000000000000..4b2d820274d9
--- /dev/null
+++ b/include/linux/guestmem.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_GUESTMEM_H
+#define _LINUX_GUESTMEM_H
+
+#include <linux/fs.h>
+
+struct guestmem_allocator_operations {
+	void *(*inode_setup)(size_t size, u64 flags);
+	void (*inode_teardown)(void *private, size_t inode_size);
+	struct folio *(*alloc_folio)(void *private);
+	/*
+	 * Returns the number of PAGE_SIZE pages in a page that this guestmem
+	 * allocator provides.
+	 */
+	size_t (*nr_pages_in_folio)(void *priv);
+};
+
+extern const struct guestmem_allocator_operations guestmem_hugetlb_ops;
+
+#endif
diff --git a/include/uapi/linux/guestmem.h b/include/uapi/linux/guestmem.h
new file mode 100644
index 000000000000..2e518682edd5
--- /dev/null
+++ b/include/uapi/linux/guestmem.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_GUESTMEM_H
+#define _UAPI_LINUX_GUESTMEM_H
+
+/*
+ * Huge page size must be explicitly defined when using the guestmem_hugetlb
+ * allocator for guest_memfd.  It is the responsibility of the application to
+ * know which sizes are supported on the running system.  See mmap(2) man page
+ * for details.
+ */
+
+#define GUESTMEM_HUGETLB_FLAG_SHIFT	58
+#define GUESTMEM_HUGETLB_FLAG_MASK	0x3fUL
+
+#define GUESTMEM_HUGETLB_FLAG_16KB	(14UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_64KB	(16UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_512KB	(19UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_1MB	(20UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_2MB	(21UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_8MB	(23UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_16MB	(24UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_32MB	(25UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_256MB	(28UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_512MB	(29UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_1GB	(30UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_2GB	(31UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+#define GUESTMEM_HUGETLB_FLAG_16GB	(34UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
+
+#endif /* _UAPI_LINUX_GUESTMEM_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 131adc49f58d..bb6e39e37245 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1218,7 +1218,10 @@ config SECRETMEM
 
 config GUESTMEM_HUGETLB
 	bool "Enable guestmem_hugetlb allocator for guest_memfd"
-	depends on HUGETLBFS
+	select GUESTMEM
+	select HUGETLBFS
+	select HUGETLB_PAGE
+	select HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	help
 	  Enable this to make HugeTLB folios available to guest_memfd
 	  (KVM virtualization) as backing memory.
diff --git a/mm/guestmem_hugetlb.c b/mm/guestmem_hugetlb.c
index 51a724ebcc50..5459ef7eb329 100644
--- a/mm/guestmem_hugetlb.c
+++ b/mm/guestmem_hugetlb.c
@@ -5,6 +5,14 @@
  */
 
 #include <linux/mm_types.h>
+#include <linux/guestmem.h>
+#include <linux/hugetlb.h>
+#include <linux/hugetlb_cgroup.h>
+#include <linux/mempolicy.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+
+#include <uapi/linux/guestmem.h>
 
 #include "guestmem_hugetlb.h"
 
@@ -12,3 +20,154 @@ void guestmem_hugetlb_handle_folio_put(struct folio *folio)
 {
 	WARN_ONCE(1, "A placeholder that shouldn't trigger. Work in progress.");
 }
+
+struct guestmem_hugetlb_private {
+	struct hstate *h;
+	struct hugepage_subpool *spool;
+	struct hugetlb_cgroup *h_cg_rsvd;
+};
+
+static size_t guestmem_hugetlb_nr_pages_in_folio(void *priv)
+{
+	struct guestmem_hugetlb_private *private = priv;
+
+	return pages_per_huge_page(private->h);
+}
+
+static void *guestmem_hugetlb_setup(size_t size, u64 flags)
+
+{
+	struct guestmem_hugetlb_private *private;
+	struct hugetlb_cgroup *h_cg_rsvd = NULL;
+	struct hugepage_subpool *spool;
+	unsigned long nr_pages;
+	int page_size_log;
+	struct hstate *h;
+	long hpages;
+	int idx;
+	int ret;
+
+	page_size_log = (flags >> GUESTMEM_HUGETLB_FLAG_SHIFT) &
+			GUESTMEM_HUGETLB_FLAG_MASK;
+	h = hstate_sizelog(page_size_log);
+	if (!h)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Check against h because page_size_log could be 0 to request default
+	 * HugeTLB page size.
+	 */
+	if (!IS_ALIGNED(size, huge_page_size(h)))
+		return ERR_PTR(-EINVAL);
+
+	private = kzalloc(sizeof(*private), GFP_KERNEL);
+	if (!private)
+		return ERR_PTR(-ENOMEM);
+
+	/* Creating a subpool makes reservations, hence charge for them now. */
+	idx = hstate_index(h);
+	nr_pages = size >> PAGE_SHIFT;
+	ret = hugetlb_cgroup_charge_cgroup_rsvd(idx, nr_pages, &h_cg_rsvd);
+	if (ret)
+		goto err_free;
+
+	hpages = size >> huge_page_shift(h);
+	spool = hugepage_new_subpool(h, hpages, hpages, false);
+	if (!spool)
+		goto err_uncharge;
+
+	private->h = h;
+	private->spool = spool;
+	private->h_cg_rsvd = h_cg_rsvd;
+
+	return private;
+
+err_uncharge:
+	ret = -ENOMEM;
+	hugetlb_cgroup_uncharge_cgroup_rsvd(idx, nr_pages, h_cg_rsvd);
+err_free:
+	kfree(private);
+	return ERR_PTR(ret);
+}
+
+static void guestmem_hugetlb_teardown(void *priv, size_t inode_size)
+{
+	struct guestmem_hugetlb_private *private = priv;
+	unsigned long nr_pages;
+	int idx;
+
+	hugepage_put_subpool(private->spool);
+
+	idx = hstate_index(private->h);
+	nr_pages = inode_size >> PAGE_SHIFT;
+	hugetlb_cgroup_uncharge_cgroup_rsvd(idx, nr_pages, private->h_cg_rsvd);
+
+	kfree(private);
+}
+
+static struct folio *guestmem_hugetlb_alloc_folio(void *priv)
+{
+	struct guestmem_hugetlb_private *private = priv;
+	struct mempolicy *mpol;
+	struct folio *folio;
+	pgoff_t ilx;
+	int ret;
+
+	ret = hugepage_subpool_get_pages(private->spool, 1);
+	if (ret == -ENOMEM) {
+		return ERR_PTR(-ENOMEM);
+	} else if (ret > 0) {
+		/* guest_memfd will not use surplus pages. */
+		goto err_put_pages;
+	}
+
+	/*
+	 * TODO: mempolicy would probably have to be stored on the inode, use
+	 * task policy for now.
+	 */
+	mpol = get_task_policy(current);
+
+	/* TODO: ignore interleaving for now. */
+	ilx = NO_INTERLEAVE_INDEX;
+
+	/*
+	 * charge_cgroup_rsvd is false because we already charged reservations
+	 * when creating the subpool for this
+	 * guest_memfd. use_existing_reservation is true - we're using a
+	 * reservation from the guest_memfd's subpool.
+	 */
+	folio = hugetlb_alloc_folio(private->h, mpol, ilx, false, true);
+	mpol_cond_put(mpol);
+
+	if (IS_ERR_OR_NULL(folio))
+		goto err_put_pages;
+
+	/*
+	 * Clear restore_reserve here so that when this folio is freed,
+	 * free_huge_folio() will always attempt to return the reservation to
+	 * the subpool.  guest_memfd, unlike regular hugetlb, has no resv_map,
+	 * and hence when freeing, the folio needs to be returned to the
+	 * subpool.  guest_memfd does not use surplus hugetlb pages, so in
+	 * free_huge_folio(), returning to subpool will always succeed and the
+	 * hstate reservation will then get restored.
+	 *
+	 * hugetlbfs does this in hugetlb_add_to_page_cache().
+	 */
+	folio_clear_hugetlb_restore_reserve(folio);
+
+	hugetlb_set_folio_subpool(folio, private->spool);
+
+	return folio;
+
+err_put_pages:
+	hugepage_subpool_put_pages(private->spool, 1);
+	return ERR_PTR(-ENOMEM);
+}
+
+const struct guestmem_allocator_operations guestmem_hugetlb_ops = {
+	.inode_setup = guestmem_hugetlb_setup,
+	.inode_teardown = guestmem_hugetlb_teardown,
+	.alloc_folio = guestmem_hugetlb_alloc_folio,
+	.nr_pages_in_folio = guestmem_hugetlb_nr_pages_in_folio,
+};
+EXPORT_SYMBOL_GPL(guestmem_hugetlb_ops);
-- 
2.49.0.1045.g170613ef41-goog


