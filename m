Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F44179B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbhIXRVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347806AbhIXRU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632503933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wh92/GIQSWuimSHEUrh/KLNHrbQS0s/D/rLAazMZI+U=;
        b=f8uJXzBxwn5QtAtLpTvkorUshsPcz2+00rm0FhyFRPW+TTC5DSGa9hoqc5nvykJO2rt9xL
        4bGnNfHZB8KnHaT9t1QnkldOptN3gahbkHnAikdrSh54HY49vujhz0+/xeNvIhGRrDElnh
        HBj9xWvhVyKRdQzkvjd3KCq3seoUYhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-gHqa0HBcMl20u-8s2KXwMA-1; Fri, 24 Sep 2021 13:18:51 -0400
X-MC-Unique: gHqa0HBcMl20u-8s2KXwMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2220E1922023;
        Fri, 24 Sep 2021 17:18:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CBB21017E36;
        Fri, 24 Sep 2021 17:18:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 5/9] mm: Make swap_readpage() for SWP_FS_OPS use
 ->swap_rw() not ->readpage()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, dhowells@redhat.com, dhowells@redhat.com,
        darrick.wong@oracle.com, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 18:18:41 +0100
Message-ID: <163250392134.2330363.2715808422502485629.stgit@warthog.procyon.org.uk>
In-Reply-To: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make swap_readpage() use the ->swap_rw() method on the filesystem to do
direct I/O rather then ->readpage() when accessing a swap file
(SWP_FS_OPS).

Make swap_writepage() similarly use ->swap_rw() also rather than the
->direct_IO() method.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Darrick J. Wong <djwong@kernel.org>
cc: linux-block@vger.kernel.org
cc: linux-xfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

 include/linux/fs.h |    2 +
 mm/page_io.c       |  106 +++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 98 insertions(+), 10 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c20f4423e2f1..c8f7724ecded 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -338,6 +338,7 @@ struct kiocb {
 	union {
 		unsigned int		ki_cookie; /* for ->iopoll */
 		struct wait_page_queue	*ki_waitq; /* for async buffered IO */
+		struct page	*ki_swap_page;	/* For swapfile_read/write */
 	};
 
 	randomized_struct_fields_end
@@ -404,6 +405,7 @@ struct address_space_operations {
 	int (*releasepage) (struct page *, gfp_t);
 	void (*freepage)(struct page *);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
+	ssize_t (*swap_rw)(struct kiocb *, struct iov_iter *);
 	/*
 	 * migrate the contents of a page to the specified target. If
 	 * migrate_mode is MIGRATE_ASYNC, it must not block.
diff --git a/mm/page_io.c b/mm/page_io.c
index b9fe25101a39..6b1465699c72 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -4,7 +4,7 @@
  *
  *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
  *
- *  Swap reorganised 29.12.95, 
+ *  Swap reorganised 29.12.95,
  *  Asynchronous swapping added 30.12.95. Stephen Tweedie
  *  Removed race in async swapping. 14.4.1996. Bruno Haible
  *  Add swap of shared pages through the page cache. 20.2.1998. Stephen Tweedie
@@ -26,6 +26,22 @@
 #include <linux/uio.h>
 #include <linux/sched/task.h>
 
+/*
+ * Keep track of the kiocb we're using to do async DIO.  We have to
+ * refcount it until various things stop looking at the kiocb *after*
+ * calling ->ki_complete().
+ */
+struct swapfile_kiocb {
+	struct kiocb		iocb;
+	refcount_t		ref;
+};
+
+static void swapfile_put_kiocb(struct swapfile_kiocb *ki)
+{
+	if (refcount_dec_and_test(&ki->ref))
+		kfree(ki);
+}
+
 static void end_swap_bio_write(struct bio *bio)
 {
 	struct page *page = bio_first_page_all(bio);
@@ -302,11 +318,12 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc)
 
 		iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
 		init_sync_kiocb(&kiocb, swap_file);
-		kiocb.ki_pos = page_file_offset(page);
+		kiocb.ki_pos	= page_file_offset(page);
+		kiocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE | IOCB_SWAP;
 
 		set_page_writeback(page);
 		unlock_page(page);
-		ret = mapping->a_ops->direct_IO(&kiocb, &from);
+		ret = mapping->a_ops->swap_rw(&kiocb, &from);
 		if (ret == PAGE_SIZE) {
 			count_vm_event(PSWPOUT);
 			ret = 0;
@@ -323,8 +340,8 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc)
 			 */
 			set_page_dirty(page);
 			ClearPageReclaim(page);
-			pr_err_ratelimited("Write error on dio swapfile (%llu)\n",
-					   page_file_offset(page));
+			pr_err_ratelimited("Write error (%d) on dio swapfile (%llu)\n",
+					   ret, page_file_offset(page));
 		}
 		end_page_writeback(page);
 		return ret;
@@ -352,6 +369,79 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc)
 	return 0;
 }
 
