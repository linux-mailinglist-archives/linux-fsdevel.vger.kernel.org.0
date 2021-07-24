Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0633D498A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 21:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhGXSyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhGXSyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627155305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Z8AWyjl1kNK52UxUU84aLxs2GFM/UHZLnNowdqQf94=;
        b=Mc8bRlP55FUJK0v0bc9Ol6AROdCp5s7tJOiwIAq4RrlzHPNPgAGKDAAK1x1kEbqumz4UoY
        Ib/K+0XjYKd50GF+8FWxtQzbTPnl4+8mfZh7CiB1Hh0CGTN9biHyKe1K0zFKuqKQzhAXi2
        8A+TGgt98e9SiyhUM4WrXKoWlC43hwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-IrixSXtCNemYMhbd8sQCQw-1; Sat, 24 Jul 2021 15:35:02 -0400
X-MC-Unique: IrixSXtCNemYMhbd8sQCQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F161D8042E7;
        Sat, 24 Jul 2021 19:35:00 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8946718432;
        Sat, 24 Jul 2021 19:34:58 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable helper
Date:   Sat, 24 Jul 2021 21:34:42 +0200
Message-Id: <20210724193449.361667-2-agruenba@redhat.com>
In-Reply-To: <20210724193449.361667-1-agruenba@redhat.com>
References: <20210724193449.361667-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new iov_iter_fault_in_writeable helper for faulting in an iterator
for writing.  The pages are faulted in manually, without writing to them, so
this function is non-destructive.

We'll use iov_iter_fault_in_writeable in gfs2 once we've determined that part
of the iterator isn't in memory.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/mm.h  |  3 +++
 include/linux/uio.h |  1 +
 lib/iov_iter.c      | 40 +++++++++++++++++++++++++++++++
 mm/gup.c            | 57 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..14b1353995e2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1840,6 +1840,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
 
+unsigned long fault_in_user_pages(unsigned long start, unsigned long len,
+				  bool write);
+
 int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 			struct task_struct *task, bool bypass_rlim);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 82c3c3e819e0..8e469b8b862f 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -120,6 +120,7 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
 int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes);
+int iov_iter_fault_in_writeable(const struct iov_iter *i, size_t bytes);
 size_t iov_iter_single_seg_count(const struct iov_iter *i);
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 20dc3d800573..ccf1ee8d4edf 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -460,6 +460,46 @@ int iov_iter_fault_in_readable(const struct iov_iter *i, size_t bytes)
 }
 EXPORT_SYMBOL(iov_iter_fault_in_readable);
 
+/**
+ * iov_iter_fault_in_writeable - fault in an iov iterator for writing
+ * @i: iterator
+ * @bytes: maximum length
+ *
+ * Faults in part or all of the iterator.  This is primarily useful when we
+ * already know that some or all of the pages in @i aren't in memory.
+ *
+ * This function uses fault_in_user_pages() to fault in the pages, which
+ * internally uses get_user_pages(), so it doesn't trigger hardware page
+ * faults.  Unlike fault_in_pages_writeable() which writes to the memory to
+ * fault it in, this function is non-destructive.
+ *
+ * Returns 0 on success, and a non-zero error code if the memory could not be
+ * accessed (i.e. because it is an invalid address).
+ */
+int iov_iter_fault_in_writeable(const struct iov_iter *i, size_t bytes)
+{
+	if (iter_is_iovec(i)) {
+		const struct iovec *p;
+		size_t skip;
+
+		if (bytes > i->count)
+			bytes = i->count;
+		for (p = i->iov, skip = i->iov_offset; bytes; p++, skip = 0) {
+			unsigned long len = min(bytes, p->iov_len - skip);
+			unsigned long start;
+
+			if (unlikely(!len))
+				continue;
+			start = (unsigned long)p->iov_base + skip;
+			if (fault_in_user_pages(start, len, true) != len)
+				return -EFAULT;
+			bytes -= len;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL(iov_iter_fault_in_writeable);
+
 void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			const struct iovec *iov, unsigned long nr_segs,
 			size_t count)
diff --git a/mm/gup.c b/mm/gup.c
index 42b8b1fa6521..784809c232f1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1669,6 +1669,63 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
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

