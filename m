Return-Path: <linux-fsdevel+bounces-46997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF5A973CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D20B1896246
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891D61DB154;
	Tue, 22 Apr 2025 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCWmW/8H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928C1D5CEA
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343697; cv=none; b=ixQk3gAeJqDnrWFKS+XYZGPL3BYhwf7xaeIVFTneVgSygfUYLTlT5SLzGrkmQXfy4DOWUt0ojn7uuLZGxW5LDn7Z0pHu0cvfwOBm0W+zkp++NOoQ30Bn8GbWjz5W6fPjlHBz1QeZXFdHze8dmbWWsDl6SJt8QXBrmBzS8ySWAEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343697; c=relaxed/simple;
	bh=J1XACVnx9RJl/TD9TooSLNThGkr7HrPiDUwdN9JodyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6zwn8bU1P38/Eoy/2FHCJZ8LnvyseaMhqjo1euGYaaHfosU6tD4QRz7eGEarJpoPqk9v7RZ5H/4oZ+uBI6bySGw2JgZcuis/4w/yVd8oEQLdYsJJNBnMyHISApacl/Ini+dQhNWMYiy0J1UBS+la187eIRO4qI0B+BwQ4qvl84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCWmW/8H; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4769aef457bso65576121cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 10:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745343694; x=1745948494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCNe8i0BAgJWtaMr5ewXgev5akdheG+RiY5FcYx6mUI=;
        b=SCWmW/8HVsojOkr4uMD1aKWU0o82QZqxMKkHdq9SBa57SyPZm42uyTZXRo94nthWB1
         nP/QJJKVi5iarRLWWdVeAERdcx5VdBpqbgptLuaIlTzxf7Ovqs+Nh4gR65voACElL2ro
         tahckQpsrA5elrOqD/4pds1EAsNICai9Jrd+BB2Op1M1OyY5EMq744KeoaYh2nCV7thc
         LGSVgCxbo98GZsgd3bR5azhKX+kflxwNsek5mEmreYv72McRQGJpqo800N4fXKUJPXOc
         W2J0GLLloYXl4F7+T3L2+0cKfTWDNOcEG8huEVuCLFljTWajjnTkjxInUsv7Xj6E7KpG
         0h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745343694; x=1745948494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCNe8i0BAgJWtaMr5ewXgev5akdheG+RiY5FcYx6mUI=;
        b=LbS5Z0/EJZJgb4Op1XfuwZIipqUnXAJJY6Vc2OCNmrWqX7wuNfe52VWQJ683Qrb1bZ
         t1AVhhmKDd3eBBEskFHNxsALVRB8ktM78hxytI5e3N+tWOWnxXmNngjutYe9k8c0F1bF
         Xkq0s7OGHYGCkbuaOLmzhr+LZAlffGt+vkvs7QFsOY3ai4c9S6JRKB/SfNbbNQ/ckpOZ
         PjLCvS3WOKs/scYEAbqyE8AH0WHfNEAKlNII+aBcs/ac/cnwEeYaCUfFtS5EMDPezWGt
         MxpDYSAnwsm8Y/rwBr05UKX9AT4oK8H35mFwneNRlAYH6rWZSlMYpLTX+t5rtX+KVTWb
         6Fhw==
X-Forwarded-Encrypted: i=1; AJvYcCXj9e3CE3wsMpnYn08jfvNweup3eYo7muB7pMYRxAntwObwWPBc2Grafm7ECET+JLCh1PPH0Gbugp7+FwED@vger.kernel.org
X-Gm-Message-State: AOJu0Yyos/0XP4ZkCjF5oDx9zEYz0YeQEWswwkqMc24nOLwfUnIc/Tgo
	4K+BPzuwmOPZzlccW+ElJqT8DWAnrmqlK+kIu8t9PjVWQmnylkde3OdduPRicIXA234rN76hGBk
	VsFrCDS8SceKIcgmk1PrgmISZQgEPi9Ux
X-Gm-Gg: ASbGncvPweWLXLemudYcE2X3/d9YVgDRLhiGw/DRqozCrxHiE/DQe7yaezZgess7o+X
	/8eGk2S2xK+ZHyKgXNoXfbUcqnrFj5W9yMYvSOtpxDCB202B+yQdPQEcAHvAMmbT2fHGJixDE/+
	46BxxjFdJJwZ9p8hXkLYET/lF8JrYar1x9vzj03g==
