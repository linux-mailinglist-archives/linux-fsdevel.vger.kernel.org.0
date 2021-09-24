Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606E64179BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347838AbhIXRVv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347611AbhIXRUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632503943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+XD7Zi/YFKEa2yF0urj/0T7v2kKhbU5Vfw3G+ykgV0=;
        b=Mg1BkYY1e5VIfz7Uhtel/xxgNtbhLLsEJVq+UrKyC9wrukeUGiiME71r50etXgUiJJpbzj
        JN9hagzYmloZtnf1Lvub8hrDy4KPHEFM3Q8LRbXYwphPEYIqKnYpbvEcXJAacikl2LiYx7
        QCQxOF0j8eK1SihUGlZqaMe4xXRqAF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-4a3NA8WpOZiVovrffGCEEQ-1; Fri, 24 Sep 2021 13:19:00 -0400
X-MC-Unique: 4a3NA8WpOZiVovrffGCEEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2708E84A5E9;
        Fri, 24 Sep 2021 17:18:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C30D69320;
        Fri, 24 Sep 2021 17:18:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 6/9] mm: Make __swap_writepage() do async DIO if asked for
 it
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, dhowells@redhat.com, dhowells@redhat.com,
        darrick.wong@oracle.com, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 18:18:54 +0100
Message-ID: <163250393435.2330363.12822795853508093546.stgit@warthog.procyon.org.uk>
In-Reply-To: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make __swap_writepage()'s DIO path do sync DIO if the writeback control's
sync mode is WB_SYNC_ALL and async DIO if not.

Note that this causes hanging processes in sunrpc if the swapfile is on
NFS.  I'm not sure whether it's due to misscheduling or something else.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Darrick J. Wong <djwong@kernel.org>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: linux-nfs@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-xfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

 mm/page_io.c |  133 ++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 92 insertions(+), 41 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 6b1465699c72..8f1199d59162 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -298,6 +298,96 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 #define bio_associate_blkg_from_page(bio, page)		do { } while (0)
 #endif /* CONFIG_MEMCG && CONFIG_BLK_CGROUP */
 
+static void swapfile_write_complete(struct page *page, long ret)
+{
+	if (ret == thp_size(page)) {
+		count_swpout_vm_event(page);
+	} else {
+		/*
+		 * In the case of swap-over-nfs, this can be a
+		 * temporary failure if the system has limited memory
+		 * for allocating transmit buffers.  Mark the page
+		 * dirty and avoid rotate_reclaimable_page but
+		 * rate-limit the messages but do not flag PageError
+		 * like the normal direct-to-bio case as it could be
+		 * temporary.
+		 */
+		set_page_dirty(page);
+		ClearPageReclaim(page);
+		pr_err_ratelimited("Write error (%ld) on dio swapfile (%llu)\n",
+				   ret, page_file_offset(page));
+	}
+	end_page_writeback(page);
+}
+
+static void __swapfile_write_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct swapfile_kiocb *ki = container_of(iocb, struct swapfile_kiocb, iocb);
+
+	swapfile_write_complete(iocb->ki_swap_page, ret);
+	swapfile_put_kiocb(ki);
+}
+
+static int swapfile_write_sync(struct swap_info_struct *sis,
+			       struct page *page, struct writeback_control *wbc,
+			       struct iov_iter *from)
+{
+	struct kiocb kiocb;
+	struct file *swap_file = sis->swap_file;
+	int ret;
+
+	init_sync_kiocb(&kiocb, swap_file);
+	kiocb.ki_swap_page	= page;
+	kiocb.ki_pos		= page_file_offset(page);
+	kiocb.ki_flags		= IOCB_DIRECT | IOCB_WRITE | IOCB_SWAP;
+
+	set_page_writeback(page);
+	unlock_page(page);
+
+	ret = swap_file->f_mapping->a_ops->swap_rw(&kiocb, from);
+	swapfile_write_complete(page, ret);
+	return ret == page_size(page) ? 0 : ret >= 0 ? -ENODATA : ret;
+}
+
+static int swapfile_write(struct swap_info_struct *sis,
+			  struct page *page, struct writeback_control *wbc)
+{
+	struct swapfile_kiocb *ki;
+	struct file *swap_file = sis->swap_file;
+	struct bio_vec bv = {
+		.bv_page	= page,
+		.bv_len		= page_size(page),
+		.bv_offset	= 0
+	};
+	struct iov_iter from;
+	int ret;
+
+	iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
+
+	if (wbc->sync_mode == WB_SYNC_ALL)
+		return swapfile_write_sync(sis, page, wbc, &from);
+
+	ki = kzalloc(sizeof(*ki), GFP_KERNEL);
+	if (!ki)
+		return -ENOMEM;
+
+	refcount_set(&ki->ref, 2);
+	init_sync_kiocb(&ki->iocb, swap_file);
+	ki->iocb.ki_swap_page	= page;
+	ki->iocb.ki_pos		= page_file_offset(page);
+	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE | IOCB_SWAP;
+	ki->iocb.ki_complete	= __swapfile_write_complete;
+
+	set_page_writeback(page);
+	unlock_page(page);
+	ret = swap_file->f_mapping->a_ops->swap_rw(&ki->iocb, &from);
+
+	if (ret != -EIOCBQUEUED)
+		__swapfile_write_complete(&ki->iocb, ret, 0);
+	swapfile_put_kiocb(ki);
+	return ret == page_size(page) ? 0 : ret >= 0 ? -ENODATA : ret;
+}
+
 int __swap_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct bio *bio;
@@ -305,47 +395,8 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc)
 	struct swap_info_struct *sis = page_swap_info(page);
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
-	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct kiocb kiocb;
-		struct file *swap_file = sis->swap_file;
-		struct address_space *mapping = swap_file->f_mapping;
-		struct bio_vec bv = {
-			.bv_page = page,
-			.bv_len  = PAGE_SIZE,
-			.bv_offset = 0
-		};
-		struct iov_iter from;
-
-		iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
-		init_sync_kiocb(&kiocb, swap_file);
-		kiocb.ki_pos	= page_file_offset(page);
-		kiocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE | IOCB_SWAP;
-
-		set_page_writeback(page);
-		unlock_page(page);
-		ret = mapping->a_ops->swap_rw(&kiocb, &from);
-		if (ret == PAGE_SIZE) {
-			count_vm_event(PSWPOUT);
-			ret = 0;
-		} else {
-			/*
-			 * In the case of swap-over-nfs, this can be a
-			 * temporary failure if the system has limited
-			 * memory for allocating transmit buffers.
-			 * Mark the page dirty and avoid
-			 * rotate_reclaimable_page but rate-limit the
-			 * messages but do not flag PageError like
-			 * the normal direct-to-bio case as it could
-			 * be temporary.
-			 */
-			set_page_dirty(page);
-			ClearPageReclaim(page);
-			pr_err_ratelimited("Write error (%d) on dio swapfile (%llu)\n",
-					   ret, page_file_offset(page));
-		}
-		end_page_writeback(page);
-		return ret;
-	}
+	if (data_race(sis->flags & SWP_FS_OPS))
+		return swapfile_write(sis, page, wbc);
 
 	ret = bdev_write_page(sis->bdev, swap_page_sector(page), page, wbc);
 	if (!ret) {


