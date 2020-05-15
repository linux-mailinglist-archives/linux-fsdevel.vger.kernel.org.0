Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24AE1D4732
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 09:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgEOHhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 03:37:45 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21140 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbgEOHhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 03:37:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589527312; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=maG4CChuV70ufvyzozEvm1K24WH8QAe0i7s8MDgKz+Oo9fWFNPDpT0a4dR/YxH99FrmMApoF9ke7yi4WM1Mz0+01M1X75v45dh2oKxI86A0vzKsg+ojG8VVr61yoQ0tleeMBBVMSTSchf6U+oFnyuR/bsaOxuGSvK5k/Ggj3WG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589527312; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=xUFcLyWr4D8q4EQRC/9G8D3ERMkZBUzlZqLURVLHOP8=; 
        b=n8ZIefAncCbit8tq8y7jyrsnBvFMlCdAn9VBaxt7x6Wp0bcNIrnk/dqBNnOPBWaI+1kne9TZotSTVTdNlXol++2cVw9AaSIGM6jSlyQeLohkRwfSMDp5iXTSEgQgsrx6PzkX4T4eqJxofE1mTrkfbWwJYMwC467cqHJkzMRfCQQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589527312;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=xUFcLyWr4D8q4EQRC/9G8D3ERMkZBUzlZqLURVLHOP8=;
        b=DUvQrPgVk+bvT+BlHUbjK6vPj3wVxyTBBisJOVMT9sNr0ubRuvSuaVkC6CataIkN
        tOBtYsquB8fTmn615t2ZZ9ddCL+yJqWVP7qRLY24Jew1GfQ7naqLQlMSSja9qZwltzW
        wIkBScdk7Du+SKygRCfkuyDle4iAEz4YlFBj7R6E=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1589527309583206.8447354867062; Fri, 15 May 2020 15:21:49 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200515072047.31454-10-cgxu519@mykernel.net>
Subject: [RFC PATCH v3 9/9] quota: Adjust argument for lookup_positive_unlocked()
Date:   Fri, 15 May 2020 15:20:47 +0800
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
 fs/quota/dquot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index b6a4f692d345..8d6c32f75a4d 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2488,7 +2488,8 @@ int dquot_quota_on_mount(struct super_block *sb, char=
 *qf_name,
 =09struct dentry *dentry;
 =09int error;
=20
-=09dentry =3D lookup_positive_unlocked(qf_name, sb->s_root, strlen(qf_name=
));
+=09dentry =3D lookup_positive_unlocked(qf_name, sb->s_root,
+=09=09=09=09=09  strlen(qf_name), 0);
 =09if (IS_ERR(dentry))
 =09=09return PTR_ERR(dentry);
=20
--=20
2.20.1


