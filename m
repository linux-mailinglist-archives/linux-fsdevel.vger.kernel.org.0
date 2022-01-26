Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9864049C125
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 03:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbiAZCSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 21:18:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50396 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbiAZCSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:18:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7466E615D5;
        Wed, 26 Jan 2022 02:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA870C340E0;
        Wed, 26 Jan 2022 02:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643163511;
        bh=9Jo7RiqEpjNyBDlqeeBM42B7c5523zzHaBZqwtVIrmg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OyWXaEiCER7eBun/mio5Ql/OjiZuwxRhCW29/Mu99suv0Y/CKrSMO8eDeXrNOLiEL
         8z8dOkmi//x62RJXeOMDUvAlKgGP/IElxHkbN0pk7MsbUl5vOp5qsMtcXDuHzou224
         TcbfxoU8YmZu0mzuLYPfiKd+rzGn1HWAQEFES++8teXrKCqFAPMHTTMHRTdelVe51H
         86MOKxL679HLqM8kHmPYjsmOd7Bm4k2nCDWnB5lGcEi0GvYfl+qW4L11ylppxixZBK
         49e4WeCgOZ1C1blsWDbiSu09Yf5TWYRiQE/DGEw/EdmjsXzjQIMAbvBxvjmhdJx3M9
         2BXqHy5NkM1dw==
Subject: [PATCH 4/4] xfs: return errors in xfs_fs_sync_fs
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Date:   Tue, 25 Jan 2022 18:18:31 -0800
Message-ID: <164316351155.2600168.3007243245021307622.stgit@magnolia>
In-Reply-To: <164316348940.2600168.17153575889519271710.stgit@magnolia>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Now that the VFS will do something with the return values from
->sync_fs, make ours pass on error codes.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_super.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index e8f37bdc8354..4c0dee78b2f8 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -735,6 +735,7 @@ xfs_fs_sync_fs(
 	int			wait)
 {
 	struct xfs_mount	*mp = XFS_M(sb);
+	int			error;
 
 	trace_xfs_fs_sync_fs(mp, __return_address);
 
@@ -744,7 +745,10 @@ xfs_fs_sync_fs(
 	if (!wait)
 		return 0;
 
-	xfs_log_force(mp, XFS_LOG_SYNC);
+	error = xfs_log_force(mp, XFS_LOG_SYNC);
+	if (error)
+		return error;
+
 	if (laptop_mode) {
 		/*
 		 * The disk must be active because we're syncing.

