Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8EA4E4368
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiCVP5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiCVP5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:57:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2214F4AE31;
        Tue, 22 Mar 2022 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DfMLpgbWXSZ2b4vFUaEdRoG+5JU7Mp6YxCyLTgziDHA=; b=e8tsqELicCbxSPhND0pe2+XR8j
        ZCtYXtUcFsReHQGLFBOhLKYVEgbuxsQX7eNw+GhbMTM/x4k/dSkB/vc3AE2vb92yQSch4QbbFY71L
        qGbHP0KocW1aK6gWZM4v/2oWH4nYB/QxXCW45Bhao0miGMv8mIA1LIVH3KTYATS0uBGEbcnzwhLye
        uUPhhfTDGLhYLmUvNdxZb+1yWM349fi0dE3eBA/CPXp4E5CpPqUFw5l+iQc4D9NZtwiWYf3ICoxZL
        /JORJkghikLWHgOgPCw+Nz1ZnKKV+xi/m8owgZDatbTsfwW4riwH2j6ewdsic0b4sB+1RYN2c0IwH
        fU3b4YBA==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgrj-00BabU-JU; Tue, 22 Mar 2022 15:56:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/40] btrfs: fix submission hook error handling in btrfs_repair_one_sector
Date:   Tue, 22 Mar 2022 16:55:27 +0100
Message-Id: <20220322155606.1267165-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs_repair_one_sector just wants to free the bio if submit_bio_hook
fails, but btrfs_submit_data_bio will call bio_endio which will call
into the submitter of the original bio and free the bio there as well.

Move the bio_endio calls from btrfs_submit_data_bio and
btrfs_submit_metadata_bio into submit_one_bio to fix this double free.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c   | 2 --
 fs/btrfs/extent_io.c | 4 ++++
 fs/btrfs/inode.c     | 4 ----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b3e9cf3fd1dd1..c245e1b131964 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -941,8 +941,6 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 	return 0;
 
 out_w_error:
-	bio->bi_status = ret;
-	bio_endio(bio);
 	return ret;
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3b386bbb85a7f..e9fa0f6d605ee 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -181,6 +181,10 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 		ret = btrfs_submit_metadata_bio(tree->private_data, bio,
 						mirror_num, bio_flags);
 
+	if (ret) {
+		bio->bi_status = ret;
+		bio_endio(bio);
+	}
 	return blk_status_to_errno(ret);
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5bbea5ec31fc5..3ef8b63bb1b5c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2571,10 +2571,6 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 	ret = btrfs_map_bio(fs_info, bio, mirror_num);
 
 out:
-	if (ret) {
-		bio->bi_status = ret;
-		bio_endio(bio);
-	}
 	return ret;
 }
 
-- 
2.30.2

