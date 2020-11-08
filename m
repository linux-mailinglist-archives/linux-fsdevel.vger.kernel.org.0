Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F992AAB38
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgKHOEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:04:01 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17144 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728197AbgKHOEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:04:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604844203; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=EFb7ie2eBft9DAACASh+Si67cfGqBMj6e4T3doS1SBJ+AYkyjeBOnkByrHaS8JtJ0/yTQMIfiOz3LFjkazme0eJuqzcdNNZKojCV46UoPQiQi0ft6yhRYbjcRXbKA/g0yeCXsw38HVvtloaWJlD7M75mWTnVR5LSXsZtjINg+bc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604844203; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NlKEQcKE+RNemWdOzA+NXWjXnwiavlahEmjugedQVBk=; 
        b=RVThziG2W7VqlXcEoJWa6gZoKWS5XjiPf57cCVzaNJ2bdynO8a/glDC1rbP5yU1/smBpaHXF7y1k9mS+8zcLyzj49GXWpMKa/TeLgwHoXQhtGD93TDVl2orsJDWK3Lo4p/L+Um6WYLi2VYYWAO0OHnLHlAfDecbfo+S5gWAU/FA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604844203;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=NlKEQcKE+RNemWdOzA+NXWjXnwiavlahEmjugedQVBk=;
        b=gG+yV7gkAiG26ts0p7CxofxCPTrgpVJ8T2aqttA6dZH42uUDA3GrMXV38X4/51Ly
        wBcW56ZU6B9ohCFFcBvrh8Avgo5Yvcg78LPZZkYw0m7Oq3zwD9Mz4791/gHZNx+jx0Z
        nY3aYQOHkTh0yV8wx2rzlyhehKplI6G2dhDHb+I4=
Received: from localhost.localdomain (113.116.49.189 [113.116.49.189]) by mx.zoho.com.cn
        with SMTPS id 1604844202208314.43846728206813; Sun, 8 Nov 2020 22:03:22 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201108140307.1385745-2-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 01/10] ovl: setup overlayfs' private bdi
Date:   Sun,  8 Nov 2020 22:02:58 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108140307.1385745-1-cgxu519@mykernel.net>
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
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


