Return-Path: <linux-fsdevel+bounces-10014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CFD84703D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A4E28B0C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A32144606;
	Fri,  2 Feb 2024 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtRcN/hJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2837140783;
	Fri,  2 Feb 2024 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876762; cv=none; b=s1rUeTICRP8ImmH4/alAZ4hXgoKQtMTbXPDAFxsLzne+lb/SbpSbE6CiS8A0ht9scqQy7S1UIwYlbpF2a4HNPOEZ0VVcBSx71Cd+a3Cs0KrwLRM26SqBSWTazxUgQcTvhuhizr7jDY8QdcCu7F06ZcjqTg5a4/ptNaulPVyJBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876762; c=relaxed/simple;
	bh=Tw35jGRqwEaaFrKm56paYJvFfUTFwDuU/Oivtu/pSc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+R2A0P7sBVRtVWxuI77N12me0hwkqhhqwLoK/IMbeWsRb1BaEftQ1nrQZJFPLot0DYmX/1q6FkiGq6BGzzOmfioMQ6Q9t0J8SzFYRkLOEiGmaHPeoInDHt9QDSal4Ejjb7Pp42MJeDMh/0AnY63uOL7VXa8wwG5V/rvX7qGUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtRcN/hJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-511206d1c89so2742907e87.1;
        Fri, 02 Feb 2024 04:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706876758; x=1707481558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cMvb8VA96y3MEO7FFtiqwg3FWVeCN/rGYUEn/narly4=;
        b=dtRcN/hJojhltJAY3D/Fg95PrGNJhQXMkRr9ZPwuB9rsOIe4B8AzreJoNRUuv01y9g
         FViEMRakV9bq8QMGqK53VsFUGV0+tOxG7vgikiw1lWlx5eybDKcECq6Lm74qCfPNgl9V
         KEri8j+m5xm0E/Eax06nT9R1hZoe58n09DxPCfYSF9cQbhPdnbVlC1uL86O2Vl3/gbC6
         PVXgWbcQnUaKf9t3K4K4MbybQDOyVRN4fIM2l49P2OP4/HfMFG6ENG/KlYlWtgWAjVDw
         0tYdFNNt33eRyrGmbh/r2DWGMZ8TYX1R07N53gJ3ILOSGNnyLE34a7LafQbFQpTzTB49
         6VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876758; x=1707481558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMvb8VA96y3MEO7FFtiqwg3FWVeCN/rGYUEn/narly4=;
        b=HstPAXk3k0Fqn0IqjdNmuI0ouqqFgP2IsgjaEqua8z0m9DDPGKE4K8rfiUzEUc0FnV
         o+uQM+CTRBoWEyHwJBOeBLfcJ32jIHE5phzfUJeCSGU2QIQEieNTVr+yxrftJI9E5qZu
         iiVHMCi5VplVbfL4e2h9G8pUEnESH+PuR53QVFMQxHKUpDupvT4SU6YrU9pSnytHcYxu
         aAFwmZx9Lvotq2vtvycc+7+6Wn/JzfldmOV2X49NkTNS0CX19ymyze3Kwxq9B8Mprd0u
         3kViukYvP1fr9fwduAzBJ6WYj5ebuWC3kaS8PvY5v7lXVtlNPzqbgnxvtMnRDbskH9ti
         MTJg==
X-Gm-Message-State: AOJu0YysLD/kzeWnAWTUTZoq8isguU5Kf0p4bP+gfjO9G7lA5677JyVV
	ceEidB0hdWffTKNx9fEyR82X6Xm3zMso9v8wfrHbk9fXmRGozQdNyxvFNvo9u6I8kCQdtnKo156
	PQ4odxwht8nIA1LQ4KojWA4Jkt7M=
X-Google-Smtp-Source: AGHT+IH3MpyDQsZKQdTX5F5C/FwhEAW32gPBprX2q8BPQcrXLC5Pa8gkQ+GIBf7MGEctDL8si7Whpq0UZ/8EgPnPqMo=
X-Received: by 2002:a19:644a:0:b0:50e:95cf:e7b1 with SMTP id
 b10-20020a19644a000000b0050e95cfe7b1mr1416305lfj.9.1706876757502; Fri, 02 Feb
 2024 04:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127020833.487907-1-kent.overstreet@linux.dev>
 <20240127020833.487907-2-kent.overstreet@linux.dev> <20240202120357.tfjdri5rfd2onajl@quack3>
