Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A034B1E67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 07:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbiBKGNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 01:13:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344649AbiBKGN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:13:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE0025CC;
        Thu, 10 Feb 2022 22:13:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27AC4618D9;
        Fri, 11 Feb 2022 06:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE1CC340EF;
        Fri, 11 Feb 2022 06:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644560009;
        bh=vhM6qsL6M2MiDMhTx+WrvUJcU5c9VPUqlvPhmVlMB+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlhToVCVIAu6n0s9QL9NidGb0US62yeO8QvDLndGbWocnvKOkVBeOZuQ5yHenv3LL
         DBYF3OePtkqa862dgWcAbI/b5X9MV2PY3CMwiZJl8wBFksXv4AElpu3UYxMU3b4nRF
         eXYn3sLmzQB14zD0C+laCyVS0VlcbiV/7FvH1YV2lM7vMOlQwR+nfbgxjjd78IzHoQ
         2afo3yCNI5o2kyfZVZVVO/8jauLSpxjNGq7vYCHGBiPIQAQpmW6gnIOIn7dPTRWFz2
         8AWX/2+i1prF/Rv8Pv/PtTuoXA4iKpCZ5nXKBFOJ3z+2WCVo8ucAQjfsHFmF1X1PHm
         6vvOESB5FFmng==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] f2fs: simplify f2fs_force_buffered_io()
Date:   Thu, 10 Feb 2022 22:11:57 -0800
Message-Id: <20220211061158.227688-7-ebiggers@kernel.org>
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

f2fs only allows direct I/O that is aligned to the filesystem block
size.  Given that fact, simplify f2fs_force_buffered_io() by removing
the redundant call to block_unaligned_IO().

This makes it easier to reuse this code for STATX_IOALIGN.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 61ff0fc16e160..9cc985258f17e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -807,19 +807,7 @@ int f2fs_truncate(struct inode *inode)
 	return 0;
 }
 
-static int block_unaligned_IO(struct inode *inode, struct kiocb *iocb,
-			      struct iov_iter *iter)
-{
-	unsigned int i_blkbits = READ_ONCE(inode->i_blkbits);
-	unsigned int blocksize_mask = (1 << i_blkbits) - 1;
-	loff_t offset = iocb->ki_pos;
-	unsigned long align = offset | iov_iter_alignment(iter);
-
-	return align & blocksize_mask;
-}
-
-static inline bool f2fs_force_buffered_io(struct inode *inode,
-				struct kiocb *iocb, struct iov_iter *iter)
+static bool f2fs_force_buffered_io(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
@@ -839,12 +827,8 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	 */
 	if (f2fs_sb_has_blkzoned(sbi))
 		return true;
-	if (f2fs_lfs_mode(sbi)) {
-		if (block_unaligned_IO(inode, iocb, iter))
-			return true;
-		if (F2FS_IO_ALIGNED(sbi))
-			return true;
-	}
+	if (f2fs_lfs_mode(sbi) && F2FS_IO_ALIGNED(sbi))
+		return true;
 	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))
 		return true;
 
@@ -4280,7 +4264,7 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return false;
 
-	if (f2fs_force_buffered_io(inode, iocb, iter))
+	if (f2fs_force_buffered_io(inode))
 		return false;
 
 	/*
-- 
2.35.1

