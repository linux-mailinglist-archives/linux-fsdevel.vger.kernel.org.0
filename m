Return-Path: <linux-fsdevel+bounces-58471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BA4B2E9E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D64A25539
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EEC1991DD;
	Thu, 21 Aug 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFeWhGJ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C94315A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738020; cv=none; b=Zj2GVA6CmDYDMbTBwvAWbcsjfRTnmtiD2EkMuKvJyhbC7Zi0qLmshpMn0oMrmEi/ODhynx9GCALQePv7do+ZHkoNJIAk+ICX4Ne3VkaU+EGDUxSQWa8OIp189E/Wku1f2HrjGOAm+Kx316y1weWsrIyUhy9xmtJ/SEYuCnTdwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738020; c=relaxed/simple;
	bh=sDl72G5vCXOQ7cEQJCI/QSSaoDeEryhAxpwJtiD6YUA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddnKBtr2cGjdKJ6XJiXGN61PUwIQlNNs3yvxgYe9DMZD2dWMo6DFSVZJ6PCuiKdgYhkjxhMT7EiaMJsdjq5rJjm4PBua6Z2oa3VJp5GwG6SxgptBTnkQ7F1lu86ABoFlGcsyNtq6WrthNQ5Uxw6JT4wV7FrgOFeX8Yny6vHh1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFeWhGJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ED5C4CEE7;
	Thu, 21 Aug 2025 01:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738019;
	bh=sDl72G5vCXOQ7cEQJCI/QSSaoDeEryhAxpwJtiD6YUA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iFeWhGJ1T+4TiyNhXxfb2YQIME02jitMcNrNzSjLEuU3tsCvl30w/wtqNFjkNrEJX
	 emYdi34Jyb8Y00ZwpHAl5XVgU4aKKyXh8SbczmDN3fOvKKjgEDZyHtPKvrUMWAjjcb
	 pY0nm71UJzt4145RQvs78oDjSfFjU7DiMnmkctAaefu7dUzPnE1K8GpCgVG9HTrYoZ
	 lsFh0x8tVnrYj3wa6clP8T6L+tYapxC+A0ROfq5stMSlQARDriD3wBIOtZMxn62puV
	 U9r7XfO3e08KLAZmv0cDZ6J0VST2+OPOc7pzVaNesZnS776qaxxagPAJvgBxu84E2r
	 cK9pF2lAtDSGg==
Date: Wed, 20 Aug 2025 18:00:19 -0700
Subject: [PATCH 3/6] fuse: cache atime when in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573710246.18622.9098013687668027248.stgit@frogsfrogsfrogs>
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

When we're running in iomap mode, allow the kernel to cache the access
timestamp to further reduce the number of roundtrips to the fuse server.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dir.c   |    5 +++++
 fs/fuse/inode.c |   19 ++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d2f9bcccd776f0..a3ea50b99054ff 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2030,6 +2030,11 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
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
index b1793df3cbbd1a..91143845c615c4 100644
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
@@ -331,8 +332,12 @@ u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (S_ISREG(inode->i_mode) &&
-	    (fuse_inode_has_iomap(inode) || fc->writeback_cache))
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	if (fuse_inode_has_iomap(inode))
+		return STATX_MTIME | STATX_CTIME | STATX_ATIME | STATX_SIZE;
+	if (fc->writeback_cache)
 		return STATX_MTIME | STATX_CTIME | STATX_SIZE;
 
 	return 0;
@@ -451,6 +456,14 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
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


