Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE77B8BB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244670AbjJDSz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244771AbjJDSyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3121BDF;
        Wed,  4 Oct 2023 11:54:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9C2C433CC;
        Wed,  4 Oct 2023 18:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445656;
        bh=TT4KITqoqB8jSKsxQR+oCA25khBY5ch0dceuLZl/LT4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mJNDbbs6B3Xh0mYVrlNnjJWru2bJV1Mq1I2rrOwZOj7Ad6zDJGpRY/xOqBO3ax5gU
         u6vXqX6WBSrsPHEw1L/GGXLyzDLsRG7yJAwFwsYdJqZuD1ngL72MkfLWYw+RF6G0sR
         4p8HnRxTmxNiFPu+71InFc9JzhBbusg1VI/1hSPbJhjX+ZXiaeuDF9AVPOE82yyl/r
         LfQLrQzxSA3m45mKjZD0OS8+Jq+LeRdn6GcmmX45PNLHvMUPYXgo/OWWUzbPO38xQY
         ilUuLhCPusGNuZ8AhBQlkFg6ZD3GJH3gKGyEdy0uM/Z9f/TtST59uoN4PHudiV7Wd/
         1LCJwfhHZuNxA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/89] configfs: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:11 -0400
Message-ID: <20231004185347.80880-24-jlayton@kernel.org>
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

