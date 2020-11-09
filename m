Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD22AB27F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 09:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgKIIei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 03:34:38 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25302 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729802AbgKIIeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:34:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604910853; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=eLkqsoKJki7/pUwoIiZpkqnnQE2FPf5zGTjzQ3+nzXlKe/d8Oh3hRPUWCxbTXwduQiyeKCZOv+v9MzCk2v120pYIdlwHxKl+jO2SLqz3vyk2P0uCV4XPcdV93wmxUnT/2JQrPRQcWlkwbn0R7xN7NuEuaRaemN4alN12BcD1s8U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604910853; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=+VfFGKqjk05dlEpp3PoUDxQIHEEXgct7SZ8Z3PFRYVE=; 
        b=IBlcAhz4i/k8AhM7U11HNa31qGpY4Z5l8wqqJRJ4agveH8Ed5p5wU0HFnl4e+tQFw5xFUinQG7uhdaS6DsP0rJ+U6oVqSuNrCii8oLy+4ZjajqRn0Ombvi6T1CG9nunU1rg+pYCeSTmWB2NV4a9UGvVXie1JAUkmFZqmInUUbqI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604910853;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=+VfFGKqjk05dlEpp3PoUDxQIHEEXgct7SZ8Z3PFRYVE=;
        b=fsFAygO4MZU43PtZwtibhUrgR2k0kKwO+om5+/WjrMesKbQjJzoB2XQOf7DPUWLY
        6/hBh9U9M5ZIjbOHJK0UunpZSnqqCwdGWZWm5tPFUv82nKttQipZNNUpfo8VA3q2UyR
        srcwIOppHjsUFOqHdWeLfaXEIj5Tz68LlZHnExGA=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 160491085017282.12469642172573; Mon, 9 Nov 2020 16:34:10 +0800 (CST)
Date:   Mon, 09 Nov 2020 16:34:10 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "miklos" <miklos@szeredi.hu>, "jack" <jack@suse.cz>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <175ac242078.1287a39451704.7442694321257329129@mykernel.net>
In-Reply-To: <CAOQ4uxhVQC_PDPaYvO9KTSJ6Vrnds-yHmsyt631TSkBq6kqQ5g@mail.gmail.com>
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
 <20201108140307.1385745-10-cgxu519@mykernel.net> <175ab1145ed.108462b5a912.9181293177019474923@mykernel.net> <CAOQ4uxhVQC_PDPaYvO9KTSJ6Vrnds-yHmsyt631TSkBq6kqQ5g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/10] ovl: introduce helper of syncfs writeback
 inode waiting
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-11-09 15:07:18 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Mon, Nov 9, 2020 at 5:34 AM Chengguang Xu <cgxu519@mykernel.net> wrot=
e:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E6=97=A5, 2020-11-08 22:03:06 Cheng=
guang Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 > >  > Introduce a helper ovl_wait_wb_inodes() to wait until all
 > >  > target upper inodes finish writeback.
 > >  >
 > >  > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > ---
 > >  >  fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
 > >  >  1 file changed, 30 insertions(+)
 > >  >
 > >  > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
 > >  > index e5607a908d82..9a535fc11221 100644
 > >  > --- a/fs/overlayfs/super.c
 > >  > +++ b/fs/overlayfs/super.c
 > >  > @@ -255,6 +255,36 @@ static void ovl_put_super(struct super_block *=
sb)
 > >  >      ovl_free_fs(ofs);
 > >  >  }
 > >  >
 > >  > +void ovl_wait_wb_inodes(struct ovl_fs *ofs)
 > >  > +{
 > >  > +    LIST_HEAD(tmp_list);
 > >  > +    struct ovl_inode *oi;
 > >  > +    struct inode *upper;
 > >  > +
 > >  > +    spin_lock(&ofs->syncfs_wait_list_lock);
 > >  > +    list_splice_init(&ofs->syncfs_wait_list, &tmp_list);
 > >  > +
 > >  > +    while (!list_empty(&tmp_list)) {
 > >  > +        oi =3D list_first_entry(&tmp_list, struct ovl_inode, wait_=
list);
 > >  > +        list_del_init(&oi->wait_list);
 > >  > +        ihold(&oi->vfs_inode);
 > >
 > > Maybe I overlooked race condition with inode eviction, so still need t=
o introduce
 > > OVL_EVICT_PENDING flag just like we did in old syncfs efficiency patch=
 series.
 > >
 >=20
 > I am not sure why you added the ovl wait list.
 >=20
 > I think you misunderstood Jan's suggestion.
 > I think what Jan meant is that ovl_sync_fs() should call
 > wait_sb_inodes(upper_sb)
 > to wait for writeback of ALL upper inodes after sync_filesystem()
 > started writeback
 > only on this ovl instance upper inodes.
 >=20


Maybe you are right, the wait list is just for accuracy that can completely
avoid interferes between ovl instances, otherwise we may need to face
waiting interferes  in high density environment.=20


 > I am not sure if this is acceptable or not - it is certainly an improvem=
ent over
 > current situation, but I have a feeling that on a large scale (many
 > containers) it
 > won't be enough.
 >=20

The same as your thought.=20


 > The idea was to keep it simple without over optimizing, since anyway
 > you are going for the "correct" solution long term (ovl inode aops),
 > so I wouldn't
 > add the wait list.
 >=20

Maybe, I think it depends on how to implement ovl page-cache, so at current
stage I have no idea for the wait list.


 > As long as the upper inode is still dirty, we can keep the ovl inode in =
cache,
 > so the worst outcome is that drop_caches needs to get called twice befor=
e the
 > ovl inode can be evicted, no?
 >=20
=20
IIUC, since currently ovl does not have it's own page-cache, so there is no=
 affect to page-cache reclaim,=20
also  there is no ovl shrinker to reclaim slab because we drop ovl inode di=
rectly after final iput.=20
So should we add a shrinker in this series?


Thanks,
Chengguang



