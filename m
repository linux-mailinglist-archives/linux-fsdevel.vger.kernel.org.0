Return-Path: <linux-fsdevel+bounces-47951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0153AA7AA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 22:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333D6467411
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 20:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84FF1F8722;
	Fri,  2 May 2025 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1zXSQCA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7B1EBFFF;
	Fri,  2 May 2025 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216721; cv=none; b=qEOpiBJe2RNuSPhiYQLvRAUC8j1jvQ5A0ka/PKtjbk4slK/p8UyzwMjyYCCtwL6psCgGN4FxY2V2j6ExlNxmDmf0RdYof4OH/5xuhRsk+SHyEGFv+me9pq0oxD7MnqH48UI5x+DM92Q1fk0oTxQYTwC4RFrNkjf1oA0dfAPWLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216721; c=relaxed/simple;
	bh=u5Z8wpvFxHNyn281JUcC5aJjExa9fXKR0LlwurFoJOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sqSAPZncN33naM7TGdeMmoBzhTot+MOmeIvMt/9fapZGHF2ZbGMrBTNAoGPtSYf04tTRoq6oUqDqitz1dCXroFhyzq07L4NJn7NLsgzQXTUlI/8Kayvj+WSJzAJ3gkq4BVfWMVRyoAdEAbDME4uwBGgpcO0ZZ7aekhvN0yIPg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1zXSQCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE2AC4CEE4;
	Fri,  2 May 2025 20:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746216720;
	bh=u5Z8wpvFxHNyn281JUcC5aJjExa9fXKR0LlwurFoJOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z1zXSQCA6uvZog8m73AsLZiKFKCo/9ZgdhCii6J5RUCUt2HIxFvCq6DiA7/W+8foD
	 DH7NXB5sgdG046YyxnOxDDEx5qpRWQAzFICFm2YO98Lf61l71s2iO8PUn4rLUsLtA4
	 AtUyHDZXcXd/r/tyF6h4eQ+9Gb2GgzmEfAHNemv7AwMjdxp/GwZkAZAjnld40MOFML
	 sR0E8bGJJU1dQDkmJEPbcMtjtefojiU7YTTWmatlY6maRZFm0gywcMaAfHYNUtPlHI
	 yHhLrX1U4i16+k8L9DNEeChBsXdNYdNly2tUxZEnpmzhKlh9RyqWPsFTIINt3yq/EH
	 TEMV3sj9OGU6A==
Date: Fri, 2 May 2025 13:12:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: [PATCH v10.1 1.1/15] xfs: only call xfs_setsize_buftarg once per
 buffer target
Message-ID: <20250502201200.GU25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501165733.1025207-2-john.g.garry@oracle.com>

From: Darrick J. Wong <djwong@kernel.org>

It's silly to call xfs_setsize_buftarg from xfs_alloc_buftarg with the
block device LBA size because we don't need to ask the block layer to
validate a geometry number that it provided us.  Instead, set the
preliminary bt_meta_sector* fields to the LBA size in preparation for
reading the primary super.

However, we still want to flush and invalidate the pagecache for all
three block devices before we start reading metadata from those devices.
Move the sync_blockdev calls into a separate helper function, and call
it immediately after xfs_open_devices creates the buftargs.

This will enable a subsequent patch to validate hw atomic write geometry
against the filesystem geometry.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
v10.1: call sync_blockdev on open for all the devices and move this to
immediately after the vfs change
---
 fs/xfs/xfs_buf.h   |    5 +++++
 fs/xfs/xfs_buf.c   |   14 +++++---------
 fs/xfs/xfs_super.c |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index d0b065a9a9f0d2..132210705602b4 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -383,6 +383,11 @@ int xfs_buf_reverify(struct xfs_buf *bp, const struct xfs_buf_ops *ops);
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
index 5ae77ffdc947b1..292891d6ff69ac 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1733,11 +1733,7 @@ xfs_setsize_buftarg(
 		return -EINVAL;
 	}
 
-	/*
-	 * Flush the block device pagecache so our bios see anything dirtied
-	 * before mount.
-	 */
-	return sync_blockdev(btp->bt_bdev);
+	return 0;
 }
 
 int
@@ -1810,10 +1806,10 @@ xfs_alloc_buftarg(
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
index b2dd0c0bf50979..83de3ac39ae53b 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -519,6 +519,35 @@ xfs_open_devices(
 	return error;
 }
 
+/*
+ * Flush and invalidate all devices' pagecaches before reading any metadata
+ * because XFS doesn't use the bdev pagecache.
+ */
+STATIC int
+xfs_preflush_devices(
+	struct xfs_mount	*mp)
+{
+	int			error;
+
+	error = xfs_buftarg_sync(mp->m_ddev_targp);
+	if (error)
+		return error;
+
+	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
+		error = xfs_buftarg_sync(mp->m_ddev_targp);
+		if (error)
+			return error;
+	}
+
+	if (mp->m_rtdev_targp) {
+		error = xfs_buftarg_sync(mp->m_rtdev_targp);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+
 /*
  * Setup xfs_mount buffer target pointers based on superblock
  */
@@ -1671,6 +1700,10 @@ xfs_fs_fill_super(
 	if (error)
 		return error;
 
+	error = xfs_preflush_devices(mp);
+	if (error)
+		goto out_shutdown_devices;
+
 	if (xfs_debugfs) {
 		mp->m_debugfs = xfs_debugfs_mkdir(mp->m_super->s_id,
 						  xfs_debugfs);

