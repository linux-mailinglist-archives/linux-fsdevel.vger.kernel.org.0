Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FFC2A8F1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 06:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgKFF6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 00:58:21 -0500
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25335 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbgKFF6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:58:20 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604642240; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=LYjdGnfi021LuB4QgaW+dbBLtDboul9WPjG8bwnjkcCZn+8dXgUfi81DVEXrVvFBImGcDVSuSdAmcMvESou0ErdS8gCaLLyvajiF1ppxqSUtGUaSFWhjNh0Q5MLiCTTB5vN6htpHhYzyhwnYALvuHnetisposmB+w+kxopHLk44=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604642240; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=z3qWmHC14BBSPeLesJ8+hp8sqT82/iEPZsHvcR+mGHY=; 
        b=ZIkRDEJ8zjACSh+lZmWvlZ4KMQfwupxMuHyurxcKzk7tTFUvevidxmIoG8EjtBq5OQqadMidZStegNgnZZVRC/qq6Rzcuul3g4lP9PXi0NTnlyOGsf2lJ7KX80UeXzWbxY0WKnBtCLFHV0uxtlFILe0NdJBBcDDYlai3doq0dPk=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604642240;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=z3qWmHC14BBSPeLesJ8+hp8sqT82/iEPZsHvcR+mGHY=;
        b=VSb+rOj6mMA6HWwJRzJ1fNZUu78Bl2KPWiPP3OXiL64BNS17GrM7SDQmXF+NiHmc
        paUqSI6yK1mhD2azvDpq+imOlBN+oyf+7oyhl5kYJ4J0QOUxnQtdxS6QFYEnrwYifA5
        pkmDhGXCCQ2IHtLAuQf17ixYZZ3Ai5E6mtLZkW3o=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1604642238648758.3577613040594; Fri, 6 Nov 2020 13:57:18 +0800 (CST)
Date:   Fri, 06 Nov 2020 13:57:18 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "miklos" <miklos@szeredi.hu>, "amir73il" <amir73il@gmail.com>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "charliecgxu" <charliecgxu@tencent.com>
Message-ID: <1759c2170b7.10787b05f11522.5880193413134534573@mykernel.net>
In-Reply-To: <20201105135506.GF32718@quack2.suse.cz>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
 <20201025034117.4918-3-cgxu519@mykernel.net>
 <20201102171741.GE23988@quack2.suse.cz>
 <175933181cc.ed06c3957114.1028981429730337490@mykernel.net> <20201105135506.GF32718@quack2.suse.cz>
Subject: Re: [RFC PATCH v2 2/8] ovl: implement ->writepages operation
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2020-11-05 21:55:06 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Wed 04-11-20 20:18:16, Chengguang Xu wrote:
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2020-11-03 01:17:41 Jan K=
ara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > >  > On Sun 25-10-20 11:41:11, Chengguang Xu wrote:
 > >  > > Implement overlayfs' ->writepages operation so that
 > >  > > we can sync dirty data/metadata to upper filesystem.
 > >  > >=20
 > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > > ---
 > >  > >  fs/overlayfs/inode.c | 26 ++++++++++++++++++++++++++
 > >  > >  1 file changed, 26 insertions(+)
 > >  > >=20
 > >  > > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
 > >  > > index b584dca845ba..f27fc5be34df 100644
 > >  > > --- a/fs/overlayfs/inode.c
 > >  > > +++ b/fs/overlayfs/inode.c
 > >  > > @@ -11,6 +11,7 @@
 > >  > >  #include <linux/posix_acl.h>
 > >  > >  #include <linux/ratelimit.h>
 > >  > >  #include <linux/fiemap.h>
 > >  > > +#include <linux/writeback.h>
 > >  > >  #include "overlayfs.h"
 > >  > > =20
 > >  > > =20
 > >  > > @@ -516,7 +517,32 @@ static const struct inode_operations ovl_spe=
cial_inode_operations =3D {
 > >  > >      .update_time    =3D ovl_update_time,
 > >  > >  };
 > >  > > =20
 > >  > > +static int ovl_writepages(struct address_space *mapping,
 > >  > > +              struct writeback_control *wbc)
 > >  > > +{
 > >  > > +    struct inode *upper_inode =3D ovl_inode_upper(mapping->host)=
;
 > >  > > +    struct ovl_fs *ofs =3D  mapping->host->i_sb->s_fs_info;
 > >  > > +    struct writeback_control tmp_wbc =3D *wbc;
 > >  > > +
 > >  > > +    if (!ovl_should_sync(ofs))
 > >  > > +        return 0;
 > >  > > +
 > >  > > +    /*
 > >  > > +     * for sync(2) writeback, it has a separate external IO
 > >  > > +     * completion path by checking PAGECACHE_TAG_WRITEBACK
 > >  > > +     * in pagecache, we have to set for_sync to 0 in thie case,
 > >  > > +     * let writeback waits completion after syncing individual
 > >  > > +     * dirty inode, because we haven't implemented overlayfs'
 > >  > > +     * own pagecache yet.
 > >  > > +     */
 > >  > > +    if (wbc->for_sync && (wbc->sync_mode =3D=3D WB_SYNC_ALL))
 > >  > > +        tmp_wbc.for_sync =3D 0;
 > >  >=20
 > >  > This looks really hacky as it closely depends on the internal detai=
ls of
 > >  > writeback implementation. I'd be more open to say export wait_sb_in=
odes()
 > >  > for overlayfs use... Because that's what I gather you need in your
 > >  > overlayfs ->syncfs() implementation.
 > >  >=20
 > >=20
 > > Does  that mean we gather synced overlay's inode into a new waiting li=
st(overlay's) and
 > > do the waiting behavior in overlay's ->syncfs() ?
 >=20
 > My idea was that you'd just use the standard writeback logic which ends =
up
 > gathering upper_sb inodes in the upper_sb->s_inodes_wb and then wait for
 > them in overlay's ->syncfs(). Maybe we'll end up waiting for more inodes
 > than strictly necessary but it shouldn't be too bad I'd say...
 >=20

Yeah, I agree with you, I'll modify in next version.


Thanks,
Chengguang
