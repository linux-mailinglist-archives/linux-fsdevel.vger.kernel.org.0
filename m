Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DC328A403
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 01:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbgJJWz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:28 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17173 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730140AbgJJSpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Oct 2020 14:45:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602341353; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=cPrlslvq1uh7ZvrGiAl96ER+QN+ySmNR3GlmdvG4++3/0t3uhQ282uuot3LY7lloRGOoe3AihyJfKegyxLVK0QrgVuGU8er1lUDXEBLHkAsxZ5jpJr3FUzSi/JnCgJSKeN6z0CGSPaRLbMtZKWNCeWmtVgwTFYP8viTrHxm+JeU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602341353; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=N6y8VyZI21TTNRw1uHTj2sBD/m50A++/UX1B2A2AIzU=; 
        b=hyBhlwEZ39jrold8dmL6IGaNRwvO8oqt0eo3COJ1PfqIdbO03F1f2KjXniYW0QqvUzlQjNMNX4f0pqYt8Msw1p6BdUeeBGkRRP24oOdhLAHABT3G1b/pcz5EMPvMKOs2o6jC5yVppEbcjdPZN0xfEJVBYBIoAi+pCezT+PyPJJY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602341353;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=N6y8VyZI21TTNRw1uHTj2sBD/m50A++/UX1B2A2AIzU=;
        b=YmSjADZUEy3Dc6psApXhupkDGwgzGX7ohCZJGz4WraDovZeYwueey/J+r3WQ/88G
        HlViIN6uZiFY8GVpBu34YUDZWngG02IjcvocyUPr30SuQPr6psQfXSi8gBw9VjmaZqR
        B14uxz6Od/xtRe5R6YIOZxQvoAKcPLeDO+gd9XSY=
Received: from localhost.localdomain (113.116.157.74 [113.116.157.74]) by mx.zoho.com.cn
        with SMTPS id 1602341351870758.5022301622118; Sat, 10 Oct 2020 22:49:11 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201010144849.742496-1-cgxu519@mykernel.net>
Subject: [PATCH] fs: remove unnecessary condition check
Date:   Sat, 10 Oct 2020 22:48:49 +0800
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

posix_acl_release() does NULL pointer check itself
so don't have to check it explicitly.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/posix_acl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 95882b3f5f62..194c24ee8ba0 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -950,9 +950,7 @@ int simple_acl_create(struct inode *dir, struct inode *=
inode)
 =09set_cached_acl(inode, ACL_TYPE_DEFAULT, default_acl);
 =09set_cached_acl(inode, ACL_TYPE_ACCESS, acl);
=20
-=09if (default_acl)
-=09=09posix_acl_release(default_acl);
-=09if (acl)
-=09=09posix_acl_release(acl);
+=09posix_acl_release(default_acl);
+=09posix_acl_release(acl);
 =09return 0;
 }
--=20
2.26.2


