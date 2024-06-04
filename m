Return-Path: <linux-fsdevel+bounces-20984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BCA8FBC64
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 21:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE3228642E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8913F45D;
	Tue,  4 Jun 2024 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Tjih+1uX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11795801
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528660; cv=none; b=lELwuCh/G3qXWi68ine01svPVvfuMhVKzxG0pYwIVltmHbDtMxrYMtWjDPVcPDH7rmnBo3YY/eWnd9DFOfDtRE1GdwhkNQvzozgLSdTuzZhfjbuDFiQhKqOBgGf4rQqjtxHJXGYfL64DYnbQDnJfybI3gFHK2HIX2ZztF1R52sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528660; c=relaxed/simple;
	bh=O1L4khWYYkg1cHB6hrcOG3/ktIEUtQl9uTRFej1rx3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvNaLcObjq9agZhaAsgy5Zq6ZlLft2U9oeJnH70biQOq43Ek9Ld6EshCe99GWDPorz3gm3EoWy7Cylon4OWPiUNYaJdt5MGsvi/2uiV5fXuEDs8SjzrLhi9SR0CtRvrxjBRgUbEPT6ItK/9lshGMdvAis2GX7hLtXCbiJ5t8RFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Tjih+1uX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8b8dtXgQZCXrmh7YRr+ZsZgt6hnJ6O2FEKhSmrRNCTg=; b=Tjih+1uXbbNitDrQV0ZGYV5vgd
	SKb54wjXm/KQfArWb48AQFppQfQML32hA1YFPnR7Z5XvbAUR8CQ+PPlRidsSvoWtx+x6+l7Zo0yj4
	VZt3ufSQhqaTwobx8CCwoyBtF7MaGKhVoCN3MN2Lb7dHFcewEsvFY+8rS8eQLazsncfmXlxnV9VIV
	Ks3bCsza/EzHM9G5lmVjfbd0yr8D3TAbYmB5xoJwvJ0Gz8iyuA76wgRWmyqH8ytCYqeV950D2xQUa
	hN7L8nmLSt3pZYkrWbmjfVG5BoqiQ1WIteKu9tYaGlR/UbpuYpaKVZtHV0qLNgUWdJHanZrq98KiZ
	wUl7lHCg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sEZf4-00E1ZT-0C;
	Tue, 04 Jun 2024 19:17:34 +0000
Date: Tue, 4 Jun 2024 20:17:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2][RFC] amdgpu: fix a race in kfd_mem_export_dmabuf()
Message-ID: <20240604191734.GS1629371@ZenIV>
References: <20240604021255.GO1629371@ZenIV>
 <20240604021354.GA3053943@ZenIV>
 <611b4f6e-e91b-4759-a170-fb43819000ce@amd.com>
 <20240604191004.GR1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604191004.GR1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[now without a descriptor leak; it really needs testing, though]

Using drm_gem_prime_handle_to_fd() to set dmabuf up and insert it into
descriptor table, only to have it looked up by file descriptor and
remove it from descriptor table is not just too convoluted - it's
racy; another thread might have modified the descriptor table while
we'd been going through that song and dance.

It's not hard to fix - turn drm_gem_prime_handle_to_fd()
into a wrapper for a new helper that would simply return the
dmabuf, without messing with descriptor table.

Then kfd_mem_export_dmabuf() would simply use that new helper
and leave the descriptor table alone.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 8975cf41a91a..793780bb819c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -25,7 +25,6 @@
 #include <linux/pagemap.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
-#include <linux/fdtable.h>
 #include <drm/ttm/ttm_tt.h>
 
 #include <drm/drm_exec.h>
@@ -812,18 +811,13 @@ static int kfd_mem_export_dmabuf(struct kgd_mem *mem)
 	if (!mem->dmabuf) {
 		struct amdgpu_device *bo_adev;
 		struct dma_buf *dmabuf;
-		int r, fd;
 
 		bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
-		r = drm_gem_prime_handle_to_fd(&bo_adev->ddev, bo_adev->kfd.client.file,
+		dmabuf = drm_gem_prime_handle_to_dmabuf(&bo_adev->ddev, bo_adev->kfd.client.file,
 					       mem->gem_handle,
 			mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
-					       DRM_RDWR : 0, &fd);
-		if (r)
-			return r;
-		dmabuf = dma_buf_get(fd);
-		close_fd(fd);
-		if (WARN_ON_ONCE(IS_ERR(dmabuf)))
+					       DRM_RDWR : 0);
+		if (IS_ERR(dmabuf))
 			return PTR_ERR(dmabuf);
 		mem->dmabuf = dmabuf;
 	}
diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 03bd3c7bd0dc..467c7a278ad3 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -409,23 +409,9 @@ static struct dma_buf *export_and_register_object(struct drm_device *dev,
 	return dmabuf;
 }
 
-/**
- * drm_gem_prime_handle_to_fd - PRIME export function for GEM drivers
- * @dev: dev to export the buffer from
- * @file_priv: drm file-private structure
- * @handle: buffer handle to export
- * @flags: flags like DRM_CLOEXEC
- * @prime_fd: pointer to storage for the fd id of the create dma-buf
- *
- * This is the PRIME export function which must be used mandatorily by GEM
- * drivers to ensure correct lifetime management of the underlying GEM object.
- * The actual exporting from GEM object to a dma-buf is done through the
- * &drm_gem_object_funcs.export callback.
- */
-int drm_gem_prime_handle_to_fd(struct drm_device *dev,
+struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
 			       struct drm_file *file_priv, uint32_t handle,
-			       uint32_t flags,
-			       int *prime_fd)
+			       uint32_t flags)
 {
 	struct drm_gem_object *obj;
 	int ret = 0;
@@ -434,14 +420,14 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
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
@@ -463,7 +449,6 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
 		/* normally the created dma-buf takes ownership of the ref,
 		 * but if that fails then drop the ref
 		 */
-		ret = PTR_ERR(dmabuf);
 		mutex_unlock(&dev->object_name_lock);
 		goto out;
 	}
@@ -478,34 +463,51 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
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

