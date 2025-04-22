Return-Path: <linux-fsdevel+bounces-46866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3586DA95A67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 03:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078001894A93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 01:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25FE175D5D;
	Tue, 22 Apr 2025 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKc1amFt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC3074059;
	Tue, 22 Apr 2025 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745284746; cv=none; b=GH7Ib/5MWZD8x04epDJQKE8WbF/UitEriaMpqmpisSBhWZ9NXWEBycsnDzhGQ6IoSG06ocVXsOI3FEnxeuJkIcOYu0kswXgcADcrJnLEztKBAi7BPT62vy2xegcV2jGA8Aioi4rO1g6RaJJphQUtAyg86dmQcIGTNYTFozPaFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745284746; c=relaxed/simple;
	bh=dq3Llca0tbrauzwEZQIkZ0+qS4gdsCAsKId5sUftGZA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wd/65s9n3bM70zG9gS0NUhw28w2VXo7AwOG4nhj0TIe6WyIaAGsnMPBKvYmD7ZopmVKtLsyk4zHo73oyHiHivQUj8ZShaMT7kkl+PJGix1feAUxSkQvLJ74zYnF0afKemQRCgcf3znEf4r//PSE3tGqWY690uQ84+pB/3r6Pe3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKc1amFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3B1C4CEE4;
	Tue, 22 Apr 2025 01:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745284746;
	bh=dq3Llca0tbrauzwEZQIkZ0+qS4gdsCAsKId5sUftGZA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bKc1amFte+cq3tByueXAuMAniErM2DBWlYRQIUXm3FoJ6Aap2VVJojhsYN+8ys+4k
	 E7/45xUIcRMNuvX4RvalqJWPcgXg4HMrO6nCE92urTM5C1OmBX9SG3yW1uOcFBzu8C
	 is4wELLu1XeDO1QCk0Kvno77T4ZDlbvddMj0fl7G2aIZ9dD774851scJRohU89/1L9
	 0SohmavJKkBImvucFAX/JElDMvIjMJZ9xJCA4XaQtdmCqPrVG+XUSoci6uCoKPcpC5
	 kskgXPs4JYx/RJipJYawdwVfFTvbPPbHzF2FxCrFImK7zAiabZQyuigFjSd5zkd4Ty
	 QYqQuuyvGYHLA==
Date: Mon, 21 Apr 2025 18:19:05 -0700
Subject: [PATCH 3/3] xfs: stop using set_blocksize
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, axboe@kernel.dk, djwong@kernel.org
Cc: mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
 linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com,
 linux-xfs@vger.kernel.org, hch@infradead.org, willy@infradead.org
Message-ID: <174528466963.2551621.17345314319654390051.stgit@frogsfrogsfrogs>
In-Reply-To: <174528466886.2551621.12802195876907852208.stgit@frogsfrogsfrogs>
References: <174528466886.2551621.12802195876907852208.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

XFS has its own buffer cache for metadata that uses submit_bio, which
means that it no longer uses the block device pagecache for anything.
Create a more lightweight helper that runs the blocksize checks and
flushes dirty data and use that instead.  No more truncating the
pagecache because XFS does not use it or care about it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/xfs/xfs_buf.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)


diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 1a2b3f06fa717e..5ae77ffdc947b1 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1719,18 +1719,25 @@ xfs_setsize_buftarg(
 	struct xfs_buftarg	*btp,
 	unsigned int		sectorsize)
 {
+	int			error;
+
 	/* Set up metadata sector size info */
 	btp->bt_meta_sectorsize = sectorsize;
 	btp->bt_meta_sectormask = sectorsize - 1;
 
-	if (set_blocksize(btp->bt_bdev_file, sectorsize)) {
+	error = bdev_validate_blocksize(btp->bt_bdev, sectorsize);
+	if (error) {
 		xfs_warn(btp->bt_mount,
-			"Cannot set_blocksize to %u on device %pg",
-			sectorsize, btp->bt_bdev);
+			"Cannot use blocksize %u on device %pg, err %d",
+			sectorsize, btp->bt_bdev, error);
 		return -EINVAL;
 	}
 
-	return 0;
+	/*
+	 * Flush the block device pagecache so our bios see anything dirtied
+	 * before mount.
+	 */
+	return sync_blockdev(btp->bt_bdev);
 }
 
 int


