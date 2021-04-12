Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8ED835C629
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 14:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbhDLMYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 08:24:55 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25325 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240245AbhDLMYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:24:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618230246; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=bEvDju2VmmhyxA0MQHI3ieq9imj1Lv/YeBjbYNc2fbD2CZ5NLfO2PQNh/BhxcYktVBwPqxVa14v/T8RJ2nwYCK/rTPDCwv96gmKsdi9uKxkFPjmb+e1BvnDRDLmv7sBkb2eycGSNKH+0u5QgKQy3BGHKEggudgMzl7jRh13XUCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1618230246; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=jyoRTl11XnFlwSLYSvB+ALJyQNLOu0fvqy3RRrlj+cI=; 
        b=GuJe24rvJcofVNTiLmibx7cqeoaR1J3R6ItXPvoO3BPSw86arDYuP7ZhxmRC8CWMGdlvKVuGKSklP4r6hqtBFv+deOadlDJhj0V25xlKhNr/QPmemRFBkSTMysScrxxaV/wC7zIJAG4jQ1QCL3EOdWxY3EN+RBejXGyZR043Z7U=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618230246;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=jyoRTl11XnFlwSLYSvB+ALJyQNLOu0fvqy3RRrlj+cI=;
        b=Zv5i308hSijNDqMK1TPhqGfuhftm/zlAUQggezo7aFYaeMjFqMIvOH1GtzuD6XNR
        bVIN1D/UgEs3sUOAWStAmcS4rioBoEUROEkMLtRpPGD3l9/VxIOjKMoXOZOd1Rqa3iB
        vu+j0zjBJ4Zkr+3dy06/g7Cv1vfnPq18JB9cwwS8=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 161823024420153.377930275199105; Mon, 12 Apr 2021 20:24:04 +0800 (CST)
Date:   Mon, 12 Apr 2021 20:24:04 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Jan Kara" <jack@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <178c609f366.d091ec3b20881.6800515353355931740@mykernel.net>
In-Reply-To: <CAJfpegsoDL7maNtU7P=OwFy_XPgcyiBOGFzaKRbGnhfwz-HyYw@mail.gmail.com>
References: <20201113065555.147276-1-cgxu519@mykernel.net> <20201113065555.147276-10-cgxu519@mykernel.net> <CAJfpegsoDL7maNtU7P=OwFy_XPgcyiBOGFzaKRbGnhfwz-HyYw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] ovl: implement containerized syncfs for
 overlayfs
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2021-04-09 21:51:26 Miklos Sze=
redi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > On Fri, Nov 13, 2020 at 7:57 AM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > > Now overlayfs can only sync dirty inode during syncfs,
 > > so remove unnecessary sync_filesystem() on upper file
 > > system.
 > >
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > > ---
 > >  fs/overlayfs/super.c | 11 ++++++++---
 > >  1 file changed, 8 insertions(+), 3 deletions(-)
 > >
 > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
 > > index 982b3954b47c..58507f1cd583 100644
 > > --- a/fs/overlayfs/super.c
 > > +++ b/fs/overlayfs/super.c
 > > @@ -15,6 +15,8 @@
 > >  #include <linux/seq_file.h>
 > >  #include <linux/posix_acl_xattr.h>
 > >  #include <linux/exportfs.h>
 > > +#include <linux/blkdev.h>
 > > +#include <linux/writeback.h>
 > >  #include "overlayfs.h"
 > >
 > >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 > > @@ -270,8 +272,7 @@ static int ovl_sync_fs(struct super_block *sb, int=
 wait)
 > >          * Not called for sync(2) call or an emergency sync (SB_I_SKIP=
_SYNC).
 > >          * All the super blocks will be iterated, including upper_sb.
 > >          *
 > > -        * If this is a syncfs(2) call, then we do need to call
 > > -        * sync_filesystem() on upper_sb, but enough if we do it when =
being
 > > +        * if this is a syncfs(2) call, it will be enough we do it whe=
n being
 > >          * called with wait =3D=3D 1.
 > >          */
 > >         if (!wait)
 > > @@ -280,7 +281,11 @@ static int ovl_sync_fs(struct super_block *sb, in=
t wait)
 > >         upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
 > >
 > >         down_read(&upper_sb->s_umount);
 > > -       ret =3D sync_filesystem(upper_sb);
 > > +       wait_sb_inodes(upper_sb);
 > > +       if (upper_sb->s_op->sync_fs)
 > > +               ret =3D upper_sb->s_op->sync_fs(upper_sb, wait);
 > > +       if (!ret)
 > > +               ret =3D sync_blockdev(upper_sb->s_bdev);
 >=20
 > Should this instead be __sync_blockdev(..., wait)?
=20
I don't remember why we skipped the case of (wait =3D=3D 0) here, just gues=
s it's not worth
to export internal function __sync_blockdev() to modules, do you prefer to =
call __sync_blockdev()
and handle both nowait and wait cases?


Thanks,
Chengguang





