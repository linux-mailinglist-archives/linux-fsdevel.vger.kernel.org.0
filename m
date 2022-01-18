Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B9F492019
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 08:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244864AbiARHVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 02:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiARHV2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:21:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE6FC061755;
        Mon, 17 Jan 2022 23:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uW2mc9iWaFckCAcp0+ZfendEWrcDkE662kty754dA0k=; b=tZb6X2SFk3AoLZl4MFFNrJNAVh
        18JZLt1KWqP3DAtfpomGX0IflVAXcruOAEh1YiU+9I8odpyf6+No3+TjObDON1RWjxVy/IGtNnG8E
        LvCQEm/YAFQpwN8mA83LMBjnUK9UJkaTlVQqgASznI94zbmjmbVNclg+N9/qXCNccrg6ElamC+FFk
        /kIiDwhlzSLMtTWTB+8fCoB3lLJ0HOe6/hR7/3f4flFFFNA1IDQvQeoCvdgSp019KSjaRpMBSbvvJ
        Mu02rz/w0rXlf++ocMqZKX0syk1fzhMYadUObkhG8P65d51v9r9RXk76lBvqvNVrKN+/uZhqSSrfQ
        l9mMFOCg==;
Received: from [2001:4bb8:184:72a4:a4a9:19c0:5242:7768] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9inQ-000Zlb-97; Tue, 18 Jan 2022 07:20:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: [PATCH 19/19] block: pass a block_device and opf to bio_reset
Date:   Tue, 18 Jan 2022 08:19:52 +0100
Message-Id: <20220118071952.1243143-20-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118071952.1243143-1-hch@lst.de>
References: <20220118071952.1243143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the block_device that we plan to use this bio for and the
operation to bio_reset to optimize the assigment.  A NULL block_device
can be passed, both for the passthrough case on a raw request_queue and
to temporarily avoid refactoring some nasty code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                 |  6 +++++-
 drivers/block/pktcdvd.c     |  8 ++------
 drivers/md/bcache/journal.c | 12 ++++--------
 drivers/md/bcache/request.c |  4 ++--
 drivers/md/raid1.c          |  5 ++---
 drivers/md/raid10.c         |  8 +++-----
 drivers/md/raid5-cache.c    |  9 +++------
 drivers/md/raid5.c          |  8 ++++----
 fs/btrfs/disk-io.c          |  4 +---
 fs/crypto/bio.c             |  8 ++------
 include/linux/bio.h         |  9 +--------
 11 files changed, 29 insertions(+), 52 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 2480f80296eac..9050b0cc1e43e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -295,6 +295,8 @@ EXPORT_SYMBOL(bio_init);
 /**
  * bio_reset - reinitialize a bio
  * @bio:	bio to reset
+ * @bdev:	block device to use the bio for
+ * @opf:	operation and flags for bio
  *
  * Description:
  *   After calling bio_reset(), @bio will be in the same state as a freshly
@@ -302,11 +304,13 @@ EXPORT_SYMBOL(bio_init);
  *   preserved are the ones that are initialized by bio_alloc_bioset(). See
  *   comment in struct bio.
  */
-void bio_reset(struct bio *bio)
+void bio_reset(struct bio *bio, struct block_device *bdev, unsigned int opf)
 {
 	bio_uninit(bio);
 	memset(bio, 0, BIO_RESET_BYTES);
 	atomic_set(&bio->__bi_remaining, 1);
+	bio->bi_bdev = bdev;
+	bio->bi_opf = opf;
 }
 EXPORT_SYMBOL(bio_reset);
 
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 2b6b70a39e760..3aa5954429462 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1020,9 +1020,8 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 			continue;
 
 		bio = pkt->r_bios[f];
-		bio_reset(bio);
+		bio_reset(bio, pd->bdev, REQ_OP_READ);
 		bio->bi_iter.bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
-		bio_set_dev(bio, pd->bdev);
 		bio->bi_end_io = pkt_end_io_read;
 		bio->bi_private = pkt;
 
