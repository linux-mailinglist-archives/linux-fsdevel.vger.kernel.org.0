Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0006A705D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbfGVQxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 12:53:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730772AbfGVQxx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:53:53 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0B92199C;
        Mon, 22 Jul 2019 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563814431;
        bh=VGrXcuq2JJds5s8/6aDAR92CvWXdrLRgJCIHirZzjWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSSPFdYxo7NKJJfa6Yg/l3vEFvo4wI2jrxVl6IwvIZxHtlicp0FALyeL5MqfV2JDn
         V9IRDTsww5mYsu0KGn0ME5kjJo7bIVOmoC/PS9/9Rq7phWz4bXIzmHyx/Dqo/4mQx+
         joJUBQ1LU7SFzAKqPjJs6IMayCCv34UpCPRh84iA=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v7 06/17] fs-verity: add inode and superblock fields
Date:   Mon, 22 Jul 2019 09:50:50 -0700
Message-Id: <20190722165101.12840-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722165101.12840-1-ebiggers@kernel.org>
References: <20190722165101.12840-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Analogous to fs/crypto/, add fields to the VFS inode and superblock for
use by the fs/verity/ support layer:

- ->s_vop: points to the fsverity_operations if the filesystem supports
  fs-verity, otherwise is NULL.

- ->i_verity_info: points to cached fs-verity information for the inode
  after someone opens it, otherwise is NULL.

- S_VERITY: bit in ->i_flags that identifies verity inodes, even when
  they haven't been opened yet and thus still have NULL ->i_verity_info.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/fs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 56b8e358af5c1..b3a0f5bfb06d7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -64,6 +64,8 @@ struct workqueue_struct;
 struct iov_iter;
 struct fscrypt_info;
 struct fscrypt_operations;
+struct fsverity_info;
+struct fsverity_operations;
 struct fs_context;
 struct fs_parameter_description;
 
@@ -723,6 +725,10 @@ struct inode {
 	struct fscrypt_info	*i_crypt_info;
 #endif
 
+#ifdef CONFIG_FS_VERITY
+	struct fsverity_info	*i_verity_info;
+#endif
+
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
@@ -1427,6 +1433,9 @@ struct super_block {
 	const struct xattr_handler **s_xattr;
 #ifdef CONFIG_FS_ENCRYPTION
 	const struct fscrypt_operations	*s_cop;
+#endif
+#ifdef CONFIG_FS_VERITY
+	const struct fsverity_operations *s_vop;
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
@@ -1965,6 +1974,7 @@ struct super_operations {
 #endif
 #define S_ENCRYPTED	16384	/* Encrypted file (using fs/crypto/) */
 #define S_CASEFOLD	32768	/* Casefolded file */
+#define S_VERITY	65536	/* Verity file (using fs/verity/) */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -2006,6 +2016,7 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_DAX(inode)		((inode)->i_flags & S_DAX)
 #define IS_ENCRYPTED(inode)	((inode)->i_flags & S_ENCRYPTED)
 #define IS_CASEFOLDED(inode)	((inode)->i_flags & S_CASEFOLD)
+#define IS_VERITY(inode)	((inode)->i_flags & S_VERITY)
 
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev == WHITEOUT_DEV)
-- 
2.22.0

