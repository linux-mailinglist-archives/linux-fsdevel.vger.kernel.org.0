Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9E04253B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 15:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbhJGNMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 09:12:21 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25317 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233155AbhJGNMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:12:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1633612196; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=haOK2xU5ATdFB8BeqmldXdLMOL7uw9dnFEcfBU87O+zPdn38Wyi0GEKBYyYCdlPDoQIS3Bev6xNLURPqmdtTG7BwLZPH+eqeLnDmHtjjcNrX/uzvHQdqWz3rIZA7eqEA+KyLfCfmvoNvqmSBCO+7q8Gdf1WuzZrN8By5tbyrdwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1633612196; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=CN/oJT4bmpU1h2TGDRDhhmNNwMjkNLqc1SD+PyBgSxM=; 
        b=ntQr7FL0RX9bxR0Im9yORF441LWQ1Te3NKK+Q8V40l4ZCoIhIkTftYWwftlpvnqGFECjojx0IK6LBlqp2F1WrSHfthFlbJnxi+mK7Mg17jGWpWxlY2cTFggUqFgwnKv/tgqHUIOxq4pZhaStyI/nAkSU+z8ce7C8s1mZ95MwccE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1633612196;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=CN/oJT4bmpU1h2TGDRDhhmNNwMjkNLqc1SD+PyBgSxM=;
        b=Jd4MfDu251kVkwmRd4OvWFq5VRb4u8YWRzdOGj/yByMUNfMp1uUcidZlbPXO4Q1T
        g9kz6MvKn5EBBrfEZH71Fgwkz4zIe8R0UQXMaxv4btWl2MiWESgL3sQ0YnqnK8u9bV1
        1W0UcGW1f4Oz/VyJAJEDS+cWNfiDEG5CXL0TrnLo=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1633612195310853.6373080083519; Thu, 7 Oct 2021 21:09:55 +0800 (CST)
Date:   Thu, 07 Oct 2021 21:09:55 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Jan Kara" <jack@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
In-Reply-To: <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-7-cgxu519@mykernel.net>
 <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com> <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net> <CAJfpegtr1NkOiY9YWd1meU1yiD-LFX-aB55UVJs94FrX0VNEJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 20:45:20 Miklos Sze=
redi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > On Thu, 7 Oct 2021 at 14:28, Chengguang Xu <cgxu519@mykernel.net> wrote:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 17:23:06 Miklo=
s Szeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > >  > On Thu, 23 Sept 2021 at 15:08, Chengguang Xu <cgxu519@mykernel.net>=
 wrote:
 > >  > >
 > >  > > Implement overlayfs' ->write_inode to sync dirty data
 > >  > > and redirty overlayfs' inode if necessary.
 > >  > >
 > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > > ---
 > >  > >  fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
 > >  > >  1 file changed, 30 insertions(+)
 > >  > >
 > >  > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
 > >  > > index 2ab77adf7256..cddae3ca2fa5 100644
 > >  > > --- a/fs/overlayfs/super.c
 > >  > > +++ b/fs/overlayfs/super.c
 > >  > > @@ -412,12 +412,42 @@ static void ovl_evict_inode(struct inode *i=
node)
 > >  > >         clear_inode(inode);
 > >  > >  }
 > >  > >
 > >  > > +static int ovl_write_inode(struct inode *inode,
 > >  > > +                          struct writeback_control *wbc)
 > >  > > +{
 > >  > > +       struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
 > >  > > +       struct inode *upper =3D ovl_inode_upper(inode);
 > >  > > +       unsigned long iflag =3D 0;
 > >  > > +       int ret =3D 0;
 > >  > > +
 > >  > > +       if (!upper)
 > >  > > +               return 0;
 > >  > > +
 > >  > > +       if (!ovl_should_sync(ofs))
 > >  > > +               return 0;
 > >  > > +
 > >  > > +       if (upper->i_sb->s_op->write_inode)
 > >  > > +               ret =3D upper->i_sb->s_op->write_inode(inode, wbc=
);
 > >  >
 > >  > Where is page writeback on upper inode triggered?
 > >  >
 > >
 > > Should pass upper inode instead of overlay inode here.
 >=20
 > That's true and it does seem to indicate lack of thorough testing.

It's a little bit weird this passed all overlay cases and generic/474(syncf=
s) without errors in xfstests.
Please let me do more diagnosis on this and strengthen the test case.


 >=20
 > However that wasn't what I was asking about.  AFAICS ->write_inode()
 > won't start write back for dirty pages.   Maybe I'm missing something,
 > but there it looks as if nothing will actually trigger writeback for
 > dirty pages in upper inode.
 >=20

Actually, page writeback on upper inode will be triggered by overlayfs ->wr=
itepages and
overlayfs' ->writepages will be called by vfs writeback function (i.e write=
back_sb_inodes).

Thanks,
Chengguang



