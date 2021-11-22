Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2395458844
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 04:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhKVDTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 22:19:48 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:12733 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238653AbhKVDTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 22:19:38 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637550057; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ZLvWAFmEurggVznKbFKsinCgYfQW+1Vo5inGf9HzDE9HeZhoVYkaCjFGJROlVZtLCFhl2qULZmiCidHYcHGY/yipI2pCImTb+0n6tGWOMj+altjEJxtkkBuklJVKiS0q3uGtbZvhrsvtfT+Q77JTTpeoRSF307suDbGsHaYRPK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637550057; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=w0m2Fx6wMRCtcv0P3H0nf5BfGoRc8ouSRTWclZNiTZU=; 
        b=a+/3KggL76KvVv1p9WFiqdH5QGXiTesfMnkZ54u0aMc9q9x4b0ABqw62u84CpSsagjQT0wrMCAa4WLPkCxP4OkuwOcWGDcRC18YzsBaE8bTsaVyJFEV8yR377CSJLLbuFR1phM+UApQxr0uAciKaMnebaS7wdZyPicHhQE/FswA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637550057;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=w0m2Fx6wMRCtcv0P3H0nf5BfGoRc8ouSRTWclZNiTZU=;
        b=Xm/zFMHfl/DYSG+CqEc9jRaE6j5a5TVbEYM/JBmi3fR71vG+1flUfgTpWyY3v3mk
        XR/xYCpIklXGD0X48u+alNvnv21cmE7XD9pbMpkDHajTYFJSeDRuvrk4cmP6wPOIsjm
        LQvApmii0Z0Oe6FAwCaPlGYbfRQcOgddA5ftnHzY=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1637550056065980.8003074971691; Mon, 22 Nov 2021 11:00:56 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Message-ID: <20211122030038.1938875-4-cgxu519@mykernel.net>
Subject: [RFC PATCH V6 3/7] ovl: implement overlayfs' own ->write_inode operation
Date:   Mon, 22 Nov 2021 11:00:34 +0800
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211122030038.1938875-1-cgxu519@mykernel.net>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chengguang Xu <charliecgxu@tencent.com>

Sync dirty data and meta of upper inode in overlayfs' ->write_inode()
and redirty overlayfs' inode.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
---
 fs/overlayfs/super.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 18a12088a37b..12acf0ec7395 100644
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
@@ -406,12 +407,32 @@ static int ovl_remount(struct super_block *sb, int *f=
lags, char *data)
 =09return ret;
 }
=20
+static int ovl_write_inode(struct inode *inode,
+=09=09=09   struct writeback_control *wbc)
+{
+=09struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
+=09struct inode *upper_inode =3D ovl_inode_upper(inode);
+=09int ret =3D 0;
+
+=09if (!upper_inode)
+=09=09return 0;
+
+=09if (!ovl_should_sync(ofs))
+=09=09return 0;
+
+=09ret =3D write_inode_now(upper_inode, wbc->sync_mode =3D=3D WB_SYNC_ALL)=
;
+=09mark_inode_dirty(inode);
+
+=09return ret;
+}
+
 static const struct super_operations ovl_super_operations =3D {
 =09.alloc_inode=09=3D ovl_alloc_inode,
 =09.free_inode=09=3D ovl_free_inode,
 =09.destroy_inode=09=3D ovl_destroy_inode,
 =09.drop_inode=09=3D generic_delete_inode,
 =09.put_super=09=3D ovl_put_super,
+=09.write_inode=09=3D ovl_write_inode,
 =09.sync_fs=09=3D ovl_sync_fs,
 =09.statfs=09=09=3D ovl_statfs,
 =09.show_options=09=3D ovl_show_options,
--=20
2.27.0


