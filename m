Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7811B20C65C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jun 2020 08:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgF1GKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jun 2020 02:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgF1GKh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jun 2020 02:10:37 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409EA21473;
        Sun, 28 Jun 2020 06:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593324636;
        bh=gRgayTRJ5OsbWbGZUwN7yGHPV5KREu495tZWeMC74TA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zf0XYX/yluiK6jnfRAwQTfK0H6Q/6R2ffPmSOEqjlG0KTZ7XikFpBgOouRaKWwO6i
         XMhEE0gcSCUXQ9+9acAe/3ttDf2giYHf5KOP12rC8Sz/6rauwJf0ZBfFohn8Lemhhk
         Y51kAoRxecVoGjttLOVq15oMRncgrccHp5JJ/EuA=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH 6/6] fs/minix: remove expected error message in block_to_path()
Date:   Sat, 27 Jun 2020 23:08:45 -0700
Message-Id: <20200628060846.682158-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628060846.682158-1-ebiggers@kernel.org>
References: <20200628060846.682158-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When truncating a file to a size within the last allowed logical block,
block_to_path() is called with the *next* block.  This exceeds the
limit, causing the "block %ld too big" error message to be printed.

This case isn't actually an error; there are just no more blocks past
that point.  So, remove this error message.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/minix/itree_v1.c | 12 ++++++------
 fs/minix/itree_v2.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/minix/itree_v1.c b/fs/minix/itree_v1.c
index 405573a79aab..1fed906042aa 100644
--- a/fs/minix/itree_v1.c
+++ b/fs/minix/itree_v1.c
@@ -29,12 +29,12 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 	if (block < 0) {
 		printk("MINIX-fs: block_to_path: block %ld < 0 on dev %pg\n",
 			block, inode->i_sb->s_bdev);
-	} else if ((u64)block * BLOCK_SIZE >= inode->i_sb->s_maxbytes) {
-		if (printk_ratelimit())
-			printk("MINIX-fs: block_to_path: "
-			       "block %ld too big on dev %pg\n",
-				block, inode->i_sb->s_bdev);
-	} else if (block < 7) {
+		return 0;
+	}
+	if ((u64)block * BLOCK_SIZE >= inode->i_sb->s_maxbytes)
+		return 0;
+
+	if (block < 7) {
 		offsets[n++] = block;
 	} else if ((block -= 7) < 512) {
 		offsets[n++] = 7;
diff --git a/fs/minix/itree_v2.c b/fs/minix/itree_v2.c
index ee8af2f9e282..9d00f31a2d9d 100644
--- a/fs/minix/itree_v2.c
+++ b/fs/minix/itree_v2.c
@@ -32,12 +32,12 @@ static int block_to_path(struct inode * inode, long block, int offsets[DEPTH])
 	if (block < 0) {
 		printk("MINIX-fs: block_to_path: block %ld < 0 on dev %pg\n",
 			block, sb->s_bdev);
-	} else if ((u64)block * (u64)sb->s_blocksize >= sb->s_maxbytes) {
-		if (printk_ratelimit())
-			printk("MINIX-fs: block_to_path: "
-			       "block %ld too big on dev %pg\n",
-				block, sb->s_bdev);
-	} else if (block < DIRCOUNT) {
+		return 0;
+	}
+	if ((u64)block * (u64)sb->s_blocksize >= sb->s_maxbytes)
+		return 0;
+
+	if (block < DIRCOUNT) {
 		offsets[n++] = block;
 	} else if ((block -= DIRCOUNT) < INDIRCOUNT(sb)) {
 		offsets[n++] = DIRCOUNT;
-- 
2.27.0

