Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AF252C814
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 01:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiERXxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 19:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiERXxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 19:53:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D5C9D064;
        Wed, 18 May 2022 16:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D06FB80D0D;
        Wed, 18 May 2022 23:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CC5C34115;
        Wed, 18 May 2022 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652918010;
        bh=3gpH8eYoou3dU+J4Tjf9kz5T3WXmPsEc2RTNKPm5Bms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItJevShOiBn0DpXopfgMGN2yyeoJx+oDtkgTlFYL/qG4o/UbPIt0O5bKQ/rlo89xp
         eSip0ZbldHm5WXJm7c5r2O7gIxik+6N6WNthX0IbTzbteIQ/xSOgbyO/wcLk1ewuhQ
         q3ABdGQYYRhEhq5xTiqzs5pVcLYMYoG44gNOLV4biTeOMt+cSfBK79kwGHnUWxs1Ag
         nVxo3WfQ+y9xzHEFgm9bMCyLbF5YPbm5mS5IDTHMbanuAzAnoLnEiPTtNZgegxxzfI
         F+FhYwTu/AbjmZGV62hDe9n+YwzqTADmozb20jDWR3VFyvFP7b2HLUDC+b3Out6Ldq
         pMYET0MKTNtbQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [RFC PATCH v2 3/7] ext4: support STATX_IOALIGN
Date:   Wed, 18 May 2022 16:50:07 -0700
Message-Id: <20220518235011.153058-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518235011.153058-1-ebiggers@kernel.org>
References: <20220518235011.153058-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index a743b1e3b89ec..7c43428901632 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3020,6 +3020,7 @@ extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 extern int  ext4_write_inode(struct inode *, struct writeback_control *);
 extern int  ext4_setattr(struct user_namespace *, struct dentry *,
 			 struct iattr *);
+extern u32  ext4_dio_alignment(struct inode *inode);
 extern int  ext4_getattr(struct user_namespace *, const struct path *,
 			 struct kstat *, u32, unsigned int);
 extern void ext4_evict_inode(struct inode *);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index de153b508b20a..ba2271e5287b2 100644
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
index 646ece9b3455f..5af2598aa170d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5533,6 +5533,22 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
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
@@ -5548,6 +5564,21 @@ int ext4_getattr(struct user_namespace *mnt_userns, const struct path *path,
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
2.36.1

