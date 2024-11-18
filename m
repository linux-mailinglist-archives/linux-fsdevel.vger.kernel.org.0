Return-Path: <linux-fsdevel+bounces-35149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C239D1A46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 22:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E49B23307
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 21:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F29F1C1F1F;
	Mon, 18 Nov 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSiyfZMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C5155312;
	Mon, 18 Nov 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964601; cv=none; b=RbFHgmTaduGJbVYH/Tcz/C2hhWp1dY7j/7AEOWFKaoNzz1WqqogQwzAckZKw/MxYuc8oqVX6svhXwxZmDElwkJH8WO9eUjWMQJm1rkrcyfkrG6SO5E7fGwCHLZv2lmUAsHN2fJlMf/zz7gmtQesd60lk22C2SMPOTAir9a9q4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964601; c=relaxed/simple;
	bh=24UJjS8/aP1EOhV1GxQeDSO01e5Mj2oB9xq3YkkR/dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOxEmHQ7rDCOCDTnA6tdjpDRlRd11RWcOv5va98HBbJDcil0AmZFpCzy68PePy4tz45FvrLWvlyy5qbtPV2Vq7+CHwb8bRNXiDweb2cDrWPTostwriH9UwUqGzO5VSIHppowZ8do3Y2+dhSN3RsuQa6UjJ8iFSpeLN90hhMa8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSiyfZMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96EAC4CED0;
	Mon, 18 Nov 2024 21:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964599;
	bh=24UJjS8/aP1EOhV1GxQeDSO01e5Mj2oB9xq3YkkR/dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSiyfZMkEaHpJ18VaTlsy9NHYzlXUSDqhp1bhCYtv2ZZuWn8VY7xiW19vezaNzp/3
	 ymCScH9tiMmymvDl4NpTLNoskDvWz/iskA02g+AFJ4HkngVtKHKldJKvde7ScTxMg7
	 h+2fM8CzT/CBoEwP+YUIW17BQgl/sLUSF9qZ2RV9yPftl9KOg24ZAZT+4WqgYSIbfB
	 7Mf/LiiGqaEjsyzlSPbMXvv9DS3YR3/5Ch4nful0OPqGAyuCXXYuPd2JfiFl0W+tAE
	 K1aZe7+K99fdMCaGi204Q+fDsiAo7dqWv4IhNWMtL0YHCE+5GUy2NlpnNNiW2g9P/s
	 ZUJbi5cvFBw3A==
Date: Mon, 18 Nov 2024 13:16:37 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: willy@infradead.org, hare@suse.de, david@fromorbit.com,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	kbusch@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com,
	nilay@linux.ibm.com
Subject: Re: [RFC 8/8] bdev: use bdev_io_min() for statx block size
Message-ID: <ZzuutQp5HzZp-lCQ@bombadil.infradead.org>
References: <20241113094727.1497722-1-mcgrof@kernel.org>
 <20241113094727.1497722-9-mcgrof@kernel.org>
 <20241118070805.GA932@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118070805.GA932@lst.de>

On Mon, Nov 18, 2024 at 08:08:05AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 13, 2024 at 01:47:27AM -0800, Luis Chamberlain wrote:
> >  	if (S_ISBLK(stat->mode))
> > -		bdev_statx(path, stat, request_mask);
> > +		bdev_statx(path, stat, request_mask | STATX_DIOALIGN);
> 
> And this is both unrelated and wrong.

I knew this was an eyesore, but was not sure if we really wanted to
go through the trouble of adding a new field for blksize alone, but come
to think of it, with it at least userspace knows for sure its
getting where as befault it was not.

If we add it, and since it would be added post LBS support it could also
signal that a kernel supports LBS. That may be a useful clue for default
mkfs in case it is set and larger than today's 4k default.

So how about:

diff --git a/block/bdev.c b/block/bdev.c
index 3a5fd65f6c8e..f5d7cda97616 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1277,7 +1277,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
 	struct inode *backing_inode;
 	struct block_device *bdev;
 
-	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
+	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC |
+			      STATX_BLKSIZE)))
 		return;
 
 	backing_inode = d_backing_inode(path->dentry);
@@ -1306,6 +1307,11 @@ void bdev_statx(struct path *path, struct kstat *stat,
 			queue_atomic_write_unit_max_bytes(bd_queue));
 	}
 
+	if (request_mask & STATX_BLKSIZE) {
+		stat->blksize = (unsigned int) bdev_io_min(bdev);
+		stat->result_mask |= STATX_BLKSIZE;
+	}
+
 	blkdev_put_no_open(bdev);
 }
 
diff --git a/fs/stat.c b/fs/stat.c
index 41e598376d7e..d4cb2296b42d 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -268,7 +268,7 @@ static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 	 * obtained from the bdev backing inode.
 	 */
 	if (S_ISBLK(stat->mode))
-		bdev_statx(path, stat, request_mask);
+		bdev_statx(path, stat, request_mask | STATX_BLKSIZE);
 
 	return error;
 }
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 887a25286441..b7e180bf72b8 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -164,6 +164,7 @@ struct statx {
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
+#define STATX_BLKSIZE		0x00020000U	/* Want/got stx_blksize */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 

