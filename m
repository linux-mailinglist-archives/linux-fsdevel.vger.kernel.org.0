Return-Path: <linux-fsdevel+bounces-16695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B84B8A17E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC641F22A0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F2C14F61;
	Thu, 11 Apr 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TGHzVYC7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC6134A0;
	Thu, 11 Apr 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847237; cv=none; b=G2xdOw4twaMfCqhSwdeEcvv5X7g/mkmvRklLpGyCZseN0WcBFN7Sg7wl81RzqD/0EL+zDZ/UBDcFUQMCJ9E2p4AWbBS6e7byCaeg4de0YlU0E/jqttjJOAqPnTNeIGSfD31ISHTDM1SvVyBK5RNJOaJVUY6sH9gH4tLmi1zyV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847237; c=relaxed/simple;
	bh=kcUVtqFQOKVhwwuMvsaOHzJkM7yJ+ffZoSHBymh0Wak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8CWp5D0oI4b7QpUKCOeNg899RRmnyJUuaY86EVsZCqSxDkLipK+x3HCLzWCbNxIKEx5Olmf5UEZMlP1AP8QpzvrJ/E/TMbTwsrf78di4L2ItmwI/LWoxFlWJoCmMIb1oeGzVf41KjkvzXcdX+3xxzQ3dggjW472w1HYcu8fWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TGHzVYC7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JZSu+6dHfqSmTDvZYgjbxhayI5b7aTjc5J1y3UDNB6A=; b=TGHzVYC7asqrofgX1Tlvry+4rj
	Arj5tlxEimlgL6lXqUaLCR6eKQPWgjOCyoGJlPfc99ewMRKKMWyLJtGI0gwojXRdEntnpnm5c3iht
	6H1D6VGkW2MsW3Hs77CPlu70PDFnmZCopyhRnjLtJigEz9tTIUtSGB/+vVJU3DXXlVle5qDg5++10
	NPvLwsgIY0Zh/w0R/J/Jybm4WqA0WzQnVxDfZs7lQrDtkW7RdSi1sz0T17AhtVWRkBQ88TqaEMG8a
	B8UBxigpOe3RGbyPDkHfjRH97QQ0eHf0JBWJffsGP202WllIamn/uIvaz49oEGD15EJXxlv6ojjFw
	Mdbxfi4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruvoC-00AYlI-0q;
	Thu, 11 Apr 2024 14:53:48 +0000
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
Subject: [PATCH 11/11] block2mtd: prevent direct access of bd_inode
Date: Thu, 11 Apr 2024 15:53:46 +0100
Message-Id: <20240411145346.2516848-11-viro@zeniv.linux.org.uk>
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

From: Yu Kuai <yukuai3@huawei.com>

Now that block2mtd stash the file of opened bdev, it's ok to get inode
from the file.

[AV: use bdev_nr_bytes()]

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/mtd/devices/block2mtd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index caacdc0a3819..b06c8dd51562 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -265,6 +265,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	struct file *bdev_file;
 	struct block_device *bdev;
 	struct block2mtd_dev *dev;
+	loff_t size;
 	char *name;
 
 	if (!devname)
@@ -291,7 +292,8 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		goto err_free_block2mtd;
 	}
 
-	if ((long)bdev->bd_inode->i_size % erase_size) {
+	size = bdev_nr_bytes(bdev);
+	if ((long)size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
@@ -309,7 +311,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 
 	dev->mtd.name = name;
 
-	dev->mtd.size = bdev->bd_inode->i_size & PAGE_MASK;
+	dev->mtd.size = size & PAGE_MASK;
 	dev->mtd.erasesize = erase_size;
 	dev->mtd.writesize = 1;
 	dev->mtd.writebufsize = PAGE_SIZE;
-- 
2.39.2


