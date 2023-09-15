Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB87A2AA4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 00:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbjIOWoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbjIOWn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:43:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4732718;
        Fri, 15 Sep 2023 15:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=q5kC8lKXTQQVIY9YNTK1DwlfcMyU3THWqOh+LBupeKg=; b=XIkzA4O9wGqO2WtO8tF1Z+xTn6
        38fyqpIf4n/IRVBBYSnI4HTtxoGdQ8LSxZIP8/NSOPmdJX/6DryFm1LyL2/rS5Wthw0D9Rc5scxXx
        LeBfwDOWskLDMOD5Txbwvzoa8w47Q+FzsTwVlhtZIXH8t5goceyGum2sBY4q4juffs5HTbYPQASpT
        iQMJK8QZZL36GAP7fFFC9PfseuwA7wua+m3Sm1TqVEdTdAbNRv6nBe+cI0DCPcBiEFH5r0zh2G8tV
        4s4fP5cV+wF3aIWx2BG++FJ3o6PNKFE+Z1nWnlngkygbY4QmNH8SvuZMwjZKYMIc4beAWEP5tblOE
        kS4wAVZA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhHXM-00BUtR-2z;
        Fri, 15 Sep 2023 22:43:44 +0000
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
        da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, kbusch@kernel.org, mcgrof@kernel.org
Subject: [PATCH v3 3/4] dm bufio: simplify by using PAGE_SECTORS_SHIFT
Date:   Fri, 15 Sep 2023 15:43:42 -0700
Message-Id: <20230915224343.2740317-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230915224343.2740317-1-mcgrof@kernel.org>
References: <20230915224343.2740317-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/md/dm-bufio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 62eb27639c9b..a5b48be93b30 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1152,7 +1152,7 @@ static void *alloc_buffer_data(struct dm_bufio_client *c, gfp_t gfp_mask,
 	    gfp_mask & __GFP_NORETRY) {
 		*data_mode = DATA_MODE_GET_FREE_PAGES;
 		return (void *)__get_free_pages(gfp_mask,
-						c->sectors_per_block_bits - (PAGE_SHIFT - SECTOR_SHIFT));
+						c->sectors_per_block_bits - PAGE_SECTORS_SHIFT);
 	}
 
 	*data_mode = DATA_MODE_VMALLOC;
@@ -1173,7 +1173,7 @@ static void free_buffer_data(struct dm_bufio_client *c,
 
 	case DATA_MODE_GET_FREE_PAGES:
 		free_pages((unsigned long)data,
-			   c->sectors_per_block_bits - (PAGE_SHIFT - SECTOR_SHIFT));
+			   c->sectors_per_block_bits - PAGE_SECTORS_SHIFT);
 		break;
 
 	case DATA_MODE_VMALLOC:
-- 
2.39.2

