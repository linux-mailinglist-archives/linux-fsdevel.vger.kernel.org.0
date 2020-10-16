Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EBB28FF59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 09:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404682AbgJPHnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 03:43:47 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25332 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404574AbgJPHnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 03:43:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602834186; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=rUtc8ja7MUOqbclFK3k7rGLv/OVPwVh9tYjo7Aeq3soAbWNJAs/aV3uoxWCEdzBfUQJUNcKjXNWOW6+PXPKK4nHSUsrN7kLAL2m6h8pTQQbCHEeKhKN614XCxLVi07qiBFrSAnttTK9Trn9rUqM5Xcc8TYF2MUYAB8LgmnbHiXE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602834186; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=0TiOawj5z6ozBRpbSf/pBUiARNw9Qco7o6BnAvMDPR4=; 
        b=TeaTVl9BuzXFLE+SOTAa04T5LU0LQSyXjcuYHxSTvuTn0SIjqqYkMXx3yEeI96mpO5sIrBPd0KYWrC5GEo6UFLDuoLoajHelX/W4Qoka65aPMKKPuMnD573oDnhOzs9hWLzEPJijLKlaXSAk+z2FSCZm0o1BTnJo1VU3ONpcsFE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602834186;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=0TiOawj5z6ozBRpbSf/pBUiARNw9Qco7o6BnAvMDPR4=;
        b=gPVm2lyT077UMZgUis7i89UAVgO8J8qeAb6SkNJbH1ssKQp9bBQ12U9PdzJpOsco
        TL3ZEUzutMvCq6ggwnc7rH6/QA04DW4I7UOD+rIdogHor1pQYWEu3frQXo9Cb4rR2gY
        3ZXVdO0uNexuE/S+pq7/R3IQQ2I3E+0/s1x5tHAA=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1602834184462391.00614447527903; Fri, 16 Oct 2020 15:43:04 +0800 (CST)
Date:   Fri, 16 Oct 2020 15:43:04 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Jan Kara" <jack@suse.cz>, "miklos" <miklos@szeredi.hu>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Message-ID: <175305cb90b.11646f2f146354.1810975809173386959@mykernel.net>
In-Reply-To: <CAOQ4uxgJ=soSgdWo20iNtm30hua8kL8Do3T_FH2uTehQWOGsTg@mail.gmail.com>
References: <20201010142355.741645-1-cgxu519@mykernel.net> <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201014161538.GA27613@quack2.suse.cz> <1752a360692.e4f6555543384.3080516622688985279@mykernel.net>
 <CAOQ4uxhOrPfJxhJ1g7eSSdO4=giFJabCCOvJL7dSo1R9VsZozA@mail.gmail.com>
 <1752c05cbe5.fd554a7a44272.2744418978249296745@mykernel.net>
 <CAOQ4uxhEA=ggONsJrUzGfHOGHob+81-UHk1Wo9ejj=CziAjtTQ@mail.gmail.com>
 <1752c652963.113ee3fbc44343.6282793280578516240@mykernel.net>
 <CAOQ4uxhujP_pzguq+FJ87Mx4GBNzEWQs-izuXK1qhWu3EmLpJA@mail.gmail.com> <1752f1f2c1a.c646418645575.6542807445910962686@mykernel.net> <CAOQ4uxgJ=soSgdWo20iNtm30hua8kL8Do3T_FH2uTehQWOGsTg@mail.gmail.com>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2020-10-16 12:39:10 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Fri, Oct 16, 2020 at 4:56 AM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2020-10-16 00:02:42 Amir =
Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > >  > >  > When an inode is writably mapped via ovarlayfs, you can f=
lag the
 > >  > >  > >  > overlay inode with "maybe-writably-mapped" and then remov=
e
 > >  > >  > >  > it from the maybe dirty list when the underlying inode is=
 not dirty
 > >  > >  > >  > AND its i_writecount is 0 (checked on write_inode() and r=
elease()).
 > >  > >  > >  >
 > >  > >  > >  > Actually, there is no reason to treat writably mapped ino=
des and
 > >  > >  > >  > other dirty inodes differently - insert to suspect list o=
n open for
 > >  > >  > >  > write, remove from suspect list on last release() or writ=
e_inode()
 > >  > >  > >  > when inode is no longer dirty and writable.
 > >  > >
 > >  > > I have to say inserting to suspect list cannot prevent dropping,
 > >  > > thinking of the problem of previous approach that we write dirty =
upper
 > >  > > inode with current->flags & PF_MEMALLOC while evicting clean over=
lay inode.
 > >  > >
 > >  >
 > >  > Sorry, I don't understand what that means.
 > >
 > > This is the main problem of my previous patch set V10, evicting clean =
inode
 > > expects no write behavior but in the case of dirty upper inode we have=
 to
 > > write out dirty data in this timing otherwise we will lose the connect=
ion with upper inode.
 > >
 >=20
 > My thinking was that the suspect list holds a reference to the overlay i=
