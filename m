Return-Path: <linux-fsdevel+bounces-69776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9684C84C0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70CBD4E8DCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8DB314A70;
	Tue, 25 Nov 2025 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR6UoXuC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A52749CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070444; cv=none; b=hN/prk0J+eHrEC2w4trTDHpduF2tRE+UxSqRl29o+zkxVaqz9C0+jtvO78q0be5YBRVnqx6szitwh4rovZgsBvahvsDRfTgYcXVBqXyTC8yixUx1PdjeSzKhwmSpS2n7aoofrnlkYD8Ae7ogxvTWrD8K3Y09XoTUtH4DVC2T0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070444; c=relaxed/simple;
	bh=gD8fKTNewNsFeuzEjgtxICOg9mPgtyzZA9NpDqhNhxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlPVuf5/+PlUpYb3ADd9ejlxknX9DTjYNHVdqNnsYpTAZ4NKIA447dv117Rdpr7L67tR336MiB/axUOC6+xRDNlr6U+VigmFhtnHWm+rYDCoIAo5dMnVvApZk++Dd20rERozPqfmy/osEesaNgEtGsPN6wXbAbnWCHfU7PKI+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR6UoXuC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b739b3fc2a0so125848666b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 03:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764070438; x=1764675238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3grKS4UOp8qd45oFpIFm7lzCDINzHuZUTldsW5EHkA=;
        b=AR6UoXuCdtnXPV8h2qJvbjTwqX+uvzw3jPL8f87xPAsvNYVJ2CmeyHbVWo4uVeDTk9
         SWf9xXYTLWr2vLastJ8MgdRU6jszUyxUAGMXuW+Xo+yFerG9CZYjG1FtukcVGZRRttlm
         +AprOu5rShwfTpk16/pBCteyzrw4K0eXMsF53w15Gb0HSHoOruGIVqq8LfMfSoWN40K2
         gF0hDGfRamJfCC+gVH8eg5jLPmkW/UrR1qLsjL782dO2oIk00BIRncAgiptlCt4/EAh9
         S5X5I1zcA20wyLJ98FP17g28f/3k3b4m1kWXR2pyC6C9vmx4kACkpQxOf7nv39IULu5K
         Ld6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764070438; x=1764675238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C3grKS4UOp8qd45oFpIFm7lzCDINzHuZUTldsW5EHkA=;
        b=LPOOgSZ8o7i2l8LR/xEejCyaxEI+sxO+7QixvL5aet4MhpTEebF5vuR6NT+zLC11sD
         8ZyAicpoTMugmgfLHPyDAukpFlGp+y0NYx5Xs+FlgKQWnFwCvLMxkBtoSDFT1xcUFKoT
         o/tB8PrCABTkeQ8IecS7mSdxukn43ttwxerM5R0HovQhvcBt0z4KVXOZaf1tE3h0g9p0
         RAQJ1XreVEWz716LmLeqVIhGp0ceO8Nr4jFaWX43ttN/aOjN3fBSYhPH2ZCe5B0KYASZ
         Fq32wFSZclLQ3sszFIdAQAW3N+YW0rOO7Pwxd6jHgM9FVCc2yJ84eHMQZ9P0q2CondlA
         Pi9A==
X-Forwarded-Encrypted: i=1; AJvYcCX5HJA5KmFWxl7MQzbUk6ud/7btZwRF8TpGGhbSH+dN6ppF7zIXu3xYYt2SgPX6bFPAdfO/9b1XWMCxiWBc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5EnZvlbhYrdYfdQvPlGSDolY+qltQsyM56SWW2yDiTyMkszEK
	FyT8FQJvkkSriQRszEVwsAq4hm8tO9maxnFzzELndapJAMtGF7b3Bu0ErBJsrEdml2s8eYYiep2
	K7QlT/p21yYoFWTsAvGtDw2mwc+GL5suNPg==
