Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2CB7A47D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbjIRLFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjIRLFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA826E6;
        Mon, 18 Sep 2023 04:05:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7ABFD1FDFE;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VXuGAE77Y1ZoaYEDFz/VrOFxHm5srcxFRGpv+gi7iDM=;
        b=2DC+zaAqoOp1lPfpc9dJf9O6mU4r1FYfud+aEkHHIRWd0XZ7a/XVTgw51KCWiTL/f3PeqZ
        7Vze48ZDjg2q2nBZWh3WIgKAtKj0e/xAVlQYyzosoDkFRceNdQwhJtpWWe1PMXOZIR2mdB
        +HBL4GuIjFXm9uzE/NNb1/JT+rce6wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VXuGAE77Y1ZoaYEDFz/VrOFxHm5srcxFRGpv+gi7iDM=;
        b=5h2DwkMQgRMJCe5jaWSSz1DP0EspCtrdR+wii+DtlQz7WVCgWToeypod/1SmlGj1yon+6B
        pdfjpJmW70IwdgBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 633C12C152;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 2B63C51CD14D; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/18] mm/readahead: allocate folios with mapping order preference
Date:   Mon, 18 Sep 2023 13:05:00 +0200
Message-Id: <20230918110510.66470-9-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918110510.66470-1-hare@suse.de>
References: <20230918110510.66470-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use mapping_get_folio_order() when calling filemap_alloc_folio()
to allocate folios with the order specified by the mapping.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 mm/readahead.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 40a5f1f65281..0466a2bdb80a 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -244,7 +244,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask,
+				mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 		if (filemap_add_folio(mapping, folio, index + i,
@@ -311,6 +312,8 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct file_ra_state *ra = ractl->ra;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages, index;
+	unsigned int order = mapping_min_folio_order(mapping);
+	unsigned int min_pages = 1 << order;
 
 	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
 		return;
@@ -320,6 +323,10 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	 * be up to the optimal hardware IO size
 	 */
 	index = readahead_index(ractl);
+	if (order) {
+		WARN_ON(index & (min_pages - 1));
+		index = ALIGN_DOWN(index, min_pages);
+	}
 	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
 	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
 	while (nr_to_read) {
@@ -327,6 +334,8 @@ void force_page_cache_ra(struct readahead_control *ractl,
 
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
+		if (this_chunk < min_pages)
+			this_chunk = min_pages;
 		ractl->_index = index;
 		do_page_cache_ra(ractl, this_chunk, 0);
 
@@ -597,8 +606,8 @@ static void ondemand_readahead(struct readahead_control *ractl,
 		pgoff_t start;
 
 		rcu_read_lock();
-		start = page_cache_next_miss(ractl->mapping, index + 1,
-				max_pages);
+		start = page_cache_next_miss(ractl->mapping,
+				index + folio_nr_pages(folio), max_pages);
 		rcu_read_unlock();
 
 		if (!start || start - index > max_pages)
@@ -782,18 +791,20 @@ void readahead_expand(struct readahead_control *ractl,
 	struct file_ra_state *ra = ractl->ra;
 	pgoff_t new_index, new_nr_pages;
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	unsigned int order = mapping_min_folio_order(mapping);
+	unsigned int min_nr_pages = 1 << order;
 
-	new_index = new_start / PAGE_SIZE;
+	new_index = new_start / (min_nr_pages * PAGE_SIZE);
 
 	/* Expand the leading edge downwards */
 	while (ractl->_index > new_index) {
-		unsigned long index = ractl->_index - 1;
+		unsigned long index = ractl->_index - min_nr_pages;
 		struct folio *folio = xa_load(&mapping->i_pages, index);
 
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask, order);
 		if (!folio)
 			return;
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
@@ -805,12 +816,12 @@ void readahead_expand(struct readahead_control *ractl,
 			ractl->_workingset = true;
 			psi_memstall_enter(&ractl->_pflags);
 		}
-		ractl->_nr_pages++;
+		ractl->_nr_pages += folio_nr_pages(folio);
 		ractl->_index = folio->index;
 	}
 
 	new_len += new_start - readahead_pos(ractl);
-	new_nr_pages = DIV_ROUND_UP(new_len, PAGE_SIZE);
+	new_nr_pages = DIV_ROUND_UP(new_len, min_nr_pages * PAGE_SIZE);
 
 	/* Expand the trailing edge upwards */
 	while (ractl->_nr_pages < new_nr_pages) {
@@ -820,7 +831,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, 0);
+		folio = filemap_alloc_folio(gfp_mask, order);
 		if (!folio)
 			return;
 		if (filemap_add_folio(mapping, folio, index, gfp_mask) < 0) {
@@ -832,10 +843,10 @@ void readahead_expand(struct readahead_control *ractl,
 			ractl->_workingset = true;
 			psi_memstall_enter(&ractl->_pflags);
 		}
-		ractl->_nr_pages++;
+		ractl->_nr_pages += folio_nr_pages(folio);
 		if (ra) {
-			ra->size++;
-			ra->async_size++;
+			ra->size += folio_nr_pages(folio);
+			ra->async_size += folio_nr_pages(folio);
 		}
 	}
 }
-- 
2.35.3

