Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27782AD9DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 16:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgKJPMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 10:12:55 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25384 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731450AbgKJPMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:12:55 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1605021136; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=PCd8n3BhtypUfdMXLYROsIHlStU7SIYkym127tuRof830GVxcFtINnsO90GW5sXXIVBYus/S9KYAW1YqrJW2jreaMSR8m0iNoqAi9YvyCrx0KlVQA9qvsD8WP7xtZUpZogOm0wa2PT8hHs2hAr4Yej/V9OoAUfWwrerYTqizWGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1605021136; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=LJ6AsdiD74STNa1twe5St3ZMGrmg4LjQXeZILt1GPR8=; 
        b=OC5azQ6sk9oYg8y4ytUvzsDfVqE7aRYFsGNU28PAg3kkVdwY9t9E7CKL2YK50LH7xjj+A9XCoO1mJ0OLLjRgmzG9QbyaUMHmVwm+S0Y730lm/g//flG6CBseZ7kUkkjSH844Zug6V+kW7cTh2qhumRcfQXha51LcvsQPBad37EQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1605021136;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=LJ6AsdiD74STNa1twe5St3ZMGrmg4LjQXeZILt1GPR8=;
        b=Gio28/1/+6JfXhMbRK9ZCPgAf30wPSlHvkuKo48fROuZz7nuCy1zTlLJSQ1UL98b
        rWzPaTduI4pCB1YT4iLLs1dy8dCbO7H0mZngalteiV4yjtuX8lcrUhyjIm5fNr3wpGH
        uUYGI2rPDPuHkRN9cRboBQvUy6+Hwk3UOquVgYZg=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1605021134656930.2158116996183; Tue, 10 Nov 2020 23:12:14 +0800 (CST)
Date:   Tue, 10 Nov 2020 23:12:14 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "miklos" <miklos@szeredi.hu>, "amir73il" <amir73il@gmail.com>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <175b2b6ef3d.11f9425843834.4407023737229017217@mykernel.net>
In-Reply-To: <20201110134551.GA28132@quack2.suse.cz>
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
 <20201108140307.1385745-8-cgxu519@mykernel.net> <20201110134551.GA28132@quack2.suse.cz>
Subject: Re: [RFC PATCH v3 07/10] ovl: implement overlayfs' ->write_inode
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2020-11-10 21:45:51 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Sun 08-11-20 22:03:04, Chengguang Xu wrote:
 > > +static int ovl_write_inode(struct inode *inode,
 > > +               struct writeback_control *wbc)
 > > +{
 > > +    struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
 > > +    struct inode *upper =3D ovl_inode_upper(inode);
 > > +    unsigned long iflag =3D 0;
 > > +    int ret =3D 0;
 > > +
 > > +    if (!upper)
 > > +        return 0;
 > > +
 > > +    if (!ovl_should_sync(ofs))
 > > +        return 0;
 > > +
 > > +    if (upper->i_sb->s_op->write_inode)
 > > +        ret =3D upper->i_sb->s_op->write_inode(inode, wbc);
 > > +
 > > +    iflag |=3D upper->i_state & I_DIRTY_ALL;
 > > +
 > > +    if (mapping_writably_mapped(upper->i_mapping) ||
 > > +        mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
 > > +        iflag |=3D I_DIRTY_PAGES;
 > > +
 > > +    if (iflag)
 > > +        ovl_mark_inode_dirty(inode);
 >=20
 > I think you didn't incorporate feedback we were speaking about in the la=
st
 > version of the series. May comment in [1] still applies - you can miss
 > inodes dirtied through mmap when you decide to clean the inode here. So
 > IMHO you need something like:
 >=20
 >     if (inode_is_open_for_write(inode))
 >         ovl_mark_inode_dirty(inode);
 >=20
 > here to keep inode dirty while it is open for write (and not based on up=
per
 > inode state which is unreliable).

Hi Jan,

I not only checked upper inode state but also checked upper inode mmap(shar=
ed) state
using  mapping_writably_mapped(upper->i_mapping). Maybe it's better to move=
 i_state check
after mmap check but isn't above checks enough for mmapped file?=20

Below code is the definition of mmapping_writably_mapped(), I think it will=
 check shared mmap
regardless write or read permission though the function name is quite confu=
sable.

static inline int mapping_writably_mapped(struct address_space *mapping)
{
=09return atomic_read(&mapping->i_mmap_writable) > 0;
}



Thanks,
Chengguang


 >=20
 >                                 Honza
 >=20
 > [1] https://lore.kernel.org/linux-fsdevel/20201105140332.GG32718@quack2.=
suse.cz/
 >=20
 > > +
 > > +    return ret;
 > > +}
 > > +
 > >  static void ovl_evict_inode(struct inode *inode)
 > >  {
 > >      struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
 > > @@ -411,6 +440,7 @@ static const struct super_operations ovl_super_ope=
rations =3D {
 > >      .destroy_inode    =3D ovl_destroy_inode,
 > >      .drop_inode    =3D generic_delete_inode,
 > >      .evict_inode    =3D ovl_evict_inode,
 > > +    .write_inode    =3D ovl_write_inode,
 > >      .put_super    =3D ovl_put_super,
 > >      .sync_fs    =3D ovl_sync_fs,
 > >      .statfs        =3D ovl_statfs,
 > > --=20
 > > 2.26.2
 > >=20
 > >=20
 > --=20
 > Jan Kara <jack@suse.com>
 > SUSE Labs, CR
 >=20
