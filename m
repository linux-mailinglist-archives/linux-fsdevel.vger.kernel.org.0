Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31EA775CE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 13:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbjHILcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 07:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjHILb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:31:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186F61FD8
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 04:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 934B6633D7
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 11:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5B0C433C9;
        Wed,  9 Aug 2023 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691580712;
        bh=o3Frsk3XlJgxkDZ8IWp2QgmXJ3sIcGktxNF9wSUgQhs=;
        h=From:To:Cc:Subject:Date:From;
        b=ipWQCU83/AV4D9pxGfI62nmvM9ueYoYsVgYHgwmGznqlbdKxD7nlSvyom1NMEARmQ
         TCfiAsjK43O4trcO8ch2IDisy2+xtetE/p1vlGRyYRN3fZfBQnkb1SRjEXrVtq3gG6
         BzdQMdAAZjCGy+e6YWgdlZyrA1NXIYnR5JEayq7poUimfL9tKd3SEUVWejEHzOsMnt
         XTFNXmIsL54GRn7tj/1K6OOJEI+nfcU0ecf6PRZIr7yRp5hyWOeJAhqTJCupY85lpn
         N/Rg/WNVbxjSoq0vkb2RVjhEh3jaDNmkctkE6a8FZstH/Pby/K45PokfVpQiycUwF3
         PBTg5oowKx2Iw==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] zonefs: fix synchronous direct writes to sequential files
Date:   Wed,  9 Aug 2023 20:31:50 +0900
Message-ID: <20230809113150.702115-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 16d7fd3cfa72 ("zonefs: use iomap for synchronous direct writes")
changes zonefs code from a self-built zone append BIO to using iomap for
synchronous direct writes. This change relies on iomap submit BIO
callback to change the write BIO built by iomap to a zone append BIO.
However, this change overlooked the fact that a write BIO may be very
large as it is split when issued. The change from a regular write to a
zone append operation for the built BIO can result in a block layer
warning as zone append BIO are not allowed to be split.

WARNING: CPU: 18 PID: 202210 at block/bio.c:1644 bio_split+0x288/0x350
Call Trace:
? __warn+0xc9/0x2b0
? bio_split+0x288/0x350
? report_bug+0x2e6/0x390
? handle_bug+0x41/0x80
? exc_invalid_op+0x13/0x40
? asm_exc_invalid_op+0x16/0x20
? bio_split+0x288/0x350
bio_split_rw+0x4bc/0x810
? __pfx_bio_split_rw+0x10/0x10
? lockdep_unlock+0xf2/0x250
__bio_split_to_limits+0x1d8/0x900
blk_mq_submit_bio+0x1cf/0x18a0
? __pfx_iov_iter_extract_pages+0x10/0x10
? __pfx_blk_mq_submit_bio+0x10/0x10
? find_held_lock+0x2d/0x110
? lock_release+0x362/0x620
? mark_held_locks+0x9e/0xe0
__submit_bio+0x1ea/0x290
? __pfx___submit_bio+0x10/0x10
? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
submit_bio_noacct_nocheck+0x675/0xa20
? __pfx_bio_iov_iter_get_pages+0x10/0x10
? __pfx_submit_bio_noacct_nocheck+0x10/0x10
iomap_dio_bio_iter+0x624/0x1280
__iomap_dio_rw+0xa22/0x18a0
? lock_is_held_type+0xe3/0x140
? __pfx___iomap_dio_rw+0x10/0x10
? lock_release+0x362/0x620
? zonefs_file_write_iter+0x74c/0xc80 [zonefs]
? down_write+0x13d/0x1e0
iomap_dio_rw+0xe/0x40
zonefs_file_write_iter+0x5ea/0xc80 [zonefs]
do_iter_readv_writev+0x18b/0x2c0
? __pfx_do_iter_readv_writev+0x10/0x10
? inode_security+0x54/0xf0
do_iter_write+0x13b/0x7c0
? lock_is_held_type+0xe3/0x140
vfs_writev+0x185/0x550
? __pfx_vfs_writev+0x10/0x10
? __handle_mm_fault+0x9bd/0x1c90
? find_held_lock+0x2d/0x110
? lock_release+0x362/0x620
? find_held_lock+0x2d/0x110
? lock_release+0x362/0x620
? __up_read+0x1ea/0x720
? do_pwritev+0x136/0x1f0
do_pwritev+0x136/0x1f0
? __pfx_do_pwritev+0x10/0x10
? syscall_enter_from_user_mode+0x22/0x90
? lockdep_hardirqs_on+0x7d/0x100
do_syscall_64+0x58/0x80

