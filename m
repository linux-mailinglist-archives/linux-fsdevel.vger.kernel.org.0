Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB95C44D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 22:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfGAU0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 16:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfGAU0t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:26:49 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6BD621841;
        Mon,  1 Jul 2019 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562012809;
        bh=fH1qBz8bc9aMV/qeircw6YrBU3Zw3ZRFu8JyT+UZkO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPUIMVpM68daxj+LoCTaRcevYYhGNPlgAi5g0Bq52xfRB2hM168VM074YtK0J50mJ
         k73xI0YrsY0ompp9Zk/pCtCeNflGCwtz0ye/4oqgPG0HKb/s6bhHyhutEfqCLFhRwj
         TkeivbS+6hH90iOoYJ/Tp7zrixjaRy6ujstcFHFg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] f2fs: remove redundant check from f2fs_setflags_common()
Date:   Mon,  1 Jul 2019 13:26:30 -0700
Message-Id: <20190701202630.43776-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190701202630.43776-1-ebiggers@kernel.org>
References: <20190701202630.43776-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Now that f2fs_ioc_setflags() and f2fs_ioc_fssetxattr() call the VFS
helper functions which check for permission to change the immutable and
append-only flags, it's no longer needed to do this check in
f2fs_setflags_common() too.  So remove it.

This is based on a patch from Darrick Wong, but reworked to apply after
commit 360985573b55 ("f2fs: separate f2fs i_flags from fs_flags and ext4
i_flags").

Originally-from: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ae1a54ecc9fccc..e8b81f6f5c2b15 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1648,19 +1648,12 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
 static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	u32 oldflags;
 
 	/* Is it quota file? Do not allow user to mess with it */
 	if (IS_NOQUOTA(inode))
 		return -EPERM;
 
-	oldflags = fi->i_flags;
-
-	if ((iflags ^ oldflags) & (F2FS_APPEND_FL | F2FS_IMMUTABLE_FL))
-		if (!capable(CAP_LINUX_IMMUTABLE))
-			return -EPERM;
-
-	fi->i_flags = iflags | (oldflags & ~mask);
+	fi->i_flags = iflags | (fi->i_flags & ~mask);
 
 	if (fi->i_flags & F2FS_PROJINHERIT_FL)
 		set_inode_flag(inode, FI_PROJ_INHERIT);
-- 
2.22.0.410.gd8fdbe21b5-goog

