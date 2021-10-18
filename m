Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D027E43148C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhJRKOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 06:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhJRKOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:14:14 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABBEC061714;
        Mon, 18 Oct 2021 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1gZf+H891s0ly+N+We+WSsOR96hNSH99XqMkm5gKgvI=; b=zwzQ5L7ESlfExe+abASqVs43QL
        14sEjm/o9bFg/y0KSbqRDAxHJqmS4yGssuMp+LyXmNnjfcWzNr3D0bQp93tQrlA6HkhUX0i+7XFzV
        pjiq6/lIz2bQIxMCAcKipcbCQiFvH0PiCliLLklv89Z7CRh+wLNy7iZUG7ujwhnm7KmgUd+UR04k+
        ZsiFETxE1JvEzxCP3lwYqkXQjse4ecAKqhVmb0XvRxVnOiiydnUb0yUKp19jSW+wfZzckyBEFgMsT
        3exDroYOhR3AggEtDC205WWO8KggW7COLbBVf+5Wlm/6j5ESNehLdtPVc/ZITyhL0Z2HlREFjp2I9
        1hLhr7eQ==;
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcPcT-00Eu4B-82; Mon, 18 Oct 2021 10:11:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: [PATCH 06/30] md: use bdev_nr_sectors instead of open coding it
Date:   Mon, 18 Oct 2021 12:11:06 +0200
Message-Id: <20211018101130.1838532-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
References: <20211018101130.1838532-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Song Liu <song@kernel.org>
---
 drivers/md/md.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ec09083ff0eff..0c75ba047ef60 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -890,8 +890,7 @@ static struct md_personality *find_pers(int level, char *clevel)
 /* return the offset of the super block in 512byte sectors */
 static inline sector_t calc_dev_sboffset(struct md_rdev *rdev)
 {
-	sector_t num_sectors = i_size_read(rdev->bdev->bd_inode) / 512;
-	return MD_NEW_SIZE_SECTORS(num_sectors);
+	return MD_NEW_SIZE_SECTORS(bdev_nr_sectors(rdev->bdev));
 }
 
 static int alloc_disk_sb(struct md_rdev *rdev)
@@ -1633,8 +1632,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	 */
 	switch(minor_version) {
 	case 0:
-		sb_start = i_size_read(rdev->bdev->bd_inode) >> 9;
-		sb_start -= 8*2;
+		sb_start = bdev_nr_sectors(rdev->bdev) - 8 * 2;
 		sb_start &= ~(sector_t)(4*2-1);
 		break;
 	case 1:
@@ -1789,10 +1787,9 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 		else
 			ret = 0;
 	}
-	if (minor_version) {
-		sectors = (i_size_read(rdev->bdev->bd_inode) >> 9);
-		sectors -= rdev->data_offset;
-	} else
+	if (minor_version)
+		sectors = bdev_nr_sectors(rdev->bdev) - rdev->data_offset;
+	else
 		sectors = rdev->sb_start;
 	if (sectors < le64_to_cpu(sb->data_size))
 		return -EINVAL;
@@ -2170,8 +2167,7 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 		return 0; /* too confusing */
 	if (rdev->sb_start < rdev->data_offset) {
 		/* minor versions 1 and 2; superblock before data */
-		max_sectors = i_size_read(rdev->bdev->bd_inode) >> 9;
-		max_sectors -= rdev->data_offset;
+		max_sectors = bdev_nr_sectors(rdev->bdev) - rdev->data_offset;
 		if (!num_sectors || num_sectors > max_sectors)
 			num_sectors = max_sectors;
 	} else if (rdev->mddev->bitmap_info.offset) {
@@ -2180,7 +2176,7 @@ super_1_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 	} else {
 		/* minor version 0; superblock after data */
 		sector_t sb_start, bm_space;
-		sector_t dev_size = i_size_read(rdev->bdev->bd_inode) >> 9;
+		sector_t dev_size = bdev_nr_sectors(rdev->bdev);
 
 		/* 8K is for superblock */
 		sb_start = dev_size - 8*2;
@@ -3384,7 +3380,7 @@ rdev_size_store(struct md_rdev *rdev, const char *buf, size_t len)
 			if (!sectors)
 				return -EBUSY;
 		} else if (!sectors)
-			sectors = (i_size_read(rdev->bdev->bd_inode) >> 9) -
+			sectors = bdev_nr_sectors(rdev->bdev) -
 				rdev->data_offset;
 		if (!my_mddev->pers->resize)
 			/* Cannot change size for RAID0 or Linear etc */
@@ -3711,7 +3707,7 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 
 	kobject_init(&rdev->kobj, &rdev_ktype);
 
-	size = i_size_read(rdev->bdev->bd_inode) >> BLOCK_SIZE_BITS;
+	size = bdev_nr_bytes(rdev->bdev) >> BLOCK_SIZE_BITS;
 	if (!size) {
 		pr_warn("md: %s has zero or unknown size, marking faulty!\n",
 			bdevname(rdev->bdev,b));
@@ -6882,7 +6878,7 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
 
 		if (!mddev->persistent) {
 			pr_debug("md: nonpersistent superblock ...\n");
-			rdev->sb_start = i_size_read(rdev->bdev->bd_inode) / 512;
+			rdev->sb_start = bdev_nr_sectors(rdev->bdev);
 		} else
 			rdev->sb_start = calc_dev_sboffset(rdev);
 		rdev->sectors = rdev->sb_start;
@@ -6969,7 +6965,7 @@ static int hot_add_disk(struct mddev *mddev, dev_t dev)
 	if (mddev->persistent)
 		rdev->sb_start = calc_dev_sboffset(rdev);
 	else
-		rdev->sb_start = i_size_read(rdev->bdev->bd_inode) / 512;
+		rdev->sb_start = bdev_nr_sectors(rdev->bdev);
 
 	rdev->sectors = rdev->sb_start;
 
-- 
2.30.2

