Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73AF52C817
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 01:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiERXxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 19:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiERXxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 19:53:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C939D4CC;
        Wed, 18 May 2022 16:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC00AB8225A;
        Wed, 18 May 2022 23:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5214BC3411A;
        Wed, 18 May 2022 23:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652918010;
        bh=3sZKLjhW06TI7c+BVa7gpFBKd4C/l+SSKwcEXk2rzX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+97VEJ8HtA4dSe2xlZDFCMyTr0v0o1esE+ZYr1Pp/3lSdTk/ZbgbKv+4J7u1hl6x
         5QrX+wl3wxxdLquQmGPHKlZTFY7nDWvGKCXCly+s2EGc4OKye9LZYP3Lqac/SFXB01
         j+Ajgae21bh8oVFdB/UeGDmlM7+1tfTUwaZdFG8MPYa8RG1TW+ZTtpCAznsNq2andv
         RVJRLAjfWnBhX4V5AOj1VPin12DiFsIHBRAJx70sJMGwmxqa0j0HAH99OIcgKr8pKQ
         4s5EHa2wC/0Dz3hyZ1MsIPHYDU2eGhPOYtmOtQS/oHDEDBV1CQlS5t3m82cKI8HNd+
         To0Lakc2KzaDw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [RFC PATCH v2 4/7] f2fs: move f2fs_force_buffered_io() into file.c
Date:   Wed, 18 May 2022 16:50:08 -0700
Message-Id: <20220518235011.153058-5-ebiggers@kernel.org>
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

f2fs_force_buffered_io() is only used in file.c, so move it into there.
No behavior change.  This makes it easier to review later patches.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/f2fs.h | 45 ---------------------------------------------
 fs/f2fs/file.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 271509b1c7928..2d6492c016ad6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4442,17 +4442,6 @@ static inline void f2fs_i_compr_blocks_update(struct inode *inode,
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
-static inline int block_unaligned_IO(struct inode *inode,
-				struct kiocb *iocb, struct iov_iter *iter)
-{
-	unsigned int i_blkbits = READ_ONCE(inode->i_blkbits);
-	unsigned int blocksize_mask = (1 << i_blkbits) - 1;
-	loff_t offset = iocb->ki_pos;
-	unsigned long align = offset | iov_iter_alignment(iter);
-
-	return align & blocksize_mask;
-}
-
 static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
 								int flag)
 {
@@ -4463,40 +4452,6 @@ static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
 	return sbi->aligned_blksize;
 }
 
-static inline bool f2fs_force_buffered_io(struct inode *inode,
-				struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int rw = iov_iter_rw(iter);
-
-	if (!fscrypt_dio_supported(inode))
-		return true;
-	if (fsverity_active(inode))
-		return true;
-	if (f2fs_compressed_file(inode))
-		return true;
-
-	/* disallow direct IO if any of devices has unaligned blksize */
-	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
-		return true;
-	/*
-	 * for blkzoned device, fallback direct IO to buffered IO, so
-	 * all IOs can be serialized by log-structured write.
-	 */
-	if (f2fs_sb_has_blkzoned(sbi))
-		return true;
-	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
-		if (block_unaligned_IO(inode, iocb, iter))
-			return true;
-		if (F2FS_IO_ALIGNED(sbi))
-			return true;
-	}
-	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))
-		return true;
-
-	return false;
-}
-
 static inline bool f2fs_need_verity(const struct inode *inode, pgoff_t idx)
 {
 	return fsverity_active(inode) &&
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5b89af0f27f05..67f2e21ffbd67 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -807,6 +807,51 @@ int f2fs_truncate(struct inode *inode)
 	return 0;
 }
 
+static int block_unaligned_IO(struct inode *inode, struct kiocb *iocb,
+			      struct iov_iter *iter)
+{
+	unsigned int i_blkbits = READ_ONCE(inode->i_blkbits);
+	unsigned int blocksize_mask = (1 << i_blkbits) - 1;
+	loff_t offset = iocb->ki_pos;
+	unsigned long align = offset | iov_iter_alignment(iter);
+
+	return align & blocksize_mask;
+}
+
+static inline bool f2fs_force_buffered_io(struct inode *inode,
+				struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int rw = iov_iter_rw(iter);
+
+	if (!fscrypt_dio_supported(inode))
+		return true;
+	if (fsverity_active(inode))
+		return true;
+	if (f2fs_compressed_file(inode))
+		return true;
+
+	/* disallow direct IO if any of devices has unaligned blksize */
+	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
+		return true;
+	/*
+	 * for blkzoned device, fallback direct IO to buffered IO, so
+	 * all IOs can be serialized by log-structured write.
+	 */
+	if (f2fs_sb_has_blkzoned(sbi))
+		return true;
+	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
+		if (block_unaligned_IO(inode, iocb, iter))
+			return true;
+		if (F2FS_IO_ALIGNED(sbi))
+			return true;
+	}
+	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))
+		return true;
+
+	return false;
+}
+
 int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
-- 
2.36.1