@@ -1034,7 +1033,6 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 			BUG();
 
 		atomic_inc(&pkt->io_wait);
-		bio_set_op_attrs(bio, REQ_OP_READ, 0);
 		pkt_queue_bio(pd, bio);
 		frames_read++;
 	}
@@ -1235,9 +1233,8 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 {
 	int f;
 
-	bio_reset(pkt->w_bio);
+	bio_reset(pkt->w_bio, pd->bdev, REQ_OP_WRITE);
 	pkt->w_bio->bi_iter.bi_sector = pkt->sector;
-	bio_set_dev(pkt->w_bio, pd->bdev);
 	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
 	pkt->w_bio->bi_private = pkt;
 
@@ -1270,7 +1267,6 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 
 	/* Start the write request */
 	atomic_set(&pkt->io_wait, 1);
-	bio_set_op_attrs(pkt->w_bio, REQ_OP_WRITE, 0);
 	pkt_queue_bio(pd, pkt->w_bio);
 }
 
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 6d26c5b06e2b6..7c2ca52ca3e43 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -53,14 +53,12 @@ static int journal_read_bucket(struct cache *ca, struct list_head *list,
 reread:		left = ca->sb.bucket_size - offset;
 		len = min_t(unsigned int, left, PAGE_SECTORS << JSET_BITS);
 
-		bio_reset(bio);
+		bio_reset(bio, ca->bdev, REQ_OP_READ);
 		bio->bi_iter.bi_sector	= bucket + offset;
-		bio_set_dev(bio, ca->bdev);
 		bio->bi_iter.bi_size	= len << 9;
 
 		bio->bi_end_io	= journal_read_endio;
 		bio->bi_private = &cl;
-		bio_set_op_attrs(bio, REQ_OP_READ, 0);
 		bch_bio_map(bio, data);
 
 		closure_bio_submit(ca->set, bio, &cl);
@@ -771,16 +769,14 @@ static void journal_write_unlocked(struct closure *cl)
 
 		atomic_long_add(sectors, &ca->meta_sectors_written);
 
-		bio_reset(bio);
+		bio_reset(bio, ca->bdev, REQ_OP_WRITE | 
+			  REQ_SYNC | REQ_META | REQ_PREFLUSH | REQ_FUA);
+		bch_bio_map(bio, w->data);
 		bio->bi_iter.bi_sector	= PTR_OFFSET(k, i);
-		bio_set_dev(bio, ca->bdev);
 		bio->bi_iter.bi_size = sectors << 9;
 
 		bio->bi_end_io	= journal_write_endio;
 		bio->bi_private = w;
-		bio_set_op_attrs(bio, REQ_OP_WRITE,
-				 REQ_SYNC|REQ_META|REQ_PREFLUSH|REQ_FUA);
-		bch_bio_map(bio, w->data);
 
 		trace_bcache_journal_write(bio, w->data->keys);
 		bio_list_add(&list, bio);
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index d4b98ebffd948..7ba59d08ed870 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -831,11 +831,11 @@ static void cached_dev_read_done(struct closure *cl)
 	 */
 
 	if (s->iop.bio) {
-		bio_reset(s->iop.bio);
+		bio_reset(s->iop.bio, s->cache_miss->bi_bdev, REQ_OP_READ);
 		s->iop.bio->bi_iter.bi_sector =
 			s->cache_miss->bi_iter.bi_sector;
-		bio_copy_dev(s->iop.bio, s->cache_miss);
 		s->iop.bio->bi_iter.bi_size = s->insert_bio_sectors << 9;
+		bio_clone_blkg_association(s->iop.bio, s->cache_miss);
 		bch_bio_map(s->iop.bio, NULL);
 
 		bio_copy_data(s->cache_miss, s->iop.bio);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 43276f8fdc815..e7710fb5befb4 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2166,11 +2166,10 @@ static void process_checks(struct r1bio *r1_bio)
 			continue;
 		/* fixup the bio for reuse, but preserve errno */
 		status = b->bi_status;
-		bio_reset(b);
+		bio_reset(b, conf->mirrors[i].rdev->bdev, REQ_OP_READ);
 		b->bi_status = status;
 		b->bi_iter.bi_sector = r1_bio->sector +
 			conf->mirrors[i].rdev->data_offset;
-		bio_set_dev(b, conf->mirrors[i].rdev->bdev);
 		b->bi_end_io = end_sync_read;
 		rp->raid_bio = r1_bio;
 		b->bi_private = rp;
@@ -2651,7 +2650,7 @@ static struct r1bio *raid1_alloc_init_r1buf(struct r1conf *conf)
 	for (i = conf->poolinfo->raid_disks; i--; ) {
 		bio = r1bio->bios[i];
 		rps = bio->bi_private;
-		bio_reset(bio);
+		bio_reset(bio, NULL, 0);
 		bio->bi_private = rps;
 	}
 	r1bio->master_bio = NULL;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index cb7c58050708e..da07bcbc06d08 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2422,7 +2422,7 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 		 * bi_vecs, as the read request might have corrupted these
 		 */
 		rp = get_resync_pages(tbio);
-		bio_reset(tbio);
+		bio_reset(tbio, conf->mirrors[d].rdev->bdev, REQ_OP_WRITE);
 
 		md_bio_reset_resync_pages(tbio, rp, fbio->bi_iter.bi_size);
 
@@ -2430,7 +2430,6 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 		tbio->bi_private = rp;
 		tbio->bi_iter.bi_sector = r10_bio->devs[i].addr;
 		tbio->bi_end_io = end_sync_write;
-		bio_set_op_attrs(tbio, REQ_OP_WRITE, 0);
 
 		bio_copy_data(tbio, fbio);
 
@@ -2441,7 +2440,6 @@ static void sync_request_write(struct mddev *mddev, struct r10bio *r10_bio)
 		if (test_bit(FailFast, &conf->mirrors[d].rdev->flags))
 			tbio->bi_opf |= MD_FAILFAST;
 		tbio->bi_iter.bi_sector += conf->mirrors[d].rdev->data_offset;
-		bio_set_dev(tbio, conf->mirrors[d].rdev->bdev);
 		submit_bio_noacct(tbio);
 	}
 
@@ -3160,12 +3158,12 @@ static struct r10bio *raid10_alloc_init_r10buf(struct r10conf *conf)
 	for (i = 0; i < nalloc; i++) {
 		bio = r10bio->devs[i].bio;
 		rp = bio->bi_private;
-		bio_reset(bio);
+		bio_reset(bio, NULL, 0);
 		bio->bi_private = rp;
 		bio = r10bio->devs[i].repl_bio;
 		if (bio) {
 			rp = bio->bi_private;
-			bio_reset(bio);
+			bio_reset(bio, NULL, 0);
 			bio->bi_private = rp;
 		}
 	}
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 98b9ca11c28d8..86e2bb89d9c7b 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1301,10 +1301,9 @@ void r5l_flush_stripe_to_raid(struct r5l_log *log)
 
 	if (!do_flush)
 		return;
-	bio_reset(&log->flush_bio);
-	bio_set_dev(&log->flush_bio, log->rdev->bdev);
+	bio_reset(&log->flush_bio, log->rdev->bdev,
+		  REQ_OP_WRITE | REQ_PREFLUSH);
 	log->flush_bio.bi_end_io = r5l_log_flush_endio;
-	log->flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 	submit_bio(&log->flush_bio);
 }
 
