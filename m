Return-Path: <linux-fsdevel+bounces-46998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E641BA973F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 19:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6EA3AAD97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 17:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0491D1E9B20;
	Tue, 22 Apr 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecdb4/cM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B64414C5B0
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344207; cv=none; b=B1+98Fh+TMiuV2/MI31jKqk+S38iF1+DuX8BJSMHzQn+f6uNnEXGGQYxDrk1kDIZKP6B/1P2BCk+9cg7cAAKcL3yvrX1x4Jx4DczCyiRBicBTWOTyIk2O4KH2An5ah3k9uscp6xblRwp1CypXXbPOcXMjNF6cSkZFffBD1D7pbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344207; c=relaxed/simple;
	bh=8Q5YT+74oHnKSpcWkXQvk0c5jRrbtINfggx/DpMVxNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fd1xSI1fg+fqNrCAaFUzjo/i62QmQL6Fih/liTUwxIGulKXpImo3ghGhJdMIgNpKlbLkt3RnmrzKrZF6z1AnNUOIHll2Y/B6Zt/HJVs69A+7gnJaTdRevfFHHuavdZZdM/yNgyAdhSwZHKZnG41MvCgXyiYk9tCbyff6RuLPBd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecdb4/cM; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4774193fdffso76399781cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745344204; x=1745949004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxbOxQqiRUIR2/B4IPV9XvlfZWvD7USTlMOwJjny8AM=;
        b=ecdb4/cModioxbCO7aizhk/Js9YPSNpXFL3ZFajY88CiIT9DEB7R2xt3gYrb221rWf
         +sZVEG2pFCEB1jLikoxex8YZMWrI0EiHCP3HJb6cwUiOz+3HPdpIswgT2k/lJyeBCzMn
         KzGNdTuzjO618aQ+2WRxQiqIBLuW1nM4fC2CZmamxZAQ1stqTGMu21VZ0V0UHBikKdTJ
         F9SYYknXPRr0NmEaqKzdj4NGIk/AV28NwWCdTKWiwNf1oBcrqJx8OqakkO0+DGkAr01g
         5hgm72tC+XTzWsQPVbt7+ioIu1RIpVut9oTGBMFO02oJYinNwR4c2IZIGJNc8at/9HvZ
         msqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745344204; x=1745949004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxbOxQqiRUIR2/B4IPV9XvlfZWvD7USTlMOwJjny8AM=;
        b=TiF5Wygk3kZCRhQRr8hQQSLjsFGdqsdzaEUd8Zx60+MZQ2wUGw4kg9iMBbtkvZkmU+
         YXESuNOY7IdlbsHyJOE4k6PeimEuO3dw/kpayUREiNeCVMWztU/z7jhsJIiq42oNek3K
         rV4xbhdJNFvDGuk4NygjuyFnykJ8vMfW8hAg3tLJvJLyii6hDF96rnFIPCZeWwU57C3E
         Y5XvPHskACUR5/MMvoNrjBgUDOzy7QlJeRpriYinb7/sJVcZoSCjs2VRV3kn+y+diOCL
         6VEEi+XyHk7yIh0h1Agef3bSG7vfFekHEH5v4Wse+ekm9JmkwzL3b56Wc9t18HCUFSMH
         XaLg==
X-Forwarded-Encrypted: i=1; AJvYcCUcvsgFr79Q8NDXv3VSwAxUrdXUuk0cSRZoNI8Vk3MH8FFOH4g553fBOB18O7D9rRM93an7Dk23CGJQZ0mY@vger.kernel.org
X-Gm-Message-State: AOJu0YxNnbPx8ReBk7oMoOHnij/b6J1zXaED8ArZ4ExxaoTlJzDRA91c
	bmqj3ZpPXmq3qcj/SYlcrSABRDzRwn5/ZX5sOt7y9YFjoUzbw5yubFUMKGbbsE6ef1FQENn1XSJ
	DmgVSfaxZLU5WxC+cd0gmDTCCYQw=
X-Gm-Gg: ASbGnctDjvw9lXMY0gkryGeRZwxupxJmWSQGnF9fDNaFHEJPnn8+xgmkXaUHyKPnKju
	7ay8N9doqk5YZz7OY/RSIp9ByHVsgJPuRO9HYTcXaHhKv7gwd5Ncn72EKoV61MduzEtmCmOD2Zx
	9tg6EDW+fGHWCCGwBd17Sl8Aolc5YBbEVbionupg==
