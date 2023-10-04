Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B37B8C6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245190AbjJDS7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245191AbjJDS5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:57:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B8519AE;
        Wed,  4 Oct 2023 11:55:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BC1C433CA;
        Wed,  4 Oct 2023 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445703;
        bh=/8pjuOM0Qd24x5SzFojlCX8B9Y/ANN/ymKVyByVWTeg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dSi0XigiWvrO5U9YjC4QnVjoXcIv+NwVDRdo7lo5xz8exDjb4kyMNDmx5BGqBb5T4
         U5Bl0BvUjBjPZXdQ+atsXLYt2OhorZUm7gzV7gbofDEYFRPmofhqrgBpcHHOle2KjL
         8eUTNE4sFyG/BOsV9Km1T4W2QrMWHCj3PHysmqKvdImpSQywLSNXIu8R2gB8zqA+yt
         gu/hw8qLNi4jjD6B662tBSVJQGZCmzQQjQHnMRfh/awPE4U0Jk2h4b/MQ6VJXx7ftb
         KH/4pczKTxK0P+dnaiVk6P8ZIZxk7DgC9V2E21FOA17G8Plth3XaahU1l0ZFY1iWVI
         xh3jtfcCwVz0A==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 64/89] qnx6: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:49 -0400
Message-ID: <20231004185347.80880-62-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/qnx6/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 21f90d519f1a..a286c545717f 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -558,10 +558,8 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	i_uid_write(inode, (uid_t)fs32_to_cpu(sbi, raw_inode->di_uid));
 	i_gid_write(inode, (gid_t)fs32_to_cpu(sbi, raw_inode->di_gid));
 	inode->i_size    = fs64_to_cpu(sbi, raw_inode->di_size);
-	inode->i_mtime.tv_sec   = fs32_to_cpu(sbi, raw_inode->di_mtime);
-	inode->i_mtime.tv_nsec = 0;
-	inode->i_atime.tv_sec   = fs32_to_cpu(sbi, raw_inode->di_atime);
-	inode->i_atime.tv_nsec = 0;
+	inode_set_mtime(inode, fs32_to_cpu(sbi, raw_inode->di_mtime), 0);
+	inode_set_atime(inode, fs32_to_cpu(sbi, raw_inode->di_atime), 0);
 	inode_set_ctime(inode, fs32_to_cpu(sbi, raw_inode->di_ctime), 0);
 
 	/* calc blocks based on 512 byte blocksize */
-- 
2.41.0

