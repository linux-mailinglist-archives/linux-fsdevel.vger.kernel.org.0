Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7EC415FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 15:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbhIWNZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 09:25:51 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17227 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241340AbhIWNZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1632402523; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=lblKkx98PmU32v/JOaN89LnX9lFru/3VCKt8x9LWCCbSK4aV8OPgF2WZ3CspPGqlsj76ko/pgKsMA6B4BSKt1llvthSSp+GF9qGr3IdoarAytpmE4jAR5naUTR8QdMbIiOt3E5VBpS/kCXn5628uF/YzZQ93GegiE4O/I6rwYHI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1632402523; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=aPd3vzQLUXRuk4ebbbXy1hr64pu+TM/TzIndQasNLMs=; 
        b=R8HPodvCEP1R0iYr4bUBUPRRSJItfmUq5o3QxyTDEhQNqx+y7MoqgWDRYveCLFGbwU+kDnrXoOB6i72X75l+LYYsuQDYGvn2qSKZ4dINE9PfHFE6aVHoy0YSAeU33zipSV5jvMGX0P5b6eDYFbZSE3DXcf7NHVSIOuUQYii4nhA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1632402523;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=aPd3vzQLUXRuk4ebbbXy1hr64pu+TM/TzIndQasNLMs=;
        b=PR5fCIU7NcfBHTykhNCmCkejwWHT5IVa8Ihxaybsa4vMopw2NGEYGfg96dtmcAbz
        d/EDrRWml/ola8aJTAiBCS6wARIjusRxjPq6sPZc2uQkYwFokQyV0GC2Zcf1YGxkq+2
        UfTFF2XRvGuU5uiDq0POLzhXrc8H04gA75BfsyUU=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1632402520970573.0190553351058; Thu, 23 Sep 2021 21:08:40 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210923130814.140814-8-cgxu519@mykernel.net>
Subject: [RFC PATCH v5 07/10] ovl: cache dirty overlayfs' inode
Date:   Thu, 23 Sep 2021 21:08:11 +0800
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210923130814.140814-1-cgxu519@mykernel.net>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now drop overlayfs' inode will sync dirty data,
so we change to only drop clean inode.

The purpose of doing this is to keep compatible
behavior with before because without this change
dropping overlayfs inode will not trigger syncing
of underlying dirty inode.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index cddae3ca2fa5..bf4000eb9be8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -441,11 +441,25 @@ static int ovl_write_inode(struct inode *inode,
 =09return ret;
 }
=20
+/*
+ * In iput_final(), clean inode will drop directly and dirty inode will
+ * keep in the cache until write back to sync dirty data then add to lru
+ * list to wait reclaim.
+ */
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
2.27.0


