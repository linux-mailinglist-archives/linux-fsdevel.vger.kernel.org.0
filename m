Return-Path: <linux-fsdevel+bounces-73106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD12D0CE44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C79230392BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 03:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33768243387;
	Sat, 10 Jan 2026 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V6SzP+af";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V6SzP+af"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413E2AEE1
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017410; cv=none; b=EehwY3MQCRBN6r4a7edhgOFwiKQPn/Rj8bx+lbYAv0KoQv0G2AhanCckJFk6mcRQNL837ItuzaXwMJa6zCI+NSH+N5wO8WJ6qJPiScu/DOHG85N5wgE875vtGeTMaWQ5yMwHQHj09Yx6izWouTKEAXNQW5BQetrPeFtL/O7bnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017410; c=relaxed/simple;
	bh=tsYW5q1H+w/BPykPySjLoBxKsZ/QRZLxl6mZRsGShkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUKI9B70IA2L98EZkd9kPzeyYJGCh8J9YZtKhfGf3CkmKvEXChqIqmUfoLod4XwXyabCejbKSDPfeKl6dgsV1hs/14uo8JD5bhUbB6kyTvmIW5cb4Whdl3WUitLnrP2Tc+txqVT5wtwWtKl9sIQXskGmsiyCQMUTodnfo/fwMMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V6SzP+af; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V6SzP+af; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 080145BCF3;
	Sat, 10 Jan 2026 03:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768017403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zA1qgtm4aA7baso3OZkf3sKtAKB0Bycvv+SiYEFeRkU=;
	b=V6SzP+affpmVFANhTenbqpJTMYcE0cXGBF5hPR56UgKFy67II+DG1iVjnxFDWtSIhV/iiG
	aS1GpUxx9fs/P92Gu/ObZANZr6ZAUTDNqkroiByWr3YTxLhDYsLJ7WTcr97a2lIcL4mOfG
	TX+pGuxNgc4go2LnV9mU3ztx5j4nEo4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=V6SzP+af
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768017403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zA1qgtm4aA7baso3OZkf3sKtAKB0Bycvv+SiYEFeRkU=;
	b=V6SzP+affpmVFANhTenbqpJTMYcE0cXGBF5hPR56UgKFy67II+DG1iVjnxFDWtSIhV/iiG
	aS1GpUxx9fs/P92Gu/ObZANZr6ZAUTDNqkroiByWr3YTxLhDYsLJ7WTcr97a2lIcL4mOfG
	TX+pGuxNgc4go2LnV9mU3ztx5j4nEo4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48CD73EA63;
	Sat, 10 Jan 2026 03:56:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aOU7A/nNYWlqLgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 10 Jan 2026 03:56:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/3] btrfs: use bdev_rw_virt() to read and scratch the disk super block
Date: Sat, 10 Jan 2026 14:26:19 +1030
Message-ID: <829db7e054cd290b5aed0b337cd219da128ac0e7.1768017091.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768017091.git.wqu@suse.com>
References: <cover.1768017091.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 080145BCF3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Currently we're using the block device page cache to read and scratch
the super block.

But that means we're reading the whole folio to grab just the super
block, this can be unnecessary especially nowadays bdev's page cache
supports large folio, not to mention systems with page size larger than
4K.

Furthermore read_cache_page*() can race with device block size setting,
thus requires extra locking.

Modify the following routines by:

- Use kmalloc() + bdev_rw_virt() for btrfs_read_disk_super()
  This means we can easily replace btrfs_release_disk_super() with a
  simple kfree().

  This also means there will no longer be any cached read for
  btrfs_read_disk_super(), thus we can drop the @drop_cache parameter.

  However this change brings a slightly behavior change for
  btrfs_scan_one_device(), now every time the device is scanned, btrfs
  will submit a read request, no more cached scan.

- Use bdev_rw_virt() for btrfs_scratch_superblock()
  Just use the memory returned by btrfs_read_disk_super() and reset the
  magic number.
  Then use bdev_rw_virt() to do the write.

  And since we're using bio to submit writes directly to the device, not
  using page cache anymore, after scratching the super block we also
  have to invalidate the cache to avoid user space seeing the
  out-of-date cached super block.

- Use kmalloc() and bdev_rw_virt() for sb_writer_pointer()
  In zoned mode we have a corner case that both super block zones are
  full, and we need to determine which zone to reuse.

  In that case we need to read the last super block of both zones and
  compare their generations.

  Here we just use regular kmalloc() + bdev_rw_virt() to do the read.

  And since we're here, simplify the error handling path by always
  calling kfree() on both super blocks.
  Since both super block pointers are initialized to NULL, we're safe to
  call kfree() on them.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c |  8 ++---
 fs/btrfs/super.c   |  4 +--
 fs/btrfs/volumes.c | 74 ++++++++++++++++++----------------------------
 fs/btrfs/volumes.h |  4 +--
 fs/btrfs/zoned.c   | 26 +++++++++-------
 5 files changed, 51 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7ce7afe2bdaf..0dd77b56dfdf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3269,7 +3269,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	/*
 	 * Read super block and check the signature bytes only
 	 */