In-Reply-To: <20240202120357.tfjdri5rfd2onajl@quack3>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 2 Feb 2024 13:25:20 +0100
Message-ID: <CA+icZUWdUUhWg_-0NvF+6L=EUhj7amv_7HRKHDPvrEBspwHC2Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] fs/pipe: Convert to lockdep_cmp_fn
To: Jan Kara <jack@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, peterz@infradead.org, 
	boqun.feng@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:12=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 26-01-24 21:08:28, Kent Overstreet wrote:
> > *_lock_nested() is fundamentally broken; lockdep needs to check lock
> > ordering, but we cannot device a total ordering on an unbounded number
> > of elements with only a few subclasses.
> >
> > the replacement is to define lock ordering with a proper comparison
> > function.
> >
> > fs/pipe.c was already doing everything correctly otherwise, nothing
> > much changes here.
> >
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>
> I had to digest for a while what this new lockdep lock ordering feature i=
s
> about. I have one pending question - what is the motivation of this
> conversion of pipe code? AFAIU we don't have any problems with lockdep
> annotations on pipe->mutex because there are always only two subclasses?
>
>                                                                 Honza

Hi,

"Numbers talk - Bullshit walks." (Linus Torvalds)

In things of pipes - I normally benchmark like this (example):

root# cat /dev/sdc | pipebench > /dev/null

Do you have numbers for your patch-series?

Thanks.

BG,
-Sedat-

[1] https://packages.debian.org/pipebench