X-Google-Smtp-Source: AGHT+IFL6p2N6fYPUyvq9kWwvItvVDacbBr9HojOwerUH1jcge7Aadh9C/mghC0CEFzaYQ49A26c+UVAO/bMjmISN4A=
X-Received: by 2002:ac8:7d03:0:b0:476:739a:5cf3 with SMTP id
 d75a77b69052e-47aec365d2cmr297582101cf.1.1745344204217; Tue, 22 Apr 2025
 10:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419000614.3795331-1-joannelkoong@gmail.com>
 <5332002a-e444-4f62-8217-8d124182290d@fastmail.fm> <26673a5077b148e98a3957532f0cb445aa7ed3c7.camel@kernel.org>
 <a65b5034-2bae-4eec-92e2-3a9ad003b0bb@fastmail.fm> <f83896afdad94014fbf0a4207e6caeb1d8e41cce.camel@kernel.org>
In-Reply-To: <f83896afdad94014fbf0a4207e6caeb1d8e41cce.camel@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 22 Apr 2025 10:49:52 -0700
X-Gm-Features: ATxdqUE_RoM68dY2cMi2LhKtLi3zmvLyB3bk00EKpPSzRFmmGboVwc2fgHqyTPc
Message-ID: <CAJnrk1YKZihzTuh0EpG12PaZ8swrRN1RGOUCKL_LR6Xpv0HbGg@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: use splice for reading user pages on servers
 that enable it
To: Jeff Layton <jlayton@kernel.org>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 4:33=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Mon, 2025-04-21 at 23:38 +0200, Bernd Schubert wrote:
> >
> > On 4/21/25 14:35, Jeff Layton wrote:
> > > On Mon, 2025-04-21 at 13:49 +0200, Bernd Schubert wrote:
> > > >
> > > > On 4/19/25 02:06, Joanne Koong wrote:
> > > > > For direct io writes, splice is disabled when forwarding pages fr=
om the
> > > > > client to the server. This is because the pages in the pipe buffe=
r are
> > > > > user pages, which is controlled by the client. Thus if a server r=
eplies
> > > > > to the request and then keeps accessing the pages afterwards, the=
re is
> > > > > the possibility that the client may have modified the contents of=
 the
> > > > > pages in the meantime. More context on this can be found in commi=
t
> > > > > 0c4bcfdecb1a ("fuse: fix pipe buffer lifetime for direct_io").
> > > > >
> > > > > For servers that do not need to access pages after answering the
> > > > > request, splice gives a non-trivial improvement in performance.
> > > > > Benchmarks show roughly a 40% speedup.
> > > > >
> > > > > Allow servers to enable zero-copy splice for servicing client dir=
ect io
> > > > > writes. By enabling this, the server understands that they should=
 not
> > > > > continue accessing the pipe buffer after completing the request o=
r may
> > > > > face incorrect data if they do so.
> > > > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > ---
> > > > >  fs/fuse/dev.c             | 18 ++++++++++--------
> > > > >  fs/fuse/dev_uring.c       |  4 ++--
> > > > >  fs/fuse/fuse_dev_i.h      |  5 +++--
> > > > >  fs/fuse/fuse_i.h          |  3 +++
> > > > >  fs/fuse/inode.c           |  5 ++++-
> > > > >  include/uapi/linux/fuse.h |  8 ++++++++
> > > > >  6 files changed, 30 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > index 67d07b4c778a..1b0ea8593f74 100644
> > > > > --- a/fs/fuse/dev.c
> > > > > +++ b/fs/fuse/dev.c
> > > > > @@ -816,12 +816,13 @@ static int unlock_request(struct fuse_req *=
req)
> > > > >         return err;
> > > > >  }
> > > > >
> > > > > -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
> > > > > -                   struct iov_iter *iter)
> > > > > +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn=
 *fc,
