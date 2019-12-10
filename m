Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C7F118BEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 16:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfLJPEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 10:04:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23283 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727568AbfLJPEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575990246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFVcksSLCjF9q7kRUkUqKvCGPoHM1ZfRxRp7U8aUWHA=;
        b=FZV9y6ILhr4LivZvVOfiQnB1Bb7Swtaj4yfnLl4y4Cl+NGZ0P7rzZn7XnPtRvqKEHEEiel
        FH+f8Qo1EvbMnsUT6EJ+2h4apEFov9HUIEmIZa1fmltarAFegUefD6ehctPS9rrypnaHQ8
        4qGDEIJWSp0mehUz/j4nkbyG1dYc4Qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-m7b-B7QIN166uDhlLMThDA-1; Tue, 10 Dec 2019 10:04:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12F249799F;
        Tue, 10 Dec 2019 15:04:04 +0000 (UTC)
Received: from orion.redhat.com (ovpn-205-230.brq.redhat.com [10.40.205.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3676F1001925;
        Tue, 10 Dec 2019 15:04:03 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de
Subject: [PATCH 4/5] fibmap: Use bmap instead of ->bmap method in ioctl_fibmap
Date:   Tue, 10 Dec 2019 16:03:43 +0100
Message-Id: <20191210150344.112181-5-cmaiolino@redhat.com>
In-Reply-To: <20191210150344.112181-1-cmaiolino@redhat.com>
References: <20191210150344.112181-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: m7b-B7QIN166uDhlLMThDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now we have the possibility of proper error return in bmap, use bmap()
function in ioctl_fibmap() instead of calling ->bmap method directly.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ioctl.c         | 29 +++++++++++++++++++----------
 include/linux/fs.h |  9 ++++++++-
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 2f5e4e5b97e1..83f36feaf781 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -54,19 +54,28 @@ EXPORT_SYMBOL(vfs_ioctl);
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
index c5b86e53e568..7d9bda8ef3db 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2865,9 +2865,16 @@ static inline ssize_t generic_write_sync(struct kioc=
b *iocb, ssize_t count)
=20
 extern void emergency_sync(void);
 extern void emergency_remount(void);
+
 #ifdef CONFIG_BLOCK
-extern int bmap(struct inode *, sector_t *);
+extern int bmap(struct inode *inode, sector_t *block);
+#else
+static inline int bmap(struct inode *inode,  sector_t *block)
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

