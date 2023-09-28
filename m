Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90597B1A04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjI1LIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjI1LGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:06:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F8C198B;
        Thu, 28 Sep 2023 04:05:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638B5C433CD;
        Thu, 28 Sep 2023 11:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899109;
        bh=wGHG8BLVh6e2CPi1I4Lj4sfPFEY/gG6PCDAB7nwbvck=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iDIHHesgkN0Utprud/ZhdXBjTWSRbOq0gj7mnBBsRENbVagC83R492BDAVPn6S9wA
         j9+nQcEBlIuZ0S/xXKdzsTtAoGIl8NUgT+DrlVkQJZb+xSdKw17VwZRU0o1nEWEvix
         nOUN8vYCHGfl54QENOKJ5OmEUpd/yE2MA38F6SnG+tYBapdQbCk8O/ZZWzKlhtUG+b
         q/DR5Pck2Ri+h55tKSxkYSOZWX5/lFSAzuIakCMG2kYRgdccFMeNs267KUG0nAmR3q
         OnSjwqRYLF4iUnWEFen1fAvgLAgYdjRcuk66Y8wD/RcEw6tlOE9qRTlaCjaUpASaLh
         mGacv3mwQTGLg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 48/87] fs/kernfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:57 -0400
Message-ID: <20230928110413.33032-47-jlayton@kernel.org>
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
 fs/kernfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 922719a343a7..401c084300ed 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -151,7 +151,7 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
 static inline void set_default_inode_attr(struct inode *inode, umode_t mode)
 {
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 }
 
 static inline void set_inode_attr(struct inode *inode,
@@ -159,8 +159,8 @@ static inline void set_inode_attr(struct inode *inode,
 {
 	inode->i_uid = attrs->ia_uid;
 	inode->i_gid = attrs->ia_gid;
-	inode->i_atime = attrs->ia_atime;
-	inode->i_mtime = attrs->ia_mtime;
+	inode_set_atime_to_ts(inode, attrs->ia_atime);
+	inode_set_mtime_to_ts(inode, attrs->ia_mtime);
 	inode_set_ctime_to_ts(inode, attrs->ia_ctime);
 }
 
-- 
2.41.0

