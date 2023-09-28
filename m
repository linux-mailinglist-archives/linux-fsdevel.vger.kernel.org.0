Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2207B1A23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjI1LJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjI1LIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:08:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F81FE1;
        Thu, 28 Sep 2023 04:05:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F6CC433C8;
        Thu, 28 Sep 2023 11:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899124;
        bh=s7WS+LV0JB5TQ52AQtIz8N34W96nGx+AXxe0soX68xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oF1zJItQf+rLBIzreOD0dJy4IIIPXRjAWa3T8dpvvNiVblS7j8VMBuOEuHGsZaEU/
         p6R/9HdZgyROZKkkM2vCUlGce3oETFYGLJXxjBKtoeHbL3ZjrHK+MFOw/FflddKB3I
         dswDue1cOa2SyGYyMsj1uPEWdztszY1qstS6bTMJjYui+hwoFgRPXfFbChtz3kAWAh
         wFYvAyabav2a6UN4OpbdwaoHr7ZxbMLzgR8s2kuxzfQSC5/PKERxxaPZ1dVAIs1nsK
         hupdg5UR5C0ZvbK/r5XH3kyY2eRYIfpNY1gLxmLxmL0uN/25yc5sRTTmLKS+XQU0PQ
         MsBO9P8MVSKxg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-unionfs@vger.kernel.org
Subject: [PATCH 59/87] fs/overlayfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:08 -0400
Message-ID: <20230928110413.33032-58-jlayton@kernel.org>
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
 fs/overlayfs/file.c  | 9 ++++++---
 fs/overlayfs/inode.c | 3 ++-
 fs/overlayfs/util.c  | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 693971d20280..9b4f5b011e4f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -239,6 +239,7 @@ static void ovl_file_accessed(struct file *file)
 {
 	struct inode *inode, *upperinode;
 	struct timespec64 ctime, uctime;
+	struct timespec64 mtime, umtime;
 
 	if (file->f_flags & O_NOATIME)
 		return;
@@ -251,9 +252,11 @@ static void ovl_file_accessed(struct file *file)
 
 	ctime = inode_get_ctime(inode);
 	uctime = inode_get_ctime(upperinode);
-	if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
-	     !timespec64_equal(&ctime, &uctime))) {
-		inode->i_mtime = upperinode->i_mtime;
+	mtime = inode_get_mtime(inode);
+	umtime = inode_get_mtime(upperinode);
+	if ((!timespec64_equal(&mtime, &umtime)) ||
+	     !timespec64_equal(&ctime, &uctime)) {
+		inode_set_mtime_to_ts(inode, inode_get_mtime(upperinode));
 		inode_set_ctime_to_ts(inode, uctime);
 	}
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 83ef66644c21..b6e98a7d36ce 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -704,7 +704,8 @@ int ovl_update_time(struct inode *inode, int flags)
 
 		if (upperpath.dentry) {
 			touch_atime(&upperpath);
-			inode->i_atime = d_inode(upperpath.dentry)->i_atime;
+			inode_set_atime_to_ts(inode,
+					      inode_get_atime(d_inode(upperpath.dentry)));
 		}
 	}
 	return 0;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 89e0d60d35b6..868afd8834c3 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1409,8 +1409,8 @@ void ovl_copyattr(struct inode *inode)
 	inode->i_uid = vfsuid_into_kuid(vfsuid);
 	inode->i_gid = vfsgid_into_kgid(vfsgid);
 	inode->i_mode = realinode->i_mode;
-	inode->i_atime = realinode->i_atime;
-	inode->i_mtime = realinode->i_mtime;
+	inode_set_atime_to_ts(inode, inode_get_atime(realinode));
+	inode_set_mtime_to_ts(inode, inode_get_mtime(realinode));
 	inode_set_ctime_to_ts(inode, inode_get_ctime(realinode));
 	i_size_write(inode, i_size_read(realinode));
 }
-- 
2.41.0

