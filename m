Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3934F3EABBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 22:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbhHLUXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 16:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237645AbhHLUXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628799769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ky+LOtMAnxfOrF4U8ZetcHe2dR1USBrS9gYy/2Wr6Ig=;
        b=Izku0CvWzLUvUdIA5Qdu4qiJ11OMOjtOc26xfUhZDZ6KeRCntIqnxip1bw2xmpQFA3MBdT
        YgTcCf28DAd//uuoPotsnUZLMdRE1hHXD9lORgD9S2xwkf8r/fNvorRyryiq+eNdoHKDIi
        7hYa9y2SlACXhiDPWoakJMmIX2BFVLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-cIGfTAv2MU-tGSQChAlpyQ-1; Thu, 12 Aug 2021 16:22:46 -0400
X-MC-Unique: cIGfTAv2MU-tGSQChAlpyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A8F88799E0;
        Thu, 12 Aug 2021 20:22:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 336435D9D5;
        Thu, 12 Aug 2021 20:22:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH v2 5/5] mm: Remove swap BIO paths and only use DIO paths
 [BROKEN]
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, dhowells@redhat.com,
        trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        hch@lst.de, viro@zeniv.linux.org.uk, jlayton@kernel.org,
        sfrench@samba.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 12 Aug 2021 21:22:41 +0100
Message-ID: <162879976139.3306668.12495248062404308890.stgit@warthog.procyon.org.uk>
In-Reply-To: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
References: <162879971699.3306668.8977537647318498651.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[!] NOTE: This doesn't work and might damage your disk's contents.

Delete the BIO-generating swap read/write paths and always use
->direct_IO().  This puts the mapping layer in the filesystem.

This doesn't work - probably due to ki_pos being set to
page_file_offset(page) which then gets remapped.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/direct-io.c      |    2 +
 include/linux/bio.h |    2 +
 mm/page_io.c        |  156 ++-------------------------------------------------
 3 files changed, 9 insertions(+), 151 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b2e86e739d7a..76eec0a68fa4 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1216,6 +1216,8 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	}
 	if (iocb->ki_flags & IOCB_HIPRI)
 		dio->op_flags |= REQ_HIPRI;
+	if (iocb->ki_flags & IOCB_SWAP)
+		dio->op_flags |= REQ_SWAP;
 
 	/*
 	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2203b686e1f0..da75cfa72ed3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -816,6 +816,8 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 	bio->bi_opf |= REQ_HIPRI;
 	if (!is_sync_kiocb(kiocb))
 		bio->bi_opf |= REQ_NOWAIT;
+	if (kiocb->ki_flags & IOCB_SWAP)
+		bio->bi_opf |= REQ_SWAP;
 }
 
 struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
diff --git a/mm/page_io.c b/mm/page_io.c
index dae7bbd7a842..fb260d9c3973 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -44,30 +44,6 @@ static void swapfile_put_kiocb(struct swapfile_kiocb *ki)
 	}
 }
 
-static void end_swap_bio_write(struct bio *bio)
-{
-	struct page *page = bio_first_page_all(bio);
-
-	if (bio->bi_status) {
-		SetPageError(page);
-		/*
-		 * We failed to write the page out to swap-space.
-		 * Re-dirty the page in order to avoid it being reclaimed.
-		 * Also print a dire warning that things will go BAD (tm)
-		 * very quickly.
-		 *
-		 * Also clear PG_reclaim to avoid folio_rotate_reclaimable()
-		 */
-		set_page_dirty(page);
-		pr_alert_ratelimited("Write-error on swap-device (%u:%u:%llu)\n",
-				     MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
-				     (unsigned long long)bio->bi_iter.bi_sector);
-		ClearPageReclaim(page);
-	}
-	end_page_writeback(page);
-	bio_put(bio);
-}
-
 static void swap_slot_free_notify(struct page *page)
 {
 	struct swap_info_struct *sis;
@@ -116,32 +92,6 @@ static void swap_slot_free_notify(struct page *page)
 	}
 }
 
-static void end_swap_bio_read(struct bio *bio)
-{
-	struct page *page = bio_first_page_all(bio);
-	struct task_struct *waiter = bio->bi_private;
-
-	if (bio->bi_status) {
-		SetPageError(page);
-		ClearPageUptodate(page);
-		pr_alert_ratelimited("Read-error on swap-device (%u:%u:%llu)\n",
-				     MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
-				     (unsigned long long)bio->bi_iter.bi_sector);
-		goto out;
-	}
-
-	SetPageUptodate(page);
-	swap_slot_free_notify(page);
-out:
-	unlock_page(page);
-	WRITE_ONCE(bio->bi_private, NULL);
-	bio_put(bio);
-	if (waiter) {
-		blk_wake_io_task(waiter);
-		put_task_struct(waiter);
-	}
-}
-
 int generic_swapfile_activate(struct swap_info_struct *sis,
 				struct file *swap_file,
 				sector_t *span)
