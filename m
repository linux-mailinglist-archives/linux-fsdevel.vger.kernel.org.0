Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A603EABB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 22:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhHLUXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 16:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235523AbhHLUXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628799759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3PjaRtIcO2Dhz+NqgsQ6uRqvSpUWTutj/OluxNvCw4I=;
        b=a8S/bFhUSIrxE7BlMhWSTlULkrhfxCR0TXmLP1fpKLGl5t5iOMRvkJn/FQmKEkMQhdmuwb
        7BuaCHphxFv1r0svhZHJFGTDzWAVrJVKaFbQ9yiNRBnBJg67X8vmHdiVXHwHi8afNYeZBS
        Nk0yvpZrsBU6qv3hJAuSMYP6U/nDUHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-YRDf8ugSOvanAlSrc8p2Ag-1; Thu, 12 Aug 2021 16:22:38 -0400
X-MC-Unique: YRDf8ugSOvanAlSrc8p2Ag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 292BC185302C;
        Thu, 12 Aug 2021 20:22:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F89F5C23A;
        Thu, 12 Aug 2021 20:22:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH v2 4/5] mm: Make __swap_writepage() do async DIO if asked
 for it
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, dhowells@redhat.com,
        dhowells@redhat.com, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, hch@lst.de, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 12 Aug 2021 21:22:32 +0100
Message-ID: <162879975253.3306668.15630001599959638168.stgit@warthog.procyon.org.uk>
In-Reply-To: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make __swap_writepage()'s DIO path do sync DIO if the writeback control's
sync mode is WB_SYNC_ALL and async DIO if not.

Note that this causes hanging processes in sunrpc if the swapfile is on
NFS.  I'm not sure whether it's due to misscheduling or something else.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: linux-nfs@vger.kernel.org
---

 mm/page_io.c |  145 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 102 insertions(+), 43 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 92ec4a7b0545..dae7bbd7a842 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -300,6 +300,105 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 #define bio_associate_blkg_from_page(bio, page)		do { } while (0)
 #endif /* CONFIG_MEMCG && CONFIG_BLK_CGROUP */
 
+static void __swapfile_write_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct page *page = iocb->ki_swap_page;
+
+	if (ret == thp_size(page)) {
+		count_vm_event(PSWPOUT);
+		ret = 0;
+	} else {
+		/*
+		 * In the case of swap-over-nfs, this can be a
+		 * temporary failure if the system has limited memory
+		 * for allocating transmit buffers.  Mark the page
+		 * dirty and avoid folio_rotate_reclaimable but
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
+static void swapfile_write_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct swapfile_kiocb *ki = container_of(iocb, struct swapfile_kiocb, iocb);
+
+	__swapfile_write_complete(iocb, ret, ret2);
+	swapfile_put_kiocb(ki);
+}
+
+static int swapfile_write_sync(struct swap_info_struct *sis,
+			       struct page *page, struct writeback_control *wbc)
+{
+	struct kiocb kiocb;
+	struct file *swap_file = sis->swap_file;
+	struct bio_vec bv = {
+		.bv_page	= page,
+		.bv_len		= thp_size(page),
+		.bv_offset	= 0
+	};
+	struct iov_iter from;
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
+	iov_iter_bvec(&from, WRITE, &bv, 1, thp_size(page));
+	ret = swap_file->f_mapping->a_ops->direct_IO(&kiocb, &from);
+	__swapfile_write_complete(&kiocb, ret, 0);
+	return (ret > 0) ? 0 : ret;
+}
+
+static int swapfile_write(struct swap_info_struct *sis,
+			  struct page *page, struct writeback_control *wbc)
+{
+	struct swapfile_kiocb *ki;
+	struct file *swap_file = sis->swap_file;
+	struct bio_vec bv = {
+		.bv_page	= page,
+		.bv_len		= thp_size(page),
+		.bv_offset	= 0
+	};
+	struct iov_iter from;
+	int ret;
+
+	if (wbc->sync_mode == WB_SYNC_ALL)
+		return swapfile_write_sync(sis, page, wbc);
+
+	ki = kzalloc(sizeof(*ki), GFP_KERNEL);
+	if (!ki)
+		return -ENOMEM;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
+	init_sync_kiocb(&ki->iocb, swap_file);
+	ki->iocb.ki_swap_page	= page;
+	ki->iocb.ki_pos		= page_file_offset(page);
+	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE | IOCB_SWAP;
+	ki->iocb.ki_complete	= swapfile_write_complete;
+	get_file(swap_file);
+
+	set_page_writeback(page);
+	unlock_page(page);
+	ret = swap_file->f_mapping->a_ops->direct_IO(&ki->iocb, &from);
+
+	if (ret != -EIOCBQUEUED)
+		swapfile_write_complete(&ki->iocb, ret, 0);
+	swapfile_put_kiocb(ki);
+	return (ret > 0) ? 0 : ret;
+}
+
 int __swap_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct bio *bio;
@@ -307,47 +406,8 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc)
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
-		ret = mapping->a_ops->direct_IO(&kiocb, &from);
-		if (ret == PAGE_SIZE) {
-			count_vm_event(PSWPOUT);
-			ret = 0;
-		} else {
-			/*
-			 * In the case of swap-over-nfs, this can be a
-			 * temporary failure if the system has limited
-			 * memory for allocating transmit buffers.
-			 * Mark the page dirty and avoid
-			 * folio_rotate_reclaimable but rate-limit the
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
@@ -410,7 +470,6 @@ static int swapfile_read_sync(struct swap_info_struct *sis, struct page *page)
 	init_sync_kiocb(&kiocb, swap_file);
 	kiocb.ki_swap_page	= page;
 	kiocb.ki_pos		= page_file_offset(page);
-	kiocb.ki_filp		= swap_file;
 	kiocb.ki_flags		= IOCB_DIRECT | IOCB_SWAP;
 	/* Should set IOCB_HIPRI too, but the box becomes unresponsive whilst
 	 * putting out occasional messages about the NFS sunrpc scheduling
@@ -449,8 +508,8 @@ static int swapfile_read(struct swap_info_struct *sis, struct page *page,
 	ki->iocb.ki_swap_page	= page;
 	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_SWAP;
 	ki->iocb.ki_pos		= page_file_offset(page);
-	ki->iocb.ki_filp	= get_file(swap_file);
 	ki->iocb.ki_complete	= swapfile_read_complete;
+	get_file(swap_file);
 
 	iov_iter_bvec(&to, READ, &bv, 1, thp_size(page));
 	ret = swap_file->f_mapping->a_ops->direct_IO(&ki->iocb, &to);


