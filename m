Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A7E45883C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 04:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbhKVDTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 22:19:36 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17241 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229870AbhKVDTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 22:19:34 -0500
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Nov 2021 22:19:34 EST
ARC-Seal: i=1; a=rsa-sha256; t=1637550057; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=eY0YtbaY/soIiaCdiOOidKcTUawRhdshegAfy+e2SF+zGk0FgVesxbhhBSK9a+3Ew3Gbv4KiDcgiqLSvxV8412Flw4UBxDb+x6+2S6CeV17+6PYM0jXqX3me21nEoEH64cESOBT0gpSKf604guR3CluRLGcFBslPNRB8/de8tmM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637550057; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=hfXyzGcOlPoLrPQVGfEwV/ALvAXxxFIn8RyNQQA7A7g=; 
        b=b5+R5pIYI8odWO+izB62xkuC0n+tIrpdri1lkcyN8fxOELuq8Gj3SJTeRMmgwoat1sOR/sIxZwXDBj5Au1CI2LUOvKPnOEQW0Aa5thcQlD5i7acAw66Kg8c7PPLYeEoQ026VsBnLdYJKw8OwSTAEN3gvOM9LBgr6+szYFk6kTzg=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637550057;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=hfXyzGcOlPoLrPQVGfEwV/ALvAXxxFIn8RyNQQA7A7g=;
        b=ZzVSTDZqosTiCkcBE6HP1ykz2ZzERDzcyRoc4VZ5bqJYXghqLO40M5/R1djxVSJl
        RA96GT4jY5hMKWEklMdlCx7WAptY+AhQbFjM+Dr9wPdJ9hQQrrnamYUhz0iSW/5Ws+C
        V+Q9ACXkT2RzGBiD/pMfz6SQM1z/+p1hN+EJ9b2w=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1637550055397164.47965855404595; Mon, 22 Nov 2021 11:00:55 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Message-ID: <20211122030038.1938875-3-cgxu519@mykernel.net>
Subject: [RFC PATCH V6 2/7] ovl: mark overlayfs inode dirty when it has upper
Date:   Mon, 22 Nov 2021 11:00:33 +0800
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211122030038.1938875-1-cgxu519@mykernel.net>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chengguang Xu <charliecgxu@tencent.com>

We simply mark overlayfs inode dirty when it has upper,
it's much simpler than mark dirtiness on modification.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
---
 fs/overlayfs/inode.c | 4 +++-
 fs/overlayfs/util.c  | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 1f36158c7dbe..027ffc0a2539 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -778,8 +778,10 @@ void ovl_inode_init(struct inode *inode, struct ovl_in=
ode_params *oip,
 {
 =09struct inode *realinode;
=20
-=09if (oip->upperdentry)
+=09if (oip->upperdentry) {
 =09=09OVL_I(inode)->__upperdentry =3D oip->upperdentry;
+=09=09mark_inode_dirty(inode);
+=09}
 =09if (oip->lowerpath && oip->lowerpath->dentry)
 =09=09OVL_I(inode)->lower =3D igrab(d_inode(oip->lowerpath->dentry));
 =09if (oip->lowerdata)
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f48284a2a896..a1922af32a13 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -421,6 +421,7 @@ void ovl_inode_update(struct inode *inode, struct dentr=
y *upperdentry)
 =09=09inode->i_private =3D upperinode;
 =09=09__insert_inode_hash(inode, (unsigned long) upperinode);
 =09}
+=09mark_inode_dirty(inode);
 }
=20
 static void ovl_dir_version_inc(struct dentry *dentry, bool impurity)
--=20
2.27.0