@@ -281,31 +231,12 @@ static inline void count_swpout_vm_event(struct page *page)
 	count_vm_events(PSWPOUT, thp_nr_pages(page));
 }
 
-#if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
-{
-	struct cgroup_subsys_state *css;
-	struct mem_cgroup *memcg;
-
-	memcg = page_memcg(page);
-	if (!memcg)
-		return;
-
-	rcu_read_lock();
-	css = cgroup_e_css(memcg->css.cgroup, &io_cgrp_subsys);
-	bio_associate_blkg_from_css(bio, css);
-	rcu_read_unlock();
-}
-#else
-#define bio_associate_blkg_from_page(bio, page)		do { } while (0)
-#endif /* CONFIG_MEMCG && CONFIG_BLK_CGROUP */
-
 static void __swapfile_write_complete(struct kiocb *iocb, long ret, long ret2)
 {
 	struct page *page = iocb->ki_swap_page;
 
 	if (ret == thp_size(page)) {
-		count_vm_event(PSWPOUT);
+		count_swpout_vm_event(page);
 		ret = 0;
 	} else {
 		/*
@@ -401,34 +332,10 @@ static int swapfile_write(struct swap_info_struct *sis,
 
 int __swap_writepage(struct page *page, struct writeback_control *wbc)
 {
-	struct bio *bio;
-	int ret;
 	struct swap_info_struct *sis = page_swap_info(page);
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page), page);
-	if (data_race(sis->flags & SWP_FS_OPS))
-		return swapfile_write(sis, page, wbc);
-
-	ret = bdev_write_page(sis->bdev, swap_page_sector(page), page, wbc);
-	if (!ret) {
-		count_swpout_vm_event(page);
-		return 0;
-	}
-
-	bio = bio_alloc(GFP_NOIO, 1);
-	bio_set_dev(bio, sis->bdev);
-	bio->bi_iter.bi_sector = swap_page_sector(page);
-	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
-	bio->bi_end_io = end_swap_bio_write;
-	bio_add_page(bio, page, thp_size(page), 0);
-
-	bio_associate_blkg_from_page(bio, page);
-	count_swpout_vm_event(page);
-	set_page_writeback(page);
-	unlock_page(page);
-	submit_bio(bio);
-
-	return 0;
+	return swapfile_write(sis, page, wbc);
 }
 
 static void __swapfile_read_complete(struct kiocb *iocb, long ret, long ret2)
@@ -437,6 +344,7 @@ static void __swapfile_read_complete(struct kiocb *iocb, long ret, long ret2)
 
 	if (ret == PAGE_SIZE) {
 		count_vm_event(PSWPIN);
+		swap_slot_free_notify(page);
 		SetPageUptodate(page);
 	} else {
 		SetPageError(page);
@@ -522,12 +430,9 @@ static int swapfile_read(struct swap_info_struct *sis, struct page *page,
 
 int swap_readpage(struct page *page, bool synchronous)
 {
-	struct bio *bio;
-	int ret = 0;
 	struct swap_info_struct *sis = page_swap_info(page);
-	blk_qc_t qc;
-	struct gendisk *disk;
 	unsigned long pflags;
+	int ret = 0;
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -543,60 +448,9 @@ int swap_readpage(struct page *page, bool synchronous)
 	if (frontswap_load(page) == 0) {
 		SetPageUptodate(page);
 		unlock_page(page);
-		goto out;
-	}
-
-	if (data_race(sis->flags & SWP_FS_OPS)) {
+	} else {
 		ret = swapfile_read(sis, page, synchronous);
-		goto out;
-	}
-
-	if (sis->flags & SWP_SYNCHRONOUS_IO) {
-		ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
-		if (!ret) {
-			if (trylock_page(page)) {
-				swap_slot_free_notify(page);
-				unlock_page(page);
-			}
-
-			count_vm_event(PSWPIN);
-			goto out;
-		}
 	}
-
-	ret = 0;
-	bio = bio_alloc(GFP_KERNEL, 1);
-	bio_set_dev(bio, sis->bdev);
-	bio->bi_opf = REQ_OP_READ;
-	bio->bi_iter.bi_sector = swap_page_sector(page);
-	bio->bi_end_io = end_swap_bio_read;
-	bio_add_page(bio, page, thp_size(page), 0);
-
-	disk = bio->bi_bdev->bd_disk;
-	/*
-	 * Keep this task valid during swap readpage because the oom killer may
-	 * attempt to access it in the page fault retry time check.
-	 */
-	if (synchronous) {
-		bio->bi_opf |= REQ_HIPRI;
-		get_task_struct(current);
-		bio->bi_private = current;
-	}
-	count_vm_event(PSWPIN);
-	bio_get(bio);
-	qc = submit_bio(bio);
-	while (synchronous) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (!READ_ONCE(bio->bi_private))
-			break;
-
-		if (!blk_poll(disk->queue, qc, true))
-			blk_io_schedule();
-	}
-	__set_current_state(TASK_RUNNING);
-	bio_put(bio);
-
-out:
 	psi_memstall_leave(&pflags);
 	return ret;
 }


