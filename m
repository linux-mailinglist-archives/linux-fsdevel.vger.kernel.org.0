Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D426BFB57
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 16:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCRPxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 11:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjCRPxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9C037737
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 08:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D451C60EB2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 15:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB81C4339C;
        Sat, 18 Mar 2023 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679154779;
        bh=JA1I3/XcubnohHPQl0f8o09weLFAWZJvytckJIqdW0c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IsBFIQ0fdP1adr9hkAFxy+DWv4xmOv4Sfo1YhotiGXuc+zeg8wp06bsvl3/T+ovb0
         Pin2lMWM/VoMN4m+iXzuTkX5YW8ipNAzI+3308nUvgO0j+65X5F2956WVuCp8PDUem
         kfj7ScLY+VFkqleVoH856YlaXIRiP9YeKAtTam4Z4t+Ogd9dUaCNmMwsvNEei0QOIA
         DDcXpXiWTJB2gT20SW42U9nvTLhuBEyGpgth7HT9dhgSjsfy4btStwP5xEelpO46qy
         9MVn7vwW+YhaUKcUtqiqRGm0TU+x57GQcifvavbd0mpe29jQtAP9q+CgB4VzQnjx6K
         lcpb3Ztphr+sg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Sat, 18 Mar 2023 16:52:00 +0100
Subject: [PATCH RFC 4/5] fs: use a for loop when locking a mount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v1-4-9b73026d5f10@kernel.org>
References: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2233; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JA1I3/XcubnohHPQl0f8o09weLFAWZJvytckJIqdW0c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSI3gsuTk74xen440JQ++8t1Ravhc7cO7/yZekZtjOC3tfK
 Veand5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyktIWR4bCN1hyFGqMtv3IdhQKFV3
 tMmb2t6Rf34sR7VW78yyZ6L2P47/isze+x7LULco9evT+xrqHm7oTTKQKzZ1rdv2AcZu7xmREA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
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

