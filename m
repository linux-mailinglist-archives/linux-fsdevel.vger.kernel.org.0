Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA72D2B1609
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 07:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKMG50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 01:57:26 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17117 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbgKMG5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:57:25 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1605250625; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=YdFsYJG7LelMshOqLqEPOhn9ZgUNkx5Hm93qrSqAeMT8ao3wDGe1Sj0IiaFvuqp85JzshJhwF2QqWBmhOZhcpTa6bZuakI5W+1Z3xy0AcSuOVOsG5dFSjjzxbCTWTOjdtdULmx81RhPVwMP4FXLxg3+JLHRS1DHxRk/nZ9jMumY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605250625; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=B0+tbtLn9OljLMIRvWu0xE+lpLb1nEucaDTR/MyR4K4=; 
        b=DbBcgnrw412gv5Ol9frR2pdHlVg/CxMhohfF80w/4aOeuSNKA5MS1LBF9vrSUN9QccSI2Yh9aXnNX+TaTAScEPZh0LF9HXYzUf66DN0foil+765+GEaqvuHwO32JqHRY1HvyyaCC9DsT17J7Ey5LgNlgEyO0Rp0G2mxZRInnST4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605250625;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=B0+tbtLn9OljLMIRvWu0xE+lpLb1nEucaDTR/MyR4K4=;
        b=f5A7qU7rRjpR3zmSCud0xTmb1B5R8gF5rVKe8hliomkHECMls/seE6QZ4c9jVje8
        KpV+tPkttdgxWadXpe/Iuuz2Uw+kB4DHYDIDeb1oJfWY35E1BC9KRFmuYKX8XTQcyFf
        tL4Gcew5qMHOJChUmDmUT+2WKL7q7gSrYY+7a9n0=
Received: from localhost.localdomain (116.30.195.173 [116.30.195.173]) by mx.zoho.com.cn
        with SMTPS id 1605250623497596.5506827080176; Fri, 13 Nov 2020 14:57:03 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201113065555.147276-4-cgxu519@mykernel.net>
Subject: [RFC PATCH v4 3/9] ovl: implement overlayfs' ->evict_inode operation
Date:   Fri, 13 Nov 2020 14:55:49 +0800
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

Implement overlayfs' ->evict_inode operation,
so that we can clear all inode dirty flags.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d1e546abce87..883172ac8a12 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -390,11 +390,18 @@ static int ovl_remount(struct super_block *sb, int *f=
lags, char *data)
 =09return ret;
 }
=20
+static void ovl_evict_inode(struct inode *inode)
+{
+=09inode->i_state &=3D ~I_DIRTY_ALL;
+=09clear_inode(inode);
+}
+
 static const struct super_operations ovl_super_operations =3D {
 =09.alloc_inode=09=3D ovl_alloc_inode,
 =09.free_inode=09=3D ovl_free_inode,
 =09.destroy_inode=09=3D ovl_destroy_inode,
 =09.drop_inode=09=3D generic_delete_inode,
+=09.evict_inode=09=3D ovl_evict_inode,
 =09.put_super=09=3D ovl_put_super,
 =09.sync_fs=09=3D ovl_sync_fs,
 =09.statfs=09=09=3D ovl_statfs,
--=20
2.26.2


