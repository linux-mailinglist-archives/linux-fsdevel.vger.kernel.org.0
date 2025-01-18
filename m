Return-Path: <linux-fsdevel+bounces-39595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCFEA15F3F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 00:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F4E1886E8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 23:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747F21DED45;
	Sat, 18 Jan 2025 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFIZVB0f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED41ACEC7
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737242184; cv=none; b=gURcjfK2JGrEFsu8gj8ngp7MW6QZDShWAkRx8LMDznsTzpWbfSjyW05N7B7wa95unH55cex0ijPCvmn3bIwuR/4k5jNZBbIorc2f14n0hedzW5cWNcyH+qHNbNLdrheuzf9vynoy12MP1Hv6lxQYDIT3fVfUA5zSk4+mFFQNxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737242184; c=relaxed/simple;
	bh=HFWgIX5XahXV+2Tg4gkiXWkjIkrR+CzfrGOzy9aK/tQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B0MrODmJS1bYnFjeqC6ceA/zzNddN51Lq+oaABJdYcauD1ymk/3ofJOtgwDBcVAiHy4gX8PT3qJ3Ycd2+SXtHqpScX1TjkF22PhNzP7PIYhTGq+9RBhVFe130j3JTo3ku+bcByMEKNcVt8AdB7cLpJH1XfG44ZCJPgq40p7IMK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFIZVB0f; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso6279812a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 15:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737242181; x=1737846981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nm402TQHrDxI1EFlR658V6OFFFRpysLj2Dms4H1rJPY=;
        b=lFIZVB0fA6myY8TFV4ZY2wpdibLcG0nNIvaZvqNsGDwY/eHflGPZb2mSEzshSJNhZq
         G/iRoiLEoKTxDOisoN5UyqK6APuZFDK6DMbaM+YWjSMkZn0ngNtygAqwRCMs5KtaLagJ
         o9oIM/NGcvx1bkJ3+oolcJU4mExt87SNBFuU1khEmSE/LIi/jrBXJfn7XFmkvA6+6T46
         PuxAryOPdwOOrSNYiP8w+W3IsH7WLeWHhoHqWzAuDhtBZjQiqwGcOANsd1s73/Vi/blC
         J1QPQxWvnzzx6gUz1+mVEU/IWWrsU4/pf+ckljlHq8PJc/8J0Aqf3TB0IsGboSG8qAZq
         xghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737242181; x=1737846981;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nm402TQHrDxI1EFlR658V6OFFFRpysLj2Dms4H1rJPY=;
        b=i8AkEqGIQLFftL53zITtPWWUeZCHglecRu/iq4XeFjI1/5zhIwNZZ2ojWph/IdpBIb
         ILGhLonGpLrrRjMa+7jjGE85/hd3pHs3WWAH0yJgWOTEAt2DieIdLWPVyHh9RYp6Qc/W
         VUfeP/IoADvpWKJb3dAC6V2MogqSjrOk+OFw87ebqZmG9psEflfjFF+J/qyedigIQB0/
         nfxH/rRfalJvBixGFUl/tyLyadFOd43PlFWs6lnJfSnPxC719c4oOvgxVHyH/uf1vJU6
         0oURlq76a2cAAHjKVEXMzczlCqczfXOzs/RoRh/mf5V++In6ozmhzcnz0fjjloeoFRuF
         cFdg==
X-Forwarded-Encrypted: i=1; AJvYcCVTXIMs2iChMDey4l4ETCjuMj9HURpgqjHahkurkJ7XUazF3hGblbQ8wiJboYXDf35UncOLmIEQyaGLMDEL@vger.kernel.org
X-Gm-Message-State: AOJu0YyTP2nZc/34O534gQEF/MOXXRMg1fet4efqOOuQF+6HmZlnk+ml
	2dLbipj4yskBb2EneoLnV/jOmXOltV8VnYSJz8GsiWImezLRMWI2RZucPL4oYM0AjV5tu0SP2OI
	i2bmSsYSjtQ==
