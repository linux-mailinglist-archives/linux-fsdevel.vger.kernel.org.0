Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4532C4A340D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jan 2022 05:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354217AbiA3E7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jan 2022 23:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354192AbiA3E7h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jan 2022 23:59:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E733C061714;
        Sat, 29 Jan 2022 20:59:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 384B7B828B9;
        Sun, 30 Jan 2022 04:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02272C340E4;
        Sun, 30 Jan 2022 04:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643518775;
        bh=zq5yesrv7JBjZMe/sQiFQuV/Mmhj5Y0ZfDqU7JPjH2c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kZ2Rq8yVyAnQqXhU6w6NTSUBvuvxVIQaUGeMADDUAO9mvsQmwlKym4cYPWB488X00
         ZPuZ3PP+yK2JhTSPxSFUfw7QeAYgZiFZ69sf/xCNsvN2F3jSpvSG4kFdQT6/+1+c+k
         2o8LV4s4ho+yQFDorpxWD6nItVsZsL9jmRF5XoeEPehQLWBQq3zBZWZAQMv4meRa0T
         D+SEw01a5XSomwyWUQ19UmTu3M2BrQGJnv3/0TvjZFT+6xZv4d11tPIQN97Q1XukoT
         RE6lQIfx7EEtJ6QEDg9T5DuT2JcCpshMR4u/lUciYptoPKWwzVzbNuW1cq/pIosjgl
         sFPBmVwSHH3cg==
Subject: [PATCH 2/3] xfs: flush log after fallocate for sync mounts and sync
 inodes
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, chandan.babu@oracle.com,
        linux-fsdevel@vger.kernel.org
Date:   Sat, 29 Jan 2022 20:59:34 -0800
Message-ID: <164351877465.4177728.6928240301340164046.stgit@magnolia>
In-Reply-To: <164351876356.4177728.10148216594418485828.stgit@magnolia>
References: <164351876356.4177728.10148216594418485828.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Since we've started treating fallocate more like a file write, we should
flush the log to disk if the user has asked for synchronous writes
either by setting it via fcntl flags, or inode flags, or with the sync
mount option.  We've already got a helper for this, so use it.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 3b0d026396e5..a54a38e66744 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -895,6 +895,21 @@ xfs_break_layouts(
 	return error;
 }
 
+/* Does this file, inode, or mount want synchronous writes? */
+static inline bool xfs_file_sync_writes(struct file *filp)
+{
+	struct xfs_inode	*ip = XFS_I(file_inode(filp));
+
+	if (xfs_has_wsync(ip->i_mount))
+		return true;
+	if (filp->f_flags & (__O_SYNC | O_DSYNC))
+		return true;
+	if (IS_SYNC(file_inode(filp)))
+		return true;
+
+	return false;
+}
+
 #define	XFS_FALLOC_FL_SUPPORTED						\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |	\
@@ -1068,7 +1083,7 @@ xfs_file_fallocate(
 	 * don't need to do that again.  This must be committed before the size
 	 * change so that we don't trim post-EOF preallocations.
 	 */
-	if (file->f_flags & O_DSYNC)
+	if (xfs_file_sync_writes(file))
 		flags |= XFS_PREALLOC_SYNC;
 	if (flags) {
 		flags |= XFS_PREALLOC_INVISIBLE;
@@ -1129,21 +1144,6 @@ xfs_file_fadvise(
 	return ret;
 }
 
-/* Does this file, inode, or mount want synchronous writes? */
-static inline bool xfs_file_sync_writes(struct file *filp)
-{
-	struct xfs_inode	*ip = XFS_I(file_inode(filp));
-
-	if (xfs_has_wsync(ip->i_mount))
-		return true;
-	if (filp->f_flags & (__O_SYNC | O_DSYNC))
-		return true;
-	if (IS_SYNC(file_inode(filp)))
-		return true;
-
-	return false;
-}
-
 STATIC loff_t
 xfs_file_remap_range(
 	struct file		*file_in,

