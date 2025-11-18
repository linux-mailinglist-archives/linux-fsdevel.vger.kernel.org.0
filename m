Return-Path: <linux-fsdevel+bounces-68971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F8DC6A70A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11D0E35F791
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFD7369987;
	Tue, 18 Nov 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ6n4oUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1022B369979
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481002; cv=none; b=VgzmR7uYNlgAY5wPhUAlPYWUDOFm2ucYZhdkayevESG4zbSw9WJbTq96YhsAN5aQ5niPqveFoSOCF+bo2+dnCnpBifcdxYXcO14Bv/J1heymIamSqnnwVbgcm+VC8QXO/uQTDhU4Y72zABhyCnYLr7FDPrrNzLwWeHZhoXARv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481002; c=relaxed/simple;
	bh=yBlFC0JH5Y9tDJmuu+rqv70PAnIRFNsPGI2DZBEbXkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tcActGsOoi3kRMbaJQwfssmIMjMK8Ti4unn7KxBWghbvsSmQA2GnRKPQCaRdLEMMMg92Ow9EIZP0V7DqDxD8f36N8LgaFBtiINcFZbfGMXcZBEykXA0A9w9+5O4n/jO4bcFMJzU1jZUqXBxPOcq3i6yPaZV+4cyREgmEN8mk2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ6n4oUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3029FC19424;
	Tue, 18 Nov 2025 15:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481001;
	bh=yBlFC0JH5Y9tDJmuu+rqv70PAnIRFNsPGI2DZBEbXkI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VZ6n4oUnwePmAkPfvFbk/ogm55XK5jdIAf/P8QxupllRCJwhsMA1jH4B9Tm05W0An
	 ZP6ae8fPzMAdfHtXvDYJIzHy177GvnbtveKQM57vn1MK0nnZyp1x9/8cgu4z6QdriC
	 DB+LRjZsDudXLHl0YY6zOgYx5UgtxNh8WaSnGN0wuGnv7/+nnhY172d3ewJPu0wUv+
	 kFmDI1wzAT8mjWykukp14dCB1haPgWSBrOb5qLKFTxKMcr2W4qDLRh4ctpMnmmsu+G
	 1j4YKyTzy+irYk1vuXgv32XLWEN7Hj/LNGUx6dV3fpY4OuAvqKrm7S0QU7ABJA4ozw
	 VEkHQ1w8xrfyA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:52 +0100
Subject: [PATCH DRAFT RFC UNTESTED 12/18] fs: nsfs2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-12-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yBlFC0JH5Y9tDJmuu+rqv70PAnIRFNsPGI2DZBEbXkI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO2/duDNIa90lwucl/yDGyc1b/bYyXH7ZyD7EpPXW
 xfYTtHV6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI0k1GhrmzLnfM4fD++XTB
 Ay/rL6wP/M2O1kWG/36+/2jSMvXr4bMZGZayLl+/kuNMpOwuFXmVFB7Z9h3Gh142RXlOficimri
 qigsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index cf20fba0ecd2..b725fd152afb 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -327,28 +327,19 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		if (ret)
 			return ret;
 
-		CLASS(get_unused_fd, fd)(O_CLOEXEC);
-		if (fd < 0)
-			return fd;
-
-		f = dentry_open(&path, O_RDONLY, current_cred());
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-
-		if (uinfo) {
-			/*
-			 * If @uinfo is passed return all information about the
-			 * mount namespace as well.
-			 */
-			ret = copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
-			if (ret)
-				return ret;
-		}
+		FD_PREPARE(fdprep, O_CLOEXEC, dentry_open(&path, O_RDONLY, current_cred()));
+		if (fd_prepare_failed(fdprep))
+			return fd_prepare_error(fdprep);
+
+		/*
+		 * If @uinfo is passed return all information about the
+		 * mount namespace as well.
+		 */
+		ret = copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
+		if (ret)
+			return ret;
 
-		/* Transfer reference of @f to caller's fdtable. */
-		fd_install(fd, no_free_ptr(f));
-		/* File descriptor is live so hand it off to the caller. */
-		return take_fd(fd);
+		return fd_publish(fdprep);
 	}
 	default:
 		ret = -ENOTTY;

-- 
2.47.3


