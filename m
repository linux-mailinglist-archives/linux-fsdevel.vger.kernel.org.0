Return-Path: <linux-fsdevel+bounces-64660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74F6BF0236
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69577189F2E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158CD2F28ED;
	Mon, 20 Oct 2025 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RTdj0U+K";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nFJE4D5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757402F3619
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952032; cv=none; b=fOsdsEFSiboVtnJIpelQfNpBz4wc0ddbqIiTqcj7Pu/yR//NeKYwZik+CS5oZhLtXqLWBwzs2ksw7ar+vn/qCk66siRuGZabIrjuAyrZaeLIPyvSvwvRnyQPSGCcTYkQ1MJrKgvoxjHMZkvLMoaoHGqTfhZfi4Xpcp990uPIrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952032; c=relaxed/simple;
	bh=CQKXi3EhtaVCwqP+h/NC4UNTrcj3xACX/1LZnn8QaNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WoNfx1bZ6gOdCIWkjSjiFY/fjGV9zjVSvbeAe3qc5JJ+mipsc2PLhAimorb7O3wXihyd8n2dCWmHoVMPUbLaW6NxEPXq3UxeKeHvAutmA6AFQRuyJRZXjV8FqrSeJCNpPiA+VNFp9xWUa2I1eAuXXK8MKGfiWSP9ADvSIPIHzt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RTdj0U+K; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nFJE4D5T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 860ED21134;
	Mon, 20 Oct 2025 09:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760952024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sp/4hSlw2N7zPOoCsAQ+w6tQazwLzeqyKFV5HdVznN4=;
	b=RTdj0U+KPGxoHrHEkuZ5wrGqdiJazff6AIWGMPXnQZsp4lHvhPnkZokuWJMGfyZUiOygOD
	AKokvdTK8fpOSpXd9/4CbZFWF8QW7WsIhyf9VAGMNZUOzOWAGNDKn2PWcPsro4ibMPWHfF
	rf2Dxoy4SZgxVQ0n+sUctFct9D6tDjA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760952020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sp/4hSlw2N7zPOoCsAQ+w6tQazwLzeqyKFV5HdVznN4=;
	b=nFJE4D5Tno3dIXp4CGUXwYxdHf66Dmf4Z30MGlxjX4lVvk+IdPMEN4IIlpEoWKBkqyjT1/
	QE+llOvhor1eL2XgC549jj+KjB281iBe6uSkbrAA+EtCGi01JiFROERH9E513bcD+TD4v1
	mPY6RUcDLCUzReizAI33YZxj3Ed09WI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFCE213AAC;
	Mon, 20 Oct 2025 09:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hadtF87+9WjPfAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 20 Oct 2025 09:20:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] btrfs: never trust the bio from direct IO
Date: Mon, 20 Oct 2025 19:49:50 +1030
Message-ID: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

There is a bug report about that direct IO (and even concurrent buffered
IO) can lead to different contents of md-raid.

