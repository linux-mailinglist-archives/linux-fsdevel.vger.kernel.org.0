Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F53EA42C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 13:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhHLL6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 07:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237140AbhHLL6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628769486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wdKGvZeZhG6ZhsVwcrNbC/I62CcUzp285FqM7Ey5wvA=;
        b=UPdJeoV7S/tXgMH3H82Cj65SDytDLBOMcARU4O/Y3z87OiEg9MetGndQIjFIuIhEkl5zOt
        L8pBgqO5emUOQ+8zzbfrlfl9Q6x7RsDL7ejB1c89wWxTIduBl3A84muNH2Sr/bfngbZnfv
        PW9qRX3KcCdopkxnN82n/pBM76xV9QU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-oAbktps4N5qq2jOoTy82ag-1; Thu, 12 Aug 2021 07:58:03 -0400
X-MC-Unique: oAbktps4N5qq2jOoTy82ag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F6631853035;
        Thu, 12 Aug 2021 11:58:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30B8060657;
        Thu, 12 Aug 2021 11:57:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use ->direct_IO()
 not ->readpage()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, trond.myklebust@primarydata.com,
        darrick.wong@oracle.com, hch@lst.de, jlayton@kernel.org,
        sfrench@samba.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 12 Aug 2021 12:57:58 +0100
Message-ID: <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
In-Reply-To: <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk>
References: <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make swap_readpage(), when accessing a swap file (SWP_FS_OPS) use
the ->direct_IO() method on the filesystem rather then ->readpage().

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 mm/page_io.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 6 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index edb72bf624d2..108f864cea28 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -354,6 +354,72 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	return 0;
 }
 
+struct swapfile_kiocb {
+	struct kiocb		iocb;
+	struct page		*page;
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
+static void swapfile_read_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct swapfile_kiocb *ki = container_of(iocb, struct swapfile_kiocb, iocb);
+	struct page *page = ki->page;
+
+	if (ret == PAGE_SIZE) {
+		count_vm_event(PSWPIN);
+		SetPageUptodate(page);
+	} else {
+		pr_err_ratelimited("Read error (%ld) on dio swapfile (%llu)\n",
+				   ret, page_file_offset(page));
+	}
+
+	unlock_page(page);
+	swapfile_put_kiocb(ki);
+}
+
+static int swapfile_read(struct swap_info_struct *sis, struct page *page,
+			 bool synchronous)
+{
+	struct swapfile_kiocb *ki;
+	struct file *swap_file = sis->swap_file;
+	struct bio_vec bv = {
+		.bv_page = page,
+		.bv_len  = PAGE_SIZE,
+		.bv_offset = 0
+	};
+	struct iov_iter to;
+	int ret;
+
+	ki = kzalloc(sizeof(*ki), GFP_KERNEL);
+	if (!ki)
+		return -ENOMEM;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	init_sync_kiocb(&ki->iocb, swap_file);
+	ki->page = page;
+	ki->iocb.ki_flags = IOCB_DIRECT | IOCB_SWAP;
+	ki->iocb.ki_pos	= page_file_offset(page);
+	ki->iocb.ki_filp = get_file(swap_file);
+	if (!synchronous)
+		ki->iocb.ki_complete = swapfile_read_complete;
+
+	iov_iter_bvec(&to, READ, &bv, 1, PAGE_SIZE);
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
@@ -381,12 +447,7 @@ int swap_readpage(struct page *page, bool synchronous)
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
 