X-Google-Smtp-Source: AGHT+IF4bqaOLkc80S0+mxFnpzANXCFDrF4tpfc/EGZHQ/JDMTt2BFYqAQ5OvXpB/hZfCdD666ydq7sV326G+pjSqVA=
X-Received: by 2002:a05:622a:148d:b0:476:aa36:d67c with SMTP id
 d75a77b69052e-47aec4c568emr317614661cf.49.1745343693600; Tue, 22 Apr 2025
 10:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419000614.3795331-1-joannelkoong@gmail.com>
 <5332002a-e444-4f62-8217-8d124182290d@fastmail.fm> <26673a5077b148e98a3957532f0cb445aa7ed3c7.camel@kernel.org>
 <a65b5034-2bae-4eec-92e2-3a9ad003b0bb@fastmail.fm> <CAJnrk1bGxhuQRCB_biX52J_rbq8S5tvPQyK-Lf+-nsMRK5OtOg@mail.gmail.com>
 <b7034a2d7443c76e1efc90fae9d7b81c80a5c03f.camel@kernel.org>
In-Reply-To: <b7034a2d7443c76e1efc90fae9d7b81c80a5c03f.camel@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 22 Apr 2025 10:41:22 -0700
X-Gm-Features: ATxdqUGKJ9k36f_NxxvegNl9iOEYCOZZabRbmwp5V0C1ZVWSQuidBi4yCl7G96E
Message-ID: <CAJnrk1Yp1Qex7RQxsn8qD-O+YGMc-p06atFCez=B8=2kVNagLw@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: use splice for reading user pages on servers
 that enable it
To: Jeff Layton <jlayton@kernel.org>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 4:37=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2025-04-21 at 17:49 -0700, Joanne Koong wrote:
> > On Mon, Apr 21, 2025 at 2:38=E2=80=AFPM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> > >
> > > On 4/21/25 14:35, Jeff Layton wrote:
> > > > On Mon, 2025-04-21 at 13:49 +0200, Bernd Schubert wrote:
> > > > >
> > > > > On 4/19/25 02:06, Joanne Koong wrote:
> > > > > > For direct io writes, splice is disabled when forwarding pages =
from the
> > > > > > client to the server. This is because the pages in the pipe buf=
fer are
> > > > > > user pages, which is controlled by the client. Thus if a server=
 replies
> > > > > > to the request and then keeps accessing the pages afterwards, t=
here is
> > > > > > the possibility that the client may have modified the contents =
of the
> > > > > > pages in the meantime. More context on this can be found in com=
mit
> > > > > > 0c4bcfdecb1a ("fuse: fix pipe buffer lifetime for direct_io").
> > > > > >
> > > > > > For servers that do not need to access pages after answering th=
e
> > > > > > request, splice gives a non-trivial improvement in performance.
> > > > > > Benchmarks show roughly a 40% speedup.
> > > > > >
> > > > > > Allow servers to enable zero-copy splice for servicing client d=
irect io
> > > > > > writes. By enabling this, the server understands that they shou=
ld not
> > > > > > continue accessing the pipe buffer after completing the request=
 or may
> > > > > > face incorrect data if they do so.
> > > > > >
> > > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > > ---
> > > > > >  fs/fuse/dev.c             | 18 ++++++++++--------
> > > > > >  fs/fuse/dev_uring.c       |  4 ++--
> > > > > >  fs/fuse/fuse_dev_i.h      |  5 +++--
> > > > > >  fs/fuse/fuse_i.h          |  3 +++
> > > > > >  fs/fuse/inode.c           |  5 ++++-
> > > > > >  include/uapi/linux/fuse.h |  8 ++++++++
> > > > > >  6 files changed, 30 insertions(+), 13 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > > index 67d07b4c778a..1b0ea8593f74 100644
> > > > > > --- a/fs/fuse/dev.c
> > > > > > +++ b/fs/fuse/dev.c
> > > > > > @@ -816,12 +816,13 @@ static int unlock_request(struct fuse_req=
 *req)