It's exactly the situation we fixed for direct IO in commit 968f19c5b1b7
("btrfs: always fallback to buffered write if the inode requires
checksum"), however we still leave a hole for nodatasum cases.

For nodatasum cases we still reuse the bio from direct IO, making it to
cause the same problem for RAID1*/5/6 profiles, and results
unreliable data contents read from disk, depending on the load balance.

Just do not trust any bio from direct IO, and never reuse those bios even
for nodatasum cases. Instead alloc our own bio with newly allocated
pages.

For direct read, submit that new bio, and at end io time copy the
contents to the dio bio.
For direct write, copy the contents from the dio bio, then submit the
new one.

This of course will lead to extra performance drop, but
it should still be much better than falling back to buffered IO.

There is a quick test done in my VM, with cache mode 'none' (aka, qemu
will use direct IO submitting the IO, to avoid double caching).

The VM has 10G ram, the target storage is backed by one PCIE gen3 NVME
SSD, the kernel has some minor/lightweight debug options:

The test command is pretty simple:
  dd if=/dev/zero bs=1M of=/mnt/btrfs/foobar count=4096 oflag=direct

- Raw disk IO
  dd if=/dev/zero bs=1M of=/dev/test/scratch1 count=4096 oflag=direct

  1.80748 s, 2.4 GB/s

- Fallback to buffered IO (unpatched)
  Mount option: default (with data checksum)

  20.7763 s, 207 MB/s

  Miserable, most SATA SSD is more than double the speed, and less than
  10% of the raw disk performance.
  Thankfully with this bouncing behavior, we can easily re-claim the
  performance soon.
  (Will be one small follow-up patch for it, after dropping the RFC
  tag)

- True zero-copy (unpatch)
  Mount option: nodatasum

  1.95422 s, 2.2 GB/s

  Very close to the raw disk speed.

- Bounce then zero-copy (patched)
  Mount option: nodatasum

  2.5453 s, 1.7 GB/s

  Around 23% slower than true zero-copy, but still acceptable if you ask
  me.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=99171
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
REASON FOR RFC:

Considering the zero-copy direct IO (and the fact XFS/EXT4 even allows
modifying the page cache when it's still under writeback) can lead to
raid mirror contents mismatch, the 23% performance drop should still be
acceptable, and bcachefs is already doing this bouncing behavior.

But still, such performance drop can be very obvious, and performance
oriented users (who are very happy running various benchmark tools) are
going to notice or even complain.

Another question is, should we push this behavior to iomap layer so that other
fses can also benefit from it?
---
 fs/btrfs/direct-io.c | 150 ++++++++++++++++++++++++++++++-------------
 1 file changed, 105 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 802d4dbe5b38..1a8bed65c417 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -640,33 +640,6 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return ret;
 }
 
-static void btrfs_dio_end_io(struct btrfs_bio *bbio)
-{
-	struct btrfs_dio_private *dip =
-		container_of(bbio, struct btrfs_dio_private, bbio);
-	struct btrfs_inode *inode = bbio->inode;
-	struct bio *bio = &bbio->bio;
-
-	if (bio->bi_status) {
-		btrfs_warn(inode->root->fs_info,
-		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
-			   btrfs_ino(inode), bio->bi_opf,
-			   dip->file_offset, dip->bytes, bio->bi_status);
-	}
-
-	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-		btrfs_finish_ordered_extent(bbio->ordered, NULL,
-					    dip->file_offset, dip->bytes,
-					    !bio->bi_status);
-	} else {
-		btrfs_unlock_dio_extent(&inode->io_tree, dip->file_offset,
-					dip->file_offset + dip->bytes - 1, NULL);
-	}
-
-	bbio->bio.bi_private = bbio->private;
-	iomap_dio_bio_end_io(bio);
-}
-
 static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 					struct btrfs_ordered_extent *ordered)
 {
@@ -705,23 +678,109 @@ static int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
 	return 0;
 }
 
