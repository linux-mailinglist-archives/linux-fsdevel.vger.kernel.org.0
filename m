Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857912AAB3A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgKHOEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:04:04 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17110 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727844AbgKHOED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:04:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604844207; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=jSyydPPDI06nqpbPUxBlX9SMyH3EHLzB6uoGQaJmgugonhbOY47jf2bg9RIf0L6DD24QeXcQygz+NPjrqVlpk5MTVCzvOxISjkGKsfJ9xiMYY1NuN93egMj9uYuhe4gfMMoFxbj2Zjsu6AIqB1u3ZeL6XUN3a7CH/HY1A+M5CKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604844207; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Hs9NI+ahedQ8YyeMtVZWX4Uqq8hHYsmgHZ2u4WxWbuM=; 
        b=ClZ4nlAxYcqppxC1bU5r8O35qwePv4VMM8Wov4VVaKzrlFgG72SiaZxnBmKim16G0qgULK/sLDktPUVYGkQln5vKA1Fc/m5AJ8Ye65Gd4glvEFGJfOHTqQ+FTUSCg4XN/SuEiUmHaesaAfq1unUtFqF9l3ETtAL9u6CExnOk0Q8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604844207;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=Hs9NI+ahedQ8YyeMtVZWX4Uqq8hHYsmgHZ2u4WxWbuM=;
        b=QYaPIrsVQ0xd946iFhvwE7UGRRyP1rMwBzdEu9vklvUecgV5LhBeM0XsHtAULS9e
        pS9yFFCh/lnzA1f3NxBJpT5g6vGWOlWBl0oHixYJLnOgKYjYlgQz0eQaaqkSyCA5kPn
        r1V1q1bY33M1izl8he9ryW2spPpJUnwbDE0m+9GE=
Received: from localhost.localdomain (113.116.49.189 [113.116.49.189]) by mx.zoho.com.cn
        with SMTPS id 1604844206284238.6408227363977; Sun, 8 Nov 2020 22:03:26 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201108140307.1385745-8-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 07/10] ovl: implement overlayfs' ->write_inode operation
Date:   Sun,  8 Nov 2020 22:03:04 +0800
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

Implement overlayfs' ->write_inode to sync dirty data
and redirty overlayfs' inode if necessary.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 694eff76eb09..0ddee18b0bab 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -391,6 +391,35 @@ static int ovl_remount(struct super_block *sb, int *fl=
ags, char *data)
 =09return ret;
 }
=20
+static int ovl_write_inode(struct inode *inode,
+=09=09=09   struct writeback_control *wbc)
+{
+=09struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
+=09struct inode *upper =3D ovl_inode_upper(inode);
+=09unsigned long iflag =3D 0;
+=09int ret =3D 0;
+
+=09if (!upper)
+=09=09return 0;
+
+=09if (!ovl_should_sync(ofs))
+=09=09return 0;
+
+=09if (upper->i_sb->s_op->write_inode)
+=09=09ret =3D upper->i_sb->s_op->write_inode(inode, wbc);
+
+=09iflag |=3D upper->i_state & I_DIRTY_ALL;
+
+=09if (mapping_writably_mapped(upper->i_mapping) ||
+=09    mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
+=09=09iflag |=3D I_DIRTY_PAGES;
+
+=09if (iflag)
+=09=09ovl_mark_inode_dirty(inode);
+
+=09return ret;
+}
+
 static void ovl_evict_inode(struct inode *inode)
 {
 =09struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
@@ -411,6 +440,7 @@ static const struct super_operations ovl_super_operatio=
ns =3D {
 =09.destroy_inode=09=3D ovl_destroy_inode,
 =09.drop_inode=09=3D generic_delete_inode,
 =09.evict_inode=09=3D ovl_evict_inode,
+=09.write_inode=09=3D ovl_write_inode,
 =09.put_super=09=3D ovl_put_super,
 =09.sync_fs=09=3D ovl_sync_fs,
 =09.statfs=09=09=3D ovl_statfs,
--=20
2.26.2


