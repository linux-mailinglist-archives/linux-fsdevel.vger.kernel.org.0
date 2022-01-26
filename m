Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C910249C12C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 03:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbiAZCSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 21:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbiAZCSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:18:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E5AC06161C;
        Tue, 25 Jan 2022 18:18:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E3AAB81074;
        Wed, 26 Jan 2022 02:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E94C340E7;
        Wed, 26 Jan 2022 02:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643163530;
        bh=7EC0tcE3NjQ0jnxSPMkJcFGyf6uy0FZRmXlIL5zEjJo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FH8GnZ/juaCMqG6EebCOPcdhSBNA4yHYujFOzs/kV86vdCPWvIbwFVxZ7GgKyj09q
         JLbnqzjLULxOObfBCEtmKokwsgPXygCeHa0LKoyt/DbCQxwCUoPbIZZpcCFGqWx8RT
         hqTkliqEsQ9uoZgsxTCwjXGpSErgZMsQynJX5QEs+8xrWDFksuc+gYNNHQE11EGkRz
         S+4RNA+u5ZPE89g+liNQ0Vci/yM4t4Hqc07X8+ZnzlymgNiVLXO8z6fmMffnaccUJ3
         KdAAxp0NxqSy8vYkUZnyh4gv8B3HO5X2pZBBqEQu8l+omfweh3aonCSDvTiYkGGcd5
         P4PhGXFY2eABw==
Subject: [PATCH 1/3] xfs: use vfs helper to update file attributes after
 fallocate
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 25 Jan 2022 18:18:49 -0800
Message-ID: <164316352961.2600373.9191916389107843284.stgit@magnolia>
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

In XFS, we always update the inode change and modification time when any
preallocation operation succeeds.  Furthermore, as various fallocate
modes can change the file contents (extending EOF, punching holes,
zeroing things, shifting extents), we should drop file privileges like
suid just like we do for a regular write().  There's already a VFS
helper that figures all this out for us, so use that.

The net effect of this is that we no longer drop suid/sgid if the caller
is root, but we also now drop file capabilities.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 22ad207bedf4..eee5fb20cf8d 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1057,13 +1057,28 @@ xfs_file_fallocate(
 		}
 	}
 
-	if (file->f_flags & O_DSYNC)
-		flags |= XFS_PREALLOC_SYNC;
-
-	error = xfs_update_prealloc_flags(ip, flags);
+	/* Update [cm]time and drop file privileges like a regular write. */
+	error = file_modified(file);
 	if (error)
 		goto out_unlock;
 
+	/*
+	 * If we need to change the PREALLOC flag, do so.  We already updated
+	 * the timestamps and cleared the suid flags, so we don't need to do
+	 * that again.  This must be committed before the size change so that
+	 * we don't trim post-EOF preallocations.
+	 */
+	if (flags) {
+		flags |= XFS_PREALLOC_INVISIBLE;
+
+		if (file->f_flags & O_DSYNC)
+			flags |= XFS_PREALLOC_SYNC;
+
+		error = xfs_update_prealloc_flags(ip, flags);
+		if (error)
+			goto out_unlock;
+	}
+
 	/* Change file size if needed */
 	if (new_size) {
 		struct iattr iattr;

