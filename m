Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C86708055
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjERLti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 07:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjERLtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 07:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1162118;
        Thu, 18 May 2023 04:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB40A64EDC;
        Thu, 18 May 2023 11:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4D1C433EF;
        Thu, 18 May 2023 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684410490;
        bh=5rxAU8gdxN1ANNzaz9AdhjVNTPRoenRpbGIWMsQfU4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVgA9C24n1V/7bjWNt/MFHa2FAnb+8uX24YF0bfaqI+n2uU86gaNNLvnJvTPy2h0u
         mzmMNL4mC7Iv7AvqfwHIA9G9ibv96tTkXSQCog7/MUUVORddGN6N+tp6QRz7RVGvZa
         0c4rrwAy4Bl9Q+gIAGIs75p0tPNaKQvgeHqryuU+BvFHe0voa9dJD3Ox4r79+jXqzp
         E/3xSXXpUnpdfGbZWx+LUnrw6U9fuTep2qhxnuOpnZ1GCC2xnB4MaVAT5BvNzQA7oH
         ISArStV4NaqnmwgskcuEltftzmabNRP0wSvpmQ288q/XTm+8QneDSB49jf3ayM81XP
         z9Kt4JGRJ4IBg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Neil Brown <neilb@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore T'so <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH v4 9/9] btrfs: convert to multigrain timestamps
Date:   Thu, 18 May 2023 07:47:42 -0400
Message-Id: <20230518114742.128950-10-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518114742.128950-1-jlayton@kernel.org>
References: <20230518114742.128950-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/delayed-inode.c | 2 +-
 fs/btrfs/inode.c         | 2 +-
 fs/btrfs/super.c         | 5 +++--
 fs/btrfs/tree-log.c      | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6b457b010cbc..8307fd69da43 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1810,7 +1810,7 @@ static void fill_stack_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_timespec_sec(&inode_item->ctime,
 				     inode->i_ctime.tv_sec);
 	btrfs_set_stack_timespec_nsec(&inode_item->ctime,
-				      inode->i_ctime.tv_nsec);
+				      ctime_nsec_peek(inode));
 
 	btrfs_set_stack_timespec_sec(&inode_item->otime,
 				     BTRFS_I(inode)->i_otime.tv_sec);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2335b5e1cecc..b27d4dda6024 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3970,7 +3970,7 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_timespec_sec(&token, &item->ctime,
 				     inode->i_ctime.tv_sec);
 	btrfs_set_token_timespec_nsec(&token, &item->ctime,
-				      inode->i_ctime.tv_nsec);
+				      ctime_nsec_peek(inode));
 
 	btrfs_set_token_timespec_sec(&token, &item->otime,
 				     BTRFS_I(inode)->i_otime.tv_sec);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ec18e2210602..fc6abf8b1f42 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2144,7 +2144,7 @@ static struct file_system_type btrfs_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_MULTIGRAIN_TS,
 };
 
 static struct file_system_type btrfs_root_fs_type = {
@@ -2152,7 +2152,8 @@ static struct file_system_type btrfs_root_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
+			  FS_ALLOW_IDMAP | FS_MULTIGRAIN_TS,
 };
 
 MODULE_ALIAS_FS("btrfs");
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9b212e8c70cc..9a4d1b2ab204 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4150,7 +4150,7 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_timespec_sec(&token, &item->ctime,
 				     inode->i_ctime.tv_sec);
 	btrfs_set_token_timespec_nsec(&token, &item->ctime,
-				      inode->i_ctime.tv_nsec);
+				      ctime_nsec_peek(inode));
 
 	/*
 	 * We do not need to set the nbytes field, in fact during a fast fsync
-- 
2.40.1

