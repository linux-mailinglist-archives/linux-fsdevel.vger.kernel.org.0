Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D2228FC4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 03:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390161AbgJPB47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 21:56:59 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25331 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390158AbgJPB47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 21:56:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602813375; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=QIszHWXh3GCxo1hbb2nKncUNK03kkKb+2WPb2tHJnFZSH2BeAX/vKa0n8xk7jnss9xe3nMVMgN7TbzfCfoMFPF/nfo7RPS/qRCQZmZ7El20CMGO1cYly3WsS8WNDD2yGvcSwYVenJF6aK1NQUJ4Q0+c4oAm8pj+Sk4XSwbRSksY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602813375; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=NY82QGHu+nlp+ZxPKnP4WVbsSdWenZoo/g3NzzlLBVY=; 
        b=OjQVY7RTp1tjv+0p+XqnJnPWoZiLIK994NZ6QRQ6FusHd1Cj3SO6KRw2ijvzTBJ9Yegoa2dPYJp8RGW6tktjdDV5mWKpuL9vxU+ikqR1bzUTZwDVR0OfHElHQjHGId5Ez8JKA6kvDwfUqqVC9+fnR14dTD7GJYZ9mnnWxDqoc7M=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602813375;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=NY82QGHu+nlp+ZxPKnP4WVbsSdWenZoo/g3NzzlLBVY=;
        b=PU/nKBorwyNL9wQIrlkb5paOv1E7lb3p/xyRPuMljufyDAQZPXmjkkb0dSiWPaCH
        EKwL2Z6lu2zXp3WPWLBctrvRdD0aKXHfF0kjCYWTwt87sgWoc67ysxNMbWgwjj57uPx
        NmQDpCFRKjwxC9LADtUuOEmHvnXJR+6ngi+IFLbQ=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1602813373470621.3903006876136; Fri, 16 Oct 2020 09:56:13 +0800 (CST)
Date:   Fri, 16 Oct 2020 09:56:13 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Jan Kara" <jack@suse.cz>, "miklos" <miklos@szeredi.hu>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Message-ID: <1752f1f2c1a.c646418645575.6542807445910962686@mykernel.net>
In-Reply-To: <CAOQ4uxhujP_pzguq+FJ87Mx4GBNzEWQs-izuXK1qhWu3EmLpJA@mail.gmail.com>
References: <20201010142355.741645-1-cgxu519@mykernel.net> <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201014161538.GA27613@quack2.suse.cz> <1752a360692.e4f6555543384.3080516622688985279@mykernel.net>
 <CAOQ4uxhOrPfJxhJ1g7eSSdO4=giFJabCCOvJL7dSo1R9VsZozA@mail.gmail.com>
 <1752c05cbe5.fd554a7a44272.2744418978249296745@mykernel.net>
 <CAOQ4uxhEA=ggONsJrUzGfHOGHob+81-UHk1Wo9ejj=CziAjtTQ@mail.gmail.com> <1752c652963.113ee3fbc44343.6282793280578516240@mykernel.net> <CAOQ4uxhujP_pzguq+FJ87Mx4GBNzEWQs-izuXK1qhWu3EmLpJA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2020-10-16 00:02:42 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > >  > When an inode is writably mapped via ovarlayfs, you can flag t=
he
 > >  > >  > overlay inode with "maybe-writably-mapped" and then remove
 > >  > >  > it from the maybe dirty list when the underlying inode is not =
dirty
 > >  > >  > AND its i_writecount is 0 (checked on write_inode() and releas=
e()).
 > >  > >  >
 > >  > >  > Actually, there is no reason to treat writably mapped inodes a=
nd
 > >  > >  > other dirty inodes differently - insert to suspect list on ope=
n for
 > >  > >  > write, remove from suspect list on last release() or write_ino=
de()
 > >  > >  > when inode is no longer dirty and writable.
 > >
 > > I have to say inserting to suspect list cannot prevent dropping,
 > > thinking of the problem of previous approach that we write dirty upper
 > > inode with current->flags & PF_MEMALLOC while evicting clean overlay i=
node.
 > >
 >=20
 > Sorry, I don't understand what that means.

This is the main problem of my previous patch set V10, evicting clean inode
expects no write behavior but in the case of dirty upper inode we have to
write out dirty data in this timing otherwise we will lose the connection w=
ith upper inode.


 >=20
 > >
 > >  > >  >
 > >  > >  > Did I miss anything?
 > >  > >  >
 > >  > >
 > >  > > If we dirty overlay inode that means we have launched writeback m=
echanism,
 > >  > > so in this case, re-dirty overlay inode in time becomes important=
.
 > >  > >
 > >  >
 > >  > My idea was to use the first call to ovl_sync_fs() with 'wait' fals=
e
 > >  > to iterate the
 > >  > maybe-dirty list and re-dirty overlay inodes whose upper is dirty.
 > >  >
 > >
 > > I'm curious how we prevent dropping of clean overlay inode with dirty =
