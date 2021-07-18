Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2999B3CCB56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 00:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhGRWms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 18:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233062AbhGRWmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 18:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626647985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azzEr4YShufMXoWVaQ28QKOg/ot07qvO0ZF8GTvxfys=;
        b=DpUayOA4ro4fLxC4z547VYl8L76/SQseYiSWPV8efKZPVNAODe1H5YDXDV2PVpXGIKi1zM
        jEHZXukAHGrTrCYqR/oE0Up8wcDtkyBx9hMw35U4UcAQeorNAvGr/xmtbcva1kTf6NA5EI
        spS8H9lI60WpunHYGdu9GyP0i2sATNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-BxkBRjW-OhOQCpuNplEvDQ-1; Sun, 18 Jul 2021 18:39:44 -0400
X-MC-Unique: BxkBRjW-OhOQCpuNplEvDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B2DC362FC;
        Sun, 18 Jul 2021 22:39:43 +0000 (UTC)
Received: from max.com (unknown [10.40.195.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3E3D60C0F;
        Sun, 18 Jul 2021 22:39:40 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 1/6] iov_iter: Introduce fault_in_iov_iter helper
Date:   Mon, 19 Jul 2021 00:39:27 +0200
Message-Id: <20210718223932.2703330-2-agruenba@redhat.com>
In-Reply-To: <20210718223932.2703330-1-agruenba@redhat.com>
References: <20210718223932.2703330-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new fault_in_iov_iter helper for manually faulting in an iterator.
Other than fault_in_pages_writeable(), this function is non-destructive.

We'll use fault_in_iov_iter in gfs2 once we've determined that the iterator
passed to .read_iter or .write_iter isn't in memory.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/mm.h  |  3 ++
 include/linux/uio.h |  1 +
 lib/iov_iter.c      | 42 ++++++++++++++++++++++++++++
 mm/gup.c            | 68 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ae31622deef..dc7d64632a60 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1836,6 +1836,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
 
+unsigned long fault_in_user_pages(unsigned long start, unsigned long len,
+				  bool write);
+
 int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 			struct task_struct *task, bool bypass_rlim);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index d3ec87706d75..74f819c41735 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -124,6 +124,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
 int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes);
+size_t fault_in_iov_iter(const struct iov_iter *i);
 size_t iov_iter_single_seg_count(const struct iov_iter *i);
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c701b7a187f2..3beecf8f77de 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -487,6 +487,48 @@ int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes)
 }
 EXPORT_SYMBOL(iov_iter_fault_in_readable);
 
+/**
+ * fault_in_iov_iter - fault in iov iterator for reading / writing
+ * @i: iterator
+ *
+ * Faults in the iterator using get_user_pages, i.e., without triggering
+ * hardware page faults.
+ *
+ * This is primarily useful when we know that some or all of the pages in @i
+ * aren't in memory.  For iterators that are likely to be in memory,
+ * fault_in_pages_readable() may be more appropriate.
+ *
+ * Other than fault_in_pages_writeable(), this function is non-destructive even
+ * when faulting in pages for writing.
+ *
+ * Returns the number of bytes faulted in, or the size of @i if @i doesn't need
+ * faulting in.
+ */
+size_t fault_in_iov_iter(const struct iov_iter *i)
+{
+	size_t count = i->count;
+	const struct iovec *p;
+	size_t ret = 0, skip;
+
+	if (iter_is_iovec(i)) {
+		for (p = i->iov, skip = i->iov_offset; count; p++, skip = 0) {
+			unsigned long len = min(count, p->iov_len - skip);
+			unsigned long start, l;
+
+			if (unlikely(!len))
+				continue;
+			start = (unsigned long)p->iov_base + skip;
+			l = fault_in_user_pages(start, len, iov_iter_rw(i) != WRITE);
+			ret += l;
+			if (unlikely(l != len))
+				break;
+			count -= l;
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL(fault_in_iov_iter);
+
 void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			const struct iovec *iov, unsigned long nr_segs,
 			size_t count)
diff --git a/mm/gup.c b/mm/gup.c
index 3ded6a5f26b2..f87fb24d59e1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1565,6 +1565,74 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 }
 #endif /* !CONFIG_MMU */
 
+/**
+ * fault_in_user_pages - fault in an address range for reading / writing
+ * @start: start of address range
+ * @len: length of address range
+ * @write: fault in for writing
+ *
+ * Note that we don't pin or otherwise hold the pages referenced that we fault
+ * in.  There's no guarantee that they'll stay in memory for any duration of
+ * time.
+ *
+ * Returns the number of bytes faulted in from @start.
+ */
+unsigned long fault_in_user_pages(unsigned long start, unsigned long len,
+				  bool write)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = NULL;
+	unsigned long end, nstart, nend;
+	int locked = 0;
+	int gup_flags;
+
+	/*
+	 * FIXME: Make sure this function doesn't succeed for pages that cannot
+	 * be accessed; otherwise we could end up in a loop trying to fault in
+	 * and then access the pages.  (It's okay if a page gets evicted and we
+	 * need more than one retry.)
+	 */
+
+	/*
+	 * FIXME: Are these the right FOLL_* flags?
+	 */
+
+	gup_flags = FOLL_TOUCH | FOLL_POPULATE;
+	if (write)
+		gup_flags |= FOLL_WRITE;
+
+	end = PAGE_ALIGN(start + len);
+	for (nstart = start & PAGE_MASK; nstart < end; nstart = nend) {
+		unsigned long nr_pages;
+		long ret;
+
+		if (!locked) {
+			locked = 1;
+			mmap_read_lock(mm);
+			vma = find_vma(mm, nstart);
+		} else if (nstart >= vma->vm_end)
+			vma = vma->vm_next;
+		if (!vma || vma->vm_start >= end)
+			break;
+		nend = min(end, vma->vm_end);
+		if (vma->vm_flags & (VM_IO | VM_PFNMAP))
+			continue;
+		if (nstart < vma->vm_start)
+			nstart = vma->vm_start;
+		nr_pages = (nend - nstart) / PAGE_SIZE;
+		ret = __get_user_pages_locked(mm, nstart, nr_pages,
+					      NULL, NULL, &locked, gup_flags);
+		if (ret <= 0)
+			break;
+		nend = nstart + ret * PAGE_SIZE;
+	}
+	if (locked)
+		mmap_read_unlock(mm);
+	if (nstart > start)
+		return min(nstart - start, len);
+	return 0;
+}
+
 /**
  * get_dump_page() - pin user page in memory while writing it to core dump
  * @addr: user address
-- 
2.26.3