node.
 > The question is can we always safely get rid of that reference and remov=
e
 > from the suspect list when the inode is no longer "writable". Let's see.=
..
 >=20
 > >
 > >  >
 > >  > >
 > >  > >  > >  >
 > >  > >  > >  > Did I miss anything?
 > >  > >  > >  >
 > >  > >  > >
 > >  > >  > > If we dirty overlay inode that means we have launched writeb=
ack mechanism,
 > >  > >  > > so in this case, re-dirty overlay inode in time becomes impo=
rtant.
 > >  > >  > >
 > >  > >  >
 > >  > >  > My idea was to use the first call to ovl_sync_fs() with 'wait'=
 false
 > >  > >  > to iterate the
 > >  > >  > maybe-dirty list and re-dirty overlay inodes whose upper is di=
rty.
 > >  > >  >
 > >  > >
 > >  > > I'm curious how we prevent dropping of clean overlay inode with d=
irty upper?
 > >  > > Hold another reference during iput_final operation? in the drop_i=
node() or something
 > >  > > else?
 > >  >
 > >  > No, just return 0 from ovl_drop_inode() and iput_final() will not e=
vict().
 > >
 > > It's not good,  it  only temporarily  skips eviction, the inode in lru=
 list
 > > will be evicted in some cases like drop cache or memory reclaim. etc.
 > >
 > > A solution for this is getting another reference in ->drop_inode so th=
at
 > > the inode can escape from adding to lru list but this looks awkward an=
d tricky.
 > >
 >=20
 > Right, that was nonsense. We need to rely on the reference held by the
 > suspect list.
 >=20
 > >  >
 > >  > >
 > >  > >
 > >  > >  > Then in the second call to __sync_filesystem, sync_inodes_sb()=
 will take
 > >  > >  > care of calling ovl_write_inode() for all the re-dirty inodes.
 > >  > >  >
 > >  > >  > In current code we sync ALL dirty upper fs inodes and we do no=
t overlay
 > >  > >  > inodes with no reference in cache.
 > >  > >  >
 > >  > >  > The best code would sync only upper fs inodes dirtied by this =
overlay
 > >  > >  > and will be able to evict overlay inodes whose upper inodes ar=
e clean.
 > >  > >  >
 > >  > >  > The compromise code would sync only upper fs inodes dirtied by=
 this overlay,
 > >  > >  > and would not evict overlay inodes as long as upper inodes are=
 "open for write".
 > >  > >  > I think its a fine compromise considering the alternatives.
 > >  > >  >
 > >  > >  > Is this workable?
 > >  > >  >
 > >  > >
 > >  > > In your approach, the key point is how to prevent dropping overla=
y inode that has
 > >  > > dirty upper and no reference but I don't understand well how to a=
