Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75DA696AFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 18:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjBNRO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 12:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBNRO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5936A274
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 09:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676394826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSLOPyPBTyGpP+6+bR7yKU/VhAXOTSaAngOTYdMp3ic=;
        b=TYVciyMlLp9otdmb85E/E2GnJs9xPk2bfHozOwhkFUjbZTDg+g7UyuJpfqZATX0YVN/CoN
        GAszEpwqWZoaH7ZI56ybbqo+CAFl2Diq4oBUMIEAMe6i5ZcbDs0EpPnReoENmV1Pxda9EQ
        WYn+iTH6i3zfHdZ0WKfK2c4joGT/zf4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-r6zz-Qt7OtqamK4CCCrB6g-1; Tue, 14 Feb 2023 12:13:41 -0500
X-MC-Unique: r6zz-Qt7OtqamK4CCCrB6g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 095C2101A521;
        Tue, 14 Feb 2023 17:13:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D5A4492B03;
        Tue, 14 Feb 2023 17:13:35 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v14 01/17] mm: Pass info, not iter, into filemap_get_pages()
Date:   Tue, 14 Feb 2023 17:13:14 +0000
Message-Id: <20230214171330.2722188-2-dhowells@redhat.com>
In-Reply-To: <20230214171330.2722188-1-dhowells@redhat.com>
References: <20230214171330.2722188-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filemap_get_pages() and a number of functions that it calls take an
iterator to provide two things: the number of bytes to be got from the file
specified and whether partially uptodate pages are allowed.  Change these
functions so that this information is passed in directly.  This allows it
to be called without having an iterator to hand.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 mm/filemap.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c4d4ace9cc70..876e77278d2a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2440,21 +2440,19 @@ static int filemap_read_folio(struct file *file, filler_t filler,
 }
 
 static bool filemap_range_uptodate(struct address_space *mapping,
-		loff_t pos, struct iov_iter *iter, struct folio *folio)
+		loff_t pos, size_t count, struct folio *folio,
+		bool need_uptodate)
 {
-	int count;
-
 	if (folio_test_uptodate(folio))
 		return true;
 	/* pipes can't handle partially uptodate pages */
-	if (iov_iter_is_pipe(iter))
+	if (need_uptodate)
 		return false;
 	if (!mapping->a_ops->is_partially_uptodate)
 		return false;
 	if (mapping->host->i_blkbits >= folio_shift(folio))
 		return false;
 
-	count = iter->count;
 	if (folio_pos(folio) > pos) {
 		count -= folio_pos(folio) - pos;
 		pos = 0;
@@ -2466,8 +2464,8 @@ static bool filemap_range_uptodate(struct address_space *mapping,
 }
 
 static int filemap_update_page(struct kiocb *iocb,
-		struct address_space *mapping, struct iov_iter *iter,
-		struct folio *folio)
+		struct address_space *mapping, size_t count,
+		struct folio *folio, bool need_uptodate)
 {
 	int error;
 
@@ -2501,7 +2499,8 @@ static int filemap_update_page(struct kiocb *iocb,
 		goto unlock;
 
 	error = 0;
-	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, folio))
+	if (filemap_range_uptodate(mapping, iocb->ki_pos, count, folio,
+				   need_uptodate))
 		goto unlock;
 
 	error = -EAGAIN;
@@ -2577,8 +2576,8 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 	return 0;
 }
 
-static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
-		struct folio_batch *fbatch)
+static int filemap_get_pages(struct kiocb *iocb, size_t count,
+		struct folio_batch *fbatch, bool need_uptodate)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2588,7 +2587,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	struct folio *folio;
 	int err = 0;
 
-	last_index = DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
+	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
 retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -2621,7 +2620,8 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		if ((iocb->ki_flags & IOCB_WAITQ) &&
 		    folio_batch_count(fbatch) > 1)
 			iocb->ki_flags |= IOCB_NOWAIT;
-		err = filemap_update_page(iocb, mapping, iter, folio);
+		err = filemap_update_page(iocb, mapping, count, folio,
+					  need_uptodate);
 		if (err)
 			goto err;
 	}
@@ -2691,7 +2691,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
 			break;
 
-		error = filemap_get_pages(iocb, iter, &fbatch);
+		error = filemap_get_pages(iocb, iter->count, &fbatch,
+					  iov_iter_is_pipe(iter));
 		if (error < 0)
 			break;
 

