Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB12360E4B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2019 02:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfGFAWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 20:22:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47700 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfGFAWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 20:22:37 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hjYTM-0006nq-Ci; Sat, 06 Jul 2019 00:22:36 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] fs/namespace.c: shift put_mountpoint() to callers of unhash_mnt()
Date:   Sat,  6 Jul 2019 01:22:32 +0100
Message-Id: <20190706002236.26113-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190706002236.26113-1-viro@ZenIV.linux.org.uk>
References: <20190706001612.GM17978@ZenIV.linux.org.uk>
 <20190706002236.26113-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

make unhash_mnt() return the mountpoint to be dropped, let callers
deal with it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 746e3fd1f430..b7059a4f07e3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -795,15 +795,17 @@ static void __touch_mnt_namespace(struct mnt_namespace *ns)
 /*
  * vfsmount lock must be held for write
  */
-static void unhash_mnt(struct mount *mnt)
+static struct mountpoint *unhash_mnt(struct mount *mnt)
 {
+	struct mountpoint *mp;
 	mnt->mnt_parent = mnt;
 	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
 	list_del_init(&mnt->mnt_child);
 	hlist_del_init_rcu(&mnt->mnt_hash);
 	hlist_del_init(&mnt->mnt_mp_list);
-	put_mountpoint(mnt->mnt_mp);
+	mp = mnt->mnt_mp;
 	mnt->mnt_mp = NULL;
+	return mp;
 }
 
 /*
@@ -813,7 +815,7 @@ static void detach_mnt(struct mount *mnt, struct path *old_path)
 {
 	old_path->dentry = mnt->mnt_mountpoint;
 	old_path->mnt = &mnt->mnt_parent->mnt;
-	unhash_mnt(mnt);
+	put_mountpoint(unhash_mnt(mnt));
 }
 
 /*
@@ -823,7 +825,7 @@ static void umount_mnt(struct mount *mnt)
 {
 	/* old mountpoint will be dropped when we can do that */
 	mnt->mnt_ex_mountpoint = mnt->mnt_mountpoint;
-	unhash_mnt(mnt);
+	put_mountpoint(unhash_mnt(mnt));
 }
 
 /*
-- 
2.11.0

