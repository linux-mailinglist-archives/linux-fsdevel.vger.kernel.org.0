Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8CD8DF3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 22:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfHNUqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 16:46:09 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44517 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfHNUqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:46:04 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1McXwD-1iYj0E0IkX-00d0se; Wed, 14 Aug 2019 22:45:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        yangerkun <yangerkun@huawei.com>, Jan Kara <jack@suse.cz>,
        Wang Shilong <wshilong@ddn.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Eric Biggers <ebiggers@google.com>, ecryptfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: [PATCH v5 04/18] fs: compat_ioctl: move FITRIM emulation into file systems
Date:   Wed, 14 Aug 2019 22:42:31 +0200
Message-Id: <20190814204259.120942-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190814204259.120942-1-arnd@arndb.de>
References: <20190814204259.120942-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:z3dV4EMHHVTIqB6irmOt7mALlth6pUBx39cxp1q/MXyyb5my9TD
 Ei9tu/20oLbXQdeGubAGFUglD7gSy7sRkwU20qqoaC5wM3V/cZvdLqBCQqcct//zQrEBTpY
 PgotaPI/UqE9QOt6pD+oJC4mYA33c2x1Cmk05o5y4PekAgaxo/Ot1QZSZphz0pO284DyXEV
 DWM5bnpXU7W9zHwvWm6+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qJAN7Jtr+50=:Hn6FCDiPj6NPOBPlxdGPcD
 u/sYhAF03jaoyRBk1JTzPSJhVA6sz1jenvAB2hCYhY8rJaynQ1wNziuco+p8X1rl9Kp67cMlD
 1KGuR6lzD1ZizOXIPdQ4gceT+kxjp8IdGN7ZrpkS0gKq9MoqQi3B0PxS5ThXI0Ng2kg6OLgdw
 j63zI6RZs2sN2dyRoehSpkkplSL3gjKQ0ehTyzU4LRVfqWnqjCX3UVgTgPTMZc8mfZmVMthy8
 cANIHtG1l+urhmm4NAoZd6sPkIeYchZlep67j9X/ZJ2+NNctF1pMbqGirTbZuMTPDtqAmCGhM
 OJ3oW67vdkpUTnkySAOptMGqDCEuDkcVM7GWrRCs/sWNmrmxIuoRZh4uN5zlnY+iZh8soANqG
 U4MZd09RCFAlvrtX/5sWC17n9SnT4LwmejHRG8lW6W/Q4cKOSEdsZSOsu93ymdZinsB5vTfuW
 E28Jz9wFCu5Lw4QArUqwVjq5OYs0Cwrsx572RE2TgpMNPCg2vyehiqTcJ5RtlVG2yJW8IG5kH
 +BqVGr47E8eINr6zbAHdgUVVu/MREg9NCspFJfr/kBeroTLhDyhys0jz/ewjHdYOY78CoFamB
 Er8mGksHdLDynfrxBPfQGKoypEd2p1tUAebqYCMwga+G6h9oScx/lOvsvxPbWr8rBG+/9EJtl
 gGAZjlTxh6MhDvFAH+dCwH4+fMDRQDlQ8lxqtUxTCBJ4VdpHcV+rzDKHjAz4Vflex8v/o40te
 v8sereCDav9jt6NTEZnegE8b/RzQevTpcA27uQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the special case for FITRIM, and make file systems
handle that like all other ioctl commands with their own
handlers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c  | 2 --
 fs/ecryptfs/file.c | 1 +
 fs/ext4/ioctl.c    | 1 +
 fs/f2fs/file.c     | 1 +
 fs/hpfs/dir.c      | 1 +
 fs/hpfs/file.c     | 1 +
 fs/nilfs2/ioctl.c  | 1 +
 fs/ocfs2/ioctl.c   | 1 +
 8 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 1e740f4406d3..b20228c19ccd 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -345,8 +345,6 @@ static int ppp_scompress(struct file *file, unsigned int cmd,
 static unsigned int ioctl_pointer[] = {
 /* Little t */
 COMPATIBLE_IOCTL(TIOCOUTQ)
-/* 'X' - originally XFS but some now in the VFS */
-COMPATIBLE_IOCTL(FITRIM)
 #ifdef CONFIG_BLOCK
 /* Big S */
 COMPATIBLE_IOCTL(SCSI_IOCTL_GET_IDLUN)
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index feecb57defa7..5fb45d865ce5 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -378,6 +378,7 @@ ecryptfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return rc;
 
 	switch (cmd) {
+	case FITRIM:
 	case FS_IOC32_GETFLAGS:
 	case FS_IOC32_SETFLAGS:
 	case FS_IOC32_GETVERSION:
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 442f7ef873fc..7a6e0f0f69e2 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1227,6 +1227,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 	case EXT4_IOC_MOVE_EXT:
 	case EXT4_IOC_RESIZE_FS:
+	case FITRIM:
 	case EXT4_IOC_PRECACHE_EXTENTS:
 	case EXT4_IOC_SET_ENCRYPTION_POLICY:
 	case EXT4_IOC_GET_ENCRYPTION_PWSALT:
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3e58a6f697dd..befd2692160c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3216,6 +3216,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_RELEASE_VOLATILE_WRITE:
 	case F2FS_IOC_ABORT_VOLATILE_WRITE:
 	case F2FS_IOC_SHUTDOWN:
+	case FITRIM:
 	case F2FS_IOC_SET_ENCRYPTION_POLICY:
 	case F2FS_IOC_GET_ENCRYPTION_PWSALT:
 	case F2FS_IOC_GET_ENCRYPTION_POLICY:
diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index d85230c84ef2..f32f15669996 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -325,4 +325,5 @@ const struct file_operations hpfs_dir_ops =
 	.release	= hpfs_dir_release,
 	.fsync		= hpfs_file_fsync,
 	.unlocked_ioctl	= hpfs_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 };
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 1ecec124e76f..b36abf9cb345 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -215,6 +215,7 @@ const struct file_operations hpfs_file_ops =
 	.fsync		= hpfs_file_fsync,
 	.splice_read	= generic_file_splice_read,
 	.unlocked_ioctl	= hpfs_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 };
 
 const struct inode_operations hpfs_file_iops =
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 91b9dac6b2cc..4ba73dbf3e8d 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -1354,6 +1354,7 @@ long nilfs_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case NILFS_IOCTL_SYNC:
 	case NILFS_IOCTL_RESIZE:
 	case NILFS_IOCTL_SET_ALLOC_RANGE:
+	case FITRIM:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index d6f7b299eb23..2d517b5ec6ac 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -985,6 +985,7 @@ long ocfs2_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 			return -EFAULT;
 
 		return ocfs2_info_handle(inode, &info, 1);
+	case FITRIM:
 	case OCFS2_IOC_MOVE_EXT:
 		break;
 	default:
-- 
2.20.0

