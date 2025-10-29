Return-Path: <linux-fsdevel+bounces-66023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC03C17A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D2D403B4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E8C2D641F;
	Wed, 29 Oct 2025 00:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TILt8Kvf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31D2C3768;
	Wed, 29 Oct 2025 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699026; cv=none; b=Kuctqdl79i4rsXgWlAOpg+5pIiN4qagCmyLKWVbH3MyOVYLlGx3YG7cN6R9j9hnIdwj2QbwryxuWcQsflgMPkxnO0TNRbSfC+YcEwXNiIyZjtFiv8ZtmHyC8fEQmGUX2UUZWYoyuaFDn4wHzVfbqx2czyv9XsDPK522khqfWyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699026; c=relaxed/simple;
	bh=gJFjVCpbPZAC8uTsxiPC5PFLovOKU7ij7oZXH50QYMc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkoHEs3Q9lf/suz9DmU7zI6ZebU4MYn7BwBfiGhm0pxdHwqBC7W60jLtyOvtPqf9yX8EpXk31QYttjCAlm6167iEcq/iRB9/fc8VjjifHLRvtArrjtnf4UuDiNoOGcLCNCwJ4JaDEVUqhO3tvggzCVSsoBuqaeYoYss2yBRQoBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TILt8Kvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C636C4CEE7;
	Wed, 29 Oct 2025 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699026;
	bh=gJFjVCpbPZAC8uTsxiPC5PFLovOKU7ij7oZXH50QYMc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TILt8Kvfa+VMra+WpP+xX98aLwggWTjgKC1gXXL+iNkfKvZbNv5sdjhntNUuO84GA
	 jgAm2rhy1ACxw24vkxJFj2RESYGgqae9oLZnR2RmOg+l59fTXyyWsZUjeBxIgs25fy
	 Wh5zycHh4lrb1Tn7xiVdsYzjP+McJklr+voMIM3PRMwmRG+1jGFlEbJOmGeFyQoSgA
	 Ls8xh5p5vViQ0+Le4WvYG+hCFRhYRDdyyp7tF/SwR7w/wL4L8oneFWLODFR37FULnq
	 Zyp0wrD/FJ+8bgAScTjboc8WnMZjIM9pIBrQhH7d3Ndi7eBBz5EPFTY2xyZeqFu3V9
	 UBT+rji0v4yfQ==
Date: Tue, 28 Oct 2025 17:50:25 -0700
Subject: [PATCH 21/31] fuse: implement fadvise for iomap files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810808.1424854.3451236931304006986.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If userspace asks us to perform readahead on a file, take i_rwsem so
that it can't race with hole punching or writes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h     |    3 +++
 fs/fuse/file.c       |    1 +
 fs/fuse/file_iomap.c |   20 ++++++++++++++++++++
 3 files changed, 24 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 3fdffbeabe3306..8e3e2e5591c760 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1792,6 +1792,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1817,6 +1819,7 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_iomap_fadvise			NULL
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index adcd9e3bd6a4d9..8a2daee7e58e27 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3199,6 +3199,7 @@ static const struct file_operations fuse_file_operations = {
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
+	.fadvise	= fuse_iomap_fadvise,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index ff61f7880b3332..9fd2600f599d95 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -7,6 +7,7 @@
 #include <linux/fiemap.h>
 #include <linux/pagemap.h>
 #include <linux/falloc.h>
+#include <linux/fadvise.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "iomap_i.h"
@@ -1877,3 +1878,22 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 		return -EFAULT;
 	return 0;
 }
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice)
+{
+	struct inode *inode = file_inode(file);
+	bool needlock = advice == POSIX_FADV_WILLNEED &&
+			fuse_inode_has_iomap(inode);
+	int ret;
+
+	/*
+	 * Operations creating pages in page cache need protection from hole
+	 * punching and similar ops
+	 */
+	if (needlock)
+		inode_lock_shared(inode);
+	ret = generic_fadvise(file, start, end, advice);
+	if (needlock)
+		inode_unlock_shared(inode);
+	return ret;
+}


