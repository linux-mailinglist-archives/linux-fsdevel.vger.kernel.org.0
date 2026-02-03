Return-Path: <linux-fsdevel+bounces-76224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H6KOldLgmnNRwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 20:24:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 677EADE217
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 20:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B36B83049EC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 19:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BBE335555;
	Tue,  3 Feb 2026 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TG055Aqv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3933D6C6
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146639; cv=none; b=etnmiIEcWYnqut7UlrH4tp3+1odkJoVuGcf8OmGY/Qsgk5WziS7x3+AycKAgH87fab5vfd4nhk2dISHRbsQvBh0Lf0/JMQyHld7bIA7i/ltdxpvKzyGHv9io3x+WPMlowr/neCopebnJ38SnXgXxYn6zoZ6wHoBa39zuq6TVRDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146639; c=relaxed/simple;
	bh=6IqnRCrViob2jHjruRgCQRHUhWeTbKyrzvYNIza1hdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=asJPbEkExEFXKmCj6P7WW6ncCGbXRPR/IKAfteKSafNnU7uwu/S9mZ01sunkPWQVQ8QLXo3mZju04JPFX3VArjthld2tdAoIH/2HQ9i4svBcEBUUfYk6zdXII4FIaWTRIHvDHWSQE3Hwje7i7KHU8wGnyvZFp9I+E5CPCVfTuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TG055Aqv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a773db3803so61341715ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 11:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770146637; x=1770751437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYF1G0Gg7ErYo3r8AiHFjVFEHimFbEWfFEP1Omqr704=;
        b=TG055AqvXI1S2IpNRhLnk3mFWPPnupDGoq1aHB5Mgo7vL6sFEGro19q6vR2JFSg5Od
         SkNNvfxw/3yq8C54yORSeAHnRGnR1E6smJszT3D9KdcHQDW0+mB2oq7hdRVkB4DRwYBg
         SsggyJ2CUkHk2FRiFoT6v7dZo2L9sxn7SJ/b++AiAjrfgoXEgkKz7eHAEh63zJzxVzm9
         fAZvCAz0yYRbLb68j0UjstG/Es8+DYx6vmEi3KKeA6vWL29kBfCl41kxdl15/G4r4X8G
         siFh8ic//pnnq3736SjycOW2XN7rx/HNfpMmSrXI0ea+rOADqMplGwqy3n9UhVfG08wK
         +Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770146637; x=1770751437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYF1G0Gg7ErYo3r8AiHFjVFEHimFbEWfFEP1Omqr704=;
        b=nL81WVHG+5loUioJrATaJHKgDui3N9kAnX5Kksxt5m2NO7fcifyClzoaqWKp3d9OB1
         1HQTKLM7L7FSXfnkwBI4SZhrylnOmVZDwfOpz7UpNkRnOZJjINCpF/Rfqb9kfEGlrHlx
         zLXjhftw+xQ9OzSTjweOo987fWae0yH9SmO23kSry1SsmQbURpsYzK7OjXtMUxQTut7n
         n/IAEywAs7NNxoTFksI6JnhHSlYBOXj3LMQZ8JDzqRqVqTC6bSHK/AfMpK0PZPWlGVOF
         XhiRb2FSiSKTu/LZpz7Cje6jSuqUhJVteO9pkXAwDk3Oa4djgh1BWmASI/CVodTufwvi
         sIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnyYfxrwX1IKHOlgosnOAQyun/n40j5kebX4cgok/PvO4yJLTFQgmYHz5Pzp+HzEoE9TVTeqgNcWDBR8QB@vger.kernel.org
X-Gm-Message-State: AOJu0YxgktTDsaKbEAImrpNqi3K4haSOZrxRuap2H8dQhgP9BKTVRus/
	BfJ5M3+YrNaI3VWJEzZ8pqu0kX3Y6//wZ5OkNWzmkofP798suTYIDtHiccxBiPd6JYbxYrfqh1B
	45so6YwUUNKTjJg==
X-Received: from pjuj5.prod.google.com ([2002:a17:90a:d005:b0:34c:2f52:23aa])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e847:b0:2a9:29d4:1099 with SMTP id d9443c01a7336-2a933d12187mr2786895ad.24.1770146637002;
 Tue, 03 Feb 2026 11:23:57 -0800 (PST)
