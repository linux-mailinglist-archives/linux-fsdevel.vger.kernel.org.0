Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B052AAB45
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgKHOEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:04:08 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17142 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728191AbgKHOEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:04:05 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604844208; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=DWXbuPQKndyoOo9VWXF0+CIVp6d9/xxihD/f7tL/uG/6uvMxt73b9IbhAP5ZGwek5xU+6oBYG9vXjTvjIkDrF00YxmCwkClU2m3f1TMZiOcHKWljo3N6/la12A6R24FXL+wrfLO5H242jdjzid2mXd2D/Lp5hqJbfbQafKIZNbg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604844208; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=KjtNuGCbko1IHimLoa0WxpHVk1G+1n/XuLBptbV9oIo=; 
        b=B6vfkYeZu1H5bWU9EX9bWLukSaiH/ERxY95D9kcJKG07J1djIIm53ES9IiokLQcwxE2evroEi6CCGsY585BIoFO5EZf/+k18BLOy2PKwRom7TgkOccqpmUExZSr6AmrdkuJEwhb36aDjnmiV309SUj7WhGzD29xa881RU6XNktU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604844208;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=KjtNuGCbko1IHimLoa0WxpHVk1G+1n/XuLBptbV9oIo=;
        b=GOuvnHYXY8eo6+H0lLRZRH07XlC4c+uDRQ/TSKzqbeZrMi1H+phhjiQkwCgPLqs3
        96F6cNSuu7o+Z6imqi72c3W6M7hr9vZcQVQzr3IyXg4Ss1EEWteIAycQrj0pZ85CDU3
        KZbHl9wRfCkw4HJ5iQ85buZ0I0zyl4Wtbb7/Hrnc=
Received: from localhost.localdomain (113.116.49.189 [113.116.49.189]) by mx.zoho.com.cn
        with SMTPS id 1604844207560846.3256977761386; Sun, 8 Nov 2020 22:03:27 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201108140307.1385745-10-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 09/10] ovl: introduce helper of syncfs writeback inode waiting
Date:   Sun,  8 Nov 2020 22:03:06 +0800
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

Introduce a helper ovl_wait_wb_inodes() to wait until all
target upper inodes finish writeback.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e5607a908d82..9a535fc11221 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -255,6 +255,36 @@ static void ovl_put_super(struct super_block *sb)
 =09ovl_free_fs(ofs);
 }
=20
+void ovl_wait_wb_inodes(struct ovl_fs *ofs)
+{
+=09LIST_HEAD(tmp_list);
+=09struct ovl_inode *oi;
+=09struct inode *upper;
+
+=09spin_lock(&ofs->syncfs_wait_list_lock);
+=09list_splice_init(&ofs->syncfs_wait_list, &tmp_list);
+
+=09while (!list_empty(&tmp_list)) {
+=09=09oi =3D list_first_entry(&tmp_list, struct ovl_inode, wait_list);
+=09=09list_del_init(&oi->wait_list);
+=09=09ihold(&oi->vfs_inode);
+=09=09spin_unlock(&ofs->syncfs_wait_list_lock);
+
+=09=09upper =3D ovl_inode_upper(&oi->vfs_inode);
+=09=09if (!mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK)) {
+=09=09=09iput(&oi->vfs_inode);
+=09=09=09goto wait_next;
+=09=09}
+
+=09=09filemap_fdatawait_keep_errors(upper->i_mapping);
+=09=09iput(&oi->vfs_inode);
+=09=09cond_resched();
+wait_next:
+=09=09spin_lock(&ofs->syncfs_wait_list_lock);
+=09}
+=09spin_unlock(&ofs->syncfs_wait_list_lock);
+}
+
 /* Sync real dirty inodes in upper filesystem (if it exists) */
 static int ovl_sync_fs(struct super_block *sb, int wait)
 {
--=20
2.26.2


