Return-Path: <linux-fsdevel+bounces-46974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF75A96EE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBCD169681
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A5C29290B;
	Tue, 22 Apr 2025 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SuONZuli"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4EA28C5B5;
	Tue, 22 Apr 2025 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745332061; cv=none; b=YoiKCnkPtUdwsdOmzqaeicNPc5Nc1l9cwwGGnoxRVtK5gs58oRAicJ/PpVwF4BBaN8uWjzkEMZrdC2cp/M/kybhMEmMZ7e+9pnwtPuqveJWAJk6tgexvouD7ZQMgKdUS/J9bSzVzp6tzmRsbaFlL48q8g5UMGnA8mIb2MmoSjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745332061; c=relaxed/simple;
	bh=/x7yHTAfZ2JSJemKXFB//zL5sTvXcfFtBmXaYs0Eo7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiYbC3dod3+m7bkSSvDX7dxdMAPDA8/A2yMahKR8yAyjetePyqwdLr2mWimCsgcHGDN74fafyRQEHBmySXJlQLmUdPX180iF6L95uwr7+WRMhgLQepjDm8ig+owA56uL9K8lh+Ubaen2jDPMDKQum/1Pt/xM8HYns/deZ8CTmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SuONZuli; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+YHndYMNq7ZxkCQAHVag1D3GGjvtDKwyrsKOxDECvi0=; b=SuONZulizFFfKXDOe2Vu2HK3pI
	I35we6L+Jy8G0dDfnM3oiAQogg/yjUJL8dGbyH3G+JdrFv7GAM2S0qV6420/UhOpfE3EZMe0i2KbB
	cA1ehOrGRzLgWP5Dtu6A9cuppIzj06ksUbSlzhNuMK3vObD4zh7IxKpt8xwI7lQj3bZ2Fl/8PEeYh
	zt1ECBI3oWtuceJ+pP8BKrHIX8OhtYitwHDE/pHi8e9c1g4GqdR5R/gTq7MratJfnC2nXXi1a8b+i
	Tc5ip1teSUvWgASsQbk23gnfDazJny1ysfk+VLfSwEVquVosdjKlhayQEMQmxDBTQSuS2ENR/d0Wt
	3ut0w0pQ==;
Received: from [2001:4bb8:2fc:38c3:78fb:84a5:c78c:68b6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Eb4-00000007UTe-1Sy1;
	Tue, 22 Apr 2025 14:27:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 17/17] PM: hibernate: split and simplify hib_submit_io
Date: Tue, 22 Apr 2025 16:26:18 +0200
Message-ID: <20250422142628.1553523-18-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250422142628.1553523-1-hch@lst.de>
References: <20250422142628.1553523-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split hib_submit_io into a sync and async version.  The sync version is
a small wrapper around bdev_rw_virt which implements all the logic to
add a kernel direct mapping range to a bio and synchronously submits it,
while the async version is slightly simplified using the
bio_add_virt_nofail for adding the single range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/power/swap.c | 103 +++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 58 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 80ff5f933a62..ad13c461b657 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -268,35 +268,26 @@ static void hib_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,
+static int hib_submit_io_sync(blk_opf_t opf, pgoff_t page_off, void *addr)
+{
+	return bdev_rw_virt(file_bdev(hib_resume_bdev_file),
+			page_off * (PAGE_SIZE >> 9), addr, PAGE_SIZE, opf);
+}
+
+static int hib_submit_io_async(blk_opf_t opf, pgoff_t page_off, void *addr,
 			 struct hib_bio_batch *hb)
 {
-	struct page *page = virt_to_page(addr);
 	struct bio *bio;
-	int error = 0;
 
 	bio = bio_alloc(file_bdev(hib_resume_bdev_file), 1, opf,
 			GFP_NOIO | __GFP_HIGH);
 	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
-
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
-		pr_err("Adding page to bio failed at %llu\n",
-		       (unsigned long long)bio->bi_iter.bi_sector);
-		bio_put(bio);
-		return -EFAULT;
-	}
-
-	if (hb) {
-		bio->bi_end_io = hib_end_io;
-		bio->bi_private = hb;
-		atomic_inc(&hb->count);
-		submit_bio(bio);
-	} else {
-		error = submit_bio_wait(bio);
-		bio_put(bio);
-	}
-
-	return error;
+	bio_add_virt_nofail(bio, addr, PAGE_SIZE);
+	bio->bi_end_io = hib_end_io;
+	bio->bi_private = hb;
+	atomic_inc(&hb->count);
+	submit_bio(bio);
+	return 0;
 }
 
 static int hib_wait_io(struct hib_bio_batch *hb)
