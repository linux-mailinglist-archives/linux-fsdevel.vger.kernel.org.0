Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882D445883F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 04:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhKVDTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 22:19:40 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17261 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238512AbhKVDTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 22:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637550059; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=XNhysrQBlWhysCnOSjN2/XVn0WnIuSEWhJIUJEImumLcYy7dR+OjpTuuq0wZUtsSnuU+mb1JfiGY1tZHjYTprK4siXNXgv5EYJmV7XLmbHSMhCDuTpJlenyqfiHoqcp98LSd7Nluxr/xRx4zAKapYqC5kOMsFXSuRq74zdqinWY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637550059; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NN0J8syqY7HhBP+osWb94ylU37U4Vn/6TEJ/OnmUV+Q=; 
        b=AgDaD7Ke3l5wOS2oBcwxb4vKC46uCisAbwrcaVBNeG65ytokCx8TkEtr+hizqw4n+GJnLutDzmp3hdi65ipfDDUbs/ssFbrFhmof6j1U9zLhTJ518gMDwQ5DCW3CQqimEYRsMzSKM3nORWegPez2Mzvi9db4INbtwOrdJQ4oCcw=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637550059;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=NN0J8syqY7HhBP+osWb94ylU37U4Vn/6TEJ/OnmUV+Q=;
        b=AZ+LVnmi2vzyCCwDb/gHh0BF5qaCv9+DmGf4pp3zbpqUv9rD6pL8HzJeLu0DTH3B
        ERRJRyPUJ6vYSBqQDiQWT5+uWv+Dxo+kNXrUSm0ep6+Wv2PSnbiHUr4ljLXCaOVrRRD
        E+R+LPjpXbMQORtjXVmzp1i6N/J3Z/gmzQN1CI0E=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1637550058013718.8663802684912; Mon, 22 Nov 2021 11:00:58 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Message-ID: <20211122030038.1938875-7-cgxu519@mykernel.net>
Subject: [RFC PATCH V6 6/7] ovl: introduce ovl_sync_upper_blockdev()
Date:   Mon, 22 Nov 2021 11:00:37 +0800
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

Introduce new helper ovl_sync_upper_blockdev() to sync
upper blockdev.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
---
 fs/overlayfs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 12acf0ec7395..ccffcd96491d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -258,6 +258,16 @@ static void ovl_put_super(struct super_block *sb)
 =09ovl_free_fs(ofs);
 }
=20
+static int ovl_sync_upper_blockdev(struct super_block *sb, int wait)
+{
+=09if (!sb->s_bdev)
+=09=09return 0;
+
+=09if (!wait)
+=09=09return filemap_flush(sb->s_bdev->bd_inode->i_mapping);
+=09return filemap_write_and_wait_range(sb->s_bdev->bd_inode->i_mapping, 0,=
 LLONG_MAX);
+}
+
 /* Sync real dirty inodes in upper filesystem (if it exists) */
 static int ovl_sync_fs(struct super_block *sb, int wait)
 {
--=20
2.27.0


