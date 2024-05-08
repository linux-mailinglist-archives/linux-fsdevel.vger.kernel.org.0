Return-Path: <linux-fsdevel+bounces-19012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4158BF675
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE76E1C2143E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B10286AF;
	Wed,  8 May 2024 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WcPIgnjW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13771E868
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150586; cv=none; b=UMkrur1scCfVMjOkrh0W5TyOYdb335SQlBY87tnuG+cUb5ApjVciJl6KluPUrggXOFu/8kee9oLpZTc8NB/MThg+xXgELuSutoUqsb6RYyf4j3vse7IehYG1R7cINtS7tvJajdhf9M3wE98TE2Zn5POUJtYuQdTzdAWVm8/eXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150586; c=relaxed/simple;
	bh=c/LfkIG3OKV3mBy7vmW75Qz2v/e3S6TjvRxEBwxCngg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z7UK3gpU+BnhHSV9cBGvVKWh2LAF8dXOlzy9jH1W7oK96q1gjiad5kEsM78vO472XX4My5to3Q8FAfQVnEuMFbVBGraZzkAge7YwSbt8vpXavHOtbaqdhWuBwDhuE6Ht/0LiTaDCECo6UGjrk3lpeGdPnW8dZsvLJt4m42YcBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WcPIgnjW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2BLWewjM35s5NMQmlkBJWYQMcLrPzus45j304Q0c6m0=; b=WcPIgnjWCopFi/mlZeg0ju5qAl
	xftBUdmbR6rzxBH1U3omp6/ZRdhdX/kHRZzdMGD5r2Qe/uDEPFnWrHd9uOl9VbdfcL1iK4imZKsTU
	gUSHbp+iDKu8dcXGhAoWMq/W2+ORRHrv2ZwdzFa3M26blB/q7XV+p3Uu4Qw+ctz+oSTZcXdBn6UIR
	+7QGzjsuC1iW/VfyEVU1XtCnXKLHxWvn0QxYfd9dxPF6c5wHBrd0IiNnbqOFYeG+BPpBX+ExQRX2z
	q0Lr9ixeawSNxVEUuR0b/346kqvykiTmI06ThyA6q7QP7i+Oz82AHqT6Qyow89Rn93fvDuLGMaJHp
	C44cRPcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b14-00FvpG-0w;
	Wed, 08 May 2024 06:43:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 1 4/7] dm-vdo: use bdev_nr_bytes(bdev) instead of i_size_read(bdev->bd_inode)
Date: Wed,  8 May 2024 07:42:58 +0100
Message-Id: <20240508064301.3797191-4-viro@zeniv.linux.org.uk>
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

going to be faster, actually - shift is cheaper than dereference...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20240411145346.2516848-9-viro@zeniv.linux.org.uk
Reviewed-by: Matthew Sakai <msakai@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/md/dm-vdo/dm-vdo-target.c      | 4 ++--
 drivers/md/dm-vdo/indexer/io-factory.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-vdo/dm-vdo-target.c b/drivers/md/dm-vdo/dm-vdo-target.c
index 5a4b0a927f56..b423bec6458b 100644
--- a/drivers/md/dm-vdo/dm-vdo-target.c
+++ b/drivers/md/dm-vdo/dm-vdo-target.c
@@ -878,7 +878,7 @@ static int parse_device_config(int argc, char **argv, struct dm_target *ti,
 	}
 
 	if (config->version == 0) {
-		u64 device_size = i_size_read(config->owned_device->bdev->bd_inode);
+		u64 device_size = bdev_nr_bytes(config->owned_device->bdev);
 
 		config->physical_blocks = device_size / VDO_BLOCK_SIZE;
 	}
@@ -1011,7 +1011,7 @@ static void vdo_status(struct dm_target *ti, status_type_t status_type,
 
 static block_count_t __must_check get_underlying_device_block_count(const struct vdo *vdo)
 {
-	return i_size_read(vdo_get_backing_device(vdo)->bd_inode) / VDO_BLOCK_SIZE;
+	return bdev_nr_bytes(vdo_get_backing_device(vdo)) / VDO_BLOCK_SIZE;
 }
 
 static int __must_check process_vdo_message_locked(struct vdo *vdo, unsigned int argc,
diff --git a/drivers/md/dm-vdo/indexer/io-factory.c b/drivers/md/dm-vdo/indexer/io-factory.c
index 515765d35794..1bee9d63dc0a 100644
--- a/drivers/md/dm-vdo/indexer/io-factory.c
+++ b/drivers/md/dm-vdo/indexer/io-factory.c
@@ -90,7 +90,7 @@ void uds_put_io_factory(struct io_factory *factory)
 
 size_t uds_get_writable_size(struct io_factory *factory)
 {
-	return i_size_read(factory->bdev->bd_inode);
+	return bdev_nr_bytes(factory->bdev);
 }
 
 /* Create a struct dm_bufio_client for an index region starting at offset. */
-- 
2.39.2