@@ -316,7 +307,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 {
 	int error;
 
-	hib_submit_io(REQ_OP_READ, swsusp_resume_block, swsusp_header, NULL);
+	hib_submit_io_sync(REQ_OP_READ, swsusp_resume_block, swsusp_header);
 	if (!memcmp("SWAP-SPACE",swsusp_header->sig, 10) ||
 	    !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {
 		memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
@@ -329,8 +320,8 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 		swsusp_header->flags = flags;
 		if (flags & SF_CRC32_MODE)
 			swsusp_header->crc32 = handle->crc32;
-		error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
-				      swsusp_resume_block, swsusp_header, NULL);
+		error = hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC,
+				      swsusp_resume_block, swsusp_header);
 	} else {
 		pr_err("Swap header not found!\n");
 		error = -ENODEV;
@@ -380,36 +371,30 @@ static int swsusp_swap_check(void)
 
 static int write_page(void *buf, sector_t offset, struct hib_bio_batch *hb)
 {
+	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
 	void *src;
 	int ret;
 
 	if (!offset)
 		return -ENOSPC;
 
-	if (hb) {
-		src = (void *)__get_free_page(GFP_NOIO | __GFP_NOWARN |
-		                              __GFP_NORETRY);
-		if (src) {
-			copy_page(src, buf);
-		} else {
-			ret = hib_wait_io(hb); /* Free pages */
-			if (ret)
-				return ret;
-			src = (void *)__get_free_page(GFP_NOIO |
-			                              __GFP_NOWARN |
-			                              __GFP_NORETRY);
-			if (src) {
-				copy_page(src, buf);
-			} else {
-				WARN_ON_ONCE(1);
-				hb = NULL;	/* Go synchronous */
-				src = buf;
-			}
-		}
-	} else {
-		src = buf;
+	if (!hb)
+		goto sync_io;
+
+	src = (void *)__get_free_page(gfp);
+	if (!src) {
+		ret = hib_wait_io(hb); /* Free pages */
+		if (ret)
+			return ret;
+		src = (void *)__get_free_page(gfp);
+		if (WARN_ON_ONCE(!src))
+			goto sync_io;
 	}
-	return hib_submit_io(REQ_OP_WRITE | REQ_SYNC, offset, src, hb);
+
+	copy_page(src, buf);
+	return hib_submit_io_async(REQ_OP_WRITE | REQ_SYNC, offset, src, hb);
+sync_io:
+	return hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC, offset, buf);
 }
 
 static void release_swap_writer(struct swap_map_handle *handle)
@@ -1041,7 +1026,7 @@ static int get_swap_reader(struct swap_map_handle *handle,
 			return -ENOMEM;
 		}
 
-		error = hib_submit_io(REQ_OP_READ, offset, tmp->map, NULL);
+		error = hib_submit_io_sync(REQ_OP_READ, offset, tmp->map);
 		if (error) {
 			release_swap_reader(handle);
 			return error;
@@ -1065,7 +1050,10 @@ static int swap_read_page(struct swap_map_handle *handle, void *buf,
 	offset = handle->cur->entries[handle->k];
 	if (!offset)
 		return -EFAULT;
-	error = hib_submit_io(REQ_OP_READ, offset, buf, hb);
+	if (hb)
+		error = hib_submit_io_async(REQ_OP_READ, offset, buf, hb);
+	else
+		error = hib_submit_io_sync(REQ_OP_READ, offset, buf);
 	if (error)
 		return error;
 	if (++handle->k >= MAP_PAGE_ENTRIES) {
@@ -1590,8 +1578,8 @@ int swsusp_check(bool exclusive)
 				BLK_OPEN_READ, holder, NULL);
 	if (!IS_ERR(hib_resume_bdev_file)) {
 		clear_page(swsusp_header);
-		error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
-					swsusp_header, NULL);
+		error = hib_submit_io_sync(REQ_OP_READ, swsusp_resume_block,
+					swsusp_header);
 		if (error)
 			goto put;
 
@@ -1599,9 +1587,9 @@ int swsusp_check(bool exclusive)
 			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
 			swsusp_header_flags = swsusp_header->flags;
 			/* Reset swap signature now */
-			error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
+			error = hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC,
 						swsusp_resume_block,
-						swsusp_header, NULL);
+						swsusp_header);
 		} else {
 			error = -EINVAL;
 		}
@@ -1650,13 +1638,12 @@ int swsusp_unmark(void)
 {
 	int error;
 
-	hib_submit_io(REQ_OP_READ, swsusp_resume_block,
-			swsusp_header, NULL);
+	hib_submit_io_sync(REQ_OP_READ, swsusp_resume_block, swsusp_header);
 	if (!memcmp(HIBERNATE_SIG,swsusp_header->sig, 10)) {
 		memcpy(swsusp_header->sig,swsusp_header->orig_sig, 10);
-		error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
+		error = hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC,
 					swsusp_resume_block,
-					swsusp_header, NULL);
+					swsusp_header);
 	} else {
 		pr_err("Cannot find swsusp signature!\n");
 		error = -ENODEV;
-- 
2.47.2


