Return-Path: <linux-fsdevel+bounces-18569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181998BA5F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 06:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D951C21E3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 04:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A38208DA;
	Fri,  3 May 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OJhC11y8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8A225D4
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709864; cv=none; b=rKgkQw2PvrdGyLvm29gf5FJ9kEO19i+k/PWMO9VcMjV4Df9ZsJ2mNWQFWxxV4g7CxSpkmdijLiSLpnFbjv3sENpGCkYz886MBTMdG1kVqbD/cLHkcMC6xxxJclvJypG7bWVcU8g2XzZZzM+jU8b0xHZsal2aOEHPCowGV6kZjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709864; c=relaxed/simple;
	bh=NpjlpBasDw/z7FV1LoIobqFo0v4WkLpRVIntjnupysE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqGwohJj524jQDIWgKNdoKP9Sxc0lOKjrXG7Dva0jBTHcUgkLZX6lpkutoQZfeQ5YWYlDn4andhTUgtDonZiHoqcVe/1ZIwK519pV4Ra+DktjArlIqxN9SdYvp6n1ZHO0Fsd11rLyVjvVYTL/pLb2CzXlRDti5Dpub4e/6ERAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OJhC11y8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=sfJK1PqnCoZ9wUJOzrwSCQ9cwiM2bYAFjnNUULTe6yA=; b=OJhC11y8NPKGznDjgKSIuT3HY8
	E4I1SxTrFyWHK+QUhyOYlb/O5ILjegXNr1L31f7FTQ+Q2TC6SynUVJ9zKf0Gf4lqqNnQwMry33eT2
	zu1bD2gYMo9rLOZILOdBzNfydcOQwLubMtCg7VeYYnRm6fugU+u8VP/L37pgEjYp32focq0ra2MBO
	C2atz8ax28oeSBD1oWtDVMZEq7v4kbCGAzGlR9mzLASYnz3ovamIt3NqQHCoHZlLMcLejXgwLaUIs
	rSlrhOwOFJD9YyuKjpCPg6DRsaBsMTu0GoO1cl/ScgflXqKZlZIRHLlCmyIhYkWvUVyhFXP+PZCY1
	0sOLCfkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2kMe-00A5VD-1h
	for linux-fsdevel@vger.kernel.org;
	Fri, 03 May 2024 04:17:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/9] pktcdvd: sort set_blocksize() calls out
Date: Fri,  3 May 2024 05:17:33 +0100
Message-Id: <20240503041740.2404425-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
References: <20240503031833.GU2118490@ZenIV>
 <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
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