+static void swapfile_read_complete(struct page *page, long ret)
+{
+	if (ret == page_size(page)) {
+		count_vm_event(PSWPIN);
+		SetPageUptodate(page);
+	} else {
+		SetPageError(page);
+		pr_err_ratelimited("Read error (%ld) on dio swapfile (%llu)\n",
+				   ret, page_file_offset(page));
+	}
+
+	unlock_page(page);
+}
+
+static void __swapfile_read_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct swapfile_kiocb *ki = container_of(iocb, struct swapfile_kiocb, iocb);
+
+	swapfile_read_complete(iocb->ki_swap_page, ret);
+	swapfile_put_kiocb(ki);
+}
+
+static void swapfile_read_sync(struct swap_info_struct *sis, struct page *page,
+			       struct iov_iter *to)
+{
+	struct kiocb kiocb;
+	struct file *swap_file = sis->swap_file;
+	int ret;
+
+	init_sync_kiocb(&kiocb, swap_file);
+	kiocb.ki_swap_page	= page;
+	kiocb.ki_pos		= page_file_offset(page);
+	kiocb.ki_flags		= IOCB_DIRECT | IOCB_SWAP;
+	ret = swap_file->f_mapping->a_ops->swap_rw(&kiocb, to);
+
+	swapfile_read_complete(page, ret);
+}
+
+static void swapfile_read(struct swap_info_struct *sis, struct page *page,
+			  bool synchronous)
+{
+	struct swapfile_kiocb *ki;
+	struct file *swap_file = sis->swap_file;
+	struct bio_vec bv = {
+		.bv_page = page,
+		.bv_len  = thp_size(page),
+		.bv_offset = 0
+	};
+	struct iov_iter to;
+	int ret;
+
+	iov_iter_bvec(&to, READ, &bv, 1, thp_size(page));
+
+	if (synchronous)
+		return swapfile_read_sync(sis, page, &to);
+
+	ki = kzalloc(sizeof(*ki), GFP_KERNEL);
+	if (!ki)
+		return;
+
+	refcount_set(&ki->ref, 2);
+	init_sync_kiocb(&ki->iocb, swap_file);
+	ki->iocb.ki_swap_page	= page;
+	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_SWAP;
+	ki->iocb.ki_pos		= page_file_offset(page);
+	ki->iocb.ki_complete	= __swapfile_read_complete;
+
+	ret = swap_file->f_mapping->a_ops->swap_rw(&ki->iocb, &to);
+	if (ret != -EIOCBQUEUED)
+		__swapfile_read_complete(&ki->iocb, ret, 0);
+	swapfile_put_kiocb(ki);
+}
+
 void swap_readpage(struct page *page, bool synchronous)
 {
 	struct bio *bio;
@@ -378,11 +468,7 @@ void swap_readpage(struct page *page, bool synchronous)
 	}
 
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct file *swap_file = sis->swap_file;
-		struct address_space *mapping = swap_file->f_mapping;
-
-		if (!mapping->a_ops->readpage(swap_file, page))
-			count_vm_event(PSWPIN);
+		swapfile_read(sis, page, synchronous);
 		goto out;
 	}
 


