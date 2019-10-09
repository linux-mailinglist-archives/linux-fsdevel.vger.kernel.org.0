Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1343DD1892
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbfJITPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:15:10 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731426AbfJITLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M9WiK-1iClaf0WZQ-005Zyd; Wed, 09 Oct 2019 21:11:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 04/43] do_vfs_ioctl(): use saner types
Date:   Wed,  9 Oct 2019 21:10:04 +0200
Message-Id: <20191009191044.308087-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kI1DDnTQHZLrMsrnrpathDXXJIopBYJ0O6lp1B2pRerXDWJqHn/
 wsPBCHkdQYk9Gj1skMySYJov8fvQIJjxLObPF++owo8gLEGGI7vt7Xc4mLXZzQaeZSeIdDU
 fZ2VkvXniRBx8AqZEl3jPzPDUqJDW7l3yq4/40BuiUt7Y5/Gb7FRvzW1SYAbdfYK0usEubq
 C8woHHxcu2zUTT+jCf6vw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0MvSIDJkOzQ=:/vLRKdkLf60Ox1ToTaf0lN
 7WRq0Nxmj1bbA6UUR53D5/DmUng15gn9dg47MBsoTOAymNui32gOt9oSBc0+KdJui1KKhAURi
 Wkei904HO9Ch7AMujiMiTOjb5yLP/d8Bz7lSf9eLdzfgP2IRke9z5hs+bDGtDzHgRKrLWzWeX
 zBdJsnsw/FHhCIg7JEGfIxGrGmYqS1T3t3SaaDa0bgDwo3HYu1uN5dhdSxT7vG8qMYGulPDPF
 i7zKXWrkG9w6d13ClGCoUngk5TOhh5VPelzMwyA0uM8KzKUT/2w5hE1E7yIrlMb9z+eZnfbfX
 +ZL1K5jznKp+ksiVZDamPL0CEuiov0M6+uS6MOrUEN8KIjInIfshBdEW+ejIdephWdV6w91oZ
 T28dL1+dT/0LYtmgcipTPEUjSCfBEQlgmCoo8inFDqgqm3VPLP1Dq3rnTW2Cf1PGQTcojvY9P
 SBrWhIMS3I5mYBAIyIvRylrPomvqsfO6T/aL+0DhTpffu9WLwDqnABq+8oIAdwW3qHtW6uXtk
 62Vyhoawx2qdNJlSCaFzg68BllhWIy2ERZD8dCB0YLn4j9yAam84xa/ykK37DMYqcY5Om2sBz
 clCrngegzSOfUIWap6n8z0DiCvWEV/YZblpkUIGtO7Z1tFZfN5f1yECU05OP40FS+uCLdni0Y
 Tf/kynYTpT70IXxRy/2J/ilxDZE5wkHiiNaYeAfTHoTh1+CexqHerOye+C3VAMJb0Ck6Qzrbl
 q7UFCGkdbIHxlf8FwOuaGKLt/Ni4cPdcE+z8d/A0QAvHpu6jx78BFEANtQ/WqBI7I5NICqWwt
 qd7+neyAcFuyc+4D2hgq/2z956MY0vIGiw3/Wt5VQL0lWNUdbyD1lmFshHx1oUE36ITXntKJh
 0k9sUJoCi1m2/lMGiuYA==
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

