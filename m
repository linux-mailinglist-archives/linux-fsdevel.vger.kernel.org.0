Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE114627D56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiKNMHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 07:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbiKNMHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:07:38 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02642CE25;
        Mon, 14 Nov 2022 04:07:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1668427448; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ZRzORh6m8nEovh7z5LC9xoKhnIYR2azpervtA+NTZV0P0nNZh7GDcun/d8lEJ5dKKUvlJOV0juJkvf64ZDm2QmtEBe9D+wyi3xwfqoARpgojzTNxCroQklWyjC98A6YUe85aK45FM/dR8dXq22FKXTj5dHcS3jYjdw2VZRiBMDU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1668427448; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=IggqRsG6zyyiJTsuHTvPfu+aryWmvQ8Thb531wDkz4U=; 
        b=cjE7oDUZx0sspDXdnM0tglLm97e4Yn4ueJQ1AFaM0KfOke1ao0TZabJosM+BupogR2DiVjOp35fGiw2KER0k6hD6NVw0jhhis6I5V85iCqRoTtxxdhsINbnGOJonbwjfM+LrByHGppbMRXU0Mo0ao5W4jOluz0Tc4VkSwly+Wwg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1668427448;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=IggqRsG6zyyiJTsuHTvPfu+aryWmvQ8Thb531wDkz4U=;
        b=JPHUw5BKVBPw3sHMXH8/wSDflLkTjwonv4Ieetj6JC0dExLm3SXDFwVrBen2LESy
        SFrX4lQQS7qrTxtZBAiYBtW36SgM8oKzXrlBQ8oQxKccp7WRutSn+49BmQIe8nvItP3
        mMHWwBpP9nxtXYKZXcWeQXPzIP4dmeVYALG+VOOc=
Received: from kampyooter.. (110.226.30.173 [110.226.30.173]) by mx.zoho.in
        with SMTPS id 1668427447485815.8405388936613; Mon, 14 Nov 2022 17:34:07 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20221114120349.472418-1-code@siddh.me>
Subject: [RFC PATCH] erofs/zmap.c: Bail out when no further region remains
Date:   Mon, 14 Nov 2022 17:33:49 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following calculation of iomap->length on line 798 in
z_erofs_iomap_begin_report() can yield 0:
=09if (iomap->offset >=3D inode->i_size)
=09=09iomap->length =3D length + map.m_la - offset;

This triggers a WARN_ON in iomap_iter_done() (see line 34 of
fs/iomap/iter.c).

Hence, return error when this scenario is encountered.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This was reported as a crash by syzbot under an issue about
warning encountered in iomap_iter_done(), but unrelated to
erofs. Hence, not adding issue hash in Reported-by line.

C reproducer: https://syzkaller.appspot.com/text?tag=3DReproC&x=3D1037a6b28=
80000
Kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3De2=
021a61197ebe02
Dashboard link: https://syzkaller.appspot.com/bug?extid=3Da8e049cd3abd34293=
6b6

Reported-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 fs/erofs/zmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 0bb66927e3d0..bad852983eb9 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -796,6 +796,9 @@ static int z_erofs_iomap_begin_report(struct inode *ino=
de, loff_t offset,
 =09=09 */
 =09=09if (iomap->offset >=3D inode->i_size)
 =09=09=09iomap->length =3D length + map.m_la - offset;
+
+=09=09if (iomap->length =3D=3D 0)
+=09=09=09return -EINVAL;
 =09}
 =09iomap->flags =3D 0;
 =09return 0;
--=20
2.35.1


