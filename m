Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7178063142A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 13:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKTMtM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 07:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiKTMss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:48:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280E41F9C3;
        Sun, 20 Nov 2022 04:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bSM021v7Bqniwl0y7H4YgiSVFfL7nNa5DyEFFras/lc=; b=PqDKCcIKT0zkaCkvk2Leg1Eawc
        mhqibWmsgTQtxpca+LARC3wYX/U3KfENsaD5JOz3cOT61MHvWFOKwE0HfTYi4Rz4AUsnZlWJfniXK
        TLIqke9mtiFkneFOXkOMFOBnDymTlSORYhtUHyuMidpindPP7HjrLap0fEvkyV7gdOQKjd920uWi5
        F55kakZLXTOzMiML9adLeEo6xinDLl2zVrTMOokURFJ1x7cpeUg9FbMMxzBOrCB4Bhr4bdF0J3Saq
        5fTHcbUUnIWMgT5knx/7+x6ZsdkZ4/sXklHCtGq1PEzbeDw3WPUUVWcqJt64d7cpErUKsCu9vmSU3
        IqUPEfqA==;
Received: from [2001:4bb8:181:6f70:ae5d:6675:76b9:6fc3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owjkL-004IJi-2x; Sun, 20 Nov 2022 12:48:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH 19/19] iomap: remove IOMAP_F_ZONE_APPEND
Date:   Sun, 20 Nov 2022 13:47:34 +0100
Message-Id: <20221120124734.18634-20-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120124734.18634-1-hch@lst.de>
References: <20221120124734.18634-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No users left now that btrfs takes REQ_OP_WRITE bios from iomap and
splits and converts them to REQ_OP_ZONE_APPEND internally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/iomap/direct-io.c  | 10 ++--------
 include/linux/iomap.h |  1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4eb559a16c9ed..9e883a9f80388 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -217,16 +217,10 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
-	if (!(dio->flags & IOMAP_DIO_WRITE)) {
-		WARN_ON_ONCE(iomap->flags & IOMAP_F_ZONE_APPEND);
+	if (!(dio->flags & IOMAP_DIO_WRITE))
 		return REQ_OP_READ;
-	}
-
-	if (iomap->flags & IOMAP_F_ZONE_APPEND)
-		opflags |= REQ_OP_ZONE_APPEND;
-	else
-		opflags |= REQ_OP_WRITE;
 
+	opflags |= REQ_OP_WRITE;
 	if (use_fua)
 		opflags |= REQ_FUA;
 	else
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 238a03087e17e..ee6d511ef29dd 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -55,7 +55,6 @@ struct vm_fault;
 #define IOMAP_F_SHARED		0x04
 #define IOMAP_F_MERGED		0x08
 #define IOMAP_F_BUFFER_HEAD	0x10
-#define IOMAP_F_ZONE_APPEND	0x20
 
 /*
  * Flags set by the core iomap code during operations:
-- 
2.30.2

