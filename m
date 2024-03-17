Return-Path: <linux-fsdevel+bounces-14601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F8A87DE95
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09F7B20E66
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01021CD29;
	Sun, 17 Mar 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2ew47uu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBA1CD06;
	Sun, 17 Mar 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692980; cv=none; b=rqdArwhPITaQ4n39AxR3yX2PB0wsFncaXyhrXuVuUfkLfuB0VcXt0nrUEsHEyHYvm7OYtAPuF7tJcLvtV1ZYrZsWzAch97AllnE1rqAmrla/Fc1FOcwWhRL0x1NQj8lgU9uARy37DM+qCNLxiFOPB9MzUrtWgosFr42A4bKUlkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692980; c=relaxed/simple;
	bh=SlQI136CHhejSV55+uq80fnqYG4X2Ac5Dqu6QQDTOlo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRECqywam82nmVm/uP0JNfWtUo67zKiUJDc/mc4lg34RzuRN8XKtayFJhI8Y35Dy5h4G+jbfXivggpu3qhRFN4dybKdBRtqgKqzb+hrF3kjMifPpGFHzZSHSWA0JiHi6Y6uMKzjv3L8AEYkEBQxzF/ariWmlYofHyMNM3y9CpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2ew47uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30FFC433F1;
	Sun, 17 Mar 2024 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692979;
	bh=SlQI136CHhejSV55+uq80fnqYG4X2Ac5Dqu6QQDTOlo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=F2ew47uu+/idrf22JJEXeXC4NyPXh+N0wv48dRdFC1ercnuX5yfFcGxm8G5kEvmIf
	 c+Hh4YfvRu0DA8l8NZGJyfVFMavdnq0mboSRcn3us7I5YNTZPBv+2K6SHWgpF5KBq+
	 fI9CDU9wOa6cVJue45ZlPy8p+H61xMvPYO+nf54JnqP/4J/26kNpQ/PIo3xwSqwu6R
	 qG8tUcQrHR0BqM+1EG3gnjP04A8r46kEvm8KdH3cncC+ZMFEgya++Jwjw8FjECESLv
	 RHy3MiAJnsyGmjpxeSHfHDygV/y5kFhxtOalSBgewp/n1GeKnBsS2qjvYuE5Tu/EXY
	 tyqNlIn6N8Sgw==
Date: Sun, 17 Mar 2024 09:29:39 -0700
Subject: [PATCH 24/40] xfs: disable direct read path for fs-verity files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246296.2684506.17423583037447505680.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

The direct path is not supported on verity files. Attempts to use direct
I/O path on such files should fall back to buffered I/O path.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix braces]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 74dba917be93..0ce51a020115 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -281,7 +281,8 @@ xfs_file_dax_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret = 0;
 
 	trace_xfs_file_dax_read(iocb, to);
@@ -334,10 +335,18 @@ xfs_file_read_iter(
 
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
-	else if (iocb->ki_flags & IOCB_DIRECT)
+	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
 		ret = xfs_file_dio_read(iocb, to);
-	else
+	else {
+		/*
+		 * In case fs-verity is enabled, we also fallback to the
+		 * buffered read from the direct read path. Therefore,
+		 * IOCB_DIRECT is set and need to be cleared (see
+		 * generic_file_read_iter())
+		 */
+		iocb->ki_flags &= ~IOCB_DIRECT;
 		ret = xfs_file_buffered_read(iocb, to);
+	}
 
 	if (ret > 0)
 		XFS_STATS_ADD(mp, xs_read_bytes, ret);


