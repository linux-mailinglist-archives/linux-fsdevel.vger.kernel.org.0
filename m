Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90C5415FA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 15:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbhIWNZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 09:25:52 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17226 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241338AbhIWNZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1632402523; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=f2h811w2svJQ4VmTGeEPdH8ik/s9xSbE+Y2NhLHm4skAElJ4FYA4xm5dEZGFMAi1TGnQJewLXfnkxfoHMNJGI3jNPYuLd4vA0vip+HcqcY+zwSgNfsMa1ORU7ggfUWGi3pDN72aPTjEogAu7+kShz6Zh98ewPabDJhBOXBqL4xc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1632402523; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=oG9u6AuZGZnG2KRRqhJabX8iiojey6H8VgFRc9r8zZI=; 
        b=VkcPKRSjcPvbDFAsHX4SaX3tRDA349fSUPEhiU7yZblCVudkVNhNPAh8EjSEhhquivpvlX/Y2+ep4mRONhMq5NdadZqjKW0IrEbQ9WE1ncQejOM9iLp0VN/EcTaYok3dknMfKuY1V952v6eneT6XYeQERXol7ZFqmkrrvyDNUhQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1632402523;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=oG9u6AuZGZnG2KRRqhJabX8iiojey6H8VgFRc9r8zZI=;
        b=XJQM+4b0CJp8iL2K71cfogKzVBIQgvz8ktaI3l4hTq+Fyn3vaxMs2Vo46b6Ap2Di
        78la47q64qXuBX4hgyzGubgPeER3oS7CfGs3fPVN3BhSN+j/VOtQeUBJaqdqXFZLaJS
        Tft2OQcHcIoZ55Cvjh/9z2MNFtN00A1UW+hZ7vXA=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1632402522914922.0766031758626; Thu, 23 Sep 2021 21:08:42 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210923130814.140814-11-cgxu519@mykernel.net>
Subject: [RFC PATCH v5 10/10] ovl: implement containerized syncfs for overlayfs
Date:   Thu, 23 Sep 2021 21:08:14 +0800
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210923130814.140814-1-cgxu519@mykernel.net>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now overlayfs can sync proper dirty inodes during syncfs,
so remove unnecessary sync_filesystem() on upper file
system.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index bf4000eb9be8..ef998ada6cb9 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include <linux/writeback.h>
 #include "overlayfs.h"
=20
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -281,18 +282,15 @@ static int ovl_sync_fs(struct super_block *sb, int wa=
it)
 =09/*
 =09 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 =09 * All the super blocks will be iterated, including upper_sb.
-=09 *
-=09 * If this is a syncfs(2) call, then we do need to call
-=09 * sync_filesystem() on upper_sb, but enough if we do it when being
-=09 * called with wait =3D=3D 1.
 =09 */
-=09if (!wait)
-=09=09return 0;
=20
 =09upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
=20
 =09down_read(&upper_sb->s_umount);
-=09ret =3D sync_filesystem(upper_sb);
+=09if (wait)
+=09=09wait_sb_inodes(upper_sb);
+
+=09ret =3D sync_fs_and_blockdev(upper_sb, wait);
 =09up_read(&upper_sb->s_umount);
=20
 =09return ret;
--=20
2.27.0


