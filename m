Return-Path: <linux-fsdevel+bounces-20880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2168FA836
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 04:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE7328A993
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 02:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4216F13D2BA;
	Tue,  4 Jun 2024 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HnB1dqAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC81DDD6
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717467300; cv=none; b=n/uyEAYCeeKLTmAanH9js3tTEmqEsInRCVrSDzkdnKMuEHZ0aelOVMfJWgsyXaOUJwNoG4dSQ3r+oSoXvqHh74Yk4vBhR5tDkuXqgMFSzn+FMgxrYk8dtNqLW3Ts1ISMnPkYhQBmAsQTsNnTz0NHfWc1GFDlNaRhmaVGDR9x6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717467300; c=relaxed/simple;
	bh=Xzuo4yYX8qHltnqC/Y5Xeddm8HWRE6K0A9jWmrEMqr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEMn5DuWGjz5bo7z62csCwn8/zN4QTL5BKS3tgEyHZrbvRZVxT9D7ghCjAtVnooWWZqT8+trhpgBWXWp+elZG1ljrLhcpWG2nxMWw01PV++0fimJ0SiqCWOScM3ffdwIpWzS42zFkC6kPTOmVay/E37r7LdTh86i68gGEGn4gNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HnB1dqAs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CuvIJAs/rMor6MVjY7M7zEwy7LNwWt2bysowxjqLdnk=; b=HnB1dqAspFeokFHDpJ6iowJwqC
	f8l6XWeb3L0PyyhxQ4p8sNtVe+0Mkh2gAa1iHDkaQqUQQ9EuXc1HfJJ0Gz5K1GUQXneWD+AfaR3Uf
	0J83vLxSZR7y0ElouhccJzbSH18YS1YPYcdwS8+ICG3WZn/qKw8Yld0sRAYXBp2epfgpX/tUNc1kg
	DN1E+LakHzn07ydwLXk3jAShOxSQeCCtkw1mO4TmJL0tV5C25AaT0ypswb0grtf2GIRipjbLIqxIE
	BooGTFlv08JsqmkNYZlpmReKJ4patXBlmxEMzcGgwAuaiVJZbRoA+a9Nm/C2rRtFnLLWTXKiFxcqx
	6XNQRfrA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sEJhQ-00CoVl-0D;
	Tue, 04 Jun 2024 02:14:56 +0000
Date: Tue, 4 Jun 2024 03:14:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: amd-gfx@lists.freedesktop.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2][RFC] amdkfd CRIU fixes
Message-ID: <20240604021456.GB3053943@ZenIV>
References: <20240604021255.GO1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604021255.GO1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Instead of trying to use close_fd() on failure exits, just have
criu_get_prime_handle() store the file reference without inserting
it into descriptor table.

Then, once the callers are past the last failure exit, they can go
and either insert all those file references into the corresponding
slots of descriptor table, or drop all those file references and
free the unused descriptors.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index fdf171ad4a3c..3f129e1c0daa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -36,7 +36,6 @@
 #include <linux/mman.h>
 #include <linux/ptrace.h>
 #include <linux/dma-buf.h>
