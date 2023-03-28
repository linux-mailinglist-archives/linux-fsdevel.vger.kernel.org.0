Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6B76CC7A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjC1QNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 12:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjC1QNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:13:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A05EC75
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 09:13:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFA3CB81DA9
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 16:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7112DC4339E;
        Tue, 28 Mar 2023 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680020006;
        bh=J/D3sOYRtAJ+6OiWq9A3XYsiv7vYMO1Cg1jvDueXf/c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Kex9KElYpUZju7RJGKQy4nes+a2At15kW43Nvp85FkfgnXrU1EP9ncfw3WyR6bTxO
         UQlWHciUUqeRu8W+tsdO5A68e4faejbEp2wfJv4oPCGsjuBdXlX15C+bsydoNFaekG
         Ns1HXfBOsOxSOIj3/rAhuPUr8+3sl9d/hZJs1fAW/hSiK7zl9COMFF/5ifsF7wBvYj
         VvLetOkzdW10AlnZbFr1fN7Kir4WM4YSUapsatmYWj2jQ/o4CLFu1z+ApWJfeWxlOe
         mnc1Smjn5fNjbp1BBppUhmeRvNDXL/W1jm89NXb1Ffkv4ApBiXqGwiUJBMS9rWrYjz
         lQEoEeYcEsMeQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Mar 2023 18:13:08 +0200
Subject: [PATCH v2 3/5] fs: fix __lookup_mnt() documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v2-3-f53cd31d6392@kernel.org>
References: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=brauner@kernel.org;
 h=from:subject:message-id; bh=J/D3sOYRtAJ+6OiWq9A3XYsiv7vYMO1Cg1jvDueXf/c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQoC8nf3nVAPP/J/omH11sa29ke2r5vSlZ81sJStrvvFFYY
 vXo5paOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAinQaMDD1f+mdc7v5cw/zjyptHpv
 ImR6Y/31n8IpZvhnHShxrZhisMf6UaP71a9t6C6SRbbWGi61PGb7w28bnLfjfz18t7JQjsYAMA
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

The comment on top of __lookup_mnt() states that it finds the first
mount implying that there could be multiple mounts mounted at the same
dentry with the same parent.

This was true on old kernels where __lookup_mnt() could encounter a
stack of child mounts such that each child had the same parent mount and
was mounted at the same dentry. These were called "shadow mounts" and
were created during mount propagation. So back then if a mount @m in the
destination propagation tree already had a child mount @p mounted at
@mp then any mount @n we propagated to @m at the same @mp would be
appended after the preexisting mount @p in @mount_hashtable.

This hasn't been the case for quite a while now and I don't see an
obvious way how such mount stacks could be created in another way. And
if that's possible it would invalidate assumptions made in other parts
of the code.

So for a long time on all relevant kernels the child-parent relationship
is unique per dentry. So given a child mount @c mounted at its parent
mount @p on dentry @mp means that @c is the only child mounted on
@p at @mp. Should a mount @m be propagated to @p on @mp then @m will be
mounted on @p at @mp and the preexisting child @c will be remounted on
top of @m at @m->mnt_root.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 154569fd7343..42dc87f86f34 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -658,9 +658,16 @@ static bool legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 	return false;
 }
 
-/*
- * find the first mount at @dentry on vfsmount @mnt.
- * call under rcu_read_lock()
+/**
+ * __lookup_mnt - find child mount
+ * @mnt:	parent mount
+ * @dentry:	mountpoint
+ *
+ * If @mnt has a child mount mounted @dentry find and return it. If a
+ * mount is found it is unique, i.e., there are no shadow child mounts
+ * with @mnt as parent and mounted at @dentry.
+ *
+ * Return: The child of @mnt mounted @dentry or NULL if there is none.
  */
 struct mount *__lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
 {

-- 
2.34.1

