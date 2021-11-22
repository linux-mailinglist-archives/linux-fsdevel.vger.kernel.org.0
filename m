Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAAC458850
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 04:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbhKVDTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 22:19:42 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17263 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238637AbhKVDTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 22:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637550059; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=IfELBCtyhYXdJYLD821WMxeVm3FWdhn1emkZNIAK6p9G5lOv5LmeJ5UuvBF1WkengtFkk+fyyjcp7ksSXce6Rn0i1VoqeIX4bmWkE2zuiyD7RcFmkzIndB3HGQR19m2X/kGECHuWb/gf2kWRa4oDdG/fln6kmsMjbvhBDS9aK8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637550059; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=x3rn9UpoZ7H4gQM/r9ta8j1G3E81TfSs5cv8aAEiDvI=; 
        b=B9gSC4oPZ2QgwajSgoyyXnC1kgS8iZMGtMe2fwgh+QPNyZFCgsL35RzXh1Q3SL9zyOB3xkmmBui78NYpZGsGTQ+QJVJAS1qu6nyhBMlcSkADtJavBvdCQQRpTmF+C0D2BBPyGt6OIPiG1ptFL80iaZ2ZKC7vArc0uAB0O3ITQIM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637550059;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=x3rn9UpoZ7H4gQM/r9ta8j1G3E81TfSs5cv8aAEiDvI=;
        b=AFTuzWH9SAxJTvrxcRm8cOuK/qxEpcQss/Y91kivBQYd/zdA5ny6VddbwfkDBmgE
        hYw5qUpln3MZaxCBe+FfwqjipusF+noZINF+x68eCtw16xRRhdwR5JMIKx/piOJraF0
        kYfWdJ0c4Gkpu/8/wvCDDrW7bvFYtQrwQiZVkCLc=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1637550058672726.6063942120564; Mon, 22 Nov 2021 11:00:58 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Message-ID: <20211122030038.1938875-8-cgxu519@mykernel.net>
Subject: [RFC PATCH V6 7/7] ovl: implement containerized syncfs for overlayfs
Date:   Mon, 22 Nov 2021 11:00:38 +0800
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211122030038.1938875-1-cgxu519@mykernel.net>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chengguang Xu <charliecgxu@tencent.com>

Now overlayfs can only sync own dirty inodes during syncfs,
so remove unnecessary sync_filesystem() on upper file system.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
---
 fs/overlayfs/super.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ccffcd96491d..213b795a6a86 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -292,18 +292,14 @@ static int ovl_sync_fs(struct super_block *sb, int wa=
it)
 =09/*
 =09 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 =09 * All the super blocks will be iterated, including upper_sb.
-=09 *
-=09 * If this is a syncfs(2) call, then we do need to call
-=09 * sync_filesystem() on upper_sb, but enough if we do it when being
-=09 * called with wait =3D=3D 1.
 =09 */
-=09if (!wait)
-=09=09return 0;
-
 =09upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
-
 =09down_read(&upper_sb->s_umount);
-=09ret =3D sync_filesystem(upper_sb);
+=09if (wait)
+=09=09wait_sb_inodes(upper_sb);
+=09if (upper_sb->s_op->sync_fs)
+=09=09upper_sb->s_op->sync_fs(upper_sb, wait);
+=09ret =3D ovl_sync_upper_blockdev(upper_sb, wait);
 =09up_read(&upper_sb->s_umount);
=20
 =09return ret;
--=20
2.27.0