> > > > > >     return err;
> > > > > >  }
> > > > > >
> > > > > > -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
> > > > > > -               struct iov_iter *iter)
> > > > > > +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_co=
nn *fc,
> > > > > > +               bool write, struct iov_iter *iter)
> > > > > >  {
> > > > > >     memset(cs, 0, sizeof(*cs));
> > > > > >     cs->write =3D write;
> > > > > >     cs->iter =3D iter;
> > > > > > +   cs->splice_read_user_pages =3D fc->splice_read_user_pages;
> > > > > >  }
> > > > > >
> > > > > >  /* Unmap and put previous page of userspace buffer */
> > > > > > @@ -1105,9 +1106,10 @@ static int fuse_copy_page(struct fuse_co=
py_state *cs, struct page **pagep,
> > > > > >             if (cs->write && cs->pipebufs && page) {
> > > > > >                     /*
> > > > > >                      * Can't control lifetime of pipe buffers, =
so always
> > > > > > -                    * copy user pages.
> > > > > > +                    * copy user pages if server does not suppo=
rt splice
> > > > > > +                    * for reading user pages.
> > > > > >                      */
> > > > > > -                   if (cs->req->args->user_pages) {
> > > > > > +                   if (cs->req->args->user_pages && !cs->splic=
e_read_user_pages) {
> > > > > >                             err =3D fuse_copy_fill(cs);
> > > > > >                             if (err)
> > > > > >                                     return err;
> > > > > > @@ -1538,7 +1540,7 @@ static ssize_t fuse_dev_read(struct kiocb=
 *iocb, struct iov_iter *to)
> > > > > >     if (!user_backed_iter(to))
> > > > > >             return -EINVAL;
> > > > > >
> > > > > > -   fuse_copy_init(&cs, true, to);
> > > > > > +   fuse_copy_init(&cs, fud->fc, true, to);
> > > > > >
> > > > > >     return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to))=
;
> > > > > >  }
> > > > > > @@ -1561,7 +1563,7 @@ static ssize_t fuse_dev_splice_read(struc=
t file *in, loff_t *ppos,
> > > > > >     if (!bufs)
> > > > > >             return -ENOMEM;
> > > > > >
> > > > > > -   fuse_copy_init(&cs, true, NULL);
> > > > > > +   fuse_copy_init(&cs, fud->fc, true, NULL);
> > > > > >     cs.pipebufs =3D bufs;
> > > > > >     cs.pipe =3D pipe;
> > > > > >     ret =3D fuse_dev_do_read(fud, in, &cs, len);
> > > > > > @@ -2227,7 +2229,7 @@ static ssize_t fuse_dev_write(struct kioc=
b *iocb, struct iov_iter *from)
> > > > > >     if (!user_backed_iter(from))
> > > > > >             return -EINVAL;
> > > > > >
> > > > > > -   fuse_copy_init(&cs, false, from);
> > > > > > +   fuse_copy_init(&cs, fud->fc, false, from);
> > > > > >
> > > > > >     return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
> > > > > >  }
> > > > > > @@ -2301,7 +2303,7 @@ static ssize_t fuse_dev_splice_write(stru=
ct pipe_inode_info *pipe,
> > > > > >     }
> > > > > >     pipe_unlock(pipe);
> > > > > >
> > > > > > -   fuse_copy_init(&cs, false, NULL);
> > > > > > +   fuse_copy_init(&cs, fud->fc, false, NULL);
> > > > > >     cs.pipebufs =3D bufs;
> > > > > >     cs.nr_segs =3D nbuf;
> > > > > >     cs.pipe =3D pipe;
> > > > > > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > > > > > index ef470c4a9261..52b883a6a79d 100644
> > > > > > --- a/fs/fuse/dev_uring.c
> > > > > > +++ b/fs/fuse/dev_uring.c
> > > > > > @@ -593,7 +593,7 @@ static int fuse_uring_copy_from_ring(struct=
 fuse_ring *ring,
> > > > > >     if (err)
> > > > > >             return err;
> > > > > >
> > > > > > -   fuse_copy_init(&cs, false, &iter);
> > > > > > +   fuse_copy_init(&cs, ring->fc, false, &iter);
> > > > > >     cs.is_uring =3D true;
> > > > > >     cs.req =3D req;
> > > > > >
> > > > > > @@ -623,7 +623,7 @@ static int fuse_uring_args_to_ring(struct f=
use_ring *ring, struct fuse_req *req,
> > > > > >             return err;
> > > > > >     }
> > > > > >
> > > > > > -   fuse_copy_init(&cs, true, &iter);
> > > > > > +   fuse_copy_init(&cs, ring->fc, true, &iter);
> > > > > >     cs.is_uring =3D true;
> > > > > >     cs.req =3D req;
> > > > > >
> > > > > > diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> > > > > > index db136e045925..25e593e64c67 100644
> > > > > > --- a/fs/fuse/fuse_dev_i.h
> > > > > > +++ b/fs/fuse/fuse_dev_i.h
> > > > > > @@ -32,6 +32,7 @@ struct fuse_copy_state {
> > > > > >     bool write:1;
> > > > > >     bool move_pages:1;
> > > > > >     bool is_uring:1;
> > > > > > +   bool splice_read_user_pages:1;
> > > > > >     struct {
> > > > > >             unsigned int copied_sz; /* copied size into the use=
r buffer */
> > > > > >     } ring;
> > > > > > @@ -51,8 +52,8 @@ struct fuse_req *fuse_request_find(struct fus=
e_pqueue *fpq, u64 unique);
> > > > > >
> > > > > >  void fuse_dev_end_requests(struct list_head *head);
> > > > > >
> > > > > > -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
> > > > > > -                      struct iov_iter *iter);
> > > > > > +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_co=
nn *conn,
> > > > > > +               bool write, struct iov_iter *iter);
> > > > > >  int fuse_copy_args(struct fuse_copy_state *cs, unsigned int nu=
margs,
> > > > > >                unsigned int argpages, struct fuse_arg *args,
> > > > > >                int zeroing);
> > > > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > > > index 3d5289cb82a5..e21875f16220 100644
> > > > > > --- a/fs/fuse/fuse_i.h
> > > > > > +++ b/fs/fuse/fuse_i.h
> > > > > > @@ -898,6 +898,9 @@ struct fuse_conn {
> > > > > >     /* Use io_uring for communication */
> > > > > >     bool io_uring:1;
> > > > > >
> > > > > > +   /* Allow splice for reading user pages */
> > > > > > +   bool splice_read_user_pages:1;
> > > > > > +
> > > > > >     /** Maximum stack depth for passthrough backing files */
> > > > > >     int max_stack_depth;
> > > > > >
> > > > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > > > index 43b6643635ee..e82e96800fde 100644
> > > > > > --- a/fs/fuse/inode.c
> > > > > > +++ b/fs/fuse/inode.c
> > > > > > @@ -1439,6 +1439,9 @@ static void process_init_reply(struct fus=
e_mount *fm, struct fuse_args *args,
> > > > > >
> > > > > >                     if (flags & FUSE_REQUEST_TIMEOUT)
> > > > > >                             timeout =3D arg->request_timeout;
> > > > > > +
> > > > > > +                   if (flags & FUSE_SPLICE_READ_USER_PAGES)
> > > > > > +                           fc->splice_read_user_pages =3D true=
;
> > > > >
> > > > >
> > > > > Shouldn't that check for capable(CAP_SYS_ADMIN)? Isn't the issue
> > > > > that one can access file content although the write is already
> > > > > marked as completed? I.e. a fuse file system might get data
> > > > > it was never exposed to and possibly secret data?
> > > > > A more complex version version could check for CAP_SYS_ADMIN, but
> > > > > also allow later on read/write to files that have the same uid as
> > > > > the fuser-server process?
> > > > >
> > > >
> > > > IDGI. I don't see how this allows the server access to something it
> > > > didn't have access to before.
> > > >
> > > > This patchset seems to be about a "contract" between the kernel and=
 the
> > > > userland server. The server is agreeing to be very careful about no=
t
> > > > touching pages after a write request completes, and the kernel allo=
ws
> > > > splicing the pages if that's the case.
> > > >
> > > > Can you explain the potential attack vector?
> > >
> > > Let's the server claim it does FUSE_SPLICE_READ_USER_PAGES, i.e. clai=
ms
> > > it stops using splice buffers before completing write requests. But t=
hen
> > > it actually first replies to the write and after an arbitrary amount
> > > of time writes out the splice buffer. User application might be using
> > > the buffer it send for write for other things and might not want to
> > > expose that. I.e. application expects that after write(, buf,)
> > > it can use 'buf' for other purposes and that the file system does not
> > > access it anymore once write() is complete. I.e. it can put sensitive
> > > data into the buffer, which it might not want to expose.
> > > From my point of the issue is mainly with allow_other in combination
> > > with "user_allow_other" in libfuse, as root has better ways to access=
 data.
> > >
> >
> > As I understand it, user_allow_other is disabled by default and is
> > only enabled if explicitly opted into by root.
> >
> > It seems to me, philosophically, that if a client chooses to interact
> > with / use a specific fuse mount then it chooses to place its trust in
> > that fuse server and accepts the possible repercussions from any
> > malicious actions the server may take. For example, currently any fuse
> > server right now could choose to deadlock or hang a request which
> > would stall the client indefinitely.
> >
> > Curious to hear if you and Jeff agree or disagree with this.
> >
> >
>
> I'm not sure here -- again FUSE isn't my area of expertise, but
> disclosing potentially private info is generally considered worse than
> a denial of service attack.

In that case then, we should probably just add the CAP_SYS_ADMIN gating.

>
> I wonder whether we could check if there are extra folio refs
> outstanding after the I/O is done?
>
> IOW, get the refcount on the folios you're splicing before you send
> them to userland. After the I/O is done, get their refcounts again and
> see if they have been elevated? If so, then something is probably
> misusing those buffers?

The pages are routed to the server through the pipebuffer, so I don't
think looking at the refcount on those folios gets us anything here.
The only solution here I see is invalidating the page in the pipe
buffer after the server completes the request, so that any subsequent
read attempts on that fd by the server will fail, but I think that
gets ugly with then having to associate pipe buffers with fuse
requests.

For now I'll gate this behind CAP_SYS_ADMIN and in the future if this
needs to be relaxed, we could add that in.

Thanks,
Joanne
> --
> Jeff Layton <jlayton@kernel.org>

