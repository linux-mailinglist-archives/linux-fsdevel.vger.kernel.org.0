Return-Path: <linux-fsdevel+bounces-1033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47097D50F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50481B212B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BAF29439;
	Tue, 24 Oct 2023 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lth0PrhP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7628E1F
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 13:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99BAC433C8;
	Tue, 24 Oct 2023 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698152781;
	bh=643g/XQmiQ2NFZJoNrdzUgTSzFzhse2eqaFJWyzKez0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lth0PrhPgetTg3jzGv/vHMSXqUZ27rscanDi2qsSZrD/LmyCo/zG1ULE+sVryDsPi
	 GopUxzhi81fdVZtgkzS+pNC3Dy1dbVdu0G2MKqLFNuQ7d+vV7t6S0ux8UznPuK84KN
	 hX/BFCsb1HfNDYz132L3CpA7GYoaWuHc5SF2TEWzG9ELpcw6Dp0gVS/de5HqWPVNrO
	 Hq3jsyj4yi8t+D2at5KI6jdgBVnUYgk/s+5l+GswaGywbDXKKdwzlRE63E1FbcL5YA
	 mqUdbr5IIaES0rMN9OlEmYBleLTNx+G5OaumpLxA5PhuhhyI2P3MS0ZlmfzU0GklSk
	 dSETsh94GL9TQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 15:01:12 +0200
Subject: [PATCH v2 06/10] fs: remove get_active_super()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-freeze-v2-6-599c19f4faac@kernel.org>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
In-Reply-To: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2266; i=brauner@kernel.org;
 h=from:subject:message-id; bh=643g/XQmiQ2NFZJoNrdzUgTSzFzhse2eqaFJWyzKez0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSaH3TULF6cWbFywoT0BysdSu5snjNrZklE5cb/5zl3S0+7
 4Zd1oaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiSeIM/4zWvzaMX2AVucB54urdM0
 ufTdyU96Nz+aTJclVGLwuSmZoYGZZ8eluxUqNLf1Z+6MaOo31ieuxvlfdpn1vpf3OhdM7rRH4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This function is now unused so remove it. One less function that uses
the global superblock list.

Link: https://lore.kernel.org/r/20230927-vfs-super-freeze-v1-4-ecc36d9ab4d9@kernel.org
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 28 ----------------------------
 include/linux/fs.h |  1 -
 2 files changed, 29 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index ee0795ce09c7..c9658ddb53f7 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1024,34 +1024,6 @@ void iterate_supers_type(struct file_system_type *type,
 
 EXPORT_SYMBOL(iterate_supers_type);
 
-/**
- * get_active_super - get an active reference to the superblock of a device
- * @bdev: device to get the superblock for
- *
- * Scans the superblock list and finds the superblock of the file system
- * mounted on the device given.  Returns the superblock with an active
- * reference or %NULL if none was found.
- */
-struct super_block *get_active_super(struct block_device *bdev)
-{
-	struct super_block *sb;
-
-	if (!bdev)
-		return NULL;
-
-	spin_lock(&sb_lock);
-	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (sb->s_bdev == bdev) {
-			if (!grab_super(sb))
-				return NULL;
-			super_unlock_excl(sb);
-			return sb;
-		}
-	}
-	spin_unlock(&sb_lock);
-	return NULL;
-}
-
 struct super_block *user_get_super(dev_t dev, bool excl)
 {
 	struct super_block *sb;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 03afc8b6f2af..5174e821d451 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3053,7 +3053,6 @@ extern int vfs_readlink(struct dentry *, char __user *, int);
 extern struct file_system_type *get_filesystem(struct file_system_type *fs);
 extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
-extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*)(struct super_block *, void *), void *);

-- 
2.34.1