This error depends on the hardware used, specifically on the max zone
append bytes and max_[hw_]sectors limits. Tests using AMD Epyc machines
that have low limits did not reveal this issue while runs on Intel Xeon
machines with larger limits trigger it.

Manually splitting the zone append BIO using bio_split_rw() can solve
this issue but also requires issuing the fragment BIOs synchronously
with submit_bio_wait(), to avoid potential reordering of the zone append
BIO fragments, which would lead to data corruption. That is, this
solution is not better than using regular write BIOs which are subject
to serialization using zone write locking at the IO scheduler level.

Given this, fix the issue by removing zone append support and using
regular write BIOs for synchronous direct writes. This allows preseving
the use of iomap and having identical synchronous and asynchronous
sequential file write path. Zone append support will be reintroduced
later through io_uring commands to ensure that the needed special
handling is done correctly.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 16d7fd3cfa72 ("zonefs: use iomap for synchronous direct writes")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
 * Corrected typos in commit message
 * Added Shin'ichiro Tested-by tag

 fs/zonefs/file.c   | 111 ++-------------------------------------------
 fs/zonefs/super.c  |   9 +---
 fs/zonefs/zonefs.h |   2 -
 3 files changed, 4 insertions(+), 118 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 92c9aaae3663..789cfb74c146 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -341,77 +341,6 @@ static loff_t zonefs_file_llseek(struct file *file, loff_t offset, int whence)
 	return generic_file_llseek_size(file, offset, whence, isize, isize);
 }
 
-struct zonefs_zone_append_bio {
-	/* The target inode of the BIO */
-	struct inode *inode;
-
-	/* For sync writes, the target append write offset */
-	u64 append_offset;
-
-	/*
-	 * This member must come last, bio_alloc_bioset will allocate enough
-	 * bytes for entire zonefs_bio but relies on bio being last.
-	 */
-	struct bio bio;
-};
-
-static inline struct zonefs_zone_append_bio *
-zonefs_zone_append_bio(struct bio *bio)
-{
-	return container_of(bio, struct zonefs_zone_append_bio, bio);
-}
-
-static void zonefs_file_zone_append_dio_bio_end_io(struct bio *bio)
-{
-	struct zonefs_zone_append_bio *za_bio = zonefs_zone_append_bio(bio);
-	struct zonefs_zone *z = zonefs_inode_zone(za_bio->inode);
-	sector_t za_sector;
-
-	if (bio->bi_status != BLK_STS_OK)
-		goto bio_end;
-
-	/*
-	 * If the file zone was written underneath the file system, the zone
-	 * append operation can still succedd (if the zone is not full) but
-	 * the write append location will not be where we expect it to be.
-	 * Check that we wrote where we intended to, that is, at z->z_wpoffset.
-	 */
-	za_sector = z->z_sector + (za_bio->append_offset >> SECTOR_SHIFT);
-	if (bio->bi_iter.bi_sector != za_sector) {
-		zonefs_warn(za_bio->inode->i_sb,
-			    "Invalid write sector %llu for zone at %llu\n",
-			    bio->bi_iter.bi_sector, z->z_sector);
-		bio->bi_status = BLK_STS_IOERR;
-	}
-
-bio_end:
-	iomap_dio_bio_end_io(bio);
-}
-
-static void zonefs_file_zone_append_dio_submit_io(const struct iomap_iter *iter,
-						  struct bio *bio,
-						  loff_t file_offset)
-{
-	struct zonefs_zone_append_bio *za_bio = zonefs_zone_append_bio(bio);
-	struct inode *inode = iter->inode;
-	struct zonefs_zone *z = zonefs_inode_zone(inode);
-
-	/*
-	 * Issue a zone append BIO to process sync dio writes. The append
-	 * file offset is saved to check the zone append write location
-	 * on completion of the BIO.
-	 */
-	za_bio->inode = inode;
-	za_bio->append_offset = file_offset;
-
-	bio->bi_opf &= ~REQ_OP_WRITE;
-	bio->bi_opf |= REQ_OP_ZONE_APPEND;
-	bio->bi_iter.bi_sector = z->z_sector;
-	bio->bi_end_io = zonefs_file_zone_append_dio_bio_end_io;
-
-	submit_bio(bio);
-}
-
 static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
 					int error, unsigned int flags)
 {
@@ -442,14 +371,6 @@ static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
 	return 0;
 }
 
