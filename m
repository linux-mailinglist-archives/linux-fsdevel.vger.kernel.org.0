Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8647B053F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjI0NV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 09:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjI0NVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:21:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99CB10A
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 06:21:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785CAC433C8;
        Wed, 27 Sep 2023 13:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695820909;
        bh=nA+pNkC2onY4V6wYGRls95uNWFt4sgRwu5dgcJrBK4E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=u74mEHwCoBksQvUjW7ZQ9Mc2ROZj0tnNeymv1MEteDYhhlNslW3TrEFqDJtNF/D2L
         SWMa+pfCPqDKTHXDN9Uk4JojEdcanGTseDKKmFSloqbn+RHECZXJBHAN14rlQzRVyG
         IbwAAg2xlK4VYyvS5ScS9YSs0nQX7hczPjl7l4heiXwdhLwtcmKNHjtTTKHWrkrHFc
         1XoHEtkjNBU8XNoEK+et/Pea7OumHqwaYfETGhACprYis+aVkpMUGWhU8e6PmzZdfE
         jr1yKwA59CsmeiHcXWa5XVy2vWqDI5bQ3srcWIVowYxOcLK76se24/DZ1ETknZWF62
         CMU6j4T45RUBQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 27 Sep 2023 15:21:18 +0200
Subject: [PATCH 5/7] super: remove bd_fsfreeze_{mutex,sb}
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-vfs-super-freeze-v1-5-ecc36d9ab4d9@kernel.org>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
In-Reply-To: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nA+pNkC2onY4V6wYGRls95uNWFt4sgRwu5dgcJrBK4E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSK6KS8299W5Xpgxt3qzgs1O5i+3FIQLmL/uGjajBzBgrS1
 VWEzO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS5Mfwvypp7yJJvU/vmtvr4nY8a2
 V5Y+WyTmbK+mWpqlXSBaVfHzIybPBjai79I3px5u0s28N+VT6Pcr/HX6mcpd+wLDllaaIIEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both bd_fsfreeze_mutex and bd_fsfreeze_sb are now unused and can be
removed. Also move bd_fsfreeze_count down to not have it weirdly placed
in the middle of the holder fields.

Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c              | 1 -
 include/linux/blk_types.h | 7 ++-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 3deccd0ffcf2..084855b669f7 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -392,7 +392,6 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	mapping_set_gfp_mask(&inode->i_data, GFP_USER);
 
 	bdev = I_BDEV(inode);
-	mutex_init(&bdev->bd_fsfreeze_mutex);
 	spin_lock_init(&bdev->bd_size_lock);
 	mutex_init(&bdev->bd_holder_lock);
 	bdev->bd_partno = partno;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 88e1848b0869..0238236852b7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -56,14 +56,11 @@ struct block_device {
 	void *			bd_holder;
 	const struct blk_holder_ops *bd_holder_ops;
 	struct mutex		bd_holder_lock;
-	/* The counter of freeze processes */
-	atomic_t		bd_fsfreeze_count;
 	int			bd_holders;
 	struct kobject		*bd_holder_dir;
 
-	/* Mutex for freeze */
-	struct mutex		bd_fsfreeze_mutex;
-	struct super_block	*bd_fsfreeze_sb;
+	/* The counter of freeze processes */
+	atomic_t		bd_fsfreeze_count;
 
 	struct partition_meta_info *bd_meta_info;
 #ifdef CONFIG_FAIL_MAKE_REQUEST

-- 
2.34.1