X-Google-Smtp-Source: AGHT+IEpzJwcasigO7Z3LrZTdDEMveaU0rSOtpGiX7RzVESFnj1S0Tl/DAer+e37P1pFsn3VS6RTQfwq+n76Gg==
X-Received: from pjlk5.prod.google.com ([2002:a17:90a:7f05:b0:2ea:aa56:49c])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:37ce:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2f782d6f0b9mr12295296a91.33.1737242181329;
 Sat, 18 Jan 2025 15:16:21 -0800 (PST)
Date: Sat, 18 Jan 2025 23:15:47 +0000
In-Reply-To: <20250118231549.1652825-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250118231549.1652825-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250118231549.1652825-2-jiaqiyan@google.com>
Subject: [RFC PATCH v1 1/3] mm: memfd/hugetlb: introduce userspace memory
 failure recovery policy
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, david@redhat.com, dave.hansen@linux.intel.com, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sometimes immediately hard offlining memory page having uncorrected
memory errors (UE) may not be the best option for capacity and/or
performance reasons. "Sometimes" even becomes "often times" in Cloud
scenarios. See cover letter for the descriptions to two scenarios.

Therefore keeping or discarding a large chunk of contiguous memory
mapped to userspace (particularly to serve guest memory) due to
UE (recoverable is implied) should be able to be controlled by
userspace process, e.g. VMM in Cloud environment.

Given the relevance of HugeTLB's non-ideal memory failure recovery
behavior, this commit uses HugeTLB as the "testbed" to demonstrate the
idea of memfd-based userspace memory failure policy.

MFD_MF_KEEP_UE_MAPPED is added to the possible values for flags in
memfd_create syscall. It is intended to be generic for any memfd,
not just HugeTLB, but the current implementation only covers HugeTLB.

When MFD_MF_KEEP_UE_MAPPED is set in flags, memory failure recovery
in the kernel doesn=E2=80=99t hard offline memory due to UE until the creat=
ed
memfd is released or the affected memory region is truncated by
userspace. IOW, the HWPoison-ed memory remains accessible via
the returned memfd or the memory mapping created with that memfd.
However, the affected memory will be immediately protected and isolated
from future use by both kernel and userspace once the owning memfd is
gone or the memory is truncated. By default MFD_MF_KEEP_UE_MAPPED is
not set, and kernel hard offlines memory having UEs.

Tested with selftest in followup patch.

This commit should probably be split into smaller pieces, but for now
I will defer it until this RFC becomes PATCH.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 fs/hugetlbfs/inode.c       |  16 +++++
 include/linux/hugetlb.h    |   7 +++
 include/linux/pagemap.h    |  43 ++++++++++++++
 include/uapi/linux/memfd.h |   1 +
 mm/filemap.c               |  78 ++++++++++++++++++++++++
 mm/hugetlb.c               |  20 ++++++-
 mm/memfd.c                 |  15 ++++-
 mm/memory-failure.c        | 119 +++++++++++++++++++++++++++++++++----
 8 files changed, 282 insertions(+), 17 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 0fc179a598300..3c7812898717b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -576,6 +576,10 @@ static void remove_inode_hugepages(struct inode *inode=
, loff_t lstart,
 	pgoff_t next, index;
 	int i, freed =3D 0;
 	bool truncate_op =3D (lend =3D=3D LLONG_MAX);
+	LIST_HEAD(hwp_folios);
+
+	/* Needs to be done before removing folios from filemap. */
+	populate_memfd_hwp_folios(mapping, lstart >> PAGE_SHIFT, end, &hwp_folios=
);
=20
 	folio_batch_init(&fbatch);
 	next =3D lstart >> PAGE_SHIFT;
@@ -605,6 +609,18 @@ static void remove_inode_hugepages(struct inode *inode=
, loff_t lstart,
 		(void)hugetlb_unreserve_pages(inode,
 				lstart >> huge_page_shift(h),
 				LONG_MAX, freed);
+	/*
+	 * hugetlbfs_error_remove_folio keeps the HWPoison-ed pages in
+	 * page cache until mm wants to drop the folio at the end of the
+	 * of the filemap. At this point, if memory failure was delayed
+	 * by AS_MF_KEEP_UE_MAPPED in the past, we can now deal with it.
+	 *
+	 * TODO: in V2 we can probably get rid of populate_memfd_hwp_folios
+	 * and hwp_folios, by inserting filemap_offline_hwpoison_folio
+	 * into somewhere in folio_batch_release, or into per file system's
+	 * free_folio handler.
+	 */
+	offline_memfd_hwp_folios(mapping, &hwp_folios);
 }
=20
 static void hugetlbfs_evict_inode(struct inode *inode)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ec8c0ccc8f959..07d2a31146728 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -836,10 +836,17 @@ int dissolve_free_hugetlb_folios(unsigned long start_=
pfn,
=20
 #ifdef CONFIG_MEMORY_FAILURE
 extern void folio_clear_hugetlb_hwpoison(struct folio *folio);
+extern bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
+						struct address_space *mapping);
 #else
 static inline void folio_clear_hugetlb_hwpoison(struct folio *folio)
 {
 }
+static inline bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio
+						       struct address_space *mapping)
+{
+	return false;
+}
 #endif
