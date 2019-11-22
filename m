Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05AB910685D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 09:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKVIxh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 03:53:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44756 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727072AbfKVIxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574412815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KaBg3z6ypXwEt8NT84FFw+9Q4ppCSEoAqcwSSVlq750=;
        b=QH/737/q9jDyCnULEyTvrOaqsDaqoVz17J2ap9IyYfWYUhKlkZOQXGiCPoMBQHE7QFaCIy
        b4MslgzpKEMtBCihiGaKkmekJ6e1sE8Cj9XbLVPQRB+D1ONk+qu4u5q27TwjwJcxTgb/hX
        VMjfoJcYru5jhNKpNR1TMVYpX0YzKbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-YafohYg_OfyH_AH0AS2N2Q-1; Fri, 22 Nov 2019 03:53:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B7D310054E3;
        Fri, 22 Nov 2019 08:53:31 +0000 (UTC)
Received: from orion.redhat.com (unknown [10.40.205.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 541D6608F3;
        Fri, 22 Nov 2019 08:53:30 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, darrick.wong@oracle.com, sandeen@sandeen.net
Subject: [PATCH 4/5] fibmap: Use bmap instead of ->bmap method in ioctl_fibmap
Date:   Fri, 22 Nov 2019 09:53:19 +0100
Message-Id: <20191122085320.124560-5-cmaiolino@redhat.com>
In-Reply-To: <20191122085320.124560-1-cmaiolino@redhat.com>
References: <20191122085320.124560-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: YafohYg_OfyH_AH0AS2N2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now we have the possibility of proper error return in bmap, use bmap()
function in ioctl_fibmap() instead of calling ->bmap method directly.

V6:
=09- Add a dummy bmap() definition so build does not break if
=09  CONFIG_BLOCK is not set
=09=09Reported-by: kbuild test robot <lkp@intel.com>
V4:
=09- Ensure ioctl_fibmap() returns 0 in case of error returned from
=09  bmap(). Otherwise we'll be changing the user interface (which
=09  returns 0 in case of error)
V3:
=09- Rename usr_blk to ur_block

V2:
=09- Use a local sector_t variable to asign the block number
=09  instead of using direct casting.
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ioctl.c         | 29 +++++++++++++++++++----------
 include/linux/fs.h |  7 +++++++
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index fef3a6bf7c78..6b589c873bc2 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -53,19 +53,28 @@ EXPORT_SYMBOL(vfs_ioctl);
=20
 static int ioctl_fibmap(struct file *filp, int __user *p)
 {
-=09struct address_space *mapping =3D filp->f_mapping;
-=09int res, block;
+=09struct inode *inode =3D file_inode(filp);
+=09int error, ur_block;
+=09sector_t block;
=20
-=09/* do we support this mess? */
-=09if (!mapping->a_ops->bmap)
-=09=09return -EINVAL;
 =09if (!capable(CAP_SYS_RAWIO))
 =09=09return -EPERM;
-=09res =3D get_user(block, p);
-=09if (res)
-=09=09return res;
-=09res =3D mapping->a_ops->bmap(mapping, block);
-=09return put_user(res, p);
+
+=09error =3D get_user(ur_block, p);
+=09if (error)
+=09=09return error;
+
+=09block =3D ur_block;
+=09error =3D bmap(inode, &block);
+
+=09if (error)
+=09=09ur_block =3D 0;
+=09else
+=09=09ur_block =3D block;
+
+=09error =3D put_user(ur_block, p);
+
+=09return error;
 }
=20
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b31075415ce..8e0e56bc4b0c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2862,9 +2862,16 @@ static inline ssize_t generic_write_sync(struct kioc=
b *iocb, ssize_t count)
=20
 extern void emergency_sync(void);
 extern void emergency_remount(void);
+
 #ifdef CONFIG_BLOCK
 extern int bmap(struct inode *, sector_t *);
+#else
+static inline int bmap(struct inode *,  sector_t *)
+{
+=09return -EINVAL;
+}
 #endif
+
 extern int notify_change(struct dentry *, struct iattr *, struct inode **)=
;
 extern int inode_permission(struct inode *, int);
 extern int generic_permission(struct inode *, int);
--=20
2.23.0

