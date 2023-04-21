Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1333F6EB2B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 21:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjDUT6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 15:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjDUT62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:58:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2BA271E;
        Fri, 21 Apr 2023 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RlYZtMcWmG/W2kDdFWLbtYt9Jiujn88dB6HTCMaouxI=; b=qTRjtG4XiiUGR6XLhcw+SFktov
        LoDASQYMHVLj3TTg5Lw0jryhjP4LqtTs5LsbGN8HjKQwWO9XJb2N6gJoJdU2Kbxy3omeTFZdCuvu9
        gYsf5oHp7r0+jNOMXyus067c8U1t8hqR7BaZ7XU9tE5o5lpKgnd7lXd/DLUlJ0pBQsJr0jx9OR/47
        1fBRNIc53lCZDX5v1jMR7xMlrxsp2KBuUX3ZJS59UrN9p8IgGGDnMRpYh9885bwZV49u+cfeaApWm
        7EbwnxAkoRXz2ALy5RYREPDptZqMo4YNQcuh2gLrKyg50PFZ75wR7Mef75Ihe/+CAH3kPwfVf6eN9
        vxETgCxw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppwtU-00BlaX-1a;
        Fri, 21 Apr 2023 19:58:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, hch@infradead.org,
        djwong@kernel.org, minchan@kernel.org, senozhatsky@chromium.org
Cc:     patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, hare@suse.de, p.raghav@samsung.com,
        da.gomez@samsung.com, kbusch@kernel.org, mcgrof@kernel.org
Subject: [PATCH 1/5] dm integrity: simplify by using PAGE_SECTORS_SHIFT
Date:   Fri, 21 Apr 2023 12:58:03 -0700
Message-Id: <20230421195807.2804512-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230421195807.2804512-1-mcgrof@kernel.org>
References: <20230421195807.2804512-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The PAGE_SHIFT - SECTOR_SHIFT constant be replaced with PAGE_SECTORS_SHIFT
defined in linux/blt_types.h, which is included by linux/blkdev.h.

This produces no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/md/dm-integrity.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 31838b13ea54..a179265970dd 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -752,7 +752,7 @@ static void page_list_location(struct dm_integrity_c *ic, unsigned int section,
 
 	sector = section * ic->journal_section_sectors + offset;
 
-	*pl_index = sector >> (PAGE_SHIFT - SECTOR_SHIFT);
+	*pl_index = sector >> (PAGE_SECTORS_SHIFT);
 	*pl_offset = (sector << SECTOR_SHIFT) & (PAGE_SIZE - 1);
 }
 
@@ -1077,7 +1077,7 @@ static void rw_journal_sectors(struct dm_integrity_c *ic, blk_opf_t opf,
 		return;
 	}
 
-	pl_index = sector >> (PAGE_SHIFT - SECTOR_SHIFT);
+	pl_index = sector >> (PAGE_SECTORS_SHIFT);
 	pl_offset = (sector << SECTOR_SHIFT) & (PAGE_SIZE - 1);
 
 	io_req.bi_opf = opf;
@@ -1201,7 +1201,7 @@ static void copy_from_journal(struct dm_integrity_c *ic, unsigned int section, u
 
 	sector = section * ic->journal_section_sectors + JOURNAL_BLOCK_SECTORS + offset;
 
-	pl_index = sector >> (PAGE_SHIFT - SECTOR_SHIFT);
+	pl_index = sector >> (PAGE_SECTORS_SHIFT);
 	pl_offset = (sector << SECTOR_SHIFT) & (PAGE_SIZE - 1);
 
 	io_req.bi_opf = REQ_OP_WRITE;
@@ -3765,7 +3765,7 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
 	ic->commit_ids[3] = cpu_to_le64(0x4444444444444444ULL);
 
 	journal_pages = roundup((__u64)ic->journal_sections * ic->journal_section_sectors,
-				PAGE_SIZE >> SECTOR_SHIFT) >> (PAGE_SHIFT - SECTOR_SHIFT);
+				PAGE_SIZE >> SECTOR_SHIFT) >> (PAGE_SECTORS_SHIFT);
 	journal_desc_size = journal_pages * sizeof(struct page_list);
 	if (journal_pages >= totalram_pages() - totalhigh_pages() || journal_desc_size > ULONG_MAX) {
 		*error = "Journal doesn't fit into memory";
@@ -4542,7 +4542,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 			spin_lock_init(&bbs->bio_queue_lock);
 
 			sector = i * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT);
-			pl_index = sector >> (PAGE_SHIFT - SECTOR_SHIFT);
+			pl_index = sector >> (PAGE_SECTORS_SHIFT);
 			pl_offset = (sector << SECTOR_SHIFT) & (PAGE_SIZE - 1);
 
 			bbs->bitmap = lowmem_page_address(ic->journal[pl_index].page) + pl_offset;
-- 
2.39.2

