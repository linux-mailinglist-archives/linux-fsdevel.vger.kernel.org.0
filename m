Return-Path: <linux-fsdevel+bounces-58457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE7AB2E9D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B84EA0855F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE42C1E5B64;
	Thu, 21 Aug 2025 00:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajmGmAAm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29079C2FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737801; cv=none; b=itJAYkKquofgB67Wq1f5mbecbFdvApfAiguoSR9WswF2tJEJ+/jBWmzHby6+f8obMPvvW5vJMRm1YJ4nVAgSbXYDJy9KwFuKXu4HCDocWw98zP8DHAGGH/A0YeDXP1pxNlnPHk18M2axdyVR6MKwrQvJMrTNkaXiIW4Kkdc92qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737801; c=relaxed/simple;
	bh=+WwxPALlExLLwadVg1qkfUxMsrH97LZrg/FsPgjHxoE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUxhqqN0e1Jlka/B7aBqdZ+V2GGDP3fKc8+HB4ajNVO4uw4cGGDhA4wbEpm0AfVVdZSCfuqXmxDKp5fdobVIhUNfCKla4Yfj3B/u6uafdEZQz3uSTkQoP4kbKUhuYLnnGM+UE4VDnPe759iVwht+f+QTFJGthIS+PaDqfrGnB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajmGmAAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4180C4CEE7;
	Thu, 21 Aug 2025 00:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737800;
	bh=+WwxPALlExLLwadVg1qkfUxMsrH97LZrg/FsPgjHxoE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ajmGmAAmXzP2trngqlUIY/UBzMY3wSkRbAZpdU6Aju+Q0ZlI/1+zGAxI6y1K60cfx
	 7km6GBBtpriscNM6Y1I+c3flXmT7encyMqNNQ8vrHHFYwnlHOtq2GWcEeZLffBlEuB
	 otkvZ/uxjOYBmv6VXX/pG3jwCpbO1iB/4RASlNqM2NPySYni//fz9GPLB8yyfwk3RF
	 7ZauYtwMvR82DbW5t3kh4BDwXWHaFCvGWEel4sylWeZKUERxeomrP1kSjCOfZ3Nu5a
	 qA6uaEFJtb3oMEJMM9XOHZ1nvRoobQ6/wnWJitDZSnhhpdeY+zHTxjyXNc0NxbYz0P
	 O38Eu+7lhyBwQ==
Date: Wed, 20 Aug 2025 17:56:40 -0700
Subject: [PATCH 16/23] fuse: implement fadvise for iomap files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573709460.17510.2341981166922481156.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
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
index 2572eab6100fe4..63ce9ddb96477c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1728,6 +1728,8 @@ int fuse_iomap_flush_unmap_range(struct inode *inode, loff_t pos,
 
 int fuse_dev_ioctl_iomap_support(struct file *file,
 				 struct fuse_iomap_support __user *argp);
+
+int fuse_iomap_fadvise(struct file *file, loff_t start, loff_t end, int advice);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -1754,6 +1756,7 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
 # define fuse_iomap_fallocate(...)		(-ENOSYS)
 # define fuse_iomap_flush_unmap_range(...)	(-ENOSYS)
 # define fuse_dev_ioctl_iomap_support(...)	(-EOPNOTSUPP)
+# define fuse_iomap_fadvise			NULL
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 825b7ac9158d08..6575deae7e65f6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3186,6 +3186,7 @@ static const struct file_operations fuse_file_operations = {
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
+	.fadvise	= fuse_iomap_fadvise,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index d2b918521b7395..c740fb1420bee0 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -7,6 +7,7 @@
 #include <linux/fiemap.h>
 #include <linux/pagemap.h>
 #include <linux/falloc.h>
+#include <linux/fadvise.h>
 #include "fuse_i.h"
 #include "fuse_trace.h"
 #include "iomap_priv.h"
@@ -1889,3 +1890,22 @@ int fuse_dev_ioctl_iomap_support(struct file *file,
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