> > > > > +                   bool write, struct iov_iter *iter)
> > > > >  {
> > > > >         memset(cs, 0, sizeof(*cs));
> > > > >         cs->write =3D write;
> > > > >         cs->iter =3D iter;
> > > > > +       cs->splice_read_user_pages =3D fc->splice_read_user_pages=
;
> > > > >  }
> > > > >
> > > > >  /* Unmap and put previous page of userspace buffer */
> > > > > @@ -1105,9 +1106,10 @@ static int fuse_copy_page(struct fuse_copy=
_state *cs, struct page **pagep,
> > > > >                 if (cs->write && cs->pipebufs && page) {
> > > > >                         /*
> > > > >                          * Can't control lifetime of pipe buffers=
, so always
> > > > > -                        * copy user pages.
> > > > > +                        * copy user pages if server does not sup=
port splice
> > > > > +                        * for reading user pages.
> > > > >                          */
> > > > > -                       if (cs->req->args->user_pages) {
> > > > > +                       if (cs->req->args->user_pages && !cs->spl=
ice_read_user_pages) {
> > > > >                                 err =3D fuse_copy_fill(cs);
> > > > >                                 if (err)
> > > > >                                         return err;
> > > > > @@ -1538,7 +1540,7 @@ static ssize_t fuse_dev_read(struct kiocb *=
iocb, struct iov_iter *to)
> > > > >         if (!user_backed_iter(to))
> > > > >                 return -EINVAL;
> > > > >
> > > > > -       fuse_copy_init(&cs, true, to);
> > > > > +       fuse_copy_init(&cs, fud->fc, true, to);
> > > > >
> > > > >         return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to=
));
> > > > >  }
> > > > > @@ -1561,7 +1563,7 @@ static ssize_t fuse_dev_splice_read(struct =
file *in, loff_t *ppos,
> > > > >         if (!bufs)
> > > > >                 return -ENOMEM;
> > > > >
> > > > > -       fuse_copy_init(&cs, true, NULL);
> > > > > +       fuse_copy_init(&cs, fud->fc, true, NULL);
> > > > >         cs.pipebufs =3D bufs;
> > > > >         cs.pipe =3D pipe;
> > > > >         ret =3D fuse_dev_do_read(fud, in, &cs, len);
> > > > > @@ -2227,7 +2229,7 @@ static ssize_t fuse_dev_write(struct kiocb =
*iocb, struct iov_iter *from)
> > > > >         if (!user_backed_iter(from))
> > > > >                 return -EINVAL;
> > > > >
> > > > > -       fuse_copy_init(&cs, false, from);
> > > > > +       fuse_copy_init(&cs, fud->fc, false, from);
> > > > >
> > > > >         return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
> > > > >  }
> > > > > @@ -2301,7 +2303,7 @@ static ssize_t fuse_dev_splice_write(struct=
 pipe_inode_info *pipe,
> > > > >         }
> > > > >         pipe_unlock(pipe);
> > > > >
> > > > > -       fuse_copy_init(&cs, false, NULL);
> > > > > +       fuse_copy_init(&cs, fud->fc, false, NULL);
> > > > >         cs.pipebufs =3D bufs;
> > > > >         cs.nr_segs =3D nbuf;
> > > > >         cs.pipe =3D pipe;
> > > > > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > > > > index ef470c4a9261..52b883a6a79d 100644
> > > > > --- a/fs/fuse/dev_uring.c
> > > > > +++ b/fs/fuse/dev_uring.c
> > > > > @@ -593,7 +593,7 @@ static int fuse_uring_copy_from_ring(struct f=
use_ring *ring,
> > > > >         if (err)
> > > > >                 return err;
> > > > >
> > > > > -       fuse_copy_init(&cs, false, &iter);
> > > > > +       fuse_copy_init(&cs, ring->fc, false, &iter);
> > > > >         cs.is_uring =3D true;
> > > > >         cs.req =3D req;
> > > > >
> > > > > @@ -623,7 +623,7 @@ static int fuse_uring_args_to_ring(struct fus=
e_ring *ring, struct fuse_req *req,
> > > > >                 return err;
> > > > >         }
> > > > >
> > > > > -       fuse_copy_init(&cs, true, &iter);
> > > > > +       fuse_copy_init(&cs, ring->fc, true, &iter);
> > > > >         cs.is_uring =3D true;
> > > > >         cs.req =3D req;
> > > > >
> > > > > diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> > > > > index db136e045925..25e593e64c67 100644
> > > > > --- a/fs/fuse/fuse_dev_i.h
> > > > > +++ b/fs/fuse/fuse_dev_i.h
> > > > > @@ -32,6 +32,7 @@ struct fuse_copy_state {
> > > > >         bool write:1;
> > > > >         bool move_pages:1;
> > > > >         bool is_uring:1;
> > > > > +       bool splice_read_user_pages:1;
> > > > >         struct {
> > > > >                 unsigned int copied_sz; /* copied size into the u=
ser buffer */
> > > > >         } ring;
> > > > > @@ -51,8 +52,8 @@ struct fuse_req *fuse_request_find(struct fuse_=
pqueue *fpq, u64 unique);
> > > > >
> > > > >  void fuse_dev_end_requests(struct list_head *head);
> > > > >
> > > > > -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
> > > > > -                          struct iov_iter *iter);
> > > > > +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn=
 *conn,
> > > > > +                   bool write, struct iov_iter *iter);
> > > > >  int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numa=
rgs,
> > > > >                    unsigned int argpages, struct fuse_arg *args,
> > > > >                    int zeroing);
> > > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > > index 3d5289cb82a5..e21875f16220 100644
> > > > > --- a/fs/fuse/fuse_i.h
> > > > > +++ b/fs/fuse/fuse_i.h
> > > > > @@ -898,6 +898,9 @@ struct fuse_conn {
> > > > >         /* Use io_uring for communication */
> > > > >         bool io_uring:1;
> > > > >
> > > > > +       /* Allow splice for reading user pages */
> > > > > +       bool splice_read_user_pages:1;
> > > > > +
> > > > >         /** Maximum stack depth for passthrough backing files */
> > > > >         int max_stack_depth;
> > > > >
> > > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > > index 43b6643635ee..e82e96800fde 100644
> > > > > --- a/fs/fuse/inode.c
> > > > > +++ b/fs/fuse/inode.c
> > > > > @@ -1439,6 +1439,9 @@ static void process_init_reply(struct fuse_=
mount *fm, struct fuse_args *args,
> > > > >
> > > > >                         if (flags & FUSE_REQUEST_TIMEOUT)
> > > > >                                 timeout =3D arg->request_timeout;
> > > > > +
> > > > > +                       if (flags & FUSE_SPLICE_READ_USER_PAGES)
> > > > > +                               fc->splice_read_user_pages =3D tr=
ue;
> > > >
> > > >
> > > > Shouldn't that check for capable(CAP_SYS_ADMIN)? Isn't the issue
> > > > that one can access file content although the write is already
> > > > marked as completed? I.e. a fuse file system might get data
> > > > it was never exposed to and possibly secret data?
> > > > A more complex version version could check for CAP_SYS_ADMIN, but
> > > > also allow later on read/write to files that have the same uid as
> > > > the fuser-server process?
> > > >
> > >
> > > IDGI. I don't see how this allows the server access to something it
> > > didn't have access to before.
> > >
> > > This patchset seems to be about a "contract" between the kernel and t=
he
> > > userland server. The server is agreeing to be very careful about not
> > > touching pages after a write request completes, and the kernel allows
> > > splicing the pages if that's the case.
> > >
> > > Can you explain the potential attack vector?
> >
> > Let's the server claim it does FUSE_SPLICE_READ_USER_PAGES, i.e. claims
> > it stops using splice buffers before completing write requests. But the=
n
> > it actually first replies to the write and after an arbitrary amount
> > of time writes out the splice buffer. User application might be using
> > the buffer it send for write for other things and might not want to
> > expose that. I.e. application expects that after write(, buf,)
> > it can use 'buf' for other purposes and that the file system does not
> > access it anymore once write() is complete. I.e. it can put sensitive
> > data into the buffer, which it might not want to expose.
> > From my point of the issue is mainly with allow_other in combination
> > with "user_allow_other" in libfuse, as root has better ways to access d=
ata.
> >
>
> That would definitely break the contract. The question is whether
> that's a security issue. I'm not convinced that it is, given all of the
> other ways you can do nefarious stuff with an unprivileged server.
>
> That said, if there is any question, gating this behind CAP_SYS_ADMIN
> seems like a reasonable thing to do. We could always relax that later
> if we decide that it's a non-issue.

I'm not convinced it is either, especially with allow_other +
user_allow_other needing root privilege to opt into it,  but I also
don't feel strongly enough about it to insist on it and I think it's
better to be safe than sorry. That's a great point about being able to
relax this in the future.

I'll add CAP_SYS_ADMIN gating in v2.


Thanks,
Joanne

>
> --
> Jeff Layton <jlayton@kernel.org>

