Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1F11D4729
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 09:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgEOHhe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 03:37:34 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21143 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726613AbgEOHhe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 03:37:34 -0400
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 May 2020 03:37:33 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1589527302; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=d/xfKEn+tR/7bR8nS9hg0WFG6dB4vhN1NLn5YBaZVDbJy1bPm+W/Yp6OrAf2RjtiUM3ocz38NSvUktOMBN4xE+WOtgAjm9wa6Fb0WrV+hVpG3RWzj/aXQt9p0iRD/L8bZ66OaQ+baB5ZNIjDZk75Pjiqp7FCLxfNvMP02zMO5u4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589527302; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=OQfSZ7V3N57McV37KTNRAC36myQ0WuVNtBUJ3+y8HO4=; 
        b=UIMWsSf6OAa71bG0z8hqOjC+aArdxWyxkH+t/6oyrKFuO7WRt/w4ukjftyZdp4o0Rk1UZvL26inlkbhyDFDnyqpw4Mqjmgue1DLuxGlRiHiCyRDAuw+5aPt2qHZB5pAApAtlhxmr/DmjeZthyFb7RFDZkPggR8UPBtLTr6fb78Y=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589527302;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=OQfSZ7V3N57McV37KTNRAC36myQ0WuVNtBUJ3+y8HO4=;
        b=HSemMUGvIrr4LrvfQKG9MgyYUYYLF1ugok4ymMy6Ljsk6koX5t0fBqvwP8Q8Uk0h
        PGzOBmHd2hR+6R21akkNwXfJA624xZgcyX8SNam6G3aZLepSpt5iFXyI0VEZCRbUM7p
        qP+REAq4zrShXvUC52Oe33C7MWVfYUhUZtKqAQ/8=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1589527301388870.0795917521274; Fri, 15 May 2020 15:21:41 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200515072047.31454-4-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 3/9] cifs: Adjust argument for lookup_positive_unlocked()
Date:   Fri, 15 May 2020 15:20:41 +0800
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
 fs/cifs/cifsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index c31f362fa098..e52a3b35ebac 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -752,7 +752,7 @@ cifs_get_root(struct smb_vol *vol, struct super_block *=
sb)
 =09=09while (*s && *s !=3D sep)
 =09=09=09s++;
=20
-=09=09child =3D lookup_positive_unlocked(p, dentry, s - p);
+=09=09child =3D lookup_positive_unlocked(p, dentry, s - p, 0);
 =09=09dput(dentry);
 =09=09dentry =3D child;
 =09} while (!IS_ERR(dentry));
--=20
2.20.1


