Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049252B15FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 07:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKMG5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 01:57:04 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17155 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgKMG5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:57:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1605250605; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=kFmChfc4GlxQHCLnzUNSJyAX51LfY5QmzYpuZU0GKYaOrOOyUk8xBYDKQpclLqlQH4zU5cdBYAQ4Q8N2ld5U6q0nmVKylJC4ufP61M/nRofnAzhdxPsWBRf4bLFC40SBY4ozMuu0t8Y2TAOvL5O8uxlMs3NV4qt0Oa44DqSVsjY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605250605; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NlKEQcKE+RNemWdOzA+NXWjXnwiavlahEmjugedQVBk=; 
        b=eF7MH9is43mBl+YG2q8BRfp14dufGixHbC7hscMEOuQlPRlco9qexO8n3zNHSTOXdyRuADDADMmdxnyDzEG1zs+f6oCas7jOer6dO3SilBmbj6kZHjEwqTqDf5ZbeB0Fh/Y3C5/FmeDsQBetl/Bf9WvZyVjbtwf2BeFB3BQksbY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605250605;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=NlKEQcKE+RNemWdOzA+NXWjXnwiavlahEmjugedQVBk=;
        b=ShkQYaIdjJp/sCKYNhZ+8u4RHfppwY1wMau6NO5KqQ8wXdlqxLdJAEnOpnJoyAyC
        jLzpkPTvzYU4NBWUXQAbnyJr3oLs5qW9h1qTfoZxAqE63+Tcth8QM66uN04ybVr/uxZ
        sgH4pfiXoAI1a0+LFVqJRpcOD6UkwYsFQpy+cYmE=
Received: from localhost.localdomain (116.30.195.173 [116.30.195.173]) by mx.zoho.com.cn
        with SMTPS id 1605250603530773.1814704162608; Fri, 13 Nov 2020 14:56:43 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201113065555.147276-2-cgxu519@mykernel.net>
Subject: [RFC PATCH v4 1/9] ovl: setup overlayfs' private bdi
Date:   Fri, 13 Nov 2020 14:55:47 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201113065555.147276-1-cgxu519@mykernel.net>
References: <20201113065555.147276-1-cgxu519@mykernel.net>
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


