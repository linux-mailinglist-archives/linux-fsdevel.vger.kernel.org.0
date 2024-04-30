Return-Path: <linux-fsdevel+bounces-18234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857438B6883
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D581C218AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6D7101DE;
	Tue, 30 Apr 2024 03:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo3Eitqa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883F10A01;
	Tue, 30 Apr 2024 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447525; cv=none; b=iUkL9ecsWC9Ys4n0m3OsekPlW7/OZHXzhWxslxDpzbJptbdsPjNKjVL184koEJ4va9UZlP62B6TJYTxujKXtVY6UyN/eh8sFpQT3SX05Zou5KC9qPskvhsQs5Tamnr4z4ngTTMZ5mhX3aRRpLNCvrkyE+R7uM+A3U1mJxWR2GzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447525; c=relaxed/simple;
	bh=6ObMVCZ176J4MGZvZ9Xo+UTcnuFTDMOn8PD7QGqsiVc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDp88B3GsFfscHSIqhbnYEiSXwag2Xto3LPMZ2UPgxd56TNFkINht/35LBaHLZHO1jnoGjoXS+TIJUYnKX/ImO5fsQ1bSYPL+nn9EIPbYYrAZOMuAI9vpEfKjrg4xkTo8eVGbrfMpA6SKF4gjB8wMVaTIdx3xOQ293ZVnOmIBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo3Eitqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043F3C116B1;
	Tue, 30 Apr 2024 03:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447525;
	bh=6ObMVCZ176J4MGZvZ9Xo+UTcnuFTDMOn8PD7QGqsiVc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Eo3EitqaDX6sS15nAIvCwlNJ3kSnugQuW+7nMJlASRpwcg5ojPNX3YXRgFOcLc9yL
	 PX4KDjRUdlpKkZzfRQr3u7mjSNtXN+bd5nx6MTkIOEWywUbVB12jKkOQ0qSTvxztTo
	 Lnt13/saL9/4xBIslbD0m9oEnIQFL4S1PPVwIdjZdECO7mzSFFmJnXyjvbn/YGgp4h
	 0SPt++vRyWlqk/QTKNNEDSX0mVCcGRzLfomKFmSUVqfmVHNMcTKKwW5g7OO0uRJk2M
	 SaJqthugaY1mcuFcvsIWeDNMgInI+WSTeYd4aLMYWlzD6Z1ItdkCSPELEp5EyAFcpp
	 n7J8WK+gLfFYA==
Date: Mon, 29 Apr 2024 20:25:24 -0700
Subject: [PATCH 05/26] xfs: use an empty transaction to protect xfs_attr_get
 from deadlocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680446.957659.9938547111608933605.stgit@frogsfrogsfrogs>
In-Reply-To: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Wrap the xfs_attr_get_ilocked call in xfs_attr_get with an empty
transaction so that we cannot livelock the kernel if someone injects a
loop into the attr structure or the attr fork bmbt.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)


diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index b841096947acb..e0be8d0c1ffdc 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -274,6 +274,8 @@ xfs_attr_get(
 
 	XFS_STATS_INC(args->dp->i_mount, xs_attr_get);
 
+	ASSERT(!args->trans);
+
 	if (xfs_is_shutdown(args->dp->i_mount))
 		return -EIO;
 
@@ -286,8 +288,27 @@ xfs_attr_get(
 	/* Entirely possible to look up a name which doesn't exist */
 	args->op_flags = XFS_DA_OP_OKNOENT;
 
+	error = xfs_trans_alloc_empty(args->dp->i_mount, &args->trans);
+	if (error)
+		return error;
+
 	lock_mode = xfs_ilock_attr_map_shared(args->dp);
+
+        /*
+	 * Make sure the attr fork iext tree is loaded.  Use the empty
+	 * transaction to load the bmbt so that we avoid livelocking on loops.
+	 */
+        if (xfs_inode_hasattr(args->dp)) {
+                error = xfs_iread_extents(args->trans, args->dp, XFS_ATTR_FORK);
+                if (error)
+                        goto out_cancel;
+        }
+
 	error = xfs_attr_get_ilocked(args);
+
+out_cancel:
+	xfs_trans_cancel(args->trans);
+	args->trans = NULL;
 	xfs_iunlock(args->dp, lock_mode);
 
 	return error;


