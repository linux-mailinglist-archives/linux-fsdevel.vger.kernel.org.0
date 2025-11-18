Return-Path: <linux-fsdevel+bounces-68970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB81C6A701
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F34F5906
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0573369972;
	Tue, 18 Nov 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBVNz9vd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1C265606
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481001; cv=none; b=IvlhWSN0nRMnpSdwFk+OG772PfW18yxifAAHq4j9zdpnPuynrxDp6kK/LqBImHnf44WVD5Kux2EFnsiK7+lQ6TpdyWbtb/dvOOZcCxvk8WxV8ruakyHvK1mVCRXws1lld14X6va7NAQHwHDqogIgLQ8fO/6Yk5U7ftiedBRFEwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481001; c=relaxed/simple;
	bh=9Zkjhde6TDrYkq4xN2L7Xk9JX5l44OaWOgzAa4wbwg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stEG57AAJQIxAzwmk6pFHJBYQfOFFC0QzAHnY7Zhu6RkjUYJ9ov0cYYaii9/Kb3EiqfgMjmLtZvPdcwC1/dcb3+mMIjK8mts30/Cu1Ne2xcL6ln3YP3cHXQP0NiB0zm3fKierPu7tujFiLmxpgKkW7dDmhuai9smWqpk0tguT2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBVNz9vd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302A1C4AF12;
	Tue, 18 Nov 2025 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480999;
	bh=9Zkjhde6TDrYkq4xN2L7Xk9JX5l44OaWOgzAa4wbwg4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aBVNz9vdzR4gAMNAPMksxdprPT49wig3L4M9BOgHg2Egr52HzOifdyHcAz3nL8W/g
	 eBB9aF2GWSEDTxDUFucCktWF4+cSqesnktzarnBkGANUdMQMmKkG/Run7lOJ1mxrf+
	 kZZZEClqukMz+Q/WKKsp5Y/9P6ZfLOK01YNfjChjv8YRl/as0t13g3taHi+bpiUIdi
	 LAFNcedG0Z3PFO29+LXyZkZGhOqbZum83hF+CYBOFe4Xr8Wo5oLp0zt60KeA3iLqIQ
	 l6/f0QufmQjgI6cGpMyHWFBvwRMaNKiCM8J2rG8jh+oIKN6dsLz65mLeYrxfaWZrJz
	 D6I2tmV9crU6w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:51 +0100
Subject: [PATCH DRAFT RFC UNTESTED 11/18] fs: open_tree_attr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-11-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9Zkjhde6TDrYkq4xN2L7Xk9JX5l44OaWOgzAa4wbwg4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO2/WBR3w+PG7I4JJxxCnykmeTE4u7+PW7Uv/K6Qp
 y6XsGFVRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERWTGBkWLBr5oTdzQX/7sj2
 PnB5ON1eaGnso018H6MVJucpbcy5vZbhvxsTR95ykTUfD7lGlTILBt0QSkwUD2XKW2cYnryu7+k
 LBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 55921ab2f2d3..58a720adde3a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5016,19 +5016,17 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
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
+	FD_PREPARE(fdprep, flags, vfs_open_tree(dfd, filename, flags));
+	if (fd_prepare_failed(fdprep))
+		return fd_prepare_error(fdprep);
 
 	if (uattr) {
 		int ret;
 		struct mount_kattr kattr = {};
+		struct file *file = fd_prepare_file(fdprep);
 
 		if (flags & OPEN_TREE_CLONE)
 			kattr.kflags = MOUNT_KATTR_IDMAP_REPLACE;
@@ -5044,12 +5042,7 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 			return ret;
 	}
 
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	fd_install(fd, no_free_ptr(file));
-	return fd;
+	return fd_publish(fdprep);
 }
 
 int show_path(struct seq_file *m, struct dentry *root)

-- 
2.47.3


