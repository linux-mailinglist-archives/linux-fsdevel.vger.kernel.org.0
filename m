Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D003778B1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjHKKKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjHKKKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:10:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E2330EC;
        Fri, 11 Aug 2023 03:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sF7/TLAdvGX6cavT8VuEoUUpVOqcLET0XfQb1xeL0Nw=; b=UCL+x9QG32FS+rhJbyMhi+/7BI
        pwDlHyybaxOCwwWqEiFMPVBNHFZeJBqaAwqNejCegVzyecx6tc9ySNjKWcO4z9faDK62iUZdEAG92
        O0byl8R9U9DO/sDMANpqYnIOjofkj88tIwTlBiw5GOiz58QuvPsWSQaw4+K4EEER553egvEWGz6yj
        C5tYAvvdB/qekhXR9UmRdfHPWIZUTA/Y6zwP1PKTJ3GVc6U/3wIdpUMiUKzBK001ICAg5yJnDlp8v
        dS7G9KViqIPcJSoosia71E04M94EtuD+UgLsefFdXt07ze6NRePr4uaLkbHud4BpYeZGm6OT48+gn
        oYBYUFPw==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP4n-00A5mu-2B;
        Fri, 11 Aug 2023 10:09:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/17] amiflop: don't call fsync_bdev in FDFMTBEG
Date:   Fri, 11 Aug 2023 12:08:21 +0200
Message-Id: <20230811100828.1897174-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
References: <20230811100828.1897174-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FDFMTBEG is used by fdformat to calibrate before formatting a disk.
Neither the atari nor PC floppy driver sync data, which also seems
a bit pointless for a disk hat is about to get formatted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/amiflop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index e460c9799d9f35..2b98114a9fe092 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1547,7 +1547,6 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 			rel_fdc();
 			return -EBUSY;
 		}
-		fsync_bdev(bdev);
 		if (fd_motor_on(drive) == 0) {
 			rel_fdc();
 			return -ENODEV;
-- 
2.39.2