-static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
-				loff_t file_offset)
+static void dio_end_write_copied_bio(struct btrfs_bio *bbio)
 {
-	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct bio *orig = bbio->private;
 	struct btrfs_dio_private *dip =
 		container_of(bbio, struct btrfs_dio_private, bbio);
-	struct btrfs_dio_data *dio_data = iter->private;
+	struct btrfs_inode *inode = bbio->inode;
+	struct bio *bio = &bbio->bio;
 
-	btrfs_bio_init(bbio, BTRFS_I(iter->inode)->root->fs_info,
-		       btrfs_dio_end_io, bio->bi_private);
-	bbio->inode = BTRFS_I(iter->inode);
-	bbio->file_offset = file_offset;
+	if (bio->bi_status) {
+		btrfs_warn(inode->root->fs_info,
+		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
+			   btrfs_ino(inode), bio->bi_opf,
+			   dip->file_offset, dip->bytes, bio->bi_status);
+	}
+
+	orig->bi_status = bbio->bio.bi_status;
+	btrfs_finish_ordered_extent(bbio->ordered, NULL,
+				    dip->file_offset, dip->bytes,
+				    !bio->bi_status);
+	bio_free_pages(bio);
+	bio_put(bio);
+	iomap_dio_bio_end_io(orig);
+}
+
+static void dio_end_read_copied_bio(struct btrfs_bio *bbio)
+{
+	struct bio *orig = bbio->private;
+	struct btrfs_dio_private *dip =
+		container_of(bbio, struct btrfs_dio_private, bbio);
+	struct btrfs_inode *inode = bbio->inode;
+	struct bio *bio = &bbio->bio;
+
+	if (bio->bi_status) {
+		btrfs_warn(inode->root->fs_info,
+		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
+			   btrfs_ino(inode), bio->bi_opf,
+			   dip->file_offset, dip->bytes, bio->bi_status);
+	}
+
+	orig->bi_status = bbio->bio.bi_status;
+	bio_copy_data(orig, &bbio->bio);
+	btrfs_unlock_dio_extent(&inode->io_tree, dip->file_offset,
+				dip->file_offset + dip->bytes - 1, NULL);
+	bio_free_pages(bio);
+	bio_put(bio);
+	iomap_dio_bio_end_io(orig);
+}
+
+static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *src,
+				loff_t file_offset)
+{
+	struct btrfs_dio_private *dip;
+	struct btrfs_dio_data *dio_data = iter->private;
+	struct btrfs_bio *new_bbio;
+	struct bio *new_bio;
+	const bool is_write = (btrfs_op(src) == BTRFS_MAP_WRITE);
+	btrfs_bio_end_io_t end_io;
+	const unsigned int src_size = src->bi_iter.bi_size;
+	const int nr_pages = round_up(src_size, PAGE_SIZE) >> PAGE_SHIFT;
+	unsigned int cur = 0;
+	int ret;
+
+	if (is_write)
+		end_io = dio_end_write_copied_bio;
+	else
+		end_io = dio_end_read_copied_bio;
+
+	/*
+	 * We can not trust the direct IO bio, the content can be modified at any time
+	 * during the submission/writeback.
+	 * Thus we have to allocate a new bio with pages allocated by us, so that noone
+	 * can change the content.
+	 */
+	new_bio = bio_alloc_bioset(NULL, nr_pages, src->bi_opf, GFP_NOFS, &btrfs_dio_bioset);
+	new_bbio = btrfs_bio(new_bio);
+	btrfs_bio_init(new_bbio, inode_to_fs_info(iter->inode), end_io, src);
+	dip = container_of(new_bbio, struct btrfs_dio_private, bbio);
+	new_bbio->inode = BTRFS_I(iter->inode);
+	new_bbio->file_offset = file_offset;
+	dip->file_offset = file_offset;
+	dip->bytes = src_size;
+	while (cur < src_size) {
+		struct page *page = alloc_page(GFP_NOFS);
+		unsigned int size = min(src_size - cur, PAGE_SIZE);
+
+		if (!page) {
+			ret = -ENOMEM;
+			goto error;
+		}
+		ret = bio_add_page(&new_bbio->bio, page, size, 0);
+		ASSERT(ret == size);
+		cur += size;
+	}
+	ASSERT(new_bbio->bio.bi_iter.bi_size == src_size);
+	new_bbio->bio.bi_iter.bi_sector = src->bi_iter.bi_sector;
 
 	dip->file_offset = file_offset;
-	dip->bytes = bio->bi_iter.bi_size;
+	dip->bytes = src_size;
 
-	dio_data->submitted += bio->bi_iter.bi_size;
+	dio_data->submitted += src_size;
+
+	if (is_write)
+		bio_copy_data(&new_bbio->bio, src);
 
 	/*
 	 * Check if we are doing a partial write.  If we are, we need to split
@@ -731,20 +790,22 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	 * remaining pages is blocked on the outstanding ordered extent.
 	 */
 	if (iter->flags & IOMAP_WRITE) {
-		int ret;
-
-		ret = btrfs_extract_ordered_extent(bbio, dio_data->ordered);
+		ret = btrfs_extract_ordered_extent(new_bbio, dio_data->ordered);
 		if (ret) {
 			btrfs_finish_ordered_extent(dio_data->ordered, NULL,
 						    file_offset, dip->bytes,
 						    !ret);
-			bio->bi_status = errno_to_blk_status(ret);
-			iomap_dio_bio_end_io(bio);
-			return;
+			goto error;
 		}
 	}
 
-	btrfs_submit_bbio(bbio, 0);
+	btrfs_submit_bbio(new_bbio, 0);
+	return;
+error:
+	src->bi_status = errno_to_blk_status(ret);
+	bio_free_pages(&new_bbio->bio);
+	bio_put(&new_bbio->bio);
+	iomap_dio_bio_end_io(src);
 }
 
 static const struct iomap_ops btrfs_dio_iomap_ops = {
@@ -754,7 +815,6 @@ static const struct iomap_ops btrfs_dio_iomap_ops = {
 
 static const struct iomap_dio_ops btrfs_dio_ops = {
 	.submit_io		= btrfs_dio_submit_io,
-	.bio_set		= &btrfs_dio_bioset,
 };
 
 static ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.51.0


