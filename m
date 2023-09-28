Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD32C7B19AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjI1LFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjI1LEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:04:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4201A126;
        Thu, 28 Sep 2023 04:04:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE23C433C7;
        Thu, 28 Sep 2023 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899072;
        bh=Iyo6HrfMYk3wC/qIL2NCNS+ijgdQoNLu5Do0CwWIXAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMX4cRe7nYlE6JP+CkqNiPN8ZwdDGJzsk9x5J3OMxOU8iOzDw1x1GxOVztk3OslgZ
         XAO5vMX3k7auNx4st+gMh/NWnzoGWHlR172/72QVzJS6H//mcSahIaW2uMlzV2/2kd
         SHznbgkcjp4DVsHyX6FzumPspz4E8rArYICuA37E1oOnL3JZZTfcZFkiduNvs2wWRR
         Ci3Qq/XLejNEVUXwhIl4ecg5M06bU7E5caGAWZ1Qyilvx94imMsDLfhBcUHyP7MYSf
         NPgeRMwd3NdULhuNxJ7x4km331u+AjPvtsu+kEDiKs/k8c6Th5DqJjTiwUnGNSzlsd
         uYg8vOjl1YQ3g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org
Subject: [PATCH 18/87] fs/afs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:27 -0400
Message-ID: <20230928110413.33032-17-jlayton@kernel.org>
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
 fs/afs/dynroot.c | 2 +-
 fs/afs/inode.c   | 8 ++++----
 fs/afs/write.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 95bcbd7654d1..4d04ef2d3ae7 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -88,7 +88,7 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
 	set_nlink(inode, 2);
 	inode->i_uid		= GLOBAL_ROOT_UID;
 	inode->i_gid		= GLOBAL_ROOT_GID;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_blocks		= 0;
 	inode->i_generation	= 0;
 
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 1c794a1896aa..78efc9719349 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -91,8 +91,8 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 
 	t = status->mtime_client;
 	inode_set_ctime_to_ts(inode, t);
-	inode->i_mtime = t;
-	inode->i_atime = t;
+	inode_set_mtime_to_ts(inode, t);
+	inode_set_atime_to_ts(inode, t);
 	inode->i_flags |= S_NOATIME;
 	inode->i_uid = make_kuid(&init_user_ns, status->owner);
 	inode->i_gid = make_kgid(&init_user_ns, status->group);
@@ -204,7 +204,7 @@ static void afs_apply_status(struct afs_operation *op,
 	}
 
 	t = status->mtime_client;
-	inode->i_mtime = t;
+	inode_set_mtime_to_ts(inode, t);
 	if (vp->update_ctime)
 		inode_set_ctime_to_ts(inode, op->ctime);
 
@@ -253,7 +253,7 @@ static void afs_apply_status(struct afs_operation *op,
 		if (change_size) {
 			afs_set_i_size(vnode, status->size);
 			inode_set_ctime_to_ts(inode, t);
-			inode->i_atime = t;
+			inode_set_atime_to_ts(inode, t);
 		}
 	}
 }
diff --git a/fs/afs/write.c b/fs/afs/write.c
index e1c45341719b..4a168781936b 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -424,7 +424,7 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 
 	op->store.write_iter = iter;
 	op->store.i_size = max(pos + size, vnode->netfs.remote_i_size);
-	op->mtime = vnode->netfs.inode.i_mtime;
+	op->mtime = inode_get_mtime(&vnode->netfs.inode);
 
 	afs_wait_for_operation(op);
 
-- 
2.41.0

