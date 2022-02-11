Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494BC4B1E6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 07:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344480AbiBKGOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 01:14:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbiBKGNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:13:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33795F65;
        Thu, 10 Feb 2022 22:13:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D3CCB82697;
        Fri, 11 Feb 2022 06:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2D8C340EB;
        Fri, 11 Feb 2022 06:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644560007;
        bh=nusYqtUDYr67sy2COTEwLJkUm+5b5gE/RxtW4gg1+6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CIDZJTQiiXv0GRyqMLC3krA9/a0vldq057bpGmujKP1iS3mQr8MvMnwfsz5AAcaE2
         RVmYxdIIOo/ViNb0lGaLJzsXtVbuv5x2yKN+kGI/gIUwFxgrI5G0/pRhf9Vgyf/V7I
         v4pF2B14m1lzjgCZMoYv4vIYU7N9ZTPedUtomjFzfIyDIyB8nmOeAvg/JgTs1jtTNB
         xNpYQa76FB3paI8IQBCpzJAzFAre+3Z5H9yqXong0deqCxTXdLcUZmyQhbqL7nkjLa
         PeoQvTYWMYZEbkoK2RNlKevW+foClFiEAPVK1DlAk7h9DmtKxYYo9fqGX7gagroAAb
         fvgmBWZpUeycQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/7] ext4: support STATX_IOALIGN
Date:   Thu, 10 Feb 2022 22:11:54 -0800
Message-Id: <20220211061158.227688-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211061158.227688-1-ebiggers@kernel.org>
References: <20220211061158.227688-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add support for STATX_IOALIGN to ext4, so that I/O alignment information
is exposed to userspace in a consistent and easy-to-use way.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/file.c  | 15 ++++-----------
 fs/ext4/inode.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bcd3b9bf8069b..fcab9713005fa 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3014,6 +3014,7 @@ extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 extern int  ext4_write_inode(struct inode *, struct writeback_control *);
 extern int  ext4_setattr(struct user_namespace *, struct dentry *,
 			 struct iattr *);
+extern u32  ext4_dio_alignment(struct inode *inode);
 extern int  ext4_getattr(struct user_namespace *, const struct path *,
 			 struct kstat *, u32, unsigned int);
 extern void ext4_evict_inode(struct inode *);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index b68706f7db439..9c34f827a021f 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -39,19 +39,12 @@
 static bool ext4_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
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
-		return false;
-	if (ext4_should_journal_data(inode))
+	if (!dio_align)
 		return false;
-	if (ext4_has_inline_data(inode))
+	if (dio_align > bdev_logical_block_size(inode->i_sb->s_bdev) &&
+	    !IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter), dio_align))
 		return false;
 	return true;
 }
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4cf55ef54193a..8c9d124a6378c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5493,6 +5493,22 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
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
+	return bdev_logical_block_size(inode->i_sb->s_bdev);
+}
+
 int ext4_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
@@ -5508,6 +5524,21 @@ int ext4_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		stat->btime.tv_nsec = ei->i_crtime.tv_nsec;
 	}
 
+	/*
+	 * Return the I/O alignment information if requested.  We only return
+	 * this information when requested, since on encrypted files it might
+	 * take a fair bit of work to get if the file wasn't opened recently.
+	 */
+	if ((request_mask & STATX_IOALIGN) && S_ISREG(inode->i_mode)) {
+		u32 dio_align = ext4_dio_alignment(inode);
+		unsigned int io_opt = bdev_io_opt(inode->i_sb->s_bdev);
+
+		stat->result_mask |= STATX_IOALIGN;
+		stat->mem_align_dio = dio_align;
+		stat->offset_align_dio = dio_align;
+		stat->offset_align_optimal = max(io_opt, i_blocksize(inode));
+	}
+
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 	if (flags & EXT4_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
-- 
2.35.1

