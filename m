Return-Path: <linux-fsdevel+bounces-17256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF8D8AA14D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7415AB22C28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 17:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755CD176FA3;
	Thu, 18 Apr 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="on+dhqRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE252175560;
	Thu, 18 Apr 2024 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462112; cv=none; b=MyAY+1kI9wFjlehZkyRyQioRIiEzsNJcjCj8rlsfHVw7eN2uPukDCK8GwBgr40SwyFHB4ACpwyJX5q21Ic5daE57LXO3wwLMmrhbE8PFX9QitHHPvxff0rho9ptlGw77PpcBpbmVW0evAMRF/A0zo9MdofHwnqKUpuANT+u8jSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462112; c=relaxed/simple;
	bh=a56H1H0ocSgA6Ov6sBnKeH1Cg0NGzgMjsDnPzQAH73Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZJIc3q0Af62/tKR8qcpUbTGMk90d4D00cLNiA7jl44wuV9o+h9GinxtoNy0mUdvRZwLNQvj/P7Ub6rdDpvwx64CMgJHtm8Z/9cL90AhWrbYjLIbAWdMzRUXDNKR32J21OgeVl4mpl2XqxsnE2bRISrzhI92WwZRNzTxjosgXiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=on+dhqRM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=jJoegfPXw11l2P7nb+pCz0D5fh1nfGJoimNQIsS8gsE=; b=on+dhqRMFO8dFwi4r/i1nOiz+2
	3fGUf4bFYJmnvvHerSQN9Ey0vO/Qh0VL1Ju7ftW4KUjbqtz0NNg1SAUDEHCB1drM7Z7mJxzjZmCcV
	9WsMIDoH+4ypcigau0gmkiMpKybQXxlL2UmFnsUUBII+YdcuQwItXOS81unNRWYg3+IAWYTj2vNdd
	hWB2pfMZWnVaS4PEgT2wJF2/ytuW73nUAQjQ3a3XwOQD+ZIroOOUi4qExClRjOw+yw5KK1TMI0nUx
	C2fHi/4aJt4jbgbzdXdJwigsfTokMyzlHqrxFd7Et/2Z7J4UvXPYAs97AMpwE9tEqsNs7MbI9GKdP
	Ye8b0OPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxVlc-00000005pZx-08jd;
	Thu, 18 Apr 2024 17:41:48 +0000
Date: Thu, 18 Apr 2024 18:41:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Removing PG_error use from btrfs
Message-ID: <ZiFbWx6o-hQ38QyZ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We're down to just JFS and btrfs using the PG_error flag.  I sent a
patch earlier to remove PG_error from JFS, so now it's your turn ...

btrfs currently uses it to indicate superblock writeback errors.
This proposal moves that information to a counter in the btrfs_device.
Maybe this isn't the best approach.  What do you think?

