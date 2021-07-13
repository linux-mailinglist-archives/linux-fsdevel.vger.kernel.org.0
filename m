Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0CD3C6F55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhGMLTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235933AbhGMLTW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E31A6128B;
        Tue, 13 Jul 2021 11:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174993;
        bh=kP+Gh543ESQvDnR3D/1zAbz+bWmsKpr4tN1JDFVBRA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/6OtF+WpZ0oweMfRpsVUS2Y+Wqux6sP8oY7V+6A3/nbRSd3Z8sR5eY6ViAKNo1SB
         jZwysWlmgr1YYxzClZKOKg6B9JKuQJwFXlNut2Sc33dllO8S5LoY+tFHP/RtLmbOFF
         z47UGsrRwFkWT+3/5GyAWXx71LkQeBAbvo+3P3BkSWUTlKc2dLIYLKRDDL6HHv697v
         K8IGB6XILpPBB1y8PK65f5N6W9cLaG+Jtl0236Bu587qPj9uTO7kmekky/5CUFpNhF
         PLxy9iqnGyqER+AG1RL/oMO7bd2233YsYNyTnLWkzFPvz1rAOzCPsN5Wf7gYp0IOR1
         D4vyR/hE4Kjaw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 12/24] btrfs/inode: allow idmapped tmpfile iop
Date:   Tue, 13 Jul 2021 13:13:32 +0200
Message-Id: <20210713111344.1149376-13-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; h=from:subject; bh=Fz3mRqHZ29Xsn+F984jNBMmMPDvrqIDjK1mR0iD0rzM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY3qMStQKlp9cfHns0X2xZ8clvUb5Z5he3fQ9fjLyyYp LWv2d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEjYuRYZmXkfREgaOFFdkzJz2P7d hv4ma467N/zhGZV96Pe1MnTGBkuDHB7PBL8Q9WSxhPP3jVPFHM9Why63vbBT7Ka5YltczPZQcA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_tmpfile() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9b87ac971875..a51545b351c8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10210,7 +10210,7 @@ static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	if (ret)
 		goto out;
 
-	inode = btrfs_new_inode(trans, root, &init_user_ns, dir, NULL, 0,
+	inode = btrfs_new_inode(trans, root, mnt_userns, dir, NULL, 0,
 			btrfs_ino(BTRFS_I(dir)), objectid, mode, &index);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
-- 
2.30.2

