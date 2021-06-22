Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6700B3B03EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhFVMOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:14:04 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41477 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhFVMOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:14:02 -0400
Received: from orion.localdomain ([95.117.21.172]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MtObA-1l8WRN3rP4-00uo1g; Tue, 22 Jun 2021 14:11:44 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [RFC PATCH 4/6] fs: btrfs: move fstrim to file_operation
Date:   Tue, 22 Jun 2021 14:11:34 +0200
Message-Id: <20210622121136.4394-5-info@metux.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210622121136.4394-1-info@metux.net>
References: <20210622121136.4394-1-info@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zVN2wKiDZWP2F68MHqOzD6D/ZquxGtkP1hotOCymlAPBDZVdZBm
 kLf8knmNeQDZesF6g8j+ls8vo8JSBqlI4IKVVmfJGGIe5tSx0ejOoiaeqbsDh9xLQWsXkvK
 Axwn5PZE8TI8kL+7c53ftAs/7P6SDQeBX83ecQO9cPeIV64nWBYAm651gZ83dLgwb+3Nmti
 jN+4BDlHI0LdoyOab2xNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:76kdDUMj3Es=:m+G1rn5Uqpoif0qMJpFP69
 RXooziSyLPG/0bhI08bKOTpzN/HGyL3hmqsariU3N2Wj7/0ObrqlWU8A3bhJfv40y/+zSbEXJ
 xA/B4TLRg/J0ZzwP9B0yz6BFa2ivagWXTmQ5Jbbc20P7ezXtxG2W03+iPfkkthJk5FsMJN2Qq
 yrlmULcyrFXWn482U3pONGrqbIV13H8H+sjmF7hqzTX+HKmWKZFJAFtJ0SNIt4i7bjykFV94d
 jbftSxWrldWaCJ4Wj8CP8LhgRpsYDYL9gp/AfD18zpqavANQjRld88AZ0nQrVtqu6x71/iX+a
 rcDmJr5g5o2rNfsnZ29UFF5LHziiOS+uLG76JP6CzGsIngEqNNhN3xDTK480cAfcSRENV3RWJ
 JiDnNWk8v4KwhpVgPDUNJv0ArzTPMNLaaltBv1HgZoAGNhV4BY9rktpiO1u23EN34BmWXMX9c
 7/UaDjYCIy4pj1vSZ+O0VXrPORBQTrUguebZpl4tLh6TxTy30Ezw19J7wz4q9HtoQou7XaCCd
 FDAFS1bj5ITGivK+pkdadI=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the newly introduced file_operation callback for FITRIM ioctl.
This removes some common code, eg. permission check, buffer copying,
which is now done by generic vfs code.
---
 fs/btrfs/ctree.h |  1 +
 fs/btrfs/inode.c |  1 +
 fs/btrfs/ioctl.c | 26 +++++++-------------------
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9fb76829a281..0361d95fe690 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3206,6 +3206,7 @@ void btrfs_update_inode_bytes(struct btrfs_inode *inode,
 
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+long btrfs_ioctl_fitrim(struct file *file, struct fstrim_range *range);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int btrfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int btrfs_fileattr_set(struct user_namespace *mnt_userns,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 46f392943f4d..5f0d1032c890 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10640,6 +10640,7 @@ static const struct file_operations btrfs_dir_file_operations = {
 #endif
 	.release        = btrfs_release_file,
 	.fsync		= btrfs_sync_file,
+	.fitrim		= btrfs_ioctl_fitrim,
 };
 
 /*
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5dc2fd843ae3..38b1de381836 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -372,19 +372,16 @@ static int btrfs_ioctl_getversion(struct file *file, int __user *arg)
 	return put_user(inode->i_generation, arg);
 }
 
-static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
-					void __user *arg)
+long btrfs_ioctl_fitrim(struct file *file, struct fstrim_range *range)
 {
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_device *device;
 	struct request_queue *q;
-	struct fstrim_range range;
 	u64 minlen = ULLONG_MAX;
 	u64 num_devices = 0;
 	int ret;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
 	/*
 	 * btrfs_trim_block_group() depends on space cache, which is not
 	 * available in zoned filesystem. So, disallow fitrim on a zoned
@@ -419,26 +416,19 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 
 	if (!num_devices)
 		return -EOPNOTSUPP;
-	if (copy_from_user(&range, arg, sizeof(range)))
-		return -EFAULT;
 
 	/*
 	 * NOTE: Don't truncate the range using super->total_bytes.  Bytenr of
 	 * block group is in the logical address space, which can be any
 	 * sectorsize aligned bytenr in  the range [0, U64_MAX].
 	 */
-	if (range.len < fs_info->sb->s_blocksize)
+	if (range->len < fs_info->sb->s_blocksize)
 		return -EINVAL;
 
-	range.minlen = max(range.minlen, minlen);
-	ret = btrfs_trim_fs(fs_info, &range);
-	if (ret < 0)
-		return ret;
-
-	if (copy_to_user(arg, &range, sizeof(range)))
-		return -EFAULT;
+	range->minlen = max(range->minlen, minlen);
+	ret = btrfs_trim_fs(fs_info, range);
 
-	return 0;
+	return ret;
 }
 
 int __pure btrfs_is_empty_uuid(u8 *uuid)
@@ -4796,8 +4786,6 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_fslabel(fs_info, argp);
 	case FS_IOC_SETFSLABEL:
 		return btrfs_ioctl_set_fslabel(file, argp);
-	case FITRIM:
-		return btrfs_ioctl_fitrim(fs_info, argp);
 	case BTRFS_IOC_SNAP_CREATE:
 		return btrfs_ioctl_snap_create(file, argp, 0);
 	case BTRFS_IOC_SNAP_CREATE_V2:
-- 
2.20.1

