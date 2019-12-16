Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0612014C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 10:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfLPJiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 04:38:25 -0500
Received: from cirse-smtp-out.extra.cea.fr ([132.167.192.148]:46154 "EHLO
        cirse-smtp-out.extra.cea.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbfLPJiZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:38:25 -0500
X-Greylist: delayed 2717 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 04:38:24 EST
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
        by cirse-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP id xBG8r5tM023379
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 09:53:05 +0100
Received: from pisaure.intra.cea.fr (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 9AB83201BB3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 09:53:05 +0100 (CET)
Received: from muguet2-smtp-out.intra.cea.fr (muguet2-smtp-out.intra.cea.fr [132.166.192.13])
        by pisaure.intra.cea.fr (Postfix) with ESMTP id 8D8E1200C12
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 09:53:05 +0100 (CET)
Received: from zia.cdc.esteban.ctsi (out.dam.intra.cea.fr [132.165.76.10])
        by muguet2-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with SMTP id xBG8r5IH001227
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 09:53:05 +0100
Received: (qmail 14640 invoked from network); 16 Dec 2019 08:53:05 -0000
From:   <quentin.bouget@cea.fr>
Subject: open_by_handle_at: mount_fd opened with O_PATH
To:     <linux-fsdevel@vger.kernel.org>
CC:     MARTINET Dominique 606316 <dominique.martinet@cea.fr>,
        Andreas Dilger <adilger@whamcloud.com>,
        NeilBrown <neilb@suse.com>
Message-ID: <2759fc54-9576-aaa0-926a-cad9d09d388c@cea.fr>
Date:   Mon, 16 Dec 2019 09:53:04 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------583348C193F558D5BC17F853"
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--------------583348C193F558D5BC17F853
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I recently noticed that the syscall open_by_handle_at() automatically 
fails if
its first argument is a file descriptor opened with O_PATH. I looked at 
the code
and saw no reason this could not be allowed. Attached to this mail are a
a reproducer and the patch I came up with.

I am not quite familiar with the kernel's way of processing patches. Any 
pointer
or advice on this matter is very welcome.

Cheers,
Quentin Bouget


--------------583348C193F558D5BC17F853
Content-Type: text/x-csrc; name="reproducer.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="reproducer.c"

#define _GNU_SOURCE
#include <errno.h>
#include <error.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

int
main()
{
    struct file_handle *fhandle;
    const char *pathname = "/";
    int mount_fd;
    int mountid;
    int fd;

    fhandle = malloc(sizeof(*fhandle) + 128);
    if (fhandle == NULL)
        error(EXIT_FAILURE, errno, "malloc");
    fhandle->handle_bytes = 128;

    fd = open(pathname, O_RDONLY | O_PATH | O_NOFOLLOW);
    if (fd < 0)
        error(EXIT_FAILURE, errno, "open");

    if (name_to_handle_at(fd, "", fhandle, &mountid, AT_EMPTY_PATH))
        error(EXIT_FAILURE, errno, "name_to_handle_at");

    mount_fd = fd;
    fd = open_by_handle_at(mount_fd, fhandle, O_RDONLY | O_PATH | O_NOFOLLOW);
    if (fd < 0)
        error(EXIT_FAILURE, errno, "open_by_handle_at");

    if (close(fd))
        error(EXIT_FAILURE, errno, "close");

    if (close(mount_fd))
        error(EXIT_FAILURE, errno, "close");

    free(fhandle);

    return EXIT_SUCCESS;
}

--------------583348C193F558D5BC17F853
Content-Type: text/x-patch;
	name="0001-vfs-let-open_by_handle_at-use-mount_fd-opened-with-O.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-vfs-let-open_by_handle_at-use-mount_fd-opened-with-O.pa";
	filename*1="tch"

From e3717e276444c5711335d398c29beedaf61bac82 Mon Sep 17 00:00:00 2001
From: Quentin Bouget <quentin.bouget@cea.fr>
Date: Thu, 24 Oct 2019 16:54:54 +0200
Subject: [PATCH] vfs: let open_by_handle_at() use mount_fd opened with O_PATH

The first argument of open_by_handle_at() is `mount_fd':

> a file descriptor for any object (file, directory, etc.) in the
> mounted filesystem with respect to which `handle' should be
> interpreted.

This patch allows for this file descriptor to be opened with O_PATH.

Signed-off-by: Quentin Bouget <quentin.bouget@cea.fr>
---
 fs/fhandle.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 01263ffbc..8b67f1b9e 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -112,22 +112,33 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 	return err;
 }
 
+static struct vfsmount *get_vfsmount_from_cwd(void)
+{
+	struct fs_struct *fs = current->fs;
+	struct vfsmount *mnt;
+
+	spin_lock(&fs->lock);
+	mnt = mntget(fs->pwd.mnt);
+	spin_unlock(&fs->lock);
+
+	return mnt;
+}
+
 static struct vfsmount *get_vfsmount_from_fd(int fd)
 {
 	struct vfsmount *mnt;
+	struct path path;
+	int err;
 
-	if (fd == AT_FDCWD) {
-		struct fs_struct *fs = current->fs;
-		spin_lock(&fs->lock);
-		mnt = mntget(fs->pwd.mnt);
-		spin_unlock(&fs->lock);
-	} else {
-		struct fd f = fdget(fd);
-		if (!f.file)
-			return ERR_PTR(-EBADF);
-		mnt = mntget(f.file->f_path.mnt);
-		fdput(f);
-	}
+	if (fd == AT_FDCWD)
+		return get_vfsmount_from_cwd();
+
+	err = filename_lookup(fd, getname_kernel(""), LOOKUP_EMPTY, &path, NULL);
+	if (err)
+		return ERR_PTR(err);
+
+	mnt = mntget(path.mnt);
+	path_put(&path);
 	return mnt;
 }
 
-- 
2.18.1


--------------583348C193F558D5BC17F853--
