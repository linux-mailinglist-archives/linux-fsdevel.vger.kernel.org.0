Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB47B8BDB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbjJDSzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244910AbjJDSzR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D941B1;
        Wed,  4 Oct 2023 11:54:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D32C433C7;
        Wed,  4 Oct 2023 18:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445684;
        bh=eBRJgq4pYENd3lA/W3dIxqsi+Z0ZXzS6MLhi4HYXHRk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I0bV7/jtFNVwLNCrFGhCnbya4CmI3f4uLC41x/r0r7htllVHrzHDii16a6fY8/Sxs
         NBbaAvZa0q4m75QEoBA3HfKTItSJIP66n7OZZgGYeGfo98d0zgz6xr+dzRlYoh4Oqf
         n1JrVP0yOW85NU9c6twujKqcU/yYI8+KcxQhAYsjCZR3PEuDEhox9SEwI3JnZoGrRL
         TMZoZlBjQ8wnsB2WIjsjK1GxNYG9UYVcvpwpEvv1hF9YCLpvSYllzb/fiHYVJl14I9
         ADtvyGCDRnOLWl0e1tuh5gHE8QrJBycr4Bf8jyFC4s5xd9kvqpIrIcZfAbWiI+3CSb
         +KvSNijR0BTPg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 49/89] kernfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:34 -0400
Message-ID: <20231004185347.80880-47-jlayton@kernel.org>
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

