Return-Path: <linux-fsdevel+bounces-34605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF749C6BCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D638E1F21B8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B90C1F8931;
	Wed, 13 Nov 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfjqClc8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C818B49B;
	Wed, 13 Nov 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491254; cv=none; b=MY0tfltQdzMQr/UDIkl3yyRJacRvIV4ggksX1PCdk/eS/BaKW7yg0X6ftji1RpSUd2Te5M/xndFw1ar6/B5Id888RDiCAYh6P3tmf8mT6g8A2i2DqEgdkvPN9z6u7N5lxeBS7t4inD0yvNZbRa4vLJ54t05qQOw7Zy2uLKHI5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491254; c=relaxed/simple;
	bh=SsLwRYjDnZhLjFEWH6rmXr0rjN+JdjyyGgFfERa/yfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKVUu18jx0PnhQc6CE6Zj4/lcIZ1oljesD0w7M+PKiTEjd/Ql4qzHbatNVS+m5GGTBorDZHgrIe806a767lBK2vX0qbDX9xR6HbBcWWepR9IfvoNT2l5cvS0a9368rE7Z3RSP4KnBEijBNfCPI1ioIEZ7aYMo3J4BO6ipCemJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LfjqClc8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rV5AoYJPlny/7wnGoBOtLs3pAmaEJ9e3y3MRINCsK0A=; b=LfjqClc8gfoI1goRIcRzOCl8nx
	xMnODzqL5tTVLpi+FvD7+C5W+4VSWGyWxc3O+VSWQZQAFTpyXCMMObOBJng3DiVAWzZqWif6ybCFj
	1O1EBmG6ZyQqRd7CWreGNvgE2bM6bDPeON3eWYpp/4tFR3VOGoX0DFrJqQzJ7C6ny88TS5jTT7n1X
	yTUGmwZ3qBkBY2FU9WcxTHWk0AbZ9o2XGr7dAUgRXdjhPETrSapitHz1jEMeQiNIgVshgBIZn2Sgx
	Qr15Lt8fMF2tYztfz6bjVjeNmc1SCe1W0+wSBLZl6BK/QX4jkKp9xyyHWp6S4SE3bG7wcsx39c4Cy
	/3lmBZRg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB9yD-00000006HdB-1F85;
	Wed, 13 Nov 2024 09:47:29 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: willy@infradead.org,
	hch@lst.de,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	kbusch@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC 5/8] block/bdev: enable large folio support for large logical block sizes
Date: Wed, 13 Nov 2024 01:47:24 -0800
Message-ID: <20241113094727.1497722-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113094727.1497722-1-mcgrof@kernel.org>
References: <20241113094727.1497722-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Hannes Reinecke <hare@suse.de>

Call mapping_set_folio_min_order() when modifying the logical block
size to ensure folios are allocated with the correct size.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7..167d82b46781 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -148,6 +148,8 @@ static void set_init_blocksize(struct block_device *bdev)
 		bsize <<= 1;
 	}
 	BD_INODE(bdev)->i_blkbits = blksize_bits(bsize);
+	mapping_set_folio_min_order(BD_INODE(bdev)->i_mapping,
+				    get_order(bsize));
 }
 
 int set_blocksize(struct file *file, int size)
@@ -170,6 +172,7 @@ int set_blocksize(struct file *file, int size)
 	if (inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
 		inode->i_blkbits = blksize_bits(size);
+		mapping_set_folio_min_order(inode->i_mapping, get_order(size));
 		kill_bdev(bdev);
 	}
 	return 0;
-- 
2.43.0


