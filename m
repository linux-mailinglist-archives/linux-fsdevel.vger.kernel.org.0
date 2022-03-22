Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4174E43A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbiCVP7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiCVP6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290756E7A5;
        Tue, 22 Mar 2022 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AetGpHeghZdfq9ng75caYNldl/gBZBMQ0vqYTIEPCAw=; b=16cqGlybM4PkfDAmaCr2Pqehia
        OSpdlHSKcOi5tDBbjcEXdqpTXhvaz5kKdTqnoXndT+MRmmK0cVCT4QpdjRPDL9nYfrgeWIAokepv6
        scHlXKPlb2Qzq3ZYYOS1Yehnv612P1qQR7V5Es+pTkrQFFa2TwjOpmNbjRwsT0dpWsyKScMbLqpVj
        qgQrWrJu4cYNZQuEYTPfkiOmkdPxldKc+9XYrXCXKOeHkh+4pnhPwm6w5+rYl+fE4mlaTY1RRGT72
        V9WXp2WIdaok6sPb+Ih3dPZq2g7IIC6gRYg1sTPUO159Prn5BJmSSqnUmj+r0E2MryQgziHI315do
        EGXICd6w==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgso-00BayP-GZ; Tue, 22 Mar 2022 15:57:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 27/40] btrfs: clean up the raid map handling __btrfs_map_block
Date:   Tue, 22 Mar 2022 16:55:53 +0100
Message-Id: <20220322155606.1267165-28-hch@lst.de>
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

Clear need_raid_map early instead of repeating the same conditional over
and over.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 60 ++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cf0914b33847..cc9e2565e4b64 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6435,6 +6435,10 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	map = em->map_lookup;
 
+	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) ||
+	    (!need_full_stripe(op) && mirror_num <= 1))
+		need_raid_map = 0;
+
 	*length = geom.len;
 	stripe_len = geom.stripe_len;
 	stripe_nr = geom.stripe_nr;
@@ -6509,37 +6513,32 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 					      dev_replace_is_ongoing);
 			mirror_num = stripe_index - old_stripe_index + 1;
 		}
+	} else if (need_raid_map) {
+		/* push stripe_nr back to the start of the full stripe */
+		stripe_nr = div64_u64(raid56_full_stripe_start,
+				      stripe_len * data_stripes);
 
-	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		if (need_raid_map && (need_full_stripe(op) || mirror_num > 1)) {
-			/* push stripe_nr back to the start of the full stripe */
-			stripe_nr = div64_u64(raid56_full_stripe_start,
-					stripe_len * data_stripes);
-
-			/* RAID[56] write or recovery. Return all stripes */
-			num_stripes = map->num_stripes;
-			max_errors = nr_parity_stripes(map);
-
-			*length = map->stripe_len;
-			stripe_index = 0;
-			stripe_offset = 0;
-		} else {
-			/*
-			 * Mirror #0 or #1 means the original data block.
-			 * Mirror #2 is RAID5 parity block.
-			 * Mirror #3 is RAID6 Q block.
-			 */
-			stripe_nr = div_u64_rem(stripe_nr,
-					data_stripes, &stripe_index);
-			if (mirror_num > 1)
-				stripe_index = data_stripes + mirror_num - 2;
+		/* RAID[56] write or recovery. Return all stripes */
+		num_stripes = map->num_stripes;
+		max_errors = nr_parity_stripes(map);
 
-			/* We distribute the parity blocks across stripes */
-			div_u64_rem(stripe_nr + stripe_index, map->num_stripes,
-					&stripe_index);
-			if (!need_full_stripe(op) && mirror_num <= 1)
-				mirror_num = 1;
-		}
+		*length = map->stripe_len;
+		stripe_index = 0;
+		stripe_offset = 0;
+	} else if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		/*
+		 * Mirror #0 or #1 means the original data block.
+		 * Mirror #2 is RAID5 parity block.
+		 * Mirror #3 is RAID6 Q block.
+		 */
+		stripe_nr = div_u64_rem(stripe_nr, data_stripes, &stripe_index);
+		if (mirror_num > 1)
+			stripe_index = data_stripes + mirror_num - 2;
+		/* We distribute the parity blocks across stripes */
+		div_u64_rem(stripe_nr + stripe_index, map->num_stripes,
+			    &stripe_index);
+		if (!need_full_stripe(op) && mirror_num <= 1)
+			mirror_num = 1;
 	} else {
 		/*
 		 * after this, stripe_nr is the number of stripes on this
@@ -6581,8 +6580,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	}
 
 	/* Build raid_map */
-	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK && need_raid_map &&
-	    (need_full_stripe(op) || mirror_num > 1)) {
+	if (need_raid_map) {
 		u64 tmp;
 		unsigned rot;
 
-- 
2.30.2

