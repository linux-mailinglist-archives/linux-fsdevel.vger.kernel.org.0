Return-Path: <linux-fsdevel+bounces-61543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982E4B589BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E983AC581
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F41A2545;
	Tue, 16 Sep 2025 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATRLr9PB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157E82032D;
	Tue, 16 Sep 2025 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983042; cv=none; b=dPh1OUIKBG0xwUpQULn4Kl7brcjJL09baGFvd+uv+47r05oUiaTJRdH71nAiSRn8ulJcprX0osl4HV0ezYfC2eERpybSzUSgM6FV8CofVtCu54VJDPiWdeQVyB7m7Uuz2uoMxvYrIYiNmsLy2JgDLZTPigraLVYwbxHKHRdfIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983042; c=relaxed/simple;
	bh=QjNFVdhNye8yv2jilMjAuhV+Z3kQGDnP4MwhWwz8xUk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhHHXY8t0WRfqevNI7MeCjmgBn30jE39CpUGhmIVT/aaeo4KBgseSlReZxXcbYo7xYtHZ2WmgKtqpptCMTja3ezS8HJ8Xg4noA84TR4NDhs3IU3h45VYHm+j0lnpgFwLfs9aMWxlGpE6RkXUreQP/Ylxy9loB/Yx/JCIO49+L74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATRLr9PB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CE7C4CEF5;
	Tue, 16 Sep 2025 00:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983042;
	bh=QjNFVdhNye8yv2jilMjAuhV+Z3kQGDnP4MwhWwz8xUk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ATRLr9PBmd/6KepBVZ47QWgJsRpNEp6IM+mpZwvoN9sDcEO7hAQW9NUeEJgjz2a0k
	 sTINuEIrxJPJH8fKDxKmuYWXhYcjmkcDwRdnMqrwVcT7JOI6wLxcke8wHe449zDlmv
	 Zq7YqaSKU+PFjRlZGWsqsH0O8BYuQ9dhEEaESPTTuxMd2M3oLPvWi3+Wask6tfP0Nz
	 yxrmp7jz2f7+OsMSiqAvIs5LdKa6hnTg7BC1qK1eH+az+fJge/VCKBN8pbfOeAN59u
	 NvdfiZ8315x47naKViWlpoxbC7J0yzD6SmyghLiHGUGG8RZJiEDv4HbntGIE8tU4aF
	 /5D3uI5dkDUYg==
Date: Mon, 15 Sep 2025 17:37:21 -0700
Subject: [PATCH 5/9] fuse: cache atime when in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152546.383971.2677594174755287145.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
References: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
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
index 30c914ba4bb23f..8247e5196fd0b2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2033,6 +2033,11 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
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
index f845864bf50dee..c29a8cbc55fa27 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -266,7 +266,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
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
-	    (fuse_inode_has_iomap(inode) || fc->writeback_cache))
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	if (fuse_inode_has_iomap(inode))
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
+	if (fuse_inode_has_iomap(inode))
+		inode_set_atime(inode, attr->atime, attr->atimensec);
+
 	/*
 	 * Ensure that we don't cache acls for daemons without FUSE_POSIX_ACL
 	 * so they see the exact same behavior as before.