chieve it from
 > >  > > your descriptions.
 > >  > >
 > >  > >
 > >  >
 > >  > Very well, I will try to explain with code:
 > >  >
 > >  > int ovl_inode_is_open_for_write(struct inode *inode)
 > >  > {
 > >  >        struct inode *upper_inode =3D ovl_inode_upper(inode);
 > >  >
 > >  >        return upper_inode && inode_is_open_for_write(upper_inode);
 > >  > }
 > >  >
 > >  > void ovl_maybe_mark_inode_dirty(struct inode *inode)
 > >  > {
 > >  >        struct inode *upper_inode =3D ovl_inode_upper(inode);
 > >  >
 > >  >        if (upper_inode && upper_inode->i_state & I_DIRTY_ALL)
 > >  >                 mark_inode_dirty(inode);
 > >  > }
 > >  >
 > >  > int ovl_open(struct inode *inode, struct file *file)
 > >  > {
 > >  > ...
 > >  >        if (ovl_inode_is_open_for_write(file_inode(file)))
 > >  >                ovl_add_inode_to_suspect_list(inode);
 > >  >
 > >  >         file->private_data =3D realfile;
 > >  >
 > >  >         return 0;
 > >  > }
 > >  >
 > >  > int ovl_release(struct inode *inode, struct file *file)
 > >  > {
 > >  >        struct inode *inode =3D file_inode(file);
 > >  >
 > >  >        if (ovl_inode_is_open_for_write(inode)) {
 > >  >                ovl_maybe_mark_inode_dirty(inode);
 > >  >                ovl_remove_inode_from_suspect_list(inode);
 > >
 > > I think in some cases removing from suspect_list will cause losing
 > > the connection with upper inode that has writable mmap.
 > >
 >=20
 > First of all I had a bug here.
 > Need to check for !ovl_inode_is_open_for_write(inode) after fput().
 >=20
 > If the upper inode has a writable mmap, the upper inode would still
 > be "writable" (i_writecount held by the map realfile reference).
 >=20
 > So when closing the last overlay file reference while upper inode
 > writable maps still exist, the remaining issue is when to remove
 > the overlay inode from the suspect list and allow its eviction and
 > I did not mention that.
 >=20
 > I *think* that this condition should be safe in the regard that
 > after the condition is met, there is no way to dirty the upper inode
 > via overlayfs without going through ovl_open().
 > Obviously, the test should be done with some list lock held.
 >=20
 > bool ovl_may_remove_from_suspect_list(struct inode *inode)
 > {
 >         struct inode *upper_inode =3D ovl_inode_upper(inode);
 >=20
 >         if (upper_inode && upper_inode->i_state & I_DIRTY_ALL)
 >                 return false;
 >=20
 >         return !inode_is_open_for_write(upper_inode);
 > }
 >=20
 > Now remains the question of WHEN to check for removal
 > from the suspect list.
 >=20
 > The first place is in ovl_sync_fs() when iterating the suspect list,
 > inodes that meet the above criteria are "indefinitely clean" and
 > may be removed from the list at that timing.
 >=20
 > For eviction during memory pressure, overlay can register a
 > shrinker to do this garbage collection. Is shrinker being called
 > on drop_caches? I'm not sure. But we can also do periodic garbage
 > collection.
 >=20
 > In the end, it is not the common case and we just need the garbage
 > collection to mitigate DoS (or existing workload) that does many:
 > - open
 > - mmap(...PROT_WRITE, MAP_SHARED...)
 > - close
 > - munmap
 >=20

That right, as you mentioned above releasing timing is important and
that also means in worst case, overlayfs hold too much memory resource
until umount. Maybe more proactive shrinker like dedicated workqueue
thread of overlayfs instead of global shrinker will be more helpful.



 >=20
 > >
 > >  >        }
 > >  >
 > >  >         fput(file->private_data);
 > >  >
 > >  >         return 0;
 > >  > }
 > >  >
 > >  > int ovl_drop_inode(struct inode *inode)
 > >  > {
 > >  >        struct inode *upper_inode =3D ovl_inode_upper(inode);
 > >  >
 > >  >        if (!upper_inode)
 > >  >                return 1;
 > >  >        if (upper_inode->i_state & I_DIRTY_ALL)
 > >  >                return 0;
 > >  >
 > >  >        return !inode_is_open_for_write(upper_inode);
 > >
 > > Is this condition just for writable mmap?
 > >
 >=20
 > No, it's for all inodes that may be written from overlayfs (or
 > from maps created by overalyfs), but as you wrote, this
 > test is not needed in drop_inode().
 >=20
 > >
 > >  > }
 > >  >
 > >  > static int ovl_sync_fs(struct super_block *sb, int wait)
 > >  > {
 > >  >         struct ovl_fs *ofs =3D sb->s_fs_info;
 > >  >         struct super_block *upper_sb;
 > >  >         int ret;
 > >  >
 > >  >         if (!ovl_upper_mnt(ofs))
 > >  >                 return 0;
 > >  >
 > >  >         /*
 > >  >          * Not called for sync(2) call or an emergency sync (SB_I_S=
KIP_SYNC).
 > >  >          * All the super blocks will be iterated, including upper_s=
b.
 > >  >          *
 > >  >          * If this is a syncfs(2) call, then we do need to call
 > >  >          * sync_filesystem() on upper_sb, but enough if we do it wh=
en being
 > >  >          * called with wait =3D=3D 1.
 > >  >          */
 > >  >         if (!wait) {
 > >  >                 /* mark inodes on the suspect list dirty if thier
 > >  > upper inode is dirty */
 > >  >                 ovl_mark_suspect_list_inodes_dirty();
 > >  >                 return 0;
 > >  >         }
 > >  > ...
 > >  >
 > >
 > > Why 2 rounds?  it seems the simplest way is only syncing dirty upper i=
node
 > > on wait=3D=3D1 just like my previous patch.
 > >
 >=20
 > We don't have to do it in 2 rounds, but as long as we have a suspect lis=
t,
 > we can use it to start writeback on wait=3D=3D0 on all dirty upper inode=
s from
 > our list just like the caller intended.
 >=20
 > Do we need overlay sbi and mark_inode_dirty() and ovl_write_inode() at a=
ll?
 > I'm not sure. It feels like a good idea to use generic infrastructure as=
 much as
 > possible. You should know better than me to answer this question.
 >=20

IMO, if we maintain a special list like suspect-list to organize target ove=
rlay inodes,
then we don't have to mark overlay inode dirty, marking overlay inode dirty=
 will
bring unnecessary complexity in this case and I think there is no special b=
enefit.

So this approach may achieve containerized syncfs for overlayfs and I've su=
bmitted
patch set V12 follow this thinking but I think the complexity is still big =
obstacle to
merge to upstream from feedback of Miklos. The new approach I posted the ot=
her day
is really simple to understand compare to the previous solution, if we can =
optimize
dirtiness  notification part a bit more then I think it will be more accept=
able.

In the end, I need more feedback and  If you guys all think the previous so=
lution  is the right way,=20
then I can do more work based on our discussion above and post V13 later.


Thanks,
Chengguang








=20

