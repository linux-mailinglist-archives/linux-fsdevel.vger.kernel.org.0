Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD7221CD88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 05:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgGMDKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jul 2020 23:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGMDKC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:10:02 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8249F2068F;
        Mon, 13 Jul 2020 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594609801;
        bh=10h5vKjFCGI+MRNMEl2+F3aI45N3pFJs0GxaJDaDmAg=;
        h=From:To:Subject:Date:From;
        b=nsmFARrVde0IdEFpC+fQLLxBTCFpi6FeGQmLwhk6go2sxRIjbmQpJ3rhW/l6shrhI
         B5Oz5k3trGZhuhMSsoI9tF4ap/J0dNwm6LjwjUkpHAsOoO4Vq5oJyUKi6ojzjPxoX4
         S9xjejAQjp24LjfVQ5nmTiKgrV6bU9vJHsaDg3Yk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs: define inode flags using bit numbers
Date:   Sun, 12 Jul 2020 20:09:52 -0700
Message-Id: <20200713030952.192348-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Define the VFS inode flags using bit numbers instead of hardcoding
powers of 2, which has become unwieldy now that we're up to 65536.

No change in the actual values.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/fs.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5abba86107d..973a3f9a3df5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1982,27 +1982,27 @@ struct super_operations {
 /*
  * Inode flags - they have no relation to superblock flags now
  */
-#define S_SYNC		1	/* Writes are synced at once */
-#define S_NOATIME	2	/* Do not update access times */
-#define S_APPEND	4	/* Append-only file */
-#define S_IMMUTABLE	8	/* Immutable file */
-#define S_DEAD		16	/* removed, but still open directory */
-#define S_NOQUOTA	32	/* Inode is not counted to quota */
-#define S_DIRSYNC	64	/* Directory modifications are synchronous */
-#define S_NOCMTIME	128	/* Do not update file c/mtime */
-#define S_SWAPFILE	256	/* Do not truncate: swapon got its bmaps */
-#define S_PRIVATE	512	/* Inode is fs-internal */
-#define S_IMA		1024	/* Inode has an associated IMA struct */
-#define S_AUTOMOUNT	2048	/* Automount/referral quasi-directory */
-#define S_NOSEC		4096	/* no suid or xattr security attributes */
+#define S_SYNC		(1 << 0)  /* Writes are synced at once */
+#define S_NOATIME	(1 << 1)  /* Do not update access times */
+#define S_APPEND	(1 << 2)  /* Append-only file */
+#define S_IMMUTABLE	(1 << 3)  /* Immutable file */
+#define S_DEAD		(1 << 4)  /* removed, but still open directory */
+#define S_NOQUOTA	(1 << 5)  /* Inode is not counted to quota */
+#define S_DIRSYNC	(1 << 6)  /* Directory modifications are synchronous */
+#define S_NOCMTIME	(1 << 7)  /* Do not update file c/mtime */
+#define S_SWAPFILE	(1 << 8)  /* Do not truncate: swapon got its bmaps */
+#define S_PRIVATE	(1 << 9)  /* Inode is fs-internal */
+#define S_IMA		(1 << 10) /* Inode has an associated IMA struct */
+#define S_AUTOMOUNT	(1 << 11) /* Automount/referral quasi-directory */
+#define S_NOSEC		(1 << 12) /* no suid or xattr security attributes */
 #ifdef CONFIG_FS_DAX
-#define S_DAX		8192	/* Direct Access, avoiding the page cache */
+#define S_DAX		(1 << 13) /* Direct Access, avoiding the page cache */
 #else
-#define S_DAX		0	/* Make all the DAX code disappear */
+#define S_DAX		0	  /* Make all the DAX code disappear */
 #endif
-#define S_ENCRYPTED	16384	/* Encrypted file (using fs/crypto/) */
-#define S_CASEFOLD	32768	/* Casefolded file */
-#define S_VERITY	65536	/* Verity file (using fs/verity/) */
+#define S_ENCRYPTED	(1 << 14) /* Encrypted file (using fs/crypto/) */
+#define S_CASEFOLD	(1 << 15) /* Casefolded file */
+#define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
-- 
2.27.0

