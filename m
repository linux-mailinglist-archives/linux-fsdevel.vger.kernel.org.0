Return-Path: <linux-fsdevel+bounces-18554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E866D8BA460
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 02:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249CB1C223DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E371367;
	Fri,  3 May 2024 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s4i+XSN/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3928E2;
	Fri,  3 May 2024 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714695057; cv=none; b=MUzIV6fEmmjfVUVQt+Fw7AZabw7I+XIoYCjcUE3YtIZB8Aw4J6X35yx6rckj0tW/TXRIQzULgWt1lj5kH/m9ZDGzYIxHelCEvnnWRVu6z2u8WF9/Z5ISViZqRZ9ECDHYiUR+9s9f6tE6wvpuEEgKo0iphF1TFR9fgTMHrOTnnp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714695057; c=relaxed/simple;
	bh=keoWL2m8Qea8xblO7xycny8fY7XElzF3E63FokViYeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5LPK8v/8O/McQLN4Dqz5W1zqtSZgYt82oSc4NTs3LD6isJ7kt7C6E6q8GG6jMcWpgxxnf2Ed4wcPMHoZ8Sx6RTA/SGUkhFdzIxmF6NQuH5A5fygTmh69gYTTRlbCC/sCBMEhkVYcIlaGl0A4hz0fGLMN56pvHFuJ+rzBR9OqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s4i+XSN/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZxijnfJaPifRRMZKYO9oyk4tZfBPhRrsYWEdO2vC2g0=; b=s4i+XSN/1hUTbQpBQF2WmJeJSd
	tPY/1EbmoSJMEAzvzSccj0eP9Xd8g03OS3TmOVVhuTlCy9kgISl8DGhEiEgp4+xZfvOeVVhIxKtHV
	HyJ8KJpMkMA+J3c27quy+Q7WWD3NuskuKEWhItdziT9wCtXjUySFLbtJogIFHa3nrmihK9cCv7irE
	0oWa8r0o7TtpGR480r7ymgYPg11AB0P95W+zz6LmhQqrSsl5D4ME3MDd1/ucaXeK10zbBpA6h4O0p
	N/H7etWoJLT6yvD8oCVnzdt7MRTtZ0f7FQqT7igQBvvFG4GHSlAfJACH9uphSpE/qH4x6diZAIPMw
	Ax9FXQWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2gVp-009tRc-1f;
	Fri, 03 May 2024 00:10:53 +0000
Date: Fri, 3 May 2024 01:10:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 7/8] bdev: move ->bd_ro_warned to ->__bd_flags
Message-ID: <20240503001053.GG2357260@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
 <20240429052315.GB32688@lst.de>
 <20240429073107.GZ2118490@ZenIV>
 <20240429170209.GA2118490@ZenIV>
 <20240429181300.GB2118490@ZenIV>
 <20240429183041.GC2118490@ZenIV>
 <20240503000647.GQ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503000647.GQ2118490@ZenIV>
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
index 11b9e8eeb79f..4e0c8785090c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -50,6 +50,7 @@ struct block_device {
 #define BD_READ_ONLY		(1u<<8) // read-only policy
 #define BD_WRITE_HOLDER		(1u<<9)
 #define BD_HAS_SUBMIT_BIO	(1u<<10)
+#define BD_RO_WARNED		(1u<<11)
 	dev_t			bd_dev;
 	struct inode		*bd_inode;	/* will die */
 
@@ -69,7 +70,6 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
-	bool			bd_ro_warned;
 	int			bd_writers;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
-- 
2.39.2


