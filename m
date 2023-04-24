Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5296EC3E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 05:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjDXDRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Apr 2023 23:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDXDRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Apr 2023 23:17:39 -0400
X-Greylist: delayed 560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Apr 2023 20:17:33 PDT
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [IPv6:2001:41d0:203:375::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2F2D74
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Apr 2023 20:17:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682305691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rktJpHCoboWkL32TRaWgx22LE+khm36G3psZAXScPBI=;
        b=QzwSL6mKb5iqX2DMZlKgThEskXLv7mneqOQYQDyOXOYwby5fL278UNJrV8qmr2TUQ4sYRg
        sG8j1Dc272/YBaHsUzv8fdaMM2spVEBQRbhmJtP579oW5ll+RlZSmc8tCjnQpX7mDRy8ZD
        rAPBNrbp5pqUFkj5RbAxpC0hhfzw+ls=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     david@redhat.com, osalvador@suse.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mmzone: Introduce for_each_populated_zone_pgdat()
Date:   Mon, 24 Apr 2023 11:07:56 +0800
Message-Id: <20230424030756.1795926-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of define an index and determining if the zone has memory,
introduce for_each_populated_zone_pgdat() helper that can be used
to iterate over each populated zone in pgdat, and convert the most
obvious users to it.

This patch has no functional change.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/base/memory.c  |  7 ++-----
 include/linux/mmzone.h |  8 ++++++++
 mm/compaction.c        | 36 +++++++-----------------------------
 mm/page-writeback.c    |  8 ++------
 4 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b456ac213610..ad898b1c85c7 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -656,7 +656,6 @@ static struct zone *early_node_zone_for_memory_block(struct memory_block *mem,
 	const unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	struct zone *zone, *matching_zone = NULL;
 	pg_data_t *pgdat = NODE_DATA(nid);
-	int i;
 
 	/*
 	 * This logic only works for early memory, when the applicable zones
@@ -666,10 +665,8 @@ static struct zone *early_node_zone_for_memory_block(struct memory_block *mem,
 	 * zones that intersect with the memory block are actually applicable.
 	 * No need to look at the memmap.
 	 */
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		zone = pgdat->node_zones + i;
-		if (!populated_zone(zone))
-			continue;
+	for_each_populated_zone_pgdat(zone, pgdat, MAX_NR_ZONES) {
+
 		if (!zone_intersects(zone, start_pfn, nr_pages))
 			continue;
 		if (!matching_zone) {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4889c9d4055..48e9f01c0b5d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1580,6 +1580,14 @@ extern struct zone *next_zone(struct zone *zone);
 			; /* do nothing */		\
 		else
 
+#define for_each_populated_zone_pgdat(zone, pgdat, max) \
+	for (zone = pgdat->node_zones;                  \
+	     zone < pgdat->node_zones + max;            \
+	     zone++)                                    \
+		if (!populated_zone(zone))		\
+			; /* do nothing */		\
+		else
+
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
 	return zoneref->zone;
diff --git a/mm/compaction.c b/mm/compaction.c
index c8bcdea15f5f..863f10c7e510 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -375,12 +375,9 @@ static void __reset_isolation_suitable(struct zone *zone)
 
 void reset_isolation_suitable(pg_data_t *pgdat)
 {
-	int zoneid;
+	struct zone *zone;
 
-	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
-		struct zone *zone = &pgdat->node_zones[zoneid];
-		if (!populated_zone(zone))
-			continue;
+	for_each_populated_zone_pgdat(zone, pgdat, MAX_NR_ZONES) {
 
 		/* Only flush if a full compaction finished recently */
 		if (zone->compact_blockskip_flush)
@@ -2046,14 +2043,10 @@ static unsigned int fragmentation_score_zone_weighted(struct zone *zone)
 static unsigned int fragmentation_score_node(pg_data_t *pgdat)
 {
 	unsigned int score = 0;
-	int zoneid;
+	struct zone *zone;
 
-	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
-		struct zone *zone;
+	for_each_populated_zone_pgdat(zone, pgdat, MAX_NR_ZONES) {
 
-		zone = &pgdat->node_zones[zoneid];
-		if (!populated_zone(zone))
-			continue;
 		score += fragmentation_score_zone_weighted(zone);
 	}
 
@@ -2681,7 +2674,6 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
  */
 static void proactive_compact_node(pg_data_t *pgdat)
 {
-	int zoneid;
 	struct zone *zone;
 	struct compact_control cc = {
 		.order = -1,
@@ -2692,10 +2684,7 @@ static void proactive_compact_node(pg_data_t *pgdat)
 		.proactive_compaction = true,
 	};
 
-	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
-		zone = &pgdat->node_zones[zoneid];
-		if (!populated_zone(zone))
-			continue;
+	for_each_populated_zone_pgdat(zone, pgdat, MAX_NR_ZONES) {
 
 		cc.zone = zone;
 
@@ -2712,7 +2701,6 @@ static void proactive_compact_node(pg_data_t *pgdat)
 static void compact_node(int nid)
 {
 	pg_data_t *pgdat = NODE_DATA(nid);
-	int zoneid;
 	struct zone *zone;
 	struct compact_control cc = {
 		.order = -1,
@@ -2722,12 +2710,7 @@ static void compact_node(int nid)
 		.gfp_mask = GFP_KERNEL,
 	};
 
-
-	for (zoneid = 0; zoneid < MAX_NR_ZONES; zoneid++) {
-
-		zone = &pgdat->node_zones[zoneid];
-		if (!populated_zone(zone))
-			continue;
+	for_each_populated_zone_pgdat(zone, pgdat, MAX_NR_ZONES) {
 
 		cc.zone = zone;
 
@@ -2823,15 +2806,10 @@ static inline bool kcompactd_work_requested(pg_data_t *pgdat)
 
 static bool kcompactd_node_suitable(pg_data_t *pgdat)
 {
-	int zoneid;
 	struct zone *zone;
 	enum zone_type highest_zoneidx = pgdat->kcompactd_highest_zoneidx;
 
-	for (zoneid = 0; zoneid <= highest_zoneidx; zoneid++) {
-		zone = &pgdat->node_zones[zoneid];
-
-		if (!populated_zone(zone))
-			continue;
+	for_each_populated_zone_pgdat(zone, pgdat, highest_zoneidx + 1) {
 
 		if (compaction_suitable(zone, pgdat->kcompactd_max_order, 0,
 					highest_zoneidx) == COMPACT_CONTINUE)
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index db7943999007..9a7bcf8fdfd5 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -272,13 +272,9 @@ static void wb_min_max_ratio(struct bdi_writeback *wb,
 static unsigned long node_dirtyable_memory(struct pglist_data *pgdat)
 {
 	unsigned long nr_pages = 0;
-	int z;
+	struct zone *zone;
 
-	for (z = 0; z < MAX_NR_ZONES; z++) {
-		struct zone *zone = pgdat->node_zones + z;
-
-		if (!populated_zone(zone))
-			continue;
+	for_each_populated_zone_pgdat(zone, pgdat, MAX_NR_ZONES) {
 
 		nr_pages += zone_page_state(zone, NR_FREE_PAGES);
 	}
-- 
2.25.1

