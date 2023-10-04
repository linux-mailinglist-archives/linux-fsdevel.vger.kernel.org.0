Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B854B7B8C8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245052AbjJDS6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244777AbjJDS4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:56:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7A173F;
        Wed,  4 Oct 2023 11:54:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3223C433D9;
        Wed,  4 Oct 2023 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445697;
        bh=aWVRym5iRRtjlVkeeXRoMTht51r0uneC7a5peLTKRN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kr03zbFGfkyv3NkbBQY3NOqQO4CTjEp4ImLQLOcslYbOFWZ+cWW0pFuudiQ8Pzoev
         l8mGR+l9M/90x6K2vQ5WQSSStr0IyHqJ94FJsepamie8W16xp3uK2xKoyIcczth3YY
         wAknJW6TInICa3B6GGpsYN+Z/HXsXhN56LxeXcsRl9QJpgFjvCHF5q6jlOSak/G3Wr
         XV+bWp3re3czgQZe1/Vo2GSzULNKE06clOQaWbWURqeY61JnEtpn2ADJ+LgbFSdI3b
         QpYbAl3AeU8PdcUIQS7AZ1BnTfqgtoT7fCxgmmm5imwL2IMs4Kd473XOL+cngm33jX
         1IEaN/WOWNyeQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org
Subject: [PATCH v2 59/89] orangefs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:44 -0400
Message-ID: <20231004185347.80880-57-jlayton@kernel.org>
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
 fs/orangefs/orangefs-utils.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 0a9fcfdf552f..0fdceb00ca07 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -155,14 +155,14 @@ static inline void copy_attributes_from_inode(struct inode *inode,
 	if (orangefs_inode->attr_valid & ATTR_ATIME) {
 		attrs->mask |= ORANGEFS_ATTR_SYS_ATIME;
 		if (orangefs_inode->attr_valid & ATTR_ATIME_SET) {
-			attrs->atime = (time64_t)inode->i_atime.tv_sec;
+			attrs->atime = (time64_t) inode_get_atime_sec(inode);
 			attrs->mask |= ORANGEFS_ATTR_SYS_ATIME_SET;
 		}
 	}
 	if (orangefs_inode->attr_valid & ATTR_MTIME) {
 		attrs->mask |= ORANGEFS_ATTR_SYS_MTIME;
 		if (orangefs_inode->attr_valid & ATTR_MTIME_SET) {
-			attrs->mtime = (time64_t)inode->i_mtime.tv_sec;
+			attrs->mtime = (time64_t) inode_get_mtime_sec(inode);
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

