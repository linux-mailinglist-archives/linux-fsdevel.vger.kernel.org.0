Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD523114DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhBEWRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhBEOdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:33:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38665C06178A;
        Fri,  5 Feb 2021 08:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+0WkhFCz6xUyn9L1glTxulg8Gxs8XBPGDsfl0JDzXmE=; b=IIg/2StJ1jRXNrytHsmqe6H2Xi
        8qeP6CtpPh3AlzHOVKMqOcwIR3vt4x1CNbLe5XWi7Ov4dyCykq5r8j46achz1tAkk1JCL7rFctGKd
        RgiKmJJAR2LBQS20GecXa68fpRAQJc+uxU7Votudqd5/UecOgWFoS2KFcGFN2g8cTS+wjytYj48Rl
        8wrVzn0UlB6sUgAGYv7EQF0iGK5r7qQPmjVblVlnLq31PDAj/VuNyY05uC4GD2uUv2dD6DWfajQAa
        6XbNs9tdoForYG2NT4TobVsxFE4aM61DMdExbgz9pufSB5/Mzw0yMg/5lzi645kncAHGhps1O8TCa
        neVXHZRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l83hu-002UPw-Ed; Fri, 05 Feb 2021 16:11:44 +0000
Date:   Fri, 5 Feb 2021 16:11:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [RFC] Better page cache error handling
Message-ID: <20210205161142.GI308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Scenario:

You have a disk with a bad sector.  This disk will take 30 seconds of
trying progressively harder to recover the sector before timing the
I/O out and returning BLK_STS_MEDIUM to the filesystem.  Unfortunately
for you, this bad sector happens to have landed in index.html on your
webserver which gets one hit per second.  You have configured 500
threads on your webserver.

Today:

We allocate a page and try to read it.  29 threads pile up waiting
for the page lock in filemap_update_page() (or whatever variant of
that you're looking at; I'm talking about linux-next).  The original
requester gets the error and returns -EIO to userspace.  One of the
lucky 29 waiting threads sends another read.  30 more threads pile up
while it's processing.  Eventually, all 500 threads of your webserver
are sleeping waiting for their turn to get an EIO.

With the below patch:

We allocate a page and try to read it.  29 threads pile up waiting
for the page lock in filemap_update_page().  The error returned by the
original I/O is shared between all 29 waiters as well as being returned
to the requesting thread.  The next request for index.html will send
another I/O, and more waiters will pile up trying to get the page lock,
but at no time will more than 30 threads be waiting for the I/O to fail.

----

Individual filesystems will have to be modified to call unlock_page_err()
to take advantage of this.  Unconverted filesystems will continue to
behave as in the first scenario.

I've only tested it lightly, but it doesn't seem to break anything.
It needs some targetted testing with error injection which I haven't
done yet.  It probably also needs some refinement to not report
errors from readahead.  Also need to audit the other callers of
put_and_wait_on_page_locked().  This patch interferes with the page
folio work, so I'm not planning on pushing it for a couple of releases.

----

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 16a1e82e3aeb..faeb6c4af7fd 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -183,7 +183,7 @@ iomap_read_page_end_io(struct bio_vec *bvec, int error)
 	}
 
 	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
-		unlock_page(page);
+		unlock_page_err(page, error);
 }
 
 static void
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fda84e88b2ba..e750881bedfe 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -564,11 +564,13 @@ struct wait_page_key {
 	struct page *page;
 	int bit_nr;
 	int page_match;
+	int err;
 };
 
 struct wait_page_queue {
 	struct page *page;
 	int bit_nr;
+	int err;
 	wait_queue_entry_t wait;
 };
 
@@ -591,6 +593,7 @@ extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
 extern void unlock_page(struct page *page);
+extern void unlock_page_err(struct page *page, int err);
 extern void unlock_page_fscache(struct page *page);
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 97ff7294516e..515e0136f00f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1077,6 +1077,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	 * afterwards to avoid any races. This store-release pairs
 	 * with the load-acquire in wait_on_page_bit_common().
 	 */
