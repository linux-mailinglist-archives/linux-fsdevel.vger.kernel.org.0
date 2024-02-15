Return-Path: <linux-fsdevel+bounces-11728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F8D85681A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 16:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C15C1F22D1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C39133435;
	Thu, 15 Feb 2024 15:41:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8D87CF03;
	Thu, 15 Feb 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011673; cv=none; b=NjhmNfVVNTFwBkbuZL5+uy9E5RC7FHOZ6E3AiGnoJ+eizmqiLXW77T3i+2WZZN5hmZu8YLHkucsQj58kOQJgF/0+bWnQwt5152qm53WP2X2vsFgZn5R2XoulYsfMkJkIb2JQnOPF9fLjvJPtTYnrNQ4etK0iZ9vF/PGWsiuk/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011673; c=relaxed/simple;
	bh=2GI9jpIl6vl07F2AqQHDLykNXmnCsS6BtP6o5Mv/NQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JNjLAqr/ljDxqZL35/hrtlSEu8dBvqQ7ITlTtmKrfVdwteVkAk7t1LLzZwGPWLkbWr/URgXGPUU/z5FEVRZMf9WDAzXmjbCVpY8MqJcg36wts2P+KQVEnFss0zYfXSMxX7iFR0h4HR4UUMUvGyTtW1/UcOGEawJ6fkUU5kk8DF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B87921FB;
	Thu, 15 Feb 2024 07:41:50 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A1C93F7A6;
	Thu, 15 Feb 2024 07:41:07 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <21cnbao@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] mm/filemap: Allow arch to request folio size for exec memory
Date: Thu, 15 Feb 2024 15:40:59 +0000
Message-Id: <20240215154059.2863126-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the readahead config so that if it is being requested for an
executable mapping, do a synchronous read of an arch-specified size in a
naturally aligned manner.

On arm64 if memory is physically contiguous and naturally aligned to the
"contpte" size, we can use contpte mappings, which improves utilization
of the TLB. When paired with the "multi-size THP" changes, this works
well to reduce dTLB pressure. However iTLB pressure is still high due to
executable mappings having a low liklihood of being in the required
folio size and mapping alignment, even when the filesystem supports
readahead into large folios (e.g. XFS).

The reason for the low liklihood is that the current readahead algorithm
starts with an order-2 folio and increases the folio order by 2 every
time the readahead mark is hit. But most executable memory is faulted in
fairly randomly and so the readahead mark is rarely hit and most
executable folios remain order-2. This is observed impirically and
confirmed from discussion with a gnu linker expert; in general, the
linker does nothing to group temporally accessed text together
spacially. Additionally, with the current read-around approach there are
no alignment guarrantees between the file and folio. This is
insufficient for arm64's contpte mapping requirement (order-4 for 4K
base pages).

So it seems reasonable to special-case the read(ahead) logic for
executable mappings. The trade-off is performance improvement (due to
more efficient storage of the translations in iTLB) vs potential read
amplification (due to reading too much data around the fault which won't
be used), and the latter is independent of base page size. I've chosen
64K folio size for arm64 which benefits both the 4K and 16K base page
size configs and shouldn't lead to any further read-amplification since
the old read-around path was (usually) reading blocks of 128K (with the
last 32K being async).

Performance Benchmarking
------------------------

The below shows kernel compilation and speedometer javascript benchmarks
on Ampere Altra arm64 system. (The contpte patch series is applied in
the baseline).

First, confirmation that this patch causes more memory to be contained
in 64K folios (this is for all file-backed memory so includes
non-executable too):

| File-backed folios      |   Speedometer   |  Kernel Compile |
| by size as percentage   |-----------------|-----------------|
| of all mapped file mem  | before |  after | before |  after |
|=========================|========|========|========|========|
|file-thp-aligned-16kB    |    45% |     9% |    46% |     7% |
|file-thp-aligned-32kB    |     2% |     0% |     3% |     1% |
|file-thp-aligned-64kB    |     3% |    63% |     5% |    80% |
|file-thp-aligned-128kB   |    11% |    11% |     0% |     0% |
|file-thp-unaligned-16kB  |     1% |     0% |     3% |     1% |
|file-thp-unaligned-128kB |     1% |     0% |     0% |     0% |
|file-thp-partial         |     0% |     0% |     0% |     0% |
|-------------------------|--------|--------|--------|--------|
|file-cont-aligned-64kB   |    16% |    75% |     5% |    80% |

The above shows that for both use cases, the amount of file memory
backed by 16K folios reduces and the amount backed by 64K folios
increases significantly. And the amount of memory that is contpte-mapped
significantly increases (last line).

And this is reflected in performance improvement:

Kernel Compilation (smaller is faster):
| kernel   |   real-time |   kern-time |   user-time |   peak memory |
|----------|-------------|-------------|-------------|---------------|
| before   |        0.0% |        0.0% |        0.0% |          0.0% |
| after    |       -1.6% |       -2.1% |       -1.7% |          0.0% |

