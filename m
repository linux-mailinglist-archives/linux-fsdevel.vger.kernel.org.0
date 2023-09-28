Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CCB7B19C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjI1LF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjI1LEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2D0CD3;
        Thu, 28 Sep 2023 04:04:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384EBC433CD;
        Thu, 28 Sep 2023 11:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899086;
        bh=QLHf7zWWMBT60c6zRtT5TfN5WGtreZu5GZ/416fDY80=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S87i2JjYqc3rRTopHRdDhhFciOONkPQbMvFX5CTPDpJNE+nsOmSRpXL/rGx23ns2A
         BnUdgRDbARyYO/Xf7MPiVv7SBPf2u4qka1BV7MPb2tX+ZVVt+6d+19Iw8CcvTo7tUl
         otqTRpWI8FelcXoY3UXjg+V/uH8sce/1ZkF68xD48YiGYSiA7q2WLe8t/7KcFnzfso
         uTF+6dAHSE3dB3Iy7dO7R8GInGQUdH6LeVPtV6Wl++j88T3dkZP/+eNtyx7Qt+vWpK
         pXsl8HEKeHh0YV9UTxrVcgfXz4xrFLAa94YIWjDLs9g4XtvpUmVNryW2c/919gtkDO
         svJtjIh5BCEIg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 30/87] fs/efs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:39 -0400
Message-ID: <20230928110413.33032-29-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/efs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 3789d22ba501..7844ab24b813 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -103,10 +103,9 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	i_uid_write(inode, (uid_t)be16_to_cpu(efs_inode->di_uid));
 	i_gid_write(inode, (gid_t)be16_to_cpu(efs_inode->di_gid));
 	inode->i_size  = be32_to_cpu(efs_inode->di_size);
-	inode->i_atime.tv_sec = be32_to_cpu(efs_inode->di_atime);
-	inode->i_mtime.tv_sec = be32_to_cpu(efs_inode->di_mtime);
+	inode_set_atime(inode, be32_to_cpu(efs_inode->di_atime), 0);
+	inode_set_mtime(inode, be32_to_cpu(efs_inode->di_mtime), 0);
 	inode_set_ctime(inode, be32_to_cpu(efs_inode->di_ctime), 0);
-	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = 0;
 
 	/* this is the number of blocks in the file */
 	if (inode->i_size == 0) {
-- 
2.41.0

