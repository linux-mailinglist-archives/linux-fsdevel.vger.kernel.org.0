Return-Path: <linux-fsdevel+bounces-16692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D118A17E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524491C2246B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE48B12E7C;
	Thu, 11 Apr 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LAAEzFJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291C749F;
	Thu, 11 Apr 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847235; cv=none; b=hjQAepT/hVySrWQmUVRfxB2WwBgvz45gspVDMQ4DTocvg9m7mwPx3l4HbuXODqQ2LSVcAtCq0eW2q3H/fyt6dTTiAFiVN4D3smNNxv8O95xcW3ihngAcqSTkRyddbeH38De1TJ6Ve9feIy+OvFBffvQwfa67pUNvqw5aNzqx7IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847235; c=relaxed/simple;
	bh=j0sIk2sj3Fwft4fpYSFtpNuxji39MAf7IdeHbajEMsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=usdPCUbaZkfL2BhTsPdcgIBkxlt41ORqJhi0X9t4ToIGgISOVTCu5sJIpCvV+Rc4SYJF+yhHndAFLghQVNS+svaREaQNYpqfI8C1Yv7NyN7aBP/pmGTna+lxZfiKZ1JNYZMCAY/eNh+crz6TQikAaqHZDosHKz6p7Jw7Sgupqvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LAAEzFJS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/X+RjE0cR7UsI2jyr7Q3/67hAUaqXlL7EqAxyCC+IZw=; b=LAAEzFJSDkcSmIMJ1UGMzYfSvy
	sR6RtZ7f/ltNZ/qB2lIhZM7XUGlIvuO3e53L6KSSyFqxEznvfrTHyiFjbug/tOrJJoHp1PqcuA13c
	+U2IGJwHSWJOuHWwu7JyCpA93kbpZL6G2A9YPSYFlzA9OtlqPkLmfuGx1cKT5mFXdtiKTr4pqv0dW
	Czk64U3uS7/cOvBOltAFgioKbBKYh3slo0ldpmnlSA1QdXbb3idzwaxOWtSWgg82EF3WHWkCC/lIE
	7OmoyGAuYCp6JO00oSbE/JAaA+kG0KN2rjrpZ2OQ6YwD3h0fuOCOlA+E8SmwkUaa5M1HmFk+Msw63
	QgPa1fsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruvoB-00AYkg-0M;
	Thu, 11 Apr 2024 14:53:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	hch@lst.de,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: [PATCH 05/11] blkdev_write_iter(): saner way to get inode and bdev
Date: Thu, 11 Apr 2024 15:53:40 +0100
Message-Id: <20240411145346.2516848-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
References: <20240411144930.GI2118490@ZenIV>
 <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... same as in other methods - bdev_file_inode() and I_BDEV() of that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index af6c244314af..040743a3b43d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -668,8 +668,8 @@ static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-	struct block_device *bdev = I_BDEV(file->f_mapping->host);
-	struct inode *bd_inode = bdev->bd_inode;
+	struct inode *bd_inode = bdev_file_inode(file);
+	struct block_device *bdev = I_BDEV(bd_inode);
 	loff_t size = bdev_nr_bytes(bdev);
 	size_t shorted = 0;
 	ssize_t ret;
-- 
2.39.2


