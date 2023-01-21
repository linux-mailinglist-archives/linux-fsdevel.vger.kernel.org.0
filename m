Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20D4676463
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjAUGvd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjAUGv0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:51:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE2D6A300;
        Fri, 20 Jan 2023 22:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VxRoYjhUTiv/ewf6feEV137it+S9fKgV/tSL3xvlLn4=; b=nWuV6tFgjP2eLvZcYEywwQpqWr
        /VM85mrhzJ2wB3AxL4DM+wDn0ZNkfWJF8SqzVYrLQqYW9RD1ftljJtSnOK04+bb0xBWC6UxJyDZkp
        nrHoHUxLz3Faru6Z9dAIjsLO5hRQ1sAGz5FiLMlwgUbJ6WzYJjgHvIpJgTRirqkOwwc+31UH77S3o
        T60M8PrVh3IOaYKneYDnpl31HvuW+NXLe6Zjs1dmPr+veeuVz+Uuw331AqmVLM361xFDJwmOKwQod
        QxCyOskMcF6lITPYJpnbzWma67VFNjswESjkmSMqqfV71JrPaDqwQMuO3xwz+pPTObij2ruiyJoQg
        NiUpp9Wg==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7iY-00DRS3-U3; Sat, 21 Jan 2023 06:51:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/34] btrfs: remove the device field in struct btrfs_bio
Date:   Sat, 21 Jan 2023 07:50:11 +0100
Message-Id: <20230121065031.1139353-15-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121065031.1139353-1-hch@lst.de>
References: <20230121065031.1139353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The device field is only used by the simple end I/O handler, and for
that it can simply be stored in the bi_private field of the bio,
which is currently used for the fs_info that can be retreived through
bbio->inode as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c | 10 +++++-----
 fs/btrfs/bio.h |  2 --
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index cdee76e3a6121a..e32a2dac97c541 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -266,18 +266,19 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	if (bbio->bio.bi_opf & REQ_META)
 		bbio->end_io(bbio);
 	else
-		btrfs_check_read_bio(bbio, bbio->device);
+		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
 }
 
 static void btrfs_simple_end_io(struct bio *bio)
 {
-	struct btrfs_fs_info *fs_info = bio->bi_private;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct btrfs_device *dev = bio->bi_private;
+	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
 
 	btrfs_bio_counter_dec(fs_info);
 
 	if (bio->bi_status)
-		btrfs_log_dev_io_error(bio, bbio->device);
+		btrfs_log_dev_io_error(bio, dev);
 
 	if (bio_op(bio) == REQ_OP_READ) {
 		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
@@ -443,9 +444,8 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 	if (!bioc) {
 		/* Single mirror read/write fast path */
 		bbio->mirror_num = mirror_num;
-		bbio->device = smap.dev;
 		bio->bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
-		bio->bi_private = fs_info;
+		bio->bi_private = smap.dev;
 		bio->bi_end_io = btrfs_simple_end_io;
 		btrfs_submit_dev_bio(smap.dev, bio);
 	} else if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 2e799c3348d5a6..61a791cf5360f3 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -45,8 +45,6 @@ struct btrfs_bio {
 	struct btrfs_inode *inode;
 	u64 file_offset;
 
-	/* @device is for stripe IO submission. */
-	struct btrfs_device *device;
 	union {
 		/* For data checksum verification. */
 		struct {
-- 
2.39.0

