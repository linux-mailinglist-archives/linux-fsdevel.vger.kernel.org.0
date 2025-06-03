Return-Path: <linux-fsdevel+bounces-50536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2329EACD027
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B691896017
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D5221DAE;
	Tue,  3 Jun 2025 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VSaPvMAS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB926ACC
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992597; cv=none; b=Bg5R2buL7rLZmOKvgbWZk8wnRryOMEyzJ2YWF3WbjFUSTJyzn9A0fWAdnzSAPigwgjr6KdQPa4FGexGM5NdwbieUxaUPsxAfYKt3rmA/fNqOQlG43oHBUHoqPbJN9qRht0ur0ZSzbMpQmV2l9Sn2jRBeWdCIg7jlcfp85n9JmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992597; c=relaxed/simple;
	bh=ldRLPdF0cfrmyavaDeWTBchWPE0QI/IQDRHggdLXbOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNwOIPsm/3VGvkxU8mkdO4+wCXkvjWOHA2Uw9tKuyge0jf/Hzy8TFuYGn5P50S9awzuZEdTP92iJOyDOtvrpjifgzWeg1j+5luLqt+oJCovhwO1KzMARTaSs1q1QmHxvhFvfU4U7Qi4/0gE7L6bX2dldnUd1vNIfIN+sdzgVs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VSaPvMAS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FoNuxN1aQzajEVQQ+MZ0kd41hAo1zsBZQhcbR8Jzj8w=; b=VSaPvMASs/eAr0vaxhQ8Fznm9A
	ksmN0NHHG1IikZ1b1LE3Kui6tTpY1XLJrFGz9iRvpuKl0RdT1LpjA4Jt4Mh39m7vDlbkK8QkJ3i1O
	TrWFvD3q43T8SucfVeGfRr5e+q41HHok7wxpgGBma0EitGi5P5lFq+xvUjKJ39eYaIbF5zV80ejw9
	rzL70tkl4fUFx5gGP55Y9Giw9D4xo2uyK1vrPCLzr97Z3uoDOiNe3JmoIey30MvVD1TQZYFwliruW
	qR6eh9EKHQDtWNY3QXMRM8qGJ1DDD2dF6WeelXMRCNITq9OXRbyKztl74gQteZwp6/zQux3ehT7N/
	6OW7ywQg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMarx-00000000cQ2-00iK;
	Tue, 03 Jun 2025 23:16:33 +0000
Date: Wed, 4 Jun 2025 00:16:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 1/5] fs/fhandle.c: fix a race in call of has_locked_children()
Message-ID: <20250603231632.GA145532@ZenIV>
References: <20250603231500.GC299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603231500.GC299672@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

may_decode_fh() is calling has_locked_children() while holding no locks.
That's an oopsable race...

The rest of the callers are safe since they are holding namespace_sem and
are guaranteed a positive refcount on the mount in question.

Rename the current has_locked_children() to __has_locked_children(), make
it static and switch the fs/namespace.c users to it.

Make has_locked_children() a wrapper for __has_locked_children(), calling
the latter under read_seqlock_excl(&mount_lock).

Fixes: 620c266f3949 ("fhandle: relax open_by_handle_at() permission checks")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7c0ebc4f4ef2..a33553bc12d0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2425,7 +2425,7 @@ void drop_collected_mounts(struct vfsmount *mnt)
 	namespace_unlock();
 }
 
-bool has_locked_children(struct mount *mnt, struct dentry *dentry)
+static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
 	struct mount *child;
 
@@ -2439,6 +2439,16 @@ bool has_locked_children(struct mount *mnt, struct dentry *dentry)
 	return false;
 }
 
+bool has_locked_children(struct mount *mnt, struct dentry *dentry)
+{
+	bool res;
+
+	read_seqlock_excl(&mount_lock);
+	res = __has_locked_children(mnt, dentry);
+	read_sequnlock_excl(&mount_lock);
+	return res;
+}
+
 /*
  * Check that there aren't references to earlier/same mount namespaces in the
  * specified subtree.  Such references can act as pins for mount namespaces
@@ -2499,7 +2509,7 @@ struct vfsmount *clone_private_mount(const struct path *path)
 			return ERR_PTR(-EINVAL);
 	}
 
-	if (has_locked_children(old_mnt, path->dentry))
+	if (__has_locked_children(old_mnt, path->dentry))
 		return ERR_PTR(-EINVAL);
 
 	new_mnt = clone_mnt(old_mnt, path->dentry, CL_PRIVATE);
@@ -3036,7 +3046,7 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 	if (!may_copy_tree(old_path))
 		return mnt;
 
-	if (!recurse && has_locked_children(old, old_path->dentry))
+	if (!recurse && __has_locked_children(old, old_path->dentry))
 		return mnt;
 
 	if (recurse)
@@ -3429,7 +3439,7 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 		goto out;
 
 	/* From mount should not have locked children in place of To's root */
-	if (has_locked_children(from, to->mnt.mnt_root))
+	if (__has_locked_children(from, to->mnt.mnt_root))
 		goto out;
 
 	/* Setting sharing groups is only allowed on private mounts */
-- 
2.39.5


