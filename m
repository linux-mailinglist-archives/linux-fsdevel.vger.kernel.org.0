Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED11425305
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 14:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbhJGMaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 08:30:55 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25332 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241238AbhJGMay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:30:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1633609721; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=jO5VSUtVuj5ZGL2dXmaje7hUPuDK/78OSMPF4FCxZ6amM5k9kM6C9DEROgLRiKlfozuCbEyQKdldr8o/MJsIEWZij2UQH75NCHVuKwt3DYDZjceB2PlZSVZW+9LpAgGOmu2Avlu39IeUqoKBN/haBA4O8PjzZqaMCRSnY+tCyFU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1633609721; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=htGAHz9e59NjyVWexCSrR7QA0fzfw1Pu+KZNBe+k36w=; 
        b=m2GFrY6JxAWE3fv3R5c+uGFKV2SEue2M0EWzK5d6x2/YG/6Os0KtqUKoqoRZ7aOd2bMZmG2+eO29XP7kSfqB88LW9ALxV5bT9sWABt2Hob6o2zWNn454r+KsJCHrhUsFZLX/s4INea8gfpseDYD3ABlY0fvrzRV0dsAS8fCimP0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1633609721;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=htGAHz9e59NjyVWexCSrR7QA0fzfw1Pu+KZNBe+k36w=;
        b=AF+FIu6pYZetGusYQYc3nyjtnE3RwSNZp7GODBT0IUQ9Vp8hEYob1VBjMDy5Bn0P
        mnKWrqQ0sHDsoZyhX7D697UkWRahKaJwPlfMIFi0S8J4CDet20/pxF7dmhQg4Il1D4I
        FteZuH1KZ5IaVYahQMUjNrrI5KpRDv3z9kGvZhp0=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1633609719794520.3264862999721; Thu, 7 Oct 2021 20:28:39 +0800 (CST)
Date:   Thu, 07 Oct 2021 20:28:39 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Jan Kara" <jack@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17c5aba1fef.c5c03d5825886.6577730832510234905@mykernel.net>
In-Reply-To: <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
References: <20210923130814.140814-1-cgxu519@mykernel.net> <20210923130814.140814-7-cgxu519@mykernel.net> <CAJfpeguqj2vst4Zj5EovSktJkXiDSCSWY=X12X0Yrz4M8gPRmQ@mail.gmail.com>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10-07 17:23:06 Miklos Sze=
redi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > On Thu, 23 Sept 2021 at 15:08, Chengguang Xu <cgxu519@mykernel.net> wrot=
e:
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
 > > index 2ab77adf7256..cddae3ca2fa5 100644
 > > --- a/fs/overlayfs/super.c
 > > +++ b/fs/overlayfs/super.c
 > > @@ -412,12 +412,42 @@ static void ovl_evict_inode(struct inode *inode)
 > >         clear_inode(inode);
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
 >=20
 > Where is page writeback on upper inode triggered?
 >=20

Should pass upper inode instead of overlay inode here.

Thanks,
Chengguang


