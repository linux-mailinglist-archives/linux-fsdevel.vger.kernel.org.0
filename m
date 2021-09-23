Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032B2415F93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbhIWNZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 09:25:33 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17222 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241252AbhIWNZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1632402521; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=LtT4AHvjKfjxM7qfFR64EaDXeRwB+/cGDrDpPbwsQpxOy9zU9S/34b9tcckTWtPRC99AFBxe4FcaVqr1Uj/UN3hKhKg1h8vL6QxnRLBoNpV0P2g63VPQspXv2qjNvZW21/WRc0M3YzJIgEErJ2ElGnTzX/Mpa3IsiMjtrSGEC7Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1632402521; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=XsUohhYVPknp/XYAaV7893wjUc9cOlm8DY/Vt5qPhmQ=; 
        b=FZdUAfgRvEjoF5w4JyAviHQETBr1ci/Y8SnblybEi/0LWK5d3aFFN9xTY586aGoFtbmw6OyHq3a5zpS5nMzls52AY6lw9HEHZTbZHiIZw+pT8q69FGam1LPJ+XkUkb4CMOMKsi/5IQZftPqGOkd6WDwfCsVisLm9Wt8I6VOeRAU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1632402521;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=XsUohhYVPknp/XYAaV7893wjUc9cOlm8DY/Vt5qPhmQ=;
        b=J1CY3iOba+GXjdL6LsJYfjWo0tJEIuJUg9Pz9U+pHROXjA9a2Rsu2AQ+m9g4SrqV
        WizDKlrtcKcL5qhJovXGJI74s5Nh41Fl0UU8EKQS5yeuiqnrgwgmhTAZv8FN+HdRh/P
        UDcIVxHoK3jjQtUiQfOr7zd9ChTCWPJCdjjSz7NE=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1632402520332669.3406501896101; Thu, 23 Sep 2021 21:08:40 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210923130814.140814-7-cgxu519@mykernel.net>
Subject: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode operation
Date:   Thu, 23 Sep 2021 21:08:10 +0800
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

Implement overlayfs' ->write_inode to sync dirty data
and redirty overlayfs' inode if necessary.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 2ab77adf7256..cddae3ca2fa5 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -412,12 +412,42 @@ static void ovl_evict_inode(struct inode *inode)
 =09clear_inode(inode);
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
+=09if (mapping_writably_mapped(upper->i_mapping) ||
+=09    mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
+=09=09iflag |=3D I_DIRTY_PAGES;
+
+=09iflag |=3D upper->i_state & I_DIRTY_ALL;
+
+=09if (iflag)
+=09=09ovl_mark_inode_dirty(inode);
+
+=09return ret;
+}
+
 static const struct super_operations ovl_super_operations =3D {
 =09.alloc_inode=09=3D ovl_alloc_inode,
 =09.free_inode=09=3D ovl_free_inode,
 =09.destroy_inode=09=3D ovl_destroy_inode,
 =09.drop_inode=09=3D generic_delete_inode,
 =09.evict_inode=09=3D ovl_evict_inode,
+=09.write_inode=09=3D ovl_write_inode,
 =09.put_super=09=3D ovl_put_super,
 =09.sync_fs=09=3D ovl_sync_fs,
 =09.statfs=09=09=3D ovl_statfs,
--=20
2.27.0


