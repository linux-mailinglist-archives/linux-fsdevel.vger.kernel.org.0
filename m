Return-Path: <linux-fsdevel+bounces-46886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20753A95D8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 07:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B36B77A9258
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 05:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55951EA7C1;
	Tue, 22 Apr 2025 05:51:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153B67603F;
	Tue, 22 Apr 2025 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301114; cv=none; b=BWWowOoAbLKcs7ybebVpy6H1ofZ/XF00Pi60EYRaIaPbm0H53+owCa6Pu09Nt9Tlbv+JHeH+JyAbjCR0wqvpZuO4fMsYivE8/LAPka5WBKxraAoh0TIPuMYM16YMZwiBUud/NjqGqkq6Y8Kh2HG04RTvsMmzxz1lNn3hi4VATKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301114; c=relaxed/simple;
	bh=gSn55mJS72uJoQ8VPPHfPKGgmfsCXOvdosYUHrkHv54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huZZT9b0LwQN/vQY7RLuIXIK2Rf/oyl0ID3rVu3vjYwxkwB75J5vdbSKG7cc+jZ4VooWn19OS2uKUtgKeTCstfsaciOGRzx6oL6v445CYnkx/ETMq6aEjyvZWXyIal+8SMrcXoNEaphsEzLqqkhUTSY6C9dTk6pgx7X+locm4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4682868BFE; Tue, 22 Apr 2025 07:51:49 +0200 (CEST)
Date: Tue, 22 Apr 2025 07:51:49 +0200
From: hch <hch@lst.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: hch <hch@lst.de>, "brauner@kernel.org" <brauner@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250422055149.GB29356@lst.de>
References: <20250417064042.712140-1-hch@lst.de> <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 22, 2025 at 05:03:19AM +0000, Shinichiro Kawasaki wrote:
> I ran blktests with the kernel v6.15-rc3, and found the test case md/001 hangs.
> The hang is recreated in stable manner. I bisected and found this patch as the
> commit 777d0961ff95 is the trigger. When I revert the commit from v6.15-rc3
> kernel, the hang disappeared.
> 
> Actions for fix will be appreciated.
> 
> FYI, the kernel INFO messages recorded functions relevant to the trigger commit,
> such as bdev_statx or vfs_getattr_nosec [1].

This should fix it:

diff --git a/block/bdev.c b/block/bdev.c
index 6a34179192c9..97d4c0ab1670 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1274,18 +1274,23 @@ void sync_bdevs(bool wait)
  */
 void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
 {
-	struct inode *backing_inode;
 	struct block_device *bdev;
 
-	backing_inode = d_backing_inode(path->dentry);
-
 	/*
-	 * Note that backing_inode is the inode of a block device node file,
-	 * not the block device's internal inode.  Therefore it is *not* valid
-	 * to use I_BDEV() here; the block device has to be looked up by i_rdev
-	 * instead.
+	 * Note that d_backing_inode() returnsthe inode of a block device node
+	 * file, not the block device's internal inode.
+	 *
+	 * Therefore it is *not* valid to use I_BDEV() here; the block device
+	 * has to be looked up by i_rdev instead.
+	 *
+	 * Only do this lookup if actually needed to avoid the performance
+	 * overhead of the lookup, and to avoid injecting bdev lifetime issues
+	 * into devtmpfs.
 	 */
-	bdev = blkdev_get_no_open(backing_inode->i_rdev);
+	if (!(request_mask & (STATX_DIOALIGN | STATX_WRITE_ATOMIC)))
+		return;
+
+	bdev = blkdev_get_no_open(d_backing_inode(path->dentry)->i_rdev);
 	if (!bdev)
 		return;
 

