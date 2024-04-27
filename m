Return-Path: <linux-fsdevel+bounces-17979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAB58B4836
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 23:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287D12825E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 21:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E406145B3E;
	Sat, 27 Apr 2024 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X3sQcUSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3177829C;
	Sat, 27 Apr 2024 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252236; cv=none; b=VkmVg2wAEt8A6xBhKtoQE8KwE66Q/EtIEIXNJRPLaatD/vbC0xJ92Z9i5i2yjwR1fsKSG34xCLg4Z4JDIlNn+jj35A7W4aNpetsolf/E1IQL7npjl2TWvfOb3ePdUY0Ew8tfppj/pJkJblZZaXt+M/oWZJHS00K6p4bjnqk7pqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252236; c=relaxed/simple;
	bh=keXklkI5MpK+WSOJstDI2j7Is+66EDTxHHrVeD4/YpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjaoxRIFeH8ukA0M5HTiLqfbXdokWLOUC2II0juvmA7VqN9PBzHzN2gGPAI1949YzT5bNWPgcaPGVwZQzKTKALallkL1bonl/t0bAiYHih8FY1jJqxO/6ac989tANflBT4P7RIRI/oyIrv+3mmbJF51acf7FH4XvgFdjvZkBDao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X3sQcUSY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0qlr0K6sGy3kLxE9t546t+u43Rg6mO6BGU1U6yKNgEQ=; b=X3sQcUSY8DO28QtKAPTqvw2YZR
	7wJEBmHL1p9UUTkkozrZ3OZVHqCAJav3cdl388Cbxb+1dJF6GR1VfPavqNsHwBp70BZt/H7KUsYig
	DQ8gDSFSTy2c2cuxquHethWunJUWC7CUfp6ldlKZIt2zYgwA1a48tGqDhW0nFYRVi1w2zIYNKWyWP
	XvjmdGyikmK5byznTq+4F5bVFfDFeQDQmlcf8iPij3erRhv75wWPa0cUUC2y4Y99cxzkn/+y8FRC/
	BNY5VLWRMuIa4vzeDke7P361ytkyY8A4gzMUJUNA75OISehOsiG950ws3oxaYVr3wTrSgWKMVUP7P
	66wF9E/w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0pJY-006H3K-2k;
	Sat, 27 Apr 2024 21:10:33 +0000
Date: Sat, 27 Apr 2024 22:10:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/7] pktcdvd: sort set_blocksize() calls out
Message-ID: <20240427211032.GB1495312@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427210920.GR2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

1) it doesn't make any sense to have ->open() call set_blocksize() on the
device being opened - the caller will override that anyway.

2) setting block size on underlying device, OTOH, ought to be done when
we are opening it exclusive - i.e. as part of pkt_open_dev().  Having
it done at setup time doesn't guarantee us anything about the state
at the time we start talking to it.  Worse, if you happen to have
the underlying device containing e.g. ext2 with 4Kb blocks that
is currently mounted r/o, that set_blocksize() will confuse the hell
out of filesystem.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/block/pktcdvd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 21728e9ea5c3..05933f25b397 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2215,6 +2215,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 		}
 		dev_info(ddev, "%lukB available on disc\n", lba << 1);
 	}
+	set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);
 
 	return 0;
 
@@ -2278,11 +2279,6 @@ static int pkt_open(struct gendisk *disk, blk_mode_t mode)
 		ret = pkt_open_dev(pd, mode & BLK_OPEN_WRITE);
 		if (ret)
 			goto out_dec;
-		/*
-		 * needed here as well, since ext2 (among others) may change
-		 * the blocksize at mount time
-		 */
-		set_blocksize(disk->part0, CD_FRAMESIZE);
 	}
 	mutex_unlock(&ctl_mutex);
 	mutex_unlock(&pktcdvd_mutex);
@@ -2526,7 +2522,6 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	__module_get(THIS_MODULE);
 
 	pd->bdev_file = bdev_file;
-	set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);
 
 	atomic_set(&pd->cdrw.pending_bios, 0);
 	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->disk->disk_name);
-- 
2.39.2


