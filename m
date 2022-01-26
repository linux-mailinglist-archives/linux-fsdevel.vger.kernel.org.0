Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1484349C12F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 03:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiAZCTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 21:19:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50692 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiAZCTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:19:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8175961676;
        Wed, 26 Jan 2022 02:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB46EC340E0;
        Wed, 26 Jan 2022 02:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643163540;
        bh=fYfjNXQI19baYwTgaziCQNXiFjhHSYcgK0focYhPzHI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GkE0sUx7tFtQLsjVo76opL6YqWe0biYNT7b1azk8Ngp0FKjnFF3zzSRxOO6ZhGOdy
         ijCSXqbuUjwIH0K9vJghixhC2gkvHtsNa3iqJ4OJZ6o940pLMaha2bwiU8GC/JJ0JE
         RJPKLr2L66BENvDacJ4FslBNiV0tmbh47HycElw0lC4ulMQvZWI0N7IipuYkN4h6zG
         O5y6B/KP9XsigTFa4I8jzjLLpVOWYKzTJf/CxTzOrIdESEIZts0FTbUYQvVWKRjMh8
         YZsh1TT6aoD80K/3ujAix4xTRRJEzeHg2iZGVONBT8Kqqk398N/szAtb9Y9eUwIdbt
         3ie3vFOzSykdw==
Subject: [PATCH 3/3] xfs: ensure log flush at the end of a synchronous
 fallocate call
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 25 Jan 2022 18:19:00 -0800
Message-ID: <164316354060.2600373.8627019780419133722.stgit@magnolia>
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

If the caller wanted us to persist the preallocation to disk before
returning to userspace, make sure we force the log to disk after making
all metadata updates.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index fb82a61696f0..8f2372b96fc4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -929,6 +929,7 @@ xfs_file_fallocate(
 	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
 	loff_t			new_size = 0;
 	bool			do_file_insert = false;
+	bool			flush_log;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
@@ -1081,12 +1082,14 @@ xfs_file_fallocate(
 	 * If we need to change the PREALLOC flag, do so.  We already updated
 	 * the timestamps and cleared the suid flags, so we don't need to do
 	 * that again.  This must be committed before the size change so that
-	 * we don't trim post-EOF preallocations.
+	 * we don't trim post-EOF preallocations.  If this is the last
+	 * transaction we're going to make, make the update synchronous too.
 	 */
+	flush_log = xfs_file_sync_writes(file);
 	if (flags) {
 		flags |= XFS_PREALLOC_INVISIBLE;
 
-		if (xfs_file_sync_writes(file))
+		if (flush_log && !(do_file_insert || new_size))
 			flags |= XFS_PREALLOC_SYNC;
 
 		error = xfs_update_prealloc_flags(ip, flags);
@@ -1112,8 +1115,22 @@ xfs_file_fallocate(
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

