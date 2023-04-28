Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56A26F216F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 01:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347061AbjD1X5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 19:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347074AbjD1X5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4A5213C
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 16:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D02856319B
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 23:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468EEC4339C;
        Fri, 28 Apr 2023 23:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682726250;
        bh=dU2qWlVSJoJw9BI89VtymHHjhkYpF/qlUyMj7z9K4e4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=p7Kvst3xsXVDMP6WnZIt/uh9fAdIgZV0Rgu2vk7XsTfs9JWfaLEV9hSye5UnmFIXr
         f8Qk76blHnGmvfwzJVVc0uwWFovwyeXTSP7DYN6+uL2DIh0aWk1jRgLnsbXtjzVOkF
         ryGIcxaaf1JWUmBQRw61FoAGZ9uWPH2ZtN5kDgNoi5EbVx79t/W3/zyeWVtmixJOaA
         9rL5yqYbppePOJtqXuT64UITCKhUFca1y4CpucdhghxVJrWzr7Z0naJNHLT5iQ+p39
         yJIeydci1Rucq6GzGvB6UWGRLQvJr6H+wgPS/aNPffVnIgMWf+jUUqTiGoEfbUB9P6
         95+iesVOSOHxg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Sat, 29 Apr 2023 01:57:19 +0200
Subject: [PATCH v3 2/4] fs: properly document __lookup_mnt()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-fs-move-mount-replace-v3-2-377893f74bc8@kernel.org>
References: <20230202-fs-move-mount-replace-v3-0-377893f74bc8@kernel.org>
In-Reply-To: <20230202-fs-move-mount-replace-v3-0-377893f74bc8@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dU2qWlVSJoJw9BI89VtymHHjhkYpF/qlUyMj7z9K4e4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT4xKbKbZ5Q8XDqRraQh98zZgddkDltz1WiV3L8MPNiEZcj
 bd/sOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSXsjI8LxB78GUvPmGO3kPHru6XT
 blqGS5KUdZ4s8ImY2KjgKJiQz/9J5cWDG9eNO80okrBaZqHDsw+XSN6nv7vWnrSi3OLDl4jREA
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

