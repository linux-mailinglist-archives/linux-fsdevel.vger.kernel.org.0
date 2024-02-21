Return-Path: <linux-fsdevel+bounces-12219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A8085D1E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 08:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FAF4B26A31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 07:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB3A3C464;
	Wed, 21 Feb 2024 07:55:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F83B199;
	Wed, 21 Feb 2024 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502140; cv=none; b=u2WwjizXxLPvu6aVh2D1s/jhcuQxTMMVmA8rn6vwrEwAtjpe916M2tukQ3iiG2cKhmD4l/0JJM9XsGWnjeALNPNZsCNjP+yeGeQKjv+KvbHNTWno9y/xU/LKBAFk6PukGMIIA0nJnsnf11l2/tMLiL5HAFTf+snRDsxa8lTuYG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502140; c=relaxed/simple;
	bh=5qPfkNy1DFd4622RFuqwJ5cJKu0Oocx4ULCnkiyPhvU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hh1mLJrEp/yczwpyXM5nE3E4+EOoNObmHhw2hNhXAkCuL/pwN/rCBvucETDB7/KPMO4GPCwLjqge9rbCXsV4s2gx9a2s7P23Z2j+1gv/EPMj8CIxthMospHUSWJY+RHWXbPpGc6+ekDycghHF946Q62VMo+oyGjxFBxJ+KJK/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41L7rmhs061563;
	Wed, 21 Feb 2024 15:53:48 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TfpRY1pdWz2KGjJg;
	Wed, 21 Feb 2024 15:53:13 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 21 Feb 2024 15:53:46 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang
 Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH 2/2] fs: introduce content activity based ioprio
Date: Wed, 21 Feb 2024 15:53:38 +0800
Message-ID: <20240221075338.598280-3-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221075338.598280-1-zhaoyang.huang@unisoc.com>
References: <20240221075338.598280-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 41L7rmhs061563

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

This commit would like to introduce content activity based ioprio into
general aops and def_blk_aops read/write API, which account the
content's(folio) activity and set the ioprio_class accordingly. This
change do NOT violate previous ioprio policy but only promote the
value if the activities raise to certain proportion, that can be
deemed as both of the IO launcher and the content's are important
for raising the priority.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/iomap/buffered-io.c | 3 +++
 fs/mpage.c             | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5db54ca29a35..5079395d6823 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -390,6 +390,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		ctx->bio->bi_iter.bi_sector = sector;
 		ctx->bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
+		bio_set_active_ioprio_folio(ctx->bio, folio);
 	}
 
 done:
@@ -624,6 +625,7 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
 	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
 	bio_add_folio_nofail(&bio, folio, plen, poff);
+	bio_set_active_ioprio_folio(&bio, folio);
 	return submit_bio_wait(&bio);
 }
 
@@ -1742,6 +1744,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 	if (!bio_add_folio(wpc->ioend->io_bio, folio, len, poff)) {
 		wpc->ioend->io_bio = iomap_chain_bio(wpc->ioend->io_bio);
 		bio_add_folio_nofail(wpc->ioend->io_bio, folio, len, poff);
+		bio_set_active_ioprio_folio(wpc->ioend->io_bio, folio);
 	}
 
 	if (ifs)
diff --git a/fs/mpage.c b/fs/mpage.c
index 242e213ee064..f209e5860423 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -308,6 +308,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 		goto alloc_new;
 	}
 
+	bio_set_active_ioprio_folio(args->bio, folio);
 	relative_block = block_in_file - args->first_logical_block;
 	nblocks = map_bh->b_size >> blkbits;
 	if ((buffer_boundary(map_bh) && relative_block == nblocks) ||
@@ -626,6 +627,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		goto alloc_new;
 	}
 
+	bio_set_active_ioprio_folio(bio, folio);
 	clean_buffers(&folio->page, first_unmapped);
 
 	BUG_ON(folio_test_writeback(folio));
-- 
2.25.1


