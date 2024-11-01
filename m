Return-Path: <linux-fsdevel+bounces-33389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB99B883A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 02:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC1A1F220E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FF641C94;
	Fri,  1 Nov 2024 01:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Om83Qbmp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F76125D5
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730423855; cv=none; b=t0IxGc/5eTjQRSfwzxB/pzZJuyR0OCGp7esgjEVtX3zBxD2wYfWJN1vkRr2S76zEH9O+Nr/SI5EcLyJe45xf8tUNvbvtJ5W0W9zUa7cB00hu58vgIvIYeGZ/4VXaN921y0gBLLH3Oqjc2deU/DjAnp+sLh1xK80kbDchQo+ddRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730423855; c=relaxed/simple;
	bh=G/vsxwj2E7d2V71qUCQsacYCV8Lufk+V6y/fnZbSbBc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q3ITE+0aUJZKyPE+mULMYQ+NDzFSNDTJENLfQF71rzGz3uwE2hAulbooTShbyH0jdsn/lmxXdZcGyhQewIRyoxTOge1X5XzHs4QfCEYNptusdcjqcHHz6wYpNGnReEFE1hh/fGhFi7NODmW5iUcR/jtvEWDAVHQ70XLBkgIzN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Om83Qbmp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1PmlZa3hVyZT72GjUI9iaKzLSQWnEjqcoaOpBfbwz6E=; b=Om83Qbmp0G9orsWd065VKaYhu8
	HKtrbJrCUqtVmjqycnMefsJS5w3CdKpfswLVLdZRGIUkMZ6p9x+Dev7SmRCQr3dzHLOvkKGi0105D
	V7CAfKKAsPUe73yMk2KzDJ1pY5RjYW1moXlB1YpZTZnZ0BobrNW/FuN2/a3jjQ9yao0KKpboIX8Qi
	8nsRo6WNL8KZR0O9/5bvf1SLEfoa2FtBWVrYcgtR8lgd+n7q6Ij558vccKxCT92sSJV8w9luqa6+B
	vIuUfj3L1QIRHdUmGnKOvqHLVCgWrF6PztSd2p0u3GS1ZTKOtV5xseUemUH7xfntWojpZwghKkay3
	NHBilfGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6gI0-00000009wI5-3oZd;
	Fri, 01 Nov 2024 01:17:24 +0000
Date: Fri, 1 Nov 2024 01:17:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: [WTF?] AT_GETATTR_NOSEC checks
Message-ID: <20241101011724.GN1350452@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	AFAICS, since the moment it had been introduced it got passed
to *ALL* ->getattr() calls.  Unconditionally.  So why are we checking
it in ecryptfs and overlayfs instances?

Look: all direct calls of instances are from other instances, with
query_flags passed unchanged.  There is only one call via method -
that in vfs_getattr_nosec(), but that caller explicitly adds
AT_GETATTR_NOSEC to query_flags.

So what the hell are the checks in ecryptfs and overlayfs for?
What am I missing here?  What would break if we did the following:

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 5ed1e4cf6c0b..255e60bd7dca 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1008,14 +1008,6 @@ static int ecryptfs_getattr_link(struct mnt_idmap *idmap,
 	return rc;
 }
 
-static int ecryptfs_do_getattr(const struct path *path, struct kstat *stat,
-			       u32 request_mask, unsigned int flags)
-{
-	if (flags & AT_GETATTR_NOSEC)
-		return vfs_getattr_nosec(path, stat, request_mask, flags);
-	return vfs_getattr(path, stat, request_mask, flags);
-}
-
 static int ecryptfs_getattr(struct mnt_idmap *idmap,
 			    const struct path *path, struct kstat *stat,
 			    u32 request_mask, unsigned int flags)
@@ -1024,7 +1016,7 @@ static int ecryptfs_getattr(struct mnt_idmap *idmap,
 	struct kstat lower_stat;
 	int rc;
 
-	rc = ecryptfs_do_getattr(ecryptfs_dentry_to_lower_path(dentry),
+	rc = vfs_getattr_nosec(ecryptfs_dentry_to_lower_path(dentry),
 				 &lower_stat, request_mask, flags);
 	if (!rc) {
 		fsstack_copy_attr_all(d_inode(dentry),
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 0bfe35da4b7b..dde85ec96444 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -415,9 +415,8 @@ static inline bool ovl_open_flags_need_copy_up(int flags)
 static inline int ovl_do_getattr(const struct path *path, struct kstat *stat,
 				 u32 request_mask, unsigned int flags)
 {
-	if (flags & AT_GETATTR_NOSEC)
-		return vfs_getattr_nosec(path, stat, request_mask, flags);
-	return vfs_getattr(path, stat, request_mask, flags);
+	BUG_ON(!(flags & AT_GETATTR_NOSEC));
+	return vfs_getattr_nosec(path, stat, request_mask, flags);
 }
 
 /* util.c */