+	wait_page->err = key->err;
 	smp_store_release(&wait->flags, flags | WQ_FLAG_WOKEN);
 	wake_up_state(wait->private, mode);
 
@@ -1094,7 +1095,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
 }
 
-static void wake_up_page_bit(struct page *page, int bit_nr)
+static void wake_up_page_bit(struct page *page, int bit_nr, int err)
 {
 	wait_queue_head_t *q = page_waitqueue(page);
 	struct wait_page_key key;
@@ -1103,6 +1104,7 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 
 	key.page = page;
 	key.bit_nr = bit_nr;
+	key.err = err;
 	key.page_match = 0;
 
 	bookmark.flags = 0;
@@ -1152,7 +1154,7 @@ static void wake_up_page(struct page *page, int bit)
 {
 	if (!PageWaiters(page))
 		return;
-	wake_up_page_bit(page, bit);
+	wake_up_page_bit(page, bit, 0);
 }
 
 /*
@@ -1214,6 +1216,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	wait->func = wake_page_function;
 	wait_page.page = page;
 	wait_page.bit_nr = bit_nr;
+	wait_page.err = 0;
 
 repeat:
 	wait->flags = 0;
@@ -1325,8 +1328,10 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 */
 	if (behavior == EXCLUSIVE)
 		return wait->flags & WQ_FLAG_DONE ? 0 : -EINTR;
+	if (behavior != DROP)
+		wait_page.err = 0;
 
-	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
+	return wait->flags & WQ_FLAG_WOKEN ? wait_page.err : -EINTR;
 }
 
 void wait_on_page_bit(struct page *page, int bit_nr)
@@ -1408,8 +1413,9 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
 #endif
 
 /**
- * unlock_page - unlock a locked page
+ * unlock_page_err - unlock a locked page
  * @page: the page
+ * @err: errno to be communicated to waiters
  *
  * Unlocks the page and wakes up sleepers in wait_on_page_locked().
  * Also wakes sleepers in wait_on_page_writeback() because the wakeup
@@ -1422,13 +1428,19 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
  * portably (architectures that do LL/SC can test any bit, while x86 can
  * test the sign bit).
  */
-void unlock_page(struct page *page)
+void unlock_page_err(struct page *page, int err)
 {
 	BUILD_BUG_ON(PG_waiters != 7);
 	page = compound_head(page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
-		wake_up_page_bit(page, PG_locked);
+		wake_up_page_bit(page, PG_locked, err);
+}
+EXPORT_SYMBOL(unlock_page_err);
+
+void unlock_page(struct page *page)
+{
+	unlock_page_err(page, 0);
 }
 EXPORT_SYMBOL(unlock_page);
 
@@ -1446,7 +1458,7 @@ void unlock_page_fscache(struct page *page)
 	page = compound_head(page);
 	VM_BUG_ON_PAGE(!PagePrivate2(page), page);
 	clear_bit_unlock(PG_fscache, &page->flags);
-	wake_up_page_bit(page, PG_fscache);
+	wake_up_page_bit(page, PG_fscache, 0);
 }
 EXPORT_SYMBOL(unlock_page_fscache);
 
@@ -2298,8 +2310,11 @@ static int filemap_update_page(struct kiocb *iocb,
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
 			return -EAGAIN;
 		if (!(iocb->ki_flags & IOCB_WAITQ)) {
-			put_and_wait_on_page_locked(page, TASK_KILLABLE);
-			return AOP_TRUNCATED_PAGE;
+			error = put_and_wait_on_page_locked(page,
+					TASK_KILLABLE);
+			if (!error)
+				return AOP_TRUNCATED_PAGE;
+			return error;
 		}
 		error = __lock_page_async(page, iocb->ki_waitq);
 		if (error)
