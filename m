Return-Path: <linux-fsdevel+bounces-52195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A36AE0239
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A99F4A08C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121F221DB0;
	Thu, 19 Jun 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXHujRx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A835963;
	Thu, 19 Jun 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327287; cv=none; b=QENeFgCHEcnVz/JroAXgImvWwRYtWwfk5iqrwzkmIOWZBeTgKPRMYSPj/K7BOfhr2uIk8hcwK5DVdZPK1a+dXzwfG4fTxxYc2piodqBbsqgToBAAq+DMmVwTQsr9VC+taiUq+/9MJhYWmqY6XPy3avn1qVNKohL59PDdupoiDiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327287; c=relaxed/simple;
	bh=iH2r4/nOdisJ4ji3r1eyCc2glfT0fNCXVE6J/1rZ5yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OstHINpAaXz//PkcyelxbJ2xeXLpuga13oJfcGKC5eLgF8ZbfRkAG8BLCGf6jge9T6qrPnDVLHeiebVthnfEUbDTGy/zmibnS2EqLk7S/TJml5M1zziQWV2sstVZqFYNWPUqbWBmRu1+1FlHYZ7txMy+bzYunMPQ09Efc0AWDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXHujRx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55811C4CEEA;
	Thu, 19 Jun 2025 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750327286;
	bh=iH2r4/nOdisJ4ji3r1eyCc2glfT0fNCXVE6J/1rZ5yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXHujRx2ZkIBQtDu3BCwhIEOlxLAAhZslA2k8hvv/w+RV1qJk+INWsQWw7hjGmorg
	 ZKXxRWlfbSSUJkgxKd3Z4h3Eyy8dmr53NXMxneA8z0sxE7/0PHAH2FiShO1lPmMYHy
	 S6qpJul6haD3AGvM9bFOxuQKeKC+qDIyZ0VmrUuQ6NzNnea5UQPbAiSDenDCEL/b1L
	 Swb7ukZt0FWOJuQYKjwCtnNygvmB59Ll6oM+55xVCRnT/H8Gg0S2IpQDUXEs6cm0RB
	 VUSC5YBYxIplToSY7nX+ponT5m0bRT0I1suIaehY1eUxSQSv79Y2NsktyXBrb0UYJI
	 s7COAQxIknpjQ==
Date: Thu, 19 Jun 2025 12:01:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, gregkh@linuxfoundation.org, tj@kernel.org, 
	daan.j.demeyer@gmail.com
Subject: Re: [PATCH bpf-next 1/4] kernfs: Add __kernfs_xattr_get for RCU
 protected access
Message-ID: <20250619-kaulquappen-absagen-27377e154bc0@brauner>
References: <20250618233739.189106-1-song@kernel.org>
 <20250618233739.189106-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="m55nvctvuaufcxua"
Content-Disposition: inline
In-Reply-To: <20250618233739.189106-2-song@kernel.org>


