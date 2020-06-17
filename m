Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89491FC334
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 03:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFQBJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 21:09:23 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17137 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgFQBJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592356114; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Kg80NpiZ6G6F3xSAGDTmPi+389WQXT6epuZ6HVbihOdb+/v9DCsruLPOAazFQl/+uFEyukdnWCIi1IwZaBDHK05Zr4ziL12ybFuC8amOvk+Ww0n/o7Y7WIFzbvtaptyzlo3OrALbCkOmky+9pVXiENbo66ZNkvaxtfr1wgspxxQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1592356114; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=MrAvKdxcdqiJd5DjeCb8Bkl8BV5nhHQ3uenaJl9pDlU=; 
        b=jc+ugjsGqyAY7v2/+9w1ooUWNVvIPDN7YtCDMOPGQFcYkuNVH6EjZPCdoivVReLMNQcpU6M8qPISraxWr/1RYr6CX43ugjWltzmqniudAGwgHhhlITVoHtlDlw4ZOBVmpEqbjp6XUh/4b9veVmP83o7ZbgWqL9G24iGIPmZbrQM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1592356114;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=MrAvKdxcdqiJd5DjeCb8Bkl8BV5nhHQ3uenaJl9pDlU=;
        b=WNsL+CApvRsmBWp5TPClE+FvRb6nQlmjQFjRpWujuX/C/MX1Cf7PEQtkA/QZyvfs
        juSMumdPaj/cI0hPoeTtTePy+PRXycY5lNVyM7uzca+gQ3i6pQnDTcdE9FSWmrFWen9
        H6ZDqFrndD8UxjAcEse7nLiX8t/yVoJ+9WjWVXgA=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1592356111416672.9028709689728; Wed, 17 Jun 2020 09:08:31 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200617010827.16048-1-cgxu519@mykernel.net>
Subject: [PATCH] vfs/xattr: strengthen error check to avoid unexpected result
Date:   Wed, 17 Jun 2020 09:08:27 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The variable error is ssize_t, which is signed and will
cast to unsigned when comapre with variable size, so add
a check to avoid unexpected result in case of negative
value of error.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index e13265e65871..9d0f12682c86 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -356,7 +356,7 @@ vfs_listxattr(struct dentry *dentry, char *list, size_t=
 size)
 =09=09error =3D inode->i_op->listxattr(dentry, list, size);
 =09} else {
 =09=09error =3D security_inode_listsecurity(inode, list, size);
-=09=09if (size && error > size)
+=09=09if (error >=3D 0 && size && error > size)
 =09=09=09error =3D -ERANGE;
 =09}
 =09return error;
--=20
2.20.1


