Return-Path: <linux-fsdevel+bounces-69313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E0C76897
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A960C35AB2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F5302766;
	Thu, 20 Nov 2025 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQJfM/Az"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A435E52C
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678006; cv=none; b=W/s+Uq1RRrIdgz+6amX/grO8yAw9KFd45/Sv+E2LHb43DbGiJ+RidSQojp+5tujkqDC641vvDLCH3s1/70HTFJJry2Rf0jGm5BBqUZ6O3c9JU5XQLPVp547Fd6VTTfDeyfP0lWqu7/tnj2HORBo1EZaHRyop3fMjJPSg6K0afiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678006; c=relaxed/simple;
	bh=r22Jxr449edIONN3XcVxWTBw5prBLSxHqjT8pqyeKGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUOMrPoBL5iTvPmQaiGYSKpPYKov2SCpBci6Dbc9c+TOOYfSgh2+mmsWfEhpWQaaDkexm48Y+4iXNSsUnTqBGzsbjMYBs/AKPqPGOxteQ88BKuPpVhKfL3bTHZXU7Jy+me7Ls4YgIcacQuPyrJTOKsmh+C5EwD5NaxXIKORVLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQJfM/Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BCCC116B1;
	Thu, 20 Nov 2025 22:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678006;
	bh=r22Jxr449edIONN3XcVxWTBw5prBLSxHqjT8pqyeKGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OQJfM/Azr8IvNlkLCv7Axuww2BvRrpeGkobgkAsMvvklPBU4qijQ44NzkF0MwJGx1
	 myU10bqmwWZCWs02CZajxEhwU5noHO32701feMGhHiLoF+Sej0suPItk3NmSpzfHfE
	 J7Wy5GCo4zWieUU1unYzDip1LwWX4UqgblHZUbfcaHvCL38+tfnqy9zdrqeBkOx5Q8
	 ZgylsqBN3eVklGmgRboWgfk7W8/eGvCJLdsCjZbCv9tgb/HM20o09Qm1gr2Lq67iwn
	 IMKMOD5xWPExXVe6i+0f3QzDXGmfT81l8r4ZFGNsHE49A5R+WiOH2IjcDPHPcrbm9Y
	 l85BuMNMqpY0Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:30 +0100
Subject: [PATCH RFC v2 33/48] spufs: convert spufs_context_open() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-33-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r22Jxr449edIONN3XcVxWTBw5prBLSxHqjT8pqyeKGU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3snZPjM+1n97ZKsbwWm+2q/22/h/paRNv/Qf/nS7
 x9cf/0R6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIrziG/znh1xd/u35uh3VY
 2ynp9a5hGvkm5yZ8meIyKSu7fLV7zBmG/7EZoU4FXAaGPiKhgd66E87eO/LcMqJwwXWN21N4Hq/
 ZyQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 7ec60290abe6..856f62aba854 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -267,22 +267,13 @@ spufs_mkdir(struct inode *dir, struct dentry *dentry, unsigned int flags,
 
 static int spufs_context_open(const struct path *path)
 {
-	int ret;
-	struct file *filp;
+	FD_PREPARE(fdf, 0, dentry_open(path, O_RDONLY, current_cred())) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	ret = get_unused_fd_flags(0);
-	if (ret < 0)
-		return ret;
-
-	filp = dentry_open(path, O_RDONLY, current_cred());
-	if (IS_ERR(filp)) {
-		put_unused_fd(ret);
-		return PTR_ERR(filp);
+		fd_prepare_file(fdf)->f_op = &spufs_context_fops;
+		return fd_publish(fdf);
 	}
-
-	filp->f_op = &spufs_context_fops;
-	fd_install(ret, filp);
-	return ret;
 }
 
 static struct spu_context *

-- 
2.47.3


