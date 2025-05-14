Return-Path: <linux-fsdevel+bounces-49060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEA2AB7A07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8F31BA69CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3AB25C717;
	Wed, 14 May 2025 23:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mARadzej"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292D22CBF8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266234; cv=none; b=Yg9QxGHiJSpoiIAiEjM/l4+2DCp4iKOPn9EcdnU8GZRj4j9/k5K7AkWzcqfM3inzvpAVsZ4sxqE0jhgIKw8TmO/i4wCjalPkMmDENr6nZpGBw3J+cDNZaKXKxPyUquSHcaC4j9Z8tTBA3BNXxSjQAtWSdA+IH/HHu7ZESFOkob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266234; c=relaxed/simple;
	bh=WIiuIhBvEYQRoDVYaMe6Epa6jW56JZZDNHsLnkwv8LE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mk1XyxamSEOyyeV8diliIb8zZkMbMFm4jBevrKXU2vKN4q/gNPtVaPjvO15jqVtIp7n+i2aCQohdctKXaAZbTLQiCsrAGXdBZJDZlV5b3qcNt836S79dAoxXcUmEsGtwk79uRXQqF3UJhOjJS6MBDaXU4SSi0e0DUHutiXmeKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mARadzej; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2002bcaa55so157432a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266232; x=1747871032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfnYbWQzMmQc1PANKcXbyhh93wrWxLA5NUfiI2kZlfs=;
        b=mARadzejB9xaLag0baFW/aClRLPyi2wXmXmCQLxkqP3A7q8uU3atLorUOvL435O0l3
         ey3vbDghtzjtiXIx2ec9i+aDs2fUeI27wgLt+x/UmnfYIZMoe6LWQb9W+2KwrJbufhXs
         dePLiQykaaRLMeaZF7+MHJAqev6y217+sEjIEvvUmTqy/ecmMQpcp6cUGh1JSjD33YWC
         4xktAJdcC5Cw+9NmJhYSgzUi8Y9e5DiUTK8rarjl0nzV3jkNRtLP3TuYC/OXm1opdNY/
         ekYapZowZb3x4NaxLyrAKJ3Mq/XcnkPSkKsmi41tn/wI8gPmYWMsopGyzyaqAqnpPHH+
         ciWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266232; x=1747871032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfnYbWQzMmQc1PANKcXbyhh93wrWxLA5NUfiI2kZlfs=;
        b=Vw1MnlsjPV6XNmUkq1s5YqiLVk7zFH4WNa5ZUrKiGz4C7Z91bdtt4Cmtf+EXGVylhs
         N7Iy27ozekgv17u80XpdFtsC+OGPuZ7IyDj+MURWmD5CBMrkECpYKWcW7mx/c+fjVyYk
         F6H8TN8fuF9prIEAouubevee2Cizw08Qt/QKIvK6Ab3xtogZMuGXsGhzKFqztohm/d5s
         IkGXWJUb8vl6aFBgVV+hKXktW+z23aK7OsLHtLugIk6E0o8VrY19apTbwwJZF5789Bpk
         eiq95rWWJ8XtRE6zpfik4r8T6DaqExq6/YnhukSMrRqnhFVQAC78qKbEAXop8Mo3Om2r
         GVhA==
X-Forwarded-Encrypted: i=1; AJvYcCWwScJJ9l63B7HM/Vt7EY8YMMEGzbCuBGB+sPowM0Tus2h9DSL9jCjOYoKc0tyH52hbqNv49kdTA92N/SLW@vger.kernel.org
X-Gm-Message-State: AOJu0YyYr//VY5BmeZQziWU5lX6XGvPFPpWEc2RuvUUJZrFH5vNLjYqm
	1LxPXstHTl8nePbVqn5d/jEQ+ETR7jzHS86iuUpmKkyd7wYUlzqw1caUfNdTh3m/dyLD9wYRLpG
	4ksAYkBbCPEauA6Tif4f9rQ==
