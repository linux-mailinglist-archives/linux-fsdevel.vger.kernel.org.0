Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE33317A192
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 09:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEIma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 03:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgCEIm3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:42:29 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BF482146E;
        Thu,  5 Mar 2020 08:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583397749;
        bh=K/56YT+etKnoKYjtDmkQrf9U3Pw0mVZKDfdV/kmF4ks=;
        h=From:To:Cc:Subject:Date:From;
        b=R37w+oJeIdHqMiqGjA3IcdEQaYStFgKRJ90nIWmmQIJ+tqio/I6Sjxb5GOyK6x59/
         bZgSoVH/ljq8omzN71BE5Q/8QiGQwxl2qkU0Tx6SPVUHGClNHtsepqWO9Q5SHBFqwQ
         JlrZ/avFlhIJeUfAFnny/KFFFrNFQf04GaSRuMFY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fscrypt: don't evict dirty inodes after removing key
Date:   Thu,  5 Mar 2020 00:41:38 -0800
Message-Id: <20200305084138.653498-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

After FS_IOC_REMOVE_ENCRYPTION_KEY removes a key, it syncs the
filesystem and tries to get and put all inodes that were unlocked by the
key so that unused inodes get evicted via fscrypt_drop_inode().
Normally, the inodes are all clean due to the sync.

However, after the filesystem is sync'ed, userspace can modify and close
one of the files.  (Userspace is *supposed* to close the files before
removing the key.  But it doesn't always happen, and the kernel can't
assume it.)  This causes the inode to be dirtied and have i_count == 0.
Then, fscrypt_drop_inode() failed to consider this case and indicated
that the inode can be dropped, causing the write to be lost.

On f2fs, other problems such as a filesystem freeze could occur due to
the inode being freed while still on f2fs's dirty inode list.

Fix this bug by making fscrypt_drop_inode() only drop clean inodes.

I've written an xfstest which detects this bug on ext4, f2fs, and ubifs.

Fixes: b1c0ec3599f4 ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl")
Cc: <stable@vger.kernel.org> # v5.4+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/keysetup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index 65cb09fa6ead..08c9f216a54d 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -538,6 +538,15 @@ int fscrypt_drop_inode(struct inode *inode)
 		return 0;
 	mk = ci->ci_master_key->payload.data[0];
 
+	/*
+	 * With proper, non-racy use of FS_IOC_REMOVE_ENCRYPTION_KEY, all inodes
+	 * protected by the key were cleaned by sync_filesystem().  But if
+	 * userspace is still using the files, inodes can be dirtied between
+	 * then and now.  We mustn't lose any writes, so skip dirty inodes here.
+	 */
+	if (inode->i_state & I_DIRTY_ALL)
+		return 0;
+
 	/*
 	 * Note: since we aren't holding ->mk_secret_sem, the result here can
 	 * immediately become outdated.  But there's no correctness problem with
-- 
2.25.1

