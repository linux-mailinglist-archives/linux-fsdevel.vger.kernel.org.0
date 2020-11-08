Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A33C2AAB40
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgKHOEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:04:06 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17153 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728363AbgKHOEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:04:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604844205; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=SyWtE7/Bv19ZpzS7Md8FwbFWM4Qa5JlNdMXJmSRiJQpZdYj1OXWyFnoRdl4kaCG1URRiVPR0TfaKjV+nLZhz8npbPkQZdKbN+/HpON9GdgxfK3WD3jydu+m64dhz1lIYOVX5tC4SqtAc/YpOtJR0NON31ZIAMgkAv2J0iUSzbQ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604844205; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=rwSqy0IB5IFNNIniPqVlfmHQOsetCWP9pAfz+bgiWLc=; 
        b=hw6Xb80ms39T6jy4w5F5mq67dFM9oq02YeSa6t6leaO5YTJalmGIjRDro8IYxak4iJtGp+eEHwfAJM8HdVupIyjv5lDjkWFB0vh7fdLFBFPI1/I7JJc4g32CrL/sBAuQ6jZ/gWtKS8sYrx2y44t7dlMmzPtAtyREHZUJ8jD6Zck=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604844205;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=rwSqy0IB5IFNNIniPqVlfmHQOsetCWP9pAfz+bgiWLc=;
        b=BvwIci7Sx2kV0v7A1MdIk4YKr2WzSS4ENv35gehIrsKL0Ja+n6rNwerjnxNrbloC
        Y9Nz+aY6QHEvxEHRNOpcwIOxqhtm0AsOHXgJgRxWGmIpz/g3qzgOQ7F5sdXt4stz45+
        z0iFwD99Bcsph9N7Co/oTUhYM9Sm5jgBB7S77I2A=
Received: from localhost.localdomain (113.116.49.189 [113.116.49.189]) by mx.zoho.com.cn
        with SMTPS id 1604844204313604.0371525151885; Sun, 8 Nov 2020 22:03:24 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201108140307.1385745-5-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 04/10] ovl: implement overlayfs' ->evict_inode operation
Date:   Sun,  8 Nov 2020 22:03:01 +0800
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

Implement overlayfs' ->evict_inode operation,
so that we can clear all inode dirty flags.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 1e21feb87297..694eff76eb09 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -391,11 +391,26 @@ static int ovl_remount(struct super_block *sb, int *f=
lags, char *data)
 =09return ret;
 }
=20
+static void ovl_evict_inode(struct inode *inode)
+{
+=09struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
+
+=09if (!list_empty(&OVL_I(inode)->wait_list)) {
+=09=09spin_lock(&ofs->syncfs_wait_list_lock);
+=09=09if (!list_empty(&OVL_I(inode)->wait_list))
+=09=09=09list_del(&OVL_I(inode)->wait_list);
+=09=09spin_unlock(&ofs->syncfs_wait_list_lock);
+=09}
+=09inode->i_state &=3D ~I_DIRTY_ALL;
+=09clear_inode(inode);
+}
+
 static const struct super_operations ovl_super_operations =3D {
 =09.alloc_inode=09=3D ovl_alloc_inode,
 =09.free_inode=09=3D ovl_free_inode,
 =09.destroy_inode=09=3D ovl_destroy_inode,
 =09.drop_inode=09=3D generic_delete_inode,
+=09.evict_inode=09=3D ovl_evict_inode,
 =09.put_super=09=3D ovl_put_super,
 =09.sync_fs=09=3D ovl_sync_fs,
 =09.statfs=09=09=3D ovl_statfs,
--=20
2.26.2