X-Google-Smtp-Source: AGHT+IFVGcqlDEnJpkFEd+R21FoPe5Rerk1Iq1HXA53kK0tkVEoANeobibZBnoWnktKVrpAkNdhU2ptVfud0MkCE0w==
X-Received: from pji8.prod.google.com ([2002:a17:90b:3fc8:b0:2ea:5084:5297])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4acb:b0:2ee:b4bf:2d06 with SMTP id 98e67ed59e1d1-30e2e6133d8mr7435241a91.19.1747266231568;
 Wed, 14 May 2025 16:43:51 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:14 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <2ae41e0d80339da2b57011622ac2288fed65cd01.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 35/51] mm: guestmem_hugetlb: Add support for splitting
 and merging pages
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

These functions allow guest_memfd to split and merge HugeTLB pages,
and clean them up on freeing the page.

For merging and splitting pages on conversion, guestmem_hugetlb
expects the refcount on the pages to already be 0. The caller must
ensure that.

For conversions, guest_memfd ensures that the refcounts are already 0
by checking that there are no unexpected refcounts, and then freezing
the expected refcounts away. On unexpected refcounts, guest_memfd will
return an error to userspace.

For truncation, on unexpected refcounts, guest_memfd will return an
error to userspace.

For truncation on closing, guest_memfd will just remove its own
refcounts (the filemap refcounts) and mark split pages with
PGTY_guestmem_hugetlb.

The presence of PGTY_guestmem_hugetlb will trigger the folio_put()
callback to handle further cleanup. This cleanup process will merge
pages (with refcount 0, since cleanup is triggered from folio_put())
before returning the pages to HugeTLB.

Since the merging process is long, it is deferred to a worker thread
since folio_put() could be called from atomic context.

Change-Id: Ib04a3236f1e7250fd9af827630c334d40fb09d40
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 include/linux/guestmem.h |   3 +
 mm/guestmem_hugetlb.c    | 349 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 347 insertions(+), 5 deletions(-)

