Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78645E767
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 06:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbhKZFeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 00:34:21 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17214 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344684AbhKZFcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 00:32:20 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1637903008; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=kTT6Em4JDS6/n2VGliGLaE9S+PknFWxGAUiJO4w9UcrhWM6NIlMzAx+PtzMv9HHDSNv2cP27qumLZNCOYVAznwtp8lXf6M/LqY/Gq/p/xzSUwgrV46aHdZiKMf+5JRO3Rs62wyy89VzmskC+loYa07G1bKLiqEwExGzYIzOszds=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1637903008; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=e1fy8d/F7bO0bxbGs9DFbseWsVknlDYWORiYHfsGIf8=; 
        b=D+d85SWg0ltZ94GnKtm7vV4/uUrRM6weqrb89FGTFtj4m89M2NfrXFUGJ9ojdiV/cZ7+gXsL/DBAa5KTV0Lqxv9KvyfNtzn2BrUtCvKpdzg8Gea5yYl3qHhHkcIcA/HcrdwmahOTG4+DUxHVrliJfPOrrOC6vMZtZRPBfJibA2Q=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1637903008;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=e1fy8d/F7bO0bxbGs9DFbseWsVknlDYWORiYHfsGIf8=;
        b=Nl3r5ejY1FHl1ts5hqefnDJ9sJvZpsLJORZ3A4KioqoF7ibhdDL7ysWhdndMlvgk
        bhsk/ZFNRmLwXCekMD84/SnA7kYzSfipuQe6dfXL/7ye+fUekX6MpcNkMD/JsBtfPKT
        eXfIDlXUdRRy6lvszTi851IoRCvWRkSeoVID5kQk=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 163790300607680.6143952720198; Fri, 26 Nov 2021 13:03:26 +0800 (CST)
Date:   Fri, 26 Nov 2021 13:03:26 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>, "Jan Kara" <jack@suse.cz>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Chengguang Xu" <charliecgxu@tencent.com>
Message-ID: <17d5aa0795d.fdfda4a49855.5158536783597235118@mykernel.net>
In-Reply-To: <CAOQ4uxhrg=MAL7sArmP47oyF_QmhG-1b=srs30VNdiT-9s-P0w@mail.gmail.com>
References: <20211122030038.1938875-1-cgxu519@mykernel.net> <20211122030038.1938875-8-cgxu519@mykernel.net> <CAOQ4uxhrg=MAL7sArmP47oyF_QmhG-1b=srs30VNdiT-9s-P0w@mail.gmail.com>
Subject: Re: [RFC PATCH V6 7/7] ovl: implement containerized syncfs for
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2021-11-22 15:40:59 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Mon, Nov 22, 2021 at 5:01 AM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > > From: Chengguang Xu <charliecgxu@tencent.com>
 > >
 > > Now overlayfs can only sync own dirty inodes during syncfs,
 > > so remove unnecessary sync_filesystem() on upper file system.
 > >
 > > Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
 > > ---
 > >  fs/overlayfs/super.c | 14 +++++---------
 > >  1 file changed, 5 insertions(+), 9 deletions(-)
 > >
 > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
 > > index ccffcd96491d..213b795a6a86 100644
 > > --- a/fs/overlayfs/super.c
 > > +++ b/fs/overlayfs/super.c
 > > @@ -292,18 +292,14 @@ static int ovl_sync_fs(struct super_block *sb, i=
nt wait)
 > >         /*
 > >          * Not called for sync(2) call or an emergency sync (SB_I_SKIP=
_SYNC).
 > >          * All the super blocks will be iterated, including upper_sb.
 > > -        *
 > > -        * If this is a syncfs(2) call, then we do need to call
 > > -        * sync_filesystem() on upper_sb, but enough if we do it when =
being
 > > -        * called with wait =3D=3D 1.
 > >          */
 > > -       if (!wait)
 > > -               return 0;
 > > -
 > >         upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
 > > -
 > >         down_read(&upper_sb->s_umount);
 > > -       ret =3D sync_filesystem(upper_sb);
 > > +       if (wait)
 > > +               wait_sb_inodes(upper_sb);
 > > +       if (upper_sb->s_op->sync_fs)
 > > +               upper_sb->s_op->sync_fs(upper_sb, wait);
 > > +       ret =3D ovl_sync_upper_blockdev(upper_sb, wait);
 >=20
 > I think it will be cleaner to use a helper ovl_sync_upper_filesystem()
 > with everything from  upper_sb =3D ... and a comment to explain that
 > this is a variant of __sync_filesystem() where all the dirty inodes writ=
e
 > have already been started.
 >=20
=20
I agree with you.=20

Thanks,
Chengguang
