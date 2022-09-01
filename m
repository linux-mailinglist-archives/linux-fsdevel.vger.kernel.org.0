Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C98D5A90F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 09:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiIAHoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 03:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiIAHnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:43:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5D6126DC6;
        Thu,  1 Sep 2022 00:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZKNiS3a/9C2boxpP0LYq6qVDpc8a6QliuN3Wa2lrTSg=; b=V24jpI2xK/h3II61ZVjkylZDJu
        euH7JDCPXV21T0EBqJL266HsMXmDD8VuZp0SuGsifikk1x+Xr8PNBL9FZBPd9nrlwQy10QI0kbO/I
        QRXDqMACU7h4t1iIm+dHWeIr2dMxfIZaHJdi5j0Hum/yRhJ4OADG2V8vM6rxeTeefBc5ShCK7Xagg
        FNjUz0b4Ab9Vt3AknW8tvl7f/IzUPSk7SEjx+oUSyK0Ikri3jDR+qypoy1Fdc3NyUx44cc6PGRexK
        UMhxB3EyZPCnaYPQwiEkA26/AxgchXKEAstgOQt2lCnQ8Qe6keG4KojsLpRHGRjmJHq6vGJSexgaX
        Qok/yxcw==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTerI-00ANpU-ON; Thu, 01 Sep 2022 07:43:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/17] iomap: remove IOMAP_F_ZONE_APPEND
Date:   Thu,  1 Sep 2022 10:42:16 +0300
Message-Id: <20220901074216.1849941-18-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901074216.1849941-1-hch@lst.de>
References: <20220901074216.1849941-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No users left now that btrfs takes REQ_OP_WRITE bios from iomap and
splits and converts them to REQ_OP_ZONE_APPEND internally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

