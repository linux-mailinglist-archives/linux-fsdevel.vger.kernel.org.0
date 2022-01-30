Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BE14A340B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jan 2022 05:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354206AbiA3E7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jan 2022 23:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353501AbiA3E7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jan 2022 23:59:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2063EC061714;
        Sat, 29 Jan 2022 20:59:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19EA160FD3;
        Sun, 30 Jan 2022 04:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D17DC340E4;
        Sun, 30 Jan 2022 04:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643518769;
        bh=6kV0/UvKn226rJ1a3vuuZbayMRT8TktAvjM46yo+2dE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cANQYiGV6m2qd6tyCIy20Q+CbBf4BoKeP3zOTSfMDXjO2A3kturoFQPdxjXJcRlIb
         OILkd43wRbRzuMMFqszPcjqTXSrLEomh9YSOyN0m715QayLts9Bh64rwyp/uw5fzTh
         eSKAXwlPwp34FIQDf/bHY61nreaPgivI/41sD7vwrFnWk5/CpxYFWg9jlVqkMjNoGG
         87J8cHSkeufC3gILAZ2b3r8yjzH15hGA0j71JT74QNUA10ZkFVY1mCvnaED8hraBg9
         XZM4KTGrHnbTQg1VGqPiHwtYQqk5iXQKzE7AZboEyKD1aPVlqHEYGlf825YRUmBI44
         s16AFWM4+9tMA==
Subject: [PATCH 1/3] xfs: use vfs helper to update file attributes after
 fallocate
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, chandan.babu@oracle.com,
        linux-fsdevel@vger.kernel.org
Date:   Sat, 29 Jan 2022 20:59:29 -0800
Message-ID: <164351876914.4177728.15972280389302582854.stgit@magnolia>
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
 fs/xfs/xfs_file.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 22ad207bedf4..3b0d026396e5 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1057,12 +1057,26 @@ xfs_file_fallocate(
 		}
 	}
 
+	/* Update [cm]time and drop file privileges like a regular write. */
+	error = file_modified(file);
+	if (error)
+		goto out_unlock;
+
+	/*
+	 * If we need to change the PREALLOC flag or flush the log, do so.
+	 * We already updated the timestamps and cleared the suid flags, so we
+	 * don't need to do that again.  This must be committed before the size
+	 * change so that we don't trim post-EOF preallocations.
+	 */
 	if (file->f_flags & O_DSYNC)
 		flags |= XFS_PREALLOC_SYNC;
+	if (flags) {
+		flags |= XFS_PREALLOC_INVISIBLE;
 
-	error = xfs_update_prealloc_flags(ip, flags);
-	if (error)
-		goto out_unlock;
+		error = xfs_update_prealloc_flags(ip, flags);
+		if (error)
+			goto out_unlock;
+	}
 
 	/* Change file size if needed */
 	if (new_size) {

