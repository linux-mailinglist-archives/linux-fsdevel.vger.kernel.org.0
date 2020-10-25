Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5438A297FF7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 04:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766976AbgJYDmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 23:42:32 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17126 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1766959AbgJYDm3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 23:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603597311; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=mf0E1TTJ/NgWDOtk+K3qkCCQG3eO8UaPWfKxjnXjNNNe37iaZItpr8aNLL1zWQNV+2ywZJZM7lTqII+DLRvwdXHQ1jfrt6BuNqGuQggHKe6oBXeFEj4gXtOZiSO0Xlkpchrq3sxOLRCdWo+obYYip5swIcAAofIkDhmtZxdwvdE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1603597311; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=v2u7N4GC7c2BP/wK2MnBMpBehRe3CxkK27J7gPJ6l0k=; 
        b=KfREJwtBknnJVJpamBgPuUt4QQCrRge3LYqKMgU5fAVtYUAQwgbNrlTx9BN57Hf+E6kJKCfCO0D8NEuB74gP8vRpKeqeuicwN0snDG6+9pbYoXx/VNRssORkE0ip+Wbg/Q/AFj0UfuwhLZH/sytatJ667zR6xWVfRhoZ4lggYgY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1603597311;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=v2u7N4GC7c2BP/wK2MnBMpBehRe3CxkK27J7gPJ6l0k=;
        b=JiUSoqqnMcqHnuIjdM7JIxaeUFs7z1eZfbO2J/UrL16GZMAsoTbcY4NyCi1ec5Az
        bIzga9P8iPQY/0syhj67RuTAQLPMavpO1jyjj33X06WXSBt5LZTMEFqP+k+8LbfAyJz
        B1M+77BeT44i7HeBNtbcrLAqOVM76h2Dk5uLin+o=
Received: from localhost.localdomain (113.88.132.7 [113.88.132.7]) by mx.zoho.com.cn
        with SMTPS id 160359731016595.65073159649478; Sun, 25 Oct 2020 11:41:50 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201025034117.4918-3-cgxu519@mykernel.net>
Subject: [RFC PATCH v2 2/8] ovl: implement ->writepages operation
Date:   Sun, 25 Oct 2020 11:41:11 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025034117.4918-1-cgxu519@mykernel.net>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement overlayfs' ->writepages operation so that
we can sync dirty data/metadata to upper filesystem.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/inode.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b584dca845ba..f27fc5be34df 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -11,6 +11,7 @@
 #include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
+#include <linux/writeback.h>
 #include "overlayfs.h"
=20
=20
@@ -516,7 +517,32 @@ static const struct inode_operations ovl_special_inode=
_operations =3D {
 =09.update_time=09=3D ovl_update_time,
 };
=20
+static int ovl_writepages(struct address_space *mapping,
+=09=09=09  struct writeback_control *wbc)
+{
+=09struct inode *upper_inode =3D ovl_inode_upper(mapping->host);
+=09struct ovl_fs *ofs =3D  mapping->host->i_sb->s_fs_info;
+=09struct writeback_control tmp_wbc =3D *wbc;
+
+=09if (!ovl_should_sync(ofs))
+=09=09return 0;
+
+=09/*
+=09 * for sync(2) writeback, it has a separate external IO
+=09 * completion path by checking PAGECACHE_TAG_WRITEBACK
+=09 * in pagecache, we have to set for_sync to 0 in thie case,
+=09 * let writeback waits completion after syncing individual
+=09 * dirty inode, because we haven't implemented overlayfs'
+=09 * own pagecache yet.
+=09 */
+=09if (wbc->for_sync && (wbc->sync_mode =3D=3D WB_SYNC_ALL))
+=09=09tmp_wbc.for_sync =3D 0;
+
+=09return sync_inode(upper_inode, &tmp_wbc);
+}
+
 static const struct address_space_operations ovl_aops =3D {
+=09.writepages=09=09=3D ovl_writepages,
 =09/* For O_DIRECT dentry_open() checks f_mapping->a_ops->direct_IO */
 =09.direct_IO=09=09=3D noop_direct_IO,
 };
--=20
2.26.2


