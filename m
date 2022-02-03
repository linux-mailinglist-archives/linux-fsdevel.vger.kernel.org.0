Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA414A84EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 14:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350717AbiBCNOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 08:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241853AbiBCNOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:14:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C8C061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 05:14:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F132D617FE
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 13:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A1FC340F1;
        Thu,  3 Feb 2022 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643894085;
        bh=U78bXyJT6cq6yQMpEOnCqW0QOW6BGlhwk2lyDA/GncI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lB2xlXVMPUxMHGpDtAW93QS5OKMP/FAbdBAY8lDV0OgYCJYDnOfs8tuvG1pcZNczv
         BnVwZvpYidy7j4h18k4OOb11mAb0r+ZSaaGUTeLe6drlP9ocjrzpVFOyxwGfm3dMdY
         MqkbqW7tjpnP4CcVLqHkBXYV0kRY3sK36GJ3T7r9reZruqobxh7RO8uchoMacm+bLz
         tjC/rnxVu3Qejms0JBFcZP4PImJqA7vgH8JCbOcLK9ceh8QHA12UazNKSAXx/a67z3
         IUcQXB/N5TTxxcQ7xWrM6ZdVrWqSXOJ2401ZZSTsDXXyQ9/tn3JCG9KqwjtLE6QwlR
         iVP77Kx74f0wQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 3/7] fs: add kernel doc for mnt_{hold,unhold}_writers()
Date:   Thu,  3 Feb 2022 14:14:07 +0100
Message-Id: <20220203131411.3093040-4-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203131411.3093040-1-brauner@kernel.org>
References: <20220203131411.3093040-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254; h=from:subject; bh=U78bXyJT6cq6yQMpEOnCqW0QOW6BGlhwk2lyDA/GncI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST+vsq0TSll5Y8te4M1M8xuOajPZuTu9jDNCclpf+IavKZb 7F9TRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESOWTL8FX3x6ovWvcRvcmHCrDGSy6 4dejTnd22wcVVi55mS88eezGRkuOXQnWV6tNDw1P6ybJlXimYJX09vrn5wN+Xgox9T7Ixl+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When I introduced mnt_{hold,unhold}_writers() in commit fbdc2f6c40f6
("fs: split out functions to hold writers") I did not add kernel doc for
them. Fix this and introduce proper documentation.

Fixes: commit fbdc2f6c40f6 ("fs: split out functions to hold writers")
Cc: Seth Forshee <seth.forshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 40b994a29e90..de6fae84f1a1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -469,6 +469,24 @@ void mnt_drop_write_file(struct file *file)
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
 
+/**
+ * mnt_hold_writers - prevent write access to the given mount
+ * @mnt: mnt to prevent write access to
+ *
+ * Prevents write access to @mnt if there are no active writers for @mnt.
+ * This function needs to be called and return successfully before changing
+ * properties of @mnt that need to remain stable for callers with write access
+ * to @mnt.
+ *
+ * After this functions has been called successfully callers must pair it with
+ * a call to mnt_unhold_writers() in order to stop preventing write access to
+ * @mnt.
+ *
+ * Context: This function expects lock_mount_hash() to be held serializing
+ *          setting MNT_WRITE_HOLD.
+ * Return: On success 0 is returned.
+ *	   On error, -EBUSY is returned.
+ */
 static inline int mnt_hold_writers(struct mount *mnt)
 {
 	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
@@ -500,6 +518,18 @@ static inline int mnt_hold_writers(struct mount *mnt)
 	return 0;
 }
 
+/**
+ * mnt_unhold_writers - stop preventing write access to the given mount
+ * @mnt: mnt to stop preventing write access to
+ *
+ * Stop preventing write access to @mnt allowing callers to gain write access
+ * to @mnt again.
+ *
+ * This function can only be called after a successful call to
+ * mnt_hold_writers().
+ *
+ * Context: This function expects lock_mount_hash() to be held.
+ */
 static inline void mnt_unhold_writers(struct mount *mnt)
 {
 	/*
-- 
2.32.0

