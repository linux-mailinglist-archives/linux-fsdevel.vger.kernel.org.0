Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8212B1607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 07:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKMG5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 01:57:22 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17163 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbgKMG5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:57:21 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1605250629; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=cd/r+FdpqhCnKkX3xMu4TUI+spYTT1m+d2ggyzYzTDjcG4EuqMrWO+fj2ghAPYDWaDv25aCNKqguQQzMkHHuFegFRwF0Lpofqpiiq5fLDIU2R67vFtONETKN3ZITIGBxFF/5qD1tSDP2rRgDlAi/U7poG8loCurGfHPbSgw+8hU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605250629; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Tlxw7j172mvgTwkWSXC4EiCFRBOcSo+hBBmaIMmXsg4=; 
        b=h1RKBMbWqkthXkks2NHWKM0DvRwiYbQmnpEevia1bX1FD8deCJoilcKg4VjPTi8o9hzTgjSSG8YdblvaJW9lAU7WUlCx0OtjWe1PALgl4xwlrOp4so0ou1TSihaVeHxLl1VIeWlo0cLcbg/YOQiUMg/i7y6bINh40HqTqBzAcgM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605250629;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=Tlxw7j172mvgTwkWSXC4EiCFRBOcSo+hBBmaIMmXsg4=;
        b=Lqm3x8zyRHTSFas/hvciSYX5gMZI+EAVuJHUFG2+9T2ml0OFG5iApQLBbi4oZtwu
        sDqNtbkGQAGPF97RsmKUJ7Ot4lQ0LyY4pQXgvYS2yVHVp2W53c7EUMM0rPxZnVBZ65V
        l//3yMi3cBKbzbmJHMIrPea507V0laPOBGi/Tpbo=
Received: from localhost.localdomain (116.30.195.173 [116.30.195.173]) by mx.zoho.com.cn
        with SMTPS id 1605250626771895.4721674647662; Fri, 13 Nov 2020 14:57:06 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201113065555.147276-7-cgxu519@mykernel.net>
Subject: [RFC PATCH v4 6/9] ovl: implement overlayfs' ->write_inode operation
Date:   Fri, 13 Nov 2020 14:55:52 +0800
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

Implement overlayfs' ->write_inode to sync dirty data
and redirty overlayfs' inode if necessary.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 883172ac8a12..82e001b97f38 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -390,6 +390,35 @@ static int ovl_remount(struct super_block *sb, int *fl=
ags, char *data)
 =09return ret;
 }
=20
+static int ovl_write_inode(struct inode *inode,
+=09=09=09   struct writeback_control *wbc)
+{
+=09struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
+=09struct inode *upper =3D ovl_inode_upper(inode);
+=09unsigned long iflag =3D 0;
+=09int ret =3D 0;
+
+=09if (!upper)
+=09=09return 0;
+
+=09if (!ovl_should_sync(ofs))
+=09=09return 0;
+
+=09if (upper->i_sb->s_op->write_inode)
+=09=09ret =3D upper->i_sb->s_op->write_inode(inode, wbc);
+
+=09if (mapping_writably_mapped(upper->i_mapping) ||
+=09    mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
+=09=09iflag |=3D I_DIRTY_PAGES;
+
+=09iflag |=3D upper->i_state & I_DIRTY_ALL;
+
+=09if (iflag)
+=09=09ovl_mark_inode_dirty(inode);
+
+=09return ret;
+}
+
 static void ovl_evict_inode(struct inode *inode)
 {
 =09inode->i_state &=3D ~I_DIRTY_ALL;
@@ -402,6 +431,7 @@ static const struct super_operations ovl_super_operatio=
ns =3D {
 =09.destroy_inode=09=3D ovl_destroy_inode,
 =09.drop_inode=09=3D generic_delete_inode,
 =09.evict_inode=09=3D ovl_evict_inode,
+=09.write_inode=09=3D ovl_write_inode,
 =09.put_super=09=3D ovl_put_super,
 =09.sync_fs=09=3D ovl_sync_fs,
 =09.statfs=09=09=3D ovl_statfs,
--=20
2.26.2


