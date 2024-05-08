Return-Path: <linux-fsdevel+bounces-19009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCAE8BF672
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB632821D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B024B21;
	Wed,  8 May 2024 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bHBGh0f5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D682720DCC
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150585; cv=none; b=kLgf+Aw44wp8h9mN804zu6T0oNqhPF0N/mMPzJjiaoTqlDWRzaPlRx0zA8yeXhCGOeaeIdMlGhpYKPz5h9K61p6q742KntAswEoh4DhMQVVp+wu7A1G+5gl4Q/EVlWX02KnqhNxm63biY2oU3FNoJKFxzKfzQEklX7q280WRBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150585; c=relaxed/simple;
	bh=6zGn5vkpjtaojVe8dx4j692J0Ws0QzGVzTmjYahWxKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mn0VbgxT/j2bRpljXOtg1bXkS82LICAnZewHRqzuB7EGKtUiPp0Ok12OHse30emPM5jIxjDoGo0J7gWDdZzy8q2g09ObdsFhHLxytr5W8VHMUgB7fSLN2FjcvWGpqrNHZWjP7pKaDQjYnZWKaJl3Y1P2TvdNxlVArzLURNqOM/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bHBGh0f5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=A80ql/fjXXwEvWMM6caYngfY8ceo3/ObTxd/L6fIV3I=; b=bHBGh0f57iuv6877li4O+Upyhm
	zoXMenlVXohfq/8Jz914iEyR8ctZ98mTXqEOe2H8hlb64EvhyqKxdIwQ2xqmHtv7nwRfAOx3F+ADp
	G64B1OchgUwNKq82HuN4jA8u7TrHK025YekWHhFfopAgjMCeZp81pe9Qc0jUV7tHbaibPGwSYwNgK
	zE8YKE978zply3AGnYzIfam4qwME8QWPD1aPvTwhY+ASjutNB8JcmkjUs1kA/XtGhsyxz+RK3+1d4
	mbAzKFFoiNNfB76KLPCQz4+6TeCX0PjMdVidrT66YbEMzuzj7u6PLFNv860QAGfKikrG04pJRDIaf
	PjW9J48w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b14-00FvpI-1H;
	Wed, 08 May 2024 06:43:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 1 5/7] block2mtd: prevent direct access of bd_inode
Date: Wed,  8 May 2024 07:42:59 +0100
Message-Id: <20240508064301.3797191-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064301.3797191-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064301.3797191-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Yu Kuai <yukuai3@huawei.com>

All we need is size, and that can be obtained via bdev_nr_bytes()

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20240411145346.2516848-11-viro@zeniv.linux.org.uk
Signed-off-by: Christian Brauner <brauner@kernel.org>
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


