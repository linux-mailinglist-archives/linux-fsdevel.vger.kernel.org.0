Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E6E415F9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 15:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241374AbhIWNZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 09:25:49 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17277 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241304AbhIWNZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:25:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1632402518; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=HVj590TZaxGsnVA2O5lZ0pLpPyNFSLFe2gysnBVdtFfGHI9kp3LJ/nmln+JcUCJDtc8s59pFHXaKSSzz6eHNeAwaFEkGu8yV0ai5b+MTeka4L6cuDvfIynsGfzaSxtx4cadVb6fTqAQBFWmob2hUk63lzt41XeEnQXMukiRvvEM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1632402518; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=BUzq9Nw85NI4rCLzem4WvUl+lsGH5mOKA8UJLkEtvlg=; 
        b=eEC7aRdbfXV3Uz6aRCVzJddTHBP11c5+/em2WRByqMH11zB/vt440HxZgRs3cXO8yyBujqh1niZXbDs6/N1uURKKVyYolp41AZJQefYOP6VPlL+0ZvykJejiUzHfz8u/U32sXgFyP/qWRQdJJnsgEc+lPpHfA4b5QNLWN40an4c=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1632402518;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=BUzq9Nw85NI4rCLzem4WvUl+lsGH5mOKA8UJLkEtvlg=;
        b=X8i5R5ocA5qRsRqIrz9vHXfXgQh/gPbjN8JhON/5BC+psOnIt5wPJGatZTTMHUuM
        zRIWWshiKGewEaaFzZLJ7InZcQ9cq8Lz3FZzrXyl4iUO1+4uB9KEPL2rQneRVPggJ7Q
        zW98XxfuWivzXA7HFhB5YmSRLF38QmA1Jx9EC3mE=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1632402516780153.9678330778986; Thu, 23 Sep 2021 21:08:36 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210923130814.140814-2-cgxu519@mykernel.net>
Subject: [RFC PATCH v5 01/10] ovl: setup overlayfs' private bdi
Date:   Thu, 23 Sep 2021 21:08:05 +0800
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

Setup overlayfs' private bdi so that we can collect
overlayfs' own dirty inodes.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 178daa5e82c9..51886ba6130a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1980,6 +1980,10 @@ static int ovl_fill_super(struct super_block *sb, vo=
id *data, int silent)
 =09if (!ofs)
 =09=09goto out;
=20
+=09err =3D super_setup_bdi(sb);
+=09if (err)
+=09=09goto out_err;
+
 =09err =3D -ENOMEM;
 =09ofs->creator_cred =3D cred =3D prepare_creds();
 =09if (!cred)
--=20
2.27.0


