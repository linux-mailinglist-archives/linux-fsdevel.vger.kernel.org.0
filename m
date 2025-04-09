Return-Path: <linux-fsdevel+bounces-46130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40536A8300C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 21:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1985F44478E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 19:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878F278150;
	Wed,  9 Apr 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSCxtPJQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1A1BC073;
	Wed,  9 Apr 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225748; cv=none; b=m9oq9ep8yxYGT0FCqU6oXJZuu7BuETXO3b6GAAjPLoovj8exZR3VVFasBJCP5j/LbqrtrOv+GDpXwqP5PPVjDJ/HGAJandNr1fHk8xzWGSY6JXAbR2wSBXPPSYRsS3Wn4zbJBlND7OSVXHmBaEKVVksbgREcD+u0BgN19LNSWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225748; c=relaxed/simple;
	bh=slV7aJP8bfDnI9jJg8xkwva4EKe7FG46aq/qjIeYOXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9KboKs2RGXfkrwwwvD7e8P1EyWXYEZQKyy4xNZLeQTuq1bkG4T3xEIJySz3OJvrRnpCS5GfOmLZOxkLZ0a0XIVYDmmXR+NYbJYuTWBG+nJ454VBekmcQ9ZjevsMKVfHlDx4F6z5YVmtnwltQTNFLt7O9ME5YtZYXyLI5SEovoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSCxtPJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1001C4CEE2;
	Wed,  9 Apr 2025 19:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744225747;
	bh=slV7aJP8bfDnI9jJg8xkwva4EKe7FG46aq/qjIeYOXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSCxtPJQUtB0DfijHbQsOBbiEps+2+YwV7NoOQkZs/cUgU2QYElmLsC052jwHv/15
	 A24s9ppUVNV5W33Sx909CAnDHpmNu0Ubk5T3ZeWsmjub9GVQBByriUMqmdVIdX4l5L
	 M2/9bF3Hokj8WP6Ab2C/Qn7HM8rIuKKfNz7CEqe4f1/lO49FQ6OziU8tzokOXvTsDZ
	 u/jYnhUO3PY5HcTd3428Gpug30MBapDR+IpT1RweUo+yhT7mHQIlpXZSu/hABSNefl
	 fvpBfdL7jSGs0Jkd0/xhPzWVPjPRPrMGfkWeM2DArxtiIa96vnnZ34IjHXnufD2OKw
	 myauuZoy28HCg==
Date: Wed, 9 Apr 2025 12:09:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Cc: linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: Weird blockdev crash in 6.15-rc1?
Message-ID: <20250409190907.GO6266@frogsfrogsfrogs>
References: <20250408175125.GL6266@frogsfrogsfrogs>
 <20250409173015.GN6266@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409173015.GN6266@frogsfrogsfrogs>

On Wed, Apr 09, 2025 at 10:30:15AM -0700, Darrick J. Wong wrote:

> Then it occurred to me to look at set_blocksize again:
> 
> 	/* Don't change the size if it is same as current */
> 	if (inode->i_blkbits != blksize_bits(size)) {
> 		sync_blockdev(bdev);
> 		inode->i_blkbits = blksize_bits(size);
> 		mapping_set_folio_order_range(inode->i_mapping,
> 				get_order(size), get_order(size));
> 		kill_bdev(bdev);
> 	}
> 
> (Note that I changed mapping_set_folio_min_order here to
> mapping_set_folio_order_range to shut up a folio migration bug that I
> reported elsewhere on fsdevel yesterday, and willy suggested forcing the
> max order as a temporary workaround.)
> 
> The update of i_blkbits and the order bits of mapping->flags are
> performed before kill_bdev truncates the pagecache, which means there's
> a window where there can be a !uptodate order-0 folio in the pagecache
> but i_blkbits > PAGE_SHIFT (in this case, 13).  The debugging assertion
> above is from someone trying to install a too-small folio into the
> pagecache.  I think the "FARK" message I captured overnight is from
> readahead trying to bring in contents from disk for this too-small folio
> and failing.
> 
> So I think the answer is that set_blocksize needs to lock out folio_add,
> flush the dirty folios, invalidate the entire bdev pagecache, set
> i_blkbits and the folio order, and only then allow new additions to the
> pagecache.
> 
> But then, which lock(s)?  Were this a file on XFS I'd say that one has
> to take i_rwsem and mmap_invalidate_lock before truncating the pagecache
> but by my recollection bdev devices don't take either lock in their IO
> paths.

