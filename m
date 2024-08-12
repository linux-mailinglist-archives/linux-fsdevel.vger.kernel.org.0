Return-Path: <linux-fsdevel+bounces-25649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA7B94E743
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADDFB20B43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E74153BF6;
	Mon, 12 Aug 2024 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PoJ1xYlA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379B14A4E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445949; cv=none; b=FdeOEura607Z1jGYTRifnvgY5WJklsgXwA1DL9Uq7xuLdYjVlk4aVIez9Of4paLgGaq5vMGWpvdqm3uhRcnNgVG/f4H1XBbVrde6O7VggOypIbeUDuHaRNjglXXStY4ak/7+KQhiWuz3xkPcNcgY2UtW+1ZM+lC3E9CprW552Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445949; c=relaxed/simple;
	bh=shTFdJc8ddJpVQUuLXsdUz9m/1DeJhTLjuBk74VGxb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2YvRGlFKtj/MQkSLncSYWafqkSJFYu58nhb1h9R9ft0jNH+WorGSrUaf6ZAYSBwDpoZdLtQ0S2UfgzxGhpvJtzJ1mUoZfDptl0Hlol3/bL2OYQKzN7rXzdReHi+7WC7IOAJJwZui5pz8e0fgD/5DscmBj089KvPdf9pyN5u75k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PoJ1xYlA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=llKvYmTSd8/Y8jELiMLmZIKz31PpLqEbxa7i6FjYD9c=; b=PoJ1xYlAcwz+VZK902tHdzv5tE
	dNic6B8B2oMcdZm8uddCSgleQrsMfgbwdSscvg3a3cUzJGlelW5m8B+vzehollvdPSoICxFh2xDG4
	7JX8aCyjmXxyNx0ztNV9Yz6OgtArI+lGJcnZ0gyVA9BrCdLjQyfRzAEgEHbBinzOfokwPaZpUcdLE
	z4aosl04kHhJVMszLsx21srOxorfrAlEl3uAPnQhIM9xQWnTbOdTkp7JqpX3Vku1NSO2rW3tPbDrM
	vIH4e4hZUJk85ckNSiB2pJDCybBmwHANjEbBD8Yg+NWKAglBRC/TVIKEGi0PgSTmGxwqPll6GUgG/
	uFeMMHoA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdP1G-000000010nd-0X3n;
	Mon, 12 Aug 2024 06:59:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] new helper: drm_gem_prime_handle_to_dmabuf()
Date: Mon, 12 Aug 2024 07:59:03 +0100
Message-ID: <20240812065906.241398-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812065656.GI13701@ZenIV>
References: <20240812065656.GI13701@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Once something had been put into descriptor table, the only thing you
can do with it is returning descriptor to userland - you can't withdraw
it on subsequent failure exit, etc.  You certainly can't count upon
it staying in the same slot of descriptor table - another thread
could've played with close(2)/dup2(2)/whatnot.

Add drm_gem_prime_handle_to_dmabuf() - the "set dmabuf up" parts of
drm_gem_prime_handle_to_fd() without the descriptor-related ones.
Instead of inserting into descriptor table and returning the file
descriptor it just returns the struct file.

drm_gem_prime_handle_to_fd() becomes a wrapper for it.  Other users
will be introduced in the next commit.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/drm_prime.c | 84 +++++++++++++++++++------------------
 include/drm/drm_prime.h     |  3 ++
 2 files changed, 46 insertions(+), 41 deletions(-)

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
-- 
2.39.2