@@ -1678,9 +1677,7 @@ static int r5l_recovery_fetch_ra_pool(struct r5l_log *log,
 				      struct r5l_recovery_ctx *ctx,
 				      sector_t offset)
 {
-	bio_reset(ctx->ra_bio);
-	bio_set_dev(ctx->ra_bio, log->rdev->bdev);
-	bio_set_op_attrs(ctx->ra_bio, REQ_OP_READ, 0);
+	bio_reset(ctx->ra_bio, log->rdev->bdev, REQ_OP_READ);
 	ctx->ra_bio->bi_iter.bi_sector = log->rdev->data_offset + offset;
 
 	ctx->valid_pages = 0;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index a9dcc5bc9c329..7c119208a2143 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2677,7 +2677,7 @@ static void raid5_end_read_request(struct bio * bi)
 		(unsigned long long)sh->sector, i, atomic_read(&sh->count),
 		bi->bi_status);
 	if (i == disks) {
-		bio_reset(bi);
+		bio_reset(bi, NULL, 0);
 		BUG();
 		return;
 	}
@@ -2785,7 +2785,7 @@ static void raid5_end_read_request(struct bio * bi)
 		}
 	}
 	rdev_dec_pending(rdev, conf->mddev);
-	bio_reset(bi);
+	bio_reset(bi, NULL, 0);
 	clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
 	raid5_release_stripe(sh);
