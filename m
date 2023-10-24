Return-Path: <linux-fsdevel+bounces-976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636E67D47A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1654F281936
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 06:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB9125C8;
	Tue, 24 Oct 2023 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LbsFIHIa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E010971
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:44:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6B3DD;
	Mon, 23 Oct 2023 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Xv0Y7MMN6a+oO5YWZ9vpRkvqCfuPiGUZ4v0gSgQ4Fio=; b=LbsFIHIaMCxJK5tHyXHay27Tpj
	0aMIGXw6DujKIybLgCJyppua7cZTABksNxgjpULkWeufdVhy2DR4tImheev61lt+bUJVdzkbAyRJf
	TiLWyG+7G5LSn3Z3tq3hbiI0bEU3JiOMlA2+aPMAOnQ1TkJ6rKJegATMhaWnO0hkLOKuikj+ETiYi
	4GI+mG3g+TmTne4T+QQA5YEP9rgNldFXZWy3SCjN0kFegAOqXb5l9CSJYDShQLtNCAq1enB5zZaXR
	CXRHTj6muUCEt5sPaPDSl+ZW2FFxKkWLwcZKhPXGp/FCX/Dns/BDyxnH6AxR22KqReTfq0saPB8k1
	8MjFBsXw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qvB9N-0090S8-1j;
	Tue, 24 Oct 2023 06:44:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] block: update the stable_writes flag in bdev_add
Date: Tue, 24 Oct 2023 08:44:15 +0200
Message-Id: <20231024064416.897956-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024064416.897956-1-hch@lst.de>
References: <20231024064416.897956-1-hch@lst.de>
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


