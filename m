Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36999458845
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 04:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbhKVDTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 22:19:48 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:12734 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238655AbhKVDTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 22:19:38 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637550055; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=JAoNsaN10azKlarTYcEUGo56chaltTpfY7UPE+s8Hqd9IxhC1VIeoWjhY+AQC/B7KR664M4M6UJOp0rj92dNwq8sEDrlZBHDNYAUHBgu25HKWY2g68cenXYxtxlKaF9CRYCAH6jUfJ+dPb4XQVWq6v8+wRWKS/Qd2NzLrcnMQjY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637550055; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=DtN3Ha9aqUUJBadIckugjDBrOSZBwL6KCrc5r2TTvV4=; 
        b=WNnl/4D+vrUqYoLKxPwgn//BIejpS25Da2rTuhO1CszG5tbIc9RRmeOMKOZqJoKiRO2l0Y4y3XZYLwz+kHzq+o9BL66LSG+4x+ddMkruqa2RF290+cT2p82RcsuR9YZKEOwn6OW1dLKOBwNmnF4JUW7b3iIOT9rKcV+gVFCOdNs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637550055;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=DtN3Ha9aqUUJBadIckugjDBrOSZBwL6KCrc5r2TTvV4=;
        b=aIa2TmSYPWRJkJ8o39TXMRAupUGzVj0+VMiElZ7tshKhhm9jYYr/el9QI1yzpsZL
        LtBGfVXgwt1Io5Q2HCESCjjYcGWrrN3mt06qs1GBGFYJBuSn8m9QOJaHsN0b89F3Cq0
        lght/wPmV6vp20JQ7YBkP7MzoxPbm2gwp2LrE0EY=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1637550054768331.1330786271167; Mon, 22 Nov 2021 11:00:54 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengguang Xu <charliecgxu@tencent.com>
Message-ID: <20211122030038.1938875-2-cgxu519@mykernel.net>
Subject: [RFC PATCH V6 1/7] ovl: setup overlayfs' private bdi
Date:   Mon, 22 Nov 2021 11:00:32 +0800
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

Setup overlayfs' private bdi so that we can collect
overlayfs' own dirty inodes.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
---
 fs/overlayfs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 265181c110ae..18a12088a37b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1984,6 +1984,10 @@ static int ovl_fill_super(struct super_block *sb, vo=
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


