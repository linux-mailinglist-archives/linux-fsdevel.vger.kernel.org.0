Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D31043D53B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 23:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244429AbhJ0VZq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 17:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241240AbhJ0VYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635369714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwLHJ12ZKjT6leEJ6WYOkEZZGnrS+h6tW+Et+6r7vhY=;
        b=ErynskCFZQbgjf4bAqihkJRdlb36ZxlI3gF6rpsUjO3yedMiWh+QK+ZX859IH4NZv1KnNM
        TozaDQ8Tp6javiwS+ZoDcVYSwC+1Yz61lQWbnO3vSgNmL5v12yTlHb3KuL6WIq6VKhguo3
        iufLnRngqxa0OrguNshS2TPJQiKdz/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-P4M58sfBMS2OucCtV0CJRQ-1; Wed, 27 Oct 2021 17:21:51 -0400
X-MC-Unique: P4M58sfBMS2OucCtV0CJRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E25E0100D029;
        Wed, 27 Oct 2021 21:21:44 +0000 (UTC)
Received: from max.com (unknown [10.40.193.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C17C8472FC;
        Wed, 27 Oct 2021 21:21:40 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
Date:   Wed, 27 Oct 2021 23:21:38 +0200
Message-Id: <20211027212138.3722977-1-agruenba@redhat.com>
In-Reply-To: <20211026094430.3669156-1-agruenba@redhat.com>
References: <20211026094430.3669156-1-agruenba@redhat.com> <YXeOVZqer+GFBkXO@mit.edu> <20211019134204.3382645-1-agruenba@redhat.com> <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com> <YXBFqD9WVuU8awIv@arm.com> <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com> <YXCbv5gdfEEtAYo8@arm.com> <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com> <YXL9tRher7QVmq6N@arm.com> <CAHc6FU6JC4ZOwA8t854WbNdmuiNL9DPq0FPga8guATaoCtvsaw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One of the arguments against Dave Hansen's patch that eliminates the
pre-faulting was that it doubles the number of page faults in the slow
case.  This can be avoided by using get_user_pages() to do the
"post-faulting", though.  For what it's worth, here's a patch for that
(on top of this series).

Andreas

--

fs: Avoid predictable page faults for sys_write() user buffer pages

Introduce a new fault_in_iov_iter_slow_readable() helper for faulting in
an iterator via get_user_pages() instead of triggering page faults.
This is slower than a simple memory read when the underlying pages are
resident, but avoids the page fault overhead when the underlying pages
need to be faulted in.

Use fault_in_iov_iter_slow_readable() in generic_perform_write and
iomap_write_iter when reading from the user buffer fails.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c  |  2 +-
 include/linux/pagemap.h |  3 ++-
 include/linux/uio.h     | 17 ++++++++++++++++-
 lib/iov_iter.c          | 10 ++++++----
 mm/filemap.c            |  2 +-
 mm/gup.c                | 10 ++++++----
 6 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d8809cd9ab31..15a0b4bb9528 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -770,7 +770,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 				bytes = copied;
 				goto again;
 			}
-			if (fault_in_iov_iter_readable(i, bytes) != bytes)
+			if (fault_in_iov_iter_slow_readable(i, bytes) != bytes)
 				goto again;
 			status = -EFAULT;
 			break;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2f7dd14083d9..43844ed5675f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -736,8 +736,9 @@ extern void add_page_wait_queue(struct page *page, wait_queue_entry_t *waiter);
  * Fault in userspace address range.
  */
 size_t fault_in_writeable(char __user *uaddr, size_t size);
-size_t fault_in_safe_writeable(const char __user *uaddr, size_t size);
 size_t fault_in_readable(const char __user *uaddr, size_t size);
+size_t __fault_in_slow(const char __user *uaddr, size_t size,
+		       unsigned int flags);
 
 int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6350354f97e9..b071f4445059 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/thread_info.h>
 #include <uapi/linux/uio.h>
+#include <linux/mm.h>
 
 struct page;
 struct pipe_inode_info;
@@ -135,7 +136,21 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
 size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
-size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t bytes);
+size_t __fault_in_iov_iter_slow(const struct iov_iter *i, size_t bytes,
+				unsigned int flags);
+
+static inline size_t fault_in_iov_iter_slow_readable(const struct iov_iter *i,
+						     size_t bytes)
+{
+	return __fault_in_iov_iter_slow(i, bytes, 0);
+}
+
+static inline size_t fault_in_iov_iter_writeable(const struct iov_iter *i,
+						 size_t bytes)
+{
+	return __fault_in_iov_iter_slow(i, bytes, FOLL_WRITE);
+}
+
 size_t iov_iter_single_seg_count(const struct iov_iter *i);
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 66a740e6e153..73789a5409f6 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -468,9 +468,10 @@ size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t size)
 EXPORT_SYMBOL(fault_in_iov_iter_readable);
 
 /*
- * fault_in_iov_iter_writeable - fault in iov iterator for writing
+ * __fault_in_iov_iter_slow - fault in iov iterator for reading/writing
  * @i: iterator
  * @size: maximum length
+ * @flags: FOLL_* flags (FOLL_WRITE for writing)
  *
  * Faults in the iterator using get_user_pages(), i.e., without triggering
  * hardware page faults.  This is primarily useful when we already know that
@@ -481,7 +482,8 @@ EXPORT_SYMBOL(fault_in_iov_iter_readable);
  *
  * Always returns 0 for non-user-space iterators.
  */
