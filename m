Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85B1458842
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 04:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhKVDTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 22:19:47 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17257 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238645AbhKVDTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 22:19:38 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637550057; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Fl90mNkZvga2F7Mr+U4bqhs5hnJmzoRXX+WHQau+M5yiCd8NIYvGL5Mf2zV/FKg2cf3adsXvRiHEOzPtBiX63uOqt5zwNmIs30gWOWgDYSmfuCFw5cwvHXRSav66Q7cT5pEGF+CVfQYNHZrt7X14CyQ7zRIsYazCfQq1QP8EX6E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637550057; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ETuCEhivaI+lEwSropDYBcDfVuyeiGC5OUBN9BSSIMw=; 
        b=eUYE5XrD4xulw+cr3kaOJ9jj2UlyqVweKn1L6AOe9+W8g9RSFkcOV0CxY/uJT3QruoIXyxVuz8cVNXPobfJX3q3DamFz6m8Q/r4OHLdsJEXfrU1yVEeyX73W25ltWZCZf9fqiGs6BhL33ik/h27rASZfM9x/Lp1/YDc3YfuqVq0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637550057;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=ETuCEhivaI+lEwSropDYBcDfVuyeiGC5OUBN9BSSIMw=;
        b=JJS/K8NQm3AYXD6ZPKPIxXtPsn6Zfp+VBYC8tunQV8IRyDyVtWWa6NOEibmtd3ET
        5ZHL3DOY5JfDl9GohbVBlKaXkcjMQSQRV5TjAL47qOIhanLV8irK+YQabMx+t0zDtiY
        Mfftzm9tQ5hiz2MKFwtfxTfGf41PxdzLzUN5tMXU=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1637550056708361.5401345405787; Mon, 22 Nov 2021 11:00:56 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Message-ID: <20211122030038.1938875-5-cgxu519@mykernel.net>
Subject: [RFC PATCH V6 4/7] ovl: set 'DONTCACHE' flag for overlayfs inode
Date:   Mon, 22 Nov 2021 11:00:35 +0800
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

Set 'DONTCACHE' flag to overlayfs inode so that
upper inode to be always synced before eviction.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
---
 fs/overlayfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 027ffc0a2539..c4472299d5df 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -791,6 +791,7 @@ void ovl_inode_init(struct inode *inode, struct ovl_ino=
de_params *oip,
 =09ovl_copyattr(realinode, inode);
 =09ovl_copyflags(realinode, inode);
 =09ovl_map_ino(inode, ino, fsid);
+=09d_mark_dontcache(inode);
 }
=20
 static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev)
--=20
2.27.0


