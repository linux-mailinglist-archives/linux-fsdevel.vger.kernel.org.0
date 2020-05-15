Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589EF1D4728
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 09:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgEOHhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 03:37:34 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21144 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbgEOHhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 03:37:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589527308; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=VEVPQNJHmPE+IJH3RZxNtSjHz/BcKhJX/UW4+FOOLLMLz7P3W/Q4dncVIDv8gkCLybwwu8IV35Vio+4q4Tx3ybwcl9bMpxK6HMevWRxEdvmU10wpri+eSFEUONc5aiYly2mfM8rRtItUlx+ewVPy1y2sg2jt/HI7w2sQiWW9rlY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589527308; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=qj5ywJSYyyAOPGei8sj6RzN+Jthoxsxu6NPYdhbNiuE=; 
        b=jAZ+/u3xid/9EkVQ+7TW9cpdbWLpoWm/5e4Sk3xwCiM4xdDLSZXEckXHngEnujNC/kko9E2EjOV2lj1Jiq17zlCmvCcs1d0ggjaHhaali0cXbcTNQU9hxNpncX/eX09HAEF8XyxJeenvOpqOZPd9ny7tQutX/DbnkXcA528jyIc=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589527308;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=qj5ywJSYyyAOPGei8sj6RzN+Jthoxsxu6NPYdhbNiuE=;
        b=PTAJ0cLCqFOFl0j0Gy05cneIACDAAigfS3jG2c30GGtItDIPQ8Ya6tbolJPbbbGP
        z1caDL8LeGn8n/NqRFmexWOCa07oag2rKJzsYbp499fd8iliRCURo0Xb1cM38ZScKjl
        LHzhexyYAXTdgKIYXKavC6zcahdREBAD4und3tVU=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1589527305512510.623272626652; Fri, 15 May 2020 15:21:45 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200515072047.31454-7-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 6/9] exportfs: Adjust argument for lookup_one_len_unlocked()
Date:   Fri, 15 May 2020 15:20:44 +0800
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

Set 0 as lookup flag argument when calling lookup_one_len_unlocked(),
because we don't hope to drop negative dentry in lookup.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/exportfs/expfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 2dd55b172d57..a4276d14aebb 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -145,7 +145,7 @@ static struct dentry *reconnect_one(struct vfsmount *mn=
t,
 =09if (err)
 =09=09goto out_err;
 =09dprintk("%s: found name: %s\n", __func__, nbuf);
-=09tmp =3D lookup_one_len_unlocked(nbuf, parent, strlen(nbuf));
+=09tmp =3D lookup_one_len_unlocked(nbuf, parent, strlen(nbuf), 0);
 =09if (IS_ERR(tmp)) {
 =09=09dprintk("%s: lookup failed: %d\n", __func__, PTR_ERR(tmp));
 =09=09err =3D PTR_ERR(tmp);
--=20
2.20.1


