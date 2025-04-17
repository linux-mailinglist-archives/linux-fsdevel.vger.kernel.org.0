Return-Path: <linux-fsdevel+bounces-46604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CEDA91212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 05:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84FC7A4E34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 03:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B4F1D5159;
	Thu, 17 Apr 2025 03:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgn0YJH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDE2F24;
	Thu, 17 Apr 2025 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744861600; cv=none; b=h22Jh1CvGaDqeff5D0AtaZSe78oAPgMO6rqzxG32h8cOO2+kjXKnPUG55xDD7PesdmCvByZmNfFBbjDS0xFKkxoXnjuy6h4MhOkEk5fV/ZIr/jHXoEnpkn866m46G7hE38QpeLHY4QFgTl/hVZSjmWdsYf4s2+bRymQSWg5fLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744861600; c=relaxed/simple;
	bh=6rtFVtP/vo/ZSPjjRyGPHE4hahprHMPM4xOkYRxZ1sM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fFovaSzw0M1cYFV5vL0Pd9cIxQuXllcviTCq1Kcwp7i0bcUFAjpu/Ijw2d0TlA5sGxYVUXKKWXr32MSWt5O3LlGW1YgxaCOYyy9qfSQMN4BBnWc6OJTpv7f5CceOLaB3FvMJCsuwIDTfe8pW/vVe7qavP9rEoSqG/r5sComVeyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgn0YJH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40C1C4CEE7;
	Thu, 17 Apr 2025 03:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744861599;
	bh=6rtFVtP/vo/ZSPjjRyGPHE4hahprHMPM4xOkYRxZ1sM=;
	h=Date:From:To:Cc:Subject:From;
	b=bgn0YJH0Cmw8Vc2zCHtAC6dnb5uG0euvYiDwxEnHsJgWvrkomK+WP3uyyf6hfApYu
	 wFybW0kdVRhmrONtoq7id9WxZrYfBdYv0ZmstwyzedAUmzJPslIFd1tMNe1ibQ+3ei
	 NS6lafiy7e7Ao08IwEjfg8WsTj8AzAXWYK9BypsTk3dYmFZOeiCioNgJGq6ey8CZpn
	 9Sly87Kwl1cgUKkoKLh/TI7UTal+Mbn5VPPK5N6bwdh7DzljmI+c8VJ5YJEcvlR5kB
	 9o2E/X/UI9Y++/bKLs2EsxCQ8WSYgEGmlJ9pKPZGsNX+sGxo3hw5kFigKTyI50vZvy
	 tDYAm0z/xnpvg==
Date: Wed, 16 Apr 2025 20:46:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	ming.lei@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] loop: fix min directio size detection for nested loop devices
Message-ID: <20250417034639.GG25659@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

fstest generic/563 sets up a loop device in front of the SCRATCH_DEV
block device to test cgroup I/O accounting, because SCRATCH_DEV could be
a partition and cgroup accounting apparently only works on full block
devices (e.g. sda, not sda1).

If however SCRATCH_DEV is itself a loop device that we've used to
simulate 4k LBA block devices, the minimum directio size discovery
introduced in commit f4774e92aab85d is wrong -- we should query the
logical block size of the underlying block device because file->f_path
points whatever filesystem /dev is.

Otherwise, you get a weird losetup config:

$ losetup -f /dev/sda
$ losetup --sector-size 4096 /dev/loop0
$ losetup -f /dev/loop0
$ losetup --raw
NAME SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE DIO LOG-SEC
/dev/loop0 0 0 0 0 /dev/sda 1 4096
/dev/loop1 0 0 0 0 /dev/loop0 1 512

(Note loop1 can try to send 512b writes to loop0 which has a sector size
of 4k)

and mkfs failures like this:

error reading existing superblock: Invalid argument
mkfs.xfs: pwrite failed: Invalid argument
libxfs_bwrite: write failed on (unknown) bno 0x42a3ef8/0x100, err=22
mkfs.xfs: Releasing dirty buffer to free list!
found dirty buffer (bulk) on free list!
mkfs.xfs: pwrite failed: Invalid argument
libxfs_bwrite: write failed on (unknown) bno 0x0/0x100, err=22

Cc: <stable@vger.kernel.org> # v6.15-rc1
Fixes: f4774e92aab85d ("loop: take the file system minimum dio alignment into account")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 drivers/block/loop.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 174e67ac729f3d..59d3e713c574b0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -443,9 +443,17 @@ static void loop_reread_partitions(struct loop_device *lo)
 static unsigned int loop_query_min_dio_size(struct loop_device *lo)
 {
 	struct file *file = lo->lo_backing_file;
-	struct block_device *sb_bdev = file->f_mapping->host->i_sb->s_bdev;
+	struct inode *inode = file->f_mapping->host;
+	struct block_device *sb_bdev = inode->i_sb->s_bdev;
 	struct kstat st;
 
+	/*
+	 * If the backing device is a block device, don't send directios
+	 * smaller than its LBA size.
+	 */
+	if (S_ISBLK(inode->i_mode))
+		return bdev_logical_block_size(I_BDEV(inode));
+
 	/*
 	 * Use the minimal dio alignment of the file system if provided.
 	 */

