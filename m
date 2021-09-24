Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0B34179B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbhIXRV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347728AbhIXRUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632503912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Vd5ZE4YLtOCXyKgQM0MGouYb2uMkTroJbSS8in5XqM=;
        b=KMNZATf6gvkaTOegQWyD3/0JWMJMDYdmHm8neQSJJmBlS1JazzY+CruNH5qznPMu8i1gX0
        RlnHfHK10DRG5UTf3nx5lMa1ze9ix2r57Emd7vIWmrhZUk5inEP8mUrS2RzlseFqNRq8Tb
        VPgXP+BrN9L5//TbbAFIzhEVtaAuwI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-LV6ULrfEMW222u8Hp8wIZA-1; Fri, 24 Sep 2021 13:18:29 -0400
X-MC-Unique: LV6ULrfEMW222u8Hp8wIZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8234F1922035;
        Fri, 24 Sep 2021 17:18:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDCBC19D9F;
        Fri, 24 Sep 2021 17:18:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 3/9] mm: Make swap_readpage() void
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dhowells@redhat.com, dhowells@redhat.com, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 18:18:24 +0100
Message-ID: <163250390413.2330363.3248359518033939175.stgit@warthog.procyon.org.uk>
In-Reply-To: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

None of the callers of swap_readpage() actually check its return value and,
indeed, the operation may still be in progress, so remove the return value.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Darrick J. Wong <djwong@kernel.org>
cc: linux-xfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

 include/linux/swap.h |    2 +-
 mm/page_io.c         |   11 +++--------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 576d40e33b1f..293eba012d4f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -416,7 +416,7 @@ extern void kswapd_stop(int nid);
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
 /* linux/mm/page_io.c */
-extern int swap_readpage(struct page *page, bool do_poll);
+void swap_readpage(struct page *page, bool synchronous);
 extern int swap_writepage(struct page *page, struct writeback_control *wbc);
 int __swap_writepage(struct page *page, struct writeback_control *wbc);
 extern int swap_set_page_dirty(struct page *page);
diff --git a/mm/page_io.c b/mm/page_io.c
index afd18f6ec09e..b9fe25101a39 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -352,10 +352,9 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc)
 	return 0;
 }
 
-int swap_readpage(struct page *page, bool synchronous)
+void swap_readpage(struct page *page, bool synchronous)
 {
 	struct bio *bio;
-	int ret = 0;
 	struct swap_info_struct *sis = page_swap_info(page);
 	blk_qc_t qc;
 	struct gendisk *disk;
@@ -382,15 +381,13 @@ int swap_readpage(struct page *page, bool synchronous)
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
 
-		ret = mapping->a_ops->readpage(swap_file, page);
-		if (!ret)
+		if (!mapping->a_ops->readpage(swap_file, page))
 			count_vm_event(PSWPIN);
 		goto out;
 	}
 
 	if (sis->flags & SWP_SYNCHRONOUS_IO) {
-		ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
-		if (!ret) {
+		if (!bdev_read_page(sis->bdev, swap_page_sector(page), page)) {
 			if (trylock_page(page)) {
 				swap_slot_free_notify(page);
 				unlock_page(page);
@@ -401,7 +398,6 @@ int swap_readpage(struct page *page, bool synchronous)
 		}
 	}
 
-	ret = 0;
 	bio = bio_alloc(GFP_KERNEL, 1);
 	bio_set_dev(bio, sis->bdev);
 	bio->bi_opf = REQ_OP_READ;
@@ -435,7 +431,6 @@ int swap_readpage(struct page *page, bool synchronous)
 
 out:
 	psi_memstall_leave(&pflags);
-	return ret;
 }
 
 int swap_set_page_dirty(struct page *page)


