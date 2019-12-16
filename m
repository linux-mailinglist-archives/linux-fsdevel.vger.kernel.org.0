Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6893A12163A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 19:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbfLPS1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 13:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:46830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfLPS1o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:27:44 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC9121775;
        Mon, 16 Dec 2019 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520863;
        bh=7X/aZdMn7hMpLO952XIw3QQyEMjX1oj8HY0BeEUL97s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxKXPIlF5A1x6kAxdsHDOmF6cNGJDkgxPcYzYfWeKTas74LatcWFs0pfm6Fc4WRBX
         lYD08QdoGrzkEazmQgUvQ+cJ7vBi/KafZuoKshN2I6SrwyKeBBSBbndVL/pJ7Ij7j1
         WtXpKJ4KTpr3MsweGqFjtslIacQPg5W4bp7znLOY=
From:   fdmanana@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        darrick.wong@oracle.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] Btrfs: make deduplication with range including the last block work
Date:   Mon, 16 Dec 2019 18:26:56 +0000
Message-Id: <20191216182656.15624-3-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191216182656.15624-1-fdmanana@kernel.org>
References: <20191216182656.15624-1-fdmanana@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Since btrfs was migrated to use the generic VFS helpers for clone and
deduplication, it stopped allowing for the last block of a file to be
deduplicated when the source file size is not sector size aligned (when
eof is somewhere in the middle of the last block). There are two reasons
for that:

1) The generic code always rounds down, to a multiple of the block size,
   the range's length for deduplications. This means we end up never
   deduplicating the last block when the eof is not block size aligned,
   even for the safe case where the destination range's end offset matches
   the destination file's size. That rounding down operation is done at
   generic_remap_check_len();

2) Because of that, the btrfs specific code does not expect anymore any
   non-aligned range length's for deduplication and therefore does not
   work if such nona-aligned length is given.

This patch addresses that second part, and it depends on a patch that
fixes generic_remap_check_len(), in the VFS, which was submitted ealier
and has the following subject:

  "fs: allow deduplication of eof block into the end of the destination file"

These two patches address reports from users that started seeing lower
deduplication rates due to the last block never being deduplicated when
the file size is not aligned to the filesystem's block size.

Link: https://lore.kernel.org/linux-btrfs/2019-1576167349.500456@svIo.N5dq.dFFD/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3418decb9e61..c41c276ff272 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3237,6 +3237,7 @@ static void btrfs_double_extent_lock(struct inode *inode1, u64 loff1,
 static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 				   struct inode *dst, u64 dst_loff)
 {
+	const u64 bs = BTRFS_I(src)->root->fs_info->sb->s_blocksize;
 	int ret;
 
 	/*
@@ -3244,7 +3245,7 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 	 * source range to serialize with relocation.
 	 */
 	btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
-	ret = btrfs_clone(src, dst, loff, len, len, dst_loff, 1);
+	ret = btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);
 	btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
 
 	return ret;
-- 
2.11.0

