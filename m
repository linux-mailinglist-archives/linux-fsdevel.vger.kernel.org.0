Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A79D6BFB55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 16:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCRPxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 11:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCRPxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:53:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B9F3771D
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 08:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AC07B8074C
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 15:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C944C433EF;
        Sat, 18 Mar 2023 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679154776;
        bh=tBOJy9hQB5dcPwgf+/WY2eL4fNy1FZMHVF1Xfa4LzFU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ET9NLqhzjqkXWu900HLRXw3fq3l56833kRtVESKPvsutnJrd3xBWPQ/PsRiR+qIST
         xC0y6y927NXkqn2GARaMKa8P9VV0KxesSZ+BnM5Nn/efMNcx2QSkwg2TG5tlp8/Rm4
         hLOUlX33r113kkZFkMlecYYn7UjRFC8C++GYXYDZdEUCGpG9sElGlaOB7AN8C5WhYL
         5xG6ptpPCxc+IsFkWXTUCTsGbvCX8FviyvlxXndxDUlxl0WVh4AMgRir/R//KJXNBy
         WxggBUp8kHX3neSSFCbI6gJHCJ7Ql4KOidkqIhS3E+gd1ZEKXev3gVBcQ0kYYVEN+w
         OtRbr9HsmMU2g==
From:   Christian Brauner <brauner@kernel.org>
Date:   Sat, 18 Mar 2023 16:51:58 +0100
Subject: [PATCH RFC 2/5] pnode: pass mountpoint directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v1-2-9b73026d5f10@kernel.org>
References: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2736; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tBOJy9hQB5dcPwgf+/WY2eL4fNy1FZMHVF1Xfa4LzFU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSI3gsuuGtg6Ls3suu4c9XSlhm/GrZ+X3b44Lx3j4Vya86G
 76l16ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI2kpGhqecaZs3n0+eEMe4U0nhRO
 y5D2tWFgRmLZh/efahLCXtzVcYGfZP/Hd/5WbzyRxHXj4Uviz1WC/d99WOiRnHu12LjDx+FXECAA==
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

Currently, we use a global variable to stash the destination
mountpoint. All global variables are changed in propagate_one(). The
mountpoint variable is one of the few which doesn't change after
initialization. Instead, just pass the destination mountpoint directly
making it easy to verify directly in propagate_mnt() that the
destination mountpoint never changes.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/pnode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 468e4e65a615..3cede8b18c8b 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -214,7 +214,6 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 
 /* all accesses are serialized by namespace_sem */
 static struct mount *last_dest, *first_source, *last_source, *dest_master;
-static struct mountpoint *mp;
 static struct hlist_head *list;
 
 static inline bool peers(struct mount *m1, struct mount *m2)
@@ -222,7 +221,7 @@ static inline bool peers(struct mount *m1, struct mount *m2)
 	return m1->mnt_group_id == m2->mnt_group_id && m1->mnt_group_id;
 }
 
-static int propagate_one(struct mount *m)
+static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 {
 	struct mount *child;
 	int type;
@@ -230,7 +229,7 @@ static int propagate_one(struct mount *m)
 	if (IS_MNT_NEW(m))
 		return 0;
 	/* skip if mountpoint isn't covered by it */
-	if (!is_subdir(mp->m_dentry, m->mnt.mnt_root))
+	if (!is_subdir(dest_mp->m_dentry, m->mnt.mnt_root))
 		return 0;
 	if (peers(m, last_dest)) {
 		type = CL_MAKE_SHARED;
@@ -262,7 +261,7 @@ static int propagate_one(struct mount *m)
 	if (IS_ERR(child))
 		return PTR_ERR(child);
 	read_seqlock_excl(&mount_lock);
-	mnt_set_mountpoint(m, mp, child);
+	mnt_set_mountpoint(m, dest_mp, child);
 	if (m->mnt_master != dest_master)
 		SET_MNT_MARK(m->mnt_master);
 	read_sequnlock_excl(&mount_lock);
@@ -299,13 +298,12 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 	last_dest = dest_mnt;
 	first_source = source_mnt;
 	last_source = source_mnt;
-	mp = dest_mp;
 	list = tree_list;
 	dest_master = dest_mnt->mnt_master;
 
 	/* all peers of dest_mnt, except dest_mnt itself */
 	for (n = next_peer(dest_mnt); n != dest_mnt; n = next_peer(n)) {
-		ret = propagate_one(n);
+		ret = propagate_one(n, dest_mp);
 		if (ret)
 			goto out;
 	}
@@ -316,7 +314,7 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 		/* everything in that slave group */
 		n = m;
 		do {
-			ret = propagate_one(n);
+			ret = propagate_one(n, dest_mp);
 			if (ret)
 				goto out;
 			n = next_peer(n);

-- 
2.34.1

