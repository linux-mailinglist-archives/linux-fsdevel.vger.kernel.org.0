Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61955C44F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 22:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfGAU0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 16:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfGAU0t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:26:49 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 419022173E;
        Mon,  1 Jul 2019 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562012808;
        bh=TJXiGDpQyPo3Am55DXSOjkswMDHlO5HT8Li7G7X071Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CT/tkyuNgPvVOMOdhW295OKt46He+y0hcknm37HcP5rN0BhSxu3YBUwtHuMOKFNaL
         dw7MDFt2hEv11NkKp/LPABGZ94TCwNuTIWqWhMhZaXDwo7olGZzJE//iGVzDgByv8h
         OGXDy201TyCOpTCEivxHFJ9BDhmFBQ/DgZmujDGA=
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] f2fs: use generic checking and prep function for FS_IOC_SETFLAGS
Date:   Mon,  1 Jul 2019 13:26:28 -0700
Message-Id: <20190701202630.43776-2-ebiggers@kernel.org>
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

Make the f2fs implementation of FS_IOC_SETFLAGS use the new VFS helper
function vfs_ioc_setflags_prepare().

This is based on a patch from Darrick Wong, but reworked to apply after
commit 360985573b55 ("f2fs: separate f2fs i_flags from fs_flags and ext4
i_flags").

Originally-from: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e7c368db81851f..b5b941e6448657 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1765,7 +1765,8 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	u32 fsflags;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	u32 fsflags, old_fsflags;
 	u32 iflags;
 	int ret;
 
@@ -1789,8 +1790,14 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
+	old_fsflags = f2fs_iflags_to_fsflags(fi->i_flags);
+	ret = vfs_ioc_setflags_prepare(inode, old_fsflags, fsflags);
+	if (ret)
+		goto out;
+
 	ret = f2fs_setflags_common(inode, iflags,
 			f2fs_fsflags_to_iflags(F2FS_SETTABLE_FS_FL));
+out:
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
-- 
2.22.0.410.gd8fdbe21b5-goog

