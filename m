Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651E05A3533
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 09:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiH0HBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 03:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiH0HBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F414E8FD49;
        Sat, 27 Aug 2022 00:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ADAC610A4;
        Sat, 27 Aug 2022 07:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FB4C433B5;
        Sat, 27 Aug 2022 07:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661583692;
        bh=8UZ3nfyjvR/tlY+3mxGCVsnHwuM9TQPRtN/Xaf4/Y3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ow3GS9VpEWEwaBcfZsOmQP3mhfwpOEhyaxUiMt1sumBXKJzOjeWFbPUm+P0JSfHsg
         VtA6vPA/q4JLRxmxt2pGM5L693TcfBzdpgRm/EFZ1NZhJ6lfmYUel8pwvNZoifkQds
         JXuuBeZheUzAFx5xwRSEwfEQO8LFPmen2nLAipWnVExDTkuoBDj8j0a1B0MO0mG8SF
         xmekiN4n+XelAPcJSWJRL6/k2QglePYbdIO7cyDRxuiPHYT1b7K6GPDXEhkT1VFn56
         wEi6KFndg39w3zleKkYb/RGdzMpBQZtBoqG0/n6XWum3PyNszMiwFUD4a4geFjHMfC
         C3oDVdTYXnQ1g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v5 6/8] f2fs: simplify f2fs_force_buffered_io()
Date:   Fri, 26 Aug 2022 23:58:49 -0700
Message-Id: <20220827065851.135710-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827065851.135710-1-ebiggers@kernel.org>
References: <20220827065851.135710-1-ebiggers@kernel.org>
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

This makes it easier to reuse this code for STATX_DIOALIGN.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8a9455bf956f16..8e11311db21060 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -808,22 +808,9 @@ int f2fs_truncate(struct inode *inode)
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
-static bool f2fs_force_buffered_io(struct inode *inode,
-				   struct kiocb *iocb, struct iov_iter *iter)
+static bool f2fs_force_buffered_io(struct inode *inode, int rw)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int rw = iov_iter_rw(iter);
 
 	if (!fscrypt_dio_supported(inode))
 		return true;
@@ -836,13 +823,9 @@ static bool f2fs_force_buffered_io(struct inode *inode,
 	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
 		return true;
 
-	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
-		if (block_unaligned_IO(inode, iocb, iter))
-			return true;
-		if (F2FS_IO_ALIGNED(sbi))
-			return true;
-	}
-	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_CP_DISABLED))
+	if (f2fs_lfs_mode(sbi) && rw == WRITE && F2FS_IO_ALIGNED(sbi))
+		return true;
+	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
 		return true;
 
 	return false;
@@ -4222,7 +4205,7 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return false;
 
-	if (f2fs_force_buffered_io(inode, iocb, iter))
+	if (f2fs_force_buffered_io(inode, iov_iter_rw(iter)))
 		return false;
 
 	/*
-- 
2.37.2

