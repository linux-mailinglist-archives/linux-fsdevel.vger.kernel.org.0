Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615CE297FF5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 04:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766972AbgJYDma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 23:42:30 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17172 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1766952AbgJYDm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 23:42:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603597315; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Uio+yvAbRvpppYuSFlt6C6AvUIfdDpmfIWeAHmAScHpHJhjhMmoICf68I1N5IbzNtMvTIwdJnehkY6tNRFkZqnbPWeNO3Jj1vNew0fLLDDOfbxzIxieuDKdga/6FKhUiRZKQkpA9SOgFWl6J0RQ4yhSUAj4vRMyda8DoRemtrx4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1603597315; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=oDIxrUfghq2f7rf9mI7jR3OrOFcG8ituLCpBBf/8iP0=; 
        b=gHz016tmd8z4NzRcdLYAhtBUXvXUc/lfsMmGIWNxrbhJTQTJcpUCSAKCKw++ha8y0+kjycZw0mbicPWSDU+iTl8dxxVoQHb5wCB7q7fZiYLZe1a2HIxJeZOZ18nOPY/mWcl/EJEaz2M92oMeSAdgTSpPS8OWhAIo5ub4G2L09yw=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1603597315;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=oDIxrUfghq2f7rf9mI7jR3OrOFcG8ituLCpBBf/8iP0=;
        b=Di4qBkqGuTx2y/KwFaH0CU58oYobH8jNLK4u3lexOW+wwvO8deox10L2pUdXpofk
        TvvDVpmAb2bNWwDzQfw7UnyCRd6KzdpPkO9I4jINP3UaGA7aVpH17LWuwwa5SHY8pOu
        eFqp+nV/D7Y08m7JY9Opyg4LBWtFHwqr5oFmE2gU=
Received: from localhost.localdomain (113.88.132.7 [113.88.132.7]) by mx.zoho.com.cn
        with SMTPS id 1603597313967178.218115280814; Sun, 25 Oct 2020 11:41:53 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201025034117.4918-8-cgxu519@mykernel.net>
Subject: [RFC PATCH v2 7/8] ovl: cache dirty overlayfs' inode
Date:   Sun, 25 Oct 2020 11:41:16 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025034117.4918-1-cgxu519@mykernel.net>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
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
 fs/overlayfs/super.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 960e79e7a8b5..1d04117fb6ad 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -421,11 +421,21 @@ static int ovl_write_inode(struct inode *inode,
 =09return ret;
 }
=20
+int ovl_drop_inode(struct inode *inode)
+{
+=09struct inode *upper =3D ovl_inode_upper(inode);
+
+=09if (!upper || !(inode->i_state & I_DIRTY_ALL))
+=09=09return 1;
+
+=09return generic_drop_inode(inode);
+}
+
 static const struct super_operations ovl_super_operations =3D {
 =09.alloc_inode=09=3D ovl_alloc_inode,
 =09.free_inode=09=3D ovl_free_inode,
 =09.destroy_inode=09=3D ovl_destroy_inode,
-=09.drop_inode=09=3D generic_delete_inode,
+=09.drop_inode=09=3D ovl_drop_inode,
 =09.write_inode=09=3D ovl_write_inode,
 =09.evict_inode=09=3D ovl_evict_inode,
 =09.put_super=09=3D ovl_put_super,
--=20
2.26.2


