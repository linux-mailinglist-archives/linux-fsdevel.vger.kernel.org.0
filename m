Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A60528B2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbiEPQyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244324AbiEPQy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:29 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44FD27B39
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:23 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165422euoutp01d3e4a39c45528af125ee5878913c276b~vpCPeo3rk2836328363euoutp01J
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220516165422euoutp01d3e4a39c45528af125ee5878913c276b~vpCPeo3rk2836328363euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720062;
        bh=lp2K3w6bYU/ZGZyfjOrT9sOG4NQYsIr+x+HLsdgsemk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gao6kZNXJCA2SyuQGlCnltENjf2JuoRrXfzpZ9zap0nqz68eWU+dTIb+g2u01N8Dq
         5kR+8EWzwRKgRheByVLoD4sTh+/BxZ2nLbvBWq3GPJc4zTkNw297OMLUBxLNe+btal
         y7ay2+cWGrzwAWUPcZWIjgvIO7TF+1jqqXS1ZTe8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220516165420eucas1p1bcc0f0bd3a9d48f46d084febc883e0cc~vpCNyNJtW3183531835eucas1p1K;
        Mon, 16 May 2022 16:54:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9E.D6.10260.CB182826; Mon, 16
        May 2022 17:54:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516165419eucas1p104aadda60df323e6154bfc3b92103b7b~vpCNYo_z33185231852eucas1p1L;
        Mon, 16 May 2022 16:54:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220516165419eusmtrp1da80ad51c871b452d6f5500bc402eb7f~vpCNXvW_c2961829618eusmtrp1E;
        Mon, 16 May 2022 16:54:19 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-3e-628281bc9a2c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4B.89.09522.BB182826; Mon, 16
        May 2022 17:54:19 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165419eusmtip17f050be3da427ead4fb6b476c789280b~vpCNDBYCX2383023830eusmtip1X;
        Mon, 16 May 2022 16:54:19 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 01/13] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Date:   Mon, 16 May 2022 18:54:04 +0200
