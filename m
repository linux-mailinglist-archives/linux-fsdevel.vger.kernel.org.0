Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0D53EABB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhHLUXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 16:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237452AbhHLUW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628799750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmNW2mWHNd0CF2q46rKFU2zuLMA3busMBrPduaMV8ew=;
        b=Dxx8mmE86EJeJJo7gdyRJZ1zesN60MTnFHkdjJT83Zv6ay++1FsWCADYt0mJl8nXWT5TNk
        +aybHt7FWAtHcvmKC1ny7RyqW274qgUr3zdWfBSpHpygEKuhQvxPlNRe+csRdDx7mGQHlN
        fTVdfltx2hUb4mSIJr8oDeIEiGPfnx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-Na8LsIJzOrSlIr_klTKa_w-1; Thu, 12 Aug 2021 16:22:29 -0400
X-MC-Unique: Na8LsIJzOrSlIr_klTKa_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5060A1853033;
        Thu, 12 Aug 2021 20:22:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C4C528556;
        Thu, 12 Aug 2021 20:22:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH v2 3/5] mm: Make swap_readpage() for SWP_FS_OPS use
 ->direct_IO() not ->readpage()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, dhowells@redhat.com,
        trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        hch@lst.de, viro@zeniv.linux.org.uk, jlayton@kernel.org,
        sfrench@samba.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 12 Aug 2021 21:22:24 +0100
Message-ID: <162879974434.3306668.4798886633463058599.stgit@warthog.procyon.org.uk>
In-Reply-To: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make swap_readpage(), when accessing a swap file (SWP_FS_OPS) use
the ->direct_IO() method on the filesystem rather then ->readpage().

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/fs.h |    1 
 mm/page_io.c       |  115 +++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b3e6a20f28ef..94c47b9b5b1c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -336,6 +336,7 @@ struct kiocb {
 	union {
 		unsigned int		ki_cookie; /* for ->iopoll */
 		struct wait_page_queue	*ki_waitq; /* for async buffered IO */
+		struct page	*ki_swap_page;	/* For swapfile_read/write */
 	};
 
 	randomized_struct_fields_end
diff --git a/mm/page_io.c b/mm/page_io.c
index 62cabcdfcec6..92ec4a7b0545 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -26,6 +26,24 @@
 #include <linux/uio.h>
 #include <linux/sched/task.h>
 
+/*
+ * Keep track of the kiocb we're using to do async DIO.  We have to
+ * refcount it until various things stop looking at the kiocb *after*
+ * calling ->ki_complete().
+ */
+struct swapfile_kiocb {
+	struct kiocb		iocb;
+	refcount_t		ki_refcnt;
+};
+
+static void swapfile_put_kiocb(struct swapfile_kiocb *ki)
+{
+	if (refcount_dec_and_test(&ki->ki_refcnt)) {
+		fput(ki->iocb.ki_filp);
+		kfree(ki);
+	}
+}
+
 static void end_swap_bio_write(struct bio *bio)
 {
 	struct page *page = bio_first_page_all(bio);
@@ -353,6 +371,96 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc)
 	return 0;
 }
 
+static void __swapfile_read_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct page *page = iocb->ki_swap_page;
+
+	if (ret == PAGE_SIZE) {
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
+static void swapfile_read_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct swapfile_kiocb *ki = container_of(iocb, struct swapfile_kiocb, iocb);
+
+	__swapfile_read_complete(iocb, ret, ret2);
+	swapfile_put_kiocb(ki);
+}
+
+static int swapfile_read_sync(struct swap_info_struct *sis, struct page *page)
+{
+	struct kiocb kiocb;
+	struct file *swap_file = sis->swap_file;
+	struct bio_vec bv = {
+		.bv_page	= page,
+		.bv_len		= thp_size(page),
+		.bv_offset	= 0
+	};
+	struct iov_iter to;
+	int ret;
+
+	init_sync_kiocb(&kiocb, swap_file);
+	kiocb.ki_swap_page	= page;
+	kiocb.ki_pos		= page_file_offset(page);
+	kiocb.ki_filp		= swap_file;
+	kiocb.ki_flags		= IOCB_DIRECT | IOCB_SWAP;
+	/* Should set IOCB_HIPRI too, but the box becomes unresponsive whilst
+	 * putting out occasional messages about the NFS sunrpc scheduling
+	 * tasks being hung.
+	 */
+
+	iov_iter_bvec(&to, READ, &bv, 1, thp_size(page));
+	ret = swap_file->f_mapping->a_ops->direct_IO(&kiocb, &to);
+
+	__swapfile_read_complete(&kiocb, ret, 0);
+	return (ret > 0) ? 0 : ret;
+}
+
+static int swapfile_read(struct swap_info_struct *sis, struct page *page,
+			 bool synchronous)
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
+	if (synchronous)
+		return swapfile_read_sync(sis, page);
+
+	ki = kzalloc(sizeof(*ki), GFP_KERNEL);
+	if (!ki)
+		return -ENOMEM;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	init_sync_kiocb(&ki->iocb, swap_file);
+	ki->iocb.ki_swap_page	= page;
+	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_SWAP;
+	ki->iocb.ki_pos		= page_file_offset(page);
+	ki->iocb.ki_filp	= get_file(swap_file);
+	ki->iocb.ki_complete	= swapfile_read_complete;
+
+	iov_iter_bvec(&to, READ, &bv, 1, thp_size(page));
+	ret = swap_file->f_mapping->a_ops->direct_IO(&ki->iocb, &to);
+
+	if (ret != -EIOCBQUEUED)
+		swapfile_read_complete(&ki->iocb, ret, 0);
+	swapfile_put_kiocb(ki);
+	return (ret > 0) ? 0 : ret;
+}
+
 int swap_readpage(struct page *page, bool synchronous)
 {
 	struct bio *bio;
@@ -380,12 +488,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		struct file *swap_file = sis->swap_file;
-		struct address_space *mapping = swap_file->f_mapping;
-
-		ret = mapping->a_ops->readpage(swap_file, page);
-		if (!ret)
-			count_vm_event(PSWPIN);
+		ret = swapfile_read(sis, page, synchronous);
 		goto out;
 	}
 


