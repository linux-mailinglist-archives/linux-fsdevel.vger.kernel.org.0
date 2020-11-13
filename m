Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5EC2B160D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 07:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKMG5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 01:57:30 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17195 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgKMG5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:57:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1605250631; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=e0lAb8RDCCYzvONL1U3KDdGUiJoJLjNVjdMAyEunVuOrC8Ir/PlGokIld4+1+ru1cQu8rI+bS2Q5NR3z1i5Ucpq8nAwF4vtytlX07RiDHgfypLIggxVue0bFJzr2bzNFRKoAwhhfiUfJWEcEla+W1IMi/UFgZg8FAyrtuPYSBmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605250631; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=AGdcIpu2sjIuvnF+45DCM+5mBHj7CFq40gjiUkSTIhw=; 
        b=G7Zgwv0Sl3vvAEYvKTKXb88qK+3TK9OEqViepl6a65KBx+uq0rxzHrSR+ek8enKVNzryo4lsHsyarHt7FXbrAlojWM3b1B8BUXQRVyBfkCoERwXFj3x1+moLYwLxXK05kol1c/hk8eZ4lQ0ABdzVr9/feY463SMFxiuKXNN2XgM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605250631;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=AGdcIpu2sjIuvnF+45DCM+5mBHj7CFq40gjiUkSTIhw=;
        b=SYlKePJojahSJGEMispwAbs2OVJ9NswyY7Kes/GIzy+MQlAG2NDm92eAneY2gEBh
        MxrDt1C5MeLSTxbpagahLo6Y3cDT1ODW5MxU+GxobnS9AzkKbsl7QA4AgCl3N9mKvfa
        FdprgUZlXihBua4MSCpdmcgphelTKNdQ3zxxHMQo=
Received: from localhost.localdomain (116.30.195.173 [116.30.195.173]) by mx.zoho.com.cn
        with SMTPS id 1605250628939771.7262224747083; Fri, 13 Nov 2020 14:57:08 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201113065555.147276-10-cgxu519@mykernel.net>
Subject: [RFC PATCH v4 9/9] ovl: implement containerized syncfs for overlayfs
Date:   Fri, 13 Nov 2020 14:55:55 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201113065555.147276-1-cgxu519@mykernel.net>
References: <20201113065555.147276-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now overlayfs can only sync dirty inode during syncfs,
so remove unnecessary sync_filesystem() on upper file
system.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 982b3954b47c..58507f1cd583 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,8 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include <linux/blkdev.h>
+#include <linux/writeback.h>
 #include "overlayfs.h"
=20
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -270,8 +272,7 @@ static int ovl_sync_fs(struct super_block *sb, int wait=
)
 =09 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 =09 * All the super blocks will be iterated, including upper_sb.
 =09 *
-=09 * If this is a syncfs(2) call, then we do need to call
-=09 * sync_filesystem() on upper_sb, but enough if we do it when being
+=09 * if this is a syncfs(2) call, it will be enough we do it when being
 =09 * called with wait =3D=3D 1.
 =09 */
 =09if (!wait)
@@ -280,7 +281,11 @@ static int ovl_sync_fs(struct super_block *sb, int wai=
t)
 =09upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
=20
 =09down_read(&upper_sb->s_umount);
-=09ret =3D sync_filesystem(upper_sb);
+=09wait_sb_inodes(upper_sb);
+=09if (upper_sb->s_op->sync_fs)
+=09=09ret =3D upper_sb->s_op->sync_fs(upper_sb, wait);
+=09if (!ret)
+=09=09ret =3D sync_blockdev(upper_sb->s_bdev);
 =09up_read(&upper_sb->s_umount);
=20
 =09return ret;
--=20
2.26.2