diff --git a/include/linux/guestmem.h b/include/linux/guestmem.h
index 4b2d820274d9..3ee816d1dd34 100644
--- a/include/linux/guestmem.h
+++ b/include/linux/guestmem.h
@@ -8,6 +8,9 @@ struct guestmem_allocator_operations {
 	void *(*inode_setup)(size_t size, u64 flags);
 	void (*inode_teardown)(void *private, size_t inode_size);
 	struct folio *(*alloc_folio)(void *private);
+	int (*split_folio)(struct folio *folio);
+	void (*merge_folio)(struct folio *folio);
+	void (*free_folio)(struct folio *folio);
 	/*
 	 * Returns the number of PAGE_SIZE pages in a page that this guestmem
 	 * allocator provides.
diff --git a/mm/guestmem_hugetlb.c b/mm/guestmem_hugetlb.c
index ec5a188ca2a7..8727598cf18e 100644
--- a/mm/guestmem_hugetlb.c
+++ b/mm/guestmem_hugetlb.c
@@ -11,15 +11,12 @@
 #include <linux/mm.h>
 #include <linux/mm_types.h>
 #include <linux/pagemap.h>
+#include <linux/xarray.h>
 
 #include <uapi/linux/guestmem.h>
 
 #include "guestmem_hugetlb.h"
-
-void guestmem_hugetlb_handle_folio_put(struct folio *folio)
-{
-	WARN_ONCE(1, "A placeholder that shouldn't trigger. Work in progress.");
-}
+#include "hugetlb_vmemmap.h"
 
 struct guestmem_hugetlb_private {
 	struct hstate *h;
@@ -34,6 +31,339 @@ static size_t guestmem_hugetlb_nr_pages_in_folio(void *priv)
 	return pages_per_huge_page(private->h);
 }
 
+static DEFINE_XARRAY(guestmem_hugetlb_stash);
+
+struct guestmem_hugetlb_metadata {
+	void *_hugetlb_subpool;
+	void *_hugetlb_cgroup;
+	void *_hugetlb_hwpoison;
+	void *private;
+};
+
+struct guestmem_hugetlb_stash_item {
+	struct guestmem_hugetlb_metadata hugetlb_metadata;
+	/* hstate tracks the original size of this folio. */
+	struct hstate *h;
+	/* Count of split pages, individually freed, waiting to be merged. */
+	atomic_t nr_pages_waiting_to_be_merged;
+};
+
+struct workqueue_struct *guestmem_hugetlb_wq __ro_after_init;
+static struct work_struct guestmem_hugetlb_cleanup_work;
+static LLIST_HEAD(guestmem_hugetlb_cleanup_list);
+
+static inline void guestmem_hugetlb_register_folio_put_callback(struct folio *folio)
+{
+	__folio_set_guestmem_hugetlb(folio);
+}
+
+static inline void guestmem_hugetlb_unregister_folio_put_callback(struct folio *folio)
+{
+	__folio_clear_guestmem_hugetlb(folio);
+}
+
+static inline void guestmem_hugetlb_defer_cleanup(struct folio *folio)
+{
+	struct llist_node *node;
+
+	/*
+	 * Reuse the folio->mapping pointer as a struct llist_node, since
+	 * folio->mapping is NULL at this point.
+	 */
+	BUILD_BUG_ON(sizeof(folio->mapping) != sizeof(struct llist_node));
+	node = (struct llist_node *)&folio->mapping;
+
+	/*
+	 * Only schedule work if list is previously empty. Otherwise,
+	 * schedule_work() had been called but the workfn hasn't retrieved the
+	 * list yet.
+	 */
+	if (llist_add(node, &guestmem_hugetlb_cleanup_list))
+		queue_work(guestmem_hugetlb_wq, &guestmem_hugetlb_cleanup_work);
+}
+
+void guestmem_hugetlb_handle_folio_put(struct folio *folio)
+{
+	guestmem_hugetlb_unregister_folio_put_callback(folio);
+
+	/*
+	 * folio_put() can be called in interrupt context, hence do the work
+	 * outside of interrupt context
+	 */
+	guestmem_hugetlb_defer_cleanup(folio);
+}
+
+/*
+ * Stash existing hugetlb metadata. Use this function just before splitting a
+ * hugetlb page.
+ */
+static inline void
+__guestmem_hugetlb_stash_metadata(struct guestmem_hugetlb_metadata *metadata,
+				  struct folio *folio)
+{
+	/*
+	 * (folio->page + 1) doesn't have to be stashed since those fields are
+	 * known on split/reconstruct and will be reinitialized anyway.
+	 */
+
+	/*
+	 * subpool is created for every guest_memfd inode, but the folios will
+	 * outlive the inode, hence we store the subpool here.
+	 */
+	metadata->_hugetlb_subpool = folio->_hugetlb_subpool;
+	/*
+	 * _hugetlb_cgroup has to be stored for freeing
+	 * later. _hugetlb_cgroup_rsvd does not, since it is NULL for
+	 * guest_memfd folios anyway. guest_memfd reservations are handled in
+	 * the inode.
+	 */
+	metadata->_hugetlb_cgroup = folio->_hugetlb_cgroup;
+	metadata->_hugetlb_hwpoison = folio->_hugetlb_hwpoison;
+
+	/*
+	 * HugeTLB flags are stored in folio->private. stash so that ->private
+	 * can be used by core-mm.
+	 */
+	metadata->private = folio->private;
+}
+
+static int guestmem_hugetlb_stash_metadata(struct folio *folio)
+{
+	XA_STATE(xas, &guestmem_hugetlb_stash, 0);
+	struct guestmem_hugetlb_stash_item *stash;
+	void *entry;
+
+	stash = kzalloc(sizeof(*stash), 1);
+	if (!stash)
+		return -ENOMEM;
+
+	stash->h = folio_hstate(folio);
+	__guestmem_hugetlb_stash_metadata(&stash->hugetlb_metadata, folio);
+
+	xas_set_order(&xas, folio_pfn(folio), folio_order(folio));
+
+	xas_lock(&xas);
+	entry = xas_store(&xas, stash);
+	xas_unlock(&xas);
+
+	if (xa_is_err(entry)) {
+		kfree(stash);
+		return xa_err(entry);
+	}
+
+	return 0;
+}
+
+static inline void
+__guestmem_hugetlb_unstash_metadata(struct guestmem_hugetlb_metadata *metadata,
+				    struct folio *folio)
+{
+	folio->_hugetlb_subpool = metadata->_hugetlb_subpool;
+	folio->_hugetlb_cgroup = metadata->_hugetlb_cgroup;
+	folio->_hugetlb_cgroup_rsvd = NULL;
+	folio->_hugetlb_hwpoison = metadata->_hugetlb_hwpoison;
+
+	folio_change_private(folio, metadata->private);
+}
+
+static int guestmem_hugetlb_unstash_free_metadata(struct folio *folio)
+{
+	struct guestmem_hugetlb_stash_item *stash;
+	unsigned long pfn;
+
+	pfn = folio_pfn(folio);
+
+	stash = xa_erase(&guestmem_hugetlb_stash, pfn);
+	__guestmem_hugetlb_unstash_metadata(&stash->hugetlb_metadata, folio);
+
+	kfree(stash);
+
+	return 0;
+}
+
+/**
+ * guestmem_hugetlb_split_folio() - Split a HugeTLB @folio to PAGE_SIZE pages.
+ *
+ * @folio: The folio to be split.
+ *
+ * Context: Before splitting, the folio must have a refcount of 0. After
+ *          splitting, each split folio has a refcount of 0.
+ * Return: 0 on success and negative error otherwise.
+ */
+static int guestmem_hugetlb_split_folio(struct folio *folio)
+{
+	long orig_nr_pages;
+	int ret;
+	int i;
+
+	if (folio_size(folio) == PAGE_SIZE)
+		return 0;
+
+	orig_nr_pages = folio_nr_pages(folio);
+	ret = guestmem_hugetlb_stash_metadata(folio);
+	if (ret)
+		return ret;
+
+	/*
+	 * hugetlb_vmemmap_restore_folio() has to be called ahead of the rest
+	 * because it checks and page type. This doesn't actually split the
+	 * folio, so the first few struct pages are still intact.
+	 */
+	ret = hugetlb_vmemmap_restore_folio(folio_hstate(folio), folio);
+	if (ret)
+		goto err;
+
+	/*
+	 * Can clear without lock because this will not race with the folio
+	 * being mapped. folio's page type is overlaid with mapcount and so in
+	 * other cases it's necessary to take hugetlb_lock to prevent races with
+	 * mapcount increasing.
+	 */
+	__folio_clear_hugetlb(folio);
+
+	/*
+	 * Remove the first folio from h->hugepage_activelist since it is no
+	 * longer a HugeTLB page. The other split pages should not be on any
+	 * lists.
+	 */
+	hugetlb_folio_list_del(folio);
+
+	/* Actually split page by undoing prep_compound_page() */
+	__folio_clear_head(folio);
+
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+	/*
+	 * Zero out _nr_pages, otherwise this overlaps with memcg_data,
+	 * resulting in lookups on false memcg_data.  _nr_pages doesn't have to
+	 * be set to 1 because folio_nr_pages() relies on the presence of the
+	 * head flag to return 1 for nr_pages.
+	 */
+	folio->_nr_pages = 0;
+#endif
+
+	for (i = 1; i < orig_nr_pages; ++i) {
+		struct page *p = folio_page(folio, i);
+
+		/* Copy flags from the first page to split pages. */
+		p->flags = folio->flags;
+
+		p->mapping = NULL;
+		clear_compound_head(p);
+	}
+
+	return 0;
+
+err:
+	guestmem_hugetlb_unstash_free_metadata(folio);
+
+	return ret;
+}
+
+/**
+ * guestmem_hugetlb_merge_folio() - Merge a HugeTLB folio from the folio
+ * beginning @first_folio.
+ *
+ * @first_folio: the first folio in a contiguous block of folios to be merged.
+ *
+ * The size of the contiguous block is tracked in guestmem_hugetlb_stash.
+ *
+ * Context: The first folio is checked to have a refcount of 0 before
+ *          reconstruction. After reconstruction, the reconstructed folio has a
+ *          refcount of 0.
+ */
+static void guestmem_hugetlb_merge_folio(struct folio *first_folio)
+{
+	struct guestmem_hugetlb_stash_item *stash;
+	struct hstate *h;
+
+	stash = xa_load(&guestmem_hugetlb_stash, folio_pfn(first_folio));
+	h = stash->h;
+
+	/*
+	 * This is the step that does the merge. prep_compound_page() will write
+	 * to pages 1 and 2 as well, so guestmem_unstash_hugetlb_metadata() has
+	 * to come after this.
+	 */
+	prep_compound_page(&first_folio->page, huge_page_order(h));
+
+	WARN_ON(guestmem_hugetlb_unstash_free_metadata(first_folio));
+
+	/*
+	 * prep_compound_page() will set up mapping on tail pages. For
+	 * completeness, clear mapping on head page.
+	 */
+	first_folio->mapping = NULL;
+
+	__folio_set_hugetlb(first_folio);
+
+	hugetlb_folio_list_add(first_folio, &h->hugepage_activelist);
+
+	hugetlb_vmemmap_optimize_folio(h, first_folio);
+}
+
+static struct folio *guestmem_hugetlb_maybe_merge_folio(struct folio *folio)
+{
+	struct guestmem_hugetlb_stash_item *stash;
+	unsigned long first_folio_pfn;
+	struct folio *first_folio;
+	unsigned long pfn;
+	size_t nr_pages;
+
+	pfn = folio_pfn(folio);
+
+	stash = xa_load(&guestmem_hugetlb_stash, pfn);
+	nr_pages = pages_per_huge_page(stash->h);
+	if (atomic_inc_return(&stash->nr_pages_waiting_to_be_merged) < nr_pages)
+		return NULL;
+
+	first_folio_pfn = round_down(pfn, nr_pages);
+	first_folio = pfn_folio(first_folio_pfn);
+
+	guestmem_hugetlb_merge_folio(first_folio);
+
+	return first_folio;
+}
+
+static void guestmem_hugetlb_cleanup_folio(struct folio *folio)
+{
+	struct folio *merged_folio;
+
+	merged_folio = guestmem_hugetlb_maybe_merge_folio(folio);
+	if (merged_folio)
+		__folio_put(merged_folio);
+}
+
+static void guestmem_hugetlb_cleanup_workfn(struct work_struct *work)
+{
+	struct llist_node *node;
+
+	node = llist_del_all(&guestmem_hugetlb_cleanup_list);
+	while (node) {
+		struct folio *folio;
+
+		folio = container_of((struct address_space **)node,
+				     struct folio, mapping);
+
+		node = node->next;
+		folio->mapping = NULL;
+
+		guestmem_hugetlb_cleanup_folio(folio);
+	}
+}
+
+static int __init guestmem_hugetlb_init(void)
+{
+	INIT_WORK(&guestmem_hugetlb_cleanup_work, guestmem_hugetlb_cleanup_workfn);
+
+	guestmem_hugetlb_wq = alloc_workqueue("guestmem_hugetlb",
+					      WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
+	if (!guestmem_hugetlb_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+subsys_initcall(guestmem_hugetlb_init);
+
 static void *guestmem_hugetlb_setup(size_t size, u64 flags)
 
 {
@@ -164,10 +494,19 @@ static struct folio *guestmem_hugetlb_alloc_folio(void *priv)
 	return ERR_PTR(-ENOMEM);
 }
 
+static void guestmem_hugetlb_free_folio(struct folio *folio)
+{
+	if (xa_load(&guestmem_hugetlb_stash, folio_pfn(folio)))
+		guestmem_hugetlb_register_folio_put_callback(folio);
+}
+
 const struct guestmem_allocator_operations guestmem_hugetlb_ops = {
 	.inode_setup = guestmem_hugetlb_setup,
 	.inode_teardown = guestmem_hugetlb_teardown,
 	.alloc_folio = guestmem_hugetlb_alloc_folio,
+	.split_folio = guestmem_hugetlb_split_folio,
+	.merge_folio = guestmem_hugetlb_merge_folio,
+	.free_folio = guestmem_hugetlb_free_folio,
 	.nr_pages_in_folio = guestmem_hugetlb_nr_pages_in_folio,
 };
 EXPORT_SYMBOL_GPL(guestmem_hugetlb_ops);
-- 
2.49.0.1045.g170613ef41-goog


