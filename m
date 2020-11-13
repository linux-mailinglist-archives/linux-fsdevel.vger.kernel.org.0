Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC762B1602
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 07:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKMG5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 01:57:12 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17110 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbgKMG5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:57:12 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1605250613; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=OJGa2fcfyxjzbu6AIxkD0UAXvQRC6G45+olHvR+tMNLEmSDjd24uyEb8FsWo1vlQ7GAHOsnMRvfLwczMfsCfS86ZNitGu4a/rkRIV1vPiXtrKTWKWp9mncnxaxJuDxPEfOhxAWk6XnU1+QkL8Wml7fn+1e0s6f48i/nNnpBGU88=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605250613; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ZdSh8eREzPnVlAiCPIG4ZzRu+AUpP6611hYDLM3CBvA=; 
        b=djoK7g0dGQs8rKmXsm4bxZt3XAWJCJs8dBug6owYooLrhaUFuNbdEtLQyIW0ncKGa+OonTD2rdvJMzab97c7o23JTRxl3LYYY94sbBArvdKxICbln3lNtPnmUvLScD4VJstij3LYLyB669ct/JQCsSutasY9P/JfwuryJwRQI8U=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605250613;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=ZdSh8eREzPnVlAiCPIG4ZzRu+AUpP6611hYDLM3CBvA=;
        b=gCORlk4JijJuB0JBxE24pZGE9itXVfRRXaigLnif8HnXmfeVm8oxuQ+Q1ljBEgxx
        1kSUYROLpQddYLV+7Obr80NTeWOhpMpZWp5e6Hr78+4P9fyXItBWsZRIslOEJAwVSKB
        p7NHr4vkr3Y32tYS5XcHRjGVEGteLlBIvE6gRXKM=
Received: from localhost.localdomain (116.30.195.173 [116.30.195.173]) by mx.zoho.com.cn
        with SMTPS id 1605250610633346.4087931492967; Fri, 13 Nov 2020 14:56:50 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201113065555.147276-3-cgxu519@mykernel.net>
Subject: [RFC PATCH v4 2/9] ovl: implement ->writepages operation
Date:   Fri, 13 Nov 2020 14:55:48 +0800
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

Implement overlayfs' ->writepages operation so that
we can sync dirty data/metadata to upper filesystem.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/inode.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b584dca845ba..8cfa75e86f56 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -11,6 +11,7 @@
 #include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
+#include <linux/writeback.h>
 #include "overlayfs.h"
=20
=20
@@ -516,7 +517,20 @@ static const struct inode_operations ovl_special_inode=
_operations =3D {
 =09.update_time=09=3D ovl_update_time,
 };
=20
+static int ovl_writepages(struct address_space *mapping,
+=09=09=09  struct writeback_control *wbc)
+{
+=09struct inode *inode =3D mapping->host;
+=09struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
+=09struct inode *upper =3D ovl_inode_upper(inode);
+
+=09if (!ovl_should_sync(ofs))
+=09=09return 0;
+=09return sync_inode(upper, wbc);
+}
+
 static const struct address_space_operations ovl_aops =3D {
+=09.writepages=09=09=3D ovl_writepages,
 =09/* For O_DIRECT dentry_open() checks f_mapping->a_ops->direct_IO */
 =09.direct_IO=09=09=3D noop_direct_IO,
 };
--=20
2.26.2


