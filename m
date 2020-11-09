Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDED2AB7BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 13:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgKIMHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 07:07:20 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25370 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbgKIMHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:07:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604923618; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=qe78cWUlmh7E0IY1JRLyeakMwJ4T0F8VJ4/tTAgqRm0cTwMCMQadrec1qhL7UOsGv7lzNqDzq/y5yYL/XcXsTNmZUKHCubRznvUoUjkAym5rltrRRaE/9MV18TuG1VN+FPsGFNHCbqSDZqMy2mMMPKjQvBOcR/36T1Ajqmii6zw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604923618; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=avWOhL7glwMpIu2WoR3GYGnQfJPc2r9R50tJEv3kAh0=; 
        b=SSsOMeoC6JwQmhUcSTY29NNPphIAjDg8d2rBsVVaL1+oAww3EWcWAGWD36g0jZBYvh5BIYt6IOfYqY20J4tFkJz3okGIc+rQpwEMPeA6uG16FwO2hhep9ay+YQiJRf+/N8qYmk1YN+zBEk2pc2rBVfkTIo2WGslOtn6aJ3oGlEY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604923618;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=avWOhL7glwMpIu2WoR3GYGnQfJPc2r9R50tJEv3kAh0=;
        b=XIv4I8aC9JqJJfJzPPG0mrgHQoruLGes805VOakPKaHV7JBa1igWZ1gIK1xXWq/G
        /RRhFuSbWWAbZrDnnuM2/uZ7somzsmfjNnzadBFuXLp2gdCbZsuGBcNuDfTFgRF8/72
        kYEZLbqzlxVm3OuEB7htwNfAruLup/DNKPf/8Weg=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1604923616737476.87992746898044; Mon, 9 Nov 2020 20:06:56 +0800 (CST)
Date:   Mon, 09 Nov 2020 20:06:56 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "miklos" <miklos@szeredi.hu>, "jack" <jack@suse.cz>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <175ace6edde.c8001f892368.3152350117841492998@mykernel.net>
In-Reply-To: <CAOQ4uxgfi26HDp6YWx3Tgc1tY_EMrfcW_hz5FMG8vXeHLdycBw@mail.gmail.com>
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
 <20201108140307.1385745-10-cgxu519@mykernel.net> <175ab1145ed.108462b5a912.9181293177019474923@mykernel.net>
 <CAOQ4uxhVQC_PDPaYvO9KTSJ6Vrnds-yHmsyt631TSkBq6kqQ5g@mail.gmail.com> <175ac242078.1287a39451704.7442694321257329129@mykernel.net> <CAOQ4uxgfi26HDp6YWx3Tgc1tY_EMrfcW_hz5FMG8vXeHLdycBw@mail.gmail.com>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-11-09 18:07:18 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Mon, Nov 9, 2020 at 10:34 AM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-11-09 15:07:18 Amir =
Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > On Mon, Nov 9, 2020 at 5:34 AM Chengguang Xu <cgxu519@mykernel.net>=
 wrote:
 > >  > >
 > >  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E6=97=A5, 2020-11-08 22:03:06 =
Chengguang Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 > >  > >  > Introduce a helper ovl_wait_wb_inodes() to wait until all
 > >  > >  > target upper inodes finish writeback.
 > >  > >  >
 > >  > >  > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > >  > ---
 > >  > >  >  fs/overlayfs/super.c | 30 ++++++++++++++++++++++++++++++
 > >  > >  >  1 file changed, 30 insertions(+)
 > >  > >  >
 > >  > >  > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
 > >  > >  > index e5607a908d82..9a535fc11221 100644
 > >  > >  > --- a/fs/overlayfs/super.c
 > >  > >  > +++ b/fs/overlayfs/super.c
 > >  > >  > @@ -255,6 +255,36 @@ static void ovl_put_super(struct super_bl=
ock *sb)
 > >  > >  >      ovl_free_fs(ofs);
 > >  > >  >  }
 > >  > >  >
 > >  > >  > +void ovl_wait_wb_inodes(struct ovl_fs *ofs)
 > >  > >  > +{
 > >  > >  > +    LIST_HEAD(tmp_list);
 > >  > >  > +    struct ovl_inode *oi;
 > >  > >  > +    struct inode *upper;
 > >  > >  > +
 > >  > >  > +    spin_lock(&ofs->syncfs_wait_list_lock);
 > >  > >  > +    list_splice_init(&ofs->syncfs_wait_list, &tmp_list);
 > >  > >  > +
 > >  > >  > +    while (!list_empty(&tmp_list)) {
 > >  > >  > +        oi =3D list_first_entry(&tmp_list, struct ovl_inode, =
wait_list);
 > >  > >  > +        list_del_init(&oi->wait_list);
 > >  > >  > +        ihold(&oi->vfs_inode);
 > >  > >
 > >  > > Maybe I overlooked race condition with inode eviction, so still n=
eed to introduce
 > >  > > OVL_EVICT_PENDING flag just like we did in old syncfs efficiency =
patch series.
 > >  > >
 > >  >
 > >  > I am not sure why you added the ovl wait list.
 > >  >
 > >  > I think you misunderstood Jan's suggestion.
 > >  > I think what Jan meant is that ovl_sync_fs() should call
 > >  > wait_sb_inodes(upper_sb)
 > >  > to wait for writeback of ALL upper inodes after sync_filesystem()
 > >  > started writeback
 > >  > only on this ovl instance upper inodes.
 > >  >
 > >
 > >
 > > Maybe you are right, the wait list is just for accuracy that can compl=
etely
 > > avoid interferes between ovl instances, otherwise we may need to face
 > > waiting interferes  in high density environment.
 > >
 > >
 > >  > I am not sure if this is acceptable or not - it is certainly an imp=
rovement over
 > >  > current situation, but I have a feeling that on a large scale (many
 > >  > containers) it
 > >  > won't be enough.
 > >  >
 > >
 > > The same as your thought.
 > >
 > >
 > >  > The idea was to keep it simple without over optimizing, since anywa=
y
 > >  > you are going for the "correct" solution long term (ovl inode aops)=
,
 > >  > so I wouldn't
 > >  > add the wait list.
 > >  >
 > >
 > > Maybe, I think it depends on how to implement ovl page-cache, so at cu=
rrent
 > > stage I have no idea for the wait list.
 > >
 > >
 > >  > As long as the upper inode is still dirty, we can keep the ovl inod=
e in cache,
 > >  > so the worst outcome is that drop_caches needs to get called twice =
before the
 > >  > ovl inode can be evicted, no?
 > >  >
 > >
 > > IIUC, since currently ovl does not have it's own page-cache, so there =
is no affect to page-cache reclaim,
 > > also  there is no ovl shrinker to reclaim slab because we drop ovl ino=
de directly after final iput.
 > > So should we add a shrinker in this series?
 > >
 >=20
 > Would that add a lot of complexity?

Sorry, don't need any other shrinker because inode and dentry use common vf=
s shrinker.

 > Thinking out loud: maybe we follow Jan's suggestion and fix remaining
 > performance with followup series?
 >=20

Okay,  so let's leave it as homework.


Thanks,
Chengguang
