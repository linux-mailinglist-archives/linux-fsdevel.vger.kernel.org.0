Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD44608F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Nov 2021 19:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhK1S3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Nov 2021 13:29:41 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17278 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236498AbhK1S1k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Nov 2021 13:27:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637931974; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Nof1v9BjaZLa7U9Yw6BND9HDJOH3W5sxq6+upyF6vQOwB4Fc7Q2Yals6F5Ev+BOs/3i0PxfG0xvE+O0hk6npLibCux886M6+C9CiVPEXU4Mw4T8H49sjONWiVTKUygo8+QhbRrP5qB3Wp7oe/0jz2Sww3Y6ZONEE1r3UuHuq9+U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637931974; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=A0WNNhMG+hvp6w62fCn0B0olJUzJi3Z1eLpxpY+eTuc=; 
        b=Q5hyVYzY/rmWRH0Exs1Otf9lIdMDa7AnCS9Ts/aK9iWdPuq+sS3zY+2PHm3c6NjQAuZJ0kW8DkOFe8wPYrglJEOpfjLQ2bA5qqBTeQP6Sq3RDTn/Z6IUAH0BlY3lqNAC+nwrSGfofx+Nht0gUlmTcA2xRqAGHLfA+f6jVdcmy5M=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637931974;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=A0WNNhMG+hvp6w62fCn0B0olJUzJi3Z1eLpxpY+eTuc=;
        b=QLPGL/NGXGIHUbDmJRtqm1rYDzwsYVYhL6xb/SqFrPS+okFeG85Tofcxx/DygeMG
        hQdbHWL4KO/uP/Zd7nwdoPwQJxfotEHuiW7KBoXafa5rptxgAeUsC5MOPHP7tRtUJx6
        grp2ryMBW3GYlXfNtjtp/AhO3kFuhaTCsAbyerXI=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1637931970561213.4333284052757; Fri, 26 Nov 2021 21:06:10 +0800 (CST)
Date:   Fri, 26 Nov 2021 21:06:10 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "miklos" <miklos@szeredi.hu>, "amir73il" <amir73il@gmail.com>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Chengguang Xu" <charliecgxu@tencent.com>,
        "ronyjin" <ronyjin@tencent.com>
Message-ID: <17d5c5a6fed.f090bcae10973.4735687401243313694@mykernel.net>
In-Reply-To: <20211126091007.GB13004@quack2.suse.cz>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
 <20211122030038.1938875-3-cgxu519@mykernel.net> <20211126091007.GB13004@quack2.suse.cz>
Subject: Re: [RFC PATCH V6 2/7] ovl: mark overlayfs inode dirty when it has
 upper
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2021-11-26 17:10:07 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Mon 22-11-21 11:00:33, Chengguang Xu wrote:
 > > From: Chengguang Xu <charliecgxu@tencent.com>
 > >=20
 > > We simply mark overlayfs inode dirty when it has upper,
 > > it's much simpler than mark dirtiness on modification.
 > >=20
 > > Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
 > > ---
 > >  fs/overlayfs/inode.c | 4 +++-
 > >  fs/overlayfs/util.c  | 1 +
 > >  2 files changed, 4 insertions(+), 1 deletion(-)
 > >=20
 > > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
 > > index 1f36158c7dbe..027ffc0a2539 100644
 > > --- a/fs/overlayfs/inode.c
 > > +++ b/fs/overlayfs/inode.c
 > > @@ -778,8 +778,10 @@ void ovl_inode_init(struct inode *inode, struct o=
vl_inode_params *oip,
 > >  {
 > >      struct inode *realinode;
 > > =20
 > > -    if (oip->upperdentry)
 > > +    if (oip->upperdentry) {
 > >          OVL_I(inode)->__upperdentry =3D oip->upperdentry;
 > > +        mark_inode_dirty(inode);
 > > +    }
 > >      if (oip->lowerpath && oip->lowerpath->dentry)
 > >          OVL_I(inode)->lower =3D igrab(d_inode(oip->lowerpath->dentry)=
);
 > >      if (oip->lowerdata)
 >=20
 > Hum, does this get called only for inodes with upper inode existing? I
 > suppose we do not need to track inodes that were not copied up because t=
hey
 > cannot be dirty? I'm sorry, my knowledge of overlayfs is rather limited =
so
 > I may be missing something basic.
 >=20

Well, as long as overly inode has upper it can be modified without copy-up,
so we need to track all overlay inodes which have upper inode.

Thanks,
Chengguang


