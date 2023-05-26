Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2BA712124
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 09:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242446AbjEZHdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 03:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242427AbjEZHdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 03:33:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BDD114;
        Fri, 26 May 2023 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mp0R5kJjV9ATA7f3wCKoUGxZA6HQSlfyegxBHwX5Bjk=; b=JFyweRH3uI2LUIKa6CevDLZKGx
        TKIgB0Y1EjmjhgQtYqrSPkMNG5keYraDpb6BQnGzIKLhMTVo0oblR4jwgMIB6HIdUXSpGXq28Xvyh
        mtYzmXcLkLNuZP2TpCA4lzDp1RA2SxN0/ENDC+tnH0vBOiJFjpSdfkBUaUztNotfiYNvg1cz1G7/1
        zF7NHp330UXzfhSxJuQ3/eJkFTHFymVoG8RVBzcYY3SMWY45Ut2V3AZToDDkiy4FZEh+w6+Ma+nuF
        OtmnMOJt2rZqs5q6W/LuP6PHm5KmPG18Oz3Qh8+WAau3MwsT+44Wt7PDwRVd38S7pB26tTKLzCQ3m
        oxCy1d7A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2RxA-001RdR-3D;
        Fri, 26 May 2023 07:33:37 +0000
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
Subject: [PATCH v2 1/5] block: annotate bdev_disk_changed() deprecation with a symbol namespace
Date:   Fri, 26 May 2023 00:33:32 -0700
Message-Id: <20230526073336.344543-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526073336.344543-1-mcgrof@kernel.org>
References: <20230526073336.344543-1-mcgrof@kernel.org>
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

This ensures no other users pop up by mistake easily and provides
us a with an easy vehicle to do the same with other routines should
we need it later.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/partitions/core.c         | 6 +-----
 drivers/block/loop.c            | 2 ++
 drivers/s390/block/dasd_genhd.c | 2 ++
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 49e0496ff23c..6f18444be4fe 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -690,11 +690,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 
 	return ret;
 }
-/*
- * Only exported for loop and dasd for historic reasons.  Don't use in new
- * code!
- */
-EXPORT_SYMBOL_GPL(bdev_disk_changed);
+EXPORT_SYMBOL_NS_GPL(bdev_disk_changed, BLOCK_DEPRECATED);
 
 void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bc31bb7072a2..50aa5b4c0c56 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -37,6 +37,8 @@
 #include <linux/spinlock.h>
 #include <uapi/linux/loop.h>
 
+MODULE_IMPORT_NS(BLOCK_DEPRECATED);
+
 /* Possible states of device */
 enum {
 	Lo_unbound,
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 998a961e1704..5ea244aec534 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -25,6 +25,8 @@
 
 #include "dasd_int.h"
 
+MODULE_IMPORT_NS(BLOCK_DEPRECATED);
+
 static unsigned int queue_depth = 32;
 static unsigned int nr_hw_queues = 4;
 
-- 
2.39.2

