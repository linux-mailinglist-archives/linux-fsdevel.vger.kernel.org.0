Return-Path: <linux-fsdevel+bounces-69285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4787AC76813
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A545E4E32A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF53B309EE0;
	Thu, 20 Nov 2025 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFnonrr6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518442AF1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677950; cv=none; b=a8CmagCT7pERnLq/WULpVJLd3GUhUpI+Ot8KDThCUk9qa7tnidJGaLuzfz67MBYGKl2sKLMfDy7CiVuU+HLr3qCkBBPazwGLW5rUfwfMNm+vdY2jdgvTAe4RreOoBN0xi8K+QVAm7y7bAjQQjXML7bg5thsYjA1AZ/PbOlSwSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677950; c=relaxed/simple;
	bh=1BwV2oYpEaQRZlZCp8dBFUwnYylZ/edRJQSbHFsD1Us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3HAHVEMlQ3HBIygyB+4Q83S1wFGagmBrMk3kagNjTm5OWPzRTMO0WeF6pTWh1fjcfaLZo6okFj+Wo7OMELAUqsvhagV1xv40Ta6XY8aOx74Wryb1CYmEIoiRnkq2LSrR8ASYDGRVadTMWE8BePbZFJxlVcUzTOD0f4KVyi5p8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFnonrr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32863C4CEF1;
	Thu, 20 Nov 2025 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677949;
	bh=1BwV2oYpEaQRZlZCp8dBFUwnYylZ/edRJQSbHFsD1Us=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cFnonrr6KBZW3gf5yoyFqyYzqYtDn/ETRJzCjYq3ehKs4/V12tB6XSI1FzwRPpUry
	 b3DJncG6xhif0xmgjEnEo+4PFg7/6rNYmQ/R2QqCZ+8f78/IzYGUXv9ZoM7vTopJG5
	 LtTM4IRvvt3PxYFaYAWfftmNkQAyDCBqMC9ptYrF8UWB3HwhWqr6Kdxj5us8jhs5On
	 0NbkCt38ZCli2dhIQp6DOLbGHxBI5W7VSqd0ITQN+uZoMux22Mhg6aTYj+VA4a+f9f
	 zGWw33/CAz/ZGaMlY7IBugWqAdsH09HsZTPnXYui0jS8TY+/KEjs7kBBCYYlbLh9Ok
	 u65dvwo09AcvQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:03 +0100
Subject: [PATCH RFC v2 06/48] namespace: convert open_tree_attr() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-6-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1BwV2oYpEaQRZlZCp8dBFUwnYylZ/edRJQSbHFsD1Us=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vz4W3s1j49LdHNvbGHdHp1Jb4ftGJjDd223fbGk
 24BL5H0jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInoxjIyLEvgcPh/XUTzX+np
 JfL6kRcea5V+u3rY9E/yr6ym5rMcaxgZOr43/Dc57H2HWTwv3Xamitx+hY2Gnh81a8/e9u98MrW
 GEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fbc4e4309bc8..2be135c8de05 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5028,40 +5028,34 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 		unsigned, flags, struct mount_attr __user *, uattr,
 		size_t, usize)
 {
-	struct file __free(fput) *file = NULL;
-	int fd;
-
 	if (!uattr && usize)
 		return -EINVAL;
 
-	file = vfs_open_tree(dfd, filename, flags);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
+	FD_PREPARE(fdf, flags, vfs_open_tree(dfd, filename, flags)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	if (uattr) {
-		int ret;
-		struct mount_kattr kattr = {};
+		if (uattr) {
+			int ret;
+			struct mount_kattr kattr = {};
+			struct file *file = fd_prepare_file(fdf);
 
-		if (flags & OPEN_TREE_CLONE)
-			kattr.kflags = MOUNT_KATTR_IDMAP_REPLACE;
-		if (flags & AT_RECURSIVE)
-			kattr.kflags |= MOUNT_KATTR_RECURSE;
+			if (flags & OPEN_TREE_CLONE)
+				kattr.kflags = MOUNT_KATTR_IDMAP_REPLACE;
+			if (flags & AT_RECURSIVE)
+				kattr.kflags |= MOUNT_KATTR_RECURSE;
 
-		ret = wants_mount_setattr(uattr, usize, &kattr);
-		if (ret > 0) {
-			ret = do_mount_setattr(&file->f_path, &kattr);
-			finish_mount_kattr(&kattr);
+			ret = wants_mount_setattr(uattr, usize, &kattr);
+			if (ret > 0) {
+				ret = do_mount_setattr(&file->f_path, &kattr);
+				finish_mount_kattr(&kattr);
+			}
+			if (ret)
+				return ret;
 		}
-		if (ret)
-			return ret;
-	}
 
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	fd_install(fd, no_free_ptr(file));
-	return fd;
+		return fd_publish(fdf);
+	}
 }
 
 int show_path(struct seq_file *m, struct dentry *root)

-- 
2.47.3


