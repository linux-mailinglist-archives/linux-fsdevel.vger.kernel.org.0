Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4637C35ED04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 08:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349155AbhDNGOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 02:14:44 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25393 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349138AbhDNGOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:14:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618380849; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=JNeQotS4kkgZHnPV0JMvW0VxaH1lbgOkIF6EaT/Rlo2/K8E/pGZ+YwthWzwKtbpHcr5PcqWzacyJJlnWzOwjrZk3mh3Yzxugrbjl6lFufur+QzP2+fYugVTw2XZf23cZxe4WtgdIAdHDii/LJ8Nw3jJ02+z0pw+FXloNl2vKx0s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1618380849; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=j0653ywqZAdpT6wQ/eknGI1RW2Keq7fohCtg0SJIZpY=; 
        b=PwwoYW97RfaxoMv5dnguj+uNlE3aNxcBv37O4JvvrFsYbDrwJCdhxLmDnHCes071K2+ey1Nyftfd34fPIvXiFvXw/RiUfFUc2QIFyfydzB4+kU9k/pCrWC2lDnT/yQ4GzkqNhbsvx5wdOl5oCwKnLjKERlFMNT1Ta2fvYekP7Zg=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618380849;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=j0653ywqZAdpT6wQ/eknGI1RW2Keq7fohCtg0SJIZpY=;
        b=f3ttytDS8bq1mTXcwGdHv1NcGHrtCrFappktK1ZFvQY3olTlkV9oUYjEnTHv+4ZC
        1C7x9juTy1G3yspP9LGly6Y+PDPKS1ryRM6Paiu6EC6RL+qwSYuAG//3efR1lcSjAfg
        8nxUE43OHiotzgCxDb/NB5ozxhenzS71vhPNE2P4=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1618380846192877.8642334081887; Wed, 14 Apr 2021 14:14:06 +0800 (CST)
Date:   Wed, 14 Apr 2021 14:14:06 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Jan Kara" <jack@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <178cf03f46d.10b2d86c733121.8697562232310027680@mykernel.net>
In-Reply-To: <CAJfpegt6BUvEL2NtfMkYJfC_NBuLxKhV3U7-h4azhoM+ttxZAA@mail.gmail.com>
References: <20201113065555.147276-1-cgxu519@mykernel.net> <20201113065555.147276-7-cgxu519@mykernel.net> <CAJfpegt6BUvEL2NtfMkYJfC_NBuLxKhV3U7-h4azhoM+ttxZAA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 6/9] ovl: implement overlayfs' ->write_inode
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

---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2021-04-09 21:49:07 Miklos Szer=
edi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > On Fri, Nov 13, 2020 at 7:57 AM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > > Implement overlayfs' ->write_inode to sync dirty data
 > > and redirty overlayfs' inode if necessary.
 > >
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > > ---
 > >  fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
 > >  1 file changed, 30 insertions(+)
 > >
 > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
 > > index 883172ac8a12..82e001b97f38 100644
 > > --- a/fs/overlayfs/super.c
 > > +++ b/fs/overlayfs/super.c
 > > @@ -390,6 +390,35 @@ static int ovl_remount(struct super_block *sb, in=
t *flags, char *data)
 > >         return ret;
 > >  }
 > >
 > > +static int ovl_write_inode(struct inode *inode,
 > > +                          struct writeback_control *wbc)
 > > +{
 > > +       struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
 > > +       struct inode *upper =3D ovl_inode_upper(inode);
 > > +       unsigned long iflag =3D 0;
 > > +       int ret =3D 0;
 > > +
 > > +       if (!upper)
 > > +               return 0;
 > > +
 > > +       if (!ovl_should_sync(ofs))
 > > +               return 0;
 > > +
 > > +       if (upper->i_sb->s_op->write_inode)
 > > +               ret =3D upper->i_sb->s_op->write_inode(inode, wbc);
 > > +
 > > +       if (mapping_writably_mapped(upper->i_mapping) ||
 > > +           mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
 > > +               iflag |=3D I_DIRTY_PAGES;
 > > +
 > > +       iflag |=3D upper->i_state & I_DIRTY_ALL;
 >=20
 > How is I_DIRTY_SYNC added/removed from the overlay inode?
 >=20

generally, I_DIRTY_SYNC is added to overlay inode when the operation dirtie=
s
upper inode, I'll check all those places and call ovl_mark_inode_dirty() to=
 do it.
After writeback if upper inode becomes clean status, we will remove I_DIRTY=
_SYNC
from overlay inode.

One exception is mmaped file, it will always keep I_DIRTY_SYNC until to be =
evicted.

Thanks,
Chengguang



