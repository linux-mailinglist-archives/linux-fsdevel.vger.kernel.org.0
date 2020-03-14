Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D98D018577A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 02:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCOBjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Mar 2020 21:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgCOBjN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:39:13 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EADF720791;
        Sat, 14 Mar 2020 20:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584219194;
        bh=ZzuiXJqO7xJuPiMyB/BPCRwhFr979eXQdYA1WeJwYWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hAaAM7yRrqMusd/sK52UdwQpOzgF3eiT9ddaMqxp+st3LMnrNcXRPOBlYKENxE8q8
         en7uS4J+vpq0fp2GA3ZxV+CrJYXX6hBYwnhSbT0f+RARhtTLKPM9O3o5/80ffNQxxk
         nrdzx8iSktHeW2Jeb7tnkEWDGz5XJKI76gJnQZlk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH 3/4] f2fs: wire up FS_IOC_GET_ENCRYPTION_NONCE
Date:   Sat, 14 Mar 2020 13:50:51 -0700
Message-Id: <20200314205052.93294-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200314205052.93294-1-ebiggers@kernel.org>
References: <20200314205052.93294-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This new ioctl retrieves a file's encryption nonce, which is useful for
testing.  See the corresponding fs/crypto/ patch for more details.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0d4da644df3bc..351762f778405 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2423,6 +2423,14 @@ static int f2fs_ioc_get_encryption_key_status(struct file *filp,
 	return fscrypt_ioctl_get_key_status(filp, (void __user *)arg);
 }
 
+static int f2fs_ioc_get_encryption_nonce(struct file *filp, unsigned long arg)
+{
+	if (!f2fs_sb_has_encrypt(F2FS_I_SB(file_inode(filp))))
+		return -EOPNOTSUPP;
+
+	return fscrypt_ioctl_get_nonce(filp, (void __user *)arg);
+}
+
 static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -3437,6 +3445,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_remove_encryption_key_all_users(filp, arg);
 	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
 		return f2fs_ioc_get_encryption_key_status(filp, arg);
+	case FS_IOC_GET_ENCRYPTION_NONCE:
+		return f2fs_ioc_get_encryption_nonce(filp, arg);
 	case F2FS_IOC_GARBAGE_COLLECT:
 		return f2fs_ioc_gc(filp, arg);
 	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
@@ -3611,6 +3621,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FS_IOC_REMOVE_ENCRYPTION_KEY:
 	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
 	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
+	case FS_IOC_GET_ENCRYPTION_NONCE:
 	case F2FS_IOC_GARBAGE_COLLECT:
 	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
 	case F2FS_IOC_WRITE_CHECKPOINT:
-- 
2.25.1

