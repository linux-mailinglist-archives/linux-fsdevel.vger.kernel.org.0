Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700A57B19AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjI1LFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjI1LEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C9191;
        Thu, 28 Sep 2023 04:04:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8283AC433D9;
        Thu, 28 Sep 2023 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899074;
        bh=Cd5IZGO0KaRk0XXew6oC3te7WDw6FBiIJ+bgLrWp4AE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2+cr7Wd8m7KOd+0wU+WrRDz+Vwd6hzfolzLZux2pxW9cFO9Nlz2ViMgqkl/Y326b
         uN0A7XfZ7tXg/zIjeGrKE7UVWAcUhTff7JRUJdoy6+ytvDcgy1uWsu8xUrHbfnJ4D6
         K1QWJ9Py/9J2YPeDnlc+5FYf3dYu+irbG+3bJn8C6yCFXMjl+yq2Epq4EaTfXc2RiT
         FDSpJG9M34aNJ+tTP6nxCiANIzwFy8aSaLOmsrKNA97fnE1yfPeiUV8k/Gph1BN3fp
         +dzkRdJeERifA6LMe2YRjdL/uZOFCIGCiihdanrjBYP9inY0mrzJoho+d9kmFB7VSK
         szNeKCqRJeeNg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     autofs@vger.kernel.org
Subject: [PATCH 19/87] fs/autofs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:28 -0400
Message-ID: <20230928110413.33032-18-jlayton@kernel.org>
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
 fs/autofs/inode.c | 2 +-
 fs/autofs/root.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 2b49662ed237..9d06aa350c31 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -370,7 +370,7 @@ struct inode *autofs_get_inode(struct super_block *sb, umode_t mode)
 		inode->i_uid = d_inode(sb->s_root)->i_uid;
 		inode->i_gid = d_inode(sb->s_root)->i_gid;
 	}
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_ino = get_next_ino();
 
 	if (S_ISDIR(mode)) {
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 512b9a26c63d..530d18827e35 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -600,7 +600,7 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
 	return 0;
 }
@@ -633,7 +633,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	d_inode(dentry)->i_size = 0;
 	clear_nlink(d_inode(dentry));
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
 	spin_lock(&sbi->lookup_lock);
 	__autofs_add_expiring(dentry);
@@ -749,7 +749,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 	inc_nlink(dir);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
 	return 0;
 }
-- 
2.41.0

