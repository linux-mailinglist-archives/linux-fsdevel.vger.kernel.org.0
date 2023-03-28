Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41E6CC7A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 18:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjC1QNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 12:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjC1QNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:13:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F802E3A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 09:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7F5E7CE1C27
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 16:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AE2C433D2;
        Tue, 28 Mar 2023 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680020004;
        bh=gg6Xm+04eTNW6tA5oB3NAg3zpvyGDFAMW2ThjNZK8Zc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VYIHcRGU/YItRMRX/ZjP577DthSoWeMHWo4eGaewxGJ1x5onU3cvsbsb4i8oRAvs+
         jFUG5JuCkj4AxRARCi91gjAW4U5niDqTL2Ye+aSp9i4t2BzBrgLTzkgxaN3LuO43/S
         vU3t68HNIpyU/wXWwtTwkueqW5LuqOKCiO6Sj8x5Efwe/4LwooRw0hfaA/UHwV0xDW
         YjsBYJcgGE/P9sZ+56Dbo0v5k/kgTSUruiTGnzK0sHcIv3WmPL9rXTFektXHZM/B02
         GSwB4ZMikL0//Q/AV8pVH4prZgCniOa2J+TDN6wWscx/MFeKqsMswRUkbpTW6xd/2Q
         VrupJuPoVe15Q==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Mar 2023 18:13:07 +0200
Subject: [PATCH v2 2/5] pnode: pass mountpoint directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v2-2-f53cd31d6392@kernel.org>
References: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gg6Xm+04eTNW6tA5oB3NAg3zpvyGDFAMW2ThjNZK8Zc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQoC8nv89eTn6S7ecb76fypXzeoGKjIni1PTp6uESvXUW23
 bHZwRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEScnRn+qRZ5HXhgrS868ba5Z8ulg7
 Ps5ENTbfMvhCTb2lrHfF7HwMgwb2rXJkvTVZw2vP38C5ztG5fIL9iX13dilfzOz3szrgWwAAA=
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

Currently, we use a global variable to stash the destination
mountpoint. All global variables are changed in propagate_one(). The
mountpoint variable is one of the few which doesn't change after
initialization. Instead, just pass the destination mountpoint directly
making it easy to verify directly in propagate_mnt() that the
destination mountpoint never changes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
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