Date: Tue,  3 Feb 2026 19:23:50 +0000
In-Reply-To: <20260203192352.2674184-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203192352.2674184-2-jiaqiyan@google.com>
Subject: [PATCH v3 1/3] mm: memfd/hugetlb: introduce memfd-based userspace MFR policy
From: Jiaqi Yan <jiaqiyan@google.com>
To: linmiaohe@huawei.com, william.roche@oracle.com, harry.yoo@oracle.com, 
	jane.chu@oracle.com
Cc: nao.horiguchi@gmail.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76224-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 677EADE217
X-Rspamd-Action: no action

Sometimes immediately hard offlining a large chunk of contigous memory
having uncorrected memory errors (UE) may not be the best option.
Cloud providers usually serve capacity- and performance-critical guest
memory with 1G HugeTLB hugepages, as this significantly reduces the
overhead associated with managing page tables and TLB misses. However,
for today's HugeTLB system, once a byte of memory in a hugepage is
hardware corrupted, the kernel discards the whole hugepage, including
the healthy portion. Customer workload running in the VM can hardly
recover from such a great loss of memory.

Therefore keeping or discarding a large chunk of contiguous memory
owned by userspace (particularly to serve guest memory) due to
recoverable UE may better be controlled by userspace process
that owns the memory, e.g. VMM in the Cloud environment.

Introduce a memfd-based userspace memory failure (MFR) policy,
MFD_MF_KEEP_UE_MAPPED. It is possible to support for other memfd,
but the current implementation only covers HugeTLB.

For a hugepage associated with MFD_MF_KEEP_UE_MAPPED enabled memfd,
whenever it runs into a new UE,

* MFR defers hard offline operations, i.e., unmapping and
  dissolving. MFR still sets HWPoison flag, holds a refcount
  for every raw HWPoison page, record them in a list, sends SIGBUS
  to the consuming thread, but si_addr_lsb is reduced to PAGE_SHIFT.
  If userspace is able to handle the SIGBUS, the HWPoison hugepage
  remains accessible via the mapping created with that memfd.

* If the memory was not faulted in yet, the fault handler also
  allows fault in the HWPoison folio.

For a MFD_MF_KEEP_UE_MAPPED enabled memfd, when it is closed, or
when userspace process truncates its hugepages:

* When the HugeTLB in-memory file system removes the filemap's
  folios one by one, it asks MFR to deal with HWPoison folios
  on the fly, implemented by filemap_offline_hwpoison_folio().

* MFR drops the refcounts being held for the raw HWPoison
  pages within the folio. Now that the HWPoison folio becomes
  free, MFR dissolves it into a set of raw pages. The healthy pages
  are recycled into buddy allocator, while the HWPoison ones are
  prevented from re-allocation.

By default MFD_MF_KEEP_UE_MAPPED is not set, so MFR immediately hard
offlines hugepages having UEs.

Tested with new selftest hugetlb-mfr in the follow-up commit.

Co-developed-by: William Roche <william.roche@oracle.com>
Signed-off-by: William Roche <william.roche@oracle.com>
Tested-by: William Roche <william.roche@oracle.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 fs/hugetlbfs/inode.c       |  25 +++++++-
 include/linux/hugetlb.h    |   7 +++
 include/linux/pagemap.h    |  23 +++++++
 include/uapi/linux/memfd.h |   6 ++
 mm/hugetlb.c               |   8 ++-
 mm/memfd.c                 |  15 ++++-
 mm/memory-failure.c        | 124 ++++++++++++++++++++++++++++++++++---
 7 files changed, 193 insertions(+), 15 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3b4c152c5c73a..8b0f5aa49711f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -551,6 +551,18 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 	}
 
 	folio_unlock(folio);
+
+	/*
+	 * There may be pending HWPoison-ed folios when a memfd is being
+	 * removed or part of it is being truncated.
+	 *
+	 * HugeTLBFS' error_remove_folio keeps the HWPoison-ed folios in
+	 * page cache until mm wants to drop the folio at the end of the
+	 * of the filemap. At this point, if memory failure was delayed
+	 * by MFD_MF_KEEP_UE_MAPPED in the past, we can now deal with it.
+	 */
+	filemap_offline_hwpoison_folio(mapping, folio);
+
 	return ret;
 }
 
