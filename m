Return-Path: <linux-fsdevel+bounces-9899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29C845D67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD928B28FCB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F477E0F8;
	Thu,  1 Feb 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0wSOJ9I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2DE7E0F2;
	Thu,  1 Feb 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804167; cv=none; b=XWknkSEBf+rk/aD5P2XbZP50TOGlSVDoLyknLbmW/RTp9ferHnfLdqLTz5VXDE3pnOFqBHHNEsBX/pOw++oyfo0ybInoEZS8QLJWhe/2/tSb6pC/8/0Bb8bLCHB8c0mCMtaCQ/LW8Js9bKLO8cuCj+nU3urepW2XoSn5I1ruSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804167; c=relaxed/simple;
	bh=7hOJPHHwV1iEzgb2DQ5/Acpav18rxOoy01qLyGFkgnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQoZcBbYJk3DG/sYtuqDS2IqgHJjZ4gk5NctLtBR/UR31FvnjqK1B0TBGq2FU7nJsya1ijXj+558/yV0N2jkVu7ZjADd7Yv8dkW6wbFHbBZYksKeW6DIY20zrA9inBIg85EcYNiRmGmKeAaM8UCLMxcMgEeywt5nEdex24YHc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0wSOJ9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A834C43394;
	Thu,  1 Feb 2024 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804167;
	bh=7hOJPHHwV1iEzgb2DQ5/Acpav18rxOoy01qLyGFkgnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0wSOJ9I8An67Shk7Mo9Dsd/FgZibMAAA6JIjv6Ce6ilt/57tvpPfRNNCMNnQngHg
	 sX6Ite5N9KlnkMTszjpOVMBtDyWZVuE28Y/yAR2f4Zs4PiyWWQGNyXa0OBiAyOTNOE
	 a64LOX048Elee+HLkN0VOM9M/Pn1Nm/NRQZvpdsWk9T+MYUD6JsSuZod2JnuI8MG4E
	 uk859y2/Zt7J04dKtSAOmT1MYOJcZh0/5DBgMLpU+dL/tyHVG8j/LIFE3aaIkpQvdK
	 I6EkjBIlVzLG7fgoZkkCuxqn01L+ZZhs82PzJVGuSlm/Dh9Yig5F3LDIi0xmt1o0JK
	 IJlhi2TurI8fg==
Date: Thu, 1 Feb 2024 17:16:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 31/34] block: use file->f_op to indicate restricted
 writes
Message-ID: <20240201-lauwarm-kurswechsel-75ed33e41ba2@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org>
 <20240201110858.on47ef4cmp23jhcv@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240201110858.on47ef4cmp23jhcv@quack3>

On Thu, Feb 01, 2024 at 12:08:58PM +0100, Jan Kara wrote:
> On Tue 23-01-24 14:26:48, Christian Brauner wrote:
> > Make it possible to detected a block device that was opened with
> > restricted write access solely based on its file operations that it was
> > opened with. This avoids wasting an FMODE_* flag.
> > 
> > def_blk_fops isn't needed to check whether something is a block device
> > checking the inode type is enough for that. And def_blk_fops_restricted
> > can be kept private to the block layer.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> I don't think we need def_blk_fops_restricted. If we have BLK_OPEN_WRITE
> file against a bdev with bdev_writes_blocked() == true, we are sure this is
> the handle blocking other writes so we can unblock them in
> bdev_yield_write_access()...

Excellent:

commit e2dd15e4c32ad66d938d35e1acd26375a7f355fb
Author:     Christian Brauner <brauner@kernel.org>
AuthorDate: Tue Jan 23 14:26:48 2024 +0100
Commit:     Christian Brauner <brauner@kernel.org>
CommitDate: Thu Feb 1 17:13:16 2024 +0100

    block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access

    Make it possible to detected a block device that was opened with
    restricted write access based only on BLK_OPEN_WRITE and
    bdev->bd_writers < 0 so we won't have to claim another FMODE_* flag.

    Link: https://lore.kernel.org/r/20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org
    base-commit: 0bd1bf95a554f5f877724c27dbe33d4db0af4d0c
    change-id: 20240129-vfs-bdev-file-bd_inode-385a56c57a51
    Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/block/bdev.c b/block/bdev.c
index 9be8c3c683ae..0edeb073e4d8 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -799,13 +799,22 @@ static void bdev_claim_write_access(struct block_device *bdev, blk_mode_t mode)
                bdev->bd_writers++;
 }

-static void bdev_yield_write_access(struct block_device *bdev, blk_mode_t mode)
+static void bdev_yield_write_access(struct file *bdev_file, blk_mode_t mode)
 {
+       struct block_device *bdev;
+
        if (bdev_allow_write_mounted)
                return;

+       bdev = file_bdev(bdev_file);
        /* Yield exclusive or shared write access. */
-       if (mode & BLK_OPEN_RESTRICT_WRITES)
+       if (mode & BLK_OPEN_WRITE) {
+               if (bdev_writes_blocked(bdev))
+                       bdev_unblock_writes(bdev);
+               else
+                       bdev->bd_writers--;
+       }
+       if (bdev_file->f_op == &def_blk_fops_restricted)
                bdev_unblock_writes(bdev);
        else if (mode & BLK_OPEN_WRITE)
                bdev->bd_writers--;
@@ -1020,7 +1029,7 @@ void bdev_release(struct file *bdev_file)
                sync_blockdev(bdev);

        mutex_lock(&disk->open_mutex);
-       bdev_yield_write_access(bdev, handle->mode);
+       bdev_yield_write_access(bdev_file, handle->mode);

        if (handle->holder)
                bd_end_claim(bdev, handle->holder);

