Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861807B1A1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjI1LJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjI1LIV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:08:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4FB1FCA;
        Thu, 28 Sep 2023 04:05:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABD1C433CC;
        Thu, 28 Sep 2023 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899122;
        bh=E6oS2zOcODx/9WfXsAOvYmFNqLdc+m+M1LwLfi/Jt9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9RRTyXzrby0QpT7bxb6Q+L2KH2Wt1LYsrklfbCXM31yTwGk4+yO3ool/4uYXlmkL
         kZ1+zSUhnVhVphEdQC8MsWU22GfTyKcOuhmvXrXl/lWJQe355gRT15ACsAX8AWdoXi
         oWfLD2nlBQmMdQbPzH6rT6m8kRl5WxrAVskPnmPRgBHCZ2AQWLSY3Zcp1UxZVMEbSr
         wn5DK3zVACsKuciCtAFZ1nX9fVFFPPbAAZTYPyYdVE2BH+IsNSY7e77tB0yMIS+RZs
         b1wyYEgQi67n2DZV55HTat2f7SjaxjulRVLmOFkGvyfl0JYLxOJgXk6dQram9j1YpL
         MhCX38+Bd/vcA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org
Subject: [PATCH 58/87] fs/orangefs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:07 -0400
Message-ID: <20230928110413.33032-57-jlayton@kernel.org>
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
 fs/orangefs/orangefs-utils.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 0a9fcfdf552f..42cb8517cebe 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -155,14 +155,14 @@ static inline void copy_attributes_from_inode(struct inode *inode,
 	if (orangefs_inode->attr_valid & ATTR_ATIME) {
 		attrs->mask |= ORANGEFS_ATTR_SYS_ATIME;
 		if (orangefs_inode->attr_valid & ATTR_ATIME_SET) {
-			attrs->atime = (time64_t)inode->i_atime.tv_sec;
+			attrs->atime = (time64_t) inode_get_atime(inode).tv_sec;
 			attrs->mask |= ORANGEFS_ATTR_SYS_ATIME_SET;
 		}
 	}
 	if (orangefs_inode->attr_valid & ATTR_MTIME) {
 		attrs->mask |= ORANGEFS_ATTR_SYS_MTIME;
 		if (orangefs_inode->attr_valid & ATTR_MTIME_SET) {
-			attrs->mtime = (time64_t)inode->i_mtime.tv_sec;
+			attrs->mtime = (time64_t) inode_get_mtime(inode).tv_sec;
 			attrs->mask |= ORANGEFS_ATTR_SYS_MTIME_SET;
 		}
 	}
@@ -357,15 +357,15 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	    downcall.resp.getattr.attributes.owner);
 	inode->i_gid = make_kgid(&init_user_ns, new_op->
 	    downcall.resp.getattr.attributes.group);
-	inode->i_atime.tv_sec = (time64_t)new_op->
-	    downcall.resp.getattr.attributes.atime;
-	inode->i_mtime.tv_sec = (time64_t)new_op->
-	    downcall.resp.getattr.attributes.mtime;
+	inode_set_atime(inode,
+			(time64_t)new_op->downcall.resp.getattr.attributes.atime,
+			0);
+	inode_set_mtime(inode,
+			(time64_t)new_op->downcall.resp.getattr.attributes.mtime,
+			0);
 	inode_set_ctime(inode,
 			(time64_t)new_op->downcall.resp.getattr.attributes.ctime,
 			0);
-	inode->i_atime.tv_nsec = 0;
-	inode->i_mtime.tv_nsec = 0;
 
 	/* special case: mark the root inode as sticky */
 	inode->i_mode = type | (is_root_handle(inode) ? S_ISVTX : 0) |
-- 
2.41.0

