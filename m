Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5467643F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjAUGuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjAUGuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:50:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3FB60C95;
        Fri, 20 Jan 2023 22:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=O8USaJHAU//9m1wczJHqIG1xYpMUBAw2bGq2kHbbz24=; b=Cf/O67HZQrFVDyUDuEJSNTjmAt
        pTt9We0MGFRQnxmnyd27oPbRo7lVvhwyxfNpW5BPv1pd+xZbT7CPB1DCbmbf4x7H7Orx1Sr9N3bF8
        KjkIbO2q002tYHuanYLRw0BUwwG1yCmkewDv6Rpj+ysDCiZDmw2Ka/NI32qJXatdhVCHj+fP26U3A
        vO9c2rYu310i0i1BLNAIkXtHeeEkGVgYc1SNH7aPLG12tdgPSdpcohF94IeFlM43OOHJABZ+ciICe
        DSUjoXnQNFMjsuY7KpKQlB/8pdDp2t2fJrGND2IED5e+hNcdRdzfngDbudtHrIBh7nGjWoNb6KTGa
        i2rQWtEQ==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7i3-00DRFg-3S; Sat, 21 Jan 2023 06:50:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/34] btrfs: better document struct btrfs_bio
Date:   Sat, 21 Jan 2023 07:49:59 +0100
Message-Id: <20230121065031.1139353-3-hch@lst.de>
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

Update the comments on btrfs_bio to better describe the structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index b12f84b3b3410f..baaa27961cc812 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -26,9 +26,8 @@ struct btrfs_fs_info;
 typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
 
 /*
- * Additional info to pass along bio.
- *
- * Mostly for btrfs specific features like csum and mirror_num.
+ * Highlevel btrfs I/O structure.  It is allocated by btrfs_bio_alloc and
+ * passed to btrfs_submit_bio for mapping to the physical devices.
  */
 struct btrfs_bio {
 	unsigned int mirror_num:7;
@@ -42,7 +41,7 @@ struct btrfs_bio {
 	unsigned int is_metadata:1;
 	struct bvec_iter iter;
 
-	/* for direct I/O */
+	/* File offset that this I/O operates on. */
 	u64 file_offset;
 
 	/* @device is for stripe IO submission. */
@@ -62,7 +61,7 @@ struct btrfs_bio {
 	btrfs_bio_end_io_t end_io;
 	void *private;
 
-	/* For read end I/O handling */
+	/* For internal use in read end I/O handling */
 	struct work_struct end_io_work;
 
 	/*
-- 
2.39.0