Here's my shabby attempt to lock my way out of this mess.  My reproducer
no longer trips, but I don't think that means much.

--D

From: Darrick J. Wong <djwong@kernel.org>
Subject: [PATCH] block: fix race between set_blocksize and IO paths

With the new large sector size support, it's now the case that
set_blocksize needs to change i_blksize and the folio order with no
folios in the pagecache because the geometry changes cause problems with
the bufferhead code.

Therefore, truncate the page cache after flushing but before updating
i_blksize.  However, that's not enough -- we also need to lock out file
IO and page faults during the update.  Take both the i_rwsem and the
invalidate_lock in exclusive mode for invalidations, and in shared mode
for read/write operations.

I don't know if this is the correct fix.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 block/bdev.c      |   12 ++++++++++++
 block/blk-zoned.c |    5 ++++-
 block/fops.c      |    7 +++++++
 block/ioctl.c     |    6 ++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7b4e35a661b0c9..0cbdac46d98d86 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -169,11 +169,23 @@ int set_blocksize(struct file *file, int size)
 
 	/* Don't change the size if it is same as current */
 	if (inode->i_blkbits != blksize_bits(size)) {
+		/* Prevent concurrent IO operations */
+		inode_lock(inode);
+		filemap_invalidate_lock(inode->i_mapping);
+
+		/*
+		 * Flush and truncate the pagecache before we reconfigure the
+		 * mapping geometry because folio sizes are variable now.
+		 */
 		sync_blockdev(bdev);
+		kill_bdev(bdev);
+
 		inode->i_blkbits = blksize_bits(size);
 		mapping_set_folio_order_range(inode->i_mapping,
 				get_order(size), get_order(size));
 		kill_bdev(bdev);
+		filemap_invalidate_unlock(inode->i_mapping);
+		inode_unlock(inode);
 	}
 	return 0;
 }
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0c77244a35c92e..8f15d1aa6eb89a 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -343,6 +343,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		op = REQ_OP_ZONE_RESET;
 
 		/* Invalidate the page cache, including dirty pages. */
+		inode_lock(bdev->bd_mapping->host);
 		filemap_invalidate_lock(bdev->bd_mapping);
 		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
 		if (ret)
@@ -364,8 +365,10 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 	ret = blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors);
 
 fail:
-	if (cmd == BLKRESETZONE)
+	if (cmd == BLKRESETZONE) {
 		filemap_invalidate_unlock(bdev->bd_mapping);
+		inode_unlock(bdev->bd_mapping->host);
+	}
 
 	return ret;
 }
diff --git a/block/fops.c b/block/fops.c
index be9f1dbea9ce0a..f46ae08fac33dd 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -746,7 +746,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 	} else {
+		inode_lock_shared(bd_inode);
 		ret = blkdev_buffered_write(iocb, from);
+		inode_unlock_shared(bd_inode);
 	}
 
 	if (ret > 0)
@@ -757,6 +759,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct inode *bd_inode = bdev_file_inode(iocb->ki_filp);
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	loff_t size = bdev_nr_bytes(bdev);
 	loff_t pos = iocb->ki_pos;
@@ -793,7 +796,9 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			goto reexpand;
 	}
 
+	inode_lock_shared(bd_inode);
 	ret = filemap_read(iocb, to, ret);
+	inode_unlock_shared(bd_inode);
 
 reexpand:
 	if (unlikely(shorted))
@@ -836,6 +841,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
+	inode_lock(inode);
 	filemap_invalidate_lock(inode->i_mapping);
 
 	/*
@@ -868,6 +874,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
  fail:
 	filemap_invalidate_unlock(inode->i_mapping);
+	inode_unlock(inode);
 	return error;
 }
 
diff --git a/block/ioctl.c b/block/ioctl.c
index faa40f383e2736..e472cc1030c60c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -142,6 +142,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	if (err)
 		return err;
 
+	inode_lock(bdev->bd_mapping->host);
 	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
@@ -174,6 +175,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 	blk_finish_plug(&plug);
 fail:
 	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
 	return err;
 }
 
@@ -199,12 +201,14 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
+	inode_lock(bdev->bd_mapping->host);
 	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
 	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
 	return err;
 }
 
@@ -236,6 +240,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages */
+	inode_lock(bdev->bd_mapping->host);
 	filemap_invalidate_lock(bdev->bd_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end);
 	if (err)
@@ -246,6 +251,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 
 fail:
 	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
 	return err;
 }
 

