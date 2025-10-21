Return-Path: <linux-fsdevel+bounces-64920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0910ABF6907
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26F904E2FDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38270332ED9;
	Tue, 21 Oct 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgIgnLQr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9632F2619
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051272; cv=none; b=sftXK7ppKFcunVEAeaeTEE7XJHsTmRbSDWYkz2uoWmynjx8xT3fRxk4RJKi4F+wkzchP5MN6Nv7zBODAyKnx6vmA12xRDCu7dyLE46Nd5+Tn0safZHzNI/4Xy/iyphOJtNzDmQelZD97/ael2FATsKXxH+YA5TPDK3s7Xb2yvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051272; c=relaxed/simple;
	bh=ATb3eV5Kue8rnagAw6IOTOZLA44gRrTvJsbpz+yFYjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNkvwWSpHPL7mo3mPYp2zt67nWN0aqAYPhBhwnS/gsfhM9kLUPwgxOc3silSnJNYlnxFTU0XeBWbayLL6BOIOh8j0teOgBpWNDFjyWmOB3r37XVT8GFbWIXVqfpAKMTqKklZtF1RQJnjRvnJznADX1dfvHbrHdiZPBHyNZjgHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgIgnLQr; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c1413dbeeso8741762a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 05:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761051269; x=1761656069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4KLn4j4uSWwP76uZWLWbQh+qtXa5bOLmesB5JSA2wg=;
        b=UgIgnLQrdJtNBDH3eakYUkKr/jkk2sfuCm9rB7TH1NVb2Yzi/2JwM8xix0AiWCbPjc
         9lRHoBbP9UqZR7GG/ptFZUL5bGkYd+MlXRwv5VuF+giltJj1YhSkSj45XMOz0Go52vXT
         sBRyr3O//gm88lmvhJG3MkbKt7aMNJMVtndDigribxnSWZdZjSKP55mpilf8AnRSCHR2
         MeY9w5o4qXGzTySZbnJwlbUj1xNNRtH9ZIivY40wD4FKPq06AaapzXDm5wrnzJK5Mne6
         RIVs1QnBBHgRDrqIaB2mEBNy6jaX0yXfTvXym+PxRt8sNQClPyHbw9iYjn2x6PNoJrdI
         d6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051269; x=1761656069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4KLn4j4uSWwP76uZWLWbQh+qtXa5bOLmesB5JSA2wg=;
        b=OCEHFzuStGRqmcfxt33XfCmrtCxRZu37hjyLT7iNvfmy1LtN6ZbZGUSqQ1GdvFr1/5
         6MKkpgHPbN3dFC3i2MnwSd1pc4T3+YZzyECPa4S8WeaXBFTsv08HSNeasKCkuj6/Dkse
         J8B5VpzB6DKgpj/39p3zkDI75tupEa8G9GQMmfK8MPDf55NzmmHhvEobHLmvCI7ubwUw
         9TXOfNQ1/fFhnqn9QY0zHJ/4yoi0VZW327eFs60wT/CU7TYbMZB9CrPJ0291CqPHnwZa
         YZWQaP8Qi4h5kQnWnm9gUO82B6gvKE79R63m+EOFEzORNptMJDTlZl6r6Y/J2qEolXc4
         poVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY4G8vP9KyImKaqUWZvvTC1LXjCs4kzqGMvVG9/SBOgFcP4tbFnX9R8qT99M4o7u1bmJr+RratSxyoS0O7@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtOSuizmlsoPlS8Epr0Z4lv6SOoandHqup/+s7Yacrq/0U82F
	YOPBl+Fo6xfcppriP9G+vWMBeBQfhBQR5XIZLWonhiVHt0HfDdaytwH3uBvgnhphfgRvLPrH+DB
	wvdG9Mdy3JlAj1ROa9BfJcH4Q5veAmUD+Xw==
