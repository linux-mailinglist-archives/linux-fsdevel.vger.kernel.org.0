Return-Path: <linux-fsdevel+bounces-69404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A05C7B310
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3EC7A35455B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5299034C123;
	Fri, 21 Nov 2025 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUevobq5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD99349AF7
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748064; cv=none; b=g9WLuK16KPGVQcZ+DMQMnHZIj/B3ohfNB7hHbRj8fxIRyX+d3eJS5vGI70AKTNxbRC9PjfU3NZX18NViKRd1rt6ctvNc8UutM9KOMWnUOEpD4MN/RJJubieH6O4m/txedCPmJFUiJvhU69Ri/zIjCzWNcgP+OUmEYu0wi/f6MaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748064; c=relaxed/simple;
	bh=ohWPoBlS86SlgWLL3tAAeU5sCLsoRe2rxmFS5dzSj5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mUJEFj0YyRlruJsQFaSz+HG71UmJ8zCEjdvsdeSqNO2YI9v9IMMe/B6qwXWNAVkvNWa+IC5nzjyYLkRsPkw4nrvfZ5fyLJ0j/VfDcUu8RiIdSr3bk6MkK55PH+Q/dtp44tvWqKDhZ+JHAGgf8nZpz/21Q1+YRsKhq1Bga0jheB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUevobq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EA2C16AAE;
	Fri, 21 Nov 2025 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748064;
	bh=ohWPoBlS86SlgWLL3tAAeU5sCLsoRe2rxmFS5dzSj5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cUevobq5OHCndbCt29LyB+uc3A07o6a0Y9KKPGiQHob/0niVP4+46+RcD/6dO+Szj
	 Gd5yCU1qIRMGgLr7dJP6YIO3E0qozXFcvf0wQUCc0oBHf8Ab8gq/EdtvtVs46BUXBK
	 WaRW6ROQI0lAD0bS0zi96CgUCGvhNax1robnA9TKCLQzNraIiYfNuTfJ2WSzanZAl+
	 5vbLPeSmyBHXYTdGXw4nieIvMgd12h6Px5xKuGIR2Osf3S7RGQyJF1QILfLBhDoHN0
	 YrrqHPEm1qcOyD5bCss6L+t+jd0tXuiwe2OCO+f+9C4yk627hfc6CGamWhxcdb8JBB
	 BV0VDEMaI6Ewg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:45 +0100
Subject: [PATCH RFC v3 06/47] namespace: convert open_tree_attr() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-6-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ohWPoBlS86SlgWLL3tAAeU5sCLsoRe2rxmFS5dzSj5Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDjv8u+Qgs+f3SdS8j24AtfePOIf+GCvYIEGi3W+q
 Ef/r7vyHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5+ZqR4aEy061l5vUS0/hY
 q+TjnBOFp/koJdz+suFt6fr4aS3MhowMczRDv/k26q8I9psb+kM8zjn7Wdzk2L+L3JNPPU26c0u
 cAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cff0fdc27fda..74157dd471ee 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5030,19 +5030,19 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 		unsigned, flags, struct mount_attr __user *, uattr,
 		size_t, usize)
 {
-	struct file __free(fput) *file = NULL;
-	int fd;
+	int ret;
 
 	if (!uattr && usize)
 		return -EINVAL;
 
-	file = vfs_open_tree(dfd, filename, flags);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
+	FD_PREPARE(fdf, flags, vfs_open_tree(dfd, filename, flags));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
 
 	if (uattr) {
-		int ret;
 		struct mount_kattr kattr = {};
+		struct file *file = fd_prepare_file(fdf);
 
 		if (flags & OPEN_TREE_CLONE)
 			kattr.kflags = MOUNT_KATTR_IDMAP_REPLACE;
@@ -5058,12 +5058,7 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 			return ret;
 	}
 
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	fd_install(fd, no_free_ptr(file));
-	return fd;
+	return fd_publish(fdf);
 }
 
 int show_path(struct seq_file *m, struct dentry *root)

-- 
2.47.3


