Return-Path: <linux-fsdevel+bounces-47869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645CDAA6469
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 21:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44075188ACD7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73382367DE;
	Thu,  1 May 2025 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp0ZpHah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0514BFA2;
	Thu,  1 May 2025 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129129; cv=none; b=P/1268AM25huWpVAl0DkRjqMxDDvquHPwSFMmelxftppVr9fkfJLYYqDKzVLn0w/o483GNzV3MBVxEXLZrSF2IROJuHGspQntgNnJKL0LuVn5b08ZxQVOMHTgZuU09e+7dZvahqzXhMapA5FXjAg/2rgBWAdhrE1pxps2ZgF8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129129; c=relaxed/simple;
	bh=aH6SZdXyk5U3M7I6JGEIYeVkKFyJiBbPRkFQRB9H3CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbnvW3rcb6QH8ZRsyanOOr3MlcLn1qj2v6mD6DoqT1yzSZwjNy1Xsg7iBA6MYFcUJmjZVRDwz4B+ScJcaVsEpekbBTcmFz322tcINy2d5MRKqWXvT1PDubW1npGv3AWQwY6QWo+oCZqK/frEwAc/sKysZsRz6F93IGwsiKnubvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp0ZpHah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57C9C4CEE4;
	Thu,  1 May 2025 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746129128;
	bh=aH6SZdXyk5U3M7I6JGEIYeVkKFyJiBbPRkFQRB9H3CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sp0ZpHahkGRWhi6np6c7D3WRQqjE0EDN1CPh6cn8Rmj1HRPmddqRdgx3q+TNWTMNE
	 jNrl85vjuhj5zp/YVyKH+UadqP/UQTwxOv9AXkX173xDM2crMfY2em1bGPgKeQbmMI
	 w5NqOJMx6mYTS6MxXCBYkqUS3uhlNEripHcKyZh5e6W3E09gF+M28O+FC4Y54+o3zH
	 YUSjdrWeGYJ2ZFAEUfpZ1jIEL6DMScFOnUXNdCWTSnn5yL8f+yo3nrH2XWLz2WMlgZ
	 r8wNyA72DejFPHLuzNiwOPIF5QUFfazJVbvQYeNbuKT3S9/qMhsBlcMijVU9WrdqNR
	 k5s76+LE2285A==
Date: Thu, 1 May 2025 12:52:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: [PATCH 16/15] xfs: only call xfs_setsize_buftarg once per buffer
 target
Message-ID: <20250501195208.GF25675@frogsfrogsfrogs>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>

From: Darrick J. Wong <djwong@kernel.org>

It's silly to call xfs_setsize_buftarg from xfs_alloc_buftarg with the
block device LBA size because we don't need to ask the block layer to
validate a geometry number that it provided us.  Instead, set the
preliminary bt_meta_sector* fields to the LBA size in preparation for
reading the primary super.

It's ok to lose the sync_blockdev call at buftarg creation time for the
external log and rt devices because we don't read from them until after
calling xfs_setup_devices.  We do need an explicit sync for the data
device because we read the primary super before calling
xfs_setup_devices.

This will enable the next patch to validate hw atomic write geometry
against the filesystem geometry.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_buf.h   |    5 +++++
 fs/xfs/xfs_buf.c   |    8 ++++----
 fs/xfs/xfs_super.c |    6 +++++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 6f691779887f77..2f809e33ec66da 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -384,6 +384,11 @@ int xfs_buf_reverify(struct xfs_buf *bp, const struct xfs_buf_ops *ops);
 bool xfs_verify_magic(struct xfs_buf *bp, __be32 dmagic);
 bool xfs_verify_magic16(struct xfs_buf *bp, __be16 dmagic);
 
+static inline int xfs_buftarg_sync(struct xfs_buftarg *btp)
+{
+	return sync_blockdev(btp->bt_bdev);
+}
+
 /* for xfs_buf_mem.c only: */
 int xfs_init_buftarg(struct xfs_buftarg *btp, size_t logical_sectorsize,
 		const char *descr);
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index c1bd5654c3afa8..437fef08b7cf7b 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1837,10 +1837,10 @@ xfs_alloc_buftarg(
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
 	 */
-	if (xfs_setsize_buftarg(btp, bdev_logical_block_size(btp->bt_bdev)))
-		goto error_free;
-	if (xfs_init_buftarg(btp, bdev_logical_block_size(btp->bt_bdev),
-			mp->m_super->s_id))
+	btp->bt_meta_sectorsize = bdev_logical_block_size(btp->bt_bdev);
+	btp->bt_meta_sectormask = btp->bt_meta_sectorsize - 1;
+
+	if (xfs_init_buftarg(btp, btp->bt_meta_sectorsize, mp->m_super->s_id))
 		goto error_free;
 
 	return btp;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index f021bdf8d0b592..b6b6fb4ce8ca65 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -507,7 +507,11 @@ xfs_open_devices(
 			bdev_fput(logdev_file);
 	}
 
-	return 0;
+	/*
+	 * Flush and invalidate the data device pagecache before reading the
+	 * primary super because XFS doesn't use the bdev pagecache.
+	 */
+	return xfs_buftarg_sync(mp->m_ddev_targp);
 
  out_free_rtdev_targ:
 	if (mp->m_rtdev_targp)

