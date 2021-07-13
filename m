Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC173C6F6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhGMLTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236007AbhGMLTu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7922961164;
        Tue, 13 Jul 2021 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175020;
        bh=IGcIPBfrU9vTz05WZWN9O7vJpNWnI/2fhYrQ26qOIk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClNJxURB26//KYcOScKdcTwOx5gGEJwPbI1Jhgqyq148nbFPduIKPHDt7VKLSsOjB
         Rnrg4xybOKM7mRbyYME4NsMSTjbmBDonPwb0JjRHKKCutJkemaMngfW9lww0LWSBGT
         McGm+djCenFsbgVNivUaB8BHbBO3Gbkh9Bj3FQtW9NZmlqwGMZ2/WauAy1u+4MFSGk
         3wht3RN5fREWFO2oJ5UsIphD1ikSLtHxh4lFj+JxBYMutEw1xtWzC42u8y0coU2x9Y
         VXbPSORP3KW9oJnJkHlIsgflbm3GTXvpkZF/Mjw2RciJaFJ7sRmVHR/G8Plwl3pysB
         d0tji47B0+InQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 20/24] btrfs/ioctl: allow idmapped BTRFS_IOC_SUBVOL_SETFLAGS ioctl
Date:   Tue, 13 Jul 2021 13:13:40 +0200
Message-Id: <20210713111344.1149376-21-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; h=from:subject; bh=irNrT5eadikahzn34PylxHzj5xyGUZNo1PJgzI9Ke6o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY3Z/qbNMGmKddCSZwfWf9eKShaOeXb0qm98IrNHRJVN iKRKRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESsExgZ7m3PKRL+zcS/pOrXUt6F7c XPQr9e3c27z8nvhXHucv3XGowMR3R9S96uiy179tkjavK0Va4Hfp3ofiqut/HRzTtu+2OuMwAA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Setting flags on subvolumes or snapshots are core features of btrfs. The
BTRFS_IOC_SUBVOL_SETFLAGS ioctl is especially important as it allows to make
subvolumes and snapshots read-only or read-write. Allow setting flags on btrfs
subvolumes and snapshots on idmapped mounts. This is a fairly straightforward
operation since all the permission checking helpers are already capable of
handling idmapped mounts. So we just need to pass down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9e6c9dfae981..8c1ca9f05f4f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1981,7 +1981,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	u64 flags;
 	int ret = 0;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(file_mnt_user_ns(file), inode))
 		return -EPERM;
 
 	ret = mnt_want_write_file(file);
-- 
2.30.2

