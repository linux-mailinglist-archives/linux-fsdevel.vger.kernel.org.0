Return-Path: <linux-fsdevel+bounces-58553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C38B2EA88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57A994E4471
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E15C214A97;
	Thu, 21 Aug 2025 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpAMGOta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1820ADD6;
	Thu, 21 Aug 2025 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739302; cv=none; b=p4ov1US2sOVPZmYD9K5UKASF4J8UNfPmnIMHvDKAZrtw/TOW8qNkef/PIJxe0FAJBnoSxuL+k6yd4nv2dcsEuCPHNo4DZ+cybKFHB5Lplnqq5tA56mP4AsmxlL9ojZy3z4qMf4jc0E77NBId+SMUeRjFOANs6mwgkG9GsoINQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739302; c=relaxed/simple;
	bh=69q+i14Up6NN6LopxCD3UWgp76IyiFGPwPTcG/ogMFM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFKqjaRHEyZnts03DDSDpxpALTlc+qxCa4zJFIKFGovaI1VkBR3mvXaQNND1XhWgHZpvwKPiMlVYUKU1O/zW37Jtp6kwrfTu54u+jcxU7gwzO0Ifg2hUXn8w+5cpZ8ktAZUWLZB082ucPgGVbMWbJu853HOenSrF9FzMmToaznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpAMGOta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3FBC4CEE7;
	Thu, 21 Aug 2025 01:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755739302;
	bh=69q+i14Up6NN6LopxCD3UWgp76IyiFGPwPTcG/ogMFM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CpAMGOtaHQeWdLkRti80pA8lDrDBo0QYZyaTsF/gKH50/A2IDp5h+q2BvjLS8KbRA
	 Yo4ZYYPkAz/h3X0ztBN2e07abbC8FvHpB3Cb9FCGHnuf80cGp6aDxRlRma/esOmq5r
	 oo37IIVRL2PHESIeW3J714S343lSlmOlwiXbKraG/+cCaAlZ/niofTHyhRnCbR5XtT
	 /hl+7LRGC54gTT4FADXxpvHNwDtALKHZj6sw9aX9lIv/7HCPWzgcDuzF30+RZax03s
	 YDm1qsR4/yCb1pFvbQesWZ5DgOZz9mZwWPlYCxmKaP4YyWHpiLZ/UdUXFCXTpQSlU9
	 wALNLjc6S/0pQ==
Date: Wed, 20 Aug 2025 18:21:42 -0700
Subject: [PATCH 2/8] fuse2fs: let the kernel tell us about acl/mode updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: John@groves.net, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com,
 neal@gompa.dev
Message-ID: <175573714428.22854.12416869399774403756.stgit@frogsfrogsfrogs>
In-Reply-To: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
References: <175573714359.22854.5198450217393478706.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |    4 ++--
 misc/fuse4fs.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 95e850e3cd49f1..11ddf6a4001955 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1939,7 +1939,7 @@ static int propagate_default_acls(struct fuse2fs *ff, ext2_ino_t parent,
 	size_t deflen;
 	int ret;
 
-	if (!ff->acl)
+	if (!ff->acl || fuse2fs_iomap_enabled(ff))
 		return 0;
 
 	ret = __getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
@@ -3224,7 +3224,7 @@ static int op_chmod(const char *path, mode_t mode
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!is_superuser(ff, ctxt)) {
+	if (!fuse2fs_iomap_enabled(ff) && !is_superuser(ff, ctxt)) {
 		ret = in_file_group(ctxt, &inode);
 		if (ret < 0)
 			goto out;
diff --git a/misc/fuse4fs.c b/misc/fuse4fs.c
index 8d547e03f558df..ef6f3b33db99fd 100644
--- a/misc/fuse4fs.c
+++ b/misc/fuse4fs.c
@@ -2112,7 +2112,7 @@ static int fuse4fs_propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
 	size_t deflen;
 	int ret;
 
-	if (!ff->acl)
+	if (!ff->acl || fuse4fs_iomap_enabled(ff))
 		return 0;
 
 	ret = fuse4fs_getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
@@ -3480,7 +3480,7 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!fuse4fs_is_superuser(ff, ctxt)) {
+	if (!fuse4fs_iomap_enabled(ff) && !fuse4fs_is_superuser(ff, ctxt)) {
 		ret = fuse4fs_in_file_group(ff, req, inode);
 		if (ret < 0)
 			return ret;


