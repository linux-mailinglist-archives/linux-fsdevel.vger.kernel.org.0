Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77E57DAF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiGVHO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 03:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVHOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:14:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2356D951C6;
        Fri, 22 Jul 2022 00:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B431A62197;
        Fri, 22 Jul 2022 07:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89D4C36AE2;
        Fri, 22 Jul 2022 07:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658474045;
        bh=Wv2MG+nWZ7BgS6tx1h+VHggdsb2rNvjySXUohJfACk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWy5FtGJZPK1pL8pJlprmjQGKf1KCsrp6nxgeQtmwntj/VBrecmscBttAdOGFPJrt
         wpGPf/unKjmcYYazzi6V0ytKUawColKBBy2tKfJxKZpIL35siJFosKFaNsi1QrlaDT
         2g71vdhGoHRH9hMTQJUbW2qwze629xZap0hnlCgyL9JIM2Ja4PAGXV2Fr8RzOwB0Lm
         ti9Y6ZCBb3LCRZJ36Hxh/8nKEVTA2hLONdxxp3eB11eA+OTa/fsKbNW1pvNVg5Qeyx
         eRkKZtKwKAzRHw3r4HNFVCddYQsC+yd4ufpUjTQeqsEagp2NgF8PxGGWmQwOYlxOxR
         s96tl41X6jV9Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 7/9] f2fs: simplify f2fs_force_buffered_io()
Date:   Fri, 22 Jul 2022 00:12:26 -0700
Message-Id: <20220722071228.146690-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220722071228.146690-1-ebiggers@kernel.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
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
 fs/f2fs/file.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ad0212848a1ab9..1b452bb75af29e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -808,19 +808,7 @@ int f2fs_truncate(struct inode *inode)
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
 
@@ -840,12 +828,8 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
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
 
@@ -4205,7 +4189,7 @@ static bool f2fs_should_use_dio(struct inode *inode, struct kiocb *iocb,
 	if (!(iocb->ki_flags & IOCB_DIRECT))
 		return false;
 
-	if (f2fs_force_buffered_io(inode, iocb, iter))
+	if (f2fs_force_buffered_io(inode))
 		return false;
 
 	/*
-- 
2.37.0