X-Gm-Gg: ASbGncvWscNry0tMEmSuPkl+g7jLfmqTUFjl3az94yl3rIJMaDMutHpsTxvv6DaRVVN
	HN5CltgkvLI1/lxU4HHUJZl2GlCgUQvW3tsXxdimrvQ28krYn9y5t73OQJ/iPNkr27N4o/JXCwc
	GzOMvLMLZuixVpH7my7/HBJEGCUAt0qBFQ0rHN5YVsxJAWilNcf5WJE9sOV2Owodc1RntJOToo1
	ZgkqGkWaxbWh5/AejWEsMG7DwsHsQ2AAZv7RtvEt1rJYx5r+Bcd78/Lfzsjdw6Ox3fUELYyX9AI
	Qfo37geABgHoX5akWdasbia1Cmk=
X-Google-Smtp-Source: AGHT+IED7tAGjnduN198AwckFQLH1TE4qtQMzh2mLOChFXWI85CF3aGpNl0dck70GmcQtLgOfHIBbB1CojqSexyADGY=
X-Received: by 2002:a05:6402:848:b0:63c:eb6:65e8 with SMTP id
 4fb4d7f45d1cf-63c1f6c3da5mr15707540a12.30.1761051268473; Tue, 21 Oct 2025
 05:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010221737.1403539-1-mjguzik@gmail.com> <CAGudoHETiJ8G8WeyFYJ6EZ4oxcmqxV3yztZDOxL8PUBGobW_xQ@mail.gmail.com>
 <20251021-beinhalten-passierbar-62c358c24613@brauner>
In-Reply-To: <20251021-beinhalten-passierbar-62c358c24613@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 21 Oct 2025 14:54:16 +0200
X-Gm-Features: AS18NWD0t8onXKG6p7Wj_wgz3pY2qswkD_mnaE3qOy8l3nSE_X4HP51jZTkCqKE
Message-ID: <CAGudoHHqzayp2yY4dtqVSQj30iONngSCpy34_f-4ZkMyj8mh5Q@mail.gmail.com>
Subject: Re: [PATCH] fs: rework I_NEW handling to operate without fences
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:48=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Oct 15, 2025 at 01:50:25PM +0200, Mateusz Guzik wrote:
> > can i get some flames on this?
>
> Ok, that looks fine to me. I don't particularly enjoy that boolean but I
> think it simplifies d_instantiate_new() enough to make up for it.
>

yes, going to sleep (or not) is lock-protected, obsoleting the need
for custom fences.

this is an incremental cleanup. I have more in the pipeline which
should dedup most of the current handling, but there is quite a bit to
clean up first and I'm have not decided to which way I'll try go
first.

> >
> > On Sat, Oct 11, 2025 at 12:17=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.c=
om> wrote:
> > >
> > > In the inode hash code grab the state while ->i_lock is held. If foun=
d
> > > to be set, synchronize the sleep once more with the lock held.
> > >
> > > In the real world the flag is not set most of the time.
> > >
> > > Apart from being simpler to reason about, it comes with a minor speed=
 up
> > > as now clearing the flag does not require the smp_mb() fence.
> > >
> > > While here rename wait_on_inode() to wait_on_new_inode() to line it u=
p
> > > with __wait_on_freeing_inode().
> > >
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > ---
> > >
> > > This temporarily duplicated sleep code from inode_wait_for_lru_isolat=
ing().
> > > This is going to get dedupped later.
> > >
> > > There is high repetition of:
> > >         if (unlikely(isnew)) {
> > >                 wait_on_new_inode(old);
> > >                 if (unlikely(inode_unhashed(old))) {
> > >                         iput(old);
> > >                         goto again;
> > >                 }
> > >
> > > I expect this is going to go away after I post a patch to sanitize th=
e
> > > current APIs for the hash.
> > >
> > >
> > >  fs/afs/dir.c       |   4 +-
> > >  fs/dcache.c        |  10 ----
> > >  fs/gfs2/glock.c    |   2 +-
> > >  fs/inode.c         | 146 +++++++++++++++++++++++++++----------------=
--
> > >  include/linux/fs.h |  12 +---
> > >  5 files changed, 93 insertions(+), 81 deletions(-)
> > >
> > > diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> > > index 89d36e3e5c79..f4e9e12373ac 100644
> > > --- a/fs/afs/dir.c
> > > +++ b/fs/afs/dir.c
> > > @@ -779,7 +779,7 @@ static struct inode *afs_do_lookup(struct inode *=
dir, struct dentry *dentry)
> > >         struct afs_vnode *dvnode =3D AFS_FS_I(dir), *vnode;
> > >         struct inode *inode =3D NULL, *ti;
> > >         afs_dataversion_t data_version =3D READ_ONCE(dvnode->status.d=
ata_version);
> > > -       bool supports_ibulk;
> > > +       bool supports_ibulk, isnew;
> > >         long ret;
> > >         int i;
> > >
> > > @@ -850,7 +850,7 @@ static struct inode *afs_do_lookup(struct inode *=
dir, struct dentry *dentry)
> > >                          * callback counters.
> > >                          */
> > >                         ti =3D ilookup5_nowait(dir->i_sb, vp->fid.vno=
de,
> > > -                                            afs_ilookup5_test_by_fid=
, &vp->fid);
> > > +                                            afs_ilookup5_test_by_fid=
, &vp->fid, &isnew);
> > >                         if (!IS_ERR_OR_NULL(ti)) {
> > >                                 vnode =3D AFS_FS_I(ti);
> > >                                 vp->dv_before =3D vnode->status.data_=
version;
> > > diff --git a/fs/dcache.c b/fs/dcache.c
> > > index 78ffa7b7e824..25131f105a60 100644
> > > --- a/fs/dcache.c
> > > +++ b/fs/dcache.c
> > > @@ -1981,17 +1981,7 @@ void d_instantiate_new(struct dentry *entry, s=
truct inode *inode)
> > >         spin_lock(&inode->i_lock);
> > >         __d_instantiate(entry, inode);
> > >         WARN_ON(!(inode_state_read(inode) & I_NEW));
> > > -       /*
> > > -        * Pairs with smp_rmb in wait_on_inode().
> > > -        */
> > > -       smp_wmb();
> > >         inode_state_clear(inode, I_NEW | I_CREATING);
> > > -       /*
> > > -        * Pairs with the barrier in prepare_to_wait_event() to make =
sure
> > > -        * ___wait_var_event() either sees the bit cleared or
> > > -        * waitqueue_active() check in wake_up_var() sees the waiter.
> > > -        */
> > > -       smp_mb();
> > >         inode_wake_up_bit(inode, __I_NEW);
> > >         spin_unlock(&inode->i_lock);
> > >  }
> > > diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> > > index b677c0e6b9ab..c9712235e7a0 100644
> > > --- a/fs/gfs2/glock.c
> > > +++ b/fs/gfs2/glock.c
> > > @@ -957,7 +957,7 @@ static struct gfs2_inode *gfs2_grab_existing_inod=
e(struct gfs2_glock *gl)
> > >                 ip =3D NULL;
> > >         spin_unlock(&gl->gl_lockref.lock);
> > >         if (ip) {
> > > -               wait_on_inode(&ip->i_inode);
> > > +               wait_on_new_inode(&ip->i_inode);
> > >                 if (is_bad_inode(&ip->i_inode)) {
> > >                         iput(&ip->i_inode);
> > >                         ip =3D NULL;
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index 3153d725859c..1396f79b2551 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -558,6 +558,32 @@ struct wait_queue_head *inode_bit_waitqueue(stru=
ct wait_bit_queue_entry *wqe,
> > >  }
> > >  EXPORT_SYMBOL(inode_bit_waitqueue);
> > >
> > > +void wait_on_new_inode(struct inode *inode)
> > > +{
> > > +       struct wait_bit_queue_entry wqe;
> > > +       struct wait_queue_head *wq_head;
> > > +
> > > +       spin_lock(&inode->i_lock);
> > > +       if (!(inode_state_read(inode) & I_NEW)) {
> > > +               spin_unlock(&inode->i_lock);
> > > +               return;
> > > +       }
> > > +
> > > +       wq_head =3D inode_bit_waitqueue(&wqe, inode, __I_NEW);
> > > +       for (;;) {
> > > +               prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UN=
INTERRUPTIBLE);
> > > +               if (!(inode_state_read(inode) & I_NEW))
> > > +                       break;
> > > +               spin_unlock(&inode->i_lock);
> > > +               schedule();
> > > +               spin_lock(&inode->i_lock);
> > > +       }
> > > +       finish_wait(wq_head, &wqe.wq_entry);
> > > +       WARN_ON(inode_state_read(inode) & I_NEW);
> > > +       spin_unlock(&inode->i_lock);
> > > +}
> > > +EXPORT_SYMBOL(wait_on_new_inode);
> > > +
> > >  /*
> > >   * Add inode to LRU if needed (inode is unused and clean).
> > >   *
> > > @@ -1008,7 +1034,8 @@ static void __wait_on_freeing_inode(struct inod=
e *inode, bool is_inode_hash_lock
> > >  static struct inode *find_inode(struct super_block *sb,
> > >                                 struct hlist_head *head,
> > >                                 int (*test)(struct inode *, void *),
> > > -                               void *data, bool is_inode_hash_locked=
)
> > > +                               void *data, bool is_inode_hash_locked=
,
> > > +                               bool *isnew)
> > >  {
> > >         struct inode *inode =3D NULL;
> > >
> > > @@ -1035,6 +1062,7 @@ static struct inode *find_inode(struct super_bl=
ock *sb,
> > >                         return ERR_PTR(-ESTALE);
> > >                 }
> > >                 __iget(inode);
> > > +               *isnew =3D !!(inode_state_read(inode) & I_NEW);
> > >                 spin_unlock(&inode->i_lock);
> > >                 rcu_read_unlock();
> > >                 return inode;
> > > @@ -1049,7 +1077,7 @@ static struct inode *find_inode(struct super_bl=
ock *sb,
> > >   */
> > >  static struct inode *find_inode_fast(struct super_block *sb,
> > >                                 struct hlist_head *head, unsigned lon=
g ino,
> > > -                               bool is_inode_hash_locked)
> > > +                               bool is_inode_hash_locked, bool *isne=
w)
> > >  {
> > >         struct inode *inode =3D NULL;
> > >
> > > @@ -1076,6 +1104,7 @@ static struct inode *find_inode_fast(struct sup=
er_block *sb,
> > >                         return ERR_PTR(-ESTALE);
> > >                 }
> > >                 __iget(inode);
> > > +               *isnew =3D !!(inode_state_read(inode) & I_NEW);
> > >                 spin_unlock(&inode->i_lock);
> > >                 rcu_read_unlock();
> > >                 return inode;
> > > @@ -1181,17 +1210,7 @@ void unlock_new_inode(struct inode *inode)
> > >         lockdep_annotate_inode_mutex_key(inode);
> > >         spin_lock(&inode->i_lock);
> > >         WARN_ON(!(inode_state_read(inode) & I_NEW));
> > > -       /*
> > > -        * Pairs with smp_rmb in wait_on_inode().
> > > -        */
> > > -       smp_wmb();
> > >         inode_state_clear(inode, I_NEW | I_CREATING);
> > > -       /*
> > > -        * Pairs with the barrier in prepare_to_wait_event() to make =
sure
> > > -        * ___wait_var_event() either sees the bit cleared or
> > > -        * waitqueue_active() check in wake_up_var() sees the waiter.
> > > -        */
> > > -       smp_mb();
>
> You're getting rid of smp_mb() because you're rechecking the flag under
> i_lock after you called prepare_to_wait_event() in wait_on_new_inode()?
>
> > >         inode_wake_up_bit(inode, __I_NEW);
> > >         spin_unlock(&inode->i_lock);
> > >  }
> > > @@ -1202,17 +1221,7 @@ void discard_new_inode(struct inode *inode)
> > >         lockdep_annotate_inode_mutex_key(inode);
> > >         spin_lock(&inode->i_lock);
> > >         WARN_ON(!(inode_state_read(inode) & I_NEW));
> > > -       /*
> > > -        * Pairs with smp_rmb in wait_on_inode().
> > > -        */
> > > -       smp_wmb();
> > >         inode_state_clear(inode, I_NEW);
> > > -       /*
> > > -        * Pairs with the barrier in prepare_to_wait_event() to make =
sure
> > > -        * ___wait_var_event() either sees the bit cleared or
> > > -        * waitqueue_active() check in wake_up_var() sees the waiter.
> > > -        */
> > > -       smp_mb();
> > >         inode_wake_up_bit(inode, __I_NEW);
> > >         spin_unlock(&inode->i_lock);
> > >         iput(inode);
> > > @@ -1286,12 +1295,13 @@ struct inode *inode_insert5(struct inode *ino=
de, unsigned long hashval,
> > >  {
> > >         struct hlist_head *head =3D inode_hashtable + hash(inode->i_s=
b, hashval);
> > >         struct inode *old;
> > > +       bool isnew;
> > >
> > >         might_sleep();
> > >
> > >  again:
> > >         spin_lock(&inode_hash_lock);
> > > -       old =3D find_inode(inode->i_sb, head, test, data, true);
> > > +       old =3D find_inode(inode->i_sb, head, test, data, true, &isne=
w);
> > >         if (unlikely(old)) {
> > >                 /*
> > >                  * Uhhuh, somebody else created the same inode under =
us.
> > > @@ -1300,10 +1310,12 @@ struct inode *inode_insert5(struct inode *ino=
de, unsigned long hashval,
> > >                 spin_unlock(&inode_hash_lock);
> > >                 if (IS_ERR(old))
> > >                         return NULL;
> > > -               wait_on_inode(old);
> > > -               if (unlikely(inode_unhashed(old))) {
> > > -                       iput(old);
> > > -                       goto again;
> > > +               if (unlikely(isnew)) {
> > > +                       wait_on_new_inode(old);
> > > +                       if (unlikely(inode_unhashed(old))) {
> > > +                               iput(old);
> > > +                               goto again;
> > > +                       }
> > >                 }
> > >                 return old;
> > >         }
> > > @@ -1391,18 +1403,21 @@ struct inode *iget5_locked_rcu(struct super_b=
lock *sb, unsigned long hashval,
> > >  {
> > >         struct hlist_head *head =3D inode_hashtable + hash(sb, hashva=
l);
> > >         struct inode *inode, *new;
> > > +       bool isnew;
> > >
> > >         might_sleep();
> > >
> > >  again:
> > > -       inode =3D find_inode(sb, head, test, data, false);
> > > +       inode =3D find_inode(sb, head, test, data, false, &isnew);
> > >         if (inode) {
> > >                 if (IS_ERR(inode))
> > >                         return NULL;
> > > -               wait_on_inode(inode);
> > > -               if (unlikely(inode_unhashed(inode))) {
> > > -                       iput(inode);
> > > -                       goto again;
> > > +               if (unlikely(isnew)) {
> > > +                       wait_on_new_inode(inode);
> > > +                       if (unlikely(inode_unhashed(inode))) {
> > > +                               iput(inode);
> > > +                               goto again;
> > > +                       }
> > >                 }
> > >                 return inode;
> > >         }
> > > @@ -1434,18 +1449,21 @@ struct inode *iget_locked(struct super_block =
*sb, unsigned long ino)
> > >  {
> > >         struct hlist_head *head =3D inode_hashtable + hash(sb, ino);
> > >         struct inode *inode;
> > > +       bool isnew;
> > >
> > >         might_sleep();
> > >
> > >  again:
> > > -       inode =3D find_inode_fast(sb, head, ino, false);
> > > +       inode =3D find_inode_fast(sb, head, ino, false, &isnew);
> > >         if (inode) {
> > >                 if (IS_ERR(inode))
> > >                         return NULL;
> > > -               wait_on_inode(inode);
> > > -               if (unlikely(inode_unhashed(inode))) {
> > > -                       iput(inode);
> > > -                       goto again;
> > > +               if (unlikely(isnew)) {
> > > +                       wait_on_new_inode(inode);
> > > +                       if (unlikely(inode_unhashed(inode))) {
> > > +                               iput(inode);
> > > +                               goto again;
> > > +                       }
> > >                 }
> > >                 return inode;
> > >         }
> > > @@ -1456,7 +1474,7 @@ struct inode *iget_locked(struct super_block *s=
b, unsigned long ino)
> > >
> > >                 spin_lock(&inode_hash_lock);
> > >                 /* We released the lock, so.. */
> > > -               old =3D find_inode_fast(sb, head, ino, true);
> > > +               old =3D find_inode_fast(sb, head, ino, true, &isnew);
> > >                 if (!old) {
> > >                         inode->i_ino =3D ino;
> > >                         spin_lock(&inode->i_lock);
> > > @@ -1482,10 +1500,12 @@ struct inode *iget_locked(struct super_block =
*sb, unsigned long ino)
> > >                 if (IS_ERR(old))
> > >                         return NULL;
> > >                 inode =3D old;
> > > -               wait_on_inode(inode);
> > > -               if (unlikely(inode_unhashed(inode))) {
> > > -                       iput(inode);
> > > -                       goto again;
> > > +               if (unlikely(isnew)) {
> > > +                       wait_on_new_inode(inode);
> > > +                       if (unlikely(inode_unhashed(inode))) {
> > > +                               iput(inode);
> > > +                               goto again;
> > > +                       }
> > >                 }
> > >         }
> > >         return inode;
> > > @@ -1586,13 +1606,13 @@ EXPORT_SYMBOL(igrab);
> > >   * Note2: @test is called with the inode_hash_lock held, so can't sl=
eep.
> > >   */
> > >  struct inode *ilookup5_nowait(struct super_block *sb, unsigned long =
hashval,
> > > -               int (*test)(struct inode *, void *), void *data)
> > > +               int (*test)(struct inode *, void *), void *data, bool=
 *isnew)
> > >  {
> > >         struct hlist_head *head =3D inode_hashtable + hash(sb, hashva=
l);
> > >         struct inode *inode;
> > >
> > >         spin_lock(&inode_hash_lock);
> > > -       inode =3D find_inode(sb, head, test, data, true);
> > > +       inode =3D find_inode(sb, head, test, data, true, isnew);
> > >         spin_unlock(&inode_hash_lock);
> > >
> > >         return IS_ERR(inode) ? NULL : inode;
> > > @@ -1620,16 +1640,19 @@ struct inode *ilookup5(struct super_block *sb=
, unsigned long hashval,
> > >                 int (*test)(struct inode *, void *), void *data)
> > >  {
> > >         struct inode *inode;
> > > +       bool isnew;
> > >
> > >         might_sleep();
> > >
> > >  again:
> > > -       inode =3D ilookup5_nowait(sb, hashval, test, data);
> > > +       inode =3D ilookup5_nowait(sb, hashval, test, data, &isnew);
> > >         if (inode) {
> > > -               wait_on_inode(inode);
> > > -               if (unlikely(inode_unhashed(inode))) {
> > > -                       iput(inode);
> > > -                       goto again;
> > > +               if (unlikely(isnew)) {
> > > +                       wait_on_new_inode(inode);
> > > +                       if (unlikely(inode_unhashed(inode))) {
> > > +                               iput(inode);
> > > +                               goto again;
> > > +                       }
> > >                 }
> > >         }
> > >         return inode;
> > > @@ -1648,19 +1671,22 @@ struct inode *ilookup(struct super_block *sb,=
 unsigned long ino)
> > >  {
> > >         struct hlist_head *head =3D inode_hashtable + hash(sb, ino);
> > >         struct inode *inode;
> > > +       bool isnew;
> > >
> > >         might_sleep();
> > >
> > >  again:
> > > -       inode =3D find_inode_fast(sb, head, ino, false);
> > > +       inode =3D find_inode_fast(sb, head, ino, false, &isnew);
> > >
> > >         if (inode) {
> > >                 if (IS_ERR(inode))
> > >                         return NULL;
> > > -               wait_on_inode(inode);
> > > -               if (unlikely(inode_unhashed(inode))) {
> > > -                       iput(inode);
> > > -                       goto again;
> > > +               if (unlikely(isnew)) {
> > > +                       wait_on_new_inode(inode);
> > > +                       if (unlikely(inode_unhashed(inode))) {
> > > +                               iput(inode);
> > > +                               goto again;
> > > +                       }
> > >                 }
> > >         }
> > >         return inode;
> > > @@ -1800,6 +1826,7 @@ int insert_inode_locked(struct inode *inode)
> > >         struct super_block *sb =3D inode->i_sb;
> > >         ino_t ino =3D inode->i_ino;
> > >         struct hlist_head *head =3D inode_hashtable + hash(sb, ino);
> > > +       bool isnew;
> > >
> > >         might_sleep();
> > >
> > > @@ -1832,12 +1859,15 @@ int insert_inode_locked(struct inode *inode)
> > >                         return -EBUSY;
> > >                 }
> > >                 __iget(old);
> > > +               isnew =3D !!(inode_state_read(old) & I_NEW);
> > >                 spin_unlock(&old->i_lock);
> > >                 spin_unlock(&inode_hash_lock);
> > > -               wait_on_inode(old);
> > > -               if (unlikely(!inode_unhashed(old))) {
> > > -                       iput(old);
> > > -                       return -EBUSY;
> > > +               if (isnew) {
> > > +                       wait_on_new_inode(old);
> > > +                       if (unlikely(!inode_unhashed(old))) {
> > > +                               iput(old);
> > > +                               return -EBUSY;
> > > +                       }
> > >                 }
> > >                 iput(old);
> > >         }
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 21c73df3ce75..a813abdcf218 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1030,15 +1030,7 @@ static inline void inode_fake_hash(struct inod=
e *inode)
> > >         hlist_add_fake(&inode->i_hash);
> > >  }
> > >
> > > -static inline void wait_on_inode(struct inode *inode)
> > > -{
> > > -       wait_var_event(inode_state_wait_address(inode, __I_NEW),
> > > -                      !(inode_state_read_once(inode) & I_NEW));
> > > -       /*
> > > -        * Pairs with routines clearing I_NEW.
> > > -        */
> > > -       smp_rmb();
> > > -}
> > > +void wait_on_new_inode(struct inode *inode);
> > >
> > >  /*
> > >   * inode->i_rwsem nesting subclasses for the lock validator:
> > > @@ -3417,7 +3409,7 @@ extern void d_mark_dontcache(struct inode *inod=
e);
> > >
> > >  extern struct inode *ilookup5_nowait(struct super_block *sb,
> > >                 unsigned long hashval, int (*test)(struct inode *, vo=
id *),
> > > -               void *data);
> > > +               void *data, bool *isnew);
> > >  extern struct inode *ilookup5(struct super_block *sb, unsigned long =
hashval,
> > >                 int (*test)(struct inode *, void *), void *data);
> > >  extern struct inode *ilookup(struct super_block *sb, unsigned long i=
no);
> > > --
> > > 2.34.1
> > >

