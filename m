Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66863322B8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 14:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhBWNfJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 08:35:09 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17128 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232929AbhBWNfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:35:08 -0500
X-Greylist: delayed 988 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Feb 2021 08:35:07 EST
ARC-Seal: i=1; a=rsa-sha256; t=1614086230; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=HDTlU465mhjgc1JCxXmUWnTEK2HV8ga3Rhc+D1Ao6w89ROf37m1uVA0+jJqCr0M6xNKc8dFiRLWLVT/2nZjKNHkgLi/WOL3UiXWu1JoQivkPM5m3nyooeHUE4V8s/5Yx+ssQn+t+r9h1Pt7Pi6aDiigpehqJ6aIUATDee68GxLM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1614086230; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=pYygrEaZnMKuOZNsZ+YDisT1qWuWhRveC75JgOj6sPg=; 
        b=BG4k0MPHU8RtphwoxqoFtWsl3gAN2eTjVRgRSdml09Oz04SJ5B8v30YBgGkdPuvRFvCLf9Ul4Sy+pT7NLiF/zmt6XmE2Z5f8WiVJnzxTFnZpCzCKD6CvVPR3P6Fs05TzqPBNYjsUkz7mjGZx1FbB5mfPBgDr46coT1qPSm7tFlw=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1614086230;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=pYygrEaZnMKuOZNsZ+YDisT1qWuWhRveC75JgOj6sPg=;
        b=Esg3zhnCzJEj/bhpcdgaswgGG8Nw4c8s8z40c3vqnjbmJhSmrFdtlMYraC+TN80v
        rk42y99s5Bow4AdiMbKyj+I1YRr19nM84ka9/k2/7ekdeHIHrdcoe0mG602NnpzZCGf
        56+5dABIhTmKFsPGULOynebx9mR/09J2+LSLWjxw=
Received: from localhost.localdomain (159.75.42.226 [159.75.42.226]) by mx.zoho.com.cn
        with SMTPS id 1614086228456793.6125108886409; Tue, 23 Feb 2021 21:17:08 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210223131632.2208648-1-cgxu519@mykernel.net>
Subject: [PATCH] fs: don't specify flag FIEMAP_FLAG_SYNC when calling fiemap_prep()
Date:   Tue, 23 Feb 2021 21:16:32 +0800
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

commit 45dd052e67ad17c7a ("fs: handle FIEMAP_FLAG_SYNC in fiemap_prep")
has moved FIEMAP_FLAG_SYNC handling to fiemap_prep(), so don't have
to specify flags FIEMAP_FLAG_SYNC when calling fiemap_prep in
__generic_block_fiemap().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4e6cc0a7d69c..49355e689750 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -303,7 +303,7 @@ static int __generic_block_fiemap(struct inode *inode,
 =09bool past_eof =3D false, whole_file =3D false;
 =09int ret =3D 0;
=20
-=09ret =3D fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
+=09ret =3D fiemap_prep(inode, fieinfo, start, &len, 0);
 =09if (ret)
 =09=09return ret;
=20
--=20
2.27.0


