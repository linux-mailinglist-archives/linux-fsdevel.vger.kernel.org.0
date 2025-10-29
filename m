Return-Path: <linux-fsdevel+bounces-66114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE766C17D13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1391C845A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E6C2DC76A;
	Wed, 29 Oct 2025 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teKkQWJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EB2D94B6;
	Wed, 29 Oct 2025 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700451; cv=none; b=DwFgaJRXfejzNvGt+ntbxvGPURV2ibcKrq50TRokJByfCHYRa2y5YlkkN1Fj5LoyufYYKcv50tQUEs1C6dGGS+FXokk6Vf9tSludBfefPGrwDsWjE6FCTjqZKXCj3yZr770BXGvnf7l8l14tyQXmq91K71CAVsRlT5tgE3W6thY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700451; c=relaxed/simple;
	bh=DlO/eP36BsGUVGjbkpR3NKOExbnY6nlM614CdBWJbGQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWLMgImANwwuA8XXloGpB7JJwzT8FNM+O3uZawYwUfyZTSQZ7mGk2I3raMCO3J97AH1O4y9DhXvlONaUZxZfuAcXuwhtO8sJiNL6ujJKJ/qynnQevRjuxGgnLS4lP2AqHAEAVTScS+mQpup6byJZXhf3nvbvXi+mNDFIZyro+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teKkQWJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB80C4CEE7;
	Wed, 29 Oct 2025 01:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700450;
	bh=DlO/eP36BsGUVGjbkpR3NKOExbnY6nlM614CdBWJbGQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=teKkQWJK7NwQDP0i9XTxdY65+X3DCHR9qz25wcVuPiJ71a6X534CgvGMruB5Hi2ag
	 m9F/FfjPoLIumuSV/y1tZK6PwEZGKMH+rcYbTcOucemcpaLlPrFDYIy/j60aV3iXjZ
	 J2NMJpbrjcSVMye5yLVW32oylqoKNkT4KtGUgfj7rbGa/vOpnx8XoGJGCRHjCXVsdo
	 uwglWFZFtJib+ry+nXcsAWWyDph+DLnnntKP4uniJzzJpizlYEpf9Z/VuKUAqci55K
	 3rxUps8RQOd31SfedlfRG0nx0ylScKDe/A67etNnKbFX/ctLWKPbu0IV3C7qmxY7tc
	 VDt2SvtGnJxlg==
Date: Tue, 28 Oct 2025 18:14:09 -0700
Subject: [PATCH 03/11] fuse2fs: let the kernel tell us about acl/mode updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818275.1430380.13779724718780277203.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
References: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

When the kernel is running in iomap mode, it will also manage all the
ACL updates and the resulting file mode changes for us.  Disable the
manual implementation of it in fuse2fs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    4 ++--
 misc/fuse2fs.c    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index aeb3040c04b221..74b262b293eabc 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -2499,7 +2499,7 @@ static int fuse4fs_propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
 	size_t deflen;
 	int ret;
 
-	if (!ff->acl || S_ISDIR(mode))
+	if (!ff->acl || S_ISDIR(mode) || fuse4fs_iomap_enabled(ff))
 		return 0;
 
 	ret = fuse4fs_getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
@@ -3925,7 +3925,7 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!fuse4fs_is_superuser(ff, ctxt)) {
+	if (!fuse4fs_iomap_enabled(ff) && !fuse4fs_is_superuser(ff, ctxt)) {
 		ret = fuse4fs_in_file_group(ff, req, inode);
 		if (ret < 0)
 			return ret;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 283a9abdc1963c..30fe10ef25da1d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2301,7 +2301,7 @@ static int propagate_default_acls(struct fuse2fs *ff, ext2_ino_t parent,
 	size_t deflen;
 	int ret;
 
-	if (!ff->acl || S_ISDIR(mode))
+	if (!ff->acl || S_ISDIR(mode) || fuse2fs_iomap_enabled(ff))
 		return 0;
 
 	ret = __getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
@@ -3630,7 +3630,7 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!is_superuser(ff, ctxt)) {
+	if (!fuse2fs_iomap_enabled(ff) && !is_superuser(ff, ctxt)) {
 		ret = in_file_group(ctxt, &inode);
 		if (ret < 0)
 			goto out;


