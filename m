Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C790A49C12E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 03:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiAZCS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 21:18:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34542 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbiAZCS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:18:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0E31B81BD1;
        Wed, 26 Jan 2022 02:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4DBC340E0;
        Wed, 26 Jan 2022 02:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643163535;
        bh=D+jdnxWVbFx4+otp0WUb22dBU1BwNtU+JIJS9K7vr38=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kZi+2Ha1b9XmYw8L2vigc5qY5Ok1GpSpTMTpaEz7hQP5p98/1uugwaMe8sPoljrfY
         AGlq/Qs6n7ZpgF8G2wFqEYOX+lk/7uXoRaPg5VhlXrccaVQRAlGXS+IPnuCx156Tai
         Y7amDhOSyICL9UhO2brRmw08MD01cQ23k5oUtdxn2pE+wGhxoyVbVxYlyDWfnxVjRJ
         koI0nAUQO8VYe/dREt4Ge8DFkWlBxuY/onQIxU4Z8uMZ43QVbE2zUelk3QSNEf+6o4
         z6GuQHG6rhqlBdk2WzTkRsvA8hQYlQG5jqTEeDHwV7ybpCI65GS33b94JHnRKwPozf
         z9MK3IO/zQqBQ==
Subject: [PATCH 2/3] xfs: flush log after fallocate for sync mounts and sync
 inodes
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 25 Jan 2022 18:18:55 -0800
Message-ID: <164316353511.2600373.9852441567149788159.stgit@magnolia>
In-Reply-To: <164316352410.2600373.17669839881121774801.stgit@magnolia>
References: <164316352410.2600373.17669839881121774801.stgit@magnolia>
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
index eee5fb20cf8d..fb82a61696f0 100644
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
@@ -1071,7 +1086,7 @@ xfs_file_fallocate(
 	if (flags) {
 		flags |= XFS_PREALLOC_INVISIBLE;
 
-		if (file->f_flags & O_DSYNC)
+		if (xfs_file_sync_writes(file))
 			flags |= XFS_PREALLOC_SYNC;
 
 		error = xfs_update_prealloc_flags(ip, flags);
@@ -1130,21 +1145,6 @@ xfs_file_fadvise(
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