-	disk_super = btrfs_read_disk_super(fs_devices->latest_dev->bdev, 0, false);
+	disk_super = btrfs_read_disk_super(fs_devices->latest_dev->bdev, 0);
 	if (IS_ERR(disk_super)) {
 		ret = PTR_ERR(disk_super);
 		goto fail_alloc;
@@ -3285,7 +3285,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
 			  csum_type);
 		ret = -EINVAL;
-		btrfs_release_disk_super(disk_super);
+		kfree(disk_super);
 		goto fail_alloc;
 	}
 
@@ -3301,7 +3301,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (btrfs_check_super_csum(fs_info, disk_super)) {
 		btrfs_err(fs_info, "superblock checksum mismatch");
 		ret = -EINVAL;
-		btrfs_release_disk_super(disk_super);
+		kfree(disk_super);
 		goto fail_alloc;
 	}
 
@@ -3311,7 +3311,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * the whole block of INFO_SIZE
 	 */
 	memcpy(fs_info->super_copy, disk_super, sizeof(*fs_info->super_copy));
-	btrfs_release_disk_super(disk_super);
+	kfree(disk_super);
 
 	disk_super = fs_info->super_copy;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d64d303b6edc..f884260d7233 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2317,7 +2317,7 @@ static int check_dev_super(struct btrfs_device *dev)
 		return 0;
 
 	/* Only need to check the primary super block. */
-	sb = btrfs_read_disk_super(dev->bdev, 0, true);
+	sb = btrfs_read_disk_super(dev->bdev, 0);
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 
@@ -2349,7 +2349,7 @@ static int check_dev_super(struct btrfs_device *dev)
 		goto out;
 	}
 out:
-	btrfs_release_disk_super(sb);
+	kfree(sb);
 	return ret;
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 908a89eaeabf..2969e2b96538 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -495,7 +495,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 		}
 	}
 	invalidate_bdev(bdev);
-	*disk_super = btrfs_read_disk_super(bdev, 0, false);
+	*disk_super = btrfs_read_disk_super(bdev, 0);
 	if (IS_ERR(*disk_super)) {
 		ret = PTR_ERR(*disk_super);
 		bdev_fput(*bdev_file);
@@ -716,12 +716,12 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		fs_devices->rw_devices++;
 		list_add_tail(&device->dev_alloc_list, &fs_devices->alloc_list);
 	}
-	btrfs_release_disk_super(disk_super);
+	kfree(disk_super);
 
 	return 0;
 
 error_free_page:
-	btrfs_release_disk_super(disk_super);
+	kfree(disk_super);
 	bdev_fput(bdev_file);
 
 	return -EINVAL;
@@ -1325,20 +1325,11 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	return ret;
 }
 
-void btrfs_release_disk_super(struct btrfs_super_block *super)
-{
-	struct page *page = virt_to_page(super);
-
-	put_page(page);
-}
-
 struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
