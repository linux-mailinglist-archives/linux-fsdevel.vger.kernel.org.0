Return-Path: <linux-fsdevel+bounces-68300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C2BC591CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 679F04F9C68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CDE35E55B;
	Thu, 13 Nov 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNFKBkei"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453035F8B7;
	Thu, 13 Nov 2025 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051863; cv=none; b=tQeKkUunvNpP8RMsjEcJOGtWjhizkFQqgMU+jUXgtbcw6ovOH/caZv/4Z8TPwUXqrf7VVM1irN6MFlLYnr9gDXOW+95kwioB0iK9geHEOh/qZX/SPMmdOQFAtwCQ9X3/wMBCZbhNQGzhFS3xw7aJgDPUbNKN26CI+kaW64MX70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051863; c=relaxed/simple;
	bh=X7ekcsGzSaytcItrvnZy1CSGOqYR9DdmI4qgMIFYRO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJuRIg+uxvIK+9DGnG60IJZBkgBEOpgzKeS7ZUq2xU2J6gnjHYGX8B8VDAW4MPkMKtFfSi3BPsarnMo+WzH9embgwNTlHDR+/P1HSgW5yz3GB/8uNU7vEpr4raGvsWYuu4xNJSwcMQ/WXVBiwaYGs1zCPiP2aDXBtYGBtc7RZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNFKBkei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8B4C4CEF8;
	Thu, 13 Nov 2025 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051862;
	bh=X7ekcsGzSaytcItrvnZy1CSGOqYR9DdmI4qgMIFYRO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kNFKBkeiqO8Y7rY9KoQ3fzMQpxJhwyBuCj91zZPeDQO/ULOwNPLth6BWPJpQb+t+8
	 j68/ihcfOTISPV8US9oR8wBWQpCUVI6vOl1vU1SXIO4qD0OW3vtKxLwqo62ggG4RrQ
	 Ys0jpZ7oWRq6ZE+LQoAHStSr13RXVUcsYm+YaEPkBoi7XMYqjApyCuEM4H6yRyNyvz
	 35D/n9Xk5C+Zuffd9aYRx/WpElzKjvfgMPNgGsK2JQsMS5C97BbIye0BjGXPly4yQ6
	 m3+SCGOtGuJwjIoGH21t0LpL5j+6Wq8eMTU+UrFTk3rtLhv+SykohEGbcp7L8vCaXT
	 7DAhSmonR2i/A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:12 +0100
Subject: [PATCH v2 07/42] ovl: port ovl_open_realfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-7-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=brauner@kernel.org;
 h=from:subject:message-id; bh=X7ekcsGzSaytcItrvnZy1CSGOqYR9DdmI4qgMIFYRO0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcboqXlH7ODnk4bc5i5a+2vyE7aznuyaVLTObmv+d5
 ry3LmhHeEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEvh9m+O+/1i4lq+nbvNUp
 ehpXP/81Cu/rXmX09sFRiVPTzf9c+zGXkaGteXLfs2vFSwW87Cymh+4+NqHqmXcJZz37/sWV//h
 YJ7IAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7ab2c9daffd0..1f606b62997b 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -31,7 +31,6 @@ static struct file *ovl_open_realfile(const struct file *file,
 	struct inode *inode = file_inode(file);
 	struct mnt_idmap *real_idmap;
 	struct file *realfile;
-	const struct cred *old_cred;
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
 	int acc_mode = ACC_MODE(flags);
 	int err;
@@ -39,9 +38,10 @@ static struct file *ovl_open_realfile(const struct file *file,
 	if (flags & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
-	old_cred = ovl_override_creds(inode->i_sb);
+	with_ovl_creds(inode->i_sb) {
 		real_idmap = mnt_idmap(realpath->mnt);
-	err = inode_permission(real_idmap, realinode, MAY_OPEN | acc_mode);
+		err = inode_permission(real_idmap, realinode,
+				       MAY_OPEN | acc_mode);
 		if (err) {
 			realfile = ERR_PTR(err);
 		} else {
@@ -49,9 +49,10 @@ static struct file *ovl_open_realfile(const struct file *file,
 				flags &= ~O_NOATIME;
 
 			realfile = backing_file_open(file_user_path(file),
-					     flags, realpath, current_cred());
+						     flags, realpath,
+						     current_cred());
+		}
 	}
-	ovl_revert_creds(old_cred);
 
 	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
 		 file, file, ovl_whatisit(inode, realinode), file->f_flags,

-- 
2.47.3


