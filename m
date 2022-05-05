Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C551CA5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 22:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385737AbiEEUPj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385733AbiEEUPb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 16:15:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7255F8EB;
        Thu,  5 May 2022 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Fo858EZ24RtCWgP5iiuyw7PCY4Ku4LcL8vFcHP9Ktg4=; b=PdzWesLjuyOXtqCS17xCBEazqs
        FUKQH0yVQSXMnPE2ZQpPtgm4xx41/qyMl6Rg7X2ApKU4SJlKr3Zbw2Ighrfd3zgpl14vEnSPkzSvJ
        8HWq62YZphEU40ive083QPsqQY348LXJ6V/0/hiK50+vXr+rwR79u4yzTwLff9vk5H7d9r/HliHS6
        Q4ZHpPw/BGLBz7KsKi72MjnwvdHeem48CV6nAKhW3H/e8yFeREzY40UrhzQEQ5O3/lbjJLM8Xa19Y
        6mcN2TS1Dgg1ovtSf15GEy1BMAkg/ArQI77RVamnOSV6BJer+pZijJqVs1mAMPCVRHlWKiafzaAwu
        YLb1u6GA==;
Received: from 65-114-90-19.dia.static.qwest.net ([65.114.90.19] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmhou-0006ln-Oc; Thu, 05 May 2022 20:11:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] btrfs: move struct btrfs_dio_private to inode.c
Date:   Thu,  5 May 2022 15:11:14 -0500
Message-Id: <20220505201115.937837-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220505201115.937837-1-hch@lst.de>
References: <20220505201115.937837-1-hch@lst.de>
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

The btrfs_dio_private structure is only used in inode.c, so move the
definition there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h | 24 ------------------------
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/inode.c       | 24 ++++++++++++++++++++++++
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 14c28213ca0d3..33811e896623f 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -395,30 +395,6 @@ static inline bool btrfs_inode_can_compress(const struct btrfs_inode *inode)
 	return true;
 }
 
-struct btrfs_dio_private {
-	struct inode *inode;
-
-	/*
-	 * Since DIO can use anonymous page, we cannot use page_offset() to
-	 * grab the file offset, thus need a dedicated member for file offset.
-	 */
-	u64 file_offset;
-	/* Used for bio::bi_size */
-	u32 bytes;
-
-	/*
-	 * References to this structure. There is one reference per in-flight
-	 * bio plus one while we're still setting up.
-	 */
-	refcount_t refs;
-
-	/* dio_bio came from fs/direct-io.c */
-	struct bio *dio_bio;
-
-	/* Array of checksums */
-	u8 csums[];
-};
-
 /*
  * btrfs_inode_item stores flags in a u64, btrfs_inode stores them in two
  * separate u32s. These two functions convert between the two representations.
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aa6e71fdc72b9..fa64323c453f5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3217,7 +3217,6 @@ int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
 int btrfs_find_orphan_item(struct btrfs_root *root, u64 offset);
 
 /* file-item.c */
-struct btrfs_dio_private;
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, u64 bytenr, u64 len);
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b1c0c7da6411c..edccfc5889e6c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -68,6 +68,30 @@ struct btrfs_dio_data {
 	bool nocow_done;
 };
 
+struct btrfs_dio_private {
+	struct inode *inode;
+
+	/*
+	 * Since DIO can use anonymous page, we cannot use page_offset() to
+	 * grab the file offset, thus need a dedicated member for file offset.
+	 */
+	u64 file_offset;
+	/* Used for bio::bi_size */
+	u32 bytes;
+
+	/*
+	 * References to this structure. There is one reference per in-flight
+	 * bio plus one while we're still setting up.
+	 */
+	refcount_t refs;
+
+	/* dio_bio came from fs/direct-io.c */
+	struct bio *dio_bio;
+
+	/* Array of checksums */
+	u8 csums[];
+};
+
 struct btrfs_rename_ctx {
 	/* Output field. Stores the index number of the old directory entry. */
 	u64 index;
-- 
2.30.2

