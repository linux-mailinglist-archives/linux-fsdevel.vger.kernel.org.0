Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5644BF09C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 05:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbiBVDU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 22:20:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240729AbiBVDUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:20:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0AC17AAF;
        Mon, 21 Feb 2022 19:19:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 642C3210E8;
        Tue, 22 Feb 2022 03:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645499986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+gOCl3Uu5a57JUf3+D8LPhOyA2XikSkYVnvXfrL++o=;
        b=Fuf3P/4XtdeE3L1qOoOVj29UXHcNj/udX+uqzlAmfU9TQ4gOakVNPvLm6WV9XHNw2Twhqn
        sG3YK3wsUpMYJGo5O1VFjH1kAV5JG3f+AvZTMT067gsfyTQVn3Z6dnqPXJqzeFAHMMe5N/
        Hl8f7OyU8NiyeLs25lu+BmR4ahBJxiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645499986;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+gOCl3Uu5a57JUf3+D8LPhOyA2XikSkYVnvXfrL++o=;
        b=e0iVNMN1hvdpMzQkKCVY9Hbh++qZa15xUJrFknVhOW91N6Iz2FkJ0V9zCPlTRBgCmToxme
        HItshZI/s+Hha9Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0FE913BA7;
        Tue, 22 Feb 2022 03:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xgsvKkhWFGIFWwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 22 Feb 2022 03:19:36 +0000
Subject: [PATCH 08/11] Remove bdi_congested() and wb_congested() and related
 functions
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Feb 2022 14:17:17 +1100
Message-ID: <164549983742.9187.2570198746005819592.stgit@noble.brown>
In-Reply-To: <164549971112.9187.16871723439770288255.stgit@noble.brown>
References: <164549971112.9187.16871723439770288255.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These functions are no longer useful as no BDIs report congestions any
more.

Removing the test on bdi_write_contested() in current_may_throttle()
could cause a small change in behaviour, but only when PF_LOCAL_THROTTLE
is set.

So replace the calls by 'false' and simplify the code - and remove the
functions.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com> (for nilfs bits)
Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/block/drbd/drbd_int.h |    3 ---
 drivers/block/drbd/drbd_req.c |    3 +--
 fs/ext2/ialloc.c              |    5 -----
 fs/nilfs2/segbuf.c            |   15 ---------------
 fs/xfs/xfs_buf.c              |    3 ---
 include/linux/backing-dev.h   |   26 --------------------------
 mm/vmscan.c                   |    4 +---
 7 files changed, 2 insertions(+), 57 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f27d5b0f9a0b..f804b1bfb3e6 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -638,9 +638,6 @@ enum {
 	STATE_SENT,		/* Do not change state/UUIDs while this is set */
 	CALLBACK_PENDING,	/* Whether we have a call_usermodehelper(, UMH_WAIT_PROC)
 				 * pending, from drbd worker context.
-				 * If set, bdi_write_congested() returns true,
-				 * so shrink_page_list() would not recurse into,
-				 * and potentially deadlock on, this drbd worker.
 				 */
 	DISCONNECT_SENT,
 
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 3235532ae077..2e5fb7e442e3 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -909,8 +909,7 @@ static bool remote_due_to_read_balancing(struct drbd_device *device, sector_t se
 
 	switch (rbm) {
 	case RB_CONGESTED_REMOTE:
-		return bdi_read_congested(
-			device->ldev->backing_bdev->bd_disk->bdi);
+		return 0;
 	case RB_LEAST_PENDING:
 		return atomic_read(&device->local_cnt) >
 			atomic_read(&device->ap_pending_cnt) + atomic_read(&device->rs_pending_cnt);
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index df14e750e9fe..998dd2ac8008 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -170,11 +170,6 @@ static void ext2_preread_inode(struct inode *inode)
 	unsigned long offset;
 	unsigned long block;
 	struct ext2_group_desc * gdp;
-	struct backing_dev_info *bdi;
-
-	bdi = inode_to_bdi(inode);
-	if (bdi_rw_congested(bdi))
-		return;
 
 	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
 	gdp = ext2_get_group_desc(inode->i_sb, block_group, NULL);
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 43287b0d3e9b..c4510f79037f 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -343,17 +343,6 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
 	struct bio *bio = wi->bio;
 	int err;
 
-	if (segbuf->sb_nbio > 0 &&
-	    bdi_write_congested(segbuf->sb_super->s_bdi)) {
-		wait_for_completion(&segbuf->sb_bio_event);
-		segbuf->sb_nbio--;
-		if (unlikely(atomic_read(&segbuf->sb_err))) {
-			bio_put(bio);
-			err = -EIO;
-			goto failed;
-		}
-	}
-
 	bio->bi_end_io = nilfs_end_bio_write;
 	bio->bi_private = segbuf;
 	bio_set_op_attrs(bio, mode, mode_flags);
@@ -365,10 +354,6 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
 	wi->nr_vecs = min(wi->max_pages, wi->rest_blocks);
 	wi->start = wi->end;
 	return 0;
-
- failed:
-	wi->bio = NULL;
-	return err;
 }
 
 /**
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index b45e0d50a405..b7ebcfe6b8d3 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -843,9 +843,6 @@ xfs_buf_readahead_map(
 {
 	struct xfs_buf		*bp;
 
-	if (bdi_read_congested(target->bt_bdev->bd_disk->bdi))
-		return;
-
 	xfs_buf_read_map(target, map, nmaps,
 		     XBF_TRYLOCK | XBF_ASYNC | XBF_READ_AHEAD, &bp, ops,
 		     __this_address);
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 860b675c2929..2d764566280c 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -135,11 +135,6 @@ static inline bool writeback_in_progress(struct bdi_writeback *wb)
 
 struct backing_dev_info *inode_to_bdi(struct inode *inode);
 
-static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
-{
-	return wb->congested & cong_bits;
-}
-
 long congestion_wait(int sync, long timeout);
 
 static inline bool mapping_can_writeback(struct address_space *mapping)
@@ -391,27 +386,6 @@ static inline void wb_blkcg_offline(struct blkcg *blkcg)
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
-static inline int bdi_congested(struct backing_dev_info *bdi, int cong_bits)
-{
-	return wb_congested(&bdi->wb, cong_bits);
-}
-
-static inline int bdi_read_congested(struct backing_dev_info *bdi)
-{
-	return bdi_congested(bdi, 1 << WB_sync_congested);
-}
-
-static inline int bdi_write_congested(struct backing_dev_info *bdi)
-{
-	return bdi_congested(bdi, 1 << WB_async_congested);
-}
-
-static inline int bdi_rw_congested(struct backing_dev_info *bdi)
-{
-	return bdi_congested(bdi, (1 << WB_sync_congested) |
-				  (1 << WB_async_congested));
-}
-
 const char *bdi_dev_name(struct backing_dev_info *bdi);
 
 #endif	/* _LINUX_BACKING_DEV_H */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e38de6456cdc..5e1469887afa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2364,9 +2364,7 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
  */
 static int current_may_throttle(void)
 {
-	return !(current->flags & PF_LOCAL_THROTTLE) ||
-		current->backing_dev_info == NULL ||
-		bdi_write_congested(current->backing_dev_info);
+	return !(current->flags & PF_LOCAL_THROTTLE);
 }
 
 /*


