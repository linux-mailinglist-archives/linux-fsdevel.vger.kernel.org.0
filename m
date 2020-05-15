Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1871D472E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 09:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgEOHhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 03:37:39 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21123 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbgEOHhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 03:37:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589527309; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=M5K+BuRevkxWk+9xVFPjbZNn3Lw9uhohWcsjcsYR1VAMx6xfeQha9dwKT+v9AkN0MCKTW0dwoBq+/L8lLL+n99TvMtcv83fByijkPJpTFKg+F2u8JBk8DaXm8HRbvLQsoLQeqx3JYerH5miX+2qigIxvYrXXPUaIIS9s6gjnCfA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589527309; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=uQ0EXwR2Al/tb5JmEvZvWIhJKgUaG+C2+JJVMkI3umI=; 
        b=g5AM3ZYhObqYjc1RxZaiveSHWm6hIN2cUz0EqtHxiyljG2keJMFldR+LtzFz9atAKAIYyc2jspayvSIPwxXoFXBCdoPSbzCd6YaQdLcOKUNVDN7XUyOYs0vDaQwbK7o7zrnicv6/P6/RWb3NarJemO2o7NT5wPCQTtIRZ7WNnYs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589527309;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=uQ0EXwR2Al/tb5JmEvZvWIhJKgUaG+C2+JJVMkI3umI=;
        b=f1Qk7bXE2uKwlimVK0HWv2UdBO0dknUjm4MGlYca2EC4CUjkU34M49U1No6Yzg6F
        Kt3oZcLuLMfTeM3KXu1B5wK3vAJgHQpJNNTzUkFrA3fjw3bSqiqOmSydYzp4FRgdalJ
        Y8J4Mwqla1TeRLN0GHtkWgK0wDvjpMexuGQVY37o=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1589527308239833.498669537171; Fri, 15 May 2020 15:21:48 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200515072047.31454-9-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 8/9] nfsd: Adjust argument for lookup_positive_unlocked()
Date:   Fri, 15 May 2020 15:20:46 +0800
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

Set 0 as lookup flag argument when calling lookup_positive_unlocked(),
because we don't hope to drop negative dentry in lookup.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/nfsd/nfs3xdr.c | 2 +-
 fs/nfsd/nfs4xdr.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index aae514d40b64..19628922969c 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -855,7 +855,7 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct sv=
c_fh *fhp,
 =09=09} else
 =09=09=09dchild =3D dget(dparent);
 =09} else
-=09=09dchild =3D lookup_positive_unlocked(name, dparent, namlen);
+=09=09dchild =3D lookup_positive_unlocked(name, dparent, namlen, 0);
 =09if (IS_ERR(dchild))
 =09=09return rv;
 =09if (d_mountpoint(dchild))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 996ac01ee977..1a69e60b8d59 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3066,7 +3066,8 @@ nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, str=
uct nfsd4_readdir *cd,
 =09__be32 nfserr;
 =09int ignore_crossmnt =3D 0;
=20
-=09dentry =3D lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen=
);
+=09dentry =3D lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry,
+=09=09=09=09=09  namlen, 0);
 =09if (IS_ERR(dentry))
 =09=09return nfserrno(PTR_ERR(dentry));
=20
--=20
2.20.1


