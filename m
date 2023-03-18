Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5246BFB56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Mar 2023 16:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCRPxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 11:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCRPxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBDE37718
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 08:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 583F360EB2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Mar 2023 15:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF25FC4339B;
        Sat, 18 Mar 2023 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679154777;
        bh=1nGZQw0CjH2K2mOcH3mcL/M6btaDeToe6QFtlXxjXxc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=d3OJngpw57UZIhR6NnSBwMoyInFcOo8GZHAP2kKH+lWmTPDDjaU/6uQP6c22gD0si
         C6JhDv3MyRI2s07TubDuaXuFd31BTuJU7GAiik51KZCW8+FfyrOVSiAWWyi5ilPh/X
         xEBTWanIFHUyDzZAmHGbKVwF+nAQ3DxKGiN7TmsQYZ7yQ7fT89FlfWtdVNhQJvBt3g
         2uCsGSQNYOM3HcH/Fe9pWlfAwf+0f9ZU9ctPWd3hojOWkExJLSDZ1H8Ai4GKkPrpW/
         e55aglXKCXgr5nvgPFudCi4tM+KpaczV4BQ1LEqM7OC85ZmmIQFcnlld9lemrBSOCS
         a2N+ToOAO8IIg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Sat, 18 Mar 2023 16:51:59 +0100
Subject: [PATCH RFC 3/5] fs: fix __lookup_mnt() documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v1-3-9b73026d5f10@kernel.org>
References: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1nGZQw0CjH2K2mOcH3mcL/M6btaDeToe6QFtlXxjXxc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSI3gtW3jyz3NFx//Mv+5s6J/88K56XyL3XbGrfgXlcmSJ7
 +qs+dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEL5nhD99Brdj2DZy2nk9+e4o5+f
 X187bpby9+Puvnke9/CgSz3jMyvFlw4GXG4T1sTybxN+ceCgk99+9MF8cj7Xotvdk8wWKNLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
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