X-Gm-Gg: ASbGnctwEQL9ZpncCwTyl2atVKBOcdXB3S1+wk2zPaLM8XFLDUiX+1iYv6YSERJh6HU
	7NXh8LTsRpDKGEEOsTQ2zFxIQj7NPQNGTcW1APvQG5FMVDAKQw3jc0MsU6Tjo6GXeN0pHXO2K/d
	j/2uDfnx8Rapjkh2j2X2N5EbIzWsrItY7VO104EuM0x1UwFxuvi15sl+xG549KO+971gzFdpP+E
	mIA+UkBd/buU3mqSHFSYvBb6ownXANCWOJ/UO8uqEddvFMofm7A0D2vazYYbFGRG35jMUaO3g1r
	E+Iwqc9nC8MmvuiY2Uk/hU2jHmpVgTAp3dL/
X-Google-Smtp-Source: AGHT+IGCT/yELvTd4eOpkaieC36kMxFG8AfmIrwIi6dJNg24+/95dAJdTMdbWFN5hkD37bavcPyIweajLt/biqEhseY=
X-Received: by 2002:a17:906:f5aa:b0:b45:60ad:daf9 with SMTP id
 a640c23a62f3a-b76c5355bb2mr255377366b.3.1764070438226; Tue, 25 Nov 2025
 03:33:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121072818.3230541-1-mjguzik@gmail.com> <d2xotmpncid4rlsahjm7lsszqjrgn6kgtta4w5flvsawcp6guu@neqoz2ayoccm>
In-Reply-To: <d2xotmpncid4rlsahjm7lsszqjrgn6kgtta4w5flvsawcp6guu@neqoz2ayoccm>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 25 Nov 2025 12:33:46 +0100
X-Gm-Features: AWmQ_bkiLNsUXbl-kbDIVtZWjIKxojCRogJOalug9HnDr6CemddH-Hxm3VJjr0E
Message-ID: <CAGudoHE9DbPVtn+v8mUJvQ69FNp1ieCUH2QWwTW9kRd43o_wXw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: scale opening of character devices
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 12:26=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 21-11-25 08:28:18, Mateusz Guzik wrote:
> > chrdev_open() always takes cdev_lock, which is only needed to synchroni=
ze
> > against cd_forget(). But the latter is only ever called by inode evict(=
),
> > meaning these two can never legally race. Solidify this with asserts.
>
> Are you sure? Because from a quick glance it doesn't seem that inodes hol=
d
> a refcount of the cdev. Thus inode->i_cdev can freed if you don't hold
> cdev_lock - it is only the cdev_lock that makes cdev_get() safe against U=
AF
> issues in chrdev_open() AFAICS because that blocks cdev_purge() from
> completing when last ref of the kobject is dropped...
>

Oh huh, I somehow missed cdev_purge().

The assumption was if ->i_cdev is legal to store in the first place,
it has to be legally accessible. That goes down the drain with the
above.

I'll cook something up for the next merge window.

Note devices like /dev/null are there for the duration, so the
->i_cdev clearing problem is not important for *that* one. It's a
matter of figuring out how to plug that information through.

