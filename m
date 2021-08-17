Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB73EE450
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 04:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhHQCYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 22:24:22 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:59153 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236550AbhHQCYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:24:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjHGpao_1629167027;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UjHGpao_1629167027)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Aug 2021 10:23:48 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [virtiofsd PATCH v4 1/4] virtiofsd: add .ioctl() support
Date:   Tue, 17 Aug 2021 10:23:44 +0800
Message-Id: <20210817022347.18098-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210817022347.18098-1-jefflexu@linux.alibaba.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add .ioctl() support for passthrough, in prep for the following support
for following per-file DAX feature.

Once advertising support for per-file DAX feature, virtiofsd should
support storing FS_DAX_FL flag persistently passed by
FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR ioctl, and set FUSE_ATTR_DAX in
FUSE_LOOKUP accordingly if the file is capable of per-file DAX.

When it comes to passthrough, it passes corresponding ioctls to host
directly. Currently only these ioctls that are needed for per-file DAX
feature, i.e., FS_IOC_GETFLAGS/FS_IOC_SETFLAGS and
FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR are supported. Later we can restrict
the flags/attributes allowed to be set to reinforce the security, or
extend the scope of allowed ioctls if it is really needed later.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 tools/virtiofsd/passthrough_ll.c      | 53 +++++++++++++++++++++++++++
 tools/virtiofsd/passthrough_seccomp.c |  1 +
 2 files changed, 54 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index b76d878509..e170b17adb 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -54,6 +54,7 @@
 #include <sys/wait.h>
 #include <sys/xattr.h>
 #include <syslog.h>
+#include <linux/fs.h>
 
 #include "qemu/cutils.h"
 #include "passthrough_helpers.h"
@@ -2105,6 +2106,57 @@ out:
     fuse_reply_err(req, saverr);
 }
 
+static void lo_ioctl(fuse_req_t req, fuse_ino_t ino, unsigned int cmd, void *arg,
+                  struct fuse_file_info *fi, unsigned flags, const void *in_buf,
+                  size_t in_bufsz, size_t out_bufsz)
+{
+    int fd = lo_fi_fd(req, fi);
+    int res;
+    int saverr = ENOSYS;
+
+    fuse_log(FUSE_LOG_DEBUG, "lo_ioctl(ino=%" PRIu64 ", cmd=0x%x, flags=0x%x, "
+	     "in_bufsz = %lu, out_bufsz = %lu)\n",
+	     ino, cmd, flags, in_bufsz, out_bufsz);
+
+    /* unrestricted ioctl is not supported yet */
+    if (flags & FUSE_IOCTL_UNRESTRICTED)
+        goto out;
+
+    /*
+     * Currently only those ioctls needed to support per-file DAX feature,
+     * i.e., FS_IOC_GETFLAGS/FS_IOC_SETFLAGS and
+     * FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR are supported.
+     */
+    if (cmd == FS_IOC_SETFLAGS || cmd == FS_IOC_FSSETXATTR) {
+        res = ioctl(fd, cmd, in_buf);
+        if (res < 0)
+            goto out_err;
+
+	fuse_reply_ioctl(req, 0, NULL, 0);
+    }
+    else if (cmd == FS_IOC_GETFLAGS || cmd == FS_IOC_FSGETXATTR) {
+	/* reused for 'unsigned int' for FS_IOC_GETFLAGS */
+	struct fsxattr attr;
+
+        res = ioctl(fd, cmd, &attr);
+        if (res < 0)
+            goto out_err;
+
+        fuse_reply_ioctl(req, 0, &attr, out_bufsz);
+    }
+    else {
+	fuse_log(FUSE_LOG_DEBUG, "Unsupported ioctl 0x%x\n", cmd);
+	goto out;
+    }
+
+    return;
+
+out_err:
+	saverr = errno;
+out:
+	fuse_reply_err(req, saverr);
+}
+
 static void lo_fsyncdir(fuse_req_t req, fuse_ino_t ino, int datasync,
                         struct fuse_file_info *fi)
 {
@@ -3279,6 +3331,7 @@ static struct fuse_lowlevel_ops lo_oper = {
     .create = lo_create,
     .getlk = lo_getlk,
     .setlk = lo_setlk,
+    .ioctl = lo_ioctl,
     .open = lo_open,
     .release = lo_release,
     .flush = lo_flush,
diff --git a/tools/virtiofsd/passthrough_seccomp.c b/tools/virtiofsd/passthrough_seccomp.c
index 62441cfcdb..2a5f7614fc 100644
--- a/tools/virtiofsd/passthrough_seccomp.c
+++ b/tools/virtiofsd/passthrough_seccomp.c
@@ -62,6 +62,7 @@ static const int syscall_allowlist[] = {
     SCMP_SYS(gettid),
     SCMP_SYS(gettimeofday),
     SCMP_SYS(getxattr),
+    SCMP_SYS(ioctl),
     SCMP_SYS(linkat),
     SCMP_SYS(listxattr),
     SCMP_SYS(lseek),
-- 
2.27.0

