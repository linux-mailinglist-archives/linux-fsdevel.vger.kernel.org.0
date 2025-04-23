Return-Path: <linux-fsdevel+bounces-47127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE30A99902
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 21:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE3C166A83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 19:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2B2269AF9;
	Wed, 23 Apr 2025 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3uRfV1i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DBA2701AB;
	Wed, 23 Apr 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438054; cv=none; b=hvqwhBQnjDNE4prG/yDLyp2DwL/+jzRng4UA/x9dMoa4XV/S7+U7tXbT/iMCMfS+OZWNdofn9TPe/ltfP9I5GAQ+haqHT5mnqKuOVkiyUqOIHTbVhdqGNntqSGyw3G1e36CkRB+Ke8oRWEhTxHpDpwKqu3/RaK2uU9g2sr5MszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438054; c=relaxed/simple;
	bh=cl8msM7zzUMJulyRFlS5LQ3Dh9UTdvQIRA7tfZ951Pw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6j96XBvaoXdeve6Ztx7XqPJo/rN8XHun5H7gYRbjti3sjqbRUb2rFElDKdwH+N2/pp/dwV3Ct4ThugUjS6FWibdI/c8556Ef08OjEXfhZ5+CZLadZvtSiN3epC/tiQZxC0S6Y5TU379t3xAQDKvlQWpHG7HDHYPMaY6RhKm4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3uRfV1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B427C4CEE2;
	Wed, 23 Apr 2025 19:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745438054;
	bh=cl8msM7zzUMJulyRFlS5LQ3Dh9UTdvQIRA7tfZ951Pw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Z3uRfV1i1+7sIGsHV7xUreCnC+8r6uZfc7BUS+96cMm8LVgg4HXU6hgiXEDBZSb9I
	 obD7wDuK6yKVsuex5sDT3Rt47bkD4lz10ENCpBSNZic0aeQ93gkXjk9LLQql8GsFgY
	 f+KmmEbU7IMy7TJIB0XJpcv/cmRF32ZBKa3dod3UNaSO/cR7WeJ2gGY6PcpTQ7/x9z
	 D9brbeASSjR7MPtf2Ktl4LIiGjA5PcarZHy/ZoD1n3EHzKMQG6YWbHmoyQGvUulxgh
	 SLkkf9X3qaPRNmiS1ohZgDL5mvHzkz50Rryl2dc9Qrse0aoBSc2mWzLBUdhJlROOy3
	 gNBdkRSLvB/LQ==
Date: Wed, 23 Apr 2025 12:54:13 -0700
Subject: [PATCH 3/3] xfs: stop using set_blocksize
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org, axboe@kernel.dk
Cc: hch@lst.de, mcgrof@kernel.org, hch@infradead.org, willy@infradead.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, mcgrof@kernel.org
Message-ID: <174543795741.4139148.12449986894161376000.stgit@frogsfrogsfrogs>
In-Reply-To: <174543795664.4139148.8846677768151191269.stgit@frogsfrogsfrogs>
References: <174543795664.4139148.8846677768151191269.stgit@frogsfrogsfrogs>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


