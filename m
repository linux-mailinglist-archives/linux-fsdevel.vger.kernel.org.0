Return-Path: <linux-fsdevel+bounces-18241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3449F8B6893
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABABC1F23EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568761094E;
	Tue, 30 Apr 2024 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfeQrK7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A59FC01;
	Tue, 30 Apr 2024 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447634; cv=none; b=QUN8uSLyqZpl8y/k62R+X0OuDNlIhfKw5YhpisMLXq6I9QW2LCZWG36vnbOJnkxTfZfMWSYAaPTmHHsx5w8vMkszoiJ3CUh8jaIdKWssAOGWjCBWo/zhTbBFEp976kI0cE6FcqjBQlTzZsC7uC7kN8KR8fH5b1cUrT2sfSdt46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447634; c=relaxed/simple;
	bh=Kk4pQX3E3pjrfy36INOir67uM4aGpUGl0cZE2VwwHEQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bihor6xz5NZlw8AFbNtfPmaYcGlJa+4JJjhvfb4dDpPVGX9YKM8z1swvHj9VuydV6nVMFIyPt/eqpztk/V0D9zACB7QqTaSeaRtYyeZpMyFUBvph/1U9wBCinQEjDNqPntG6qrXrVlkkTghkQNhD2S0gkuAeuHK8/MZdgBMRnOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfeQrK7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880FEC116B1;
	Tue, 30 Apr 2024 03:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447634;
	bh=Kk4pQX3E3pjrfy36INOir67uM4aGpUGl0cZE2VwwHEQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QfeQrK7LPj7cp2Wj5e2HMfp0Q/miQAn8lQo36BrvBVPgNDgG23yfsRWMtcEWCFx95
	 W+dyhPgwd2LF8MNt1nYFr877Ldde3CB3+aokjVIXKL4BoQRFbsQ2R1OX97o+zwl3+s
	 ZfDKzs6bDPT/fU+h3O/PICiFXQ7K7jwUFKV9aH9bVO69IsuPvvRNz76grTJxoMSnmm
	 0aIrDv4lUa1oIWImhHFT5UfwHWTRwz+oaElIqRRTnPmf+qcJRvvj4+oCBoCur5Wgtf
	 P/rX84JAnNYqe20Pm0CqxLhwoHMXY4K9djKl1ZvHxGbEeGduI2maLaAVNc3Yuwxbk0
	 +Ii0mEgsXp8GQ==
Date: Mon, 29 Apr 2024 20:27:14 -0700
Subject: [PATCH 12/26] xfs: disable direct read path for fs-verity files
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444680567.957659.12115154461388222101.stgit@frogsfrogsfrogs>
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
index fe1f108aa6bff..2ab28c64373d6 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -269,7 +269,8 @@ xfs_file_dax_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret = 0;
 
 	trace_xfs_file_dax_read(iocb, to);
@@ -322,10 +323,18 @@ xfs_file_read_iter(
 
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
-	else if (iocb->ki_flags & IOCB_DIRECT)
+	else if ((iocb->ki_flags & IOCB_DIRECT) && !fsverity_active(inode))
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


