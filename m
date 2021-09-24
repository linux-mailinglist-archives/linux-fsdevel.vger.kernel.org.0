Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E384179A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347760AbhIXRTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347686AbhIXRTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632503896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NNU0bFI5zkvJJJmtP4TNyGEOQ6HKFpxRqWA6pe5+eN8=;
        b=Eg+GQzXZeqmS/k0LYQ5A8Cx9QqmGzFYqJKj2W2sjvAPtIfjr8Lub2wJHtNLP/Nzcy1ZmNB
        UxKMUsKnvHQhjdNbi0DfpPm//VzbKjEEUmWePKX6616E6y+pyl2n6TOHrlVNC+4GJy8eWi
        CwLZDFj+B+/+k4lf8rD/9kZeI79DL54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-dzhGp2qYMX-bXRkOQ6RAuA-1; Fri, 24 Sep 2021 13:18:12 -0400
X-MC-Unique: dzhGp2qYMX-bXRkOQ6RAuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 745DF1922039;
        Fri, 24 Sep 2021 17:18:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 098FD5D9DE;
        Fri, 24 Sep 2021 17:18:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 1/9] mm: Remove the callback func argument from
 __swap_writepage()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Seth Jennings <sjenning@linux.vnet.ibm.com>,
        Bob Liu <bob.liu@oracle.com>, Minchan Kim <minchan@kernel.org>,
        Dan Magenheimer <dan.magenheimer@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dhowells@redhat.com, dhowells@redhat.com, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 18:18:05 +0100
Message-ID: <163250388519.2330363.14896768040342703526.stgit@warthog.procyon.org.uk>
In-Reply-To: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the callback func argument from __swap_writepage() as it's
end_swap_bio_write() in both places that call it.

This reverts:

	commit 1eec6702a80e04416d528846a5ff2122484d95ec
	mm: allow for outstanding swap writeback accounting

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Darrick J. Wong <djwong@kernel.org>
cc: Seth Jennings <sjenning@linux.vnet.ibm.com>
cc: Bob Liu <bob.liu@oracle.com>
cc: Minchan Kim <minchan@kernel.org>
cc: Dan Magenheimer <dan.magenheimer@oracle.com>
cc: linux-block@vger.kernel.org
cc: linux-xfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

 include/linux/swap.h |    4 +---
 mm/page_io.c         |    9 ++++-----
 mm/zswap.c           |    2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ba52f3a3478e..576d40e33b1f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -418,9 +418,7 @@ extern void kswapd_stop(int nid);
 /* linux/mm/page_io.c */
 extern int swap_readpage(struct page *page, bool do_poll);
 extern int swap_writepage(struct page *page, struct writeback_control *wbc);
-extern void end_swap_bio_write(struct bio *bio);
-extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
-	bio_end_io_t end_write_func);
+int __swap_writepage(struct page *page, struct writeback_control *wbc);
 extern int swap_set_page_dirty(struct page *page);
 
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
diff --git a/mm/page_io.c b/mm/page_io.c
index c493ce9ebcf5..afd18f6ec09e 100644
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
@@ -341,7 +340,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
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
 


