Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6424F0E39
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 06:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377146AbiDDEro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 00:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377142AbiDDErm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:47:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4031C32EED;
        Sun,  3 Apr 2022 21:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=g+ZMzme6kz75KUekAyhRpwVmQW7rPPcw33xPjfVCTbI=; b=NkMbvHdoZ7ratUYipZwWnsv6My
        Qd/asoCL1l+cPB0pi1Q2kxTwCepjAArGhsKav/ZnExT/vRzQ/ZGAbH8UdijLHnbtFxPsuDlp3r+pQ
        qBJA0043UCzVLBZGjQux4Qe9bMJqzF5jLhEdNegXg3RQsjBI9nxgHOzXT83EXyMWpV/yKZZJUFWUz
        QeU7vC67I6LN1A+On80zES1JyUsNDk4bvCkcKdjjMAfxhHwHXL84Xz9xmvx/rSKpHdm7NxLvJfrBm
        NBIzW7P0es7sdUlzP44a+R7L7/xPeGKI3iJzLm78x5llbFMjP6AaOuu0aO16XDnI7+vYGI8w4BSO3
        THWFJazw==;
Received: from 089144211060.atnat0020.highway.a1.net ([89.144.211.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEb1-00D3Wl-0w; Mon, 04 Apr 2022 04:45:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/12] btrfs: simplify btrfsic_read_block
Date:   Mon,  4 Apr 2022 06:45:19 +0200
Message-Id: <20220404044528.71167-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404044528.71167-1-hch@lst.de>
References: <20220404044528.71167-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfsic_read_block does not need the btrfs_bio structure, so switch to
plain bio_alloc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/check-integrity.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 49f9954f1438f..0fd3ca10ec569 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1563,10 +1563,9 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 		struct bio *bio;
 		unsigned int j;
 
-		bio = btrfs_bio_alloc(num_pages - i);
-		bio_set_dev(bio, block_ctx->dev->bdev);
+		bio = bio_alloc(block_ctx->dev->bdev, num_pages - i,
+				REQ_OP_READ, GFP_NOFS);
 		bio->bi_iter.bi_sector = dev_bytenr >> 9;
-		bio->bi_opf = REQ_OP_READ;
 
 		for (j = i; j < num_pages; j++) {
 			ret = bio_add_page(bio, block_ctx->pagev[j],
-- 
2.30.2

