Return-Path: <linux-fsdevel+bounces-64239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED5BDE552
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 13:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C5319C4B3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20796322DD8;
	Wed, 15 Oct 2025 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlyMo40G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690B1322A3B
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529041; cv=none; b=Hj8lRO8VxXfW/xbsoDbU59lGwLzcib1GPj7eB485jEmFESbA18xzEF1EEbeGVeNzKv45w1H0hVpPzyAjY5IxTPNyKu2jhZ0zuHu1VEE1XroRXIr2o9ZM8dhg7E1vTQKRqg2IPVTPLYSK7RWnmPIPQ+Mw4VueOK/JBxl2PnpauL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529041; c=relaxed/simple;
	bh=RXKHwxzKXiJ0UlK2tdmScjt63gxBCd7X0J2PMbqAA6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ihbCvwUW8ScBdRo1gqYC3mCZwK0E0JiMgK14FXRmZSTS91Vq/w43dXmz994pHquTYBnwiiCOjMks8Cz6RQ1CBUlrR+XRTzVreInswBaY1rS4NKOB0klDegyrOw4oxYJoWlP92azKEaecblTzFS2bUIK4GW8V5KktwXkXXnwSPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlyMo40G; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3e9d633b78so212243766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760529038; x=1761133838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpo8kDK8JO1CJCSgMe87q+YOatwPymBjSdrr7goSAYc=;
        b=XlyMo40GkRCTK/yfH7OC8XoqzK+lxRdmLcq7nwROFp4dD9maQT0YvCgzXJGB1fqVdR
         Kp4kZLFdv5+QFKiH1BOt74sTCx2sMhCuC81+LCOcUfQyil12j833hYvE2LSdebSX2dyM
         ec172VsBQM44efOyqt3yUHTL9IEF9eJajl5P3Hdf9O1OidV0ULml2whUZ2hyRZQ3Q6fu
         Px7RWpFruLy7Pynp5Y5pLcRSGkrIqrwEEULnVr1+sFbaoyabtAzp6o1J+8KsCxZoVxzu
         amr4dBPpK60b08qjY2bHgMqohlE5DJ6JoUDTtYackrAJ+I6uCO0v/17162gn9EhPtxu+
         2TYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760529038; x=1761133838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpo8kDK8JO1CJCSgMe87q+YOatwPymBjSdrr7goSAYc=;
        b=v/UN3C2WYEt7Omdo6rL0QYEhEW31rP0FcAqMNip1+L5Aey6sWie3+0rgPMD0y0GlGM
         mHyhmmrxbX7JxlmzERfFWHs7vd9RmYsMC+N00i3npBPgrp3SUR1cFKPxCf1Ez/S3jYxp
         vWCu9lO/6W8WRNjW4Fll7L9t9Nz03QmCuvWLJFQ4Err7cD0eDX017Ml2ZrnnygySMS7a
         vkwS/KexfsOPF1s2G+5Oi4rXIz4OoZwXoWFxJkjL4PjXB9wDW4UuisHCktBjG3QUqg65
         Q+KmpIPmEa6nI9dIswLxFcpX5Zyu6r0rl4Dr+UAiaK6wEIyFGxXKmnuI2vbiv6b9DBYv
         uAAw==
X-Forwarded-Encrypted: i=1; AJvYcCUhgLs9IG6Hj7EDoGJSF+GgbXv3bxFFeFLx5qGRDIz9FiwjbyDQYQvUkQ9YI9PGQ1O4WSm0KRnqHT4GNDbF@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLsEJ7SMeGdcerceY/EesqY7c+fFal5LwbDu9RNOVUWpqNLIF
	BTI0uRWA5SjhiTDaF+tqqZk+idgi1FYz8cTHMazYHClvacJwG8U0ufdbS4cFicmDy3rDDOvbAb5
	EzDqLinC1VVeKHJy8O/JZCSAgBksBAZ4=
