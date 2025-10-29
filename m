Return-Path: <linux-fsdevel+bounces-66041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73CEC17AC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD511C82B6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4E82D6E71;
	Wed, 29 Oct 2025 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XySbRpZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD02D0C84;
	Wed, 29 Oct 2025 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699308; cv=none; b=pzp463ifbhzII6KdHydgDXTkH/8+L2OgnmI03Gqrd2RdarJarV7Ri0n/qiNsMt+YtCJfw0h836C3vDqAoqatRtd7QW2EEifnndIl3XJ5oF9W/jo3GgE5znxf1I+ZcfUwKBCFNWb/NhvRbToEIv7xtAg6/Uikd7NmFRjy21RLWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699308; c=relaxed/simple;
	bh=Q5Q6ZQLTvYB7BTBMX0ia5xnpMzmFAPbTPLDVl9tIBz8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krI4Fhu6oz82jX/weRfEbFpBQrMBSRTMzhZHMXurH0vbf+68p993eV5ZVnOvEn0LFUc0CD+EdlPZZgwObHuMb1RPZr3aafF3SuhVWPltYXqGA0j6shGhq7+0l0WP5Fo+i52KDCyFiLVOsoX0wjh1vBomSoexvZ7p0Ej3ZTmN3UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XySbRpZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DE1C4CEE7;
	Wed, 29 Oct 2025 00:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699307;
	bh=Q5Q6ZQLTvYB7BTBMX0ia5xnpMzmFAPbTPLDVl9tIBz8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XySbRpZg2Tl/THjixYjW6zGKD7tgmPizUNZNhVCXeMIX1a1d5IwaIMRL+MQyXO4/F
	 qE1EhNeHWAOGITLE5TRiUIaGZU00FVCLSwvJD1WwQJKKugJKoDate3EeYb8aN2RkyE
	 8Zfm1na2hryFFtxm7ZMuZD7vfWdP/J+nk9SUmf60acrrUbBRz5Me54pte9CINyfLtM
	 guVQkmF/o9xPxfzWPKUjVUESYU5IhQzVXT8+Nuho34Uya2V3Hxa9bCzgzewVe7uTp2
	 2DxIoBy3j5YqbMBpVaz278oIgmMc+w0KFZedHDGHrjCvNg0TuRh9ctFoiLhj971ES+
	 JomtOILFpx5Bg==
Date: Tue, 28 Oct 2025 17:55:07 -0700
Subject: [PATCH 5/9] fuse: cache atime when in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811699.1426244.11280100587640231801.stgit@frogsfrogsfrogs>
In-Reply-To: <176169811533.1426244.7175103913810588669.stgit@frogsfrogsfrogs>
References: <176169811533.1426244.7175103913810588669.stgit@frogsfrogsfrogs>
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
index 492222862ed2b0..135c601230e547 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2026,6 +2026,11 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
 		inarg.ctime = inode_get_ctime_sec(inode);
 		inarg.ctimensec = inode_get_ctime_nsec(inode);
 	}
+	if (fuse_inode_has_iomap(inode)) {
+		inarg.valid |= FATTR_ATIME;
+		inarg.atime = inode_get_atime_sec(inode);
+		inarg.atimensec = inode_get_atime_nsec(inode);
+	}
 	if (ff) {
 		inarg.valid |= FATTR_FH;
 		inarg.fh = ff->fh;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 707bd3718be681..c82c6a29904396 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -263,7 +263,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 	attr->mtimensec = min_t(u32, attr->mtimensec, NSEC_PER_SEC - 1);
 	attr->ctimensec = min_t(u32, attr->ctimensec, NSEC_PER_SEC - 1);
 
-	inode_set_atime(inode, attr->atime, attr->atimensec);
+	if (!(cache_mask & STATX_ATIME))
+		inode_set_atime(inode, attr->atime, attr->atimensec);
 	/* mtime from server may be stale due to local buffered write */
 	if (!(cache_mask & STATX_MTIME)) {
 		inode_set_mtime(inode, attr->mtime, attr->mtimensec);
@@ -326,8 +327,12 @@ u32 fuse_get_cache_mask(struct inode *inode)
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
@@ -458,6 +463,14 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 		BUG();
 		break;
 	}
+
+	/*
+	 * iomap caches atime too, so we must load it from the fuse server
+	 * at instantiation time.
+	 */
+	if (fuse_inode_has_iomap(inode))
+		inode_set_atime(inode, attr->atime, attr->atimensec);
+
 	/*
 	 * Ensure that we don't cache acls for daemons without FUSE_POSIX_ACL
 	 * so they see the exact same behavior as before.


