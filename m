Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A4352379F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbiEKPpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 11:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiEKPpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 11:45:43 -0400
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn [163.53.93.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878DF9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1652283920;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=LzdE0Xwv07gu2x2Cq0B39Z1oDicPX3n0TmcRbU8cBIE=;
        b=CCEVn+wytJisn78PbRwNoQtitYDovt3Qk1JShF6Qle3+8+rguCxFhyoyUT18Jovw
        YFSZj+fkvHXFzNyY1RLIU7D/830yA3Jubx+rA0j07zvdKT0crbxBFKV/GCBzhn1LHOn
        7qt+Tg+9nzDEWj4o5fXg8mUnzdI1dze+xcn/2NvU=
Received: from sanma.. (113.88.133.138 [113.88.133.138]) by mx.zoho.com.cn
        with SMTPS id 1652283918530281.90610360329765; Wed, 11 May 2022 23:45:18 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20220511154503.28365-1-cgxu519@mykernel.net>
Subject: [PATCH] vfs: move fdput() to right place in ksys_sync_file_range()
Date:   Wed, 11 May 2022 11:45:03 -0400
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move fdput() to right place in ksys_sync_file_range() to
avoid fdput() after failed fdget().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/sync.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index c7690016453e..b217d908bee8 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -360,10 +360,10 @@ int ksys_sync_file_range(int fd, loff_t offset, loff_=
t nbytes,
=20
 =09ret =3D -EBADF;
 =09f =3D fdget(fd);
-=09if (f.file)
+=09if (f.file) {
 =09=09ret =3D sync_file_range(f.file, offset, nbytes, flags);
-
-=09fdput(f);
+=09=09fdput(f);
+=09}
 =09return ret;
 }
=20
--=20
2.35.1


