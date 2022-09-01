Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610C65A90E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiIAHoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiIAHnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:43:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171711264A7;
        Thu,  1 Sep 2022 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xsLsepdDzI92/2ENAfo4C5Xjkuy4xHWvAk9PUbduG/M=; b=vEsy/WwxjHl81dUC4T+ib9A5WG
        O+OA/hTvVc7qOewlAMaHxouFYT6JSAOfNAxw86BondRgWcyEUTUxV2O1Ej3DQUL4VDJYA9u9mJfhH
        SoFVlIAPnJLsh7Qy/eDtyEZnM2f/akRx+KpQBuIccRfcnocp+2G+aNpoTrvXE4hBA5Do4ZqHrb8tE
        uJIa+XE+qLHC6OhbUdzd8ETKoA8aMKhV5oJ/EOdhhFDELAv0/TS6Inl+YYYC7Hr3QsVvHZ73xkusi
        US17JEnxKK8OUEfZte+MBTgFFGvIpF1Nh9h0zBKBAubJzgpkC6/SBiOCoHNKzBpuMQqQ/Zfim2CoM
        xfUZdgAg==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTer3-00ANlX-DP; Thu, 01 Sep 2022 07:43:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/17] btrfs: remove submit_encoded_read_bio
Date:   Thu,  1 Sep 2022 10:42:12 +0300
Message-Id: <20220901074216.1849941-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901074216.1849941-1-hch@lst.de>
References: <20220901074216.1849941-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just opencode the functionality in the only caller and remove the
now superflous error handling there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 399381a4f8e69..25194e75c0812 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9990,17 +9990,6 @@ struct btrfs_encoded_read_private {
 	blk_status_t status;
 };
 
-static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
-					    struct bio *bio, int mirror_num)
-{
-	struct btrfs_encoded_read_private *priv = btrfs_bio(bio)->private;
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-
-	atomic_inc(&priv->pending);
-	btrfs_submit_bio(fs_info, bio, mirror_num);
-	return BLK_STS_OK;
-}
-
 static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 {
 	struct btrfs_encoded_read_private *priv = bbio->private;
@@ -10025,6 +10014,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  u64 file_offset, u64 disk_bytenr,
 					  u64 disk_io_size, struct page **pages)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_encoded_read_private priv = {
 		.inode = inode,
 		.file_offset = file_offset,
@@ -10055,14 +10045,8 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 
 			if (!bytes ||
 			    bio_add_page(bio, pages[i], bytes, 0) < bytes) {
-				blk_status_t status;
-
-				status = submit_encoded_read_bio(inode, bio, 0);
-				if (status) {
-					WRITE_ONCE(priv.status, status);
-					bio_put(bio);
-					goto out;
-				}
+				atomic_inc(&priv.pending);
+				btrfs_submit_bio(fs_info, bio, 0);
 				bio = NULL;
 				continue;
 			}
@@ -10073,7 +10057,6 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		}
 	}
 
-out:
 	if (atomic_dec_return(&priv.pending))
 		io_wait_event(priv.wait, !atomic_read(&priv.pending));
 	/* See btrfs_encoded_read_endio() for ordering. */
-- 
2.30.2

