Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA4D2B160F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 07:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgKMG5b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 01:57:31 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17196 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726324AbgKMG5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:57:31 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1605250628; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ofv0uWhOwHJA6YfT5qvQJQnLCnRYI8fXM+59/oMWJ2oNaD30fA/f34DqO0AyrXmXESkGXJ5DWocDwI6IYscwRG3MVucynNd7rRCqu26z537shIerqqGoDopcGqB2f4r+eHj1kn1RXPUjFeEscxBjfA7sW3tJb9YxKNM2zoIe470=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605250628; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=xTG8TIoGOE4iq++iWSnXZTF7oknun/VvMTPo2hC5z0Y=; 
        b=lM6nE3J/YccHtai10/7gXSaqbh9orobrurxUGGCo3MgADtQH38n6HxGBCx7t/kWdWGl2vG/jNZbS/+iDOJ2rwfBaIREEpC4GOE1sDInTgEFrK0D2oqgAhGQfYLCMz0Z3KYK4TFr7y3RuXoG76IkwFqHVTBIkh1uxstfN4I8muNE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605250628;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=xTG8TIoGOE4iq++iWSnXZTF7oknun/VvMTPo2hC5z0Y=;
        b=Wfh0uGQh3iV7rXvIpjq4tjOaZMbkTF8T+3Yw0DfQ9g0x3ZQd+7wFk+4Wc4b+gK9x
        2KtJWDqi9oyGPLVp4TX1orXrNc+4ZjbS0eRqUa1Nt0VpIYOUDH9n8Z/0/33T4qB+Nql
        uElMrpxqONy+J02jmwp1nYTMlHsWCoGJoFpiTuvk=
Received: from localhost.localdomain (116.30.195.173 [116.30.195.173]) by mx.zoho.com.cn
        with SMTPS id 1605250627591598.3097181555864; Fri, 13 Nov 2020 14:57:07 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201113065555.147276-8-cgxu519@mykernel.net>
Subject: [RFC PATCH v4 7/9] ovl: cache dirty overlayfs' inode
Date:   Fri, 13 Nov 2020 14:55:53 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201113065555.147276-1-cgxu519@mykernel.net>
References: <20201113065555.147276-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now drop overlayfs' inode will sync dirty data,
so we change to only drop clean inode.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 82e001b97f38..982b3954b47c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -425,11 +425,20 @@ static void ovl_evict_inode(struct inode *inode)
 =09clear_inode(inode);
 }
=20
+static int ovl_drop_inode(struct inode *inode)
+{
+=09struct inode *upper =3D ovl_inode_upper(inode);
+
+=09if (!upper || !(inode->i_state & I_DIRTY_ALL))
+=09=09return 1;
+=09return generic_drop_inode(inode);
+}
+
 static const struct super_operations ovl_super_operations =3D {
 =09.alloc_inode=09=3D ovl_alloc_inode,
 =09.free_inode=09=3D ovl_free_inode,
 =09.destroy_inode=09=3D ovl_destroy_inode,
-=09.drop_inode=09=3D generic_delete_inode,
+=09.drop_inode=09=3D ovl_drop_inode,
 =09.evict_inode=09=3D ovl_evict_inode,
 =09.write_inode=09=3D ovl_write_inode,
 =09.put_super=09=3D ovl_put_super,
--=20
2.26.2


