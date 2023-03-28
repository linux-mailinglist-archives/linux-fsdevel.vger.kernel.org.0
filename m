Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CF46CC7A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 18:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjC1QNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjC1QNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:13:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F202EEB53
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 09:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86FE3618AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 16:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DBFC4339B;
        Tue, 28 Mar 2023 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680020008;
        bh=oudLq702gbyUJb94CPLgBvhp6A9wh7OP8WEgrRRlxTQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kXUEL5SVYvjVPEsY77jYaPnAAgb0htEkkM/+0u1Zc8ZGbdMK5jSSeLtnG4+2QJ/yE
         /1yP/6clVEwA/n8XJhYIxy4ELdAvtCCr86ezeEizO/OU58B4LFDR6ARWjEUN9rtr/0
         Oyq8uAOpNuJZQsJC+cC0NRFzSbBidOjWclfdlob5OxsdXH03jhS+OQNknZnVo4yAZd
         +t1oWPZ06cEhcC3XZENLeWUy2jqZc0bjqWvw9n2yooyGIelHhiqMXJbEsn1Q0DeJvE
         afuleM2VdarWp2MxjWpLhGy9Fkd/JilbTrvzXkWer4Qzv5iAIDTmAZhDGlpKEyXKU8
         yZpA3n/he86Nw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Mar 2023 18:13:09 +0200
Subject: [PATCH v2 4/5] fs: use a for loop when locking a mount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v2-4-f53cd31d6392@kernel.org>
References: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oudLq702gbyUJb94CPLgBvhp6A9wh7OP8WEgrRRlxTQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQoCymUdqfXbuSOzOy8PSFrf9aytmXtk47cumv05MPDFlm+
 kw+EOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiu5Hhr4x6r6LFPb9rV59a6+RwyM
 ruqMoJ/1bl/eRy322X8P0HTjIyHFdvm113vkT19PGwCxHXhUQci469D3T3sjr/tu/NN+X7fAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, lock_mount() uses a goto to retry the lookup until it
succeeded in acquiring the namespace_lock() preventing the top mount
from being overmounted. While that's perfectly fine we want to lookup
the mountpoint on the parent of the top mount in later patches. So adapt
the code to make this easier to implement. Also, the for loop is
arguably a little cleaner and makes the code easier to follow. No
functional changes intended.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 42dc87f86f34..7f22fcfd8eab 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2308,31 +2308,39 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 
 static struct mountpoint *lock_mount(struct path *path)
 {
-	struct vfsmount *mnt;
-	struct dentry *dentry = path->dentry;
-retry:
-	inode_lock(dentry->d_inode);
-	if (unlikely(cant_mount(dentry))) {
-		inode_unlock(dentry->d_inode);
-		return ERR_PTR(-ENOENT);
-	}
-	namespace_lock();
-	mnt = lookup_mnt(path);
-	if (likely(!mnt)) {
-		struct mountpoint *mp = get_mountpoint(dentry);
-		if (IS_ERR(mp)) {
-			namespace_unlock();
+	struct vfsmount *mnt = path->mnt;
+	struct dentry *dentry;
+	struct mountpoint *mp;
+
+	for (;;) {
+		dentry = path->dentry;
+		inode_lock(dentry->d_inode);
+		if (unlikely(cant_mount(dentry))) {
 			inode_unlock(dentry->d_inode);
-			return mp;
+			return ERR_PTR(-ENOENT);
 		}
+
+		namespace_lock();
+
+		mnt = lookup_mnt(path);
+		if (likely(!mnt))
+			break;
+
+		namespace_unlock();
+		inode_unlock(dentry->d_inode);
+		path_put(path);
+		path->mnt = mnt;
+		path->dentry = dget(mnt->mnt_root);
+	}
+
+	mp = get_mountpoint(dentry);
+	if (IS_ERR(mp)) {
+		namespace_unlock();
+		inode_unlock(dentry->d_inode);
 		return mp;
 	}
-	namespace_unlock();
-	inode_unlock(path->dentry->d_inode);
-	path_put(path);
-	path->mnt = mnt;
-	dentry = path->dentry = dget(mnt->mnt_root);
-	goto retry;
+
+	return mp;
 }
 
 static void unlock_mount(struct mountpoint *where)

-- 
2.34.1