=20
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fc2e1319c7bb5..fad7093d232a9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,6 +210,12 @@ enum mapping_flags {
 	AS_STABLE_WRITES =3D 7,	/* must wait for writeback before modifying
 				   folio contents */
 	AS_INACCESSIBLE =3D 8,	/* Do not attempt direct R/W access to the mapping=
 */
+	/*
+	 * Keeps folios belong to the mapping mapped even if uncorrectable memory
+	 * errors (UE) caused memory failure (MF) within the folio. Only at the e=
nd
+	 * of mapping will its HWPoison-ed folios be dealt with.
+	 */
+	AS_MF_KEEP_UE_MAPPED =3D 9,
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS =3D 5,
 	AS_FOLIO_ORDER_MIN =3D 16,
@@ -335,6 +341,16 @@ static inline bool mapping_inaccessible(struct address=
_space *mapping)
 	return test_bit(AS_INACCESSIBLE, &mapping->flags);
 }
=20
+static inline bool mapping_mf_keep_ue_mapped(struct address_space *mapping=
)
+{
+	return test_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
+}
+
+static inline void mapping_set_mf_keep_ue_mapped(struct address_space *map=
ping)
+{
+	set_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
 	return mapping->gfp_mask;
@@ -1298,6 +1314,33 @@ void replace_page_cache_folio(struct folio *old, str=
uct folio *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct folio_batch *fbatch);
 bool filemap_release_folio(struct folio *folio, gfp_t gfp);
+#ifdef CONFIG_MEMORY_FAILURE
+void populate_memfd_hwp_folios(struct address_space *mapping,
+			       pgoff_t lstart, pgoff_t lend,
+			       struct list_head *list);
+void offline_memfd_hwp_folios(struct address_space *mapping,
+			      struct list_head *list);
+/*
+ * Provided by memory failure to offline HWPoison-ed folio for various mem=
ory
+ * management systems (hugetlb, THP etc).
+ */
+void filemap_offline_hwpoison_folio(struct address_space *mapping,
+				    struct folio *folio);
+#else
+void populate_memfd_hwp_folios(struct address_space *mapping,
+			       loff_t lstart, loff_t lend,
+			       struct list_head *list)
+{
+}
+void offline_memfd_hwp_folios(struct address_space *mapping,
+			      struct list_head *list)
+{
+}
+void filemap_offline_hwpoison_folio(struct address_space *mapping,
+				    struct folio *folio)
+{
+}
+#endif
 loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t=
 end,
 		int whence);
=20
diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 273a4e15dfcff..eb7a4ffcae6b9 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -12,6 +12,7 @@
 #define MFD_NOEXEC_SEAL		0x0008U
 /* executable */
 #define MFD_EXEC		0x0010U
