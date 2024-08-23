Return-Path: <linux-fsdevel+bounces-26861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396D095C30A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 03:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F101B212B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 01:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2B118E3F;
	Fri, 23 Aug 2024 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BMwyl+Ds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC31CD3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 01:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724378245; cv=none; b=FiO6v5hA4GWu+RFO6BKLugQ2iAdFXVyyXhBq7dOtlIJmYC+dljUJKIh+i8Ri/FKyXGiBUQy3dgt5ncANqrm0qmxY4khqMaRUjaucqKoBndrIYKsk3on9PswShDR62HWCxO8/74Sl8I9SxUr7ZbLaG6QN9DHFUiUJF92tB5c8Poo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724378245; c=relaxed/simple;
	bh=6WPtFZ1u+CODXPl7SsAesgBwz2aLRIoIitRS60o7xcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnX/yMHlImaiVheEzFUOwJauzeuCN/dKKfS/WIX2jHt/um39BvSVScxLaCdHllOn7yGPJreSPmcl+CK7jIeuILXCGlqZIdeI8/4pINRibr7zpyf1cwTrrdCIgRFcK+HYJj+EY8XeOtyEDXr0HY/H2kwKe89yVoztOMHCcY88kf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BMwyl+Ds; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NvWZmHSCnungcCwYghqZUgrUpcmA/4vJcNHw6Bfmwd4=; b=BMwyl+DsqGaXnKVUD+t56KtN+D
	hebX2fiP9fRMvyGVhDJMDlUrZN1NsLCIET5GH/Fl5L2BMN7FVQCo5vnheHKShCEgsXla/v0YMlsf2
	Xp36yu+k1g4Ekeu1QQMBZzWPJmbsg3gqTTWJFign6UMVx58M1gMwUhToGD2EesLq0hB92RX1/urBf
	eMZgq8+G5LQXBkDPrHRRf/C6zOkqx0uiN/2wQiFh5hZYPP7M0BZqhoKDv4aI5/xCWg8qJCJ9perDi
	SJnXcT0O5Zs5cfm+VEyRESjLg05IUV8HMQwtb+Nmr45y1otff5LRQzyf8b57qYxBQ7q7+Mc+qSFLk
	CJPey3ew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1shJYF-00000004OSk-3ZLh;
	Fri, 23 Aug 2024 01:57:19 +0000
Date: Fri, 23 Aug 2024 02:57:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] new helper: drm_gem_prime_handle_to_dmabuf()
Message-ID: <20240823015719.GV504335@ZenIV>
References: <20240812065656.GI13701@ZenIV>
 <20240812065906.241398-1-viro@zeniv.linux.org.uk>
 <57520a28-fff2-41ae-850b-fa820d2b0cfa@suse.de>
 <20240822152022.GU504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822152022.GU504335@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Do you have any problems with the variant below?  The only changes are
in commit message and added comment for new helper...

commit 8c291056e3e88153ef4b6316d5247547da200757
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Aug 2 09:56:28 2024 -0400

    new helper: drm_gem_prime_handle_to_dmabuf()
    
    Once something had been put into descriptor table, the only thing you
    can do with it is returning descriptor to userland - you can't withdraw
    it on subsequent failure exit, etc.  You certainly can't count upon
    it staying in the same slot of descriptor table - another thread
    could've played with close(2)/dup2(2)/whatnot.
    
    drm_gem_prime_handle_to_fd() creates a dmabuf, allocates a descriptor
    and attaches dmabuf's file to it (the last two steps are done
    in dma_buf_fd()).  That's nice when all you are going to do is
    passing a descriptor to userland.  If you just need to work with the
    resulting object or have something else to be done that might fail,
    drm_gem_prime_handle_to_fd() is racy.
    
    The problem is analogous to one with anon_inode_getfd(), and solution
    is similar to what anon_inode_getfile() provides.
    
    Add drm_gem_prime_handle_to_dmabuf() - the "set dmabuf up" parts of
    drm_gem_prime_handle_to_fd() without the descriptor-related ones.
    Instead of inserting into descriptor table and returning the file
    descriptor it just returns the struct file.
    
    drm_gem_prime_handle_to_fd() becomes a wrapper for it.  Other users
    will be introduced in the next commit.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 03bd3c7bd0dc..0e3f8adf162f 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -410,22 +410,30 @@ static struct dma_buf *export_and_register_object(struct drm_device *dev,
 }
 
 /**
- * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
+ * drm_gem_prime_handle_to_dmabuf - PRIME export function for GEM drivers
  * @dev: dev to export the buffer from
  * @file_priv: drm file-private structure
  * @handle: buffer handle to export
  * @flags: flags like DRM_CLOEXEC
- * @prime_fd: pointer to storage for the fd id of the create dma-buf
  *
  * This is the PRIME export function which must be used mandatorily by GEM
  * drivers to ensure correct lifetime management of the underlying GEM object.
  * The actual exporting from GEM object to a dma-buf is done through the
  * &drm_gem_object_funcs.export callback.
+ *
+ * Unlike drm_gem_prime_handle_to_fd(), it returns the struct dma_buf it
+ * has created, without attaching it to any file descriptors.  The difference
+ * between those two is similar to that between anon_inode_getfile() and
+ * anon_inode_getfd(); insertion into descriptor table is something you
+ * can not revert if any cleanup is needed, so the descriptor-returning
+ * variants should only be used when you are past the last failure exit
+ * and the only thing left is passing the new file descriptor to userland.
+ * When all you need is the object itself or when you need to do something
+ * else that might fail, use that one instead.
  */
