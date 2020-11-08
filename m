Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA58F2AAB41
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgKHOEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:04:06 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17152 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727570AbgKHOEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:04:05 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604844205; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=BKtvap62UzG0f6dME/cwvpzkz3sDm8w5ma0+sASIdvHQLQ8FA1pJQ7fJETCxYbcHPl+uNOg/azpXM4bf4sddwxtSjJQG3oVhwPprb1wAF9Ty5hXTzQNzp2ve9CwGVPCzwi3kljBIvChoLmT6v7BeYDNLDiyRVBibP51gbYI5alI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604844205; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9en0t344dZx9gFZ3T+wZUNYnBIjQcpi5KhVT7rOuUWw=; 
        b=LzsbXCG9sq5O5PahrLnc/JpVMi7Pq+1fsU95PHy0aQpTHSkTHLONQcOEz1rE6iNVUPrL6andLq5o4DC+ZYov6aEQayYFrUUa0IreOHEb7bVDEu2Hz3Cu2Ig2i7131RsOS0Xt9SfVUJJ3ZqXhQ0MfBnBtYTUUsY5zgVhSvMpX8tI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604844205;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=9en0t344dZx9gFZ3T+wZUNYnBIjQcpi5KhVT7rOuUWw=;
        b=Be8ZJ51p7eqMmahS9JGWQYscfllTzS6i8MKXtwSR7UEKw2ozX1pg4ZpbyesV50O9
        OdQnXwG6SJRToBWz2n6kycrdmXohRlgkgJsxdXSv/kjrAST90Qw+RfpOiwaEEw1LxkH
        fXIv0cG5EULG1vGNnrOmNLQXqy46c44d/e8+6dOA=
Received: from localhost.localdomain (113.116.49.189 [113.116.49.189]) by mx.zoho.com.cn
        with SMTPS id 1604844202883136.1258273953929; Sun, 8 Nov 2020 22:03:22 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201108140307.1385745-3-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 02/10] ovl: introduce waiting list for syncfs
Date:   Sun,  8 Nov 2020 22:02:59 +0800
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

Introduce extra waiting list to collect inodes
which are in writeback process.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/ovl_entry.h | 5 +++++
 fs/overlayfs/super.c     | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 1b5a2094df8e..72334662253a 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -79,6 +79,9 @@ struct ovl_fs {
 =09atomic_long_t last_ino;
 =09/* Whiteout dentry cache */
 =09struct dentry *whiteout;
+=09/* syncfs waiting list and lock */
+=09struct list_head syncfs_wait_list;
+=09spinlock_t syncfs_wait_list_lock;
 };
=20
 static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
@@ -129,6 +132,8 @@ struct ovl_inode {
=20
 =09/* synchronize copy up and more */
 =09struct mutex lock;
+=09/* link to ofs->syncfs_wait_list */
+=09struct list_head wait_list;
 };
=20
 static inline struct ovl_inode *OVL_I(struct inode *inode)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d1e546abce87..1e21feb87297 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -184,6 +184,7 @@ static struct inode *ovl_alloc_inode(struct super_block=
 *sb)
 =09oi->lower =3D NULL;
 =09oi->lowerdata =3D NULL;
 =09mutex_init(&oi->lock);
+=09INIT_LIST_HEAD(&oi->wait_list);
=20
 =09return &oi->vfs_inode;
 }
@@ -1869,6 +1870,9 @@ static int ovl_fill_super(struct super_block *sb, voi=
d *data, int silent)
 =09if (!ofs)
 =09=09goto out;
=20
+=09INIT_LIST_HEAD(&ofs->syncfs_wait_list);
+=09spin_lock_init(&ofs->syncfs_wait_list_lock);
+
 =09err =3D super_setup_bdi(sb);
 =09if (err)
 =09=09goto out_err;
--=20
2.26.2


