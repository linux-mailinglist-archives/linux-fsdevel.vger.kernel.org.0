Return-Path: <linux-fsdevel+bounces-1180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF127D6E75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8504D281CF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A463028E3B;
	Wed, 25 Oct 2023 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NkupXjjQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F45C15486
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:10:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BDA193;
	Wed, 25 Oct 2023 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eQkFS0CPXyYdJjvcxwO874+N6FHj6qkC07nIc5KQ7Fc=; b=NkupXjjQ3bzL5mbyZ8icwT06pw
	ektizSCeFbKc39Orvb0x8fTzJ1oLB74rAYmYPqIbjS+fyCfCbMOy66EZxYkrekM6Cn6PghALK5LJ6
	JtRDjTtq62PUPTC4s0HvcuM8KPOjeaSXWnNsbMThbqD9AKBUqzTUu7vJdIzrmxjJupxwgJAPXfiYk
	txfYJX8o7U5BHxwpLEcz4Se3hhRRYMrzEGaqL+b+tpoGOqW82ZVGsfn8vbkhhWPmS/lCmtBU/nVGK
	LKh8pkdcKzEaIruwf0QCn5HY8bWUuuTuz3kDbTflXeYwIRyujn0pcmEWGrPxaNsxJeeH1EWYwXsAu
	WyHCdRVQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qveak-00CTxA-04;
	Wed, 25 Oct 2023 14:10:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 2/4] block: update the stable_writes flag in bdev_add
Date: Wed, 25 Oct 2023 16:10:18 +0200
Message-Id: <20231025141020.192413-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025141020.192413-1-hch@lst.de>
References: <20231025141020.192413-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Propagate the per-queue stable_write flags into each bdev inode in bdev_add.
This makes sure devices that require stable writes have it set for I/O
on the block device node as well.

Note that this doesn't cover the case of a flag changing on a live device
yet.  We should handle that as well, but I plan to cover it as part of a
more general rework of how changing runtime paramters on block devices
works.

Fixes: 1cb039f3dc16 ("bdi: replace BDI_CAP_STABLE_WRITES with a queue and a sb flag")
Reported-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Tested-by: Ilya Dryomov <idryomov@gmail.com>
---
 block/bdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index f3b13aa1b7d428..04dba25b0019eb 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -425,6 +425,8 @@ void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 
 void bdev_add(struct block_device *bdev, dev_t dev)
 {
+	if (bdev_stable_writes(bdev))
+		mapping_set_stable_writes(bdev->bd_inode->i_mapping);
 	bdev->bd_dev = dev;
 	bdev->bd_inode->i_rdev = dev;
 	bdev->bd_inode->i_ino = dev;
-- 
2.39.2


