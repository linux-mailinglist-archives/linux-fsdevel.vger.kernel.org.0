Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442EF2EA1DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 01:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbhAEA4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 19:56:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbhAEA43 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:56:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE7C122955;
        Tue,  5 Jan 2021 00:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609808110;
        bh=SwwC2tQmuzx2ECIC/aYAUe8sOHWx78XkiAxTAUcoLvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Srdu4HxF1Bb9lEnR7JzmGw/pdJjgAOcpxaS4Evh8wreQR3/eN7eUek7cPFXHkcOaX
         lP184SXS2dHBX1l/m6Xd4qXPeYU4JGmMqZHXpHz/62wMMlOf0dL21hMP0mh4xZFYrV
         9JXvXG7cNpFUn1xaxZHWtAbrVZdWzyWRe2/n4Mz0NBqC0ZpRVkCsF4zucS4Bgq4luo
         SMClFaef9S/mS8BcRvOz3HVeAsvDIYQWYC6Gbxjt2fQ65CbGPeOopGXTTzKkT9UQTb
         l9n/P27mrwnTgHDHwtEkxO2GafO5eYYSKRVI3erirNDRVNH1/EGucH2wSlAOpnUTan
         rUAdXIJZ1qfcw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/13] xfs: implement lazytime_expired
Date:   Mon,  4 Jan 2021 16:54:52 -0800
Message-Id: <20210105005452.92521-14-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105005452.92521-1-ebiggers@kernel.org>
References: <20210105005452.92521-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Implement the new ->lazytime_expired method to get notified of lazytime
timestamp expirations, instead of relying on ->dirty_inode(inode,
I_DIRTY_SYNC) which is potentially ambiguous.

This fixes a bug where XFS didn't write lazytime timestamps to disk upon
a sync(), or after 24 hours (dirtytime_expire_interval * 2).  This is
because it only wrote the timestamps if I_DIRTY_TIME was set in i_state.
But actually when an inode's timestamps expire without the inode being
marked I_DIRTY_SYNC first, then ->dirty_inode isn't called until
__writeback_single_inode() has already cleared I_DIRTY_TIME in i_state.

The new ->lazytime_expired method is unambiguous, so it removes any need
to check for I_DIRTY_TIME, which avoids this bug.

I've written an xfstest which reproduces this bug.

Fixes: c3b1b13190ae ("xfs: implement the lazytime mount option")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/xfs/xfs_super.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 813be879a5e51..0b7623907b264 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -666,19 +666,13 @@ xfs_fs_destroy_inode(
 }
 
 static void
-xfs_fs_dirty_inode(
-	struct inode			*inode,
-	int				flag)
+xfs_fs_lazytime_expired(
+	struct inode			*inode)
 {
 	struct xfs_inode		*ip = XFS_I(inode);
 	struct xfs_mount		*mp = ip->i_mount;
 	struct xfs_trans		*tp;
 
-	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
-		return;
-	if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
-		return;
-
 	if (xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp))
 		return;
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
@@ -1108,7 +1102,7 @@ xfs_fs_free_cached_objects(
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
-	.dirty_inode		= xfs_fs_dirty_inode,
+	.lazytime_expired	= xfs_fs_lazytime_expired,
 	.drop_inode		= xfs_fs_drop_inode,
 	.put_super		= xfs_fs_put_super,
 	.sync_fs		= xfs_fs_sync_fs,
-- 
2.30.0

