Return-Path: <linux-fsdevel+bounces-36141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8189DE6E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB4BB223C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2843019F48D;
	Fri, 29 Nov 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VudsppRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5A1990C9;
	Fri, 29 Nov 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885366; cv=none; b=jU6ppsDvG+1Hkw5GESejzyWpXlb915AYHIDQDIgXESDEp8YB0o/Wv9U6TIIBzSS3iWAz921zGZyVch+OFgbFgzry/ry7XCrWXYt3whRtsoEk9Wg8+v8ZKEru8M5Vehdcp7rQAa9x2/kZ99LvirNycwC/aHBG++WK8UkRD7mBh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885366; c=relaxed/simple;
	bh=1J6UPxtILhTxdAU/YMMXiqJEhnPoxJ1JRHaUYLuJeZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrOZ69pizb2wTlbHlAKl4XIO5EaGleQ2uSdTLMNKvmJq4f9oQTc+uwO1vibNhoNPp1yFi6vAyrtMPgcoty0SoYhuaG37l0B8ufV3JM72F4W1yIK6hu8SRn087A2/iZsRjipCh4Nz/tjRp+9Cc3BfsjVulSgYlAUbp3QPGZPXe/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VudsppRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7B3C4CECF;
	Fri, 29 Nov 2024 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732885366;
	bh=1J6UPxtILhTxdAU/YMMXiqJEhnPoxJ1JRHaUYLuJeZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VudsppRhDcZTvMCxd3Ztdh6/34k2uLmBbngDpI5HUlH7Ol9RIaeRGZun23ahma538
	 rSUJmuT4JdbiD2L7IQXfMaS3u7cmJxgJEylrk82DsPPusZUB8oZNl8IOIs3ELm+99I
	 Z0IQx6woSRx61LTgTkbLUelRT54IYh7tf0HZSqxzc9F3vBijLPXbDQ6TqC0vm3G4Kj
	 qaubtEYs0UlI3KZH14iMqy1GVfP6QJamf67SGJ4c5lNxMFNvuBgN1Qxc0jeeBQphP1
	 wqEgUoAV+iHSL8UGbsuHyzZrX8MWGjs2Loy2Y73nT/5Aw2WT+T/j4pUoZ/rL8Ici4E
	 CwDyyKgi08S7w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 29 Nov 2024 14:02:24 +0100
Subject: [PATCH RFC v2 2/3] pidfs: remove 32bit inode number handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-work-pidfs-v2-2-61043d66fbce@kernel.org>
References: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
In-Reply-To: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>, 
 Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2419; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1J6UPxtILhTxdAU/YMMXiqJEhnPoxJ1JRHaUYLuJeZw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR77s5NlH7auXrjs8ObrkQoLnpVLB0b45taom9Z48EY3
 LAgOP5kRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQmWjP801h+aIaVtXrl94ly
 r2dvjV++bvcdNsXUvOJwy+R7RqEWtgz/i55ZF+z8mJj1xdx2Wt2h1L7m0OTmqv8Wf+8+Xsa45mk
 QGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we have a unified inode number handling model remove the custom
ida-based allocation for 32bit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 46 +++++-----------------------------------------
 1 file changed, 5 insertions(+), 41 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 0bdd9c525b80895d33f2eae5e8e375788580072f..ff4f25078f3d983bce630e597adbb12262e5d727 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -371,40 +371,6 @@ struct pid *pidfd_pid(const struct file *file)
 
 static struct vfsmount *pidfs_mnt __ro_after_init;
 
-#if BITS_PER_LONG == 32
-/*
- * Provide a fallback mechanism for 32-bit systems so processes remain
- * reliably comparable by inode number even on those systems.
- */
-static DEFINE_IDA(pidfd_inum_ida);
-
-static int pidfs_inum(struct pid *pid, unsigned long *ino)
-{
-	int ret;
-
-	ret = ida_alloc_range(&pidfd_inum_ida, RESERVED_PIDS + 1,
-			      UINT_MAX, GFP_ATOMIC);
-	if (ret < 0)
-		return -ENOSPC;
-
-	*ino = ret;
-	return 0;
-}
-
-static inline void pidfs_free_inum(unsigned long ino)
-{
-	if (ino > 0)
-		ida_free(&pidfd_inum_ida, ino);
-}
-#else
-static inline int pidfs_inum(struct pid *pid, unsigned long *ino)
-{
-	*ino = pid->ino;
-	return 0;
-}
-#define pidfs_free_inum(ino) ((void)(ino))
-#endif
-
 /*
  * The vfs falls back to simple_setattr() if i_op->setattr() isn't
  * implemented. Let's reject it completely until we have a clean
@@ -456,7 +422,6 @@ static void pidfs_evict_inode(struct inode *inode)
 
 	clear_inode(inode);
 	put_pid(pid);
-	pidfs_free_inum(inode->i_ino);
 }
 
 static const struct super_operations pidfs_sops = {
@@ -482,17 +447,16 @@ static const struct dentry_operations pidfs_dentry_operations = {
 
 static int pidfs_init_inode(struct inode *inode, void *data)
 {
+	struct pid *pid = data;
+
 	inode->i_private = data;
 	inode->i_flags |= S_PRIVATE;
 	inode->i_mode |= S_IRWXU;
 	inode->i_op = &pidfs_inode_operations;
 	inode->i_fop = &pidfs_file_operations;
-	/*
-	 * Inode numbering for pidfs start at RESERVED_PIDS + 1. This
-	 * avoids collisions with the root inode which is 1 for pseudo
-	 * filesystems.
-	 */
-	return pidfs_inum(data, &inode->i_ino);
+	inode->i_ino = pidfs_ino(pid->ino);
+	inode->i_generation = pidfs_gen(pid->ino);
+	return 0;
 }
 
 static void pidfs_put_data(void *data)

-- 
2.45.2


