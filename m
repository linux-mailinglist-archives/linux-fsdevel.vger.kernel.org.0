Return-Path: <linux-fsdevel+bounces-26432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F4C959493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1441F23ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251C16DED8;
	Wed, 21 Aug 2024 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LcfxGoka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70B1607A1;
	Wed, 21 Aug 2024 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221878; cv=none; b=E2KQf4taSij2AJfMJSPgag2uqhXNZklV2lD6dkSvHKs0nWaLN0dhOLCUqacaVREmQ6HtBUg6bxLyEEnG4zhh7pvR4JJJ1IRZlZvDOm/VdNxRndgyhDrjVlgTH+gFx+vw8SnqJ3VK7MWpx9gFS8b7LkosutjlJZM4Q5V2OxZAw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221878; c=relaxed/simple;
	bh=GFDgSREkc10KvJibkFoMGKetqK6/aq+WcOR08cWF8OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tu4C3TaolS26+4vP8SxsiueMRVQQNBHSmtKOZNMdatNued6Y1IKU/zEQKea4mSskZ9o8/GQqdHf6jIHbt6ApH5s/gTYGMrk51R5Y03oRLKA+4x8Rxz2pbFitwLQKy05BIjq1qQtR2DNmWZ0Uu0Z+W1j1xmivgTjAOV3fNE/PrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LcfxGoka; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Qqxbe0v5qYjyQtS6Ev502TIe5IRKBV0K7OLmDV05ewU=; b=LcfxGokat+1LtbKSu1S3loENSZ
	JfButhNPHwANdWcXWNnuQbk4fzj6ehB0CJrIGSscHHgteRJCj5K17aQR36cjrjarqqSmumVRoQRYT
	VEDSjB1L4Nt/hBj8EqFe9ztSyH0KrugiFQpSaULfQH/cXA2u+bu3S/aV4YXHdzr2kXvLNErpOxZxw
	q25CCh1ab7GCztdq/OGEY2Ax/nuL8NNQNIOxLEmZRV//YimAS6UlXPy2/TwZhmdEOQr6/b6ZMxQtm
	8PZRK+OxWM0fWdg+TpgesKAB+AZ84hISBGm106RDb9K8k98KTJLOTeFxp8r9zuxAdIfmPGxFDTLlW
	Wyx82BRA==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgesD-00000007iQs-2rTS;
	Wed, 21 Aug 2024 06:31:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 1/6] block: remove checks for FALLOC_FL_NO_HIDE_STALE
Date: Wed, 21 Aug 2024 08:30:27 +0200
Message-ID: <20240821063108.650126-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821063108.650126-1-hch@lst.de>
References: <20240821063108.650126-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

While the FALLOC_FL_NO_HIDE_STALE value has been registered, it has
always been rejected by vfs_fallocate before making it into
blkdev_fallocate because it isn't in the supported mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 9825c1713a49a9..7f48f03a62e9a8 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -771,7 +771,7 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
-		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
+		 FALLOC_FL_ZERO_RANGE)
 
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
@@ -830,14 +830,6 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
-	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
-		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
-		if (error)
-			goto fail;
-
-		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL);
-		break;
 	default:
 		error = -EOPNOTSUPP;
 	}
-- 
2.43.0


