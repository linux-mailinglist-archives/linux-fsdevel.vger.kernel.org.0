Return-Path: <linux-fsdevel+bounces-69283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EE4C7680D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BD9F4E3185
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2582EFD86;
	Thu, 20 Nov 2025 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhwS90Mx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A3327B349
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677946; cv=none; b=r/OC+avC/Pgy3njDP5MYkgYsoIim9sgd/eTVGwyNTSEVaPUBEdC2/Y/G6OiVsQL7Q7FtOkDUs6NH9lNH8EZgnPJG/jdGA4efcX+smw98lFaVj+G7cwcTn2zQefLjEEbTj7ULckvmsCZoqD9y49bvlhCMbhJTYrkbTXgou7DJxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677946; c=relaxed/simple;
	bh=+zvK+Jvs9HRh4cTb/3Jb9RWzgKjLOLuY3JL2+fiURx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uPzufsPi0bOKh1ERO5c+UD21w+gTy5UHxzMRfAzWI31v44hJkT77LboC6pyD/NHjOFGeu8m3Mjs9Y0uyMXZvBI72AH5dhwAvVrAF1+miFDQuGuGL30u4olNMENpuEu7zndnvSdgo7CkSWHIIWyRLdEYuKo4mcgZ+UTFvqXLKBSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhwS90Mx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26296C113D0;
	Thu, 20 Nov 2025 22:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677945;
	bh=+zvK+Jvs9HRh4cTb/3Jb9RWzgKjLOLuY3JL2+fiURx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dhwS90MxSFh+VdFAZXzgAuKCO+oGHcghJKSvsf+wIMcAmIVoV71gp/JfLd/tqQmPJ
	 wJ4bBGyMV7aF1UJ2ghDn2lK4YEVjFYh4s5BHILZAcDX4hNuiq/nMJyg1Ky8KfWULFI
	 nz2yw8hGxFmkZQVY4i5/sQfIQqvNaEWG4iF77bXueXPgaIssgpiw48FwQGv/HDfbeT
	 aso4lS72lcGVCVygW3/PoDND+4PPhl8FYDa/9S0R1q/rkT+6HD/mAPYL/VIbg9bCkq
	 VGyDlKx6oGSI+lgX5nDF1Ui5uTMoaJ/JRQy48zQSSNMo/7K+1BT4mesXWfs8P4PPvs
	 /Tx0H1vrczI+g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:01 +0100
Subject: [PATCH RFC v2 04/48] fhandle: convert do_handle_open() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-4-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+zvK+Jvs9HRh4cTb/3Jb9RWzgKjLOLuY3JL2+fiURx0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vzeYZB531l3l32v9meHuE5xfLq5s3fpVtnBnsuz
 du3eL2IUEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBESjQYGRaprP/7/ZPdMfed
 ttVy3GbfHk0KMN/y9utvnqAqRwZtnusM/312PM/NvXhU8Lp5tv8vvcKDS5KOrWI6eWjdMrYVobZ
 GikwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 052f9c9368fb..c31c90b6ad53 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -404,32 +404,33 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	return retval;
 }
 
+static struct file *file_open_handle(struct path *path, int open_flag)
+{
+	const struct export_operations *eops;
+
+	eops = path->mnt->mnt_sb->s_export_op;
+	if (eops->open)
+		return eops->open(path, open_flag);
+
+	return file_open_root(path, "", open_flag, 0);
+}
+
 static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 			   int open_flag)
 {
 	long retval = 0;
 	struct path path __free(path_put) = {};
-	struct file *file;
-	const struct export_operations *eops;
 
 	retval = handle_to_path(mountdirfd, ufh, &path, open_flag);
 	if (retval)
 		return retval;
 
-	CLASS(get_unused_fd, fd)(open_flag);
-	if (fd < 0)
-		return fd;
-
-	eops = path.mnt->mnt_sb->s_export_op;
-	if (eops->open)
-		file = eops->open(&path, open_flag);
-	else
-		file = file_open_root(&path, "", open_flag, 0);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
+	FD_PREPARE(fdf, open_flag, file_open_handle(&path, open_flag)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	fd_install(fd, file);
-	return take_fd(fd);
+		return fd_publish(fdf);
+	}
 }
 
 /**

-- 
2.47.3


