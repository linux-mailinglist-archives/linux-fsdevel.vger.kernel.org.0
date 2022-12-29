Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DEB658A50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 09:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiL2IOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 03:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiL2INU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:13:20 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8265E10060
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:11 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9so1537459pll.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tknTAYGKiWbOelfCTGAIM4O7q8g3LJuucBsJtaWsm7Y=;
        b=od6vH7qllnsXef6M4SnGIOrNBwpv4p//RiTi9UhMGK3lxP1a2K3Nm1uXz7ssRR+Smi
         wUthhRevFt0NOvSr6D9fSLI7kuMeJffcI62x3q63JgaiPRtoRmo7cT9cQcEV1/CPgE3M
         gaDQE3uH/ZWruLOhIAciPanxs5Ham7RNijdIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tknTAYGKiWbOelfCTGAIM4O7q8g3LJuucBsJtaWsm7Y=;
        b=FFfZoqVCBK7imEYvWCqoH9x+ZRh//+Wxa6nnQx9u2tRFOPOTrMolsSiUIvb3fj4vXk
         0F0sTtB+oqzPqDxs0vKz5W3fNiB3XT8+ZDCWyluzqlrz9wiMl2awuneL6hkvrSbYjGIh
         +U9aXCShI3S38SsVvn49OiPbRT+He7w2yc4R3+XhTNNnxmsH6zgPpzHfNrqc+iQmTFVO
         lqiUaa0l/T8ck1rywzd7jjKRLZXHbgK7cEVhaPkfqV5B+xP9+Q1ayZWA7iF/OGMdYqZo
         RLe4evK1WVblwqd6Q2QUZKYbYN9977aUKVVCeqe1nNHxxnMQCLsdwJ20+zZUf4AiZMhm
         Y9lg==
X-Gm-Message-State: AFqh2kqEapcXYG0nulO4fuFAn/1309Q+tu0Gcun3Giu/imN5sLsLb8LD
        ya6gjqdIRBQathpDFEH3ATSRag==
X-Google-Smtp-Source: AMrXdXtym0rxjHIaY1zQhiKiElSe51N0oXHJB0JFxm27wv3KTRxbF3edYhG2fNv1/xvRbhTy3gkDbA==
X-Received: by 2002:a17:902:c94f:b0:189:9e91:762e with SMTP id i15-20020a170902c94f00b001899e91762emr45014676pla.57.1672301590739;
        Thu, 29 Dec 2022 00:13:10 -0800 (PST)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:75ff:1277:3d7b:d67a])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b00192820d00d0sm6496325plk.120.2022.12.29.00.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:13:10 -0800 (PST)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 5/7] ext4: Add support for FALLOC_FL_PROVISION
Date:   Thu, 29 Dec 2022 00:12:50 -0800
Message-Id: <20221229081252.452240-6-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221229081252.452240-1-sarthakkukreti@chromium.org>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Once ext4 is done mapping blocks for an fallocate() request, send
out an FALLOC_FL_PROVISION request to the underlying layer to
ensure that the space is provisioned for the newly allocated extent
or indirect blocks.

There is an expected performance degradation with fallocate() calls made
with this flag due to the extra REQ_OP_PROVISIONs sent to the underlying
storage.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 fs/ext4/ext4.h         |  2 ++
 fs/ext4/extents.c      | 15 ++++++++++++++-
 fs/ext4/indirect.c     |  9 +++++++++
 include/linux/blkdev.h | 11 +++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 140e1eb300d1..49832e90b62f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -673,6 +673,8 @@ enum {
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
 	/* Caller is in the atomic contex, find extent if it has been cached */
 #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
+	/* Provision blocks on underlying storage */
+#define EXT4_GET_BLOCKS_PROVISION		0x1000
 
 /*
  * The bit position of these flags must not overlap with any of the
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9de1c9d1a13d..2e64a9211792 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4361,6 +4361,13 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		}
 	}
 
+	/* Attempt to provision blocks on underlying storage */
+	if (flags & EXT4_GET_BLOCKS_PROVISION) {
+		err = sb_issue_provision(inode->i_sb, pblk, ar.len, GFP_NOFS);
+		if (err)
+			goto out;
+	}
+
 	/*
 	 * Cache the extent and update transaction to commit on fdatasync only
 	 * when it is _not_ an unwritten extent.
@@ -4694,7 +4701,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	/* Return error if mode is not supported */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
-		     FALLOC_FL_INSERT_RANGE))
+		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_PROVISION))
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
@@ -4754,6 +4761,12 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (ret)
 		goto out;
 
+	/* Ensure that preallocation provisions the blocks on the underlying
+	 * storage device.
+	 */
+	if (mode & FALLOC_FL_PROVISION)
+		flags |= EXT4_GET_BLOCKS_PROVISION;
+
 	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
 	if (ret)
 		goto out;
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index c68bebe7ff4b..a8065aae7563 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -647,6 +647,15 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	if (err)
 		goto cleanup;
 
+	/* Attempt to provision blocks on underlying storage */
+	if (flags & EXT4_GET_BLOCKS_PROVISION) {
+		err = sb_issue_provision(inode->i_sb,
+					 le32_to_cpu(chain[depth-1].key),
+					 ar.len, GFP_NOFS);
+		if (err)
+			goto out;
+	}
+
 	map->m_flags |= EXT4_MAP_NEW;
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f1abc7b43e25..b2e3244e9f3d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1093,6 +1093,17 @@ static inline int sb_issue_zeroout(struct super_block *sb, sector_t block,
 				    gfp_mask, 0);
 }
 
+static inline int sb_issue_provision(struct super_block *sb, sector_t block,
+		sector_t nr_blocks, gfp_t gfp_mask)
+{
+	return blkdev_issue_provision(sb->s_bdev,
+				      block << (sb->s_blocksize_bits -
+					      SECTOR_SHIFT),
+				      nr_blocks << (sb->s_blocksize_bits -
+						    SECTOR_SHIFT),
+				      gfp_mask);
+}
+
 static inline bool bdev_is_partition(struct block_device *bdev)
 {
 	return bdev->bd_partno;
-- 
2.37.3