+#define MFD_MF_KEEP_UE_MAPPED	0x0020U
=20
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/filemap.c b/mm/filemap.c
index b6494d2d3bc2a..5216889d12ecf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4427,3 +4427,81 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
 	return 0;
 }
 #endif /* CONFIG_CACHESTAT_SYSCALL */
+
+#ifdef CONFIG_MEMORY_FAILURE
+/**
+ * To remember the HWPoison-ed folios within a mapping before removing eve=
ry
+ * folio, create an utility struct to link them a list.
+ */
+struct memfd_hwp_folio {
+	struct list_head node;
+	struct folio *folio;
+};
+/**
+ * populate_memfd_hwp_folios - populates HWPoison-ed folios.
+ * @mapping: The address_space of a memfd the kernel is trying to remove o=
r truncate.
+ * @start: The starting page index.
+ * @end: The final page index (inclusive).
+ * @list: Where the HWPoison-ed folios will be stored into.
+ *
+ * There may be pending HWPoison-ed folios when a memfd is being removed o=
r
+ * part of it is being truncated. Stores them into a linked list to offlin=
e
+ * after the file system removes them.
+ */
+void populate_memfd_hwp_folios(struct address_space *mapping,
+			       pgoff_t start, pgoff_t end,
+			       struct list_head *list)
+{
+	int i;
+	struct folio *folio;
+	struct memfd_hwp_folio *to_add;
+	struct folio_batch fbatch;
+	pgoff_t next =3D start;
+
+	if (!mapping_mf_keep_ue_mapped(mapping))
+		return;
+
+	folio_batch_init(&fbatch);
+	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
+		for (i =3D 0; i < folio_batch_count(&fbatch); ++i) {
+			folio =3D fbatch.folios[i];
+			if (!folio_test_hwpoison(folio))
+				continue;
+
+			to_add =3D kmalloc(sizeof(*to_add), GFP_KERNEL);
+			if (!to_add)
+				continue;
+
+			to_add->folio =3D folio;
+			list_add_tail(&to_add->node, list);
+		}
+		folio_batch_release(&fbatch);
+	}
+}
+EXPORT_SYMBOL_GPL(populate_memfd_hwp_folios);
+
+/**
+ * offline_memfd_hwp_folios - hard offline HWPoison-ed folios.
+ * @mapping: The address_space of a memfd the kernel is trying to remove o=
r truncate.
+ * @list: Where the HWPoison-ed folios are stored. It will become empty wh=
en
+ *        offline_memfd_hwp_folios returns.
+ *
+ * After the file system removed all the folios belong to a memfd, the ker=
nel
+ * now can hard offline all HWPoison-ed folios that are previously pending=
.
+ * Caller needs to exclusively own @list as no locking is provided here, a=
nd
+ * @list is entirely consumed here.
+ */
+void offline_memfd_hwp_folios(struct address_space *mapping,
+			      struct list_head *list)
+{
+	struct memfd_hwp_folio *curr, *temp;
+
+	list_for_each_entry_safe(curr, temp, list, node) {
+		filemap_offline_hwpoison_folio(mapping, curr->folio);
+		list_del(&curr->node);
+		kfree(curr);
+	}
+}
+EXPORT_SYMBOL_GPL(offline_memfd_hwp_folios);
+
+#endif /* CONFIG_MEMORY_FAILURE */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 87761b042ed04..35e88d7fc2793 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6091,6 +6091,18 @@ static bool hugetlb_pte_stable(struct hstate *h, str=
uct mm_struct *mm, unsigned
 	return same;
 }