-int drm_gem_prime_handle_to_fd(struct drm_device *dev,
+struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
 			       struct drm_file *file_priv, uint32_t handle,
-			       uint32_t flags,
-			       int *prime_fd)
+			       uint32_t flags)
 {
 	struct drm_gem_object *obj;
 	int ret = 0;
@@ -434,14 +442,14 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
 	mutex_lock(&file_priv->prime.lock);
 	obj = drm_gem_object_lookup(file_priv, handle);
 	if (!obj)  {
-		ret = -ENOENT;
+		dmabuf = ERR_PTR(-ENOENT);
 		goto out_unlock;
 	}
 
 	dmabuf = drm_prime_lookup_buf_by_handle(&file_priv->prime, handle);
 	if (dmabuf) {
 		get_dma_buf(dmabuf);
-		goto out_have_handle;
+		goto out;
 	}
 
 	mutex_lock(&dev->object_name_lock);
@@ -463,7 +471,6 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
 		/* normally the created dma-buf takes ownership of the ref,
 		 * but if that fails then drop the ref
 		 */
-		ret = PTR_ERR(dmabuf);
 		mutex_unlock(&dev->object_name_lock);
 		goto out;
 	}
@@ -478,34 +485,51 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
 	ret = drm_prime_add_buf_handle(&file_priv->prime,
 				       dmabuf, handle);
 	mutex_unlock(&dev->object_name_lock);
-	if (ret)
-		goto fail_put_dmabuf;
-
-out_have_handle:
-	ret = dma_buf_fd(dmabuf, flags);
-	/*
-	 * We must _not_ remove the buffer from the handle cache since the newly
-	 * created dma buf is already linked in the global obj->dma_buf pointer,
-	 * and that is invariant as long as a userspace gem handle exists.
-	 * Closing the handle will clean out the cache anyway, so we don't leak.
-	 */
-	if (ret < 0) {
-		goto fail_put_dmabuf;
-	} else {
-		*prime_fd = ret;
-		ret = 0;
+	if (ret) {
+		dma_buf_put(dmabuf);
+		dmabuf = ERR_PTR(ret);
 	}
-
-	goto out;
-
-fail_put_dmabuf:
-	dma_buf_put(dmabuf);
 out:
 	drm_gem_object_put(obj);
 out_unlock:
 	mutex_unlock(&file_priv->prime.lock);
+	return dmabuf;
+}
+EXPORT_SYMBOL(drm_gem_prime_handle_to_dmabuf);
 
-	return ret;
+/**
+ * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
+ * @dev: dev to export the buffer from
+ * @file_priv: drm file-private structure
+ * @handle: buffer handle to export
+ * @flags: flags like DRM_CLOEXEC
+ * @prime_fd: pointer to storage for the fd id of the create dma-buf
+ *
+ * This is the PRIME export function which must be used mandatorily by GEM
+ * drivers to ensure correct lifetime management of the underlying GEM object.
+ * The actual exporting from GEM object to a dma-buf is done through the
+ * &drm_gem_object_funcs.export callback.
+ */
+int drm_gem_prime_handle_to_fd(struct drm_device *dev,
+			       struct drm_file *file_priv, uint32_t handle,
+			       uint32_t flags,
+			       int *prime_fd)
+{
+	struct dma_buf *dmabuf;
+	int fd = get_unused_fd_flags(flags);
+
+	if (fd < 0)
+		return fd;
+
+	dmabuf = drm_gem_prime_handle_to_dmabuf(dev, file_priv, handle, flags);
+	if (IS_ERR(dmabuf)) {
+		put_unused_fd(fd);
+		return PTR_ERR(dmabuf);
+	}
+
+	fd_install(fd, dmabuf->file);
+	*prime_fd = fd;
+	return 0;
 }
 EXPORT_SYMBOL(drm_gem_prime_handle_to_fd);
 
diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
index 2a1d01e5b56b..fa085c44d4ca 100644
--- a/include/drm/drm_prime.h
+++ b/include/drm/drm_prime.h
@@ -69,6 +69,9 @@ void drm_gem_dmabuf_release(struct dma_buf *dma_buf);
 
 int drm_gem_prime_fd_to_handle(struct drm_device *dev,
 			       struct drm_file *file_priv, int prime_fd, uint32_t *handle);
+struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
+			       struct drm_file *file_priv, uint32_t handle,
+			       uint32_t flags);
 int drm_gem_prime_handle_to_fd(struct drm_device *dev,
 			       struct drm_file *file_priv, uint32_t handle, uint32_t flags,
 			       int *prime_fd);

