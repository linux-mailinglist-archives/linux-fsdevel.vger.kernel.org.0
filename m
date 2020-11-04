Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015F32A6414
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 13:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgKDMSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 07:18:51 -0500
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25373 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726344AbgKDMSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:18:51 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604492298; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=WmQHoaXD8haA8YfaqkUSfzAFHobX5JUht++COkiW+J1ZiIWtGL4fxDfgRpnwzcHxCSHCPjfgCedEQE6U3CC49SMN9U/QAj3VHiJKgQ7Ue/Zq0zD/zYgdf9QhMo3tp92jpZ2wtWgf0L4avW/CTM3PkBHmHF1cLgPI1Yz0bPAMEjI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604492298; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=fOYcXvz8TBsP/EL22VTNi2cy2YXzZLHBmh57tXE0MuA=; 
        b=RkUgsrCQtMCUWgiOtX7WIyCICS8bZz/4Nyb2MiO6Iz0X1+nCNHhusAmTHf/Y9efjpFzlBLvFGy2Tsmn3w5azj2A2SJow9+ZO7TqJUdSXwWotN76PYtOkmG2wRkX8yPNLL6yWVeiwInoyXzQSiFL5qhI6aG+aU1Hn0ifSN0nrGC0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604492298;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=fOYcXvz8TBsP/EL22VTNi2cy2YXzZLHBmh57tXE0MuA=;
        b=T6IccPlJ2ND077NZ2lqgzEjielHYLTchmlN3OuGfMVEBqIqtqgsCmt2JNZXVUhd+
        vxrhkgsSmRdY9CPxL05YpE4geuOq+3LZi6UEpZnI0QpQoWTdrA02ySr2mHwoDaqnUcT
        /9w4SAGp6QRwG0Kedk3l9Um4OvyLhjIQzOHM2jE0=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1604492296653165.76731359124267; Wed, 4 Nov 2020 20:18:16 +0800 (CST)
Date:   Wed, 04 Nov 2020 20:18:16 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "miklos" <miklos@szeredi.hu>, "amir73il" <amir73il@gmail.com>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "cgxu519" <cgxu519@mykernel.net>,
        "charliecgxu" <charliecgxu@tencent.com>
Message-ID: <175933181cc.ed06c3957114.1028981429730337490@mykernel.net>
In-Reply-To: <20201102171741.GE23988@quack2.suse.cz>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
 <20201025034117.4918-3-cgxu519@mykernel.net> <20201102171741.GE23988@quack2.suse.cz>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2020-11-03 01:17:41 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Sun 25-10-20 11:41:11, Chengguang Xu wrote:
 > > Implement overlayfs' ->writepages operation so that
 > > we can sync dirty data/metadata to upper filesystem.
 > >=20
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > > ---
 > >  fs/overlayfs/inode.c | 26 ++++++++++++++++++++++++++
 > >  1 file changed, 26 insertions(+)
 > >=20
 > > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
 > > index b584dca845ba..f27fc5be34df 100644
 > > --- a/fs/overlayfs/inode.c
 > > +++ b/fs/overlayfs/inode.c
 > > @@ -11,6 +11,7 @@
 > >  #include <linux/posix_acl.h>
 > >  #include <linux/ratelimit.h>
 > >  #include <linux/fiemap.h>
 > > +#include <linux/writeback.h>
 > >  #include "overlayfs.h"
 > > =20
 > > =20
 > > @@ -516,7 +517,32 @@ static const struct inode_operations ovl_special_=
inode_operations =3D {
 > >      .update_time    =3D ovl_update_time,
 > >  };
 > > =20
 > > +static int ovl_writepages(struct address_space *mapping,
 > > +              struct writeback_control *wbc)
 > > +{
 > > +    struct inode *upper_inode =3D ovl_inode_upper(mapping->host);
 > > +    struct ovl_fs *ofs =3D  mapping->host->i_sb->s_fs_info;
 > > +    struct writeback_control tmp_wbc =3D *wbc;
 > > +
 > > +    if (!ovl_should_sync(ofs))
 > > +        return 0;
 > > +
 > > +    /*
 > > +     * for sync(2) writeback, it has a separate external IO
 > > +     * completion path by checking PAGECACHE_TAG_WRITEBACK
 > > +     * in pagecache, we have to set for_sync to 0 in thie case,
 > > +     * let writeback waits completion after syncing individual
 > > +     * dirty inode, because we haven't implemented overlayfs'
 > > +     * own pagecache yet.
 > > +     */
 > > +    if (wbc->for_sync && (wbc->sync_mode =3D=3D WB_SYNC_ALL))
 > > +        tmp_wbc.for_sync =3D 0;
 >=20
 > This looks really hacky as it closely depends on the internal details of
 > writeback implementation. I'd be more open to say export wait_sb_inodes(=
)
 > for overlayfs use... Because that's what I gather you need in your
 > overlayfs ->syncfs() implementation.
 >=20

Does  that mean we gather synced overlay's inode into a new waiting list(ov=
erlay's) and
do the waiting behavior in overlay's ->syncfs() ?


Thanks,
Chengguang


