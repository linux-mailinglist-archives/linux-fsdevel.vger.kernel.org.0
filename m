Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829BE20C139
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 14:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgF0MSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 08:18:30 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17151 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725926AbgF0MSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 08:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593260264; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=JsbcrppJgNJrFG//rrLd2AwrjM2Dt8+yoEuF+LVGV9wifwA1VDI+N0x8dLE701ubQFmvIIJjShdFuEzkonehqxUOTooFs2UQY+rYRNPF2ilHh/3DrjA1QF7jVO0RXVcMv74gAGLYASu/k+MpZf76whAFCmWNOFlTcMzjX0sjJpc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1593260264; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=QRLJ2rD+rCWmkqmAVg5emu4lLaHKtdXn/ykyWo/w1mI=; 
        b=Nw2NVIwSVEk74j2Ff+Xb/e4+pS/NnDRxh0OADeUjsSofqesnOYtfwwFArodoTlZPRS3MmH0pEwu0UsUpIJnBhK381+rNu9TxChcGwlopFCsAU0HqG+ppgYxMKByGSP0YXWfJXsq03FconfvGTSxvLMbx9R7gmahs35dnS08UN5w=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1593260264;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=QRLJ2rD+rCWmkqmAVg5emu4lLaHKtdXn/ykyWo/w1mI=;
        b=ZsT7Ihu7rxPJVEBBd8AonrIyT/oYwb7rVTq6qDWmsfe4aM3bM6LbmavFfmnVBO8E
        rxCOkcVCZEZrKb2cAzgYvH2lmx4ldJxHNdxQOrLUkQywmGJSNaOssFCKSnLPMDf7esW
        FWxSUIim5t0znwlPuRyqLsR96cJEBSUG5yAriJIE=
Received: from localhost.localdomain (113.116.51.119 [113.116.51.119]) by mx.zoho.com.cn
        with SMTPS id 159326026118856.86340483602953; Sat, 27 Jun 2020 20:17:41 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20200627121726.415145-1-cgxu519@mykernel.net>
Subject: [PATCH] vfs: remove unnecessary assignment in do_sys_ftruncate()
Date:   Sat, 27 Jun 2020 20:17:26 +0800
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have already set error to -EINVAL, so don't have to do
it again.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/open.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 6cd48a61cda3..f1ec0c1ad135 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -177,7 +177,6 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, i=
nt small)
 =09if (!S_ISREG(inode->i_mode) || !(f.file->f_mode & FMODE_WRITE))
 =09=09goto out_putf;
=20
-=09error =3D -EINVAL;
 =09/* Cannot ftruncate over 2^31 bytes without large file support */
 =09if (small && length > MAX_NON_LFS)
 =09=09goto out_putf;
--=20
2.26.2


