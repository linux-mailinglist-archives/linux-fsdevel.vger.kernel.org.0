Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61923A7742
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 08:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFOGoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 02:44:03 -0400
Received: from m12-16.163.com ([220.181.12.16]:60471 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbhFOGoC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zDFMU
        pcM0iFsbvJpRwSkNP93HHPNlE4oSqJBlAUDPlk=; b=W6Qruxugt1uG8DvcNRSCh
        WQkmBaT0craSB2a0kpColyFNZ2weURMjH45I2x9ToB/xxXqPmO2SKH7R8h5Bi/U5
        ki5eukc3tzyI9YleXFdOY180o6UFpGvN+4mmuEa1fh93WM2kM/vK4rXedkoqeOfk
        2tP5OAk+96xgWNTUyTGcPk=
Received: from jiangzhipeng.ccdomain.com (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowACHnlqsS8hgqPq7xQ--.51904S2;
        Tue, 15 Jun 2021 14:41:54 +0800 (CST)
From:   jzp0409 <jzp0409@163.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        "edison.jiang" <jiangzhipeng@yulong.com>
Subject: [PATCH] fuse: set limit size
Date:   Tue, 15 Jun 2021 14:41:55 +0800
Message-Id: <20210615064155.911-1-jzp0409@163.com>
X-Mailer: git-send-email 2.30.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowACHnlqsS8hgqPq7xQ--.51904S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4rKrykuw4fXr15Cw1DGFg_yoW8Gry5pF
        nruFWrJrZFqFWxGr1Sgr17Way5K3yFyF4jgFWfZa12vr15Xr9IkF93ZFWkW3y5ur4kZw1Y
        y3sxKr1rursrt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-Vy3UUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: hm2sikiqz6il2tof0z/xtbBiBKyhlaD-TZ0twAAsz
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "edison.jiang" <jiangzhipeng@yulong.com>

Android-R /sdcard mount FUSE filesystem type,
use "dd" command to filli up /sdcard dir,
Android will not boot normal,
becase this system need at least 128M userspace.

Test: open adb port,
      adb shell "dd if=dev/zero of=sdcard/ae bs=1024000 count=xxx"

Result: if not limit size,Android system  can not boot normal.

Signed-off-by: edison.jiang <jiangzhipeng@yulong.com>
---
 fs/fuse/inode.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b0e18b4..f4e54505 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -477,6 +477,21 @@ static void convert_fuse_statfs(struct kstatfs *stbuf, struct fuse_kstatfs *attr
 	stbuf->f_files   = attr->files;
 	stbuf->f_ffree   = attr->ffree;
 	stbuf->f_namelen = attr->namelen;
+#ifdef LIMIT_SDCARD_SIZE
+	u32 data_free_size_th = 128*1024*1024;
+
+	stbuf->f_blocks -= (u32)data_free_size_th/attr->bsize;
+
+	if (stbuf->f_bfree < ((u32)data_free_size_th/attr->bsize))
+		stbuf->f_bfree = 0;
+	else
+		stbuf->f_bfree -= (u32)data_free_size_th/attr->bsize;
+
+	if (stbuf->f_bavail < ((u32)data_free_size_th/attr->bsize))
+		stbuf->f_bavail = 0;
+	else
+		stbuf->f_bavail -= (u32)data_free_size_th/attr->bsize;
+#endif
 	/* fsid is left zero */
 }
 
-- 
1.9.1