upper?
 > > Hold another reference during iput_final operation? in the drop_inode(=
) or something
 > > else?
 >=20
 > No, just return 0 from ovl_drop_inode() and iput_final() will not evict(=
).

It's not good,  it  only temporarily  skips eviction, the inode in lru list
will be evicted in some cases like drop cache or memory reclaim. etc.

A solution for this is getting another reference in ->drop_inode so that
the inode can escape from adding to lru list but this looks awkward and tri=
cky.

 >=20
 > >
 > >
 > >  > Then in the second call to __sync_filesystem, sync_inodes_sb() will=
 take
 > >  > care of calling ovl_write_inode() for all the re-dirty inodes.
 > >  >
 > >  > In current code we sync ALL dirty upper fs inodes and we do not ove=
rlay
 > >  > inodes with no reference in cache.
 > >  >
 > >  > The best code would sync only upper fs inodes dirtied by this overl=
ay
 > >  > and will be able to evict overlay inodes whose upper inodes are cle=
an.
 > >  >
 > >  > The compromise code would sync only upper fs inodes dirtied by this=
 overlay,
 > >  > and would not evict overlay inodes as long as upper inodes are "ope=
n for write".
 > >  > I think its a fine compromise considering the alternatives.
 > >  >
 > >  > Is this workable?
 > >  >
 > >
 > > In your approach, the key point is how to prevent dropping overlay ino=
de that has
 > > dirty upper and no reference but I don't understand well how to achiev=
e it from
 > > your descriptions.
 > >
 > >
 >=20
 > Very well, I will try to explain with code:
 >=20
 > int ovl_inode_is_open_for_write(struct inode *inode)
 > {
 >        struct inode *upper_inode =3D ovl_inode_upper(inode);
 >=20
 >        return upper_inode && inode_is_open_for_write(upper_inode);
 > }
 >=20
 > void ovl_maybe_mark_inode_dirty(struct inode *inode)
 > {
 >        struct inode *upper_inode =3D ovl_inode_upper(inode);
 >=20
 >        if (upper_inode && upper_inode->i_state & I_DIRTY_ALL)
 >                 mark_inode_dirty(inode);
 > }
 >=20
 > int ovl_open(struct inode *inode, struct file *file)
 > {
 > ...
 >        if (ovl_inode_is_open_for_write(file_inode(file)))
 >                ovl_add_inode_to_suspect_list(inode);
 >=20
 >         file->private_data =3D realfile;
 >=20
 >         return 0;
 > }
 >=20
 > int ovl_release(struct inode *inode, struct file *file)
 > {
 >        struct inode *inode =3D file_inode(file);
 >=20
 >        if (ovl_inode_is_open_for_write(inode)) {
 >                ovl_maybe_mark_inode_dirty(inode);
 >                ovl_remove_inode_from_suspect_list(inode);

I think in some cases removing from suspect_list will cause losing
the connection with upper inode that has writable mmap.


 >        }
 >=20
 >         fput(file->private_data);
 >=20
 >         return 0;
 > }
 >=20
 > int ovl_drop_inode(struct inode *inode)
 > {
 >        struct inode *upper_inode =3D ovl_inode_upper(inode);
 >=20
 >        if (!upper_inode)
 >                return 1;
 >        if (upper_inode->i_state & I_DIRTY_ALL)
 >                return 0;
 >=20
 >        return !inode_is_open_for_write(upper_inode);

Is this condition just for writable mmap?


 > }
 >=20
 > static int ovl_sync_fs(struct super_block *sb, int wait)
 > {
 >         struct ovl_fs *ofs =3D sb->s_fs_info;
 >         struct super_block *upper_sb;
 >         int ret;
 >=20
 >         if (!ovl_upper_mnt(ofs))
 >                 return 0;
 >=20
 >         /*
 >          * Not called for sync(2) call or an emergency sync (SB_I_SKIP_S=
YNC).
 >          * All the super blocks will be iterated, including upper_sb.
 >          *
 >          * If this is a syncfs(2) call, then we do need to call
 >          * sync_filesystem() on upper_sb, but enough if we do it when be=
ing
 >          * called with wait =3D=3D 1.
 >          */
 >         if (!wait) {
 >                 /* mark inodes on the suspect list dirty if thier
 > upper inode is dirty */
 >                 ovl_mark_suspect_list_inodes_dirty();
 >                 return 0;
 >         }
 > ...
 >=20

Why 2 rounds?  it seems the simplest way is only syncing dirty upper inode
on wait=3D=3D1 just like my previous patch.


 >=20
 > The races are avoided because inode is added/removed from suspect
 > list while overlay inode has a reference (from file) and because upper i=
node
 > cannot be dirtied by overlayfs when overlay inode is not on the suspect =
list.
 >=20
 > Unless I am missing something.
 >=20

Thanks,
Chengguang
