Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645A1748D90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjGETMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjGETMB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:12:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFB94693;
        Wed,  5 Jul 2023 12:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26CAB616F6;
        Wed,  5 Jul 2023 19:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E96C433C9;
        Wed,  5 Jul 2023 19:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583902;
        bh=4L4f2j1dXwzf+7ROukpRWmIKlAPq9hAU4+j8l9mv3ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FsRHi7/XSrEQ04l3pTxAs6fvpw/dr0VlD+PtIh2GXYf262SVbChPIRQx1bY2dhICw
         pDD9WuuxW+SQKrg1L6Q3Y1vymeUP4a3WCFCbUYENVT8jGPNUkNHEIWmctBbLx7p4s4
         Lle9utlMCkzLjgeZ8iT0+Hpwqgfi3nKHBWyzaQZ1YBeJ0Ch8PHnVWG/R9aE54KSuS2
         eskMgt47uhF5IU2mUVXRbwfi24bHRrZWoPKwLI4kYHMVCap3W5jUf8IgwTrMHjA2O2
         8PHdA2cOrZyL9euUcT763C8APBXZ5zj69AGX5ZkK5WpotGIpoMh6lRLeLb6uQ3iHWV
         E3qP4H2pFzomA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@lists.orangefs.org
Subject: [PATCH v2 65/92] orangefs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:30 -0400
Message-ID: <20230705190309.579783-63-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/orangefs/namei.c          | 2 +-
 fs/orangefs/orangefs-utils.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 77518e248cf7..c9dfd5c6a097 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -421,7 +421,7 @@ static int orangefs_rename(struct mnt_idmap *idmap,
 		     ret);
 
 	if (new_dentry->d_inode)
-		new_dentry->d_inode->i_ctime = current_time(new_dentry->d_inode);
+		inode_set_ctime_current(d_inode(new_dentry));
 
 	op_release(new_op);
 	return ret;
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 46b7dcff18ac..0a9fcfdf552f 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -361,11 +361,11 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	    downcall.resp.getattr.attributes.atime;
 	inode->i_mtime.tv_sec = (time64_t)new_op->
 	    downcall.resp.getattr.attributes.mtime;
-	inode->i_ctime.tv_sec = (time64_t)new_op->
-	    downcall.resp.getattr.attributes.ctime;
+	inode_set_ctime(inode,
+			(time64_t)new_op->downcall.resp.getattr.attributes.ctime,
+			0);
 	inode->i_atime.tv_nsec = 0;
 	inode->i_mtime.tv_nsec = 0;
-	inode->i_ctime.tv_nsec = 0;
 
 	/* special case: mark the root inode as sticky */
 	inode->i_mode = type | (is_root_handle(inode) ? S_ISVTX : 0) |
-- 
2.41.0

