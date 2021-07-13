Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3422B3C6F69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhGMLTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236007AbhGMLTr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:19:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8C686023F;
        Tue, 13 Jul 2021 11:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626175016;
        bh=44+NB6f86AP2RfHvDZDkkq75eLi+o1kIJTeLFI6zi5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mb5KSHGVsPTqszBVdwW8ljqxGVg6eEWs+a/sAH15Jv0BTc1hFuOmddhVM6+XDl3Lm
         GIW12n6mey88lTptmnp7qJwh6wpqjnY8rgPOWK6GdIAFOup/wUSE5noghb9SQ1F4QZ
         3ATYGlCe8DTSW7ECtMSifzF8tjYec0IbjdJt/se+odgK/DyqvSDoV2JJ7negIHbwQh
         UsKia6zY+xLRNQoDztWGeI3oux0ygbpIkIA6kDiiW1vEUtI8lZTuN745SQXyyxXJgE
         IMrGlkT+Sa4+Z0tWxG33Zc33UKSkX1BCRom/OBUIWSmJeYy71N6VGbVQZqrXPnSjcC
         nPfpTWwabGYGw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 19/24] btrfs/ioctl: allow idmapped BTRFS_IOC_SET_RECEIVED_SUBVOL{_32} ioctl
Date:   Tue, 13 Jul 2021 13:13:39 +0200
Message-Id: <20210713111344.1149376-20-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; h=from:subject; bh=wHvbxGMwoEzqcFYI1X1RkTCuRmJPgRfx+cBa4ag/e3A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY3RulSrO3u3XOFGPZNQfYkpafXucw4eT3l9sevlFdc3 93+bdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkySVGhiP/n9VsbPFomrH18eP7jp 0p2xsCDHWaZmfdXeQj8yVU3JuR4Vzf7QWZ1q731/QvVVuo+fu3bq/56xMX01hqrW5yiSXOZwQA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The BTRFS_IOC_SET_RECEIVED_SUBVOL{_32} are used to set information about a
received subvolume. Make it possible to set information about a received
subvolume on idmapped mounts. This is a fairly straightforward operation since
all the permission checking helpers are already capable of handling idmapped
mounts. So we just need to pass down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/btrfs/ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 586ec4af9777..9e6c9dfae981 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4464,6 +4464,7 @@ static long btrfs_ioctl_quota_rescan_wait(struct btrfs_fs_info *fs_info,
 }
 
 static long _btrfs_ioctl_set_received_subvol(struct file *file,
+					    struct user_namespace *mnt_userns,
 					    struct btrfs_ioctl_received_subvol_args *sa)
 {
 	struct inode *inode = file_inode(file);
@@ -4475,7 +4476,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	int ret = 0;
 	int received_uuid_changed;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EPERM;
 
 	ret = mnt_want_write_file(file);
@@ -4580,7 +4581,7 @@ static long btrfs_ioctl_set_received_subvol_32(struct file *file,
 	args64->rtime.nsec = args32->rtime.nsec;
 	args64->flags = args32->flags;
 
-	ret = _btrfs_ioctl_set_received_subvol(file, args64);
+	ret = _btrfs_ioctl_set_received_subvol(file, file_mnt_user_ns(file), args64);
 	if (ret)
 		goto out;
 
@@ -4614,7 +4615,7 @@ static long btrfs_ioctl_set_received_subvol(struct file *file,
 	if (IS_ERR(sa))
 		return PTR_ERR(sa);
 
-	ret = _btrfs_ioctl_set_received_subvol(file, sa);
+	ret = _btrfs_ioctl_set_received_subvol(file, file_mnt_user_ns(file), sa);
 
 	if (ret)
 		goto out;
-- 
2.30.2

