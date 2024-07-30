Return-Path: <linux-fsdevel+bounces-24571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B602294078B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C32E283E30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D06B16C448;
	Tue, 30 Jul 2024 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="friXM2pp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA1316B75F;
	Tue, 30 Jul 2024 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316525; cv=none; b=mzfFpEEqN+XXJvFLWyqJkbSGW5uNGx/O2nJG+uXfwGHc0ntVOoSwYfID8VpXBE0Z/qX2bO+5o66g/G1MGY5B0/hAWS3o740N0o+YZF2zdME3Pc+U9nFp5gDwxwVLuJPxYT1wupp3IFgybiaNmFg8d4Y9W8XPnIL3x9IMWh4dI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316525; c=relaxed/simple;
	bh=KpyDFQBqfRWXWJUhf9px/ftS5trX/XsLPbwslLox5Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fI7GXiEPvIo4d5AvrW8XBlShlueOH6JuQRs+UqFu5k89VXSNQNlOe6uthc/WAshwUa2TlAPzrbFrE+CH9q9k8WlgXxa4zopJ49+77hvx9+3ihQx4N5+12/k3jx+6FLjxpLoh8O4iK3vEwfod4FLrCsBqnnIe9ZzyLPkmLfwghiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=friXM2pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5F8C4AF10;
	Tue, 30 Jul 2024 05:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316523;
	bh=KpyDFQBqfRWXWJUhf9px/ftS5trX/XsLPbwslLox5Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=friXM2ppRWjAc5ET5w+wVYdgGT/YUZT7nCpppDnV1jGWQxNYM1DQK/B7ahDhcV54+
	 SQbzETYCgvVl8uHSjFERYp0kbK7tzKptgsf5dgXxOPSjn98KnFiY4haJAHcZLRBL7d
	 MLTKVmET1sxMD+DkdE30JcmuYM0Q92dESfpM5XFJSImFSv9gweMrVlx0zSFJy7z6BV
	 lLh5aWoTrxQX/qrxoxeRQREEwAt7OSoFfrbgelb2RmFehOiD1JO9zGMDriDzpndsYj
	 lrYefEzF2HSXuPhUIgAAqH5yjcUQ4loj6+bN8DkH+2HBK+iYPyxPCJCLJmFCxFR6Qt
	 tUZONcipro3dQ==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 39/39] deal with the last remaing boolean uses of fd_file()
Date: Tue, 30 Jul 2024 01:16:25 -0400
Message-Id: <20240730051625.14349-39-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[one added in fs/stat.c]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/infiniband/core/uverbs_cmd.c | 8 +++-----
 fs/stat.c                            | 2 +-
 include/linux/cleanup.h              | 2 +-
 sound/core/pcm_native.c              | 2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index a4cce360df21..66b02fbf077a 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -584,7 +584,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	if (cmd.fd != -1) {
 		/* search for file descriptor */
 		f = fdget(cmd.fd);
-		if (!fd_file(f)) {
+		if (fd_empty(f)) {
 			ret = -EBADF;
 			goto err_tree_mutex_unlock;
 		}
@@ -632,8 +632,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 		atomic_inc(&xrcd->usecnt);
 	}
 
-	if (fd_file(f))
-		fdput(f);
+	fdput(f);
 
 	mutex_unlock(&ibudev->xrcd_tree_mutex);
 	uobj_finalize_uobj_create(&obj->uobject, attrs);
@@ -648,8 +647,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	uobj_alloc_abort(&obj->uobject, attrs);
 
 err_tree_mutex_unlock:
-	if (fd_file(f))
-		fdput(f);
+	fdput(f);
 
 	mutex_unlock(&ibudev->xrcd_tree_mutex);
 
diff --git a/fs/stat.c b/fs/stat.c
index 56d6ce2b2c79..b7be119b070f 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -273,7 +273,7 @@ static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
 			  u32 request_mask)
 {
 	CLASS(fd_raw, f)(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 	return vfs_statx_path(&fd_file(f)->f_path, flags, stat, request_mask);
 }
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index a3d3e888cf1f..72615212b911 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -98,7 +98,7 @@ const volatile void * __must_check_fn(const volatile void *val)
  * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
  *
  *	CLASS(fdget, f)(fd);
- *	if (!fd_file(f))
+ *	if (fd_empty(f))
  *		return -EBADF;
  *
  *	// use 'f' without concern
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index cbb9c972cb93..320a7637b662 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2250,7 +2250,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	bool nonatomic = substream->pcm->nonatomic;
 	CLASS(fd, f)(fd);
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADFD;
 	if (!is_pcm_file(fd_file(f)))
 		return -EBADFD;
-- 
2.39.2


