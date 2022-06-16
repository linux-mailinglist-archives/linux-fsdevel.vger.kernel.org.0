Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7E54EAA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 22:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378336AbiFPUST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378388AbiFPUSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1650135257;
        Thu, 16 Jun 2022 13:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8CE561DB9;
        Thu, 16 Jun 2022 20:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B2AC3411F;
        Thu, 16 Jun 2022 20:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655410696;
        bh=iOxOv0QdDiqnoNfajHWkadykNw8yw6SMHWPSQ+/Z1Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XCySuz3YzYlgIHp8UL9jy8oSMx9yC+Hk6wTrq88c+IqE3hXqu0MY+j4K/xAAKTOAB
         sAbep1qh9fUb8cPkmzPaQXFgxh+7nOMstYpxFHqIhVpafDfYexM9uSN3fhdwzTOemJ
         vVKthy2fIB4Jh7ii0yur32iWQbzJuBIUYh4gNt3v2cHdnfB4jmyxfEh79bOgfZG9iS
         MwwX6yNWttTI2eKEHpQxjcfMtWiL98SiARcc+j/jzMKfzRbnNY05boFEMDVUk5YG+S
         rtMLJEhH/UUTKqs7mFfPlqVdeaqbFX2S7jZCkEZDBN+SJH0Yk7KT3G3/QA0AbK9qR/
         ASb2CbGMlBDdA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 2/8] vfs: support STATX_DIOALIGN on block devices
Date:   Thu, 16 Jun 2022 13:15:00 -0700
Message-Id: <20220616201506.124209-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616201506.124209-1-ebiggers@kernel.org>
References: <20220616201506.124209-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add support for STATX_DIOALIGN to block devices, so that direct I/O
alignment restrictions are exposed to userspace in a generic way.

Note that this breaks the tradition of stat operating only on the block
device node, not the block device itself.  However, it was felt that
doing this is preferable, in order to make the interface useful and
avoid needing separate interfaces for regular files and block devices.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/stat.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index a7930d7444830..c1ce447c1a383 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/blkdev.h>
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/errno.h>
@@ -198,6 +199,35 @@ int getname_statx_lookup_flags(int flags)
 	return lookup_flags;
 }
 
+/* Handle STATX_DIOALIGN for block devices. */
+static inline void handle_bdev_dioalign(struct path *path, u32 request_mask,
+					struct kstat *stat)
+{
+#ifdef CONFIG_BLOCK
+	struct inode *inode;
+	struct block_device *bdev;
+	unsigned int lbs;
+
+	if (likely(!(request_mask & STATX_DIOALIGN)))
+		return;
+
+	inode = d_backing_inode(path->dentry);
+	if (!S_ISBLK(inode->i_mode))
+		return;
+
+	bdev = blkdev_get_no_open(inode->i_rdev);
+	if (!bdev)
+		return;
+
+	lbs = bdev_logical_block_size(bdev);
+	stat->dio_mem_align = lbs;
+	stat->dio_offset_align = lbs;
+	stat->result_mask |= STATX_DIOALIGN;
+
+	blkdev_put_no_open(bdev);
+#endif /* CONFIG_BLOCK */
+}
+
 /**
  * vfs_statx - Get basic and extra attributes by filename
  * @dfd: A file descriptor representing the base dir for a relative filename
@@ -230,11 +260,16 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 		goto out;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
+
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
 	stat->result_mask |= STATX_MNT_ID;
+
 	if (path.mnt->mnt_root == path.dentry)
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
+
+	handle_bdev_dioalign(&path, request_mask, stat);
+
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
-- 
2.36.1

