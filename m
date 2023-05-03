Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E007C6F570E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 13:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjECLTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 07:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjECLTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 07:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A6740CF
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 04:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E565F62CDC
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 11:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D209C433D2;
        Wed,  3 May 2023 11:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683112741;
        bh=dU2qWlVSJoJw9BI89VtymHHjhkYpF/qlUyMj7z9K4e4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nfA613BnzyKSSPDMQ91kw0x34MNpP38EQRXfwPahO9wOKIHPSAeCzIfU/4hHImA4r
         rbWElFPgiQSmdbauPmPpBAU9Y6QnvMHAAZItU+R9nw7WrIgNFv/9yCbLzuVJ03Wheg
         mfeP7E2/rGTj1TfUXU0NsutWdsCm83MsBOV27Nw3/+3j3klQUAJ9/zWT1n9JeequAf
         sd1eultjIgwCh2/HYwL2QiAmqXuQ26GTUfUHaJtFCAE4ORAjvqTPyJPOg328+tF/oh
         nW8tbM6A7y9ovQOa2dAYLv7x7U/bqI8PP/REoXL/l/5y5o56vz9KdXc9y48OiDrpxV
         xqPC5dRywzKZw==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 03 May 2023 13:18:40 +0200
Subject: [PATCH v4 2/4] fs: properly document __lookup_mnt()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v4-2-98f3d80d7eaa@kernel.org>
References: <20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dU2qWlVSJoJw9BI89VtymHHjhkYpF/qlUyMj7z9K4e4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQEOStIbC25uGqtw8Igm1WbJzraNZU9rA3ZJKfoezE37PXz
 T/yOHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5tY/hf7Hqw7jbinzOUxuuZHmseh
 L5UqFFybihZwFneLm/46lfYgz/HavmsqfG/d55syss73+Izw3mku8csf82t9+b8Heb6T8TFgA=
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

The comment on top of __lookup_mnt() states that it finds the first
mount implying that there could be multiple mounts mounted at the same
dentry with the same parent.

On older kernels "shadow mounts" could be created during mount
propagation. So if a mount @m in the destination propagation tree
already had a child mount @p mounted at @mp then any mount @n we
propagated to @m at the same @mp would be appended after the preexisting
mount @p in @mount_hashtable. This was a completely direct way of
creating shadow mounts.

That direct way is gone but there are still subtle ways to create shadow
mounts. For example, when attaching a source mnt @mnt to a shared mount.
The root of the source mnt @mnt might be overmounted by a mount @o after
we finished path lookup but before we acquired the namespace semaphore
to copy the source mount tree @mnt.

After we acquired the namespace lock @mnt is copied including @o
covering it. After we attach @mnt to a shared mount @dest_mnt we end up
propagation it to all it's peer and slaves @d. If @d already has a mount
@n mounted on top of it we tuck @mnt beneath @n. This means, we mount
@mnt at @d and mount @n on @mnt. Now we have both @o and @n mounted on
the same mountpoint at @mnt.

Explain this in the documentation as this is pretty subtle.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Fix documentation for __lookup_mnt()
---
 fs/namespace.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ffa56ec633c6..89297744ccf8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -658,9 +658,25 @@ static bool legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 	return false;
 }
 
-/*
- * find the first mount at @dentry on vfsmount @mnt.
- * call under rcu_read_lock()
+/**
+ * __lookup_mnt - find first child mount
+ * @mnt:	parent mount
+ * @dentry:	mountpoint
+ *
+ * If @mnt has a child mount @c mounted @dentry find and return it.
+ *
+ * Note that the child mount @c need not be unique. There are cases
+ * where shadow mounts are created. For example, during mount
+ * propagation when a source mount @mnt whose root got overmounted by a
+ * mount @o after path lookup but before @namespace_sem could be
+ * acquired gets copied and propagated. So @mnt gets copied including
+ * @o. When @mnt is propagated to a destination mount @d that already
+ * has another mount @n mounted at the same mountpoint then the source
+ * mount @mnt will be tucked beneath @n, i.e., @n will be mounted on
+ * @mnt and @mnt mounted on @d. Now both @n and @o are mounted at @mnt
+ * on @dentry.
+ *
+ * Return: The first child of @mnt mounted @dentry or NULL.
  */
 struct mount *__lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
 {

-- 
2.34.1

