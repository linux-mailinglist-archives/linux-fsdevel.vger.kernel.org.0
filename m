Return-Path: <linux-fsdevel+bounces-50269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A993ACA19C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 01:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474BA3B43EA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 23:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C9E258CED;
	Sun,  1 Jun 2025 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsAFWSY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1A25DCE0;
	Sun,  1 Jun 2025 23:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820326; cv=none; b=WAHHGCgdAUtyPtzjG+3A8DgbCAZruHuUyYTxIoBYKZB9O1oOKp9vJpYW2xkSwBGVky8sTeZ2d8A6mYuT4yUfKsspttui5+so4Rx4UuDnDxvaFRnzRJQnnossin39NFg0BYIFApCAGjSpcapxQA9Kfr+nWtqBBQxVCLcujZaC0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820326; c=relaxed/simple;
	bh=GlF/7nNGkKcM8Bkhd2WAsT/UJVnoFHO3xaPg2NSYqY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MjBQskxjklLVHkizapftGpX+hWaeG+8sNDbqz68Z3Uo7xcjkl8ou1DZxVkzztXw+i4+KRtYaz6XfW68O2kgZNbv2xGyfF4F6WK9MhFHDbpFbzRtUfwyN9wU04+zBpW+yoAL2bxuzjaQF2Y6hThrXvU5m9jzGanpIxHsvJET+RvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsAFWSY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238BEC4CEEE;
	Sun,  1 Jun 2025 23:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820326;
	bh=GlF/7nNGkKcM8Bkhd2WAsT/UJVnoFHO3xaPg2NSYqY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsAFWSY/KVLvc0+c1f6lx5W+r/CkAN8Kv+QFL0zcpAZ1kZjbeVF0zwKuDHqyDBnk+
	 6qHdOfne0H5cZEXHQogcZ5ykJlXotZeUdMZe7fGe4tufVXeGRP6X3ANLHZ6VpM8YOp
	 fN3qeptaneckH3nxW2JpmBgwMfQUlcQr+a5WtH1IAGlqiLVqARq0qXhLXJz5XbEozM
	 r2duR7qGfh2mhCd5+GuvNSD2TUwc/sOJijXs/oDahqPhArMxdnoRSjukIiCvmyN+zv
	 MP+334ZbbErJ5dOYvntQizyBilrAABJVzcVrxKkYOuRAhHZQitydKRkByDq8ZJsLse
	 kveY9CGuL4oNA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 019/110] exfat: do not clear volume dirty flag during sync
Date: Sun,  1 Jun 2025 19:23:01 -0400
Message-Id: <20250601232435.3507697-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Transfer-Encoding: 8bit

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit 46a557694b464881b3c2c4a0ba389a6436419a37 ]

xfstests generic/482 tests the file system consistency after each
FUA operation. It fails when run on exfat.

exFAT clears the volume dirty flag with a FUA operation during sync.
Since s_lock is not held when data is being written to a file, sync
can be executed at the same time. When data is being written to a
file, the FAT chain is updated first, and then the file size is
updated. If sync is executed between updating them, the length of the
FAT chain may be inconsistent with the file size.

To avoid the situation where the file system is inconsistent but the
volume dirty flag is cleared, this commit moves the clearing of the
volume dirty flag from exfat_fs_sync() to exfat_put_super(), so that
the volume dirty flag is not cleared until unmounting. After the
move, there is no additional action during sync, so exfat_fs_sync()
can be deleted.

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Looking at this commit to analyze for backport suitability: **YES** This
commit addresses a critical data consistency issue in the exFAT
filesystem that can cause file corruption when remounting read-only. The
commit resolves a race condition where the volume dirty flag could be
cleared prematurely, potentially leaving the filesystem in an
inconsistent state. ## Key Analysis Points: **1. Critical Bug Fix**: The
commit message clearly identifies this fixes a specific test failure
(xfstests generic/482) that tests filesystem consistency. File system
corruption is a serious user-facing issue that affects data integrity.
**2. Small, Contained Changes**: The code changes are minimal and
surgical: - Removes the `exfat_sync_fs()` function (only 20 lines) -
Moves `exfat_clear_volume_dirty(sb)` call from sync to unmount
(`exfat_put_super()`) - Updates the remount function to explicitly sync
and clear dirty flag - Removes the `.sync_fs` callback from the
super_operations structure **3. Race Condition Fix**: The commit
addresses a fundamental race condition where: - FAT chain updates happen
first - File size updates happen second - If sync occurs between these
steps, the filesystem becomes inconsistent - The volume dirty flag could
be cleared despite the inconsistency **4. Follows Stable Tree Rules**:
This is exactly the type of fix that should be backported: - Fixes file
system corruption - Minimal risk of regression - Small, focused change -
Addresses data integrity issue **5. Similar Historical Precedents**:
Looking at the similar commits provided: - Similar Commit #2 (Status:
YES) also deals with exFAT fsync functionality and data consistency -
Similar Commit #4 (Status: YES) addresses exFAT remount synchronization
issues - These precedents show that exFAT data consistency fixes are
typically backported **6. No Architectural Changes**: The fix doesn't
introduce new features or make architectural changes - it simply moves
when the volume dirty flag is cleared to prevent premature clearing
during race conditions. **7. Critical Subsystem**: Filesystem data
integrity is a critical subsystem where corruption bugs must be fixed to
protect user data. The code changes are straightforward - instead of
clearing the dirty flag during sync operations (which can race with
ongoing writes), the flag is only cleared at unmount time when no more
writes can occur. This ensures the filesystem dirty state accurately
reflects whether pending changes exist.

 fs/exfat/super.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8465033a6cf0c..7ed858937d45d 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -36,31 +36,12 @@ static void exfat_put_super(struct super_block *sb)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	mutex_lock(&sbi->s_lock);
+	exfat_clear_volume_dirty(sb);
 	exfat_free_bitmap(sbi);
 	brelse(sbi->boot_bh);
 	mutex_unlock(&sbi->s_lock);
 }
 
-static int exfat_sync_fs(struct super_block *sb, int wait)
-{
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	int err = 0;
-
-	if (unlikely(exfat_forced_shutdown(sb)))
-		return 0;
-
-	if (!wait)
-		return 0;
-
-	/* If there are some dirty buffers in the bdev inode */
-	mutex_lock(&sbi->s_lock);
-	sync_blockdev(sb->s_bdev);
-	if (exfat_clear_volume_dirty(sb))
-		err = -EIO;
-	mutex_unlock(&sbi->s_lock);
-	return err;
-}
-
 static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
@@ -219,7 +200,6 @@ static const struct super_operations exfat_sops = {
 	.write_inode	= exfat_write_inode,
 	.evict_inode	= exfat_evict_inode,
 	.put_super	= exfat_put_super,
-	.sync_fs	= exfat_sync_fs,
 	.statfs		= exfat_statfs,
 	.show_options	= exfat_show_options,
 	.shutdown	= exfat_shutdown,
@@ -751,10 +731,14 @@ static void exfat_free(struct fs_context *fc)
 
 static int exfat_reconfigure(struct fs_context *fc)
 {
+	struct super_block *sb = fc->root->d_sb;
 	fc->sb_flags |= SB_NODIRATIME;
 
-	/* volume flag will be updated in exfat_sync_fs */
-	sync_filesystem(fc->root->d_sb);
+	sync_filesystem(sb);
+	mutex_lock(&EXFAT_SB(sb)->s_lock);
+	exfat_clear_volume_dirty(sb);
+	mutex_unlock(&EXFAT_SB(sb)->s_lock);
+
 	return 0;
 }
 
-- 
2.39.5


