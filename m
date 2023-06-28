Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E6574152A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjF1PdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjF1Pcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FCC2D72;
        Wed, 28 Jun 2023 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=t0IHZiCOY5VW7cxEG9l1eoC3QT227WuoADquDBph/4c=; b=RiKGY6P1bGKm3tCLfjrTvQudpk
        yHI/EcLjRO5QLRqtSe0TeOzdHOclhbkhqn7M6LPlLr7Y/Br/xJ4HTwxzqVbRiD0cKRY1M0bbdegM0
        fv2CE6UnJ0B4g70v6oeBDzvbuM/saU+dDeIleVve/7JqwBD+3DKVkaGnihxUgleJ7FhgK+gfXDXLy
        Nr36LY/xkXFc/TkwQ26fvNe8lujBKdTFslbr5CfVbZdGnaRLXOfjmciWomdC/qH/GrLjIE+Mimpim
        GoKVDHyNQjBJD8Bx2VDFIlTiU0ReoUWPilycqJeeH6YO3OMtzRNQ24C/6e91z/hxLn+7KdOfTBNrh
        kyVnOb/g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9u-00G0CW-0Y;
        Wed, 28 Jun 2023 15:32:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/23] btrfs: use a separate label for the incompressible case in compress_file_range
Date:   Wed, 28 Jun 2023 17:31:38 +0200
Message-Id: <20230628153144.22834-18-hch@lst.de>
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

compress_file_range can fail to compress either because of resource or
alignment constraints or because the data is incompressible.  In the latter
case the inode is marked so that compression isn't tried again.  Currently
that check is based on the condition that the pages array has been allocated
which is rather cryptic.  Use a separate label to clearly distinguish this
case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 560682a5d9d7aa..00aabc088a9deb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -949,7 +949,7 @@ static void compress_file_range(struct btrfs_work *work)
 				   mapping, start, pages, &nr_pages, &total_in,
 				   &total_compressed);
 	if (ret)
-		goto cleanup_and_bail_uncompressed;
+		goto mark_incompressible;
 
 	/*
 	 * Zero the tail end of the last page, as we might be sending it down
@@ -1025,7 +1025,7 @@ static void compress_file_range(struct btrfs_work *work)
 	 */
 	total_in = round_up(total_in, fs_info->sectorsize);
 	if (total_compressed + blocksize > total_in)
-		goto cleanup_and_bail_uncompressed;
+		goto mark_incompressible;
 
 	/*
 	 * The async work queues will take care of doing actual allocation on
@@ -1040,6 +1040,9 @@ static void compress_file_range(struct btrfs_work *work)
 	}
 	return;
 
+mark_incompressible:
+	if (!btrfs_test_opt(fs_info, FORCE_COMPRESS) && !inode->prop_compress)
+		inode->flags |= BTRFS_INODE_NOCOMPRESS;
 cleanup_and_bail_uncompressed:
 	if (pages) {
 		/*
@@ -1054,12 +1057,6 @@ static void compress_file_range(struct btrfs_work *work)
 		pages = NULL;
 		total_compressed = 0;
 		nr_pages = 0;
-
-		/* flag the file so we don't compress in the future */
-		if (!btrfs_test_opt(fs_info, FORCE_COMPRESS) &&
-		    !(inode->prop_compress)) {
-			inode->flags |= BTRFS_INODE_NOCOMPRESS;
-		}
 	}
 
 	/*
-- 
2.39.2