--m55nvctvuaufcxua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Jun 18, 2025 at 04:37:36PM -0700, Song Liu wrote:
> Existing kernfs_xattr_get() locks iattr_mutex, so it cannot be used in
> RCU critical sections. Introduce __kernfs_xattr_get(), which reads xattr
> under RCU read lock. This can be used by BPF programs to access cgroupfs
> xattrs.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/kernfs/inode.c      | 14 ++++++++++++++
>  include/linux/kernfs.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index b83054da68b3..0ca231d2012c 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -302,6 +302,20 @@ int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
>  	return simple_xattr_get(&attrs->xattrs, name, value, size);
>  }
>  
> +int __kernfs_xattr_get(struct kernfs_node *kn, const char *name,
> +		       void *value, size_t size)
> +{
> +	struct kernfs_iattrs *attrs;
> +
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +
> +	attrs = rcu_dereference(kn->iattr);
> +	if (!attrs)
> +		return -ENODATA;

Hm, that looks a bit silly. Which isn't your fault. I'm looking at the
kernfs code that does the xattr allocations and I think that's the
origin of the silliness. It uses a single global mutex for all kernfs
users thus serializing all allocations for kernfs->iattr. That seems
crazy but maybe I'm missing a good reason.

I'm appending a patch to remove that mutex. @Greg, @Tejun, can you take
a look whether that makes sense to you. Then I can take that patch and
you can build yours on top of the series and I'll pick it all up in one
go.

You should then just use READ_ONCE(kn->iattr) or the
kernfs_iattrs_noalloc(kn) helper in your kfunc.

--m55nvctvuaufcxua
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-kernfs-remove-iattr_mutex.patch"

From bdc53435a1cd5c456dc28d8239eff0e7fa4e8dda Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 19 Jun 2025 11:50:26 +0200
Subject: [PATCH] kernfs: remove iattr_mutex

All allocations of struct kernfs_iattrs are serialized through a global
mutex. Simply do a racy allocation and let the first one win. I bet most
callers are under inode->i_rwsem anyway and it wouldn't be needed but
let's not require that.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Note, that this uses kfree() for the kmem cache allocation.
That's been possible for a while now but not everyone knows about it
yet so I'm pointing it out explicitly.
---
 fs/kernfs/inode.c | 74 +++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index b83054da68b3..f4b73b9482b7 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -24,45 +24,46 @@ static const struct inode_operations kernfs_iops = {
 	.listxattr	= kernfs_iop_listxattr,
 };
 
-static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
+static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, bool alloc)
 {
-	static DEFINE_MUTEX(iattr_mutex);
-	struct kernfs_iattrs *ret;
+	struct kernfs_iattrs *ret __free(kfree) = NULL;
+	struct kernfs_iattrs *attr;
 
-	mutex_lock(&iattr_mutex);
+	attr = READ_ONCE(kn->iattr);
+	if (attr || !alloc)
+		return attr;
 
-	if (kn->iattr || !alloc)
-		goto out_unlock;
-
-	kn->iattr = kmem_cache_zalloc(kernfs_iattrs_cache, GFP_KERNEL);
-	if (!kn->iattr)
-		goto out_unlock;
+	ret = kmem_cache_zalloc(kernfs_iattrs_cache, GFP_KERNEL);
+	if (!ret)
+		return NULL;
 
 	/* assign default attributes */
-	kn->iattr->ia_uid = GLOBAL_ROOT_UID;
-	kn->iattr->ia_gid = GLOBAL_ROOT_GID;
-
-	ktime_get_real_ts64(&kn->iattr->ia_atime);
-	kn->iattr->ia_mtime = kn->iattr->ia_atime;
-	kn->iattr->ia_ctime = kn->iattr->ia_atime;
-
-	simple_xattrs_init(&kn->iattr->xattrs);
-	atomic_set(&kn->iattr->nr_user_xattrs, 0);
-	atomic_set(&kn->iattr->user_xattr_size, 0);
-out_unlock:
-	ret = kn->iattr;
-	mutex_unlock(&iattr_mutex);
-	return ret;
+	ret->ia_uid = GLOBAL_ROOT_UID;
+	ret->ia_gid = GLOBAL_ROOT_GID;
+
+	ktime_get_real_ts64(&ret->ia_atime);
+	ret->ia_mtime = ret->ia_atime;
+	ret->ia_ctime = ret->ia_atime;
+
+	simple_xattrs_init(&ret->xattrs);
+	atomic_set(&ret->nr_user_xattrs, 0);
+	atomic_set(&ret->user_xattr_size, 0);
+
+	/* If someone raced us, recognize it. */
+	if (!try_cmpxchg(&kn->iattr, &attr, ret))
+		return READ_ONCE(kn->iattr);
+
+	return no_free_ptr(ret);
 }
 
 static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 {
-	return __kernfs_iattrs(kn, 1);
+	return __kernfs_iattrs(kn, true);
 }
 
 static struct kernfs_iattrs *kernfs_iattrs_noalloc(struct kernfs_node *kn)
 {
-	return __kernfs_iattrs(kn, 0);
+	return __kernfs_iattrs(kn, false);
 }
 
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
@@ -141,9 +142,9 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
 	struct kernfs_node *kn = kernfs_dentry_node(dentry);
 	struct kernfs_iattrs *attrs;
 
-	attrs = kernfs_iattrs(kn);
+	attrs = kernfs_iattrs_noalloc(kn);
 	if (!attrs)
-		return -ENOMEM;
+		return -ENODATA;
 
 	return simple_xattr_list(d_inode(dentry), &attrs->xattrs, buf, size);
 }
@@ -166,9 +167,10 @@ static inline void set_inode_attr(struct inode *inode,
 
 static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 {
-	struct kernfs_iattrs *attrs = kn->iattr;
+	struct kernfs_iattrs *attrs;
 
 	inode->i_mode = kn->mode;
+	attrs = kernfs_iattrs_noalloc(kn);
 	if (attrs)
 		/*
 		 * kernfs_node has non-default attributes get them from
@@ -306,7 +308,9 @@ int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 		     const void *value, size_t size, int flags)
 {
 	struct simple_xattr *old_xattr;
-	struct kernfs_iattrs *attrs = kernfs_iattrs(kn);
+	struct kernfs_iattrs *attrs;
+
+	attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
@@ -345,8 +349,9 @@ static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
 				     struct simple_xattrs *xattrs,
 				     const void *value, size_t size, int flags)
 {
-	atomic_t *sz = &kn->iattr->user_xattr_size;
-	atomic_t *nr = &kn->iattr->nr_user_xattrs;
+	struct kernfs_iattrs *attr = kernfs_iattrs_noalloc(kn);
+	atomic_t *sz = &attr->user_xattr_size;
+	atomic_t *nr = &attr->nr_user_xattrs;
 	struct simple_xattr *old_xattr;
 	int ret;
 
@@ -384,8 +389,9 @@ static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
 				    struct simple_xattrs *xattrs,
 				    const void *value, size_t size, int flags)
 {
-	atomic_t *sz = &kn->iattr->user_xattr_size;
-	atomic_t *nr = &kn->iattr->nr_user_xattrs;
+	struct kernfs_iattrs *attr = kernfs_iattrs(kn);
+	atomic_t *sz = &attr->user_xattr_size;
+	atomic_t *nr = &attr->nr_user_xattrs;
 	struct simple_xattr *old_xattr;
 
 	old_xattr = simple_xattr_set(xattrs, full_name, value, size, flags);
-- 
2.47.2


--m55nvctvuaufcxua--

