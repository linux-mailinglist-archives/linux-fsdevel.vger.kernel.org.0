Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2537B8D23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbjJDTBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245229AbjJDS7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:59:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0281FFD;
        Wed,  4 Oct 2023 11:55:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFB6C433CD;
        Wed,  4 Oct 2023 18:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445727;
        bh=MoIiW0tMHURG7cJf6w6ln0tYlsyoiEpsfqWIhLoofRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPqhVdWskSIIpfDDjPHzSCqQNZIl417YlCoBc9LPz5sjsfGqE07PJZOhE6sbqYP2X
         0U1dSNp6FcjR7IOU1yow1ION3UjDnESIbSQDkdDpWksH/8zYMZcB3idwbfTAzC0HXB
         /qVg/1XnBw320D6Hhx0qh2KItlWeJkAItTSMRcgeDL9uG/CHgx4Ckr4D4rAbL+jDlv
         QwK/9vxexr4tqB/vjwaQtmI63IBMlRihiEOuGgDK0Y/BnD4ubIzD95kSWb57EJGSzJ
         nPT6UIVKEBcI2UHtAFu84iqq2l6M7LkuDXctHZOMs99yMKIepLnPV/675uCcQfewxu
         QIoYrlMYYkRpQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Subject: [PATCH v2 84/89] apparmor: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:53:09 -0400
Message-ID: <20231004185347.80880-82-jlayton@kernel.org>
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
 security/apparmor/apparmorfs.c    | 7 ++++---
 security/apparmor/policy_unpack.c | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index c198a8a2047b..27b0540a761c 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -226,7 +226,7 @@ static int __aafs_setup_d_inode(struct inode *dir, struct dentry *dentry,
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_private = data;
 	if (S_ISDIR(mode)) {
 		inode->i_op = iops ? iops : &simple_dir_inode_operations;
@@ -1557,7 +1557,8 @@ void __aafs_profile_migrate_dents(struct aa_profile *old,
 		if (new->dents[i]) {
 			struct inode *inode = d_inode(new->dents[i]);
 
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		}
 		old->dents[i] = NULL;
 	}
@@ -2546,7 +2547,7 @@ static int aa_mk_null_file(struct dentry *parent)
 
 	inode->i_ino = get_next_ino();
 	inode->i_mode = S_IFCHR | S_IRUGO | S_IWUGO;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO,
 			   MKDEV(MEM_MAJOR, 3));
 	d_instantiate(dentry, inode);
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 94d0f801eb49..7f0e58f3e1fc 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -89,10 +89,10 @@ void __aa_loaddata_update(struct aa_loaddata *data, long revision)
 		struct inode *inode;
 
 		inode = d_inode(data->dents[AAFS_LOADDATA_DIR]);
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 		inode = d_inode(data->dents[AAFS_LOADDATA_REVISION]);
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 }
 
-- 
2.41.0

