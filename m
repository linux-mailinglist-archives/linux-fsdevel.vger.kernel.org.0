Return-Path: <linux-fsdevel+bounces-61643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C084FB58A95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B051B26924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090FC1C84B8;
	Tue, 16 Sep 2025 01:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCZgCfH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A2B3A1DB;
	Tue, 16 Sep 2025 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984654; cv=none; b=lZycTqo0zvICUYhBQveM6ZhoFSIyotWmKvC7aY470XZStKEBn1DQmSoLm7EVsF38mBUyaIJilUUu2wdgPDVJ8tP5tWxWJybuRjV5VIW9aYHy2fcwD9ITYccOgQ48tzYVnRAN4TtSaWZy+dUusYMigRDb2y1bndc8IaHkezaeJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984654; c=relaxed/simple;
	bh=steSzCuyTGHIaRt89u6L1AQH0mzh7GxXQ5LFaA4+tl8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UZ2kPZnxC4j/jb+IWVhbLFMaqEorZ6dxrKJ4JU1XAaZTOMIJiWDmwS106s3/04RzqLk66d99+DfZThPq9pWd1vfiuh8vX0kYkWBFxemO/Ut+ATCa7BrN+2fyHBMcwM4Z+M1zRe927LVso/x6R6DO/WFaarQicH4ON/zLlBIqZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCZgCfH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB51C4CEF1;
	Tue, 16 Sep 2025 01:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984654;
	bh=steSzCuyTGHIaRt89u6L1AQH0mzh7GxXQ5LFaA4+tl8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=sCZgCfH19NBmuwDcu1aYiOYptiAWkIHyVMAsVhO+z3Ti6jcqyPTqyfBkSEuwl3d3F
	 aPq/RvkpXqBkekoTMMvfBqWemgfxIXNfwIiFqzL7opmSGrBsmbNNkz4CeVPZ/zP357
	 ZZzpCkzy5svSTTkdiVf/AagC5YGJU2RQ8WUKjcW014WivJVwNzfrBW8KrnlN6jP5A8
	 eAE8xwVcWVRiQLjTkYrOXZIlepG5fJ9Ff7IGfJdqENLCo7lCXu2gJTBVTZtuoEeAc4
	 uYBPbMGR83MmCn8GSCyxLc6VNfWRl45Hty+3dI9nRkZRJlOHX2tcKtKtkmJfCyziNc
	 dCrkhbzbC4Xzg==
Date: Mon, 15 Sep 2025 18:04:13 -0700
Subject: [PATCH 03/10] fuse2fs: let the kernel tell us about acl/mode updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162394.391272.18208922781778627059.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
References: <175798162297.391272.17812368866586383182.stgit@frogsfrogsfrogs>
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
index 06be49164c783d..184066855517b1 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -2137,7 +2137,7 @@ static int fuse4fs_propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
 	size_t deflen;
 	int ret;
 
-	if (!ff->acl || S_ISDIR(mode))
+	if (!ff->acl || S_ISDIR(mode) || fuse4fs_iomap_enabled(ff))
 		return 0;
 
 	ret = fuse4fs_getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
@@ -3512,7 +3512,7 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!fuse4fs_is_superuser(ff, ctxt)) {
+	if (!fuse4fs_iomap_enabled(ff) && !fuse4fs_is_superuser(ff, ctxt)) {
 		ret = fuse4fs_in_file_group(ff, req, inode);
 		if (ret < 0)
 			return ret;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 716793b5fa485c..2b3c09a59270bc 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1937,7 +1937,7 @@ static int propagate_default_acls(struct fuse2fs *ff, ext2_ino_t parent,
 	size_t deflen;
 	int ret;
 
-	if (!ff->acl || S_ISDIR(mode))
+	if (!ff->acl || S_ISDIR(mode) || fuse2fs_iomap_enabled(ff))
 		return 0;
 
 	ret = __getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
@@ -3213,7 +3213,7 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!is_superuser(ff, ctxt)) {
+	if (!fuse2fs_iomap_enabled(ff) && !is_superuser(ff, ctxt)) {
 		ret = in_file_group(ctxt, &inode);
 		if (ret < 0)
 			goto out;


