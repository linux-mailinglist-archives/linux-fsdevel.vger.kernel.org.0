Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739194179C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbhIXRWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347864AbhIXRVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632503972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Arocsm2H++jgTSxW2Ds/xKG2F2CIUBb6boQqvt8idwM=;
        b=RgWxWpZDiCLFEVRUoWcgfX6X7mPuRHf/A4zJ2CbptAjM6XnK5ltu8nL8rX56dxfQhmHHuO
        6PbQbPTvhYQrZ5eYRImW74flWV4XYxWW66Z7VFtJqWbaQ50g4svt0wmjuaOFm6ce5cV6xn
        kk7QH1pLbOMvFOyQw6Y3XHHCMcGoDH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-TYnDqK9rMcyp5PU33PijFw-1; Fri, 24 Sep 2021 13:19:28 -0400
X-MC-Unique: TYnDqK9rMcyp5PU33PijFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 106EC5075D;
        Fri, 24 Sep 2021 17:19:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0991260BF1;
        Fri, 24 Sep 2021 17:19:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 9/9] mm: Remove swap BIO paths and only use DIO paths
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
Date:   Fri, 24 Sep 2021 18:19:23 +0100
Message-ID: <163250396319.2330363.10564506508011638258.stgit@warthog.procyon.org.uk>
In-Reply-To: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Delete the BIO-generating swap read/write paths and always use ->swap_rw().
This puts the mapping layer in the filesystem.

[!] ALSO: Add a compile-time knob to disable swap by asynchronous DIO, only
    using synchronous DIO.  Async DIO doesn't seem to work, with ATA errors
    being chucked out by the swap-on-blockdev and swapfile-on-XFS.  It also
    misbehaves on NFS.

I have tested this with sync DIO on ext4-swapfile, xfs-swapfile, a raw
blockdev and NFS.  The first three work; NFS works for a while then grinds to
a halt, chucking out lists of blocked sunrpc operations (I suspect it can't
allocate memory somewhere).

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

 mm/page_io.c  |  156 +++------------------------------------------------------
 mm/swapfile.c |    4 +
 2 files changed, 10 insertions(+), 150 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 8f1199d59162..b48318951380 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -26,6 +26,8 @@
 #include <linux/uio.h>
 #include <linux/sched/task.h>
 
+#define ONLY_USE_SYNC_DIO 1
+
 /*
  * Keep track of the kiocb we're using to do async DIO.  We have to
  * refcount it until various things stop looking at the kiocb *after*
@@ -42,30 +44,6 @@ static void swapfile_put_kiocb(struct swapfile_kiocb *ki)
 		kfree(ki);
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
-		 * Also clear PG_reclaim to avoid rotate_reclaimable_page()
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
@@ -114,32 +92,6 @@ static void swap_slot_free_notify(struct page *page)
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
@@ -279,25 +231,6 @@ static inline void count_swpout_vm_event(struct page *page)
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
 static void swapfile_write_complete(struct page *page, long ret)
 {
 	if (ret == thp_size(page)) {
@@ -364,7 +297,7 @@ static int swapfile_write(struct swap_info_struct *sis,
 
 	iov_iter_bvec(&from, WRITE, &bv, 1, PAGE_SIZE);
 
-	if (wbc->sync_mode == WB_SYNC_ALL)
+	if (ONLY_USE_SYNC_DIO || wbc->sync_mode == WB_SYNC_ALL)
 		return swapfile_write_sync(sis, page, wbc, &from);
 
 	ki = kzalloc(sizeof(*ki), GFP_KERNEL);
@@ -390,40 +323,17 @@ static int swapfile_write(struct swap_info_struct *sis,
 
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
 
 static void swapfile_read_complete(struct page *page, long ret)
 {
 	if (ret == page_size(page)) {
 		count_vm_event(PSWPIN);
+		swap_slot_free_notify(page);
 		SetPageUptodate(page);
 	} else {
 		SetPageError(page);
@@ -473,7 +383,7 @@ static void swapfile_read(struct swap_info_struct *sis, struct page *page,
 
 	iov_iter_bvec(&to, READ, &bv, 1, thp_size(page));
 
-	if (synchronous)
+	if (ONLY_USE_SYNC_DIO || synchronous)
 		return swapfile_read_sync(sis, page, &to);
 
 	ki = kzalloc(sizeof(*ki), GFP_KERNEL);
@@ -495,10 +405,7 @@ static void swapfile_read(struct swap_info_struct *sis, struct page *page,
 
 void swap_readpage(struct page *page, bool synchronous)
 {
-	struct bio *bio;
 	struct swap_info_struct *sis = page_swap_info(page);
-	blk_qc_t qc;
-	struct gendisk *disk;
 	unsigned long pflags;
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
@@ -515,58 +422,9 @@ void swap_readpage(struct page *page, bool synchronous)
 	if (frontswap_load(page) == 0) {
 		SetPageUptodate(page);
 		unlock_page(page);
-		goto out;
-	}
-
-	if (data_race(sis->flags & SWP_FS_OPS)) {
+	} else {
 		swapfile_read(sis, page, synchronous);
-		goto out;
 	}
-
-	if (sis->flags & SWP_SYNCHRONOUS_IO) {
-		if (!bdev_read_page(sis->bdev, swap_page_sector(page), page)) {
-			if (trylock_page(page)) {
-				swap_slot_free_notify(page);
-				unlock_page(page);
-			}
-
-			count_vm_event(PSWPIN);
-			goto out;
-		}
-	}
-
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
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 22d10f713848..95d2571e3727 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2918,6 +2918,8 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 			return -EINVAL;
 		p->flags |= SWP_BLKDEV;
 	} else if (S_ISREG(inode->i_mode)) {
+		if (!inode->i_mapping->a_ops->swap_rw)
+			return -EINVAL;
 		p->bdev = inode->i_sb->s_bdev;
 	}
 
@@ -3165,7 +3167,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		name = NULL;
 		goto bad_swap;
 	}
-	swap_file = file_open_name(name, O_RDWR|O_LARGEFILE, 0);
+	swap_file = file_open_name(name, O_RDWR | O_LARGEFILE | O_DIRECT, 0);
 	if (IS_ERR(swap_file)) {
 		error = PTR_ERR(swap_file);
 		swap_file = NULL;


