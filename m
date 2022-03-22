Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D054E4385
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbiCVP5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbiCVP5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:57:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7C360CC9;
        Tue, 22 Mar 2022 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=injaVrOJ8h3U+R9HCkyDDXAbxZC09lGNVRrP8XP7APo=; b=MlttcE87AsVlpYZiw5gkgR5CD1
        GRj26tdFyw+BSxce8EmXO2sWtx5Eqw25iTcgBlVA+80NqoXwQToZ6YWtZG6xw4/NqMDTrswF15b7P
        DOuYWlg25hGlRTejF2Xjbh+10eO6XUrah6eL9xLcJWf0sb8mbAWXKbCJsCpCE4k1Fe7v0YJ0vp4qL
        CreD8g7n6niqcgXCJ3Mi3v4HO0sJjtaWyjL3/hcRPAJ9DdSdf6HSXsHlPVQpv+ca9LwVeWi2uLH7r
        pFCyYe4dUz7945k75V6jfXQYOqV5LwhrjQ5BkLWnw6lY5oCeMpIJ0uFIizwiYhOJSQWNNadukLvfE
        GJ3t4pRQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgro-00BacC-MO; Tue, 22 Mar 2022 15:56:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/40] btrfs: fix direct I/O writes for split bios on zoned devices
Date:   Tue, 22 Mar 2022 16:55:29 +0100
Message-Id: <20220322155606.1267165-4-hch@lst.de>
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

When a bio is split in btrfs_submit_direct, dip->file_offset contains
the file offset for the first bio.  But this means the start value used
in btrfs_end_dio_bio to record the write location for zone devices is
icorrect for subsequent bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 93f00e9150ed0..325e773c6e880 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7829,6 +7829,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
 static void btrfs_end_dio_bio(struct bio *bio)
 {
 	struct btrfs_dio_private *dip = bio->bi_private;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
 	blk_status_t err = bio->bi_status;
 
 	if (err)
@@ -7839,12 +7840,12 @@ static void btrfs_end_dio_bio(struct bio *bio)
 			   bio->bi_iter.bi_size, err);
 
 	if (bio_op(bio) == REQ_OP_READ)
-		err = btrfs_check_read_dio_bio(dip, btrfs_bio(bio), !err);
+		err = btrfs_check_read_dio_bio(dip, bbio, !err);
 
 	if (err)
 		dip->dio_bio->bi_status = err;
 
-	btrfs_record_physical_zoned(dip->inode, dip->file_offset, bio);
+	btrfs_record_physical_zoned(dip->inode, bbio->file_offset, bio);
 
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
-- 
2.30.2

