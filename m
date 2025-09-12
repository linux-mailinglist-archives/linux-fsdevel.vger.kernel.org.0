Return-Path: <linux-fsdevel+bounces-61126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADF9B556B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8441D624FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAD23375A9;
	Fri, 12 Sep 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CO1kUtz6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A131E10D
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703560; cv=none; b=iPPhzCI9qJJhUXAN5fZvLHdTgguHe+AFzlbTFQco3HJYW1hcVuB2EeV55VH03uXcELtU3UtCt0TWEFNw6qZk10TPVoINzunGU971ELBQ9dTBLYyvQNMfYU+K9rXXrVsoGuA7p+4q7Nd+np9RWf5HwM3cG7+8haOj1lElWPjqebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703560; c=relaxed/simple;
	bh=3VQJ/Z8kibwbDGvufdgrIHEPFCPM0OUPFBluiDu1ZQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRZPeL94qpJ+2trzcfyoF+v54SeLvzTkiNoVQA41TyigM8rpVdGQFVJVKHRhCYGQZsRF7pHue2yewZLEDBSFeF4UI4A7CHTEJrFVhI+GqtgVAwR99xHXmvHgYy4TbHSthJ+eSD9CIVrcllw125TG2LPH9CCjrJKC5iji8MkzNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CO1kUtz6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=f9Dj5QT1wGFCC6flPL/Nf2xJHMbcc3H4v9oOHZcd2Jw=; b=CO1kUtz6MI08u97dopoiEwZ4Nq
	BgZMufZpTgZkDcIGHP4WySwoQeEgoTSRjcsxWL3ye6H8Ex3R5hdAi/eme5Fa3Gm5vd4TOihuiMUKe
	DnVimZKKAeBYbhrQ8HqO/NQRa3W2AsHl4DZ7HDiJgMwggEPdv6pYmLcMjqY6ELS1jsBlKicvah0nC
	9Cl8Li97bPNYrFZBIPxJoQgmqMErMuMnj3UQVWsx2y4FUalIRja+Tq3hM0Apt9IngRnleyTUD0ikG
	sKJC/uEA80qbyeuY0Ia+jsj+zYOCl+dxHfvx6RUkuDQtCu0uZfX5iaztl1V0P/ljwrMz6dExxHmAT
	p0ju72DA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux8zM-00000001g5e-3CCm;
	Fri, 12 Sep 2025 18:59:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu
Subject: [PATCH 2/9] 9p: simplify v9fs_vfs_atomic_open()
Date: Fri, 12 Sep 2025 19:59:09 +0100
Message-ID: <20250912185916.400113-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250912185916.400113-1-viro@zeniv.linux.org.uk>
References: <20250912185530.GZ39973@ZenIV>
 <20250912185916.400113-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

if v9fs_vfs_lookup() returns a preexisting alias, it is guaranteed to be
positive.  IOW, in that case we will immediately return finish_no_open(),
leaving only the case res == NULL past that point.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/9p/vfs_inode.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 399d455d50d6..d0c77ec31b1d 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -768,22 +768,18 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct v9fs_inode __maybe_unused *v9inode;
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
-	struct dentry *res = NULL;
 	struct inode *inode;
 	int p9_omode;
 
 	if (d_in_lookup(dentry)) {
-		res = v9fs_vfs_lookup(dir, dentry, 0);
-		if (IS_ERR(res))
-			return PTR_ERR(res);
-
-		if (res)
-			dentry = res;
+		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
+		if (res || d_really_is_positive(dentry))
+			return finish_no_open(file, res);
 	}
 
 	/* Only creates */
-	if (!(flags & O_CREAT) || d_really_is_positive(dentry))
-		return finish_no_open(file, res);
+	if (!(flags & O_CREAT))
+		return finish_no_open(file, NULL);
 
 	v9ses = v9fs_inode2v9ses(dir);
 	perm = unixmode2p9mode(v9ses, mode);
@@ -795,17 +791,17 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			"write-only file with writeback enabled, creating w/ O_RDWR\n");
 	}
 	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, p9_omode);
-	if (IS_ERR(fid)) {
-		err = PTR_ERR(fid);
-		goto error;
-	}
+	if (IS_ERR(fid))
+		return PTR_ERR(fid);
 
 	v9fs_invalidate_inode_attr(dir);
 	inode = d_inode(dentry);
 	v9inode = V9FS_I(inode);
 	err = finish_open(file, dentry, generic_file_open);
-	if (err)
-		goto error;
+	if (unlikely(err)) {
+		p9_fid_put(fid);
+		return err;
+	}
 
 	file->private_data = fid;
 #ifdef CONFIG_9P_FSCACHE
@@ -818,13 +814,7 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	v9fs_open_fid_add(inode, &fid);
 
 	file->f_mode |= FMODE_CREATED;
-out:
-	dput(res);
-	return err;
-
-error:
-	p9_fid_put(fid);
-	goto out;
+	return 0;
 }
 
 /**
-- 
2.47.2


