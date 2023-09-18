Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBCB7A47ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbjIRLGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbjIRLF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6298101;
        Mon, 18 Sep 2023 04:05:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8502121AB8;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=12LMwdHZ1bZ03RR+L49Ac8+YMFXdYZwVGlXkz8YquqM=;
        b=dFpKEK4HeBOY3FewXaP7aJtlTdk6AnpOKd5O9i+LAbNCc2lHEJdxzKrF+7DEUo848CZIfI
        3r83uBVKDg8zPugjmS+JWHroeQdVpXUn/+sgaEeVsy0kI6w9fZfcdCwQoA0uaGrsmsuGxL
        jbSuxDdd69gcz1d+cohNFjmlclWvXtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=12LMwdHZ1bZ03RR+L49Ac8+YMFXdYZwVGlXkz8YquqM=;
        b=zqNAQDBNpyFItxIXFqKGYZdQYwaKTOpB0xmuEb47kyGqB7bslHfHMYBqwQ7egP4XZPoEK+
        4BmnSQlqI86VdDAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6ED792C162;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 4386C51CD153; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/18] block/bdev: enable large folio support for large logical block sizes
Date:   Mon, 18 Sep 2023 13:05:03 +0200
Message-Id: <20230918110510.66470-12-hare@suse.de>
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

Enable large folio support when the logical block size is larger
than PAGE_SIZE.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/bdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index adbcf7af0b56..d5198743401a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -133,6 +133,9 @@ static void set_init_blocksize(struct block_device *bdev)
 		bsize <<= 1;
 	}
 	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	if (bsize > PAGE_SIZE)
+		mapping_set_folio_orders(bdev->bd_inode->i_mapping,
+					 get_order(bsize), MAX_ORDER);
 }
 
 int set_blocksize(struct block_device *bdev, int size)
@@ -149,6 +152,9 @@ int set_blocksize(struct block_device *bdev, int size)
 	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
 		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		if (size > PAGE_SIZE)
+			mapping_set_folio_orders(bdev->bd_inode->i_mapping,
+						 get_order(size), MAX_ORDER);
 		kill_bdev(bdev);
 	}
 	return 0;
@@ -425,6 +431,11 @@ void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 
 void bdev_add(struct block_device *bdev, dev_t dev)
 {
+	unsigned int bsize = bdev_logical_block_size(bdev);
+
+	if (bsize > PAGE_SIZE)
+		mapping_set_folio_orders(bdev->bd_inode->i_mapping,
+					 get_order(bsize), MAX_ORDER);
 	bdev->bd_dev = dev;
 	bdev->bd_inode->i_rdev = dev;
 	bdev->bd_inode->i_ino = dev;
-- 
2.35.3

