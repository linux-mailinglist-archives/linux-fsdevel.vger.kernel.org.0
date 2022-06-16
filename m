Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EAD54EAC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378573AbiFPUSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 16:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245332AbiFPUSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776BE3585B;
        Thu, 16 Jun 2022 13:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D963D61DBF;
        Thu, 16 Jun 2022 20:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BF7C341C6;
        Thu, 16 Jun 2022 20:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655410697;
        bh=YB3H0eP+bq4tdjh6wOG3YtQsw/WbRpJHmQN03tzgLw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G738p0TMyDWt0e6trNPG+dB0KLlBCyRwBvLqIZ8Nuyj+G49kC8lRumdjhubfT/kOr
         jeYn01pHPF87lJkZ2uk8dQ/Q3opB3khw6umyDkfkxQqBXqtVGm3sqPY4Q6P/81EO0m
         3Whtsu5ECR4LCexsZ/MQ9Jy2ii1jRqMahe+08NKepynxPyL0jDyQlvrSzQ+RJs49il
         v8QKnHRH1faFtoGDpF/X/S0P2OFkIyir8Y38fdukImFvo7DGESaWqvlY6UBq26mqdx
         5o6IEQAcK0NkhL3fXoFG3MrrbZhHm4p2dGRh2Yo+PN6f8MfeNSIKRVmNCB2m5EmMJi
         ZLYfarptileBA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 6/8] f2fs: don't allow DIO reads but not DIO writes
Date:   Thu, 16 Jun 2022 13:15:04 -0700
Message-Id: <20220616201506.124209-7-ebiggers@kernel.org>
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

Currently, if an f2fs filesystem is mounted with the mode=lfs and
io_bits mount options, DIO reads are allowed but DIO writes are not.
Allowing DIO reads but not DIO writes is an unusual restriction, which
is likely to be surprising to applications, namely any application that
both reads and writes from a file (using O_DIRECT).  This behavior is
also incompatible with the proposed STATX_DIOALIGN extension to statx.
Given this, let's drop the support for DIO reads in this configuration.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5e5c97fccfb4e..ad0212848a1ab 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -823,7 +823,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 				struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int rw = iov_iter_rw(iter);
 
 	if (!fscrypt_dio_supported(inode))
 		return true;
@@ -841,7 +840,7 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	 */
 	if (f2fs_sb_has_blkzoned(sbi))
 		return true;
-	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
+	if (f2fs_lfs_mode(sbi)) {
 		if (block_unaligned_IO(inode, iocb, iter))
 			return true;
 		if (F2FS_IO_ALIGNED(sbi))
-- 
2.36.1

