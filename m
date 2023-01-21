Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF9567649B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjAUGws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjAUGwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:52:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E576AF76;
        Fri, 20 Jan 2023 22:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mM5qeuvX02JPpBY4QUR+8WPJXaasb3H8TIxuP94jcrc=; b=zBX95EVyYRGxu0Dtmx7AAOj/Vy
        v8zROueOYadG37dv/4DcjvGMahE+lfBGlGWnGa4mqttGW8m2vAtII2M7eUMJyOZPgMvm90z8lGkHY
        ro3NNbnQ4wcfa/4Subcb8qiioncL65ltcZkTrR5w9Qr9QAsYL5VM8yfF0fy9SzbBUyH25MKaUIORd
        eHjJ+4f2RzJ38TgT4ijksBiq9YHraa0PJpEdGWXiQ7hGLOul3kOex6Gu1QyZ/9DvnQU11DSBsUV1b
        ZKOkcT+lxbqV2M5taBiwFQ8VJWAyKiwu3V5OkXtzoiQYt7ZX4d42DLBCtYsRWyjLLVtZ8WX2uIymP
        jSb13KbQ==;
Received: from [2001:4bb8:19a:2039:6754:cc81:9ace:36fc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7jP-00DRlB-Oq; Sat, 21 Jan 2023 06:52:04 +0000
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
Subject: [PATCH 34/34] iomap: remove IOMAP_F_ZONE_APPEND
Date:   Sat, 21 Jan 2023 07:50:31 +0100
Message-Id: <20230121065031.1139353-35-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121065031.1139353-1-hch@lst.de>
References: <20230121065031.1139353-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
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
2.39.0

