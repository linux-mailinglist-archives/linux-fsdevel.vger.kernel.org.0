Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC33415F92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241257AbhIWNZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 09:25:33 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17267 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241246AbhIWNZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:25:32 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Sep 2021 09:25:32 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1632402519; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=USt4P00lNZZPNFMSumV/GycrF2tO2fKY8/ClpqdludyrNoFvkUovVomhVmsX6bWSky95dzqEl/+q51Pp7wQjN98Kee5UnyA1eq5IOpQvyi8bmQP1fb9rOh0nsBjJcsMibjXgWgOoH8lRprGv4y/0+XzBvjBz6lqHIdEhla0L6sI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1632402519; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YcxkPiJx6Ikxp0ynHw1Dz+L3wBzcP9EXpk2Zzl1PCl4=; 
        b=eIgoR/BVZrZMhGaM2ewLhBaQsrwvTn7bThx3r/0azeLUM3tHIqwEDxYLWoYKQE2aKsP75NhsAG46RgGKnkSn0U4YeNzKUhnfRX6VamXWtV8lYLr8fWWEu59WHe4x2vu1620w7Nl4f4N5G55uoK/wJYzAzYbCn/S91QNvcFWb8P4=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1632402519;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=YcxkPiJx6Ikxp0ynHw1Dz+L3wBzcP9EXpk2Zzl1PCl4=;
        b=OAeo3R/bEBj3E+lbzVDff2g72aNLcqL3jxZRwYe4TiR9NCtnj55RAKPCJgb/cEQ1
        eShD7V7ouJPRFkSmStmbkZSFTq8dsE914Zk9hHVNsVRYIE4ijYEnQGc5qF7bCmsnwLG
        LsO4yHkMEskGjCW2LJjm/Nt1kBEWO77fJmP0lPzU=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1632402518088813.5030221103862; Thu, 23 Sep 2021 21:08:38 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210923130814.140814-4-cgxu519@mykernel.net>
Subject: [RFC PATCH v5 03/10] ovl: implement overlayfs' ->evict_inode operation
Date:   Thu, 23 Sep 2021 21:08:07 +0800
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

Implement overlayfs' ->evict_inode operation,
so that we can clear dirty flags of overlayfs inode.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 51886ba6130a..2ab77adf7256 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -406,11 +406,18 @@ static int ovl_remount(struct super_block *sb, int *f=
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
2.27.0


