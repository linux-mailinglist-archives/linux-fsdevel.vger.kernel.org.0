Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9C72759F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 05:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjFHDYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 23:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFHDYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:24:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB942128;
        Wed,  7 Jun 2023 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tJx3dGm90GKdxMftw9L/RXCahr9FMlcRqFZ3WAycOtw=; b=SnPxpRakWKO3T03Wum+j1Oo4PP
        fZ2ekS0+63BhppE75A69n7zuvV//6fONSqDm81rg0z7wY6DlQ4KGoA+gPLQFCueJ8d56DmjAgmzrr
        AcMxGOHBNBectqVEhqMFViUocqzXzYcErEiNEIXjxPZ7EynytZhRa4MokPMcQPnY2iMbLosajzoAV
        8f/YE11Zoj5fqgm4O+AwvpN2V4LHoJBcuyQHLMS4EWq/9kV1wsQhbtdn3X4P77AO8U3rzK2mS19O2
        1sKqZZduZ13Na74voRxmvQhwbpCsiSE+auOoa8AvrZMSeKsbyYFthFY/c2yabOQPUUz+VpZJgOHVB
        isHny2qw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q76Fr-007uuk-2p;
        Thu, 08 Jun 2023 03:24:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, willy@infradead.org
Cc:     hare@suse.de, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, patches@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, mcgrof@kernel.org, corbet@lwn.net,
        jake@lwn.net
Subject: [RFC 2/4] bdev: abstract inode lookup on blkdev_get_no_open()
Date:   Wed,  7 Jun 2023 20:24:02 -0700
Message-Id: <20230608032404.1887046-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608032404.1887046-1-mcgrof@kernel.org>
References: <20230608032404.1887046-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide an abstraction for how we lookup an inode
on blkdev_get_no_open() so we can later expand upon
the implementation on just relying on one super block.

This will make subsequent changes easier to review.

This introduces no functional changes.

Although we all probably want to just remove BLOCK_LEGACY_AUTOLOAD
removing it before has proven issues with both loopback [0] and
is expected to break mdraid [1], so this takes the more careful
approach to just keeping it.

[0] https://lore.kernel.org/all/20220222085354.GA6423@lst.de/T/#u
[1] https://lore.kernel.org/all/20220503212848.5853-1-dmoulding@me.com/

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 91477c3849d2..61d8d2722cda 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -666,15 +666,20 @@ static void blkdev_put_part(struct block_device *part, fmode_t mode)
 	blkdev_put_whole(whole, mode);
 }
 
+static struct inode *blkdev_inode_lookup(dev_t dev)
+{
+	return ilookup(blockdev_superblock, dev);
+}
+
 struct block_device *blkdev_get_no_open(dev_t dev)
 {
 	struct block_device *bdev;
 	struct inode *inode;
 
-	inode = ilookup(blockdev_superblock, dev);
+	inode = blkdev_inode_lookup(dev);
 	if (!inode && IS_ENABLED(CONFIG_BLOCK_LEGACY_AUTOLOAD)) {
 		blk_request_module(dev);
-		inode = ilookup(blockdev_superblock, dev);
+		inode = blkdev_inode_lookup(dev);
 		if (inode)
 			pr_warn_ratelimited(
 "block device autoloading is deprecated and will be removed.\n");
-- 
2.39.2

