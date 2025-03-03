Return-Path: <linux-fsdevel+bounces-42970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DFBA4C85A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C73161642
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC42702B3;
	Mon,  3 Mar 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWgL3kcx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1FC2702D8;
	Mon,  3 Mar 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019540; cv=none; b=WLT3Z3lW71DCIrG3377/o2gMRYq6ESylfH55vxlvl3rU4BRR1Jtrtx0seaG+apBp6QSmH2K+JGLh2XrBARDm5GQGNRQU0iyeLgBZOpB7HyE4j4Lbtmn7dK8h0myihHC7QA1uDafzVxXWx5TauUbWVMHd8n7QWuBGJJOdsACmjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019540; c=relaxed/simple;
	bh=1bHc5qmoopObw4cmvTlemjLVF9uh0LB94w7N97BMYOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JjiQ66ASMp81jGg0QDAFUmEb2ybK23weAZ/kvI+cGd+OgozvYlCsrchwdZrcpbliKpF1WqhPNqc6h3VCyv9oIDgocFL6av0He54NEIW9Wz8wN8ft8oo7gpY5ZPpXGWkFXMfaRljbJcAzgmkp1sl5YpkdxS6YXsRkjuivN/33/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWgL3kcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88B5C4CEE4;
	Mon,  3 Mar 2025 16:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019540;
	bh=1bHc5qmoopObw4cmvTlemjLVF9uh0LB94w7N97BMYOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWgL3kcx/3NqKKdfz0flGQbDkcmh2tPKiXSqh5jG3SYAoekN5Sr0hDxP4ODAOsVxC
	 OO9Zdh5YCgRuzWzQvKGyq9vKYnK65yeyHAinNefsx4CWqEMTgI3w/iP0yWqni7Ypov
	 hwd1NVLlj70YGKj5YPAfOTMRGTibFLPNZGlRvJvlW70SF7lotg5VfK3CcaJQZvD+aW
	 TtZWtyyyp3hfMf0vWSx+AsPZNSswFHK69oj3lWN5PLoF/4Szg1g/YGIlszJXCapBCS
	 WA9c+UnzwKUw0Z8+aOT112ZfaMiQWN7CPx0jbLxN/SX5BcsjNtWCq2fxSvsLEEA4Ay
	 xKibkSB23fRxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Laura Promberger <laura.promberger@cern.ch>,
	Sam Lewis <samclewis@google.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 4/8] fuse: don't truncate cached, mutated symlink
Date: Mon,  3 Mar 2025 11:32:07 -0500
Message-Id: <20250303163211.3764282-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163211.3764282-1-sashal@kernel.org>
References: <20250303163211.3764282-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit b4c173dfbb6c78568578ff18f9e8822d7bd0e31b ]

Fuse allows the value of a symlink to change and this property is exploited
by some filesystems (e.g. CVMFS).

It has been observed, that sometimes after changing the symlink contents,
the value is truncated to the old size.

This is caused by fuse_getattr() racing with fuse_reverse_inval_inode().
fuse_reverse_inval_inode() updates the fuse_inode's attr_version, which
results in fuse_change_attributes() exiting before updating the cached
attributes

This is okay, as the cached attributes remain invalid and the next call to
fuse_change_attributes() will likely update the inode with the correct
values.

The reason this causes problems is that cached symlinks will be
returned through page_get_link(), which truncates the symlink to
inode->i_size.  This is correct for filesystems that don't mutate
symlinks, but in this case it causes bad behavior.

The solution is to just remove this truncation.  This can cause a
regression in a filesystem that relies on supplying a symlink larger than
the file size, but this is unlikely.  If that happens we'd need to make
this behavior conditional.

Reported-by: Laura Promberger <laura.promberger@cern.ch>
Tested-by: Sam Lewis <samclewis@google.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Link: https://lore.kernel.org/r/20250220100258.793363-1-mszeredi@redhat.com
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dir.c      |  2 +-
 fs/namei.c         | 24 +++++++++++++++++++-----
 include/linux/fs.h |  2 ++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d131f34cd3e13..4488a53a192dc 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1384,7 +1384,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 		goto out_err;
 
 	if (fc->cache_symlinks)
-		return page_get_link(dentry, inode, callback);
+		return page_get_link_raw(dentry, inode, callback);
 
 	err = -ECHILD;
 	if (!dentry)
diff --git a/fs/namei.c b/fs/namei.c
index 72521a614514b..3eb0130f0c3f7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4678,10 +4678,9 @@ const char *vfs_get_link(struct dentry *dentry, struct delayed_call *done)
 EXPORT_SYMBOL(vfs_get_link);
 
 /* get the link contents into pagecache */
-const char *page_get_link(struct dentry *dentry, struct inode *inode,
-			  struct delayed_call *callback)
+static char *__page_get_link(struct dentry *dentry, struct inode *inode,
+			     struct delayed_call *callback)
 {
-	char *kaddr;
 	struct page *page;
 	struct address_space *mapping = inode->i_mapping;
 
@@ -4700,8 +4699,23 @@ const char *page_get_link(struct dentry *dentry, struct inode *inode,
 	}
 	set_delayed_call(callback, page_put_link, page);
 	BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
-	kaddr = page_address(page);
-	nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
+	return page_address(page);
+}
+
+const char *page_get_link_raw(struct dentry *dentry, struct inode *inode,
+			      struct delayed_call *callback)
+{
+	return __page_get_link(dentry, inode, callback);
+}
+EXPORT_SYMBOL_GPL(page_get_link_raw);
+
+const char *page_get_link(struct dentry *dentry, struct inode *inode,
+					struct delayed_call *callback)
+{
+	char *kaddr = __page_get_link(dentry, inode, callback);
+
+	if (!IS_ERR(kaddr))
+		nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
 	return kaddr;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4e475ded5cf58..9463dddce6bf7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3242,6 +3242,8 @@ extern const struct file_operations generic_ro_fops;
 
 extern int readlink_copy(char __user *, int, const char *);
 extern int page_readlink(struct dentry *, char __user *, int);
+extern const char *page_get_link_raw(struct dentry *, struct inode *,
+				     struct delayed_call *);
 extern const char *page_get_link(struct dentry *, struct inode *,
 				 struct delayed_call *);
 extern void page_put_link(void *);
-- 
2.39.5


