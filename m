Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD5CD1841
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfJITMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:12:36 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbfJITLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:31 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mbzdn-1hfexe4BV1-00dXse; Wed, 09 Oct 2019 21:11:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        linux-nilfs@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: [PATCH v6 30/43] fs: compat_ioctl: move FITRIM emulation into file systems
Date:   Wed,  9 Oct 2019 21:10:31 +0200
Message-Id: <20191009191044.308087-31-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Yt5Qym2EiThPkdPiZuVWsOArs8kXwnMpYv8e8jcFHq6aBlEUl35
 2IN5+k0io/Ejnt6hQYqU5PeavuhijMbDbcKRb1ZxQ/6UItKgQqaET9+WeQFtRybNXL/7Evn
 QrMfvNL1I0AWYpCpt9cUDrfru1T2gMRukpp+x7ARQhmEKsY4PWg2oSrpD+oymHu2Kj+/KUc
 T+MrdQgXOJZMCEpqnSOug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7szO+vH6EQs=:V71EFPjAZtDgdRdkiMO12Q
 GDLOgoe6xabrsRpK8dss/1FbSbd0/LRu8BSTX7ftPlUZ+ZrQO/H/faHx7JJk8RieIGlFgEcTT
 EXof9rfzqoBpUY3NJs2WvGoyHioXGOJcv1Ti4timVZ1CMpKrwZubVAerQ6bQxbTMwoXlwZhPJ
 WJWhKviJJ+5ZHWTRMNkj74RwxD4yVonQ4W5VjBHlK1Oo0eblhb0poFzhDCODP46ISMsi/9YD2
 Z4V+18ywpVntd+bOeYwYzv7eX5gkuhOSj+XrBOKfyrRP+pT8nx6Ukjzvd9oHcdrcJFvC8AcvM
 TvBxzq9XsZnQzQ+IfDnHkROqfzx2gcSDKD0pN7QcP8+NDDTTDn+mTZ1jyWFe8szzoDIEf/in/
 Z5HsDqhyHAMOZrRu2p2/5NLbSZdH+gtKjTP7Bm+rsQUQtZoA5sZqPZA5Ke8MPiljJxYAjb3V+
 8tAWysmnPhzKCTGzz55hWPESGavXF+hXB1U4zToeD0cfYLJFxIXVuC8mA75CIHsiUhPaOlrM+
 S3nXh/SqKBSkahI3UkokDIAHWkeuXN0A9Ra894zoJWdvH9wNUbJsLtVGIM/fifxQThNlWYT5T
 6R1gelJX7GGYk1z8i6JQP1goaezQjXRvWLMhZVXgf04QdLYqzPCZ0deY+X6VpUqvBULcsaxWj
 j4pGbhm+vSq8rHNdmFVEWNgmvZX9otZDdg2NWWjUTy9l7RSbYel3vhdr4QBBswTCE/pvQbuiK
 haSKR+87qyJ1+499CCnOZ8trUag2y5Kb3V9ee/cpkoDhqP0imin4VTobW5LCiZIFp3Y/AbzmZ
 FtTTQ0cj7UlAaaqwms/+RToktTC6bvO2m2r1rUqodivpkKTexLJqOe/arDm2yym9T4zGxA0VQ
 +W/7eVUm3osaGfa39ACA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the special case for FITRIM, and make file systems
handle that like all other ioctl commands with their own
handlers.

Cc: linux-ext4@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-nilfs@vger.kernel.org
Cc: ocfs2-devel@oss.oracle.com
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
index 0b7f316fd30f..e8870fff8224 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1360,6 +1360,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 	case EXT4_IOC_MOVE_EXT:
 	case EXT4_IOC_RESIZE_FS:
+	case FITRIM:
 	case EXT4_IOC_PRECACHE_EXTENTS:
 	case EXT4_IOC_SET_ENCRYPTION_POLICY:
 	case EXT4_IOC_GET_ENCRYPTION_PWSALT:
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 29bc0a542759..57d82f2d2ebd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3403,6 +3403,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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