Message-Id: <20220516165416.171196-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djP87p7GpuSDK53CFqsvtvPZvH77Hlm
        i73vZrNaXPjRyGRx88BOJos9iyYxWaxcfZTJoufABxaLvbe0LS49XsFusWfvSRaLy7vmsFnM
        X/aU3eLGhKeMFp+XtrBbrLn5lMVBwOPfiTVsHjtn3WX3uHy21GPTqk42j81L6j1232wACrfe
        Z/V4v+8qm0ffllWMHuu3XGXx2Hy62uPzJrkAnigum5TUnMyy1CJ9uwSujL7FixgLZopUHPg8
        mamB8ZZAFyMnh4SAicSN7uusXYxcHEICKxgl/l3YxwSSEBL4wihxvF8dwv7MKHFwlitMw9KZ
        v1kg4ssZJWb0u0A0P2eUWPbqBGMXIwcHm4CWRGMnO0iNiECWxLQTDxlBapgFDjNJPD86nxWk
        RlggWeLScmOQGhYBVYndsxvZQGxeASuJF5uns0PskpeYeek7O0g5p4C1xOoubogSQYmTM5+A
        ncAMVNK8dTYzyHgJgeWcEqcP/GKD6HWROPHzFROELSzx6vgWqJkyEqcn97BA2NUST2/8hmpu
        YZTo37meDWSZBNCyvjM5ICazgKbE+l36EOWOEituvGeBqOCTuPFWEOIEPolJ26YzQ4R5JTra
        hCCqlSR2/nwCtVRC4nLTHKilHhJ/5jxnmcCoOAvJM7OQPDMLYe8CRuZVjOKppcW56anFxnmp
        5XrFibnFpXnpesn5uZsYgYnv9L/jX3cwrnj1Ue8QIxMH4yFGCQ5mJRFeg4qGJCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8yZkbEoUE0hNLUrNTUwtSi2CyTBycUg1MO1iXfz+SyuXyYm2Q202J
        S3OX8rzKzHd8OVXuQH1c4a9PGW2cLe9ezPqpqiOzKzL4bJ395D3flPquzHDMCNC+bfZNI3nt
        ruPySWfeqxmGFGTNcZovwRnqdiLKvrIowz9Zfd+cSUe41IOCuOS+71uUY9HF1qW29N1XU5GF
        uVklpR43c63e/mzXEL/glRKZN+EQP0+v3K6lkQzdConlm/bxJIebHHh83Mf934eJBw/omG2v
        +dcdyH7iv/ffEmXT4s8zbu1ebviNZ4JGcZfmtjXf212sKkz/MOf/YdZRT+ft+fN8w5nNrndn
        BAXLH6j9x/X69oaJXurNwp7C3cuuKn9umVBZoHLdy3jCH25t8SolluKMREMt5qLiRAAcKPbk
        6wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7q7G5uSDP5uN7dYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBZ7Fk1isli5+iiTRc+BDywWe29pW1x6vILdYs/ekywWl3fNYbOY
        v+wpu8WNCU8ZLT4vbWG3WHPzKYuDgMe/E2vYPHbOusvucflsqcemVZ1sHpuX1HvsvtkAFG69
        z+rxft9VNo++LasYPdZvucrisfl0tcfnTXIBPFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYm
        lnqGxuaxVkamSvp2NimpOZllqUX6dgl6GX2LFzEWzBSpOPB5MlMD4y2BLkZODgkBE4mlM3+z
        dDFycQgJLGWUWNb/hQkiISFxe2ETI4QtLPHnWhcbRNFTRolNTe1ARRwcbAJaEo2d7CA1IgIF
        EnP6t7CA2MwC55kk9q93B7GFBRIlZv14D1bDIqAqsXt2IxuIzStgJfFi83R2iPnyEjMvfWcH
        GckpYC2xuosbJCwEVPL1yS12iHJBiZMzn0CNl5do3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem
        5xYb6hUn5haX5qXrJefnbmIERuq2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrwGFQ1JQrwpiZVV
        qUX58UWlOanFhxhNgc6eyCwlmpwPTBV5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6Yklqdmp
        qQWpRTB9TBycUg1M7Pcbb0tJiolxsB7lSj8p7O2mczzNa6/e03UhRcc/ZTV7T12oVKO1tmLB
        5k+7z9gd7FoZfeVKzbaD6cYzWpdJmPY9dPz867vTiyfPZK8+CDr/XvzALNdV/DcDu20XHDeo
        cfig/vuHTtQqtX39O3oMf87gSa1tdk2YMGdLf+SLEyXpqepFZkLSS9PbXjqza64469h0NiLS
        5N71KXy8Gmlpe3+3/j/4ItlCNvD7E4F7vw/sLvivvTV54aq/DssuJIns/mL2SuIq84tb8/Zw
        3Fe4vWGzrmKwxL0Z13W+f3dSmrWn2dB4wcOFsc2VNyLfBt2dULbGqySWK0BW/6HJzXuvthp9
        n28zeQlr9ossmQxPEyWW4oxEQy3mouJEALGUZ2ldAwAA
X-CMS-MailID: 20220516165419eucas1p104aadda60df323e6154bfc3b92103b7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165419eucas1p104aadda60df323e6154bfc3b92103b7b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165419eucas1p104aadda60df323e6154bfc3b92103b7b
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165419eucas1p104aadda60df323e6154bfc3b92103b7b@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
also work for non-power-of-2 zone sizes.

As the existing deployments of zoned devices had power-of-2
assumption, power-of-2 optimized calculation is kept for those devices.

There are no direct hot paths modified and the changes just
introduce one new branch per call.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-zoned.c      | 13 ++++++++++---
 include/linux/blkdev.h |  8 +++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 38cd840d8..140230134 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -111,16 +111,23 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
  * blkdev_nr_zones - Get number of zones
  * @disk:	Target gendisk
  *
- * Return the total number of zones of a zoned block device.  For a block
- * device without zone capabilities, the number of zones is always 0.
+ * Return the total number of zones of a zoned block device, including the
+ * eventual small last zone if present. For a block device without zone
+ * capabilities, the number of zones is always 0.
  */
 unsigned int blkdev_nr_zones(struct gendisk *disk)
 {
 	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
+	sector_t capacity = get_capacity(disk);
 
 	if (!blk_queue_is_zoned(disk->queue))
 		return 0;
-	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return (capacity + zone_sectors - 1) >>
+		       ilog2(zone_sectors);
+
+	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
 }
 EXPORT_SYMBOL_GPL(blkdev_nr_zones);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1b24c1fb3..22fe512ee 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -675,9 +675,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 					     sector_t sector)
 {
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
+
 	if (!blk_queue_is_zoned(q))
 		return 0;
-	return sector >> ilog2(q->limits.chunk_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return sector >> ilog2(zone_sectors);
+
+	return div64_u64(sector, zone_sectors);
 }
 
 static inline bool blk_queue_zone_is_seq(struct request_queue *q,
-- 
2.25.1

