Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F7D7B19B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjI1LFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjI1LEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33C41A6;
        Thu, 28 Sep 2023 04:04:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333C9C433CA;
        Thu, 28 Sep 2023 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899071;
        bh=MQbRQV1pMyXoxMI32Jaeh4uSSWTp46z3JlKjNlrpA8E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RRpyQs9CXb5e0HIifUYeN4lpcynjLHWwCeXho3hyPphN9ud17Aw2+d8dBj2AgQZtg
         klXJ/li8hoho1bYLvxRehgir7nnSvErI7k7CZ2EY7ycAgaNHQxprEK5lC+fo91YDV1
         PcIt2ZwO1tfDV4GABXM57si8BWobmzqUs8qF0PkGlZQJ3rnlp6oP4LyLy+6WGDFglp
         LIBddSDDeTvxavtPQi1+Oc78XJio1cWXoFfVSVKWfTGpTqw0qQT0XR9rKCM/5GdfZQ
         eeQYYaeUXIBxzxY7+9Zpevc5DzBDtqJBm2p0vTEKohyGu9TOI62lOjATZ5HulCRtAR
         k5LMoq1/VtoGg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/87] fs/affs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:26 -0400
Message-ID: <20230928110413.33032-16-jlayton@kernel.org>
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
 fs/affs/amigaffs.c |  4 ++--
 fs/affs/inode.c    | 17 +++++++----------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/affs/amigaffs.c b/fs/affs/amigaffs.c
index 7ba93efc1143..fd669daa4e7b 100644
--- a/fs/affs/amigaffs.c
+++ b/fs/affs/amigaffs.c
@@ -60,7 +60,7 @@ affs_insert_hash(struct inode *dir, struct buffer_head *bh)
 	mark_buffer_dirty_inode(dir_bh, dir);
 	affs_brelse(dir_bh);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_inc_iversion(dir);
 	mark_inode_dirty(dir);
 
@@ -114,7 +114,7 @@ affs_remove_hash(struct inode *dir, struct buffer_head *rem_bh)
 
 	affs_brelse(bh);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_inc_iversion(dir);
 	mark_inode_dirty(dir);
 
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 060746c63151..95df8ce32d3a 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -149,13 +149,9 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 		break;
 	}
 
-	inode->i_mtime.tv_sec = inode->i_atime.tv_sec =
-		inode_set_ctime(inode,
-				(be32_to_cpu(tail->change.days) * 86400LL +
-				 be32_to_cpu(tail->change.mins) * 60 +
-				 be32_to_cpu(tail->change.ticks) / 50 + AFFS_EPOCH_DELTA)
-				+ sys_tz.tz_minuteswest * 60, 0).tv_sec;
-	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = 0;
+	inode_set_mtime(inode,
+			inode_set_atime(inode, inode_set_ctime(inode, (be32_to_cpu(tail->change.days) * 86400LL + be32_to_cpu(tail->change.mins) * 60 + be32_to_cpu(tail->change.ticks) / 50 + AFFS_EPOCH_DELTA) + sys_tz.tz_minuteswest * 60, 0).tv_sec, 0).tv_sec,
+			0);
 	affs_brelse(bh);
 	unlock_new_inode(inode);
 	return inode;
@@ -187,12 +183,13 @@ affs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	}
 	tail = AFFS_TAIL(sb, bh);
 	if (tail->stype == cpu_to_be32(ST_ROOT)) {
-		affs_secs_to_datestamp(inode->i_mtime.tv_sec,
+		affs_secs_to_datestamp(inode_get_mtime(inode).tv_sec,
 				       &AFFS_ROOT_TAIL(sb, bh)->root_change);
 	} else {
 		tail->protect = cpu_to_be32(AFFS_I(inode)->i_protect);
 		tail->size = cpu_to_be32(inode->i_size);
-		affs_secs_to_datestamp(inode->i_mtime.tv_sec, &tail->change);
+		affs_secs_to_datestamp(inode_get_mtime(inode).tv_sec,
+				       &tail->change);
 		if (!(inode->i_ino == AFFS_SB(sb)->s_root_block)) {
 			uid = i_uid_read(inode);
 			gid = i_gid_read(inode);
@@ -314,7 +311,7 @@ affs_new_inode(struct inode *dir)
 	inode->i_gid     = current_fsgid();
 	inode->i_ino     = block;
 	set_nlink(inode, 1);
-	inode->i_mtime   = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	atomic_set(&AFFS_I(inode)->i_opencnt, 0);
 	AFFS_I(inode)->i_blkcnt = 0;
 	AFFS_I(inode)->i_lc = NULL;
-- 
2.41.0

