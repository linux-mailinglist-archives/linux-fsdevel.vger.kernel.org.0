Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27E1297FFD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 04:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766981AbgJYDmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 23:42:43 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17173 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1766958AbgJYDmm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 23:42:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603597315; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=pA0pH32x4imtrjsVanGnCFG+ScEigAqyEkm3+d44yyhr8I6rIdfz/LrSpogzBjOTo5GD62C4StEzduARXDRU1ltOhhyf2i7Km4263vmCPi5PsQiSlAsxNDlqGPpP3u+iEGbghO/jPTAPe1U1FgEIqUi3dnuG/7D2Bf/E98nEFhg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1603597315; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vu/ag4Tg6S+Hh8bpKgvQ+I+D5rt1ARq7efArRp49AkA=; 
        b=U1Cf960g2plCFVPSNteG0fZ20YPwJVHU9R0NcZHreWNrAKcsXTjCGAOkCn67DoF8q+r+XRmMnvHSTPM1U175Z8ttf/Bo0HUhw8JyeIlBjKi6bj6Hap05JlnFRaRc8edPDU3GumYO6LNdE3BjXKZGFM9LPVwM86OnWoOj3934NhM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1603597315;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=vu/ag4Tg6S+Hh8bpKgvQ+I+D5rt1ARq7efArRp49AkA=;
        b=F8tZJMVXnF/UoKKQdtrd6Vf8XLcubKuViJAc+CKCOWq0cDQmsYXFzqqTXIXPSLmu
        lzLAaBIxe5ljhhY9+b4sScKwxpi2FRZEKNs1axdphb5uAPPnnWvFzohEqqsWeWrZS6f
        NwWMUEmM3vx6iIxqJ5BYeaN+yHpf7bDJqpQ/wklE=
Received: from localhost.localdomain (113.88.132.7 [113.88.132.7]) by mx.zoho.com.cn
        with SMTPS id 160359731470039.422630673296794; Sun, 25 Oct 2020 11:41:54 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, amir73il@gmail.com, jack@suse.cz
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20201025034117.4918-9-cgxu519@mykernel.net>
Subject: [RFC PATCH v2 8/8] ovl: implement containerized syncfs for overlayfs
Date:   Sun, 25 Oct 2020 11:41:17 +0800
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201025034117.4918-1-cgxu519@mykernel.net>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now overlayfs can only sync dirty inode during
syncfs, so remove unnecessary sync_filesystem()
on upper file system.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/overlayfs/super.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 1d04117fb6ad..df33e8c8f1d0 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -271,8 +271,7 @@ static int ovl_sync_fs(struct super_block *sb, int wait=
)
 =09 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 =09 * All the super blocks will be iterated, including upper_sb.
 =09 *
-=09 * If this is a syncfs(2) call, then we do need to call
-=09 * sync_filesystem() on upper_sb, but enough if we do it when being
+=09 * If this is a syncfs(2) call, it will be enough we do it when being
 =09 * called with wait =3D=3D 1.
 =09 */
 =09if (!wait)
@@ -281,7 +280,10 @@ static int ovl_sync_fs(struct super_block *sb, int wai=
t)
 =09upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
=20
 =09down_read(&upper_sb->s_umount);
-=09ret =3D sync_filesystem(upper_sb);
+=09if (upper_sb->s_op->sync_fs)
+=09=09ret =3D upper_sb->s_op->sync_fs(upper_sb, wait);
+=09if (!ret)
+=09=09ret =3D sync_blockdev(upper_sb->s_bdev);
 =09up_read(&upper_sb->s_umount);
=20
 =09return ret;
--=20
2.26.2


