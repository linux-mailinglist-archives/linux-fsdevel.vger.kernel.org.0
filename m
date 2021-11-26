Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21774601DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 23:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355735AbhK0WFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 17:05:45 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17225 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235987AbhK0WDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 17:03:44 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637932178; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=YCD9Qy/t2w3SG/dzfftvb30u8EtAqWFB0/v7Gz5mdsDG1lqyu9jplrgieI983y96ACu3TkHCX8b01GKHM55T/OU6FAQ8dcNYRTmnarjSbxT9g2a5aVINpvv7DC7wRJoXwqz59IREFqMDrvFpKNhVagDKOIiykKK/0ZcWsa3ukFE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637932178; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=DKINIDnMGkMKeLcTBYO3BxCbPU2T+QmP00nUmcd3ZJM=; 
        b=Er6e0/lkmSRSDyV226mD5NFNTE/ZyV1j6Sg4apZ8oYShb5o7o/EuMxFx6NPd3wIaEr3a34zyjqlEa5amf7z0Elcsdj/6FjwkhpNuytXuHv6z29aHOZgioU8SOVfHCs4LkJrbOdseCedcLEQLiSxbsKHOHOML12KgAWoPIAlxFoU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637932178;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=DKINIDnMGkMKeLcTBYO3BxCbPU2T+QmP00nUmcd3ZJM=;
        b=TSAddY81PkFDLj1aC2Geq5A7DpzYXqjiqX2cd1JiU6+p8vo+ip6IQL0AJwqYzL8q
        SL/EUFY7eXLVgpH6U+sChP4Mp9AvTMG1SmkiGP7ZB/e4e59TCqEV3ypRXpjFSaUYX4Q
        jlj9W1EHKYPABmA1E5luDrb6We20clxMVRqlY6V0=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 163793217656496.81082384691524; Fri, 26 Nov 2021 21:09:36 +0800 (CST)
Date:   Fri, 26 Nov 2021 21:09:36 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "miklos" <miklos@szeredi.hu>, "amir73il" <amir73il@gmail.com>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Chengguang Xu" <charliecgxu@tencent.com>,
        "ronyjin" <ronyjin@tencent.com>
Message-ID: <17d5c5d9498.134e725b210976.7805957202314611987@mykernel.net>
In-Reply-To: <20211126091430.GC13004@quack2.suse.cz>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
 <20211122030038.1938875-4-cgxu519@mykernel.net> <20211126091430.GC13004@quack2.suse.cz>
Subject: Re: [RFC PATCH V6 3/7] ovl: implement overlayfs' own ->write_inode
 operation
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2021-11-26 17:14:30 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Mon 22-11-21 11:00:34, Chengguang Xu wrote:
 > > From: Chengguang Xu <charliecgxu@tencent.com>
 > >=20
 > > Sync dirty data and meta of upper inode in overlayfs' ->write_inode()
 > > and redirty overlayfs' inode.
 > >=20
 > > Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
 >=20
 > Looks good. I'm still not 100% convinced keeping inodes dirty all the ti=
me
 > will not fire back in excessive writeback activity (e.g. flush worker wi=
ll
 > traverse the list of all dirty inodes every 30 seconds and try to write
 > them) but I guess we can start with this and if people complain, dirtine=
ss
 > handling can be improved.=20

Hi Jan,

Thanks for the review and suggestion.


Thanks,
Chengguang



 > So feel free to add:
 >=20
 > Reviewed-by: Jan Kara <jack@suse.cz>
 >=20
 >                                 Honza
 >=20
 > > ---
 > >  fs/overlayfs/super.c | 21 +++++++++++++++++++++
 > >  1 file changed, 21 insertions(+)
 > >=20
 > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
 > > index 18a12088a37b..12acf0ec7395 100644
 > > --- a/fs/overlayfs/super.c
 > > +++ b/fs/overlayfs/super.c
 > > @@ -15,6 +15,7 @@
 > >  #include <linux/seq_file.h>
 > >  #include <linux/posix_acl_xattr.h>
 > >  #include <linux/exportfs.h>
 > > +#include <linux/writeback.h>
 > >  #include "overlayfs.h"
 > > =20
 > >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
 > > @@ -406,12 +407,32 @@ static int ovl_remount(struct super_block *sb, i=
nt *flags, char *data)
 > >      return ret;
 > >  }
 > > =20
 > > +static int ovl_write_inode(struct inode *inode,
 > > +               struct writeback_control *wbc)
 > > +{
 > > +    struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
 > > +    struct inode *upper_inode =3D ovl_inode_upper(inode);
 > > +    int ret =3D 0;
 > > +
 > > +    if (!upper_inode)
 > > +        return 0;
 > > +
 > > +    if (!ovl_should_sync(ofs))
 > > +        return 0;
 > > +
 > > +    ret =3D write_inode_now(upper_inode, wbc->sync_mode =3D=3D WB_SYN=
C_ALL);
 > > +    mark_inode_dirty(inode);
 > > +
 > > +    return ret;
 > > +}
 > > +
 > >  static const struct super_operations ovl_super_operations =3D {
 > >      .alloc_inode    =3D ovl_alloc_inode,
 > >      .free_inode    =3D ovl_free_inode,
 > >      .destroy_inode    =3D ovl_destroy_inode,
 > >      .drop_inode    =3D generic_delete_inode,
 > >      .put_super    =3D ovl_put_super,
 > > +    .write_inode    =3D ovl_write_inode,
 > >      .sync_fs    =3D ovl_sync_fs,
 > >      .statfs        =3D ovl_statfs,
 > >      .show_options    =3D ovl_show_options,
 > > --=20
 > > 2.27.0
 > >=20
 > >=20
 > --=20
 > Jan Kara <jack@suse.com>
 > SUSE Labs, CR
 >=20
