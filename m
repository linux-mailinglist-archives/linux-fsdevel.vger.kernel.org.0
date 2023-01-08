Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212B56616F9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 17:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbjAHQ5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 11:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjAHQ5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:57:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17FE2BD3;
        Sun,  8 Jan 2023 08:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lFvtQi+fLwMAHlLvXJj+xcXbU2gUQgSohjqo1SaHtyU=; b=oCh8q89awjYtytoZeT3pHyKMkl
        VyT99nkn9BUuSEHliHPt62EP8SCxWjNrcNLmisEoaHMhYjJ8blEV2oOQjss2Be8g/xEE9Xu6T3NXp
        cX2D3XC22yjMYecCu3dMuigB7G2U+YrmmMECKpaqBwx1GZ7mj3KW96NRON6fZ4NNOhhoCXma7S6jX
        kwHVVTH7ntlpydXJw1owjb0dtlCOQp1u4Psodi/w/rAdX6DMMVmMLise2oRJNsVxC9vWRy+Myt95+
        CvWwxs1xVejbXQVUEiHnuz2WHplf41pBViKOvH7DT3UKkzeh0LnVga9cr6PVhw5F/KrNlu4CexH4y
        TUx1FMmw==;
Received: from [2001:4bb8:198:a591:1c7c:bf66:af15:b282] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEYyY-00ERqS-AO; Sun, 08 Jan 2023 16:56:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/7] btrfs: don't read the disk superblock for zoned devices in btrfs_scratch_superblocks
Date:   Sun,  8 Jan 2023 17:56:39 +0100
Message-Id: <20230108165645.381077-2-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230108165645.381077-1-hch@lst.de>
References: <20230108165645.381077-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For zoned devices, btrfs_scratch_superblocks just resets the sb zones,
which means there is no need to even read the previous superblock.
Split the code to read, zero and write the superblock for conventional
devices into a separate helper so that it isn't called for zoned
devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 51 +++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index aa25fa335d3ed1..1378f5ad5ed4c4 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2005,42 +2005,43 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
 	return num_devices;
 }
 
+static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
+				     struct block_device *bdev, int copy_num)
+{
+	struct btrfs_super_block *disk_super;
+	struct page *page;
+	int ret;
+
+	disk_super = btrfs_read_dev_one_super(bdev, copy_num, false);
+	if (IS_ERR(disk_super))
+		return;
+	memset(&disk_super->magic, 0, sizeof(disk_super->magic));
+	page = virt_to_page(disk_super);
+	set_page_dirty(page);
+	lock_page(page);
+	/* write_on_page() unlocks the page */
+	ret = write_one_page(page);
+	if (ret)
+		btrfs_warn(fs_info,
+			"error clearing superblock number %d (%d)",
+			copy_num, ret);
+	btrfs_release_disk_super(disk_super);
+}
+
 void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 			       struct block_device *bdev,
 			       const char *device_path)
 {
-	struct btrfs_super_block *disk_super;
 	int copy_num;
 
 	if (!bdev)
 		return;
 
 	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX; copy_num++) {
-		struct page *page;
-		int ret;
-
-		disk_super = btrfs_read_dev_one_super(bdev, copy_num, false);
-		if (IS_ERR(disk_super))
-			continue;
-
-		if (bdev_is_zoned(bdev)) {
+		if (bdev_is_zoned(bdev))
 			btrfs_reset_sb_log_zones(bdev, copy_num);
-			continue;
-		}
-
-		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
-
-		page = virt_to_page(disk_super);
-		set_page_dirty(page);
-		lock_page(page);
-		/* write_on_page() unlocks the page */
-		ret = write_one_page(page);
-		if (ret)
-			btrfs_warn(fs_info,
-				"error clearing superblock number %d (%d)",
-				copy_num, ret);
-		btrfs_release_disk_super(disk_super);
-
+		else
+			btrfs_scratch_superblock(fs_info, bdev, copy_num);
 	}
 
 	/* Notify udev that device has changed */
-- 
2.35.1

