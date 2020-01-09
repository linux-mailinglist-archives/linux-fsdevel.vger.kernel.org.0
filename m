Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E64AA135A25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgAINbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:31:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20554 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729114AbgAINbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578576663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lRmNoC4UPTCVIngwiJ4U4bmcbrm7KHI2dsz/lFIHqH4=;
        b=M8HpsDzwYG3TFlr0o8SsQi1RlpVjZQ6MYQOI7jB3FbUy8nnMDYr+lqOI1cafLpVEK40Rew
        GvjBwLye4Z7niMuMsDZy2EIYVzluRSOzNmgVdy/PSqZN+XCHUZyrs9F9w72N7cgnB2mfzw
        1s3DTgLhiAyi5LOMN+I6h+hDLIq4WIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-7McnWKq_Ml25IKmuBr_kPw-1; Thu, 09 Jan 2020 08:31:00 -0500
X-MC-Unique: 7McnWKq_Ml25IKmuBr_kPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD560190D340;
        Thu,  9 Jan 2020 13:30:58 +0000 (UTC)
Received: from orion.redhat.com (ovpn-205-210.brq.redhat.com [10.40.205.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B4D160E1C;
        Thu,  9 Jan 2020 13:30:57 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk
Subject: [PATCH 4/5] fibmap: Use bmap instead of ->bmap method in ioctl_fibmap
Date:   Thu,  9 Jan 2020 14:30:44 +0100
Message-Id: <20200109133045.382356-5-cmaiolino@redhat.com>
In-Reply-To: <20200109133045.382356-1-cmaiolino@redhat.com>
References: <20200109133045.382356-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now we have the possibility of proper error return in bmap, use bmap()
function in ioctl_fibmap() instead of calling ->bmap method directly.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ioctl.c         | 30 ++++++++++++++++++++----------
 include/linux/fs.h |  9 ++++++++-
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 7c9a5df5a597..0ed5fb2d6c19 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -54,19 +54,29 @@ EXPORT_SYMBOL(vfs_ioctl);
=20
 static int ioctl_fibmap(struct file *filp, int __user *p)
 {
-	struct address_space *mapping =3D filp->f_mapping;
-	int res, block;
+	struct inode *inode =3D file_inode(filp);
+	int error, ur_block;
+	sector_t block;
=20
-	/* do we support this mess? */
-	if (!mapping->a_ops->bmap)
-		return -EINVAL;
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
-	res =3D get_user(block, p);
-	if (res)
-		return res;
-	res =3D mapping->a_ops->bmap(mapping, block);
-	return put_user(res, p);
+
+	error =3D get_user(ur_block, p);
+	if (error)
+		return error;
+
+	block =3D ur_block;
+	error =3D bmap(inode, &block);
+
+	if (error)
+		ur_block =3D 0;
+	else
+		ur_block =3D block;
+
+	if (put_user(ur_block, p))
+		error =3D -EFAULT;
+
+	return error;
 }
=20
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 092699e99faa..90a72f7185b7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2864,9 +2864,16 @@ static inline ssize_t generic_write_sync(struct ki=
ocb *iocb, ssize_t count)
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
+	return -EINVAL;
+}
 #endif
+
 extern int notify_change(struct dentry *, struct iattr *, struct inode *=
*);
 extern int inode_permission(struct inode *, int);
 extern int generic_permission(struct inode *, int);
--=20
2.23.0