@@ -582,13 +594,13 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	const pgoff_t end = lend >> PAGE_SHIFT;
 	struct folio_batch fbatch;
 	pgoff_t next, index;
-	int i, freed = 0;
+	int i, j, freed = 0;
 	bool truncate_op = (lend == LLONG_MAX);
 
 	folio_batch_init(&fbatch);
 	next = lstart >> PAGE_SHIFT;
 	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
-		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+		for (i = 0, j = 0; i < folio_batch_count(&fbatch); ++i) {
 			struct folio *folio = fbatch.folios[i];
 			u32 hash = 0;
 
@@ -603,8 +615,17 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 							index, truncate_op))
 				freed++;
 
+			/*
+			 * Skip HWPoison-ed hugepages, which should no
+			 * longer be hugetlb if successfully dissolved.
+			 */
+			if (folio_test_hugetlb(folio))
+				fbatch.folios[j++] = folio;
+
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
+		fbatch.nr = j;
+
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e51b8ef0cebd9..7fadf1772335d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -879,10 +879,17 @@ int dissolve_free_hugetlb_folios(unsigned long start_pfn,
 
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
 
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ec442af3f8861..53772c29451eb 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -211,6 +211,7 @@ enum mapping_flags {
 	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
 				   account usage to user cgroups */
 	AS_NO_DATA_INTEGRITY = 11, /* no data integrity guarantees */
+	AS_MF_KEEP_UE_MAPPED = 12, /* For MFD_MF_KEEP_UE_MAPPED. */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
@@ -356,6 +357,16 @@ static inline bool mapping_no_data_integrity(const struct address_space *mapping
 	return test_bit(AS_NO_DATA_INTEGRITY, &mapping->flags);
 }
 
+static inline bool mapping_mf_keep_ue_mapped(const struct address_space *mapping)
+{
+	return test_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
+}
+
+static inline void mapping_set_mf_keep_ue_mapped(struct address_space *mapping)
+{
+	set_bit(AS_MF_KEEP_UE_MAPPED, &mapping->flags);
+}
+
 static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
 {
 	return mapping->gfp_mask;
@@ -1303,6 +1314,18 @@ void replace_page_cache_folio(struct folio *old, struct folio *new);
 void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct folio_batch *fbatch);
 bool filemap_release_folio(struct folio *folio, gfp_t gfp);
+#ifdef CONFIG_MEMORY_FAILURE
+/*
+ * Provided by memory failure to offline HWPoison-ed folio managed by memfd.
+ */
+void filemap_offline_hwpoison_folio(struct address_space *mapping,
+				    struct folio *folio);
+#else
+static inline void filemap_offline_hwpoison_folio(struct address_space *mapping,
+						  struct folio *folio)
+{
+}
+#endif
 loff_t mapping_seek_hole_data(struct address_space *, loff_t start, loff_t end,
 		int whence);
 
diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 273a4e15dfcff..d9875da551b7f 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -12,6 +12,12 @@
 #define MFD_NOEXEC_SEAL		0x0008U
 /* executable */
 #define MFD_EXEC		0x0010U
+/*
+ * Keep owned folios mapped when uncorrectable memory errors (UE) causes
+ * memory failure (MF) within the folio. Only at the end of the mapping
+ * will its HWPoison-ed folios be dealt with.
+ */
+#define MFD_MF_KEEP_UE_MAPPED	0x0020U
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a1832da0f6236..2a161c281da2a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5836,9 +5836,11 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		 * So we need to block hugepage fault by PG_hwpoison bit check.
 		 */
 		if (unlikely(folio_test_hwpoison(folio))) {
-			ret = VM_FAULT_HWPOISON_LARGE |
-				VM_FAULT_SET_HINDEX(hstate_index(h));
-			goto backout_unlocked;
+			if (!mapping_mf_keep_ue_mapped(mapping)) {
+				ret = VM_FAULT_HWPOISON_LARGE |
+				      VM_FAULT_SET_HINDEX(hstate_index(h));
+				goto backout_unlocked;
+			}
 		}
 
 		/* Check for page in userfault range. */
diff --git a/mm/memfd.c b/mm/memfd.c
index ab5312aff14b9..f9fdf014b67ba 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -340,7 +340,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
+#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
+		       MFD_NOEXEC_SEAL | MFD_EXEC | MFD_MF_KEEP_UE_MAPPED)
 
 static int check_sysctl_memfd_noexec(unsigned int *flags)
 {
@@ -414,6 +415,8 @@ static int sanitize_flags(unsigned int *flags_ptr)
 	if (!(flags & MFD_HUGETLB)) {
 		if (flags & ~MFD_ALL_FLAGS)
 			return -EINVAL;
+		if (flags & MFD_MF_KEEP_UE_MAPPED)
+			return -EINVAL;
 	} else {
 		/* Allow huge page size encoding in flags. */
 		if (flags & ~(MFD_ALL_FLAGS |
@@ -486,6 +489,16 @@ static struct file *alloc_file(const char *name, unsigned int flags)
 	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
 	file->f_flags |= O_LARGEFILE;
 
+	/*
+	 * MFD_MF_KEEP_UE_MAPPED can only be specified in memfd_create;
+	 * no API to update it once memfd is created. MFD_MF_KEEP_UE_MAPPED
+	 * is not seal-able.
+	 *
+	 * For now MFD_MF_KEEP_UE_MAPPED is only supported by HugeTLBFS.
+	 */
+	if (flags & MFD_MF_KEEP_UE_MAPPED)
+		mapping_set_mf_keep_ue_mapped(file->f_mapping);
+
 	if (flags & MFD_NOEXEC_SEAL) {
 		inode->i_mode &= ~0111;
 		file_seals = memfd_file_seals_ptr(file);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 58b34f5d2c05d..b9cecbbe08dae 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -410,6 +410,8 @@ static void __add_to_kill(struct task_struct *tsk, const struct page *p,
 			  unsigned long addr)
 {
 	struct to_kill *tk;
+	const struct folio *folio;
+	struct address_space *mapping;
 
 	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
 	if (!tk) {
@@ -420,8 +422,19 @@ static void __add_to_kill(struct task_struct *tsk, const struct page *p,
 	tk->addr = addr;
 	if (is_zone_device_page(p))
 		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
-	else
-		tk->size_shift = folio_shift(page_folio(p));
+	else {
+		folio = page_folio(p);
+		mapping = folio_mapping(folio);
+		if (mapping && mapping_mf_keep_ue_mapped(mapping))
+			/*
+			 * Let userspace know the radius of HWPoison is
+			 * the size of raw page; accessing other pages
+			 * inside the folio is still ok.
+			 */
+			tk->size_shift = PAGE_SHIFT;
+		else
+			tk->size_shift = folio_shift(folio);
+	}
 
 	/*
 	 * Send SIGKILL if "tk->addr == -EFAULT". Also, as
@@ -844,6 +857,8 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 				  int flags)
 {
 	int ret;
+	struct folio *folio;
+	struct address_space *mapping;
 	struct hwpoison_walk priv = {
 		.pfn = pfn,
 	};
@@ -861,8 +876,14 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 	 * ret = 0 when poison page is a clean page and it's dropped, no
 	 * SIGBUS is needed.
 	 */
-	if (ret == 1 && priv.tk.addr)
+	if (ret == 1 && priv.tk.addr) {
+		folio = pfn_folio(pfn);
+		mapping = folio_mapping(folio);
+		if (mapping && mapping_mf_keep_ue_mapped(mapping))
+			priv.tk.size_shift = PAGE_SHIFT;
+
 		kill_proc(&priv.tk, pfn, flags);
+	}
 	mmap_read_unlock(p->mm);
 
 	return ret > 0 ? -EHWPOISON : 0;
@@ -1206,6 +1227,13 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		}
 	}
 
+	/*
+	 * MF still needs to holds a refcount for the deferred actions in
+	 * filemap_offline_hwpoison_folio.
+	 */
+	if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
+		return res;
+
 	if (has_extra_refcount(ps, p, extra_pins))
 		res = MF_FAILED;
 
@@ -1602,6 +1630,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 {
 	LIST_HEAD(tokill);
 	bool unmap_success;
+	bool keep_mapped;
 	int forcekill;
 	bool mlocked = folio_test_mlocked(folio);
 
@@ -1629,8 +1658,12 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	 */
 	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_success = !unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
-	if (!unmap_success)
+	keep_mapped = hugetlb_should_keep_hwpoison_mapped(folio, folio->mapping);
+	if (!keep_mapped)
+		unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
+
+	unmap_success = !folio_mapped(folio);
+	if (!keep_mapped && !unmap_success)
 		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
 		       pfn, folio_mapcount(folio));
 
@@ -1655,7 +1688,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 		    !unmap_success;
 	kill_procs(&tokill, forcekill, pfn, flags);
 
-	return unmap_success;
+	return unmap_success || keep_mapped;
 }
 
 static int identify_page_state(unsigned long pfn, struct page *p,
@@ -1896,6 +1929,13 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	unsigned long count = 0;
 
 	head = llist_del_all(raw_hwp_list_head(folio));
+	/*
+	 * If filemap_offline_hwpoison_folio_hugetlb is handling this folio,
+	 * it has already taken off the head of the llist.
+	 */
+	if (head == NULL)
+		return 0;
+
 	llist_for_each_entry_safe(p, next, head, node) {
 		if (move_flag)
 			SetPageHWPoison(p->page);
@@ -1912,7 +1952,8 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
 	struct raw_hwp_page *p;
-	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
+	struct address_space *mapping = folio->mapping;
+	bool has_hwpoison = folio_test_set_hwpoison(folio);
 
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
@@ -1931,8 +1972,15 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 	if (raw_hwp) {
 		raw_hwp->page = page;
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
@@ -1947,7 +1995,8 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 		 */
 		__folio_free_raw_hwp(folio, false);
 	}
-	return ret;
+
+	return has_hwpoison ? -EHWPOISON : 0;
 }
 
 static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_flag)
@@ -1980,6 +2029,18 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
 	folio_free_raw_hwp(folio, true);
 }
 
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
 /*
  * Called from hugetlb code with hugetlb_lock held.
  *
@@ -2037,6 +2098,51 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 	return ret;
 }
 
+static void filemap_offline_hwpoison_folio_hugetlb(struct folio *folio)
+{
+	int ret;
+	struct llist_node *head;
+	struct raw_hwp_page *curr, *next;
+
+	/*
+	 * Since folio is still in the folio_batch, drop the refcount
+	 * elevated by filemap_get_folios.
+	 */
+	folio_put_refs(folio, 1);
+	head = llist_del_all(raw_hwp_list_head(folio));
+
+	/*
+	 * Release refcounts held by try_memory_failure_hugetlb, one per
+	 * HWPoison-ed page in the raw hwp list.
+	 *
+	 * Set HWPoison flag on each page so that free_has_hwpoisoned()
+	 * can exclude them during dissolve_free_hugetlb_folio().
+	 */
+	llist_for_each_entry_safe(curr, next, head, node) {
+		folio_put(folio);
+		SetPageHWPoison(curr->page);
+		kfree(curr);
+	}
+
+	/* Refcount now should be zero and ready to dissolve folio. */
+	ret = dissolve_free_hugetlb_folio(folio);
+	if (ret)
+		pr_err("failed to dissolve hugetlb folio: %d\n", ret);
+}
+
+void filemap_offline_hwpoison_folio(struct address_space *mapping,
+				    struct folio *folio)
+{
+	WARN_ON_ONCE(!mapping);
+
+	if (!folio_test_hwpoison(folio))
+		return;
+
+	/* Pending MFR currently only exist for hugetlb. */
+	if (hugetlb_should_keep_hwpoison_mapped(folio, mapping))
+		filemap_offline_hwpoison_folio_hugetlb(folio);
+}
+
 /*
  * Taking refcount of hugetlb pages needs extra care about race conditions
  * with basic operations like hugepage allocation/free/demotion.
-- 
2.53.0.rc2.204.g2597b5adb4-goog


