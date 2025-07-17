Return-Path: <linux-fsdevel+bounces-55390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90D3B09884
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B961892546
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663F92405E7;
	Thu, 17 Jul 2025 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="petIoxaG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31F54503B;
	Thu, 17 Jul 2025 23:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795970; cv=none; b=PDDD9OTC2mc9OyiATyQYlXeG15TIGCF/j6T/d3avqeN61GpWSWhJWv4DO8gSM1ULdcn4dBj7oQJj+lf2VAsQB8ymmFFZiRy/8cgNpEt4FgvlwZBONgZI+Ay8nslPA+tlJ4js/jHdpUewXAR3vHePbDTG9eU48ZaaMG9eJZPea3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795970; c=relaxed/simple;
	bh=7Wi2ze/sE60JRTvumzpSEdInx2Gw52MC0Dqqyl2VBHc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JH4v7cQE8/M7MYHIzgblGFxdvqtbEKG7m0IdWqBcxLjqYy6QkM3zZiKGOQaSP0T2uk4/hVR8A9i4qaandp+y1sn6hxHugrtSOagJpZC+qS1zjcDGPXdU0o8PlRyrjusmYZDo8Q/aZhumHE7ce7UJaSEtg1aFVUL+Q93O4L2uT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=petIoxaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980A0C4CEE3;
	Thu, 17 Jul 2025 23:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795970;
	bh=7Wi2ze/sE60JRTvumzpSEdInx2Gw52MC0Dqqyl2VBHc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=petIoxaGA/lOt6kiQLouIznbWxdjt5xjKTxe4h61OwGUXdSyopHQBAw9TxDA7vyRg
	 Sod1LccWl0HxmYLkuZ5ytOCZuT6WRx/jgjC57tGKdVitI8P11GhlgXlDMpM7b4fThH
	 W7j6pi9X3uulPD1RMqc79droZxn4V2WMqOloFtbFprW2P0WTrdPtbWvn7E3QO2QdhX
	 BEs+cA0jdKG+dg7aDWi3Fs8HalOSVg+9CtO6t9tQc4ltHH2H2x3I29QFTxhhD4w4cg
	 kT3Re+x2vWu5o44jjpMnMZ2XMmBp9Ip0e7j2NNaY9vP9/Hii3W4ZBgRMte7JF+ykkn
	 eW886t1jXA86A==
Date: Thu, 17 Jul 2025 16:46:10 -0700
Subject: [PATCH 03/10] fuse2fs: let the kernel tell us about acl/mode updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461773.716436.5581132815831111781.stgit@frogsfrogsfrogs>
In-Reply-To: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
References: <175279461680.716436.11923939115339176158.stgit@frogsfrogsfrogs>
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
 1 file changed, 2 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5d75cffa8f6bca..e580622d39b1d1 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1739,7 +1739,7 @@ static int propagate_default_acls(struct fuse2fs *ff, ext2_ino_t parent,
 	size_t deflen;
 	int ret;
 
-	if (!ff->acl)
+	if (!ff->acl || fuse2fs_iomap_does_fileio(ff))
 		return 0;
 
 	ret = __getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
@@ -2999,7 +2999,7 @@ static int op_chmod(const char *path, mode_t mode
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!is_superuser(ff, ctxt)) {
+	if (!fuse2fs_iomap_does_fileio(ff) && !is_superuser(ff, ctxt)) {
 		ret = in_file_group(ctxt, &inode);
 		if (ret < 0)
 			goto out;


