Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2A748CEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjGETFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjGETED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B16E2108;
        Wed,  5 Jul 2023 12:03:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED985616EC;
        Wed,  5 Jul 2023 19:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9794C433C9;
        Wed,  5 Jul 2023 19:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583821;
        bh=fdejnxV1LJvnaB0wtfuEm/JayRlnvFjmoK8r3gZzcgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMGB23APQBhbU0+7gU0zX57RnL7A38MYS2ehUWP9J8yXQpkFUcO4rxbyzb1VHShSF
         dGftSU9lKa7rcsoKgZMWcpzoFtTLM9s8J6l1Fg9S+P/L8cyRNCXUzrXY5kJ9kPxxXl
         Oj5hJR0YbHRfZkCKn9B1ZNBl3MOS3maUKd3o5tZUSPfwSAKmHn2cCi6TtwN7xrv7pW
         aIWukeXI7rEcYeGE2aj5f2SG4LJ9RHfhHJz5PknkGDcmM8opALwrZZ6iA8S+o3vw2+
         IHco4LdEeYd6RvlxQH48rCtcELnnPB6UWvJcvIE0d4ldQjJ4thrC3cxiLaB6QuFQ1K
         9yEiJgc91mfVw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/92] adfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:47 -0400
Message-ID: <20230705190309.579783-20-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/adfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index c3ac613d0975..20963002578a 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -270,7 +270,7 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
 	inode->i_mode	 = adfs_atts2mode(sb, inode);
 	adfs_adfs2unix_time(&inode->i_mtime, inode);
 	inode->i_atime = inode->i_mtime;
-	inode->i_ctime = inode->i_mtime;
+	inode_set_ctime_to_ts(inode, inode->i_mtime);
 
 	if (S_ISDIR(inode->i_mode)) {
 		inode->i_op	= &adfs_dir_inode_operations;
@@ -331,7 +331,7 @@ adfs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = attr->ia_atime;
 	if (ia_valid & ATTR_CTIME)
-		inode->i_ctime = attr->ia_ctime;
+		inode_set_ctime_to_ts(inode, attr->ia_ctime);
 	if (ia_valid & ATTR_MODE) {
 		ADFS_I(inode)->attr = adfs_mode2atts(sb, inode, attr->ia_mode);
 		inode->i_mode = adfs_atts2mode(sb, inode);
-- 
2.41.0

