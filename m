Return-Path: <linux-fsdevel+bounces-16700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C878A17F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A737F1F22639
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFBC17C96;
	Thu, 11 Apr 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h/IFe6E8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E8171C1;
	Thu, 11 Apr 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847241; cv=none; b=Vm9HKdJJ17pPk+UTtBKdIhtvrOYZZTljVsWMOAtDAddyQ25WHuZiI7Tp/bFWlpk5dHEtkHxrb4eycLiPeeWhUzBvTqiTnSlPKoloDC09Qp/iLtp+xpND2lFAP5+CaIBzTVSjjx+KgX4z9DWr0xxCvBlYD1PNNlwl6+IEZVm41hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847241; c=relaxed/simple;
	bh=yz0fPQRur9PF5tZZWJEaNZTXMumF0k9BRteSxFOys5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSKrg7eam66rRd09g9ahg4zUeBotc5Mr8WyCW2xKCP4Nnq99NDeZZfCDbY/Om1UnrKh6ByMx+sZpndEXjC7aGHKkXcMz4Rq1FFHB4YKP7H1Z3SYGQ1wKnCZ7LmaqQRkWyk3dQNr3CYwvDS6gqFaekEBVP2B7VR4mQ0L2Zs7XevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=h/IFe6E8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KGEPFBMj+JXg28PqPg3HNRvQWllGw5jqmhRObH4YP4Q=; b=h/IFe6E8nqgPFBpSLeMc2quPJz
	LlvfJbQ2YH5Qq11qbshqzvC9XHaKtoqez1LscSrKMLU2qVVrbOAafWYA4NeCIVHEnpUPa5+2glugR
	80ou7qBGAqhhqxEdlKxHClDVuR70UQUT3DkpMQFi9lR4lk04qjg2Dt4YZB656OjAOTglIvzWxxnmg
	mitg+/VBL6i8d/N1jI2x8K9AFl0+gnlo87EQf/kfTvpB2UVC0Tw0s07spDusM+md8+QscjzooHYDQ
	Wcu8MjytutH15arB37yDgckTcD2YUFHaD51LhpQ1pgyw17/38aC3lMocB6DGNuJ5NGmyMyp4gMtPC
	LenHD88w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruvoB-00AYl9-37;
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
Subject: [PATCH 09/11] dm-vdo: use bdev_nr_bytes(bdev) instead of i_size_read(bdev->bd_inode)
Date: Thu, 11 Apr 2024 15:53:44 +0100
Message-Id: <20240411145346.2516848-9-viro@zeniv.linux.org.uk>
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

going to be faster, actually - shift is cheaper than dereference...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
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


