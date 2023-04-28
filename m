Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDC06F2170
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 01:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347086AbjD1X5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 19:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347077AbjD1X5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD071213C
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 16:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B3E163D5A
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 23:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89AEC4339E;
        Fri, 28 Apr 2023 23:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682726251;
        bh=fopvhTmvStaaaW9Fq0s5+eQXa7o4Pgy8eptPT1y3dhk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Qwn2VcRZWrhKv4LI03YhovQ5G/vlHEV7/RXLKgsDY/sBe12SSd2feMc3OEMbpsJBF
         XTOtVh4V02p25lcMQbl/6MJcg6qOWAqIi8iCwA+7X71D8wALf6ZCRLUfJ+BaZyOhhx
         AC+CUdvUmnt4sFmLfa65rqw2Z6/ywatury4n5D3EK/MryIW5M45g6OODopKmyQlkKy
         oUIWsLSRLn84QZiu8koRn+oDduLgR6AMLIdvWbptEp7bHwYTd1N3YZ4XaNivGMwfxy
         +6QtEYbEx1M5JHrYp5EY4117OZazNjRXQUKkBZa6B1/2O0mA+IZDhaqDpcNBzxljN1
         OOKMoEfWhFNdQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Sat, 29 Apr 2023 01:57:20 +0200
Subject: [PATCH v3 3/4] fs: use a for loop when locking a mount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v3-3-377893f74bc8@kernel.org>
References: <20230202-fs-move-mount-replace-v3-0-377893f74bc8@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v3-0-377893f74bc8@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2238; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fopvhTmvStaaaW9Fq0s5+eQXa7o4Pgy8eptPT1y3dhk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT4xKZyHV1Waqfa9SOaw+/cP0edeEV33olcjclzhQKkrx3Q
 tp7UUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEHQYwML6bK+99duXtLnVjWladyga
 fv6+3YqutepGIz8TPbik0HMhn+6TcfNIqY5n380vpLcQ6nFxtte/vks+Zsw1+HA1XZXrvP4wYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v3:
- Remove unused assignment to @mnt.
---
 fs/namespace.c | 49 ++++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 89297744ccf8..11157d0abe8f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2318,30 +2318,37 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 static struct mountpoint *lock_mount(struct path *path)
 {
 	struct vfsmount *mnt;
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
-		return mp;
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
 	}
-	namespace_unlock();
-	inode_unlock(path->dentry->d_inode);
-	path_put(path);
-	path->mnt = mnt;
-	dentry = path->dentry = dget(mnt->mnt_root);
-	goto retry;
+
+	mp = get_mountpoint(dentry);
+	if (IS_ERR(mp)) {
+		namespace_unlock();
+		inode_unlock(dentry->d_inode);
+	}
+
+	return mp;
 }
 
 static void unlock_mount(struct mountpoint *where)

-- 
2.34.1

