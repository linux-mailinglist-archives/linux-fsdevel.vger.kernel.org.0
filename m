Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670B03EABB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 22:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhHLUWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 16:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235232AbhHLUWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628799744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78K4D7iEyfZAy66gDZncwdkERY71xPhDycqvasMywDk=;
        b=hoca/IHftv4d3PO/hl9MyBVtGX53JixmjkVNF6gVBaWdTlsUEsXmR2IvaaIKkYrN/exVaj
        5jGkYSMpvviJNelxs7XS6mOdr35UqLxhw7XAWbmyQFztA8XYi/2jam94vzJ21bbk0g91sg
        sXXL/bGwJUSp+MDm/XNBG3pbXL9hwbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-P7YgFk1mPIqz992NKuug1g-1; Thu, 12 Aug 2021 16:22:21 -0400
X-MC-Unique: P7YgFk1mPIqz992NKuug1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E98E1008060;
        Thu, 12 Aug 2021 20:22:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AFC760C05;
        Thu, 12 Aug 2021 20:22:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH v2 2/5] mm: Remove the callback func argument from
 __swap_writepage()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     Seth Jennings <sjenning@linux.vnet.ibm.com>,
        Bob Liu <bob.liu@oracle.com>, Minchan Kim <minchan@kernel.org>,
        Dan Magenheimer <dan.magenheimer@oracle.com>,
        dhowells@redhat.com, dhowells@redhat.com,
        trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        hch@lst.de, viro@zeniv.linux.org.uk, jlayton@kernel.org,
        sfrench@samba.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 12 Aug 2021 21:22:15 +0100
Message-ID: <162879973548.3306668.4893577928865857447.stgit@warthog.procyon.org.uk>
In-Reply-To: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the callback func argument from __swap_writepage() as it's
end_swap_bio_write() in both places that call it.

This reverts:

	commit 1eec6702a80e04416d528846a5ff2122484d95ec
	mm: allow for outstanding swap writeback accounting

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Seth Jennings <sjenning@linux.vnet.ibm.com>
cc: Bob Liu <bob.liu@oracle.com>
cc: Minchan Kim <minchan@kernel.org>
cc: Dan Magenheimer <dan.magenheimer@oracle.com>
---

 include/linux/swap.h |    4 +---
 mm/page_io.c         |    9 ++++-----
 mm/zswap.c           |    2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 81801ba78b1e..b785bb041a44 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -425,9 +425,7 @@ extern void kswapd_stop(int nid);
 /* linux/mm/page_io.c */
 extern int swap_readpage(struct page *page, bool do_poll);
 extern int swap_writepage(struct page *page, struct writeback_control *wbc);
-extern void end_swap_bio_write(struct bio *bio);
-extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
-	bio_end_io_t end_write_func);
+extern int __swap_writepage(struct page *page, struct writeback_control *wbc);
 extern int swap_set_page_dirty(struct page *page);
 
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
diff --git a/mm/page_io.c b/mm/page_io.c
index edb72bf624d2..62cabcdfcec6 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -26,7 +26,7 @@
 #include <linux/uio.h>
 #include <linux/sched/task.h>
 
-void end_swap_bio_write(struct bio *bio)
+static void end_swap_bio_write(struct bio *bio)
 {
 	struct page *page = bio_first_page_all(bio);
 
@@ -249,7 +249,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		end_page_writeback(page);
 		goto out;
 	}
-	ret = __swap_writepage(page, wbc, end_swap_bio_write);
+	ret = __swap_writepage(page, wbc);
 out:
 	return ret;
 }
@@ -282,8 +282,7 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 #define bio_associate_blkg_from_page(bio, page)		do { } while (0)
 #endif /* CONFIG_MEMCG && CONFIG_BLK_CGROUP */
 
-int __swap_writepage(struct page *page, struct writeback_control *wbc,
-		bio_end_io_t end_write_func)
+int __swap_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct bio *bio;
 	int ret;
@@ -342,7 +341,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	bio_set_dev(bio, sis->bdev);
 	bio->bi_iter.bi_sector = swap_page_sector(page);
 	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
-	bio->bi_end_io = end_write_func;
+	bio->bi_end_io = end_swap_bio_write;
 	bio_add_page(bio, page, thp_size(page), 0);
 
 	bio_associate_blkg_from_page(bio, page);
diff --git a/mm/zswap.c b/mm/zswap.c
index 7944e3e57e78..f38e34917aa3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1011,7 +1011,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	SetPageReclaim(page);
 
 	/* start writeback */
-	__swap_writepage(page, &wbc, end_swap_bio_write);
+	__swap_writepage(page, &wbc);
 	put_page(page);
 	zswap_written_back_pages++;
 