X-Gm-Gg: ASbGnct6PZaMmJ0uuywXbFTw7aY17Ade9yQ87NuwoDo3RDU7UDgRIqs5hxLQR7Itsn4
	dfi86ALDr9qpOG8r9TRIj3LIIMDIFdhUIGVEwcn+zGQ1v85ejC7KDhEVaulrcVWx3FoFOK7m55Z
	jdacQIdwpngUDzAWAss2dtHe+ifnntZhJsQdWQDgaAk+TidKWsOzmRjSxFtkB0YTS1GBZQpo51v
	POAq4TY0BjwHW05LECCvwwy0Ql9Webf0ZD6w6T3gh305MahfRZn33frCg==
X-Google-Smtp-Source: AGHT+IEOVWsqm0eHg2SxAXjMoiQU4YW5YHee6f0wIuwZp59XpuSBvVd6RUrccUkRgMNkIxl7OKzSprdoJPXtqK9OVLg=
X-Received: by 2002:a17:907:a788:b0:b2d:4e57:58d8 with SMTP id
 a640c23a62f3a-b4f4116509cmr3174810866b.10.1760529037421; Wed, 15 Oct 2025
 04:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010221737.1403539-1-mjguzik@gmail.com>
In-Reply-To: <20251010221737.1403539-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 15 Oct 2025 13:50:25 +0200
X-Gm-Features: AS18NWDIdlm6uHmrtkVjmZ4eWJLc7In7Fq9FlwNZ0F4qOF4XIPfAbA1zuY-uQ_g
Message-ID: <CAGudoHETiJ8G8WeyFYJ6EZ4oxcmqxV3yztZDOxL8PUBGobW_xQ@mail.gmail.com>
Subject: Re: [PATCH] fs: rework I_NEW handling to operate without fences
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

can i get some flames on this?

