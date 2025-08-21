Return-Path: <linux-fsdevel+bounces-58469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF67EB2E9E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D7018834FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECEA1E7C23;
	Thu, 21 Aug 2025 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEChEyax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085111C3BF7
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737989; cv=none; b=SoOoWJmI0r+0+3DAWXTL8LLHYRmD3jo5aOXpM3mNdByysNs7taF8+lmc71O72m+uEbpZ1jHKcgJsOne4dbP4vtwCpBl+wBlCvbPGEWL888EuEVnNq4tPYOSlvOTtrhSkfX3v8+vM+ZdhfrvhaYHs8pr9fLgHYNF3K4yR8CkQ5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737989; c=relaxed/simple;
	bh=8w9aGfsGt8rVh9Gj9L12Vnx7Xo297HkVb7IyVvvn6KM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emSdOpbEG1CQNq5SVVkD0NOo9Ye7ceEcpjElTWEIFqubYajsHIx7AMunV+ZFrehL5xHM6YRpU7m4/b7CUDXICoNTElrDibuW7Ew8FZ8Q1Jl4+r7gUGAXkYMNHD0HPtVkOTljTFcn2wX9ES0ye/V5dWCT3zUgxMIzNVmEn+nKG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEChEyax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7215EC4CEE7;
	Thu, 21 Aug 2025 00:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737988;
	bh=8w9aGfsGt8rVh9Gj9L12Vnx7Xo297HkVb7IyVvvn6KM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bEChEyaxa7gATlBBsMLU21Bx3o15sOyB3mC6bSE5WfdLx/YMII+Tl4TxeK7c0tH+8
	 GiVf7th25mF+thrKpWjt6aDM35SEo9+ytI9Davga9zt03wwTf4C6mEqMAB7uTyHwwZ
	 A9037NRur1oBmrPKK/YfNd8MNoY4kzaENIhRXK7DHriT8ELOzGPtjXD6ZvgqyjEsF5
	 s6rbndP4f7+lRhs+FetWaTqk/qrdEHteYbC7NtQGdJMCqLa2vQ1jwAFG9K78Az8Q/D
	 q4O9T0SP4w6H+gYw1VOaRivKHsLXwzvQdB0HRnpLBna1XLzk9iuYdf7OeiPsiA6G+v
	 U7Uk3QGWG7bjw==
Date: Wed, 20 Aug 2025 17:59:47 -0700
Subject: [PATCH 1/6] fuse: force a ctime update after a fileattr_set call when
 in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573710204.18622.13869238214569408777.stgit@frogsfrogsfrogs>
In-Reply-To: <175573710148.18622.12330106999267016022.stgit@frogsfrogsfrogs>
References: <175573710148.18622.12330106999267016022.stgit@frogsfrogsfrogs>
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