-#include <linux/fdtable.h>
 #include <linux/processor.h>
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
@@ -1857,7 +1856,8 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
 }
 
 static int criu_get_prime_handle(struct kgd_mem *mem,
-				 int flags, u32 *shared_fd)
+				 int flags, u32 *shared_fd,
+				 struct file **file)
 {
 	struct dma_buf *dmabuf;
 	int ret;
@@ -1868,13 +1868,14 @@ static int criu_get_prime_handle(struct kgd_mem *mem,
 		return ret;
 	}
 
-	ret = dma_buf_fd(dmabuf, flags);
+	ret = get_unused_fd_flags(flags);
 	if (ret < 0) {
 		pr_err("dmabuf create fd failed, ret:%d\n", ret);
 		goto out_free_dmabuf;
 	}
 
 	*shared_fd = ret;
+	*file = dmabuf->file;
 	return 0;
 
 out_free_dmabuf:
@@ -1882,6 +1883,24 @@ static int criu_get_prime_handle(struct kgd_mem *mem,
 	return ret;
 }
 
+static void commit_files(struct file **files,
+			 struct kfd_criu_bo_bucket *bo_buckets,
+			 unsigned int count,
+			 int err)
+{
+	while (count--) {
+		struct file *file = files[count];
+		if (!file)
+			continue;
+		if (err) {
+			fput(file);
+			put_unused_fd(bo_buckets[count].dmabuf_fd);
+		} else {
+			fd_install(bo_buckets[count].dmabuf_fd, file);
+		}
+	}
+}
+
 static int criu_checkpoint_bos(struct kfd_process *p,
 			       uint32_t num_bos,
 			       uint8_t __user *user_bos,
@@ -1890,6 +1909,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 {
 	struct kfd_criu_bo_bucket *bo_buckets;
 	struct kfd_criu_bo_priv_data *bo_privs;
+	struct file **files = NULL;
 	int ret = 0, pdd_index, bo_index = 0, id;
 	void *mem;
 
@@ -1903,6 +1923,12 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 		goto exit;
 	}
 
+	files = kvzalloc(num_bos * sizeof(struct file *), GFP_KERNEL);
+	if (!files) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
 	for (pdd_index = 0; pdd_index < p->n_pdds; pdd_index++) {
 		struct kfd_process_device *pdd = p->pdds[pdd_index];
 		struct amdgpu_bo *dumper_bo;
@@ -1950,7 +1976,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 				ret = criu_get_prime_handle(kgd_mem,
 						bo_bucket->alloc_flags &
 						KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
-						&bo_bucket->dmabuf_fd);
+						&bo_bucket->dmabuf_fd, &files[bo_index]);
 				if (ret)
 					goto exit;
 			} else {
@@ -2001,12 +2027,8 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 	*priv_offset += num_bos * sizeof(*bo_privs);
 
 exit:
-	while (ret && bo_index--) {
-		if (bo_buckets[bo_index].alloc_flags
-		    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
-			close_fd(bo_buckets[bo_index].dmabuf_fd);
-	}
-
+	commit_files(files, bo_buckets, bo_index, ret);
+	kvfree(files);
 	kvfree(bo_buckets);
 	kvfree(bo_privs);
 	return ret;
@@ -2358,7 +2380,8 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 
 static int criu_restore_bo(struct kfd_process *p,
 			   struct kfd_criu_bo_bucket *bo_bucket,
-			   struct kfd_criu_bo_priv_data *bo_priv)
+			   struct kfd_criu_bo_priv_data *bo_priv,
+			   struct file **file)
 {
 	struct kfd_process_device *pdd;
 	struct kgd_mem *kgd_mem;
@@ -2410,7 +2433,7 @@ static int criu_restore_bo(struct kfd_process *p,
 	if (bo_bucket->alloc_flags
 	    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
 		ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
-					    &bo_bucket->dmabuf_fd);
+					    &bo_bucket->dmabuf_fd, file);
 		if (ret)
 			return ret;
 	} else {
@@ -2427,6 +2450,7 @@ static int criu_restore_bos(struct kfd_process *p,
 {
 	struct kfd_criu_bo_bucket *bo_buckets = NULL;
 	struct kfd_criu_bo_priv_data *bo_privs = NULL;
+	struct file **files = NULL;
 	int ret = 0;
 	uint32_t i = 0;
 
@@ -2440,6 +2464,12 @@ static int criu_restore_bos(struct kfd_process *p,
 	if (!bo_buckets)
 		return -ENOMEM;
 
+	files = kvzalloc(args->num_bos * sizeof(struct file *), GFP_KERNEL);
+	if (!files) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
 	ret = copy_from_user(bo_buckets, (void __user *)args->bos,
 			     args->num_bos * sizeof(*bo_buckets));
 	if (ret) {
@@ -2465,7 +2495,7 @@ static int criu_restore_bos(struct kfd_process *p,
 
 	/* Create and map new BOs */
 	for (; i < args->num_bos; i++) {
-		ret = criu_restore_bo(p, &bo_buckets[i], &bo_privs[i]);
+		ret = criu_restore_bo(p, &bo_buckets[i], &bo_privs[i], &files[i]);
 		if (ret) {
 			pr_debug("Failed to restore BO[%d] ret%d\n", i, ret);
 			goto exit;
@@ -2480,11 +2510,8 @@ static int criu_restore_bos(struct kfd_process *p,
 		ret = -EFAULT;
 
 exit:
-	while (ret && i--) {
-		if (bo_buckets[i].alloc_flags
-		   & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT))
-			close_fd(bo_buckets[i].dmabuf_fd);
-	}
+	commit_files(files, bo_buckets, i, ret);
+	kvfree(files);
 	kvfree(bo_buckets);
 	kvfree(bo_privs);
 	return ret;

