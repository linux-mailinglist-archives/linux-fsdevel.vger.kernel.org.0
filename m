Return-Path: <linux-fsdevel+bounces-36088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCD39DB7C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 13:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE53286FD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487991A9B4C;
	Thu, 28 Nov 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9MViOGT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBCA1A9B26;
	Thu, 28 Nov 2024 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797246; cv=none; b=kWlHBauuJ5XIMSGsT3QJjFm6+8JapkY+ybnC68BjzOv6hpnMWP8yUGTMOHW30S7jk4+ZiGawxg+LCneq7eoJwBWTR2FgKEQe+ZeyRXuT0XPvOq1ZFN2baiuxvlaNtmPRJZID4oaEOB6HxZC7cjJkByCei0mVmhnhUIMzBtSyYT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797246; c=relaxed/simple;
	bh=EEW4Cdyc4h8c2gh3EbxdsQJkmYgdPEEWnE0d9G+UEoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJnHLUI8beVexv9znof2o7BYyhJGJYf9+qbP6XEknNS2WZL8aaYZ9rSiz9AxTfOII/QBQy+3EAv5bGRSBDrwezWBXYpI4gTDTjZJ9bp9FNQHBYSfa3+Dd9LKAfEYlgqIiKppxsLOrUK442+W1eO9SHJ10EXUPdi15AFDO3ajDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9MViOGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B32C4CEDB;
	Thu, 28 Nov 2024 12:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732797246;
	bh=EEW4Cdyc4h8c2gh3EbxdsQJkmYgdPEEWnE0d9G+UEoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K9MViOGTFAdy2/BsrZaujMwNR2PgO8NjqKmmGVd+f5Vrf5HRHy9+S/LOKENuBjYaW
	 LkuNXMydD/9qs9BlkX7E/jYNBpzMF2hNSbQxYiHqnT42QZcw9Sry9R9lVP2U2eYCsk
	 kT4jWctyArBV1h00zRMMgeQBID4iAKY29/3BcTbcF6iBRGZLxZJB4xtkwnCXHwTDBb
	 IdE4QcF8DcidYNb2gBKI/QXUksOVwFrKVYxck1llRwQ6VQ25Jxc48yiBiUlcY8hB7P
	 UJMxJiII+TyLyrxZH++dsFcgdo8d3hPWC9IqaIgdWWQ2yNIvI3H6Uw+qN/5izZpwwT
	 EB4z6kW8lBjNg==
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 2/2] pidfs: remove 32bit inode number handling
Date: Thu, 28 Nov 2024 13:33:38 +0100
Message-ID: <20241128-work-pidfs-v1-2-80f267639d98@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128-work-pidfs-v1-0-80f267639d98@kernel.org>
References: <20241128-work-pidfs-v1-0-80f267639d98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2419; i=brauner@kernel.org; h=from:subject:message-id; bh=EEW4Cdyc4h8c2gh3EbxdsQJkmYgdPEEWnE0d9G+UEoY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR7JKuerI9KTzHWz1GevvJ9m9KBo1PDXontVX1Tl7/5T NcPw41NHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPp387wh7fef/7sbc4qk0qr vJhkdmv823GoVtpugqXI5qkurb6lsxkZTndNi+D1qY5+aHXE8Kl6VtDDU6vFy31fHn1V+KAooHE 3EwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that we have a unified inode number handling model remove the custom
ida-based allocation for 32bit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 46 +++++-----------------------------------------
 1 file changed, 5 insertions(+), 41 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 09a0c8ac805301927a94758b3f7d1e513826daf9..334d2fc3f01ee6f219dc3e52309bfe00726885ca 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -400,40 +400,6 @@ struct pid *pidfd_pid(const struct file *file)
 
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
@@ -485,7 +451,6 @@ static void pidfs_evict_inode(struct inode *inode)
 
 	clear_inode(inode);
 	put_pid(pid);
-	pidfs_free_inum(inode->i_ino);
 }
 
 static const struct super_operations pidfs_sops = {
@@ -511,17 +476,16 @@ static const struct dentry_operations pidfs_dentry_operations = {
 
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


