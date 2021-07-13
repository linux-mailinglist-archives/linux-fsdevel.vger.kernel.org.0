Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2E03C6F70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbhGMLT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235874AbhGMLT6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6339C61164;
        Tue, 13 Jul 2021 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175028;
        bh=xucsiZLTse/n/hkj2erjU2YUp6WR9DP6biFRcYtaiFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Blfvjl0bljem/InkziSEcQehbC2ZtqFwa8tXmtMOauUS57LxRwuHkKWsUpaSHyEn2
         KVim6s73AoUEv1PflgjnAGug1WL8K6g+ETJgH/oAHLsbNQNt44Ycw02yXZRnMWy3ry
         9+Z1zXcQL6HegqTYuRW6SDXeLI68r9xfikaSp/yMz0vBam/kEl58F0SVV0EbWt0rDi
         xjtJ17/faOVqfYLRLxKLJlkcTULJbgSRLcxtHmoXxISNvKDYwdvtTrrauXjyBRHrQW
         3rsr3bZrvArpuH1uKXEQP797BPAHd17Ju1V6i7gNIBGC9ujyHKsHM0D2Z3m7x2phjf
         AegG47nHGUgfA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 22/24] btrfs/acl: handle idmapped mounts
Date:   Tue, 13 Jul 2021 13:13:42 +0200
Message-Id: <20210713111344.1149376-23-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2975; h=from:subject; bh=zQsbcE/Ys3WaqckL++eThQdHVcB8JaGOiPlzOTEwyTc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY1d1HWh76XUP6vvFmtVzR8Uztm2cIXmx0KLad+XVTSv WnTtTEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE0rwZ/kcHTFCdN8c9MsaL4dLRXX dOr8osXiCwL993V9sUvl+fLk9mZDg15c1BofrJkusO//V7X7TYSmnH5eXalj8ktn6Yc3x9RycTAA==
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Make the btrfs acl code idmapped mount aware. The posix default and posix
access acls are the only acls other than some specific xattrs that take dac
permissions into account. On an idmapped mount they need to be translated
according to the mount's userns. The main change is done to __btrfs_set_acl()
which is responsible for translating posix acls to their final on-disk
representation. The btrfs_init_acl() helper does not need to take the idmapped
mount into account since it is called in the context of file creation
operations (mknod, create, mkdir, symlink, tmpfile) and is used for
btrfs_init_inode_security() to copy posix default and posix access permissions
from the parent directory. These acls need to be inherited unmodified from the
parent directory. This is identical to what we do for ext4 and xfs.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/acl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index d95eb5c8cb37..3ebf415e5211 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -53,7 +53,8 @@ struct posix_acl *btrfs_get_acl(struct inode *inode, int type)
 }
 
 static int __btrfs_set_acl(struct btrfs_trans_handle *trans,
-			 struct inode *inode, struct posix_acl *acl, int type)
+			   struct user_namespace *mnt_userns,
+			   struct inode *inode, struct posix_acl *acl, int type)
 {
 	int ret, size = 0;
 	const char *name;
@@ -88,7 +89,7 @@ static int __btrfs_set_acl(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
-		ret = posix_acl_to_xattr(&init_user_ns, acl, value, size);
+		ret = posix_acl_to_xattr(mnt_userns, acl, value, size);
 		if (ret < 0)
 			goto out;
 	}
@@ -114,12 +115,12 @@ int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	umode_t old_mode = inode->i_mode;
 
 	if (type == ACL_TYPE_ACCESS && acl) {
-		ret = posix_acl_update_mode(&init_user_ns, inode,
+		ret = posix_acl_update_mode(mnt_userns, inode,
 					    &inode->i_mode, &acl);
 		if (ret)
 			return ret;
 	}
-	ret = __btrfs_set_acl(NULL, inode, acl, type);
+	ret = __btrfs_set_acl(NULL, mnt_userns, inode, acl, type);
 	if (ret)
 		inode->i_mode = old_mode;
 	return ret;
@@ -140,14 +141,14 @@ int btrfs_init_acl(struct btrfs_trans_handle *trans,
 		return ret;
 
 	if (default_acl) {
-		ret = __btrfs_set_acl(trans, inode, default_acl,
+		ret = __btrfs_set_acl(trans, &init_user_ns, inode, default_acl,
 				      ACL_TYPE_DEFAULT);
 		posix_acl_release(default_acl);
 	}
 
 	if (acl) {
 		if (!ret)
-			ret = __btrfs_set_acl(trans, inode, acl,
+			ret = __btrfs_set_acl(trans, &init_user_ns, inode, acl,
 					      ACL_TYPE_ACCESS);
 		posix_acl_release(acl);
 	}
-- 
2.30.2

