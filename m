Return-Path: <linux-fsdevel+bounces-18004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4B58B49CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 07:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9FE1C20CA4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA5553BE;
	Sun, 28 Apr 2024 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vHE07jo1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BE320C;
	Sun, 28 Apr 2024 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714281583; cv=none; b=H34i/ITRk/Ns9yZHAq5hytN4WMth+g97msy63eHEVVzE6dO2kcgUZ3egxN71o360fqbMHjzf6T8pSFRNbhizsm/5SjCw8+N4c3VcdcWO7+S/f3Hv7XyQQ7XS0ddbYJ7vChlV/Z9z9t+PS/59q6yzy+oQvq4bixACExiV9zNMqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714281583; c=relaxed/simple;
	bh=5aNW/JcDN2+X23Bke8nP2Qy4FDcNgexCJHLMUNXkqpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4knXcJHZJ7WvVpVAeftpmqbNmISrat2p0WludT2M2UAkHmGRNnn6EQkiJPa2cpREoTHO3qucvQ5Wey7tQfvACFc5VBh7SOkNugdq8jjGuPgG1FffUCwvfcW0+xtMXDdC+e7s6lvmwhF0AKTERQNNyie9XfELNpDbsLxsMd1ZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vHE07jo1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AjleHgbiW4gZwTUlHqCfArxk8aQfvqZ3X8uYfRsghBk=; b=vHE07jo16YpQU9BtXSstG2BEjE
	O4/NzT7wYkzwjYa76X+wvD3kZLjqgnpPX9UGy8BX3PSa+bRV2DdqZC6Lcf6cm4jnxBH76AKdrbXt0
	yz3tYzwURdtQHowGYmu6nej58/gukHi8yU5F7QZPeqd3Q6UOZm+7wmV+evxOWiqoWjSnEY+lKndU9
	kL4sXXoTdysnE8Th0o9jI2hNSc/eN1XECPjiFKXtMLrezXxCHi9nMBXvnb5CPEcFlEnkpgyQCuAGo
	Bg/YF2pIPmMSNMHrkiH8bZNs92I4vUQG8eBbh1iH0aG7I5S6HetYaSayDbcyfOBD3H/OOVm6irP1v
	DyamXTdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0wwu-006VPg-0c;
	Sun, 28 Apr 2024 05:19:40 +0000
Date: Sun, 28 Apr 2024 06:19:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/8] bdev: move ->bd_ro_warned to ->__bd_flags
Message-ID: <20240428051940.GG1549798@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428051232.GU2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/blk-core.c          | 5 +++--
 include/linux/blk_types.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f61460b65408..1be49be9fac4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -514,10 +514,11 @@ static inline void bio_check_ro(struct bio *bio)
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
 			return;
 
-		if (bio->bi_bdev->bd_ro_warned)
+		if (bdev_test_flag(bio->bi_bdev, BD_RO_WARNED))
 			return;
 
-		bio->bi_bdev->bd_ro_warned = true;
+		bdev_set_flag(bio->bi_bdev, BD_RO_WARNED);
+
 		/*
 		 * Use ioctl to set underlying disk of raid/dm to read-only
 		 * will trigger this.
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c8f5364b24f1..59de93913cc4 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -65,7 +65,6 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
-	bool			bd_ro_warned;
 	int			bd_writers;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
@@ -87,6 +86,7 @@ enum {
 	BD_READ_ONLY,		// read-only policy
 	BD_WRITE_HOLDER,
 	BD_HAS_SUBMIT_BIO,
+	BD_RO_WARNED,
 };
 
 /*
-- 
2.39.2