-						int copy_num, bool drop_cache)
+						int copy_num)
 {
 	struct btrfs_super_block *super;
-	struct page *page;
 	u64 bytenr, bytenr_orig;
-	struct address_space *mapping = bdev->bd_mapping;
 	int ret;
 
 	bytenr_orig = btrfs_sb_offset(copy_num);
@@ -1352,28 +1343,19 @@ struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
 	if (bytenr + BTRFS_SUPER_INFO_SIZE >= bdev_nr_bytes(bdev))
 		return ERR_PTR(-EINVAL);
 
-	if (drop_cache) {
-		/* This should only be called with the primary sb. */
-		ASSERT(copy_num == 0);
-
-		/*
-		 * Drop the page of the primary superblock, so later read will
-		 * always read from the device.
-		 */
-		invalidate_inode_pages2_range(mapping, bytenr >> PAGE_SHIFT,
-				      (bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
+	super = kmalloc(BTRFS_SUPER_INFO_SIZE, GFP_NOFS);
+	if (!super)
+		return ERR_PTR(-ENOMEM);
+	ret = bdev_rw_virt(bdev, bytenr >> SECTOR_SHIFT, super, BTRFS_SUPER_INFO_SIZE,
+			   REQ_OP_READ);
+	if (ret < 0) {
+		kfree(super);
+		return ERR_PTR(ret);
 	}
 
-	filemap_invalidate_lock(mapping);
-	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
-	filemap_invalidate_unlock(mapping);
-	if (IS_ERR(page))
-		return ERR_CAST(page);
-
-	super = page_address(page);
 	if (btrfs_super_magic(super) != BTRFS_MAGIC ||
 	    btrfs_super_bytenr(super) != bytenr_orig) {
-		btrfs_release_disk_super(super);
+		kfree(super);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -1474,7 +1456,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path,
 	if (IS_ERR(bdev_file))
 		return ERR_CAST(bdev_file);
 
-	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), 0, false);
+	disk_super = btrfs_read_disk_super(file_bdev(bdev_file), 0);
 	if (IS_ERR(disk_super)) {
 		device = ERR_CAST(disk_super);
 		goto error_bdev_put;
@@ -1496,7 +1478,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path,
 		btrfs_free_stale_devices(device->devt, device);
 
 free_disk_super:
-	btrfs_release_disk_super(disk_super);
+	kfree(disk_super);
 
 error_bdev_put:
 	bdev_fput(bdev_file);
@@ -2119,20 +2101,22 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
 				     struct block_device *bdev, int copy_num)
 {
 	struct btrfs_super_block *disk_super;
-	const size_t len = sizeof(disk_super->magic);
 	const u64 bytenr = btrfs_sb_offset(copy_num);
 	int ret;
 
-	disk_super = btrfs_read_disk_super(bdev, copy_num, false);
-	if (IS_ERR(disk_super))
-		return;
-
-	memset(&disk_super->magic, 0, len);
-	folio_mark_dirty(virt_to_folio(disk_super));
-	btrfs_release_disk_super(disk_super);
-
-	ret = sync_blockdev_range(bdev, bytenr, bytenr + len - 1);
-	if (ret)
+	disk_super = btrfs_read_disk_super(bdev, copy_num);
+	if (IS_ERR(disk_super)) {
+		ret = PTR_ERR(disk_super);
+		goto out;
+	}
+	btrfs_set_super_magic(disk_super, 0);
+	ret = bdev_rw_virt(bdev, bytenr >> SECTOR_SHIFT, disk_super,
+			   BTRFS_SUPER_INFO_SIZE, REQ_OP_WRITE);
+	kfree(disk_super);
+out:
+	/* Make sure userspace won't see some out-of-date cached super block. */
+	invalidate_bdev(bdev);
+	if (ret < 0)
 		btrfs_warn(fs_info, "error clearing superblock number %d (%d)",
 			copy_num, ret);
 }
@@ -2462,7 +2446,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 		memcpy(args->fsid, disk_super->metadata_uuid, BTRFS_FSID_SIZE);
 	else
 		memcpy(args->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
-	btrfs_release_disk_super(disk_super);
+	kfree(disk_super);
 	bdev_fput(bdev_file);
 	return 0;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 93f45410931e..6381420800fb 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -780,9 +780,7 @@ struct btrfs_chunk_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 					    u64 logical, u64 length);
 void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map);
 struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
-						int copy_num, bool drop_cache);
-void btrfs_release_disk_super(struct btrfs_super_block *super);
-
+						int copy_num);
 static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
 				      int index)
 {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2e861eef5cd8..301e342776b2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -122,23 +122,27 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		return -ENOENT;
 	} else if (full[0] && full[1]) {
 		/* Compare two super blocks */
-		struct address_space *mapping = bdev->bd_mapping;
-		struct page *page[BTRFS_NR_SB_LOG_ZONES];
-		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
+		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES] = { 0 };
 
 		for (int i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
 			u64 zone_end = (zones[i].start + zones[i].capacity) << SECTOR_SHIFT;
 			u64 bytenr = ALIGN_DOWN(zone_end, BTRFS_SUPER_INFO_SIZE) -
 						BTRFS_SUPER_INFO_SIZE;
+			int ret;
 
-			page[i] = read_cache_page_gfp(mapping,
-					bytenr >> PAGE_SHIFT, GFP_NOFS);
-			if (IS_ERR(page[i])) {
-				if (i == 1)
-					btrfs_release_disk_super(super[0]);
-				return PTR_ERR(page[i]);
+			super[i] = kmalloc(BTRFS_SUPER_INFO_SIZE, GFP_NOFS);
+			if (!super[i]) {
+				kfree(super[0]);
+				kfree(super[1]);
+				return -ENOMEM;
+			}
+			ret = bdev_rw_virt(bdev, bytenr >> SECTOR_SHIFT, super[i],
+					   BTRFS_SUPER_INFO_SIZE, REQ_OP_READ);
+			if (ret < 0) {
+				kfree(super[0]);
+				kfree(super[1]);
+				return ret;
 			}
-			super[i] = page_address(page[i]);
 		}
 
 		if (btrfs_super_generation(super[0]) >
@@ -148,7 +152,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 			sector = zones[0].start;
 
 		for (int i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++)
-			btrfs_release_disk_super(super[i]);
+			kfree(super[i]);
 	} else if (!full[0] && (empty[1] || full[1])) {
 		sector = zones[0].wp;
 	} else if (full[0]) {
-- 
2.52.0


