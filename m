Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FFC5A3540
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiH0HBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 03:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiH0HBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:01:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCE18B2CC;
        Sat, 27 Aug 2022 00:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CF37B80EE6;
        Sat, 27 Aug 2022 07:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7DAC4347C;
        Sat, 27 Aug 2022 07:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661583692;
        bh=UvXddYd+iwueCPhRMn68McfBxmc3REsqRxfThR55PaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oudzvj887EqPL0I9pQyZzOoVwv9mevFDu30f0H9Vuyv4C4+bWVfn/u6xPYXgcklZ6
         hix3W58pqKbJRezEXoZBe4MgOVszQm7EFVIR9sMdju4QLGBun8yLiA4at/mLUltetp
         ot6qbnRYlhXMX2Smtxx+wMbwjEeP1Ti4KTb3VTA6EfZ5KW/w7UxpxclHnqGZuzU1Fy
         EwOaNwXFkJR0NyWFkeahBNULUcMW34XDGOwStlWJt3Ta8RWF3cAhs4+mvNyAp9nwwv
         eKrcsaqWkAl4xdJB7OW18WXmxIyWHLLjeJqjV3JdTYh2wVGUXccrTLP7VRYAI34XvQ
         OmMl1hNTS791Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v5 4/8] ext4: support STATX_DIOALIGN
Date:   Fri, 26 Aug 2022 23:58:47 -0700
Message-Id: <20220827065851.135710-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827065851.135710-1-ebiggers@kernel.org>
References: <20220827065851.135710-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add support for STATX_DIOALIGN to ext4, so that direct I/O alignment
restrictions are exposed to userspace in a generic way.

Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/file.c  | 42 ++++++++++++++++++++++++++----------------
 fs/ext4/inode.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9bca5565547bae..e6674504ca2abe 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2979,6 +2979,7 @@ extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 extern int  ext4_write_inode(struct inode *, struct writeback_control *);
 extern int  ext4_setattr(struct user_namespace *, struct dentry *,
 			 struct iattr *);
+extern u32  ext4_dio_alignment(struct inode *inode);
 extern int  ext4_getattr(struct user_namespace *, const struct path *,
 			 struct kstat *, u32, unsigned int);
 extern void ext4_evict_inode(struct inode *);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 26d7426208970d..8bb1c35fd6dd5a 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -36,24 +36,34 @@
 #include "acl.h"
 #include "truncate.h"
 
-static bool ext4_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
+/*
+ * Returns %true if the given DIO request should be attempted with DIO, or
+ * %false if it should fall back to buffered I/O.
+ *
+ * DIO isn't well specified; when it's unsupported (either due to the request
+ * being misaligned, or due to the file not supporting DIO at all), filesystems
+ * either fall back to buffered I/O or return EINVAL.  For files that don't use
+ * any special features like encryption or verity, ext4 has traditionally
+ * returned EINVAL for misaligned DIO.  iomap_dio_rw() uses this convention too.
+ * In this case, we should attempt the DIO, *not* fall back to buffered I/O.
+ *
+ * In contrast, in cases where DIO is unsupported due to ext4 features, ext4
+ * traditionally falls back to buffered I/O.
+ *
+ * This function implements the traditional ext4 behavior in all these cases.
+ */
+static bool ext4_should_use_dio(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	u32 dio_align = ext4_dio_alignment(inode);
 
-	if (IS_ENCRYPTED(inode)) {
-		if (!fscrypt_dio_supported(inode))
-			return false;
-		if (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter),
-				i_blocksize(inode)))
-			return false;
-	}
-	if (fsverity_active(inode))
+	if (dio_align == 0)
 		return false;
-	if (ext4_should_journal_data(inode))
-		return false;
-	if (ext4_has_inline_data(inode))
-		return false;
-	return true;
+
+	if (dio_align == 1)
+		return true;
+
+	return IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter), dio_align);
 }
 
 static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -68,7 +78,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		inode_lock_shared(inode);
 	}
 
-	if (!ext4_dio_supported(iocb, to)) {
+	if (!ext4_should_use_dio(iocb, to)) {
 		inode_unlock_shared(inode);
 		/*
 		 * Fallback to buffered I/O if the operation being performed on
@@ -516,7 +526,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	/* Fallback to buffered I/O if the inode does not support direct I/O. */
-	if (!ext4_dio_supported(iocb, from)) {
+	if (!ext4_should_use_dio(iocb, from)) {
 		if (ilock_shared)
 			inode_unlock_shared(inode);
 		else
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3aec..364774230d87ac 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5550,6 +5550,22 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	return error;
 }
 
+u32 ext4_dio_alignment(struct inode *inode)
+{
+	if (fsverity_active(inode))
+		return 0;
+	if (ext4_should_journal_data(inode))
+		return 0;
+	if (ext4_has_inline_data(inode))
+		return 0;
+	if (IS_ENCRYPTED(inode)) {
+		if (!fscrypt_dio_supported(inode))
+			return 0;
+		return i_blocksize(inode);
+	}
+	return 1; /* use the iomap defaults */
+}
+
 int ext4_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
@@ -5565,6 +5581,27 @@ int ext4_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		stat->btime.tv_nsec = ei->i_crtime.tv_nsec;
 	}
 
+	/*
+	 * Return the DIO alignment restrictions if requested.  We only return
+	 * this information when requested, since on encrypted files it might
+	 * take a fair bit of work to get if the file wasn't opened recently.
+	 */
+	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
+		u32 dio_align = ext4_dio_alignment(inode);
+
+		stat->result_mask |= STATX_DIOALIGN;
+		if (dio_align == 1) {
+			struct block_device *bdev = inode->i_sb->s_bdev;
+
+			/* iomap defaults */
+			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+			stat->dio_offset_align = bdev_logical_block_size(bdev);
+		} else {
+			stat->dio_mem_align = dio_align;
+			stat->dio_offset_align = dio_align;
+		}
+	}
+
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 	if (flags & EXT4_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
-- 
2.37.2

