Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5145EDD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 13:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377269AbhKZM2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 07:28:54 -0500
Received: from mail.loongson.cn ([114.242.206.163]:38780 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238353AbhKZM0x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:26:53 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax2sjF0aBhFi8AAA--.152S2;
        Fri, 26 Nov 2021 20:23:34 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] fuse: Rename virtio_fs.c to virtiofs.c and clean up Makefile
Date:   Fri, 26 Nov 2021 20:23:33 +0800
Message-Id: <1637929413-22687-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Ax2sjF0aBhFi8AAA--.152S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1xXry5tw4UXFyfWFWkXrb_yoW8Ww4xpw
        18Cr1rGry7XrW7GayfGF1Uu3yjkrn7Gr17Gr4kXwnIgrn8XayUAr1jyFyjkws7Zry5XF40
        qr1Fqr429r4vvF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8Jr0_Cr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Xr1l42xK
        82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYsjUUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No need to generate virtio_fs.o first and then link to virtiofs.o, just
rename virtio_fs.c to virtiofs.c and remove "virtiofs-y := virtio_fs.o"
in Makefile. Additionally, update MAINTAINERS.

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
 MAINTAINERS                         | 2 +-
 fs/fuse/Makefile                    | 2 --
 fs/fuse/{virtio_fs.c => virtiofs.c} | 0
 3 files changed, 1 insertion(+), 3 deletions(-)
 rename fs/fuse/{virtio_fs.c => virtiofs.c} (100%)

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
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtiofs.c
similarity index 100%
rename from fs/fuse/virtio_fs.c
rename to fs/fuse/virtiofs.c
-- 
2.1.0

