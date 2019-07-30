Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D661E7B354
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 21:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbfG3T33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 15:29:29 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42193 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfG3T32 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:29:28 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MPp0l-1hgDjO0Qap-00MtFU; Tue, 30 Jul 2019 21:27:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH v5 04/29] do_vfs_ioctl(): use saner types
Date:   Tue, 30 Jul 2019 21:25:15 +0200
Message-Id: <20190730192552.4014288-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730192552.4014288-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MCta0RGgf01015SH24OTPHqteqHOO6itXkDD7QX+UrLmioMGiDF
 HsY/l7URD7XE5tpeJJYg93oLECrl1DqOEPQ+klC6eTXg/1hLA/wq8MaxniK0LSh7oxOIaTD
 KLAYGoosvsfjWtewjouxLTs0W2fsnHaZ+6FwPwEHi5NScFngc/pwhe152slTd2DREgnGoCc
 mRvqNg42XWJZ6ePXxDz1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QT1LidRZpKY=:0YxiP35xtkAKrc4fvbEh/7
 MAQc01UIw8htdvjMtA2MEU8YpOsAx3GPjSmtPNLy93XMBV7ZkU47/YZZKh2HNjWs7q521fC31
 NgDK8+GZDcNW4keJ7RvsAZph+KeZrpKQFyy5XsJ9G/2hvPJSfj3GZvrVkyskXRY4r5JklIjmo
 FpW23co6D3mfLBQQNAvXdUI4FBYo9Q/rm2Ikl3VY0ihJ8LhEwUatKTeV7g4rTKgtUo+QzPnq0
 LpUt+qLuzp+3MNKhkZp5yEHR3u7796trclWyCfE8gZIHlQtqJE2M6jpwSivf1UjwClmXX97uO
 1L+oJWsGsxmK2N3uIOGLg9dFiwv+dKMPaULFmovLRsubcet9GmewSKRcmJRcW7O3XLYqULtjS
 Ymyy9CM+ugBPQ4hdfdbYSJpWipJCx30p6sfXUObAAEFvwZKvOJa3urleeFHRFlT20N2VMA1Z/
 rTiEqN8uuEt1bMxKhk3+PKox55LtfxrJwldZq3wd5luCXibDX6vDPMpTRaWXtCY/P+MXkujxZ
 VfWtRsgPeSETQi7cFKud9hx8PnsML/xforbYOvWFtLuYh3YPPxnUfbvFWKdYgT+sGVpPIwoMd
 /ITZl67R8uh1WGZpDOYub2Kc9lYA+NTWagd1uORKVEFU2QQdhLa2wqLGOLTfx8UCx0brzj+jG
 ynyfr59FTYlW0vHOlRLU94oIo6fAKlfe/Z51Qzo4RnopydnpzagD1aQ54D+96hEiKRHo8+lJ5
 S9ZDdrzCan1rDPRCQAqiQSxoe3DC3LZ1E3qxeA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

casting to pointer to int, only to pass that to function that
takes pointer to void and uses it as pointer to structure is
really asking for trouble.

"Some pointer, I'm not sure what to" is spelled "void *",
not "int *"; use that.

And declare the functions we are passing that pointer to
as taking the pointer to what they really want to access.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ioctl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index fef3a6bf7c78..3f28b39f32f3 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -174,10 +174,9 @@ static int fiemap_check_ranges(struct super_block *sb,
 	return 0;
 }
 
-static int ioctl_fiemap(struct file *filp, unsigned long arg)
+static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 {
 	struct fiemap fiemap;
-	struct fiemap __user *ufiemap = (struct fiemap __user *) arg;
 	struct fiemap_extent_info fieinfo = { 0, };
 	struct inode *inode = file_inode(filp);
 	struct super_block *sb = inode->i_sb;
@@ -244,7 +243,8 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 	return ret;
 }
 
-static long ioctl_file_clone_range(struct file *file, void __user *argp)
+static long ioctl_file_clone_range(struct file *file,
+				   struct file_clone_range __user *argp)
 {
 	struct file_clone_range args;
 
@@ -584,9 +584,9 @@ static int ioctl_fsthaw(struct file *filp)
 	return thaw_super(sb);
 }
 
-static int ioctl_file_dedupe_range(struct file *file, void __user *arg)
+static int ioctl_file_dedupe_range(struct file *file,
+				   struct file_dedupe_range __user *argp)
 {
-	struct file_dedupe_range __user *argp = arg;
 	struct file_dedupe_range *same = NULL;
 	int ret;
 	unsigned long size;
@@ -635,7 +635,7 @@ int do_vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd,
 	     unsigned long arg)
 {
 	int error = 0;
-	int __user *argp = (int __user *)arg;
+	void __user *argp = (void __user *)arg;
 	struct inode *inode = file_inode(filp);
 
 	switch (cmd) {
@@ -674,13 +674,13 @@ int do_vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd,
 		break;
 
 	case FS_IOC_FIEMAP:
-		return ioctl_fiemap(filp, arg);
+		return ioctl_fiemap(filp, argp);
 
 	case FIGETBSZ:
 		/* anon_bdev filesystems may not have a block size */
 		if (!inode->i_sb->s_blocksize)
 			return -EINVAL;
-		return put_user(inode->i_sb->s_blocksize, argp);
+		return put_user(inode->i_sb->s_blocksize, (int __user *)argp);
 
 	case FICLONE:
 		return ioctl_file_clone(filp, arg, 0, 0, 0);
-- 
2.20.0