On Sat, Oct 11, 2025 at 12:17=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> In the inode hash code grab the state while ->i_lock is held. If found
> to be set, synchronize the sleep once more with the lock held.
>
> In the real world the flag is not set most of the time.
>
> Apart from being simpler to reason about, it comes with a minor speed up
> as now clearing the flag does not require the smp_mb() fence.
>
> While here rename wait_on_inode() to wait_on_new_inode() to line it up
> with __wait_on_freeing_inode().
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>
> This temporarily duplicated sleep code from inode_wait_for_lru_isolating(=
).
> This is going to get dedupped later.
>
> There is high repetition of:
>         if (unlikely(isnew)) {
>                 wait_on_new_inode(old);
>                 if (unlikely(inode_unhashed(old))) {
>                         iput(old);
>                         goto again;
>                 }
>
> I expect this is going to go away after I post a patch to sanitize the
> current APIs for the hash.
>
>
>  fs/afs/dir.c       |   4 +-
>  fs/dcache.c        |  10 ----
>  fs/gfs2/glock.c    |   2 +-
>  fs/inode.c         | 146 +++++++++++++++++++++++++++------------------
>  include/linux/fs.h |  12 +---
>  5 files changed, 93 insertions(+), 81 deletions(-)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 89d36e3e5c79..f4e9e12373ac 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -779,7 +779,7 @@ static struct inode *afs_do_lookup(struct inode *dir,=
 struct dentry *dentry)
>         struct afs_vnode *dvnode =3D AFS_FS_I(dir), *vnode;
>         struct inode *inode =3D NULL, *ti;
>         afs_dataversion_t data_version =3D READ_ONCE(dvnode->status.data_=
version);
> -       bool supports_ibulk;
> +       bool supports_ibulk, isnew;
>         long ret;
>         int i;
>
> @@ -850,7 +850,7 @@ static struct inode *afs_do_lookup(struct inode *dir,=
 struct dentry *dentry)
>                          * callback counters.
>                          */
>                         ti =3D ilookup5_nowait(dir->i_sb, vp->fid.vnode,
> -                                            afs_ilookup5_test_by_fid, &v=
p->fid);
> +                                            afs_ilookup5_test_by_fid, &v=
p->fid, &isnew);
>                         if (!IS_ERR_OR_NULL(ti)) {
>                                 vnode =3D AFS_FS_I(ti);
>                                 vp->dv_before =3D vnode->status.data_vers=
ion;
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 78ffa7b7e824..25131f105a60 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1981,17 +1981,7 @@ void d_instantiate_new(struct dentry *entry, struc=
t inode *inode)
>         spin_lock(&inode->i_lock);
>         __d_instantiate(entry, inode);
>         WARN_ON(!(inode_state_read(inode) & I_NEW));
> -       /*
> -        * Pairs with smp_rmb in wait_on_inode().
> -        */
> -       smp_wmb();
>         inode_state_clear(inode, I_NEW | I_CREATING);
> -       /*
> -        * Pairs with the barrier in prepare_to_wait_event() to make sure
> -        * ___wait_var_event() either sees the bit cleared or
> -        * waitqueue_active() check in wake_up_var() sees the waiter.
> -        */
> -       smp_mb();
>         inode_wake_up_bit(inode, __I_NEW);
>         spin_unlock(&inode->i_lock);
>  }
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index b677c0e6b9ab..c9712235e7a0 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -957,7 +957,7 @@ static struct gfs2_inode *gfs2_grab_existing_inode(st=
ruct gfs2_glock *gl)
>                 ip =3D NULL;
>         spin_unlock(&gl->gl_lockref.lock);
>         if (ip) {
> -               wait_on_inode(&ip->i_inode);
> +               wait_on_new_inode(&ip->i_inode);
>                 if (is_bad_inode(&ip->i_inode)) {
>                         iput(&ip->i_inode);
>                         ip =3D NULL;
> diff --git a/fs/inode.c b/fs/inode.c
> index 3153d725859c..1396f79b2551 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -558,6 +558,32 @@ struct wait_queue_head *inode_bit_waitqueue(struct w=
ait_bit_queue_entry *wqe,
>  }
>  EXPORT_SYMBOL(inode_bit_waitqueue);
>
> +void wait_on_new_inode(struct inode *inode)
> +{
> +       struct wait_bit_queue_entry wqe;
> +       struct wait_queue_head *wq_head;
> +
> +       spin_lock(&inode->i_lock);
> +       if (!(inode_state_read(inode) & I_NEW)) {
> +               spin_unlock(&inode->i_lock);
> +               return;
> +       }
> +
> +       wq_head =3D inode_bit_waitqueue(&wqe, inode, __I_NEW);
> +       for (;;) {
> +               prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTE=
RRUPTIBLE);
> +               if (!(inode_state_read(inode) & I_NEW))
> +                       break;
> +               spin_unlock(&inode->i_lock);
> +               schedule();
> +               spin_lock(&inode->i_lock);
> +       }
> +       finish_wait(wq_head, &wqe.wq_entry);
> +       WARN_ON(inode_state_read(inode) & I_NEW);
> +       spin_unlock(&inode->i_lock);
> +}
> +EXPORT_SYMBOL(wait_on_new_inode);
> +
>  /*
>   * Add inode to LRU if needed (inode is unused and clean).
>   *
> @@ -1008,7 +1034,8 @@ static void __wait_on_freeing_inode(struct inode *i=
node, bool is_inode_hash_lock
>  static struct inode *find_inode(struct super_block *sb,
>                                 struct hlist_head *head,
>                                 int (*test)(struct inode *, void *),
> -                               void *data, bool is_inode_hash_locked)
> +                               void *data, bool is_inode_hash_locked,
> +                               bool *isnew)
>  {
>         struct inode *inode =3D NULL;
>
> @@ -1035,6 +1062,7 @@ static struct inode *find_inode(struct super_block =
*sb,
>                         return ERR_PTR(-ESTALE);
>                 }
>                 __iget(inode);
> +               *isnew =3D !!(inode_state_read(inode) & I_NEW);
>                 spin_unlock(&inode->i_lock);
>                 rcu_read_unlock();
>                 return inode;
> @@ -1049,7 +1077,7 @@ static struct inode *find_inode(struct super_block =
*sb,
>   */
>  static struct inode *find_inode_fast(struct super_block *sb,
>                                 struct hlist_head *head, unsigned long in=
o,
> -                               bool is_inode_hash_locked)
> +                               bool is_inode_hash_locked, bool *isnew)
>  {
>         struct inode *inode =3D NULL;
>
> @@ -1076,6 +1104,7 @@ static struct inode *find_inode_fast(struct super_b=
lock *sb,
>                         return ERR_PTR(-ESTALE);
>                 }
>                 __iget(inode);
> +               *isnew =3D !!(inode_state_read(inode) & I_NEW);
>                 spin_unlock(&inode->i_lock);
>                 rcu_read_unlock();
>                 return inode;
> @@ -1181,17 +1210,7 @@ void unlock_new_inode(struct inode *inode)
>         lockdep_annotate_inode_mutex_key(inode);
>         spin_lock(&inode->i_lock);
>         WARN_ON(!(inode_state_read(inode) & I_NEW));
> -       /*
> -        * Pairs with smp_rmb in wait_on_inode().
> -        */
> -       smp_wmb();
>         inode_state_clear(inode, I_NEW | I_CREATING);
> -       /*
> -        * Pairs with the barrier in prepare_to_wait_event() to make sure
> -        * ___wait_var_event() either sees the bit cleared or
> -        * waitqueue_active() check in wake_up_var() sees the waiter.
> -        */
> -       smp_mb();
>         inode_wake_up_bit(inode, __I_NEW);
>         spin_unlock(&inode->i_lock);
>  }
> @@ -1202,17 +1221,7 @@ void discard_new_inode(struct inode *inode)
>         lockdep_annotate_inode_mutex_key(inode);
>         spin_lock(&inode->i_lock);
>         WARN_ON(!(inode_state_read(inode) & I_NEW));
> -       /*
> -        * Pairs with smp_rmb in wait_on_inode().
> -        */
> -       smp_wmb();
>         inode_state_clear(inode, I_NEW);
> -       /*
> -        * Pairs with the barrier in prepare_to_wait_event() to make sure
> -        * ___wait_var_event() either sees the bit cleared or
> -        * waitqueue_active() check in wake_up_var() sees the waiter.
> -        */
> -       smp_mb();
>         inode_wake_up_bit(inode, __I_NEW);
>         spin_unlock(&inode->i_lock);
>         iput(inode);
> @@ -1286,12 +1295,13 @@ struct inode *inode_insert5(struct inode *inode, =
unsigned long hashval,
>  {
>         struct hlist_head *head =3D inode_hashtable + hash(inode->i_sb, h=
ashval);
>         struct inode *old;
> +       bool isnew;
>
>         might_sleep();
>
>  again:
>         spin_lock(&inode_hash_lock);
> -       old =3D find_inode(inode->i_sb, head, test, data, true);
> +       old =3D find_inode(inode->i_sb, head, test, data, true, &isnew);
>         if (unlikely(old)) {
>                 /*
>                  * Uhhuh, somebody else created the same inode under us.
> @@ -1300,10 +1310,12 @@ struct inode *inode_insert5(struct inode *inode, =
unsigned long hashval,
>                 spin_unlock(&inode_hash_lock);
>                 if (IS_ERR(old))
>                         return NULL;
> -               wait_on_inode(old);
> -               if (unlikely(inode_unhashed(old))) {
> -                       iput(old);
> -                       goto again;
> +               if (unlikely(isnew)) {
> +                       wait_on_new_inode(old);
> +                       if (unlikely(inode_unhashed(old))) {
> +                               iput(old);
> +                               goto again;
> +                       }
>                 }
>                 return old;
>         }
> @@ -1391,18 +1403,21 @@ struct inode *iget5_locked_rcu(struct super_block=
 *sb, unsigned long hashval,
>  {
>         struct hlist_head *head =3D inode_hashtable + hash(sb, hashval);
>         struct inode *inode, *new;
> +       bool isnew;
>
>         might_sleep();
>
>  again:
> -       inode =3D find_inode(sb, head, test, data, false);
> +       inode =3D find_inode(sb, head, test, data, false, &isnew);
>         if (inode) {
>                 if (IS_ERR(inode))
>                         return NULL;
> -               wait_on_inode(inode);
> -               if (unlikely(inode_unhashed(inode))) {
> -                       iput(inode);
> -                       goto again;
> +               if (unlikely(isnew)) {
> +                       wait_on_new_inode(inode);
> +                       if (unlikely(inode_unhashed(inode))) {
> +                               iput(inode);
> +                               goto again;
> +                       }
>                 }
>                 return inode;
>         }
> @@ -1434,18 +1449,21 @@ struct inode *iget_locked(struct super_block *sb,=
 unsigned long ino)
>  {
>         struct hlist_head *head =3D inode_hashtable + hash(sb, ino);
>         struct inode *inode;
> +       bool isnew;
>
>         might_sleep();
>
>  again:
> -       inode =3D find_inode_fast(sb, head, ino, false);
> +       inode =3D find_inode_fast(sb, head, ino, false, &isnew);
>         if (inode) {
>                 if (IS_ERR(inode))
>                         return NULL;
> -               wait_on_inode(inode);
> -               if (unlikely(inode_unhashed(inode))) {
> -                       iput(inode);
> -                       goto again;
> +               if (unlikely(isnew)) {
> +                       wait_on_new_inode(inode);
> +                       if (unlikely(inode_unhashed(inode))) {
> +                               iput(inode);
> +                               goto again;
> +                       }
>                 }
>                 return inode;
>         }
> @@ -1456,7 +1474,7 @@ struct inode *iget_locked(struct super_block *sb, u=
nsigned long ino)
>
>                 spin_lock(&inode_hash_lock);
>                 /* We released the lock, so.. */
> -               old =3D find_inode_fast(sb, head, ino, true);
> +               old =3D find_inode_fast(sb, head, ino, true, &isnew);
>                 if (!old) {
>                         inode->i_ino =3D ino;
>                         spin_lock(&inode->i_lock);
> @@ -1482,10 +1500,12 @@ struct inode *iget_locked(struct super_block *sb,=
 unsigned long ino)
>                 if (IS_ERR(old))
>                         return NULL;
>                 inode =3D old;
> -               wait_on_inode(inode);
> -               if (unlikely(inode_unhashed(inode))) {
> -                       iput(inode);
> -                       goto again;
> +               if (unlikely(isnew)) {
> +                       wait_on_new_inode(inode);
> +                       if (unlikely(inode_unhashed(inode))) {
> +                               iput(inode);
> +                               goto again;
> +                       }
>                 }
>         }
>         return inode;
> @@ -1586,13 +1606,13 @@ EXPORT_SYMBOL(igrab);
>   * Note2: @test is called with the inode_hash_lock held, so can't sleep.
>   */
>  struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hash=
val,
> -               int (*test)(struct inode *, void *), void *data)
> +               int (*test)(struct inode *, void *), void *data, bool *is=
new)
>  {
>         struct hlist_head *head =3D inode_hashtable + hash(sb, hashval);
>         struct inode *inode;
>
>         spin_lock(&inode_hash_lock);
> -       inode =3D find_inode(sb, head, test, data, true);
> +       inode =3D find_inode(sb, head, test, data, true, isnew);
>         spin_unlock(&inode_hash_lock);
>
>         return IS_ERR(inode) ? NULL : inode;
> @@ -1620,16 +1640,19 @@ struct inode *ilookup5(struct super_block *sb, un=
signed long hashval,
>                 int (*test)(struct inode *, void *), void *data)
>  {
>         struct inode *inode;
> +       bool isnew;
>
>         might_sleep();
>
>  again:
> -       inode =3D ilookup5_nowait(sb, hashval, test, data);
> +       inode =3D ilookup5_nowait(sb, hashval, test, data, &isnew);
>         if (inode) {
> -               wait_on_inode(inode);
> -               if (unlikely(inode_unhashed(inode))) {
> -                       iput(inode);
> -                       goto again;
> +               if (unlikely(isnew)) {
> +                       wait_on_new_inode(inode);
> +                       if (unlikely(inode_unhashed(inode))) {
> +                               iput(inode);
> +                               goto again;
> +                       }
>                 }
>         }
>         return inode;
> @@ -1648,19 +1671,22 @@ struct inode *ilookup(struct super_block *sb, uns=
igned long ino)
>  {
>         struct hlist_head *head =3D inode_hashtable + hash(sb, ino);
>         struct inode *inode;
> +       bool isnew;
>
>         might_sleep();
>
>  again:
> -       inode =3D find_inode_fast(sb, head, ino, false);
> +       inode =3D find_inode_fast(sb, head, ino, false, &isnew);
>
>         if (inode) {
>                 if (IS_ERR(inode))
>                         return NULL;
> -               wait_on_inode(inode);
> -               if (unlikely(inode_unhashed(inode))) {
> -                       iput(inode);
> -                       goto again;
> +               if (unlikely(isnew)) {
> +                       wait_on_new_inode(inode);
> +                       if (unlikely(inode_unhashed(inode))) {
> +                               iput(inode);
> +                               goto again;
> +                       }
>                 }
>         }
>         return inode;
> @@ -1800,6 +1826,7 @@ int insert_inode_locked(struct inode *inode)
>         struct super_block *sb =3D inode->i_sb;
>         ino_t ino =3D inode->i_ino;
>         struct hlist_head *head =3D inode_hashtable + hash(sb, ino);
> +       bool isnew;
>
>         might_sleep();
>
> @@ -1832,12 +1859,15 @@ int insert_inode_locked(struct inode *inode)
>                         return -EBUSY;
>                 }
>                 __iget(old);
> +               isnew =3D !!(inode_state_read(old) & I_NEW);
>                 spin_unlock(&old->i_lock);
>                 spin_unlock(&inode_hash_lock);
> -               wait_on_inode(old);
> -               if (unlikely(!inode_unhashed(old))) {
> -                       iput(old);
> -                       return -EBUSY;
> +               if (isnew) {
> +                       wait_on_new_inode(old);
> +                       if (unlikely(!inode_unhashed(old))) {
> +                               iput(old);
> +                               return -EBUSY;
> +                       }
>                 }
>                 iput(old);
>         }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 21c73df3ce75..a813abdcf218 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1030,15 +1030,7 @@ static inline void inode_fake_hash(struct inode *i=
node)
>         hlist_add_fake(&inode->i_hash);
>  }
>
> -static inline void wait_on_inode(struct inode *inode)
> -{
> -       wait_var_event(inode_state_wait_address(inode, __I_NEW),
> -                      !(inode_state_read_once(inode) & I_NEW));
> -       /*
> -        * Pairs with routines clearing I_NEW.
> -        */
> -       smp_rmb();
> -}
> +void wait_on_new_inode(struct inode *inode);
>
>  /*
>   * inode->i_rwsem nesting subclasses for the lock validator:
> @@ -3417,7 +3409,7 @@ extern void d_mark_dontcache(struct inode *inode);
>
>  extern struct inode *ilookup5_nowait(struct super_block *sb,
>                 unsigned long hashval, int (*test)(struct inode *, void *=
),
> -               void *data);
> +               void *data, bool *isnew);
>  extern struct inode *ilookup5(struct super_block *sb, unsigned long hash=
val,
>                 int (*test)(struct inode *, void *), void *data);
>  extern struct inode *ilookup(struct super_block *sb, unsigned long ino);
> --
> 2.34.1
>

