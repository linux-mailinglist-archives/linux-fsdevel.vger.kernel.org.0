Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268CE54EACC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 22:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378549AbiFPUSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 16:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378359AbiFPUST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:18:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD334BAC;
        Thu, 16 Jun 2022 13:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D5AC61DBA;
        Thu, 16 Jun 2022 20:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970CAC341C7;
        Thu, 16 Jun 2022 20:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655410696;
        bh=wpwosW4eHH6Fw12lkcoZt/x92SHG+lIGe2xLCvF09SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyhPvWCMjg7XHUuUrxvjwwn1koaM3dckK7kdu1HDuQ83/GRZqVB1pqSig3j5pHm1m
         p1SEOMtlf0guG7E2cTO7jRMBqq6IpBOZERCH/DEvvqbksyYXaQ+xPGI46IxdZZwZqu
         CNHEcBXTaW72MB6mkFHZ7Ji60TOzsvajBTHnn43NR8yLDkYFVTlLnf9L5QysgZruYg
         tP6E1s24gwws7wZ2KKjX/RasU2C+6rMAmgXKySfQwVgel4ixHguQWC/CorB9E9M+6e
         IQZ6HeHWEBzfwYlAuSHtPwENvrTai7yfRuzk0DzfX3vPxpiAXlGDoQWelEtoG/Fuzk
         vpyLEYinDsP6A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 4/8] ext4: support STATX_DIOALIGN
Date:   Thu, 16 Jun 2022 13:15:02 -0700
Message-Id: <20220616201506.124209-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616201506.124209-1-ebiggers@kernel.org>
References: <20220616201506.124209-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add support for STATX_DIOALIGN to ext4, so that direct I/O alignment
restrictions are exposed to userspace in a generic way.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/file.c  | 15 ++++-----------
 fs/ext4/inode.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75b8d81b24692..68e964394e917 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2968,6 +2968,7 @@ extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 extern int  ext4_write_inode(struct inode *, struct writeback_control *);
 extern int  ext4_setattr(struct user_namespace *, struct dentry *,
 			 struct iattr *);
+extern u32  ext4_dio_alignment(struct inode *inode);
 extern int  ext4_getattr(struct user_namespace *, const struct path *,
 			 struct kstat *, u32, unsigned int);
 extern void ext4_evict_inode(struct inode *);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 26d7426208970..ecede6b01b7f0 100644
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
index 3dce7d058985b..78180c98f3847 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5536,6 +5536,22 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
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
@@ -5551,6 +5567,19 @@ int ext4_getattr(struct user_namespace *mnt_userns, const struct path *path,
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
+		stat->dio_mem_align = dio_align;
+		stat->dio_offset_align = dio_align;
+	}
+
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 	if (flags & EXT4_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
-- 
2.36.1