Speedometer (bigger is faster):
| kernel   |   runs_per_min |   peak memory |
|----------|----------------|---------------|
| before   |           0.0% |          0.0% |
| after    |           1.3% |          1.0% |

Both benchmarks show a ~1.5% improvement once the patch is applied.

Alternatives
------------

I considered (and rejected for now - but I anticipate this patch will
stimulate discussion around what the best approach is) alternative
approaches:

  - Expose a global user-controlled knob to set the preferred folio
    size; this would move policy to user space and allow (e.g.) setting
    it to PMD-size for even better iTLB utilizaiton. But this would add
    ABI, and I prefer to start with the simplest approach first. It also
    has the downside that a change wouldn't apply to memory already in
    the page cache that is in active use (e.g. libc) so we don't get the
    same level of utilization as for something that is fixed from boot.

  - Add a per-vma attribute to allow user space to specify preferred
    folio size for memory faulted from the range. (we've talked about
    such a control in the context of mTHP). The dynamic loader would
    then be responsible for adding the annotations. Again this feels
    like something that could be added later if value was demonstrated.

  - Enhance MADV_COLLAPSE to collapse to THP sizes less than PMD-size.
    This would still require dynamic linker involvement, but would
    additionally neccessitate a copy and all memory in the range would
    be synchronously faulted in, adding to application load time. It
    would work for filesystems that don't support large folios though.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Hi All,

This applies on top of mm-unstable (157d6f218d89). But it requires the series at
[2] to realize the performance improvements (I'm hoping [2] will be added to
mm-unstable imminently).

I didn't get a huge amount of feedback from the RFC, except for Matthew
kind-of-implying that he agrees with the principle. Barry initially raised some
concerns about the potential for performance regression with filesystems that
don't support large folios, but I think he ended up coming around to Matthew's
view that this should be ok in principle.

So I'm trying my luck with a v2 with just one minor change that fixes a benign
bug. As per above I'm seeing performance improvement, so I'm keen to get this
in, but I'm willing to run other benchmarks if others have suggestions for what
to run.

Changes since v1 [1]
====================

 - Remove "void" from arch_wants_exec_folio_order() macro args list

[1] https://lore.kernel.org/linux-mm/20240111154106.3692206-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20240215103205.2607016-1-ryan.roberts@arm.com/

Thanks,
Ryan


 arch/arm64/include/asm/pgtable.h | 12 ++++++++++++
 include/linux/pgtable.h          | 12 ++++++++++++
 mm/filemap.c                     | 19 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 52d0b0a763f1..fa6365ce61a7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1115,6 +1115,18 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
  */
 #define arch_wants_old_prefaulted_pte	cpu_has_hw_af

+/*
+ * Request exec memory is read into pagecache in at least 64K folios. The
+ * trade-off here is performance improvement due to storing translations more
+ * effciently in the iTLB vs the potential for read amplification due to reading
+ * data from disk that won't be used. The latter is independent of base page
+ * size, so we set a page-size independent block size of 64K. This size can be
+ * contpte-mapped when 4K base pages are in use (16 pages into 1 iTLB entry),
+ * and HPA can coalesce it (4 pages into 1 TLB entry) when 16K base pages are in
+ * use.
+ */
+#define arch_wants_exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)
+
 static inline bool pud_sect_supported(void)
 {
 	return PAGE_SIZE == SZ_4K;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index aab227e12493..6cdd145cbbb9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -407,6 +407,18 @@ static inline bool arch_has_hw_pte_young(void)
 }
 #endif

+#ifndef arch_wants_exec_folio_order
+/*
+ * Returns preferred minimum folio order for executable file-backed memory. Must
+ * be in range [0, PMD_ORDER]. Negative value implies that the HW has no
+ * preference and mm will not special-case executable memory in the pagecache.
+ */
+static inline int arch_wants_exec_folio_order(void)
+{
+	return -1;
+}
+#endif
+
 #ifndef arch_check_zapped_pte
 static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
 					 pte_t pte)
diff --git a/mm/filemap.c b/mm/filemap.c
index 142864338ca4..7954274de11c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3118,6 +3118,25 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	}
 #endif

+	/*
+	 * Allow arch to request a preferred minimum folio order for executable
+	 * memory. This can often be beneficial to performance if (e.g.) arm64
+	 * can contpte-map the folio. Executable memory rarely benefits from
+	 * read-ahead anyway, due to its random access nature.
+	 */
+	if (vm_flags & VM_EXEC) {
+		int order = arch_wants_exec_folio_order();
+
+		if (order >= 0) {
+			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+			ra->size = 1UL << order;
+			ra->async_size = 0;
+			ractl._index &= ~((unsigned long)ra->size - 1);
+			page_cache_ra_order(&ractl, ra, order);
+			return fpin;
+		}
+	}
+
 	/* If we don't want any read-ahead, don't bother */
 	if (vm_flags & VM_RAND_READ)
 		return fpin;
--
2.25.1


