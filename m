Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96FD297FFB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 04:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766978AbgJYDmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 23:42:33 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17127 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1766958AbgJYDmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 23:42:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603597311; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=P5FB1fGosSPBooNc5Z7gtdILnFBZuaoKzlgz9ERuwlZXyHjW51AtCp6eFTBxj0O/IEZ7AqM7Uigt8Pm2CdF9RK6McCv6HDmmUIRzhjXKFq13riNeToXPMiBvkJ+dm5B/8XqNZYwVBVT8eBXFeOt0JCYxOkAtuUqwGLQFms+1ids=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1603597311; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NlKEQcKE+RNemWdOzA+NXWjXnwiavlahEmjugedQVBk=; 
        b=HvoD7FRT2uE/R+I6zUodUReNKmPu/CtKQfytoW+0+Vmn90hlpF5Wtpr6KS4fR7ERj1Svt0k66MO7qSLQeAFKnks0rkBOsw8lQhXpkH6e+PR/2LM2EKNno9mjtK4Ht9FIioAAS7eW74lesei9XvryR1spl82NwB8KsgDiLxgOg+c=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1603597311;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=NlKEQcKE+RNemWdOzA+NXWjXnwiavlahEmjugedQVBk=;
        b=KA22zK2S82JYVtJhkR1DJ6StAdF74aMgG5qm8l5R/KgtxkzB5m5TQkIwVa3Vl8gd
        fJEQJuk4hLPwoHUsSh66msUDrQc7gVy2CkV4nEUQjJdNFyquxPXkElvLkrnXx7vKFpu
        JcTuz1P5HDcFxmtk83ChEWuiSoc3t5M+/5sSZpNk=
Received: from localhost.localdomain (113.88.132.7 [113.88.132.7]) by mx.zoho.com.cn
        with SMTPS id 1603597309263981.7178667108379; Sun, 25 Oct 2020 11:41:49 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201025034117.4918-2-cgxu519@mykernel.net>
Subject: [RFC PATCH v2 1/8] ovl: setup overlayfs' private bdi
Date:   Sun, 25 Oct 2020 11:41:10 +0800
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

Setup overlayfs' private bdi so that we can collect
overlayfs' own dirty inodes.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 290983bcfbb3..d1e546abce87 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1869,6 +1869,10 @@ static int ovl_fill_super(struct super_block *sb, vo=
id *data, int silent)
 =09if (!ofs)
 =09=09goto out;
=20
+=09err =3D super_setup_bdi(sb);
+=09if (err)
+=09=09goto out_err;
+
 =09ofs->creator_cred =3D cred =3D prepare_creds();
 =09if (!cred)
 =09=09goto out_err;
--=20
2.26.2


