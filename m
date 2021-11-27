Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F324E45FE0D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 11:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbhK0KSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 05:18:55 -0500
Received: from mail.loongson.cn ([114.242.206.163]:34834 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244587AbhK0KQx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 05:16:53 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxasnEBKJh_r0AAA--.1566S2;
        Sat, 27 Nov 2021 18:13:24 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2] fuse: rename some files and clean up Makefile
Date:   Sat, 27 Nov 2021 18:13:22 +0800
Message-Id: <1638008002-3037-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxasnEBKJh_r0AAA--.1566S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww43Gw17GFWxCrW7ZFWkJFb_yoW7uFy8pF
        ykuF48Gr47Xr47Wa47CF1jk34aqws3Gr17Jry8Xw129r1aqa4DArWqvFn0kr48ZrWDXF1j
        qr1UGrnxZrs8ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4DMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jeoGQUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No need to generate virtio_fs.o first and then link to virtiofs.o, just
rename virtio_fs.c to virtiofs.c and remove "virtiofs-y := virtio_fs.o"
in Makefile, also update MAINTAINERS. Additionally, rename the private
header file fuse_i.h to fuse.h, like ext4.h in fs/ext4, xfs.h in fs/xfs
and f2fs.h in fs/f2fs.

Without this patch:

  CC [M]  fs/fuse/virtio_fs.o
  LD [M]  fs/fuse/virtiofs.o
  MODPOST modules-only.symvers
  GEN     Module.symvers
  CC [M]  fs/fuse/virtiofs.mod.o
  LD [M]  fs/fuse/virtiofs.ko

With this patch:

  CC [M]  fs/fuse/virtiofs.o
  MODPOST modules-only.symvers
  GEN     Module.symvers
  CC [M]  fs/fuse/virtiofs.mod.o
  LD [M]  fs/fuse/virtiofs.ko

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2: rename fuse_i.h to fuse.h

 MAINTAINERS                         | 2 +-
 fs/fuse/Makefile                    | 2 --
 fs/fuse/acl.c                       | 2 +-
 fs/fuse/control.c                   | 2 +-
 fs/fuse/cuse.c                      | 2 +-
 fs/fuse/dax.c                       | 2 +-
 fs/fuse/dev.c                       | 2 +-
 fs/fuse/dir.c                       | 2 +-
 fs/fuse/file.c                      | 2 +-
 fs/fuse/{fuse_i.h => fuse.h}        | 0
 fs/fuse/inode.c                     | 2 +-
 fs/fuse/ioctl.c                     | 2 +-
 fs/fuse/readdir.c                   | 2 +-
 fs/fuse/{virtio_fs.c => virtiofs.c} | 2 +-
 fs/fuse/xattr.c                     | 2 +-
 15 files changed, 13 insertions(+), 15 deletions(-)
 rename fs/fuse/{fuse_i.h => fuse.h} (100%)
 rename fs/fuse/{virtio_fs.c => virtiofs.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345c..8c2ad7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20152,7 +20152,7 @@ L:	linux-fsdevel@vger.kernel.org
 S:	Supported
 W:	https://virtio-fs.gitlab.io/
 F:	Documentation/filesystems/virtiofs.rst
-F:	fs/fuse/virtio_fs.c
+F:	fs/fuse/virtiofs.c
 F:	include/uapi/linux/virtio_fs.h
 
 VIRTIO GPIO DRIVER
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 0c48b35..5f10fe6 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -9,5 +9,3 @@ obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
-
-virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 337cb29..2292e44 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -6,7 +6,7 @@
  * See the file COPYING.
  */
 
-#include "fuse_i.h"
+#include "fuse.h"
 
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 000d2e5..dc9095f 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -6,7 +6,7 @@
   See the file COPYING.
 */
 
-#include "fuse_i.h"
+#include "fuse.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index c7d882a..bc115e8 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -51,7 +51,7 @@
 #include <linux/uio.h>
 #include <linux/user_namespace.h>
 
-#include "fuse_i.h"
+#include "fuse.h"
 
 #define CUSE_CONNTBL_LEN	64
 
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 713818d..25dae57 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2020 Red Hat, Inc.
  */
 
-#include "fuse_i.h"
+#include "fuse.h"
 
 #include <linux/delay.h>
 #include <linux/dax.h>
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index cd54a52..e133c1c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -6,7 +6,7 @@
   See the file COPYING.
 */
 
-#include "fuse_i.h"
+#include "fuse.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 656e921..58b8af6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -6,7 +6,7 @@
   See the file COPYING.
 */
 
-#include "fuse_i.h"
+#include "fuse.h"
 
 #include <linux/pagemap.h>
 #include <linux/file.h>
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9d6c5f6..f5e10ab 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -6,7 +6,7 @@
   See the file COPYING.
 */
 
-#include "fuse_i.h"
+#include "fuse.h"
 
 #include <linux/pagemap.h>
 #include <linux/slab.h>
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse.h
similarity index 100%
rename from fs/fuse/fuse_i.h
rename to fs/fuse/fuse.h
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 63ab454..0ffd0fe 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -6,7 +6,7 @@
   See the file COPYING.
 */
 
-#include "fuse_i.h"
+#include "fuse.h"
 
 #include <linux/pagemap.h>
 #include <linux/slab.h>
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fbc09da..1004d7a 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2017 Red Hat, Inc.
  */
 
-#include "fuse_i.h"
+#include "fuse.h"
 
 #include <linux/uio.h>
 #include <linux/compat.h>
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index b4e5657..d83a7a3 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -6,8 +6,8 @@
   See the file COPYING.
 */
 
+#include "fuse.h"
 
-#include "fuse_i.h"
 #include <linux/iversion.h>
 #include <linux/posix_acl.h>
 #include <linux/pagemap.h>
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtiofs.c
similarity index 99%
rename from fs/fuse/virtio_fs.c
rename to fs/fuse/virtiofs.c
index 4cfa4bc..cc3a8ae 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtiofs.c
@@ -16,7 +16,7 @@
 #include <linux/fs_parser.h>
 #include <linux/highmem.h>
 #include <linux/uio.h>
-#include "fuse_i.h"
+#include "fuse.h"
 
 /* Used to help calculate the FUSE connection's max_pages limit for a request's
  * size. Parts of the struct fuse_req are sliced into scattergather lists in
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 0d3e717..641bf3b 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -6,7 +6,7 @@
  * See the file COPYING.
  */
 
-#include "fuse_i.h"
+#include "fuse.h"
 
 #include <linux/xattr.h>
 #include <linux/posix_acl_xattr.h>
-- 
2.1.0

