Return-Path: <linux-fsdevel+bounces-11921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9698592A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 21:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975811F22D5D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 20:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1AF7F7DA;
	Sat, 17 Feb 2024 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSPSc3YT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A67E78A;
	Sat, 17 Feb 2024 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201437; cv=none; b=gnhCauvvrJ9cE55qf5+gsvLnTpFvsIkbY1lR42+tnpMRpaBanjv3fo0qg1LS2BDFzIuR0vdEDOZUVb2g0Lioze2I3c+TC6hEiAhrEZEmtjf+Qa1m7Ffa5AGZ94ixfs2DgMpv1HPbaLS5awutri/5EJ50oMUGlaeh7JatoUKRwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201437; c=relaxed/simple;
	bh=Wl5YZpZIwNdyP0j7hPhqHmMF9/qk/KQwvYrvu9hugUU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjnHgVE/RGufgZl+M9v1h4QQQrTCQCnooUTOqQoRHC9BvxiJLj09GwOUNij9CalmVIvL+uXWWZn4/8iMnCYy+WLY/f7jFnznT18uC+moXRtCwE9cYzan+gWFi06tS9G6Oq9S7Nx10UOtKlvbbf+bQ//WWwh6lQKmQxAVOybhLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSPSc3YT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9828DC433C7;
	Sat, 17 Feb 2024 20:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708201436;
	bh=Wl5YZpZIwNdyP0j7hPhqHmMF9/qk/KQwvYrvu9hugUU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hSPSc3YTTnETZH7tpcODEx1noXHcGxWv4jbcdGMmkKFsEWnfprlfhBAMvQrRX//ay
	 cgIsqNc565w8r+aJyx0o2wv3/D0ExShXnYuhchx1OdQ6esqSVlx4XCBIwsz0wR4Tc+
	 SLiXgISMOVYmI8HKJURtotqLYVMwdItc1YCaZMJaTNJ9wiCtKOi5mW2hiO9NAnrsL4
	 eCstP8GCNdyd2EaFgD7YXM37wiYuqB7EwqVdbHXQCbINlch7KtIHb/1vlLp4w3hwYH
	 R9vt1ltVSLWnz79sr+OcRO1RCM8jv6mrvIq9talI2/YedhJ5Oy60DgXlVhj+DFJHq/
	 p8Xc60B+KN9Pw==
Subject: [PATCH v2 3/6] libfs: Add simple_offset_empty()
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Sat, 17 Feb 2024 15:23:54 -0500
Message-ID: 
 <170820143463.6328.7872919188371286951.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: 
 <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
References: 
 <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

For simple filesystems that use directory offset mapping, rely
strictly on the directory offset map to tell when a directory has
no children.

After this patch is applied, the emptiness test holds only the RCU
read lock when the directory being tested has no children.

In addition, this adds another layer of confirmation that
simple_offset_add/remove() are working as expected.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c         |   32 ++++++++++++++++++++++++++++++++
 include/linux/fs.h |    1 +
 mm/shmem.c         |    4 ++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index f0045db739df..f7f92a49a418 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -313,6 +313,38 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
 	offset_set(dentry, 0);
 }
 
+/**
+ * simple_offset_empty - Check if a dentry can be unlinked
+ * @dentry: dentry to be tested
+ *
+ * Returns 0 if @dentry is a non-empty directory; otherwise returns 1.
+ */
+int simple_offset_empty(struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	struct offset_ctx *octx;
+	struct dentry *child;
+	unsigned long index;
+	int ret = 1;
+
+	if (!inode || !S_ISDIR(inode->i_mode))
+		return ret;
+
+	index = DIR_OFFSET_MIN;
+	octx = inode->i_op->get_offset_ctx(inode);
+	xa_for_each(&octx->xa, index, child) {
+		spin_lock(&child->d_lock);
+		if (simple_positive(child)) {
+			spin_unlock(&child->d_lock);
+			ret = 0;
+			break;
+		}
+		spin_unlock(&child->d_lock);
+	}
+
+	return ret;
+}
+
 /**
  * simple_offset_rename_exchange - exchange rename with directory offsets
  * @old_dir: parent of dentry being moved
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..03d141809a2c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3267,6 +3267,7 @@ struct offset_ctx {
 void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
+int simple_offset_empty(struct dentry *dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
 				  struct dentry *old_dentry,
 				  struct inode *new_dir,
diff --git a/mm/shmem.c b/mm/shmem.c
index d7c84ff62186..6fed524343cb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3374,7 +3374,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 
 static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (!simple_empty(dentry))
+	if (!simple_offset_empty(dentry))
 		return -ENOTEMPTY;
 
 	drop_nlink(d_inode(dentry));
@@ -3431,7 +3431,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 		return simple_offset_rename_exchange(old_dir, old_dentry,
 						     new_dir, new_dentry);
 
-	if (!simple_empty(new_dentry))
+	if (!simple_offset_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {



