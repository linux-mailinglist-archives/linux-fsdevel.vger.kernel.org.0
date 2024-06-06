Return-Path: <linux-fsdevel+bounces-21133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEBA8FF4DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 20:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3597C1C25B37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DB24D9E9;
	Thu,  6 Jun 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7O/ZA6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1944C73;
	Thu,  6 Jun 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699573; cv=none; b=paPWE/dlCJzOmkHSxOgWEMJ3kvEY/kx+orBTzejZG3WifMyyl5pyLwY6xxHUwB38AuTAvOFOpT2hBXNkikWomlEw8p+1E/ab/ADExCjXYuyiRjxVugzY87TSnn5+xPvil4AgFws5+5GkfFqAbyA+QoH4NBiGp2XTjIMFsDTba58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699573; c=relaxed/simple;
	bh=KWkApAjfkQMb9tbwDmHBJttC1PLW2IgoH3n2/ahabng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnAlOkqXITkISFuNRTIaDKzGxI0u6NH9mNC0nAbXSZYjaGLPhv1dc3bYWZvhCDO6wc5rfLs0os7Lx6LCGqIIL06r4aVK+6e4LYDnO/JklKq7Q1IgiIeeHZs+XmGjoDdAED74P5WSqaRw8uKlBGwYxOB5kDrkTiWXTzlAvG6PRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7O/ZA6B; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a68e7538cfaso173360366b.0;
        Thu, 06 Jun 2024 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717699570; x=1718304370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZhRGCddhzDppgR2oYpDJaWzjmMIWmcsbVelwBQpSao=;
        b=N7O/ZA6ByEdci43wqmNdfHG5JFsdpRRXU+MEk4yziXpVWo4HdV0D1gZwnnj7s0yO0g
         htAoZPaLy5cRneyZhQBbY2e8yFy/IZ4LcdGhzVQGeHkrY29NUD4r1KMe6HkELmDbdHMl
         m5Ws68Mok0EHRAS0Ny3xFb52ja6iL6jrSfHxUDThO2nw7Hl/w12VUt8YwFDv8eq9evd8
         CMCVQ3JT2sYsclqHRl+g/hEZEqwbMHvnOiANEB00vH+t/vbpXghZYUcBltHl9Lkln3RS
         fSLkQeOZiCNdZIOpRJuII6gmTITsC21bIWJZDRy76b0UvWVxOh+yRGI22TCyuSWgeC9l
         VaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717699570; x=1718304370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZhRGCddhzDppgR2oYpDJaWzjmMIWmcsbVelwBQpSao=;
        b=w4dCZh+1TvW92f+OFM1hiH/4P7qUCdfXAY0AgVRxp0szd+hALXnkq+urLZxZ3CTPso
         fBiHqafLxjXD345oK/pfN88cIlOmD/G5z8Bogv72P0KmNFCjbLeZyUYb6wV6fjRUVpjD
         eL9B13Kcv4SjrmP29Vu8a0uL0yf8jDCHbboIWy08OaD44WhCtMh/1lEH1cGnvPC5lHAj
         SAz71WxVjevYUnhvg8M3A5bMtZdErokOjoRR288UtmzqCdVj0wq6/nmgzIQ7ZL6XgnCY
         roDI9Vdab8bosMN6xiIrusuFlwuORgJwW1tLVOalLMuR6iwGPqI/bi59sfCmQ79GYsuK
         b2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXYN9ggx29IvIMpPuyrUi7T1ZnIYfhYMEk0p3XDttgVDKx75JIsBlGCCGXJDUw5JxLec7tzdRCXaclrFWP+oSWTXx9ltMdComEAeHLKAa7imRiCVruukl9DM4kmAz+vna0zkB/Huym+X1gFMQ==
X-Gm-Message-State: AOJu0Yx1g09FJ5X0hBlOmPTaXH0ddcQTWaU9at9u3NRZ76t5tSajj5IB
	pwHFfBhNf7frIWIJNLmaPE7AOaEGV4y4Kn+C7KwjtoJa96YQB0eGaO5cb0HLd9sDajHj9QIVW02
	TTbxwkSjNjSr58awNzD+cO1Aj+Nc=
X-Google-Smtp-Source: AGHT+IE6ArkX0xYdgFlf5pp7VO3nd9wgFHmNApbiJwgBXe6BuVzc/wdqWHxWNWaj0P0jziL+FCArHEmB1DGUF961tH8=
X-Received: by 2002:a17:906:b74c:b0:a67:e4e3:99d with SMTP id
 a640c23a62f3a-a6cdb1ee33amr26321866b.59.1717699569867; Thu, 06 Jun 2024
 11:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606140515.216424-1-mjguzik@gmail.com> <20240606163116.fnblztdlbp7sqjt6@quack3>
In-Reply-To: <20240606163116.fnblztdlbp7sqjt6@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Jun 2024 20:45:57 +0200
Message-ID: <CAGudoHGmq2spTXMV+02xqrcpcQYqwJ-hEAoD7WojhY-LV_JY4Q@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: add rcu-based find_inode variants for iget ops
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 6:31=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 06-06-24 16:05:15, Mateusz Guzik wrote:
> > Instantiating a new inode normally takes the global inode hash lock
> > twice:
> > 1. once to check if it happens to already be present
> > 2. once to add it to the hash
> >
> > The back-to-back lock/unlock pattern is known to degrade performance
> > significantly, which is further exacerbated if the hash is heavily
> > populated (long chains to walk, extending hold time). Arguably hash
> > sizing and hashing algo need to be revisited, but that's beyond the
> > scope of this patch.
> >
> > A long term fix would introduce fine-grained locking, this was attempte=
d
> > in [1], but that patchset was already posted several times and appears
> > stalled.
> >
> > A simpler idea which solves majority of the problem and which may be
> > good enough for the time being is to use RCU for the initial lookup.
> > Basic RCU support is already present in the hash, it is just not being
> > used for lookup on inode creation.
> >
> > iget_locked consumers (notably ext4) get away without any changes
> > because inode comparison method is built-in.
> >
> > iget5_locked and ilookup5_nowait consumers pass a custom callback. Sinc=
e
> > removal of locking adds more problems (inode can be changing) it's not
> > safe to assume all filesystems happen to cope.  Thus iget5_locked_rcu
> > ilookup5_nowait_rcu get added, requiring manual conversion.
>
> BTW, why not ilookup5_rcu() as well? To keep symmetry with non-RCU APIs a=
nd
> iget5_locked_rcu() could then use ilookup5_rcu().

I don't have a strong opinion. Note that the routine as implemented
right now mimicks iget_locked.

> I presume eventually we'd like to trasition everything to these RCU based=
 methods?
>

That is up in the air, but I would not go for it. Note every
iget5_locked consumer would have to get reviewed for safety of the
callback, which is a lot of work for no real gain for vast majority of
filesystems out there.

Also note the rcu variants are only used in cases which tolerate a
false negative -- if the inode fails to match, the caller is expected
to cope by creating a new inode and performing a locked lookup. It
does not have to be this way, but I find it less error prone.

> > In order to reduce code duplication find_inode and find_inode_fast grow
> > an argument indicating whether inode hash lock is held, which is passed
> > down should sleeping be necessary. They always rcu_read_lock, which is
> > redundant but harmless. Doing it conditionally reduces readability for
> > no real gain that I can see. RCU-alike restrictions were already put on
> > callbacks due to the hash spinlock being held.
> >
> > Benchmarked with the following: a 32-core vm with 24GB of RAM, a
> > dedicated fs partition. 20 separate trees with 1000 directories * 1000
> > files.  Then walked by 20 processes issuing stat on files, each on a
> > dedicated tree. Testcase is at [2].
> >
> > In this particular workload, mimicking a real-world setup $elsewhere,
> > the initial lookup is guaranteed to fail, guaranteeing the 2 lock
> > acquires. At the same time RAM is scarce enough enough compared to the
> > demand that inodes keep needing to be recycled.
> >
> > Total real time fluctuates by 1-2s, sample results:
> >
> > ext4 (needed mkfs.ext4 -N 24000000):
> > before:       3.77s user 890.90s system 1939% cpu 46.118 total
> > after:  3.24s user 397.73s system 1858% cpu 21.581 total (-53%)
> >
> > btrfs (s/iget5_locked/iget5_locked_rcu in fs/btrfs/inode.c):
> > before: 3.54s user 892.30s system 1966% cpu 45.549 total
> > after:  3.28s user 738.66s system 1955% cpu 37.932 total (-16.7%)
> >
> > btrfs is heavily bottlenecked on its own locks, so the improvement is
> > small in comparison.
> >
> > [1] https://lore.kernel.org/all/20231206060629.2827226-1-david@fromorbi=
t.com/
> > [2] https://people.freebsd.org/~mjg/fstree.tgz
>
> Nice results. I've looked through the patch and otherwise I didn't find a=
ny
> issue.
>
>                                                                 Honza
>
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > This is an initial submission to gauge interest.
> >
> > I do claim this provides great bang for the buck, I don't claim it
> > solves the problem overall. *something* finer-grained will need to
> > land.
> >
> > I wanted to add bcachefs to the list, but I ran into memory reclamation
> > issues again (first time here:
> > https://lore.kernel.org/all/CAGudoHGenxzk0ZqPXXi1_QDbfqQhGHu+wUwzyS6Wmf=
kUZ1HiXA@mail.gmail.com/),
> > did not have time to mess with diagnostic to write a report yet.
> >
> > I'll post a patchset with this (+ tidy ups to comments and whatnot) +
> > btrfs + bcachefs conversion after the above gets reported and sorted
> > out.
> >
> > Also interestingly things improved since last year, when Linux needed
> > about a minute.
> >
> >  fs/inode.c         | 106 +++++++++++++++++++++++++++++++++++++--------
> >  include/linux/fs.h |  10 ++++-
> >  2 files changed, 98 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 3a41f83a4ba5..f40b868f491f 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -886,36 +886,43 @@ long prune_icache_sb(struct super_block *sb, stru=
ct shrink_control *sc)
> >       return freed;
> >  }
> >
> > -static void __wait_on_freeing_inode(struct inode *inode);
> > +static void __wait_on_freeing_inode(struct inode *inode, bool locked);
> >  /*
> >   * Called with the inode lock held.
> >   */
> >  static struct inode *find_inode(struct super_block *sb,
> >                               struct hlist_head *head,
> >                               int (*test)(struct inode *, void *),
> > -                             void *data)
> > +                             void *data, bool locked)
> >  {
> >       struct inode *inode =3D NULL;
> >
> > +     if (locked)
> > +             lockdep_assert_held(&inode_hash_lock);
> > +
> > +     rcu_read_lock();
> >  repeat:
> > -     hlist_for_each_entry(inode, head, i_hash) {
> > +     hlist_for_each_entry_rcu(inode, head, i_hash) {
> >               if (inode->i_sb !=3D sb)
> >                       continue;
> >               if (!test(inode, data))
> >                       continue;
> >               spin_lock(&inode->i_lock);
> >               if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
> > -                     __wait_on_freeing_inode(inode);
> > +                     __wait_on_freeing_inode(inode, locked);
> >                       goto repeat;
> >               }
> >               if (unlikely(inode->i_state & I_CREATING)) {
> >                       spin_unlock(&inode->i_lock);
> > +                     rcu_read_unlock();
> >                       return ERR_PTR(-ESTALE);
> >               }
> >               __iget(inode);
> >               spin_unlock(&inode->i_lock);
> > +             rcu_read_unlock();
> >               return inode;
> >       }
> > +     rcu_read_unlock();
> >       return NULL;
> >  }
> >
> > @@ -924,29 +931,37 @@ static struct inode *find_inode(struct super_bloc=
k *sb,
> >   * iget_locked for details.
> >   */
> >  static struct inode *find_inode_fast(struct super_block *sb,
> > -                             struct hlist_head *head, unsigned long in=
o)
> > +                             struct hlist_head *head, unsigned long in=
o,
> > +                             bool locked)
> >  {
> >       struct inode *inode =3D NULL;
> >
> > +     if (locked)
> > +             lockdep_assert_held(&inode_hash_lock);
> > +
> > +     rcu_read_lock();
> >  repeat:
> > -     hlist_for_each_entry(inode, head, i_hash) {
> > +     hlist_for_each_entry_rcu(inode, head, i_hash) {
> >               if (inode->i_ino !=3D ino)
> >                       continue;
> >               if (inode->i_sb !=3D sb)
> >                       continue;
> >               spin_lock(&inode->i_lock);
> >               if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
> > -                     __wait_on_freeing_inode(inode);
> > +                     __wait_on_freeing_inode(inode, locked);
> >                       goto repeat;
> >               }
> >               if (unlikely(inode->i_state & I_CREATING)) {
> >                       spin_unlock(&inode->i_lock);
> > +                     rcu_read_unlock();
> >                       return ERR_PTR(-ESTALE);
> >               }
> >               __iget(inode);
> >               spin_unlock(&inode->i_lock);
> > +             rcu_read_unlock();
> >               return inode;
> >       }
> > +     rcu_read_unlock();
> >       return NULL;
> >  }
> >
> > @@ -1161,7 +1176,7 @@ struct inode *inode_insert5(struct inode *inode, =
unsigned long hashval,
> >
> >  again:
> >       spin_lock(&inode_hash_lock);
> > -     old =3D find_inode(inode->i_sb, head, test, data);
> > +     old =3D find_inode(inode->i_sb, head, test, data, true);
> >       if (unlikely(old)) {
> >               /*
> >                * Uhhuh, somebody else created the same inode under us.
> > @@ -1245,6 +1260,43 @@ struct inode *iget5_locked(struct super_block *s=
b, unsigned long hashval,
> >  }
> >  EXPORT_SYMBOL(iget5_locked);
> >
> > +/**
> > + * iget5_locked_rcu - obtain an inode from a mounted file system
> > + *
> > + * This is equivalent to iget5_locked, except the @test callback must
> > + * tolerate inode not being stable, including being mid-teardown.
> > + */
> > +struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long h=
ashval,
> > +             int (*test)(struct inode *, void *),
> > +             int (*set)(struct inode *, void *), void *data)
> > +{
> > +     struct hlist_head *head =3D inode_hashtable + hash(sb, hashval);
> > +     struct inode *inode, *new;
> > +
> > +again:
> > +     inode =3D find_inode(sb, head, test, data, false);
> > +     if (inode) {
> > +             if (IS_ERR(inode))
> > +                     return NULL;
> > +             wait_on_inode(inode);
> > +             if (unlikely(inode_unhashed(inode))) {
> > +                     iput(inode);
> > +                     goto again;
> > +             }
> > +             return inode;
> > +     }
> > +
> > +     new =3D alloc_inode(sb);
> > +     if (new) {
> > +             new->i_state =3D 0;
> > +             inode =3D inode_insert5(new, hashval, test, set, data);
> > +             if (unlikely(inode !=3D new))
> > +                     destroy_inode(new);
> > +     }
> > +     return inode;
> > +}
> > +EXPORT_SYMBOL(iget5_locked_rcu);
> > +
> >  /**
> >   * iget_locked - obtain an inode from a mounted file system
> >   * @sb:              super block of file system
> > @@ -1263,9 +1315,7 @@ struct inode *iget_locked(struct super_block *sb,=
 unsigned long ino)
> >       struct hlist_head *head =3D inode_hashtable + hash(sb, ino);
> >       struct inode *inode;
> >  again:
> > -     spin_lock(&inode_hash_lock);
> > -     inode =3D find_inode_fast(sb, head, ino);
> > -     spin_unlock(&inode_hash_lock);
> > +     inode =3D find_inode_fast(sb, head, ino, false);
> >       if (inode) {
> >               if (IS_ERR(inode))
> >                       return NULL;
> > @@ -1283,7 +1333,7 @@ struct inode *iget_locked(struct super_block *sb,=
 unsigned long ino)
> >
> >               spin_lock(&inode_hash_lock);
> >               /* We released the lock, so.. */
> > -             old =3D find_inode_fast(sb, head, ino);
> > +             old =3D find_inode_fast(sb, head, ino, true);
> >               if (!old) {
> >                       inode->i_ino =3D ino;
> >                       spin_lock(&inode->i_lock);
> > @@ -1419,13 +1469,31 @@ struct inode *ilookup5_nowait(struct super_bloc=
k *sb, unsigned long hashval,
> >       struct inode *inode;
> >
> >       spin_lock(&inode_hash_lock);
> > -     inode =3D find_inode(sb, head, test, data);
> > +     inode =3D find_inode(sb, head, test, data, true);
> >       spin_unlock(&inode_hash_lock);
> >
> >       return IS_ERR(inode) ? NULL : inode;
> >  }
> >  EXPORT_SYMBOL(ilookup5_nowait);
> >
> > +/**
> > + * ilookup5_nowait_rcu - search for an inode in the inode cache
> > + *
> > + * This is equivalent to ilookup5_nowait, except the @test callback mu=
st
> > + * tolerate inode not being stable, including being mid-teardown.
> > + */
> > +struct inode *ilookup5_nowait_rcu(struct super_block *sb, unsigned lon=
g hashval,
> > +             int (*test)(struct inode *, void *), void *data)
> > +{
> > +     struct hlist_head *head =3D inode_hashtable + hash(sb, hashval);
> > +     struct inode *inode;
> > +
> > +     inode =3D find_inode(sb, head, test, data, false);
> > +
> > +     return IS_ERR(inode) ? NULL : inode;
> > +}
> > +EXPORT_SYMBOL(ilookup5_nowait_rcu);
> > +
> >  /**
> >   * ilookup5 - search for an inode in the inode cache
> >   * @sb:              super block of file system to search
> > @@ -1474,7 +1542,7 @@ struct inode *ilookup(struct super_block *sb, uns=
igned long ino)
> >       struct inode *inode;
> >  again:
> >       spin_lock(&inode_hash_lock);
> > -     inode =3D find_inode_fast(sb, head, ino);
> > +     inode =3D find_inode_fast(sb, head, ino, true);
> >       spin_unlock(&inode_hash_lock);
> >
> >       if (inode) {
> > @@ -2235,17 +2303,21 @@ EXPORT_SYMBOL(inode_needs_sync);
> >   * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash =
list
> >   * will DTRT.
> >   */
> > -static void __wait_on_freeing_inode(struct inode *inode)
> > +static void __wait_on_freeing_inode(struct inode *inode, bool locked)
> >  {
> >       wait_queue_head_t *wq;
> >       DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
> >       wq =3D bit_waitqueue(&inode->i_state, __I_NEW);
> >       prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> >       spin_unlock(&inode->i_lock);
> > -     spin_unlock(&inode_hash_lock);
> > +     rcu_read_unlock();
> > +     if (locked)
> > +             spin_unlock(&inode_hash_lock);
> >       schedule();
> >       finish_wait(wq, &wait.wq_entry);
> > -     spin_lock(&inode_hash_lock);
> > +     if (locked)
> > +             spin_lock(&inode_hash_lock);
> > +     rcu_read_lock();
> >  }
> >
> >  static __initdata unsigned long ihash_entries;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 0283cf366c2a..2817c915d355 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3021,6 +3021,9 @@ extern void d_mark_dontcache(struct inode *inode)=
;
> >  extern struct inode *ilookup5_nowait(struct super_block *sb,
> >               unsigned long hashval, int (*test)(struct inode *, void *=
),
> >               void *data);
> > +extern struct inode *ilookup5_nowait_rcu(struct super_block *sb,
> > +             unsigned long hashval, int (*test)(struct inode *, void *=
),
> > +             void *data);
> >  extern struct inode *ilookup5(struct super_block *sb, unsigned long ha=
shval,
> >               int (*test)(struct inode *, void *), void *data);
> >  extern struct inode *ilookup(struct super_block *sb, unsigned long ino=
);
> > @@ -3029,7 +3032,12 @@ extern struct inode *inode_insert5(struct inode =
*inode, unsigned long hashval,
> >               int (*test)(struct inode *, void *),
> >               int (*set)(struct inode *, void *),
> >               void *data);
> > -extern struct inode * iget5_locked(struct super_block *, unsigned long=
, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), =
void *);
> > +extern struct inode * iget5_locked(struct super_block *, unsigned long=
,
> > +                                int (*test)(struct inode *, void *),
> > +                                int (*set)(struct inode *, void *), vo=
id *);
> > +extern struct inode * iget5_locked_rcu(struct super_block *, unsigned =
long,
> > +                                    int (*test)(struct inode *, void *=
),
> > +                                    int (*set)(struct inode *, void *)=
, void *);
> >  extern struct inode * iget_locked(struct super_block *, unsigned long)=
;
> >  extern struct inode *find_inode_nowait(struct super_block *,
> >                                      unsigned long,
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



--=20
Mateusz Guzik <mjguzik gmail.com>

