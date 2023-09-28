Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A297B19BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjI1LFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjI1LEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8F21B4;
        Thu, 28 Sep 2023 04:04:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFD9C433C9;
        Thu, 28 Sep 2023 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899081;
        bh=+GMC4PjnNkP7Yi4b9udX8bXyU16DKLRsXZYo4cptrO8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ht1vnVyW/c4zmL5Lt42VSykPHnoEj7AdgEUYbSusR7nMwwPloOhdvyU9DLfeH/wWj
         GBU8OrrwrxxKHRFysO1RJ8Ijd95p6WQ8qW2Rn6gLZt8VhWBpscsIFYXkCZF6gCnNyC
         XndQPDS6+tlc+g/G8taFL4EXoYYy0sHFFUOMni0CvoiF5rUw4rSpYep627g4pkj1s7
         aMC3FEuUXL/nd3ZKT9PJIXETA0kmVzmzeOstP5Cp0wKTqYsOlwkZBiG7aJgMiQlWCA
         cynEX+MtFsns6fmP0I4EaqftzPr3Me5CZLzyB7a72FlBMoihhcEtm5ZM8wmu07qsb+
         SVuXNU0+JcA0Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/87] fs/configfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:34 -0400
Message-ID: <20230928110413.33032-24-jlayton@kernel.org>
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
 fs/configfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index fbdcb3582926..dcc22f593e43 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -88,7 +88,7 @@ int configfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 static inline void set_default_inode_attr(struct inode * inode, umode_t mode)
 {
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 }
 
 static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
@@ -96,8 +96,8 @@ static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
 	inode->i_mode = iattr->ia_mode;
 	inode->i_uid = iattr->ia_uid;
 	inode->i_gid = iattr->ia_gid;
-	inode->i_atime = iattr->ia_atime;
-	inode->i_mtime = iattr->ia_mtime;
+	inode_set_atime_to_ts(inode, iattr->ia_atime);
+	inode_set_mtime_to_ts(inode, iattr->ia_mtime);
 	inode_set_ctime_to_ts(inode, iattr->ia_ctime);
 }
 
@@ -171,7 +171,7 @@ struct inode *configfs_create(struct dentry *dentry, umode_t mode)
 		return ERR_PTR(-ENOMEM);
 
 	p_inode = d_inode(dentry->d_parent);
-	p_inode->i_mtime = inode_set_ctime_current(p_inode);
+	inode_set_mtime_to_ts(p_inode, inode_set_ctime_current(p_inode));
 	configfs_set_inode_lock_class(sd, inode);
 	return inode;
 }
-- 
2.41.0

