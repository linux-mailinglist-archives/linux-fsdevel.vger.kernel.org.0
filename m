Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2C23D8DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 11:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgHFJnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 05:43:40 -0400
Received: from foss.arm.com ([217.140.110.172]:41644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgHFJnh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:43:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10F511045;
        Thu,  6 Aug 2020 02:43:14 -0700 (PDT)
Received: from [10.163.65.54] (unknown [10.163.65.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C8FB3F9AB;
        Thu,  6 Aug 2020 02:43:10 -0700 (PDT)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, rafael@kernel.org
From:   Vikas Kumar <vikas.kumar2@arm.com>
Subject: [LTP-FAIL][02/21] fs: refactor ksys_umount
Message-ID: <d28d2235-9b1c-0403-59ca-e57ac5d0460e@arm.com>
Date:   Thu, 6 Aug 2020 15:13:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

We have seen LTP test(utime06 and umount03) failure in Next Master with 
commit Id 41525f56e256("fs: refactor ksys_umount").
I didn't analysis root cause of problem, i am reporting this issue.

---------------------------------------------
LTP Testcase    Result    Exit Value
----------------------------------- ---------
umount03          FAIL           4
utime06             FAIL           2
--------------------------------------------

LTP utime06 Fail Log:
/dev/loop0 is mounted; will not make a filesystem here!
utime06     0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
utime06     0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra 
opts=''
utime06     1  TBROK  :  tst_mkfs.c:102: utime06.c:122: mkfs.ext2 failed 
with 1
utime06     2  TBROK  :  tst_mkfs.c:102: Remaining cases broken

LTP umount03 Fail Log:
tst_device.c:262: INFO: Using test device LTP_DEV='/dev/loop0'
tst_mkfs.c:89: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.44.5 (15-Dec-2018)
tst_test.c:1244: INFO: Timeout per run is 0h 05m 00s
umount03.c:35: PASS: umount() fails as expected: EPERM (1)
tst_device.c:383: INFO: umount('mntpoint') failed with EBUSY, try 1...
tst_device.c:387: INFO: Likely gvfsd-trash is probing newly mounted fs, 
kill it to speed up tests.
tst_device.c:383: INFO: umount('mntpoint') failed with EBUSY, try 2...
tst_device.c:383: INFO: umount('mntpoint') failed with EBUSY, try 3...
tst_device.c:383: INFO: umount('mntpoint') failed with EBUSY, try 48...
tst_device.c:383: INFO: umount('mntpoint') failed with EBUSY, try 49...
tst_device.c:383: INFO: umount('mntpoint') failed with EBUSY, try 50...
tst_device.c:394: WARN: Failed to umount('mntpoint') after 50 retries
tst_tmpdir.c:336: WARN: tst_rmdir: rmobj(/scratch/ltp-Lnmh7tbxY6/gx0hJU) 
failed: remove(/scratch/ltp-Lnmh7tbxY6/gx0hJU/mntpoint) failed; 
errno=16: EBUSY

Regards,

Vikas


Below Commit ID 41525f56e256 Bisected for This fail:

     commit 41525f56e2564c2feff4fb2824823900efb3a39f
     Author: Christoph Hellwig <hch@lst.de>
     Date:   Tue Jul 21 10:54:34 2020 +0200

     fs: refactor ksys_umount

     Factor out a path_umount helper that takes a struct path * instead 
of the
     actual file name.  This will allow to convert the init and devtmpfs 
code
     to properly mount based on a kernel pointer instead of relying on the
     implicit set_fs(KERNEL_DS) during early init.

     Signed-off-by: Christoph Hellwig <hch@lst.de>

---
  fs/namespace.c | 40 ++++++++++++++++++----------------------
  1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6f8234f74bed90..43834b59eff6c3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1706,36 +1706,19 @@ static inline bool may_mandlock(void)
  }
  #endif

-/*
- * Now umount can handle mount points as well as block devices.
- * This is important for filesystems which use unnamed block devices.
- *
- * We now support a flag for forced unmount like the other 'big iron'
- * unixes. Our API is identical to OSF/1 to avoid making a mess of AMD
- */
-
-int ksys_umount(char __user *name, int flags)
+static int path_umount(struct path *path, int flags)
  {
-    struct path path;
      struct mount *mnt;
      int retval;
-    int lookup_flags = LOOKUP_MOUNTPOINT;

      if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
          return -EINVAL;
-
      if (!may_mount())
          return -EPERM;

-    if (!(flags & UMOUNT_NOFOLLOW))
-        lookup_flags |= LOOKUP_FOLLOW;
-
-    retval = user_path_at(AT_FDCWD, name, lookup_flags, &path);
-    if (retval)
-        goto out;
-    mnt = real_mount(path.mnt);
+    mnt = real_mount(path->mnt);
      retval = -EINVAL;
-    if (path.dentry != path.mnt->mnt_root)
+    if (path->dentry != path->mnt->mnt_root)
          goto dput_and_out;
      if (!check_mnt(mnt))
          goto dput_and_out;
@@ -1748,12 +1731,25 @@ int ksys_umount(char __user *name, int flags)
      retval = do_umount(mnt, flags);
  dput_and_out:
      /* we mustn't call path_put() as that would clear mnt_expiry_mark */
-    dput(path.dentry);
+    dput(path->dentry);
      mntput_no_expire(mnt);
-out:
      return retval;
  }

+int ksys_umount(char __user *name, int flags)
+{
+    int lookup_flags = LOOKUP_MOUNTPOINT;
+    struct path path;
+    int ret;
+
+    if (!(flags & UMOUNT_NOFOLLOW))
+        lookup_flags |= LOOKUP_FOLLOW;
+    ret = user_path_at(AT_FDCWD, name, lookup_flags, &path);
+    if (ret)
+        return ret;
+    return path_umount(&path, flags);
+}
+
SYSCALL_DEFINE2(umount, char __user *, name, int, flags)
  {


