Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC705117942
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 23:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfLIWYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 17:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfLIWYV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:24:21 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 232362073D;
        Mon,  9 Dec 2019 22:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575930260;
        bh=Txysl0+3YMuRnATdL1j/J6K16t6mLbaFJChqfy90MwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tYWBRWpv36hPtz6Evnmhu1djMMLvR26BcTJAwTXhIiyYmTwvY7PA9gSwJ6hHA3Yuk
         AnWbw5RR2NCZSMNAvpCFfu546W9qlnKss1wScPWsDu0uJrTpWDF/2diIOVGbs04YRp
         v9DjBbCglO5H6B1ugc/9D3QyPBKN/PXTQIeXLE/k=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] ubifs: add support for FS_ENCRYPT_FL
Date:   Mon,  9 Dec 2019 14:23:25 -0800
Message-Id: <20191209222325.95656-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191209222325.95656-1-ebiggers@kernel.org>
References: <20191209222325.95656-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make the FS_IOC_GETFLAGS ioctl on ubifs return the FS_ENCRYPT_FL flag on
encrypted files, like ext4 and f2fs do.

Also make this flag be ignored by FS_IOC_SETFLAGS, like ext4 and f2fs
do, since it's a recognized flag but is not directly settable.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ubifs/ioctl.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index eeb1be2598881..d49fc04f2d7d4 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -17,10 +17,14 @@
 #include "ubifs.h"
 
 /* Need to be kept consistent with checked flags in ioctl2ubifs() */
-#define UBIFS_SUPPORTED_IOCTL_FLAGS \
+#define UBIFS_SETTABLE_IOCTL_FLAGS \
 	(FS_COMPR_FL | FS_SYNC_FL | FS_APPEND_FL | \
 	 FS_IMMUTABLE_FL | FS_DIRSYNC_FL)
 
+/* Need to be kept consistent with checked flags in ubifs2ioctl() */
+#define UBIFS_GETTABLE_IOCTL_FLAGS \
+	(UBIFS_SETTABLE_IOCTL_FLAGS | FS_ENCRYPT_FL)
+
 /**
  * ubifs_set_inode_flags - set VFS inode flags.
  * @inode: VFS inode to set flags for
@@ -91,6 +95,8 @@ static int ubifs2ioctl(int ubifs_flags)
 		ioctl_flags |= FS_IMMUTABLE_FL;
 	if (ubifs_flags & UBIFS_DIRSYNC_FL)
 		ioctl_flags |= FS_DIRSYNC_FL;
+	if (ubifs_flags & UBIFS_CRYPT_FL)
+		ioctl_flags |= FS_ENCRYPT_FL;
 
 	return ioctl_flags;
 }
@@ -113,7 +119,7 @@ static int setflags(struct inode *inode, int flags)
 	if (err)
 		goto out_unlock;
 
-	ui->flags &= ~ioctl2ubifs(UBIFS_SUPPORTED_IOCTL_FLAGS);
+	ui->flags &= ~ioctl2ubifs(UBIFS_SETTABLE_IOCTL_FLAGS);
 	ui->flags |= ioctl2ubifs(flags);
 	ubifs_set_inode_flags(inode);
 	inode->i_ctime = current_time(inode);
@@ -156,8 +162,9 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (get_user(flags, (int __user *) arg))
 			return -EFAULT;
 
-		if (flags & ~UBIFS_SUPPORTED_IOCTL_FLAGS)
+		if (flags & ~UBIFS_GETTABLE_IOCTL_FLAGS)
 			return -EOPNOTSUPP;
+		flags &= UBIFS_SETTABLE_IOCTL_FLAGS;
 
 		if (!S_ISDIR(inode->i_mode))
 			flags &= ~FS_DIRSYNC_FL;
-- 
2.24.0.393.g34dc348eaf-goog