>                                                                 Honza
>
> >
> > More cleanups are needed here but this is enough to get the thing out o=
f
> > the way.
> >
> > Rationale is funny-sounding at first: opening of /dev/zero happens to b=
e
> > a contention point in large-scale package building (think 100+ packages
> > at the same with a thread count to support it). Such a workload is not
> > only very fork+exec heavy, but frequently involves scripts which use th=
e
> > idiom of silencing output by redirecting it to /dev/null.
> >
> > A non-large-scale microbenchmark of opening /dev/null in a loop in 16
> > processes:
> > before:       2865472
> > after:        4011960 (+40%)
> >
> > Code goes from being bottlenecked on the spinlock to being bottlenecked
> > on lockref.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > v2:
> > - add back new =3D NULL lost in refactoring
> >
> > I'll note for interested my experience with the workload at hand comes
> > from FreeBSD and was surprised to find /dev/null on the profile. Given
> > that Linux is globally serializing on it, it has to be a factor as well
> > in this case.
> >
> >  fs/char_dev.c        | 20 +++++++++++---------
> >  fs/inode.c           |  2 +-
> >  include/linux/cdev.h |  2 +-
> >  3 files changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/char_dev.c b/fs/char_dev.c
> > index c2ddb998f3c9..9a6dfab084d1 100644
> > --- a/fs/char_dev.c
> > +++ b/fs/char_dev.c
> > @@ -374,15 +374,15 @@ static int chrdev_open(struct inode *inode, struc=
t file *filp)
> >  {
> >       const struct file_operations *fops;
> >       struct cdev *p;
> > -     struct cdev *new =3D NULL;
> >       int ret =3D 0;
> >
> > -     spin_lock(&cdev_lock);
> > -     p =3D inode->i_cdev;
> > +     VFS_BUG_ON_INODE(icount_read(inode) < 1, inode);
> > +
> > +     p =3D READ_ONCE(inode->i_cdev);
> >       if (!p) {
> >               struct kobject *kobj;
> > +             struct cdev *new =3D NULL;
> >               int idx;
> > -             spin_unlock(&cdev_lock);
> >               kobj =3D kobj_lookup(cdev_map, inode->i_rdev, &idx);
> >               if (!kobj)
> >                       return -ENXIO;
> > @@ -392,19 +392,19 @@ static int chrdev_open(struct inode *inode, struc=
t file *filp)
> >                  we dropped the lock. */
> >               p =3D inode->i_cdev;
> >               if (!p) {
> > -                     inode->i_cdev =3D p =3D new;
> > +                     p =3D new;
> > +                     WRITE_ONCE(inode->i_cdev, p);
> >                       list_add(&inode->i_devices, &p->list);
> >                       new =3D NULL;
> >               } else if (!cdev_get(p))
> >                       ret =3D -ENXIO;
> > +             spin_unlock(&cdev_lock);
> > +             cdev_put(new);
> >       } else if (!cdev_get(p))
> >               ret =3D -ENXIO;
> > -     spin_unlock(&cdev_lock);
> > -     cdev_put(new);
> >       if (ret)
> >               return ret;
> >
> > -     ret =3D -ENXIO;
> >       fops =3D fops_get(p->ops);
> >       if (!fops)
> >               goto out_cdev_put;
> > @@ -423,8 +423,10 @@ static int chrdev_open(struct inode *inode, struct=
 file *filp)
> >       return ret;
> >  }
> >
> > -void cd_forget(struct inode *inode)
> > +void inode_cdev_forget(struct inode *inode)
> >  {
> > +     VFS_BUG_ON_INODE(!(inode_state_read_once(inode) & I_FREEING), ino=
de);
> > +
> >       spin_lock(&cdev_lock);
> >       list_del_init(&inode->i_devices);
> >       inode->i_cdev =3D NULL;
> > diff --git a/fs/inode.c b/fs/inode.c
> > index a62032864ddf..88be1f20782d 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -840,7 +840,7 @@ static void evict(struct inode *inode)
> >               clear_inode(inode);
> >       }
> >       if (S_ISCHR(inode->i_mode) && inode->i_cdev)
> > -             cd_forget(inode);
> > +             inode_cdev_forget(inode);
> >
> >       remove_inode_hash(inode);
> >
> > diff --git a/include/linux/cdev.h b/include/linux/cdev.h
> > index 0e8cd6293deb..bed99967ad90 100644
> > --- a/include/linux/cdev.h
> > +++ b/include/linux/cdev.h
> > @@ -34,6 +34,6 @@ void cdev_device_del(struct cdev *cdev, struct device=
 *dev);
> >
> >  void cdev_del(struct cdev *);
> >
> > -void cd_forget(struct inode *);
> > +void inode_cdev_forget(struct inode *);
> >
> >  #endif
> > --
> > 2.48.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

