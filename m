Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7EE4A340F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jan 2022 05:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354221AbiA3E7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jan 2022 23:59:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48366 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354213AbiA3E7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jan 2022 23:59:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5FBFB828BA;
        Sun, 30 Jan 2022 04:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F200C340E4;
        Sun, 30 Jan 2022 04:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643518780;
        bh=uUNwbd/z2iI+K1tLc1Wg5DPiYax2Stet/HMhUl+Gg84=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DOP4+NrifA/FpZN4RgeYQj/m1tsqaPdb/L4BncNtc/9pjywfYtv12FxwN9h/e85HO
         P8YA7sbtFurfB5KZ6AigHhN9v5Hld0BbBcKWopYVM2K9FXxFQau3bqC+/wyLosTrTg
         iDpwc5CkbB5mqj6XZ5p77bvBIyH6s5TuvKyTRKNMPxwTnOIHKoWUSUz026cx3NOkSM
         JAvxFOfYG4k71XibkpFb/JAfoXVx1IilSz14mh2coiYBHP+dSHUhcSx1YwggFELZPh
         FBEV4dQmf7PzxvUvBQkrGIlRUzPMQYt7YPXMvpIPPjV28D+YMCSQGtZlJu7xrqAtOY
         ytqdG9kMpqsnA==
Subject: [PATCH 3/3] xfs: ensure log flush at the end of a synchronous
 fallocate call
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, chandan.babu@oracle.com,
        linux-fsdevel@vger.kernel.org
Date:   Sat, 29 Jan 2022 20:59:40 -0800
Message-ID: <164351878016.4177728.4148624283377010229.stgit@magnolia>
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

If the caller wanted us to persist the preallocation to disk before
returning to userspace, make sure we force the log to disk after making
all metadata updates.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c |   32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a54a38e66744..8f2372b96fc4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -929,6 +929,7 @@ xfs_file_fallocate(
 	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
 	loff_t			new_size = 0;
 	bool			do_file_insert = false;
+	bool			flush_log;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
@@ -1078,16 +1079,19 @@ xfs_file_fallocate(
 		goto out_unlock;
 
 	/*
-	 * If we need to change the PREALLOC flag or flush the log, do so.
-	 * We already updated the timestamps and cleared the suid flags, so we
-	 * don't need to do that again.  This must be committed before the size
-	 * change so that we don't trim post-EOF preallocations.
+	 * If we need to change the PREALLOC flag, do so.  We already updated
+	 * the timestamps and cleared the suid flags, so we don't need to do
+	 * that again.  This must be committed before the size change so that
+	 * we don't trim post-EOF preallocations.  If this is the last
+	 * transaction we're going to make, make the update synchronous too.
 	 */
-	if (xfs_file_sync_writes(file))
-		flags |= XFS_PREALLOC_SYNC;
+	flush_log = xfs_file_sync_writes(file);
 	if (flags) {
 		flags |= XFS_PREALLOC_INVISIBLE;
 
+		if (flush_log && !(do_file_insert || new_size))
+			flags |= XFS_PREALLOC_SYNC;
+
 		error = xfs_update_prealloc_flags(ip, flags);
 		if (error)
 			goto out_unlock;
@@ -1111,8 +1115,22 @@ xfs_file_fallocate(
 	 * leave shifted extents past EOF and hence losing access to
 	 * the data that is contained within them.
 	 */
-	if (do_file_insert)
+	if (do_file_insert) {
 		error = xfs_insert_file_space(ip, offset, len);
+		if (error)
+			goto out_unlock;
+	}
+
+	/*
+	 * If the caller wants us to flush the log and either we've made
+	 * changes since updating the PREALLOC flag or we didn't need to
+	 * update the PREALLOC flag, then flush the log now.
+	 */
+	if (flush_log && (do_file_insert || new_size || flags == 0)) {
+		error = xfs_log_force_inode(ip);
+		if (error)
+			goto out_unlock;
+	}
 
 out_unlock:
 	xfs_iunlock(ip, iolock);

