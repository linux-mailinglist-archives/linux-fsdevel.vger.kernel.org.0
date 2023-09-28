Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AA57B1A1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjI1LJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjI1LIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:08:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554781BF4;
        Thu, 28 Sep 2023 04:05:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3215AC433CD;
        Thu, 28 Sep 2023 11:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899120;
        bh=DJSvCuPLAD4saV0xZe/l++49VBU2Ao4YBQp420d7aJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1p1tnqkywMXIK15zqJ2FgVjNGn7haElYKat55LiJsKAEX44aY9LJroHbA3VzKLGj
         /Y6rWU8/2CJidpL3EcXTC6Xu8+XrH/os0C2pOlhFNunuxtBiyODoe7HJX3GtJyWhzc
         ikSi7r3w2rNWPJS/8i6BgDOuAFW7BZ/AsmifvnSK7N1Ju0zyi191rT03uuSHoRuV6x
         Ug/dMhpw4MIlS9jrAGXCpgZhzqNmGrGaqyuG8uTeiHP1xw2JK5iohcnV73NUzY11xd
         A2bzjwLLv+A5lAtZRymkX5iLwUrdcnw9wGxHtX4+Iix6HcvBC2Q8qKuiiVE7JG21Q+
         dh/X0w7/3+u7Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-karma-devel@lists.sourceforge.net
Subject: [PATCH 56/87] fs/omfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:05 -0400
Message-ID: <20230928110413.33032-55-jlayton@kernel.org>
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
 fs/omfs/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 2f8c1882f45c..cdcee7af34d1 100644
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

