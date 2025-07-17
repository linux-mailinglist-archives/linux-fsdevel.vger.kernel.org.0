Return-Path: <linux-fsdevel+bounces-55341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF78B09813
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03ED17B70D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920522248AF;
	Thu, 17 Jul 2025 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkucgXH/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08972153C1
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795203; cv=none; b=dtSUzyhYNusUf5PoBNM+JUq9c2YWLm2Lu9XD+mDIt4RZ6tOGIWBRrbxBTeoXa8srHLgD7RBEEPUulxtGVrWR2x7yLQ36tWjTK/Nw92Mth2P0fKoWCgwTvC/ilbPleNfzhXiKAf1bKruNH/NMGImTexn7SyKb5fX0daT+aYl6OV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795203; c=relaxed/simple;
	bh=OYFeRSyynTi8o8/tMqY00QmtcHoUmiFm/TcIJ2sBGVY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flriI+6XNfLtJCqV9OjUmlI5cYSJqMN3SpOm957jC/+hWHN5PNlnT1KNHw+SagD+hgChMc/BvwgMdWT66kRFJRvO1C5++NEJ8RK8tkwpVk+Jb9K/DrERAjuVco8tQsZnYg46vDfnNfmuEyOO4dzonuumiSJrnm9q4NoOE121dR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkucgXH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B93C4CEE3;
	Thu, 17 Jul 2025 23:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795202;
	bh=OYFeRSyynTi8o8/tMqY00QmtcHoUmiFm/TcIJ2sBGVY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UkucgXH/44UWmPeaN0sq4uNFFxV/cfMgng53x2neRYeaTYd8cUMcGVL1QM/YZwBdC
	 8dDij6OivNndSEAsJXyngghuGoRJLumyOjq3NCi6r3kt/lkaiVllGJ5Y2ZZLgQqIiQ
	 ubvp5M2kR6eq2nlqenZ5uy+vjKC5mjZ/iZkRVnsGsDrnkC2Yzxa+E1Q6RraMz4CctW
	 Os6tomLgbD3NULeLxVN2J3ScXVY62uRP/y81HEDlWChHH/sfES/fyol1uTNpR2yCbj
	 KDwFXAuDPFiRzxaYwDL/iN/UsV4o+m6ldW5pgX0kWDj84U6c1IvWtANI75G2kQUvbm
	 U/7qCuF93G/wA==
Date: Thu, 17 Jul 2025 16:33:22 -0700
Subject: [PATCH 3/7] fuse: cache atime when in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450848.713693.15132363459902458158.stgit@frogsfrogsfrogs>
In-Reply-To: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
References: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

When we're running in iomap mode, allow the kernel to cache the access
timestamp to further reduce the number of roundtrips to the fuse server.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c   |    5 +++++
 fs/fuse/inode.c |   19 ++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 56ef73dd58e3b6..33a375a21b2da1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1936,6 +1936,11 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
 		inarg.ctime = inode_get_ctime_sec(inode);
 		inarg.ctimensec = inode_get_ctime_nsec(inode);
 	}
+	if (fuse_has_iomap(inode)) {
+		inarg.valid |= FATTR_ATIME;
+		inarg.atime = inode_get_atime_sec(inode);
+		inarg.atimensec = inode_get_atime_nsec(inode);
+	}
 	if (ff) {
 		inarg.valid |= FATTR_FH;
 		inarg.fh = ff->fh;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 84f68dc37db64f..19d51a44793e0c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -264,7 +264,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	attr->mtimensec = min_t(u32, attr->mtimensec, NSEC_PER_SEC - 1);
 	attr->ctimensec = min_t(u32, attr->ctimensec, NSEC_PER_SEC - 1);
 
-	inode_set_atime(inode, attr->atime, attr->atimensec);
+	if (!(cache_mask & STATX_ATIME))
+		inode_set_atime(inode, attr->atime, attr->atimensec);
 	/* mtime from server may be stale due to local buffered write */
 	if (!(cache_mask & STATX_MTIME)) {
 		inode_set_mtime(inode, attr->mtime, attr->mtimensec);
@@ -328,8 +329,12 @@ u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (S_ISREG(inode->i_mode) &&
-	    (fuse_has_iomap_fileio(inode) || fc->writeback_cache))
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	if (fuse_has_iomap_fileio(inode))
+		return STATX_MTIME | STATX_CTIME | STATX_ATIME | STATX_SIZE;
+	if (fc->writeback_cache)
 		return STATX_MTIME | STATX_CTIME | STATX_SIZE;
 
 	return 0;
@@ -448,6 +453,14 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 				   new_decode_dev(attr->rdev));
 	} else
 		BUG();
+
+	/*
+	 * iomap caches atime too, so we must load it from the fuse server
+	 * at instantiation time.
+	 */
+	if (fuse_has_iomap(inode))
+		inode_set_atime(inode, attr->atime, attr->atimensec);
+
 	/*
 	 * Ensure that we don't cache acls for daemons without FUSE_POSIX_ACL
 	 * so they see the exact same behavior as before.


