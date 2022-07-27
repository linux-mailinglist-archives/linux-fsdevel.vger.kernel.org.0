Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C73582821
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiG0OAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 10:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiG0OAS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F75926E5;
        Wed, 27 Jul 2022 07:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 289F0617AC;
        Wed, 27 Jul 2022 14:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C42C433D7;
        Wed, 27 Jul 2022 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658930416;
        bh=vaE1eWwp7aN3hqwB2SjGUb3XxCjvvJzwkTG/Qe3Ulto=;
        h=From:To:Cc:Subject:Date:From;
        b=SNj4SQQiLAJYZmSsj9UmFCNbN1cn2z4E0qnt/N6W1ev4JLQwl3+N2JaM/BS8VEUv+
         elDQj7R1ImsZZ9rET/zKlFzQHhZ6oxDjgSRYo3p0wYt1oYK9QBQfXxoj3ZmYwAh8DC
         twCSx0MgdEeZfBc/8AUp7QvUk4aKNbzRNGJxhetzFITpRA2YnFiLLOvndFQvC7WLY6
         1tys1yaM6Ohf271epBW001JdgEZKXb4mTcGmdgKSXzN8DmFxl81t83Q8nM9oQECAyT
         crzLUfh1we+vfVsJSm8SLpaCfwtJqAITSQ98QmM3hGvye+qENkhK0chk+/cx7bhwgi
         Ux25crHWLtoiA==
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Yongchen Yang <yoyang@redhat.com>
Subject: [PATCH v2] vfs: bypass may_create_in_sticky check on newly-created files if task has CAP_FOWNER
Date:   Wed, 27 Jul 2022 10:00:14 -0400
Message-Id: <20220727140014.69091-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

NFS server is exporting a sticky directory (mode 01777) with root
squashing enabled. Client has protect_regular enabled and then tries to
open a file as root in that directory. File is created (with ownership
set to nobody:nobody) but the open syscall returns an error. The problem
is may_create_in_sticky which rejects the open even though the file has
already been created.

Add a new condition to may_create_in_sticky. If the file was just
created, then allow bypassing the ownership check if the task has
CAP_FOWNER. With this change, the initial open of a file by root works,
but later opens of the same file will fail.

Note that we can contrive a similar situation by exporting with
all_squash and opening the file as an unprivileged user. This patch does
not fix that case. I suspect that that configuration is likely to be
fundamentally incompatible with the protect_* sysctls enabled on the
clients.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1976829
Reported-by: Yongchen Yang <yoyang@redhat.com>
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Hi Christian,

I left you as author here since this is basically identical to the patch
you suggested. Let me know if that's an issue.

-- Jeff

diff --git a/fs/namei.c b/fs/namei.c
index 1f28d3f463c3..26b602d1152b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1221,7 +1221,8 @@ int may_linkat(struct user_namespace *mnt_userns, struct path *link)
  * Returns 0 if the open is allowed, -ve on error.
  */
 static int may_create_in_sticky(struct user_namespace *mnt_userns,
-				struct nameidata *nd, struct inode *const inode)
+				struct nameidata *nd, struct inode *const inode,
+				bool created)
 {
 	umode_t dir_mode = nd->dir_mode;
 	kuid_t dir_uid = nd->dir_uid;
@@ -1230,7 +1231,8 @@ static int may_create_in_sticky(struct user_namespace *mnt_userns,
 	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
 	    likely(!(dir_mode & S_ISVTX)) ||
 	    uid_eq(i_uid_into_mnt(mnt_userns, inode), dir_uid) ||
-	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
+	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)) ||
+	    (created && inode_owner_or_capable(mnt_userns, inode)))
 		return 0;
 
 	if (likely(dir_mode & 0002) ||
@@ -3496,7 +3498,8 @@ static int do_open(struct nameidata *nd,
 		if (d_is_dir(nd->path.dentry))
 			return -EISDIR;
 		error = may_create_in_sticky(mnt_userns, nd,
-					     d_backing_inode(nd->path.dentry));
+					     d_backing_inode(nd->path.dentry),
+					     (file->f_mode & FMODE_CREATED));
 		if (unlikely(error))
 			return error;
 	}
-- 
2.37.1

