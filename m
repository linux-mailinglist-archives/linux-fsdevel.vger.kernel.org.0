Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3487B8C7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbjJDS5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244988AbjJDSzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43A310C0;
        Wed,  4 Oct 2023 11:54:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A370AC433CB;
        Wed,  4 Oct 2023 18:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445695;
        bh=2GDYXuoPELo6aY4xsJQ5Xkq6BT2slz1YjAzuDRonK7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSutjIkTw5Hg9r5T40U/3rI9n7UCPNKjw944PqszHvRshw2UhWhp/frAinofO6kwh
         aFedrArjmAAgJaa3BA0OffPFtHFX3093FMslVqXeptbUsis24716lHHBafC7ynkaB2
         5F+FiSAgdAK7Ger1Kaa799u80Ramx+RfqMQP/v8vweUJLB4hlomh6yfLBvr0elPCBo
         sneCPuxSCq+tVlNSW+gN5yF8ULXpD1ldTmIEirzoqExsyobkDIo5jXE0q5KyStBtFU
         zX6X7Uvuif0YWr0Pwr2dJKe5OO3LUDj179M1mhOttEwySp4S1Awag15gKll/jFtkov
         KncqKNCf9i/6g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-karma-devel@lists.sourceforge.net
Subject: [PATCH v2 57/89] omfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:42 -0400
Message-ID: <20231004185347.80880-55-jlayton@kernel.org>
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
 fs/omfs/inode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 2f8c1882f45c..d6cd81163030 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -51,7 +51,7 @@ struct inode *omfs_new_inode(struct inode *dir, umode_t mode)
 	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
 	inode->i_mapping->a_ops = &omfs_aops;
 
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	switch (mode & S_IFMT) {
 	case S_IFDIR:
 		inode->i_op = &omfs_dir_inops;
@@ -134,8 +134,8 @@ static int __omfs_write_inode(struct inode *inode, int wait)
 	oi->i_head.h_magic = OMFS_IMAGIC;
 	oi->i_size = cpu_to_be64(inode->i_size);
 
-	ctime = inode_get_ctime(inode).tv_sec * 1000LL +
-		((inode_get_ctime(inode).tv_nsec + 999)/1000);
+	ctime = inode_get_ctime_sec(inode) * 1000LL +
+		((inode_get_ctime_nsec(inode) + 999)/1000);
 	oi->i_ctime = cpu_to_be64(ctime);
 
 	omfs_update_checksums(oi);
@@ -230,11 +230,9 @@ struct inode *omfs_iget(struct super_block *sb, ino_t ino)
 	ctime = be64_to_cpu(oi->i_ctime);
 	nsecs = do_div(ctime, 1000) * 1000L;
 
-	inode->i_atime.tv_sec = ctime;
-	inode->i_mtime.tv_sec = ctime;
+	inode_set_atime(inode, ctime, nsecs);
+	inode_set_mtime(inode, ctime, nsecs);
 	inode_set_ctime(inode, ctime, nsecs);
-	inode->i_atime.tv_nsec = nsecs;
-	inode->i_mtime.tv_nsec = nsecs;
 
 	inode->i_mapping->a_ops = &omfs_aops;
 
-- 
2.41.0

