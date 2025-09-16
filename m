Return-Path: <linux-fsdevel+bounces-61540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2069AB589B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0274169094
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF801A3172;
	Tue, 16 Sep 2025 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzuU+kD6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491A7483;
	Tue, 16 Sep 2025 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982995; cv=none; b=iBfekMvdoHr+6bL5XJ5FNr/2RyMlynespMbXVbBtWuypbaYymUrcQXGFW8PYuXF8rDtahbmguVXBaAkyJXDAbB3mhqDl30zbV7c0piksOPNL+bRtovuIGD6+ZGanLW416JbRHFGrR0+T7tTugoksNPhODzhjrFFWVm4fF7ITYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982995; c=relaxed/simple;
	bh=8w9aGfsGt8rVh9Gj9L12Vnx7Xo297HkVb7IyVvvn6KM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNPklIe1eMCNaFViS55mcy31NZopQhk8fDuAZnRjwv4mc4/bHbxl0ZSkIFSGfsBbHglELi4oZk0nAzlwJVYjJjNpxuLG2vojd8nZhZfRa33T2oavLS4P9YL6e/aJQUFh11zfFZtDeyQbVytk33Z+Hh4GC1JaWqvigqvoUxYSJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzuU+kD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E04C4CEF5;
	Tue, 16 Sep 2025 00:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982995;
	bh=8w9aGfsGt8rVh9Gj9L12Vnx7Xo297HkVb7IyVvvn6KM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nzuU+kD6T2JHVgWkFSiREOfVtWLRYLcE/Zib1OvSOuZtXUW87C8JDJ0VgUpmTFMlm
	 Qq5igHOyjjO80MSMPpe2zylO/KPKFNqxtXLTglyMLzKD3rb2hWApIM2z0jNywyhfcI
	 GkH+YbxZhGjXPjdUEoFaTZ7aWh/1a56YLzR6BUdrD0IoRwuonm+ey4BZwcHcsVCgCq
	 KAIcG/HtEuSSqwKI1awwgJtqDZjrSQqH1vExsQYk+vAavBActmxOAr2ka1i2fPVpZ4
	 FqYRt4TWmSRzfQWUS6ddYsfXdgMXnVjJsk0ZOOBkOmgn9cwITskFwYg1QJcWXkRK4g
	 LEsS7fw4w7rUA==
Date: Mon, 15 Sep 2025 17:36:34 -0700
Subject: [PATCH 2/9] fuse: force a ctime update after a fileattr_set call when
 in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152482.383971.4041104594209831935.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
References: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, the kernel is in charge of driving ctime updates to
the fuse server and ignores updates coming from the fuse server.
Therefore, when someone calls fileattr_set to change file attributes, we
must force a ctime update.

Found by generic/277.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/ioctl.c |   11 +++++++++++
 1 file changed, 11 insertions(+)


diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 57032eadca6c27..f5f7d806262cdf 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -548,8 +548,13 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 	struct fuse_file *ff;
 	unsigned int flags = fa->flags;
 	struct fsxattr xfa;
+	struct file_kattr old_ma = { };
+	bool is_wb = (fuse_get_cache_mask(inode) & STATX_CTIME);
 	int err;
 
+	if (is_wb)
+		vfs_fileattr_get(dentry, &old_ma);
+
 	ff = fuse_priv_ioctl_prepare(inode);
 	if (IS_ERR(ff))
 		return PTR_ERR(ff);
@@ -573,6 +578,12 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);
+	/*
+	 * If we cache ctime updates and the fileattr changed, then force a
+	 * ctime update.
+	 */
+	if (is_wb && memcmp(&old_ma, fa, sizeof(old_ma)))
+		fuse_update_ctime(inode);
 
 	if (err == -ENOTTY)
 		err = -EOPNOTSUPP;


