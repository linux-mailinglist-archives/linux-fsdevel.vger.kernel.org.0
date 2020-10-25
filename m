Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E8B297FEF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 04:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766965AbgJYDm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 23:42:28 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17171 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1766956AbgJYDm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 23:42:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603597314; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=cJglc88SO8/m5vvnaacGcQMt4ag/Bcta6ROObVljeZRH8kYjtQzdY6KKT8TyrzE86gAmYDfzQceZ4sT+NTDovmCj2rIyaBlLtnXTGw9jCzIPlyXczxagjuxCqDupOAGdUYXtJ/js0dmUJKpik8pSmZXKgZIsZQOBse8ABh8i3ZU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1603597314; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YQPSQWMCt9yX/niXxA9Y98SHIHVYHo3mXqsbyMEGE6M=; 
        b=ZWl2wCbuZIxLUKfIaGOCGr3hY4MR7Rqd3Y6k9JU1y9DjF0byLplTYl/GpBiaFA96sY/FU/IeaY83SsUBFJSunOfR0Y3Er1h0eZ4wNNZv9L8nSBCZrfN/B9el6fK8mVA7xnE+R6CIKeB59cBdivvIRgdRmiNwbuYDToyc09eyJ0U=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1603597314;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=YQPSQWMCt9yX/niXxA9Y98SHIHVYHo3mXqsbyMEGE6M=;
        b=cCIvohuxRjAO3GwMucSWhaGL1vziikLfVmMSYKgDcDwTe+mwPdPMci0hM3acuX3D
        xfyP3dyddxmgq9AqGH6UukIetWm8VUMMzbOlVDrIbaOXqf0aJ9Bz8UotLetxDomXOh1
        AIrcYZxMrtL7V3ITdTW4b3YWw0b4oV+4Tl/L27e4=
Received: from localhost.localdomain (113.88.132.7 [113.88.132.7]) by mx.zoho.com.cn
        with SMTPS id 1603597313166589.9733889441386; Sun, 25 Oct 2020 11:41:53 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201025034117.4918-7-cgxu519@mykernel.net>
Subject: [RFC PATCH v2 6/8] ovl: implement overlayfs' ->write_inode operation
Date:   Sun, 25 Oct 2020 11:41:15 +0800
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

Implement overlayfs' ->write_inode to sync dirty data
and redirty overlayfs' inode if necessary.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5d7e12b8bd1f..960e79e7a8b5 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include <linux/writeback.h>
 #include "overlayfs.h"
=20
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -396,11 +397,36 @@ static void ovl_evict_inode (struct inode *inode)
 =09clear_inode(inode);
 }
=20
+static int ovl_write_inode(struct inode *inode,
+=09=09=09   struct writeback_control *wbc)
+{
+=09struct inode *upper =3D ovl_inode_upper(inode);
+=09unsigned long iflag =3D 0;
+=09int ret =3D 0;
+
+=09if (!upper)
+=09=09return 0;
+
+=09if (upper->i_sb->s_op->write_inode)
+=09=09ret =3D upper->i_sb->s_op->write_inode(inode, wbc);
+
+=09iflag |=3D upper->i_state & I_DIRTY_ALL;
+=09if (mapping_writably_mapped(upper->i_mapping) ||
+=09    mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
+=09=09iflag |=3D I_DIRTY_PAGES;
+
+=09if (iflag)
+=09=09ovl_mark_inode_dirty(inode);
+
+=09return ret;
+}
+
 static const struct super_operations ovl_super_operations =3D {
 =09.alloc_inode=09=3D ovl_alloc_inode,
 =09.free_inode=09=3D ovl_free_inode,
 =09.destroy_inode=09=3D ovl_destroy_inode,
 =09.drop_inode=09=3D generic_delete_inode,
+=09.write_inode=09=3D ovl_write_inode,
 =09.evict_inode=09=3D ovl_evict_inode,
 =09.put_super=09=3D ovl_put_super,
 =09.sync_fs=09=3D ovl_sync_fs,
--=20
2.26.2


