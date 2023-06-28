Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81794741530
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjF1Pci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjF1Pc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D786D30C5;
        Wed, 28 Jun 2023 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7ayhH8VZI9kxAFPFQzSgayXxw0cyNFJ82CM16lTSVPI=; b=Fc2PuFirqXY1uwY9mNYHYVZ5ct
        vSUgnRDBLtrjWA4htbVmZrSLMOyk/6FCW+YaW6B7LMl5vizPZy6dQQvahtpDl9QeqjzlZppaLaMzP
        pIL59Cld2oWu/mFgtL/OQEH8fgewCoOsgRG9VD0kkyhwyt6bclsA1JnjmJj5UUEEOhUO79hn//nZX
        SFwwEvaE/O9H6zh7qW4dJYdd6lrwKvujKvHMXQegIgFCSIvU1SBocFnPaAQMoUJBhnasCiNKZ1+mW
        a6dYdNStF7EMY58bLxU9Z8j1PlaPLTBHmSk57dcGLodjTsnDArRpuABuZXGsYjg7hvEtCMJI+pXC2
        Jyz9+yQg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9b-00G08W-24;
        Wed, 28 Jun 2023 15:32:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/23] btrfs: clean up the check for uncompressed ranges in submit_one_async_extent
Date:   Wed, 28 Jun 2023 17:31:32 +0200
Message-Id: <20230628153144.22834-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628153144.22834-1-hch@lst.de>
References: <20230628153144.22834-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of checking for a NULL !pages and explaining this with a cryptic
comment, just check the compression type for BTRFS_COMPRESS_NONE to make
the check self-explanatory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8185e95ad12a19..6197b33fb0b23b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1209,8 +1209,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	}
 	lock_extent(io_tree, start, end, NULL);
 
-	/* We have fall back to uncompressed write */
-	if (!async_extent->pages) {
+	if (async_extent->compress_type == BTRFS_COMPRESS_NONE) {
 		submit_uncompressed_range(inode, async_extent, locked_page);
 		goto done;
 	}
-- 
2.39.2

