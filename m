Return-Path: <linux-fsdevel+bounces-17983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A20E8B4842
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 23:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5083A1F21F67
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E38145B38;
	Sat, 27 Apr 2024 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="omTIS9S8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F9A94A;
	Sat, 27 Apr 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252353; cv=none; b=t0zRrF41f6mgG26aXiCVAGqdpR7LFnilTivbGwZtr2zdzjdYxzPjoUqXoCKUc7YTN2UCesHwumq8z8EyP4zJTSn2i7uE8FRJaYWCyVCq1pXvPCl4UIVT3wyrfovAT8rL6x7AyA3LStc7VVbmlhf2zKJqe8NhhNNLvQUwOJZokFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252353; c=relaxed/simple;
	bh=fBiRQG4zecCqFY+7My1+SzX1mZB1ITQwnnWZw52sMRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9zOyVAodgAEeW4KxRuU6PzfybmRNAXjEu4vAlD/MQN8xHPZS7vjSubBGFdRLGI8OLIL8rzoZpXS8mVSV++LhcZ4BvrKqp/0cMCwavmSycLBUeGJtyLNcH4ZqRUMa3pHHgY2sN0tTWyfmxHwqlUQaSi6QMsLs95W7n1m+MMTwCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=omTIS9S8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BEkSoGdMPNYqtxDnNFJLbgBxb+qoovcKUxzy5IqMZzc=; b=omTIS9S86XvOfK19Z/zDAHAOUj
	Y2BpMZI0j7c9/sURct/WamvEk2BuCZxyIo/x5KgpasE2AczMrZTDqcegGBQXtk9AOdhEWorRi4Qbw
	d7YE+0iz7CKwKPEJWSD8QZMaHftIy6r4X8oFVWhNi7fogBzCa3V5CuYNTiWXZFBwUebfnTOcx0Y8k
	AFJkFjyZHjOdw1Uk5IVxJHPH1HXV5TJk7w5clQibvIFVMuU5iJKRjFB2EdBnBXj8b8Uvp3P5zLqof
	07nnLYueFMseAB92B9ggiRpNCM9/ZW0Zn/sYHh+rp5NO2QBu8q9kWfBg+3rpxKKNNzsdpTd38NWPd
	5qcva90Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0pLS-006H99-0M;
	Sat, 27 Apr 2024 21:12:30 +0000
Date: Sat, 27 Apr 2024 22:12:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6/7] btrfs_get_dev_args_from_path(): don't call
 set_blocksize()
Message-ID: <20240427211230.GF1495312@ZenIV>
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

We don't have bdev opened exclusive there.  And I'm rather dubious
about the need to do set_blocksize() anywhere in btrfs, to be
honest - there's some access to page cache of underlying block
devices in there, but it's nowhere near the hot paths, AFAICT.

In any case, btrfs_get_dev_args_from_path() only needs to read
the on-disk superblock and copy several fields out of it; all
callers are only interested in devices that are already opened
and brought into per-filesystem set, so setting the block size
is redundant for those and actively harmful if we are given
a pathname of unrelated device.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/volumes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f15591f3e54f..43af5a9fb547 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -482,10 +482,12 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 
 	if (flush)
 		sync_blockdev(bdev);
-	ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
-	if (ret) {
-		fput(*bdev_file);
-		goto error;
+	if (holder) {
+		ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
+		if (ret) {
+			fput(*bdev_file);
+			goto error;
+		}
 	}
 	invalidate_bdev(bdev);
 	*disk_super = btrfs_read_dev_super(bdev);
@@ -498,6 +500,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	return 0;
 
 error:
+	*disk_super = NULL;
 	*bdev_file = NULL;
 	return ret;
 }
-- 
2.39.2