>
> > ---
> >  fs/pipe.c | 81 +++++++++++++++++++++++++------------------------------
> >  1 file changed, 36 insertions(+), 45 deletions(-)
> >
> > diff --git a/fs/pipe.c b/fs/pipe.c
> > index f1adbfe743d4..50c8a8596b52 100644
> > --- a/fs/pipe.c
> > +++ b/fs/pipe.c
> > @@ -76,18 +76,20 @@ static unsigned long pipe_user_pages_soft =3D PIPE_=
DEF_BUFFERS * INR_OPEN_CUR;
> >   * -- Manfred Spraul <manfred@colorfullife.com> 2002-05-09
> >   */
> >
> > -static void pipe_lock_nested(struct pipe_inode_info *pipe, int subclas=
s)
> > +#define cmp_int(l, r)                ((l > r) - (l < r))
> > +
> > +#ifdef CONFIG_PROVE_LOCKING
> > +static int pipe_lock_cmp_fn(const struct lockdep_map *a,
> > +                         const struct lockdep_map *b)
> >  {
> > -     if (pipe->files)
> > -             mutex_lock_nested(&pipe->mutex, subclass);
> > +     return cmp_int((unsigned long) a, (unsigned long) b);
> >  }
> > +#endif
> >
> >  void pipe_lock(struct pipe_inode_info *pipe)
> >  {
> > -     /*
> > -      * pipe_lock() nests non-pipe inode locks (for writing to a file)
> > -      */
> > -     pipe_lock_nested(pipe, I_MUTEX_PARENT);
> > +     if (pipe->files)
> > +             mutex_lock(&pipe->mutex);
> >  }
> >  EXPORT_SYMBOL(pipe_lock);
> >
> > @@ -98,28 +100,16 @@ void pipe_unlock(struct pipe_inode_info *pipe)
> >  }
> >  EXPORT_SYMBOL(pipe_unlock);
> >
> > -static inline void __pipe_lock(struct pipe_inode_info *pipe)
> > -{
> > -     mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
> > -}
> > -
> > -static inline void __pipe_unlock(struct pipe_inode_info *pipe)
> > -{
> > -     mutex_unlock(&pipe->mutex);
> > -}
> > -
> >  void pipe_double_lock(struct pipe_inode_info *pipe1,
> >                     struct pipe_inode_info *pipe2)
> >  {
> >       BUG_ON(pipe1 =3D=3D pipe2);
> >
> > -     if (pipe1 < pipe2) {
> > -             pipe_lock_nested(pipe1, I_MUTEX_PARENT);
> > -             pipe_lock_nested(pipe2, I_MUTEX_CHILD);
> > -     } else {
> > -             pipe_lock_nested(pipe2, I_MUTEX_PARENT);
> > -             pipe_lock_nested(pipe1, I_MUTEX_CHILD);
> > -     }
> > +     if (pipe1 > pipe2)
> > +             swap(pipe1, pipe2);
> > +
> > +     pipe_lock(pipe1);
> > +     pipe_lock(pipe2);
> >  }
> >
> >  static void anon_pipe_buf_release(struct pipe_inode_info *pipe,
> > @@ -271,7 +261,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >               return 0;
> >
> >       ret =3D 0;
> > -     __pipe_lock(pipe);
> > +     mutex_lock(&pipe->mutex);
> >
> >       /*
> >        * We only wake up writers if the pipe was full when we started
> > @@ -368,7 +358,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
> >                       ret =3D -EAGAIN;
> >                       break;
> >               }
> > -             __pipe_unlock(pipe);
> > +             mutex_unlock(&pipe->mutex);
> >
> >               /*
> >                * We only get here if we didn't actually read anything.
> > @@ -400,13 +390,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to=
)
> >               if (wait_event_interruptible_exclusive(pipe->rd_wait, pip=
e_readable(pipe)) < 0)
> >                       return -ERESTARTSYS;
> >
> > -             __pipe_lock(pipe);
> > +             mutex_lock(&pipe->mutex);
> >               was_full =3D pipe_full(pipe->head, pipe->tail, pipe->max_=
usage);
> >               wake_next_reader =3D true;
> >       }
> >       if (pipe_empty(pipe->head, pipe->tail))
> >               wake_next_reader =3D false;
> > -     __pipe_unlock(pipe);
> > +     mutex_unlock(&pipe->mutex);
> >
> >       if (was_full)
> >               wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT =
| EPOLLWRNORM);
> > @@ -462,7 +452,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *fro=
m)
> >       if (unlikely(total_len =3D=3D 0))
> >               return 0;
> >
> > -     __pipe_lock(pipe);
> > +     mutex_lock(&pipe->mutex);
> >
> >       if (!pipe->readers) {
> >               send_sig(SIGPIPE, current, 0);
> > @@ -582,19 +572,19 @@ pipe_write(struct kiocb *iocb, struct iov_iter *f=
rom)
> >                * after waiting we need to re-check whether the pipe
> >                * become empty while we dropped the lock.
> >                */
> > -             __pipe_unlock(pipe);
> > +             mutex_unlock(&pipe->mutex);
> >               if (was_empty)
> >                       wake_up_interruptible_sync_poll(&pipe->rd_wait, E=
POLLIN | EPOLLRDNORM);
> >               kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> >               wait_event_interruptible_exclusive(pipe->wr_wait, pipe_wr=
itable(pipe));
> > -             __pipe_lock(pipe);
> > +             mutex_lock(&pipe->mutex);
> >               was_empty =3D pipe_empty(pipe->head, pipe->tail);
> >               wake_next_writer =3D true;
> >       }
> >  out:
> >       if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
> >               wake_next_writer =3D false;
> > -     __pipe_unlock(pipe);
> > +     mutex_unlock(&pipe->mutex);
> >
> >       /*
> >        * If we do do a wakeup event, we do a 'sync' wakeup, because we
> > @@ -629,7 +619,7 @@ static long pipe_ioctl(struct file *filp, unsigned =
int cmd, unsigned long arg)
> >
> >       switch (cmd) {
> >       case FIONREAD:
> > -             __pipe_lock(pipe);
> > +             mutex_lock(&pipe->mutex);
> >               count =3D 0;
> >               head =3D pipe->head;
> >               tail =3D pipe->tail;
> > @@ -639,16 +629,16 @@ static long pipe_ioctl(struct file *filp, unsigne=
d int cmd, unsigned long arg)
> >                       count +=3D pipe->bufs[tail & mask].len;
> >                       tail++;
> >               }
> > -             __pipe_unlock(pipe);
> > +             mutex_unlock(&pipe->mutex);
> >
> >               return put_user(count, (int __user *)arg);
> >
> >  #ifdef CONFIG_WATCH_QUEUE
> >       case IOC_WATCH_QUEUE_SET_SIZE: {
> >               int ret;
> > -             __pipe_lock(pipe);
> > +             mutex_lock(&pipe->mutex);
> >               ret =3D watch_queue_set_size(pipe, arg);
> > -             __pipe_unlock(pipe);
> > +             mutex_unlock(&pipe->mutex);
> >               return ret;
> >       }
> >
> > @@ -734,7 +724,7 @@ pipe_release(struct inode *inode, struct file *file=
)
> >  {
> >       struct pipe_inode_info *pipe =3D file->private_data;
> >
> > -     __pipe_lock(pipe);
> > +     mutex_lock(&pipe->mutex);
> >       if (file->f_mode & FMODE_READ)
> >               pipe->readers--;
> >       if (file->f_mode & FMODE_WRITE)
> > @@ -747,7 +737,7 @@ pipe_release(struct inode *inode, struct file *file=
)
> >               kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> >               kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> >       }
> > -     __pipe_unlock(pipe);
> > +     mutex_unlock(&pipe->mutex);
> >
> >       put_pipe_info(inode, pipe);
> >       return 0;
> > @@ -759,7 +749,7 @@ pipe_fasync(int fd, struct file *filp, int on)
> >       struct pipe_inode_info *pipe =3D filp->private_data;
> >       int retval =3D 0;
> >
> > -     __pipe_lock(pipe);
> > +     mutex_lock(&pipe->mutex);
> >       if (filp->f_mode & FMODE_READ)
> >               retval =3D fasync_helper(fd, filp, on, &pipe->fasync_read=
ers);
> >       if ((filp->f_mode & FMODE_WRITE) && retval >=3D 0) {
> > @@ -768,7 +758,7 @@ pipe_fasync(int fd, struct file *filp, int on)
> >                       /* this can happen only if on =3D=3D T */
> >                       fasync_helper(-1, filp, 0, &pipe->fasync_readers)=
;
> >       }
> > -     __pipe_unlock(pipe);
> > +     mutex_unlock(&pipe->mutex);
> >       return retval;
> >  }
> >
> > @@ -834,6 +824,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
> >               pipe->nr_accounted =3D pipe_bufs;
> >               pipe->user =3D user;
> >               mutex_init(&pipe->mutex);
> > +             lock_set_cmp_fn(&pipe->mutex, pipe_lock_cmp_fn, NULL);
> >               return pipe;
> >       }
> >
> > @@ -1144,7 +1135,7 @@ static int fifo_open(struct inode *inode, struct =
file *filp)
> >       filp->private_data =3D pipe;
> >       /* OK, we have a pipe and it's pinned down */
> >
> > -     __pipe_lock(pipe);
> > +     mutex_lock(&pipe->mutex);
> >
> >       /* We can only do regular read/write on fifos */
> >       stream_open(inode, filp);
> > @@ -1214,7 +1205,7 @@ static int fifo_open(struct inode *inode, struct =
file *filp)
> >       }
> >
> >       /* Ok! */
> > -     __pipe_unlock(pipe);
> > +     mutex_unlock(&pipe->mutex);
> >       return 0;
> >
> >  err_rd:
> > @@ -1230,7 +1221,7 @@ static int fifo_open(struct inode *inode, struct =
file *filp)
> >       goto err;
> >
> >  err:
> > -     __pipe_unlock(pipe);
> > +     mutex_unlock(&pipe->mutex);
> >
> >       put_pipe_info(inode, pipe);
> >       return ret;
> > @@ -1411,7 +1402,7 @@ long pipe_fcntl(struct file *file, unsigned int c=
md, unsigned int arg)
> >       if (!pipe)
> >               return -EBADF;
> >
> > -     __pipe_lock(pipe);
> > +     mutex_lock(&pipe->mutex);
> >
> >       switch (cmd) {
> >       case F_SETPIPE_SZ:
> > @@ -1425,7 +1416,7 @@ long pipe_fcntl(struct file *file, unsigned int c=
md, unsigned int arg)
> >               break;
> >       }
> >
> > -     __pipe_unlock(pipe);
> > +     mutex_unlock(&pipe->mutex);
> >       return ret;
> >  }
> >
> > --
> > 2.43.0
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>

