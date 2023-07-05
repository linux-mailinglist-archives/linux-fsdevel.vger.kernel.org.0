Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C8748D14
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjGETGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjGETFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:05:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E852709;
        Wed,  5 Jul 2023 12:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9062616C4;
        Wed,  5 Jul 2023 19:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC62C433C8;
        Wed,  5 Jul 2023 19:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583850;
        bh=drNbTch4MFALaAjIb0HJv1jQX0IS4DSN9KjY5vGKrAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTZ/kFDNnI/Q6Nnc34HxC0VQoYl3zKC53va1kTdUOoKojmOoKUesyDkj6ouWjcOtI
         0gUwxaA1JhO3R/Y9Z37Kz2eaLuN2OAKZxD/1gnOpT9+sTwL0oO91GR5FxC+/cYLBrq
         CrC5ozhtoNq9y2bUf3uhRcHTw34CtkUS2tVrSvNUW6pPPQxmW82waJY4frYpdAN8PX
         AcaM5AAxI+JqFd4dTebrgPUmDqtcERFteRq2GId1n65B7XxKbFnVAOtwhQUHVSSnqM
         +nxbzXjZX2a6JctMRh4Cw/pXqAo9VrTmqBv5YZdytZjTSqtoej4pEjmQBbApJIocru
         FYni8LeZ11A3A==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 39/92] erofs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:04 -0400
Message-ID: <20230705190309.579783-37-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
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

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Acked-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/erofs/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d70b12b81507..806374d866d1 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -105,8 +105,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		set_nlink(inode, le32_to_cpu(die->i_nlink));
 
 		/* extended inode has its own timestamp */
-		inode->i_ctime.tv_sec = le64_to_cpu(die->i_mtime);
-		inode->i_ctime.tv_nsec = le32_to_cpu(die->i_mtime_nsec);
+		inode_set_ctime(inode, le64_to_cpu(die->i_mtime),
+				le32_to_cpu(die->i_mtime_nsec));
 
 		inode->i_size = le64_to_cpu(die->i_size);
 
@@ -148,8 +148,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		set_nlink(inode, le16_to_cpu(dic->i_nlink));
 
 		/* use build time for compact inodes */
-		inode->i_ctime.tv_sec = sbi->build_time;
-		inode->i_ctime.tv_nsec = sbi->build_time_nsec;
+		inode_set_ctime(inode, sbi->build_time, sbi->build_time_nsec);
 
 		inode->i_size = le32_to_cpu(dic->i_size);
 		if (erofs_inode_is_data_compressed(vi->datalayout))
@@ -176,10 +175,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		vi->chunkbits = sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	inode->i_mtime.tv_sec = inode->i_ctime.tv_sec;
-	inode->i_atime.tv_sec = inode->i_ctime.tv_sec;
-	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec;
-	inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec;
+	inode->i_mtime.tv_sec = inode_get_ctime(inode).tv_sec;
+	inode->i_atime.tv_sec = inode_get_ctime(inode).tv_sec;
+	inode->i_mtime.tv_nsec = inode_get_ctime(inode).tv_nsec;
+	inode->i_atime.tv_nsec = inode_get_ctime(inode).tv_nsec;
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
-- 
2.41.0

