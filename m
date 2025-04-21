Return-Path: <linux-fsdevel+bounces-46832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685AFA95523
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFD5168432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080A1E32B9;
	Mon, 21 Apr 2025 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJCuQvip"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D04171CD;
	Mon, 21 Apr 2025 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745255964; cv=none; b=eTXWQdV6wADVegft4gPhL3d98w9qdraNVR6IecNkPG078hsj4VC7UPwMrFLwikSylBoY9XJiG+vTzr9oN6rSdX8UzjztPRSUaKX2Hqum4EX5gisWZCW7x66TyxXVmJr29rbF9pJ3B0ABg+PWBidd6EQCTFDDcjyw3V6bVA+KLkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745255964; c=relaxed/simple;
	bh=ZOmyRXmRoEyIIWzuCFtXPMy0+SkSJbikUvZaUoGvQcU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEcG4t5bBZmDGeJnDL4fUBlLGzdKN0MVHde61WAlCu5A/kRbOBwH/JNW18PvdQ4yw20i6EsBSdY1olkxRwhZkJF4006MA/TIKfX2n44LciOnTqS1W9mHInYMhFc1mHE+Vzd9/wHpJkZu7wBnLtC9e1ZWjyCQ2g92py3urM8/6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJCuQvip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66CBC4CEE4;
	Mon, 21 Apr 2025 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745255963;
	bh=ZOmyRXmRoEyIIWzuCFtXPMy0+SkSJbikUvZaUoGvQcU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EJCuQvipDVnY7id7jE4MK9n5lGKrbLeIYtiuKJhYyaNmqemhOz6tlamK0cMp+JFWd
	 u4g9WYtQuzsn9aKVlpaJ+hLd0p/wNI4WpN4G5PM1LHLFGRa25fS8DxRQLq7j0Tmdon
	 CFY/79wHx6dwdhFy7JTMJqR9JNhr+jExU2myFOGjNla1a/GwAroSQ2umF/HqG2G0nQ
	 M3TO99CfyD/dwtkLArTLIaNZd+98UnM9uW0d2QM7vr0pxgp1POL/lz3iHkbhozv0sH
	 qi5Ic/SkR237M0LkTpuy/Lg7WPopws1Jh8xOK7EZV6dtMFqGas/GhAQ+PfCAy4f4Bn
	 J57HQMt14lvIw==
Date: Mon, 21 Apr 2025 10:19:23 -0700
Subject: [PATCH 3/3] xfs: stop using set_blocksize
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org, axboe@kernel.dk
Cc: shinichiro.kawasaki@wdc.com, linux-mm@kvack.org, mcgrof@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 willy@infradead.org, hch@infradead.org, linux-block@vger.kernel.org
Message-ID: <174525589090.2138337.6822381628832847466.stgit@frogsfrogsfrogs>
In-Reply-To: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
References: <174525589013.2138337.16473045486118778580.stgit@frogsfrogsfrogs>
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


