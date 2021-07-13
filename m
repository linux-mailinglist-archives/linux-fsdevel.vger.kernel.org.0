Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5B13C6F57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbhGMLT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235722AbhGMLT0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E53DA6127C;
        Tue, 13 Jul 2021 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174996;
        bh=SB6h6B2E7YmJiJAEvUn2tP87f7ZDJwsJaTNT4YRLlTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4XLbSK2HgzXHZJfKwGRWamX1o3CqaHlBK9+/FTzCCXC2KZ8cBuBOTZXiGD8e/4ZM
         yP8IIaF8aSssdlH08FNOq5NYW8BDee4VCWkTI0VPBHkkxv/cLSIqB2nZc/HfQ1yp1a
         E3wvgS0yzL0hb9NWJnbZmmLP9L0ZHdcOS8fRjFuzBSB9Ie9KjwJXvhrSq0KHe+FvrX
         tKDM4EHo9/VyElPx1nGfGzu6vaNm4UlArdKT9j/HwtZflhJTj70Ry6fBIcodX0QBVR
         8VgOq+3X//lqP1pF9XXyx5hzTXyR7Fbef7Xr+VLsN24lwG/h2cU45jE6btM9FUJDfk
         sM5BYMkywkviQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 13/24] btrfs/inode: allow idmapped setattr iop
Date:   Tue, 13 Jul 2021 13:13:33 +0200
Message-Id: <20210713111344.1149376-14-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; h=from:subject; bh=dpUPs8T/xVYhX0/N2bAdockNjc1gy/w4bB/6qMaovT4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY1KaEx+veY1g3TY1pSrGwIdeiKW/3N7eiRJZk0j52bf 1csWd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE6z4jwxQNllfPdv+pnSi89OXdrT /lnDL8HJuuzDm6bJtyntqqUjFGhgW+PAeOCC2fvvTrzzcBO2rM5WK/yygllz2Onnv8iP71I3wA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_setattr() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a51545b351c8..8a80ef810703 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5253,7 +5253,7 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 	if (btrfs_root_readonly(root))
 		return -EROFS;
 
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(mnt_userns, dentry, attr);
 	if (err)
 		return err;
 
@@ -5264,12 +5264,12 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 	}
 
 	if (attr->ia_valid) {
-		setattr_copy(&init_user_ns, inode, attr);
+		setattr_copy(mnt_userns, inode, attr);
 		inode_inc_iversion(inode);
 		err = btrfs_dirty_inode(inode);
 
 		if (!err && attr->ia_valid & ATTR_MODE)
-			err = posix_acl_chmod(&init_user_ns, inode,
+			err = posix_acl_chmod(mnt_userns, inode,
 					      inode->i_mode);
 	}
 
-- 
2.30.2