I'm currently running fstests against it and it hasn't blown up yet.

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3d512b041977..5f6f8472ecec 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3627,28 +3627,24 @@ ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 static void btrfs_end_super_write(struct bio *bio)
 {
 	struct btrfs_device *device = bio->bi_private;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-	struct page *page;
-
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		page = bvec->bv_page;
+	struct folio_iter fi;
 
+	bio_for_each_folio_all(fi, bio) {
 		if (bio->bi_status) {
 			btrfs_warn_rl_in_rcu(device->fs_info,
-				"lost page write due to IO error on %s (%d)",
+				"lost sb write due to IO error on %s (%d)",
 				btrfs_dev_name(device),
 				blk_status_to_errno(bio->bi_status));
-			ClearPageUptodate(page);
-			SetPageError(page);
 			btrfs_dev_stat_inc_and_print(device,
 						     BTRFS_DEV_STAT_WRITE_ERRS);
-		} else {
-			SetPageUptodate(page);
+			/* Ensure failure if a primary sb fails */
+			if (bio->bi_opf & REQ_FUA)
+				atomic_set(&device->sb_wb_errors, INT_MAX / 2);
+			else
+				atomic_inc(&device->sb_wb_errors);
 		}
-
-		put_page(page);
-		unlock_page(page);
+		folio_unlock(fi.folio);
+		folio_put(fi.folio);
 	}
 
 	bio_put(bio);
@@ -3750,19 +3746,21 @@ static int write_dev_supers(struct btrfs_device *device,
 	struct address_space *mapping = device->bdev->bd_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
-	int errors = 0;
 	int ret;
 	u64 bytenr, bytenr_orig;
 
+	atomic_set(&device->sb_wb_errors, 0);
+
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
 	shash->tfm = fs_info->csum_shash;
 
 	for (i = 0; i < max_mirrors; i++) {
-		struct page *page;
+		struct folio *folio;
 		struct bio *bio;
 		struct btrfs_super_block *disk_super;
+		size_t offset;
 
 		bytenr_orig = btrfs_sb_offset(i);
 		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
@@ -3772,7 +3770,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			btrfs_err(device->fs_info,
 				"couldn't get super block location for mirror %d",
 				i);
-			errors++;
+			atomic_inc(&device->sb_wb_errors);
 			continue;
 		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
@@ -3785,20 +3783,18 @@ static int write_dev_supers(struct btrfs_device *device,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
 				    sb->csum);
 
-		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
-					   GFP_NOFS);
-		if (!page) {
+		folio = __filemap_get_folio(mapping, bytenr >> PAGE_SHIFT,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_NOFS);
+		if (IS_ERR(folio)) {
 			btrfs_err(device->fs_info,
 			    "couldn't get super block page for bytenr %llu",
 			    bytenr);
-			errors++;
+			atomic_inc(&device->sb_wb_errors);
 			continue;
 		}
 
-		/* Bump the refcount for wait_dev_supers() */
-		get_page(page);
-
-		disk_super = page_address(page);
+		offset = offset_in_folio(folio, bytenr);
+		disk_super = folio_address(folio) + offset;
 		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
 
 		/*
@@ -3812,8 +3808,7 @@ static int write_dev_supers(struct btrfs_device *device,
 		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
 		bio->bi_private = device;
 		bio->bi_end_io = btrfs_end_super_write;
-		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
-			       offset_in_page(bytenr));
+		bio_add_folio_nofail(bio, folio, BTRFS_SUPER_INFO_SIZE, offset);
 
 		/*
 		 * We FUA only the first super block.  The others we allow to
@@ -3825,9 +3820,9 @@ static int write_dev_supers(struct btrfs_device *device,
 		submit_bio(bio);
 
 		if (btrfs_advance_sb_log(device, i))
-			errors++;
+			atomic_inc(&device->sb_wb_errors);
 	}
-	return errors < i ? 0 : -1;
+	return atomic_read(&device->sb_wb_errors) < i ? 0 : -1;
 }
 
 /*
@@ -3849,7 +3844,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
 	for (i = 0; i < max_mirrors; i++) {
-		struct page *page;
+		struct folio *folio;
 
 		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
 		if (ret == -ENOENT) {
@@ -3864,29 +3859,19 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(device->bdev->bd_mapping,
+		folio = filemap_get_folio(device->bdev->bd_mapping,
 				     bytenr >> PAGE_SHIFT);
-		if (!page) {
-			errors++;
-			if (i == 0)
-				primary_failed = true;
+		/* If the folio has been removed, then we know it completed */
+		if (IS_ERR(folio))
 			continue;
-		}
-		/* Page is submitted locked and unlocked once the IO completes */
-		wait_on_page_locked(page);
-		if (PageError(page)) {
-			errors++;
-			if (i == 0)
-				primary_failed = true;
-		}
-
-		/* Drop our reference */
-		put_page(page);
-
-		/* Drop the reference from the writing run */
-		put_page(page);
+		/* Folio is unlocked once the IO completes */
+		folio_wait_locked(folio);
+		folio_put(folio);
 	}
 
+	errors += atomic_read(&device->sb_wb_errors);
+	if (errors >= INT_MAX / 2)
+		primary_failed = true;
 	/* log error, force error return */
 	if (primary_failed) {
 		btrfs_err(device->fs_info, "error writing primary super block to device %llu",
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index cf555f5b47ce..44c639720426 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -142,6 +142,8 @@ struct btrfs_device {
 	/* type and info about this device */
 	u64 type;
 
+	atomic_t sb_wb_errors;
+
 	/* minimal io size for this device */
 	u32 sector_size;
 


