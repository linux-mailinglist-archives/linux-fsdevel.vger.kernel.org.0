Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA5C1D472D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 09:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgEOHhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 03:37:39 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21145 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726715AbgEOHhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 03:37:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589527309; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ipnm8/fT9xfvgU32eK3enUxfv51FtuGieLits0tW1hs0QDvi0+/Gr56Sf9bhAkIT1ND+ZnvvMWZaOqCUXMGE/4MKzul+kn3MLNhYV2bgQQ57kVaoOk1tIhI80jF4y6dEfW+nndUBF9xjZ5LTuXvl2oJK1M6ZrRZ8S2QPOxL9QXw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589527309; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/zcjwUOZSvHEU5HoCVl0NjoEfg5VSqwCmmFmmBKUM6w=; 
        b=RnSnIEETkAF6q1mlR4euULZQUa78Cm0mx0g8wCn4mzdWu1CaCVLZMRbY2B9Rxa4BnaMEbAbgrYiRPD/SFD7LnvMHuyAjlSM/I37kKYPR3zYB8wXngSO17c7k3L0Uz+UeZpjEBNUKvjUbnhshKaerWyB/iFqBwSS6HSYiYq7RNjo=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589527309;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=/zcjwUOZSvHEU5HoCVl0NjoEfg5VSqwCmmFmmBKUM6w=;
        b=ED37Aywmz3hf7x4KDbLYGuS/ahKrdfTpnKku+vMpyMz6HPwGABdHuWzabzcK8NKo
        Z3peuW/nYgI4R82luUG7skJkKeYNJ4Jj/QJ/t1/u0ZCY5TQNUgSxVn3Zm4jWfN61wXh
        5lF5a5LsWMOpHLuGYujqpijpRwP/db8wom6Khv4Q=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1589527306843634.123449457146; Fri, 15 May 2020 15:21:46 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200515072047.31454-8-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 7/9] kernfs: Adjust argument for lookup_positive_unlocked()
Date:   Fri, 15 May 2020 15:20:45 +0800
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
 fs/kernfs/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 9dc7e7a64e10..3162d2bf39b3 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -224,7 +224,7 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *k=
n,
 =09=09=09return ERR_PTR(-EINVAL);
 =09=09}
 =09=09dtmp =3D lookup_positive_unlocked(kntmp->name, dentry,
-=09=09=09=09=09       strlen(kntmp->name));
+=09=09=09=09=09       strlen(kntmp->name), 0);
 =09=09dput(dentry);
 =09=09if (IS_ERR(dtmp))
 =09=09=09return dtmp;
--=20
2.20.1