@@ -2823,7 +2823,7 @@ static void raid5_end_write_request(struct bio *bi)
 		(unsigned long long)sh->sector, i, atomic_read(&sh->count),
 		bi->bi_status);
 	if (i == disks) {
-		bio_reset(bi);
+		bio_reset(bi, NULL, 0);
 		BUG();
 		return;
 	}
@@ -2860,7 +2860,7 @@ static void raid5_end_write_request(struct bio *bi)
 	if (sh->batch_head && bi->bi_status && !replacement)
 		set_bit(STRIPE_BATCH_ERR, &sh->batch_head->state);
 
-	bio_reset(bi);
+	bio_reset(bi, NULL, 0);
 	if (!test_and_clear_bit(R5_DOUBLE_LOCKED, &sh->dev[i].flags))
 		clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f45aa506f9a6f..505ba21230b1f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4154,10 +4154,8 @@ static void write_dev_flush(struct btrfs_device *device)
 		return;
 #endif
 
-	bio_reset(bio);
+	bio_reset(bio, device->bdev, REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH);
 	bio->bi_end_io = btrfs_end_empty_barrier;
-	bio_set_dev(bio, device->bdev);
-	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
 	init_completion(&device->flush_wait);
 	bio->bi_private = &device->flush_wait;
 
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 755e985a42e0b..2217fe5ece6f9 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -80,9 +80,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 			err = submit_bio_wait(bio);
 			if (err)
 				goto out;
-			bio_reset(bio);
-			bio_set_dev(bio, inode->i_sb->s_bdev);
-			bio->bi_opf = REQ_OP_WRITE;
+			bio_reset(bio, inode->i_sb->s_bdev, REQ_OP_WRITE);
 			num_pages = 0;
 		}
 	}
@@ -181,9 +179,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		err = submit_bio_wait(bio);
 		if (err)
 			goto out;
-		bio_reset(bio);
-		bio_set_dev(bio, inode->i_sb->s_bdev);
-		bio->bi_opf = REQ_OP_WRITE;
+		bio_reset(bio, inode->i_sb->s_bdev, REQ_OP_WRITE);
 	} while (len != 0);
 	err = 0;
 out:
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 41bedf727f59c..18cfe5bb41ea8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -459,7 +459,7 @@ extern int submit_bio_wait(struct bio *bio);
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	      unsigned short max_vecs, unsigned int opf);
 extern void bio_uninit(struct bio *);
-extern void bio_reset(struct bio *);
+void bio_reset(struct bio *bio, struct block_device *bdev, unsigned int opf);
 void bio_chain(struct bio *, struct bio *);
 
 int bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
@@ -517,13 +517,6 @@ static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
 	bio_associate_blkg(bio);
 }
 
-static inline void bio_copy_dev(struct bio *dst, struct bio *src)
-{
-	bio_clear_flag(dst, BIO_REMAPPED);
-	dst->bi_bdev = src->bi_bdev;
-	bio_clone_blkg_association(dst, src);
-}
-
 /*
  * BIO list management for use by remapping drivers (e.g. DM or MD) and loop.
  *
-- 
2.30.2

