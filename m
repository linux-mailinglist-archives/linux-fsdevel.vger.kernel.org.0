Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3A2AAB3C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgKHOEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:04:04 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17141 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbgKHOED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:04:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604844209; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=hJKqz46bMoFQbA7P5d/3iEAagbKCvzYyKET5E1EfgDzw3Wj+UQbOz6JnKHvGNI5U485jWdiYiBd1Z9IMi9ecRN+k0n6l5esOI77axTroCeBX1I0ZZSenFXj0ycf0xnjf54GQg1SqgiZcXVvshzHL2cJSgsoGPSNYGTpQ1pgqlBo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604844209; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=nE9/U4FdhP2QCkpJbWwcZagtZcr1H04OMCjjI97w8Tg=; 
        b=YPZ/kKk+uVXNro0vMx/K45J750HJmU7m9xbo0Pv4F7sPRoMcvg1kWS8VWcThnzN8T+Z95leHotTTS+eY+I+mKoFe/gfZbIK3cHAM0WGpwhM/RAQ6RczfgSdNK916tA1TIqjtLT9bn0QFVHFl1NnV+B+vexJbbZmQvwJuql17clk=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604844209;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=nE9/U4FdhP2QCkpJbWwcZagtZcr1H04OMCjjI97w8Tg=;
        b=R3RISgcta+xHROvHE+2Q3AYNdXgnQKiQud5Ink6JfZ/d+PMS4wh6AE7EQNhjAGaV
        fBY1NkGpIb12pihelhNZ5swQDvKy4So5R9jQPJJmak4PvcZwKCcqmK40hp8Ut1lUvAi
        GpSaCNf1q6/scGMjQwebQQv13FvRSgiMLoiA1xCk=
Received: from localhost.localdomain (113.116.49.189 [113.116.49.189]) by mx.zoho.com.cn
        with SMTPS id 1604844208180826.6251706207471; Sun, 8 Nov 2020 22:03:28 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201108140307.1385745-11-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 10/10] ovl: implement containerized syncfs for overlayfs
Date:   Sun,  8 Nov 2020 22:03:07 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108140307.1385745-1-cgxu519@mykernel.net>
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now overlayfs can only sync dirty inode during
syncfs, so remove unnecessary sync_filesystem()
on upper file system.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 9a535fc11221..9fc66563d749 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include <linux/blkdev.h>
 #include "overlayfs.h"
=20
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -301,8 +302,7 @@ static int ovl_sync_fs(struct super_block *sb, int wait=
)
 =09 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 =09 * All the super blocks will be iterated, including upper_sb.
 =09 *
-=09 * If this is a syncfs(2) call, then we do need to call
-=09 * sync_filesystem() on upper_sb, but enough if we do it when being
+=09 * If this is a syncfs(2) call, it will be enough we do it when being
 =09 * called with wait =3D=3D 1.
 =09 */
 =09if (!wait)
@@ -311,7 +311,11 @@ static int ovl_sync_fs(struct super_block *sb, int wai=
t)
 =09upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
=20
 =09down_read(&upper_sb->s_umount);
-=09ret =3D sync_filesystem(upper_sb);
+=09ovl_wait_wb_inodes(ofs);
+=09if (upper_sb->s_op->sync_fs)
+=09=09ret =3D upper_sb->s_op->sync_fs(upper_sb, wait);
+=09if (!ret)
+=09=09ret =3D sync_blockdev(upper_sb->s_bdev);
 =09up_read(&upper_sb->s_umount);
=20
 =09return ret;
--=20
2.26.2


