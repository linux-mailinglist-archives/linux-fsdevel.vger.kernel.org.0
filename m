Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83001D4730
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 09:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgEOHhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 03:37:39 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21122 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbgEOHhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 03:37:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589527305; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=MrnTR8zGCASQF9RDnWUIp17kLCy0mOnKPbvfEe7L7dGUBAd1AsY5oB4VEbtm39ZOcEhfPoENbSHBsTizfc1HvESnQj0KayULB9JY7Z6GEiW1X2wjd4okAGjsVx0YDN5c3HMyMPhdjylcplxEh5FtoQwohx5F8k5x1Ru/o3t3cK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589527305; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=QI2uO+6qInvA6nTOODT6EV5/ob+2kzYLGLBF57B3AHs=; 
        b=FQjnL0r1JP09LVUG6+it7bu52E+QeaFX6FZ0C3bIeBzumeat2IB+rBWJlXOBcNv4MsPJpo5xgw0SGsajBI2SEN2t33CV11Z6TmmoVkwj7gauqWI/oKJ7RNn2E+XCsixrdYDPcA3bOtbz9qQ1MpIeM2vv5uNUW3qU26gqss6qL90=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589527305;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=QI2uO+6qInvA6nTOODT6EV5/ob+2kzYLGLBF57B3AHs=;
        b=K7a2novINPl1o21KQcrX1Ap/1rD7egdzg8PObF2wh7l0ttSkSJ+cQaQOQdTbC6Gh
        mpdMg6Ld28/zvTSXhUZ88oDYbXLft89sBpINTlyvDoP3Cu3etJiTKbP+UNUJys5vGS9
        PTPHeaXyX5fkAkJTF+w8MgdViZnpg/YjCXq64y+o=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1589527302790519.7614667820507; Fri, 15 May 2020 15:21:42 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200515072047.31454-5-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 4/9] debugfs: Adjust argument for lookup_positive_unlocked()
Date:   Fri, 15 May 2020 15:20:42 +0800
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515072047.31454-1-cgxu519@mykernel.net>
References: <20200515072047.31454-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Set 0 as lookup flag argument when calling lookup_positive_unlocked(),
because we don't hope to drop negative dentry in lookup.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/debugfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index b7f2e971ecbc..df4f37a6a9ab 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -299,7 +299,7 @@ struct dentry *debugfs_lookup(const char *name, struct =
dentry *parent)
 =09if (!parent)
 =09=09parent =3D debugfs_mount->mnt_root;
=20
-=09dentry =3D lookup_positive_unlocked(name, parent, strlen(name));
+=09dentry =3D lookup_positive_unlocked(name, parent, strlen(name), 0);
 =09if (IS_ERR(dentry))
 =09=09return NULL;
 =09return dentry;
--=20
2.20.1