=20
+bool hugetlb_should_keep_hwpoison_mapped(struct folio *folio,
+					 struct address_space *mapping)
+{
+	if (WARN_ON_ONCE(!folio_test_hugetlb(folio)))
+		return false;
+
+	if (!mapping)
+		return false;
+
+	return mapping_mf_keep_ue_mapped(mapping);
+}
+
 static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			struct vm_fault *vmf)
 {
@@ -6214,9 +6226,11 @@ static vm_fault_t hugetlb_no_page(struct address_spa=
ce *mapping,
 		 * So we need to block hugepage fault by PG_hwpoison bit check.
 		 */
 		if (unlikely(folio_test_hwpoison(folio))) {
-			ret =3D VM_FAULT_HWPOISON_LARGE |
-				VM_FAULT_SET_HINDEX(hstate_index(h));
-			goto backout_unlocked;
+			if (!mapping_mf_keep_ue_mapped(mapping)) {
+				ret =3D VM_FAULT_HWPOISON_LARGE |
+				      VM_FAULT_SET_HINDEX(hstate_index(h));
+				goto backout_unlocked;
+			}
 		}
=20
 		/* Check for page in userfault range. */
diff --git a/mm/memfd.c b/mm/memfd.c
index 37f7be57c2f50..ddb9e988396c7 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -302,7 +302,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, u=
nsigned int arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
=20
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD=
_NOEXEC_SEAL | MFD_EXEC)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
+		       MFD_NOEXEC_SEAL | MFD_EXEC | MFD_MF_KEEP_UE_MAPPED)
=20
 static int check_sysctl_memfd_noexec(unsigned int *flags)
 {
@@ -376,6 +377,8 @@ static int sanitize_flags(unsigned int *flags_ptr)
 	if (!(flags & MFD_HUGETLB)) {
 		if (flags & ~(unsigned int)MFD_ALL_FLAGS)
 			return -EINVAL;
+		if (flags & MFD_MF_KEEP_UE_MAPPED)
+			return -EINVAL;
 	} else {
 		/* Allow huge page size encoding in flags. */
 		if (flags & ~(unsigned int)(MFD_ALL_FLAGS |
@@ -436,6 +439,16 @@ static struct file *alloc_file(const char *name, unsig=
ned int flags)
 	file->f_mode |=3D FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
 	file->f_flags |=3D O_LARGEFILE;
=20
+	/*
+	 * MFD_MF_KEEP_UE_MAPPED can only be specified in memfd_create; no API
+	 * to update it once memfd is created. MFD_MF_KEEP_UE_MAPPED is not
+	 * seal-able.
+	 *
+	 * TODO: MFD_MF_KEEP_UE_MAPPED is not supported by all file system yet.
+	 */
+	if (flags & (MFD_HUGETLB | MFD_MF_KEEP_UE_MAPPED))
+		mapping_set_mf_keep_ue_mapped(file->f_mapping);
+
 	if (flags & MFD_NOEXEC_SEAL) {
 		struct inode *inode =3D file_inode(file);
=20
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a7b8ccd29b6f5..f43607fb4310e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -445,11 +445,13 @@ static unsigned long dev_pagemap_mapping_shift(struct=
 vm_area_struct *vma,
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  */
-static void __add_to_kill(struct task_struct *tsk, const struct page *p,
+static void __add_to_kill(struct task_struct *tsk, struct page *p,
 			  struct vm_area_struct *vma, struct list_head *to_kill,
 			  unsigned long addr)
 {
 	struct to_kill *tk;
+	struct folio *folio;
+	struct address_space *mapping;
=20
 	tk =3D kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
 	if (!tk) {
@@ -460,8 +462,20 @@ static void __add_to_kill(struct task_struct *tsk, con=
st struct page *p,
 	tk->addr =3D addr;
 	if (is_zone_device_page(p))
 		tk->size_shift =3D dev_pagemap_mapping_shift(vma, tk->addr);
-	else
-		tk->size_shift =3D folio_shift(page_folio(p));
+	else {
+		folio =3D page_folio(p);
+		mapping =3D folio_mapping(folio);
+		if (mapping && mapping_mf_keep_ue_mapped(mapping))
+			/*
+			 * Let userspace know the radius of the hardware poison
+			 * is the size of raw page, and as long as they aborts
+			 * the load to the scope, other pages inside the folio
+			 * are still safe to access.
+			 */
+			tk->size_shift =3D PAGE_SHIFT;
+		else
+			tk->size_shift =3D folio_shift(folio);
+	}
=20
 	/*
 	 * Send SIGKILL if "tk->addr =3D=3D -EFAULT". Also, as
@@ -486,7 +500,7 @@ static void __add_to_kill(struct task_struct *tsk, cons=
t struct page *p,
 	list_add_tail(&tk->nd, to_kill);
 }
=20
-static void add_to_kill_anon_file(struct task_struct *tsk, const struct pa=
ge *p,
+static void add_to_kill_anon_file(struct task_struct *tsk, struct page *p,
 		struct vm_area_struct *vma, struct list_head *to_kill,
 		unsigned long addr)
 {
@@ -607,7 +621,7 @@ struct task_struct *task_early_kill(struct task_struct =
*tsk, int force_early)
  * Collect processes when the error hit an anonymous page.
  */
 static void collect_procs_anon(const struct folio *folio,
-		const struct page *page, struct list_head *to_kill,
+		struct page *page, struct list_head *to_kill,
 		int force_early)
 {
 	struct task_struct *tsk;
@@ -645,7 +659,7 @@ static void collect_procs_anon(const struct folio *foli=
o,
  * Collect processes when the error hit a file mapped page.
  */
 static void collect_procs_file(const struct folio *folio,
-		const struct page *page, struct list_head *to_kill,
+		struct page *page, struct list_head *to_kill,
 		int force_early)
 {
 	struct vm_area_struct *vma;
@@ -727,7 +741,7 @@ static void collect_procs_fsdax(const struct page *page=
,
 /*
  * Collect the processes who have the corrupted page mapped to kill.
  */
-static void collect_procs(const struct folio *folio, const struct page *pa=
ge,
+static void collect_procs(const struct folio *folio, struct page *page,
 		struct list_head *tokill, int force_early)
 {
 	if (!folio->mapping)
@@ -1226,6 +1240,13 @@ static int me_huge_page(struct page_state *ps, struc=
t page *p)
 		}
 	}
=20
+	/*
+	 * MF still needs to holds a refcount for the deferred actions in
+	 * filemap_offline_hwpoison_folio.
+	 */
+	if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
+		return res;
+
 	if (has_extra_refcount(ps, p, extra_pins))
 		res =3D MF_FAILED;
=20
@@ -1593,6 +1614,7 @@ static bool hwpoison_user_mappings(struct folio *foli=
o, struct page *p,
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
 	bool unmap_success;
+	bool keep_mapped;
 	int forcekill;
 	bool mlocked =3D folio_test_mlocked(folio);
=20
@@ -1643,10 +1665,12 @@ static bool hwpoison_user_mappings(struct folio *fo=
lio, struct page *p,
 	 */
 	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
=20
-	unmap_poisoned_folio(folio, ttu);
+	keep_mapped =3D hugetlb_should_keep_hwpoison_mapped(folio, mapping);
+	if (!keep_mapped)
+		unmap_poisoned_folio(folio, ttu);
=20
 	unmap_success =3D !folio_mapped(folio);
-	if (!unmap_success)
+	if (!unmap_success && !keep_mapped)
 		pr_err("%#lx: failed to unmap page (folio mapcount=3D%d)\n",
 		       pfn, folio_mapcount(folio));
=20
@@ -1671,7 +1695,7 @@ static bool hwpoison_user_mappings(struct folio *foli=
o, struct page *p,
 		    !unmap_success;
 	kill_procs(&tokill, forcekill, pfn, flags);
=20
-	return unmap_success;
+	return unmap_success || keep_mapped;
 }
=20
 static int identify_page_state(unsigned long pfn, struct page *p,
@@ -1911,6 +1935,9 @@ static unsigned long __folio_free_raw_hwp(struct foli=
o *folio, bool move_flag)
 	unsigned long count =3D 0;
=20
 	head =3D llist_del_all(raw_hwp_list_head(folio));
+	if (head =3D=3D NULL)
+		return 0;
+
 	llist_for_each_entry_safe(p, next, head, node) {
 		if (move_flag)
 			SetPageHWPoison(p->page);
@@ -1927,7 +1954,8 @@ static int folio_set_hugetlb_hwpoison(struct folio *f=
olio, struct page *page)
 	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
 	struct raw_hwp_page *p;
-	int ret =3D folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
+	struct address_space *mapping =3D folio->mapping;
+	bool has_hwpoison =3D folio_test_set_hwpoison(folio);
=20
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
@@ -1946,8 +1974,15 @@ static int folio_set_hugetlb_hwpoison(struct folio *=
folio, struct page *page)
 	if (raw_hwp) {
 		raw_hwp->page =3D page;
 		llist_add(&raw_hwp->node, head);
+		if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
+			/*
+			 * A new raw HWPoison page. Don't return HWPOISON.
+			 * Error event will be counted in action_result().
+			 */
+			return 0;
+
 		/* the first error event will be counted in action_result(). */
-		if (ret)
+		if (has_hwpoison)
 			num_poisoned_pages_inc(page_to_pfn(page));
 	} else {
 		/*
@@ -1962,7 +1997,8 @@ static int folio_set_hugetlb_hwpoison(struct folio *f=
olio, struct page *page)
 		 */
 		__folio_free_raw_hwp(folio, false);
 	}
-	return ret;
+
+	return has_hwpoison ? -EHWPOISON : 0;
 }
=20
 static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_fla=
g)
@@ -2051,6 +2087,63 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, =
int flags,
 	return ret;
 }
=20
+static void filemap_offline_hwpoison_folio_hugetlb(struct folio *folio)
+{
+	int ret;
+	struct llist_node *head;
+	struct raw_hwp_page *curr, *next;
+	struct page *page;
+	unsigned long pfn;
+
+	head =3D llist_del_all(raw_hwp_list_head(folio));
+
+	/*
+	 * Release references hold by try_memory_failure_hugetlb, one per
+	 * HWPoison-ed page in raw hwp list. This folio's refcount expects to
+	 * drop to zero after the below for-each loop.
+	 */
+	llist_for_each_entry(curr, head, node)
+		folio_put(folio);
+
+	ret =3D dissolve_free_hugetlb_folio(folio);
+	if (ret) {
+		pr_err("failed to dissolve hugetlb folio: %d\n", ret);
+		llist_for_each_entry(curr, head, node) {
+			page =3D curr->page;
+			pfn =3D page_to_pfn(page);
+			/*
+			 * TODO: roll back the count incremented during online
+			 * handling, i.e. whatever me_huge_page returns.
+			 */
+			update_per_node_mf_stats(pfn, MF_FAILED);
+		}
+		return;
+	}
+
+	llist_for_each_entry_safe(curr, next, head, node) {
+		page =3D curr->page;
+		pfn =3D page_to_pfn(page);
+		drain_all_pages(page_zone(page));
+		if (PageBuddy(page) && !take_page_off_buddy(page))
+			pr_warn("%#lx: unable to take off buddy allocator\n", pfn);
+
+		SetPageHWPoison(page);
+		page_ref_inc(page);
+		kfree(curr);
+		pr_info("%#lx: pending hard offline completed\n", pfn);
+	}
+}
+
+void filemap_offline_hwpoison_folio(struct address_space *mapping,
+				    struct folio *folio)
+{
+	WARN_ON_ONCE(!mapping);
+
+	/* Pending MFR currently only exist for hugetlb. */
+	if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
+		filemap_offline_hwpoison_folio_hugetlb(folio);
+}
+
 /*
  * Taking refcount of hugetlb pages needs extra care about race conditions
  * with basic operations like hugepage allocation/free/demotion.
--=20
2.48.0.rc2.279.g1de40edade-goog


