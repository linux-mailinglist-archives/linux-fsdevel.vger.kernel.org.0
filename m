Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A95666DD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbjALJMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 04:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjALJKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:10:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E97AD93;
        Thu, 12 Jan 2023 01:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+FS5p5rqX+D0dMknT+K4MNJZC6GPawitjooq8RtKUs0=; b=EZM4m05zpQ0OFQtGJz9DCf76PA
        mg1SWzm+p3nqUk/EE0BNFS9lrOhbdaJO6A5y3oOLeywmyL3ZB4fUoNW5kt/aRF8swz6JCyvExBMb7
        x2XYCpsxVH9FvG3i4ivymSbQtG/DTdXf4G1psCXFEgSOmvJegpi5Sj53RnsAH/9PIXfgrVRwxl7Ju
        Znl1rkkLPVupS6A89BEOa3/Euk6rv3VBjUBYZZf47ee26DmAGYkIOML2XlDeJAVFybx1HSIgcrC1k
        SNvJwEB0AikQLssmZP70+OQe82h8THbqJzoA6RVgwoWPu0mtjEFSKa0bylJ45U3wiln22RlozgegG
        75jWFmEA==;
Received: from [2001:4bb8:181:656b:c87d:36c9:914c:c2ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFtXc-00EGde-PA; Thu, 12 Jan 2023 09:06:33 +0000
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
Date:   Thu, 12 Jan 2023 10:05:31 +0100
Message-Id: <20230112090532.1212225-20-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230112090532.1212225-1-hch@lst.de>
References: <20230112090532.1212225-1-hch@lst.de>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/iomap/direct-io.c  | 10 ++--------
 include/linux/iomap.h |  3 +--
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9804714b17518e..f771001574d008 100644
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
index 0983dfc9a203c3..fca43a4bd96b77 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -58,8 +58,7 @@ struct vm_fault;
 #define IOMAP_F_SHARED		(1U << 2)
 #define IOMAP_F_MERGED		(1U << 3)
 #define IOMAP_F_BUFFER_HEAD	(1U << 4)
-#define IOMAP_F_ZONE_APPEND	(1U << 5)
-#define IOMAP_F_XATTR		(1U << 6)
+#define IOMAP_F_XATTR		(1U << 5)
 
 /*
  * Flags set by the core iomap code during operations:
-- 
2.35.1

