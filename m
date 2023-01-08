Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2704E6616F6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 17:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjAHQ5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 11:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjAHQ5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:57:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4E15FCC;
        Sun,  8 Jan 2023 08:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BznR/4w1o26qgOdWpgaXoEzrG7xwT/5BaeqDtDNhkG0=; b=KycIApiWI5yISCZouDp8O8ipc4
        dsl/ueN8sUNA33Tp9c717pqGJ+DRYXWPrwamlDfC9ftc159YEu3rH4iisYVgqRu/w53sUAME1wPCf
        MTqnBKQrVKo99G/ggyD2TGlKA9HTNX06xjiq6D39LxRqspHtjdzrjwPj/R4YOGTbHKRoxYyqU+GgO
        hplk+/amqkkU5IiaF7B9o2QiTNtdVdmhnSylKAIJ1PkTIFxh3AiZkBHips001Vc6L9c4I1xFVKuNI
        30m27hquq2Q0Y5e4zNu+1vbMwCxkSGN7IoC06MseeAUTxFVjrgD8hhd2XQ2oWt/MRiFklab9eYZBQ
        21VcibDQ==;
Received: from [2001:4bb8:198:a591:1c7c:bf66:af15:b282] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEYyb-00ERql-3S; Sun, 08 Jan 2023 16:56:53 +0000
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
        linux-mm@kvack.org
Subject: [PATCH 2/7] btrfs: stop using write_one_page in btrfs_scratch_superblock
Date:   Sun,  8 Jan 2023 17:56:40 +0100
Message-Id: <20230108165645.381077-3-hch@lst.de>
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

write_one_page is an awkward interface that expects the page locked
and ->writepage to be implemented.  Just mark the sb dirty, put
the page and then call the proper bdev helper to sync the range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1378f5ad5ed4c4..10e98b004a2fa3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2009,23 +2009,22 @@ static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
 				     struct block_device *bdev, int copy_num)
 {
 	struct btrfs_super_block *disk_super;
-	struct page *page;
+	const size_t len = sizeof(disk_super->magic);
+	u64 bytenr = btrfs_sb_offset(copy_num);
 	int ret;
 
-	disk_super = btrfs_read_dev_one_super(bdev, copy_num, false);
+	disk_super = btrfs_read_disk_super(bdev, bytenr, bytenr);
 	if (IS_ERR(disk_super))
 		return;
-	memset(&disk_super->magic, 0, sizeof(disk_super->magic));
-	page = virt_to_page(disk_super);
-	set_page_dirty(page);
-	lock_page(page);
-	/* write_on_page() unlocks the page */
-	ret = write_one_page(page);
+	memset(&disk_super->magic, 0, len);
+	set_page_dirty(virt_to_page(disk_super));
+	btrfs_release_disk_super(disk_super);
+
+	ret = sync_blockdev_range(bdev, bytenr, bytenr + len - 1);
 	if (ret)
 		btrfs_warn(fs_info,
 			"error clearing superblock number %d (%d)",
 			copy_num, ret);
-	btrfs_release_disk_super(disk_super);
 }
 
 void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
-- 
2.35.1