-static struct bio_set zonefs_zone_append_bio_set;
-
-static const struct iomap_dio_ops zonefs_zone_append_dio_ops = {
-	.submit_io	= zonefs_file_zone_append_dio_submit_io,
-	.end_io		= zonefs_file_write_dio_end_io,
-	.bio_set	= &zonefs_zone_append_bio_set,
-};
-
 static const struct iomap_dio_ops zonefs_write_dio_ops = {
 	.end_io		= zonefs_file_write_dio_end_io,
 };
@@ -533,9 +454,6 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
 	struct super_block *sb = inode->i_sb;
-	const struct iomap_dio_ops *dio_ops;
-	bool sync = is_sync_kiocb(iocb);
-	bool append = false;
 	ssize_t ret, count;
 
 	/*
@@ -543,7 +461,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	 * as this can cause write reordering (e.g. the first aio gets EAGAIN
 	 * on the inode lock but the second goes through but is now unaligned).
 	 */
-	if (zonefs_zone_is_seq(z) && !sync && (iocb->ki_flags & IOCB_NOWAIT))
+	if (zonefs_zone_is_seq(z) && !is_sync_kiocb(iocb) &&
+	    (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -573,18 +492,6 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 			goto inode_unlock;
 		}
 		mutex_unlock(&zi->i_truncate_mutex);
-		append = sync;
-	}
-
-	if (append) {
-		unsigned int max = bdev_max_zone_append_sectors(sb->s_bdev);
-
-		max = ALIGN_DOWN(max << SECTOR_SHIFT, sb->s_blocksize);
-		iov_iter_truncate(from, max);
-
-		dio_ops = &zonefs_zone_append_dio_ops;
-	} else {
-		dio_ops = &zonefs_write_dio_ops;
 	}
 
 	/*
@@ -593,7 +500,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	 * the user can make sense of the error.
 	 */
 	ret = iomap_dio_rw(iocb, from, &zonefs_write_iomap_ops,
-			   dio_ops, 0, NULL, 0);
+			   &zonefs_write_dio_ops, 0, NULL, 0);
 	if (ret == -ENOTBLK)
 		ret = -EBUSY;
 
@@ -938,15 +845,3 @@ const struct file_operations zonefs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.iopoll		= iocb_bio_iopoll,
 };
-
-int zonefs_file_bioset_init(void)
-{
-	return bioset_init(&zonefs_zone_append_bio_set, BIO_POOL_SIZE,
-			   offsetof(struct zonefs_zone_append_bio, bio),
-			   BIOSET_NEED_BVECS);
-}
-
-void zonefs_file_bioset_exit(void)
-{
-	bioset_exit(&zonefs_zone_append_bio_set);
-}
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bbe44a26a8e5..9350221abfc5 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1412,13 +1412,9 @@ static int __init zonefs_init(void)
 
 	BUILD_BUG_ON(sizeof(struct zonefs_super) != ZONEFS_SUPER_SIZE);
 
-	ret = zonefs_file_bioset_init();
-	if (ret)
-		return ret;
-
 	ret = zonefs_init_inodecache();
 	if (ret)
-		goto destroy_bioset;
+		return ret;
 
 	ret = zonefs_sysfs_init();
 	if (ret)
@@ -1434,8 +1430,6 @@ static int __init zonefs_init(void)
 	zonefs_sysfs_exit();
 destroy_inodecache:
 	zonefs_destroy_inodecache();
-destroy_bioset:
-	zonefs_file_bioset_exit();
 
 	return ret;
 }
@@ -1445,7 +1439,6 @@ static void __exit zonefs_exit(void)
 	unregister_filesystem(&zonefs_type);
 	zonefs_sysfs_exit();
 	zonefs_destroy_inodecache();
-	zonefs_file_bioset_exit();
 }
 
 MODULE_AUTHOR("Damien Le Moal");
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index f663b8ebc2cb..8175652241b5 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -279,8 +279,6 @@ extern const struct file_operations zonefs_dir_operations;
 extern const struct address_space_operations zonefs_file_aops;
 extern const struct file_operations zonefs_file_operations;
 int zonefs_file_truncate(struct inode *inode, loff_t isize);
-int zonefs_file_bioset_init(void);
-void zonefs_file_bioset_exit(void);
 
 /* In sysfs.c */
 int zonefs_sysfs_register(struct super_block *sb);
-- 
2.41.0

