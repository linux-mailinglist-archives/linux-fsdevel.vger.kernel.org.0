Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0937F666DC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 10:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbjALJMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 04:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbjALJK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:10:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9C152C79;
        Thu, 12 Jan 2023 01:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MR19TXb0gmG8o2lfg9y/ShVQLOAVD9gKAIrPpnBx2Is=; b=wSAdDCMexCBAImNHrkePpp0YCB
        cHMyv/ufF5HPRQbvfMWzqFjywNyzvvRNpSCOm0K9McS/CiP+A10NNVJ7gpJNW2pJcU2QlVFkwkMUW
        ixmxKhH6PRbfn3gyds43eU3WLMmcSuZI2j/J9uyLQrERlBwzkjs9YAoTcQRoi8lgdZDhpoRZTAQtC
        83H/v+a0TX3/bhhm3+IwhcFm/niyxCzD6iP3iEPEley7Jy9Jptn4NYmoML/sa6ZvC8Je4nRPy6Ca0
        hdym+4Docj5LA9DGxONPCLJh4ZThJEMsZVy/uLfK0XDJbELj4lFNPDynaeiD4RDRuKbdCKXH2SdtP
        SB09wifQ==;
Received: from [2001:4bb8:181:656b:c87d:36c9:914c:c2ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFtXL-00EGUL-VM; Thu, 12 Jan 2023 09:06:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/19] btrfs: remove submit_encoded_read_bio
Date:   Thu, 12 Jan 2023 10:05:26 +0100
Message-Id: <20230112090532.1212225-15-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230112090532.1212225-1-hch@lst.de>
References: <20230112090532.1212225-1-hch@lst.de>
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

Just opencode the functionality in the only caller and remove the
now superfluous error handling there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 74a2e7bac4abdc..606fcd0b111e65 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9935,17 +9935,6 @@ struct btrfs_encoded_read_private {
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
@@ -9970,6 +9959,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  u64 file_offset, u64 disk_bytenr,
 					  u64 disk_io_size, struct page **pages)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_encoded_read_private priv = {
 		.inode = inode,
 		.file_offset = file_offset,
@@ -10000,14 +9990,8 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 
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
@@ -10018,7 +10002,6 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		}
 	}
 
-out:
 	if (atomic_dec_return(&priv.pending))
 		io_wait_event(priv.wait, !atomic_read(&priv.pending));
 	/* See btrfs_encoded_read_endio() for ordering. */
-- 
2.35.1