-size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size)
+size_t __fault_in_iov_iter_slow(const struct iov_iter *i, size_t size,
+				unsigned int flags)
 {
 	if (iter_is_iovec(i)) {
 		size_t count = min(size, iov_iter_count(i));
@@ -495,7 +497,7 @@ size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size)
 
 			if (unlikely(!len))
 				continue;
-			ret = fault_in_safe_writeable(p->iov_base + skip, len);
+			ret = __fault_in_slow(p->iov_base + skip, len, flags);
 			count -= len - ret;
 			if (ret)
 				break;
@@ -504,7 +506,7 @@ size_t fault_in_iov_iter_writeable(const struct iov_iter *i, size_t size)
 	}
 	return 0;
 }
-EXPORT_SYMBOL(fault_in_iov_iter_writeable);
+EXPORT_SYMBOL(__fault_in_iov_iter_slow);
 
 void iov_iter_init(struct iov_iter *i, unsigned int direction,
 			const struct iovec *iov, unsigned long nr_segs,
diff --git a/mm/filemap.c b/mm/filemap.c
index 467cdb7d086d..7ca76f4aa974 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3787,7 +3787,7 @@ ssize_t generic_perform_write(struct file *file,
 				bytes = copied;
 				goto again;
 			}
-			if (fault_in_iov_iter_readable(i, bytes) != bytes)
+			if (fault_in_iov_iter_slow_readable(i, bytes) != bytes)
 				goto again;
 			status = -EFAULT;
 			break;
diff --git a/mm/gup.c b/mm/gup.c
index e1c7e4bde11f..def9f478a621 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1694,9 +1694,10 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
 EXPORT_SYMBOL(fault_in_writeable);
 
 /*
- * fault_in_safe_writeable - fault in an address range for writing
+ * __fault_in_slow - fault in an address range for reading/writing
  * @uaddr: start of address range
  * @size: length of address range
+ * @flags: FOLL_* flags (FOLL_WRITE for writing)
  *
  * Faults in an address range using get_user_pages, i.e., without triggering
  * hardware page faults.  This is primarily useful when we already know that
@@ -1711,7 +1712,8 @@ EXPORT_SYMBOL(fault_in_writeable);
  * Returns the number of bytes not faulted in, like copy_to_user() and
  * copy_from_user().
  */
-size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)
+size_t __fault_in_slow(const char __user *uaddr, size_t size,
+		       unsigned int flags)
 {
 	unsigned long start = (unsigned long)untagged_addr(uaddr);
 	unsigned long end, nstart, nend;
@@ -1743,7 +1745,7 @@ size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)
 		nr_pages = (nend - nstart) / PAGE_SIZE;
 		ret = __get_user_pages_locked(mm, nstart, nr_pages,
 					      NULL, NULL, &locked,
-					      FOLL_TOUCH | FOLL_WRITE);
+					      FOLL_TOUCH | flags);
 		if (ret <= 0)
 			break;
 		nend = nstart + ret * PAGE_SIZE;
@@ -1754,7 +1756,7 @@ size_t fault_in_safe_writeable(const char __user *uaddr, size_t size)
 		return 0;
 	return size - min_t(size_t, nstart - start, size);
 }
-EXPORT_SYMBOL(fault_in_safe_writeable);
+EXPORT_SYMBOL(__fault_in_slow);
 
 /**
  * fault_in_readable - fault in userspace address range for reading
-- 
2.26.3

