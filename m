Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0474A84EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 14:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350721AbiBCNOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 08:14:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55424 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350720AbiBCNOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:14:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA53761812
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Feb 2022 13:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE369C340EB;
        Thu,  3 Feb 2022 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643894089;
        bh=OUaSff9cDZ+6ABcme6URZJBJhurYNAABavUam3S21C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrcTIOHbnbcWnpAL8TP7CE3RoEGkrXTgTvMlnf5AfneQtBw1MhUQOXTGEc9CmQpzS
         aNi8ZcKWpVZZXdnHzn7TTPe7E6oISrTG6nVe/gCwYAQdNYKMx+t0A/Qc8acqgPvZLk
         X6GwMsZp0UXRKy8f5t75b+WygQByb98xSntJep8R3YQsxaHT7GAZ6UknFxYWyPCmqm
         Ni6mZFPNTBIE1wn2cDD/5gd5ihxRHgE9zCmyo3A6e1J/m9OZ2afHMP2Q4+mwgMUqvH
         QJeq9aXYUoHv3t+5kYUgcDGrux5Ne+OBdiDBNIi8QQ9z0In/KHMe4SbUZiQkh15mbY
         KcxmvsHdYtlXA==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <seth.forshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5/7] fs: simplify check in mount_setattr_commit()
Date:   Thu,  3 Feb 2022 14:14:09 +0100
Message-Id: <20220203131411.3093040-6-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203131411.3093040-1-brauner@kernel.org>
References: <20220203131411.3093040-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742; h=from:subject; bh=OUaSff9cDZ+6ABcme6URZJBJhurYNAABavUam3S21C4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST+vsq0sGv5oW2us7yLDGeWSh2cXujR/GHl5ojr1uwO0RtK /y326ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIdmdGhomHZesTJgma3otfo5erls C4M9NiUdPeL1+arqlrWoYU1DEyrG7Z5ilvlfbqw/pY7dsHFvh3n3j0SkNFqnP2oY9ziytf8QMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to determine whether we need to call mnt_unhold_writers() in
mount_setattr_commit() we currently do not just check whether
MNT_WRITE_HOLD is set but also if a read-only mount was requested.

However, checking whether MNT_WRITE_HOLD is set is enough. Setting
MNT_WRITE_HOLD requires lock_mount_hash() to be held and it must be
unset before calling unlock_mount_hash(). This guarantees that if we see
MNT_WRITE_HOLD we know that we were the ones who set it earlier. We
don't need to care about why we set it. Plus, leaving this additional
read-only check in makes the code more confusing because it implies that
MNT_WRITE_HOLD could've been set by another thread when it really can't.
Remove it and update the associated comment.

Cc: Seth Forshee <seth.forshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7e5535ed155d..ddae5c08ea8c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4096,13 +4096,8 @@ static void mount_setattr_commit(struct mount_kattr *kattr,
 			WRITE_ONCE(m->mnt.mnt_flags, flags);
 		}
 
-		/*
-		 * We either set MNT_READONLY above so make it visible
-		 * before ~MNT_WRITE_HOLD or we failed to recursively
-		 * apply mount options.
-		 */
-		if ((kattr->attr_set & MNT_READONLY) &&
-		    (m->mnt.mnt_flags & MNT_WRITE_HOLD))
+		/* If we had to hold writers unblock them. */
+		if (m->mnt.mnt_flags & MNT_WRITE_HOLD)
 			mnt_unhold_writers(m);
 
 		if (!err && kattr->propagation)
-- 
2.32.0

