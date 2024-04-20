Return-Path: <linux-fsdevel+bounces-17327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1418AB8E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EAD31C20AC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E93DF42;
	Sat, 20 Apr 2024 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ak6RqJnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013BB79DE;
	Sat, 20 Apr 2024 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581452; cv=none; b=iEVA8vX+9YPtL62iL2SxzQxWyMzrSEmU4E3Q6SCuFGVeOaer7Ck0FdKbiSaW3OrnhqY20bu7mW9uojItO+VL8Ly52TpwPelFBtK1+kyl84/AYm/OBqEszaUdc0IK+mUdBm34g61qdIp6JJtg4FTM+qXDw+i4huI0gOTzFT4M3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581452; c=relaxed/simple;
	bh=6zw/DGvX4iHTZ43cuv+HPFmSiAYP11zruXeXS7YT3iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzUjBdMK2w4rfzSp0mN6QPn8IHubbVvN2BdLAyYXK8N+pIMTC1kpNyGIy9B4/gT7h9EKxL+0CW4pbkDHxqPN1X/ITb1UbJx+QpqOWwP+RJM9vTLFpMQpAa8wvOClj/azneI/a7iFUUKXKiDVVvmFqtAXkBPoIzTzpRilK2bmUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ak6RqJnJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Vh4ZxQBjoUokzSVjhM/l0v5XocbZMAs1eA/cyY2hHz0=; b=Ak6RqJnJQQHWPqZpHoQ1DxDOUr
	Q6/R23PF1ihBxpXV3LuUv+9ZSHofjhpRVIrf+WnR2YgFTWEowcrSrSfF20LJpsbgPemebKnnEtdo2
	jQAF+tIoRGDM20Yoz01wlKT18Uf8IuOvLi923WExLrCwGFkWZCauv5F0r/YoFq+LdG+cNAhMcsa76
	tz2RyRyp0VDBH4fa0e4ddPlRAoA3Z2BbJjWhIQYjrmJ9fy/W2a3eaVDfwGF//Or/wmiI83j3jouEc
	FE+AxERqneyA3uSL3tcTDE7khfftIhQWl9BSe3cmP0ATqgWm+jStusaP3pKSoNN5+HO0i9fxF1tlq
	L6vHAwYw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oP-000000095e9-46IS;
	Sat, 20 Apr 2024 02:50:46 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 04/30] btrfs: Remove use of the folio error flag
Date: Sat, 20 Apr 2024 03:49:59 +0100
Message-ID: <20240420025029.2166544-5-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Count the number of superblock writeback errors in the btrfs_device.
That means we don't need the folio to stay around until it's waited for,
and can avoid the extra call to folio_get/put.

Also remove a mention of PageError in a comment.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/disk-io.c   | 44 ++++++++++++++++++--------------------------
 fs/btrfs/extent_io.c |  2 +-
 fs/btrfs/volumes.h   |  5 +++++
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 18c47bf3f383..3fa073f969d8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3635,11 +3635,15 @@ static void btrfs_end_super_write(struct bio *bio)
 				"lost sb write due to IO error on %s (%d)",
 				btrfs_dev_name(device),
 				blk_status_to_errno(bio->bi_status));
-			folio_set_error(fi.folio);
 			btrfs_dev_stat_inc_and_print(device,
 						     BTRFS_DEV_STAT_WRITE_ERRS);
+			/* Ensure failure if a primary sb fails */
+			if (bio->bi_opf & REQ_FUA)
+				atomic_set(&device->sb_wb_errors,
+						BTRFS_DEV_PRIMARY_ERROR);
+			else
+				atomic_inc(&device->sb_wb_errors);
 		}
-
 		folio_unlock(fi.folio);
 		folio_put(fi.folio);
 	}
@@ -3743,10 +3747,11 @@ static int write_dev_supers(struct btrfs_device *device,
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
 
@@ -3766,7 +3771,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			btrfs_err(device->fs_info,
 				"couldn't get super block location for mirror %d",
 				i);
-			errors++;
+			atomic_inc(&device->sb_wb_errors);
 			continue;
 		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
@@ -3785,13 +3790,10 @@ static int write_dev_supers(struct btrfs_device *device,
 			btrfs_err(device->fs_info,
 			    "couldn't get super block page for bytenr %llu",
 			    bytenr);
-			errors++;
+			atomic_inc(&device->sb_wb_errors);
 			continue;
 		}
 
-		/* Bump the refcount for wait_dev_supers() */
-		folio_get(folio);
-
 		offset = offset_in_folio(folio, bytenr);
 		disk_super = folio_address(folio) + offset;
 		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
@@ -3819,9 +3821,9 @@ static int write_dev_supers(struct btrfs_device *device,
 		submit_bio(bio);
 
 		if (btrfs_advance_sb_log(device, i))
-			errors++;
+			atomic_inc(&device->sb_wb_errors);
 	}
-	return errors < i ? 0 : -1;
+	return atomic_read(&device->sb_wb_errors) < i ? 0 : -1;
 }
 
 /*
@@ -3860,27 +3862,17 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 
 		folio = filemap_get_folio(device->bdev->bd_mapping,
 				     bytenr >> PAGE_SHIFT);
-		if (IS_ERR(folio)) {
-			errors++;
-			if (i == 0)
-				primary_failed = true;
+		/* If the folio has been removed, then we know it completed */
+		if (IS_ERR(folio))
 			continue;
-		}
-		/* Folio is unlocked once the write completes */
+		/* Folio is unlocked once the IO completes */
 		folio_wait_locked(folio);
-		if (folio_test_error(folio)) {
-			errors++;
-			if (i == 0)
-				primary_failed = true;
-		}
-
-		/* Drop our reference */
-		folio_put(folio);
-
-		/* Drop the reference from the writing run */
 		folio_put(folio);
 	}
 
+	errors += atomic_read(&device->sb_wb_errors);
+	if (errors >= BTRFS_DEV_PRIMARY_ERROR)
+		primary_failed = true;
 	/* log error, force error return */
 	if (primary_failed) {
 		btrfs_err(device->fs_info, "error writing primary super block to device %llu",
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7b10f47d8f83..7a1bd23833e5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1602,7 +1602,7 @@ static void set_btree_ioerr(struct extent_buffer *eb)
 	 * can be no longer dirty nor marked anymore for writeback (if a
 	 * subsequent modification to the extent buffer didn't happen before the
 	 * transaction commit), which makes filemap_fdata[write|wait]_range not
-	 * able to find the pages tagged with SetPageError at transaction
+	 * able to find the pages which contain errors at transaction
 	 * commit time. So if this happens we must abort the transaction,
 	 * otherwise we commit a super block with btree roots that point to
 	 * btree nodes/leafs whose content on disk is invalid - either garbage
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index cf555f5b47ce..cdab144410a8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -92,6 +92,9 @@ enum btrfs_raid_types {
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 #define BTRFS_DEV_STATE_NO_READA	(5)
 
+/* We'll never have this many superblocks */
+#define BTRFS_DEV_PRIMARY_ERROR		(INT_MAX / 2)
+
 struct btrfs_fs_devices;
 
 struct btrfs_device {
@@ -142,6 +145,8 @@ struct btrfs_device {
 	/* type and info about this device */
 	u64 type;
 
+	atomic_t sb_wb_errors;
+
 	/* minimal io size for this device */
 	u32 sector_size;
 
-- 
2.43.0


