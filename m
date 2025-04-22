Return-Path: <linux-fsdevel+bounces-46862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E48A95A42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 02:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96A37A7853
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA6E14386D;
	Tue, 22 Apr 2025 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnZmT+Jc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81C282F0
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745283010; cv=none; b=ViX1XAZjej3WbX7KeZ1GCBU8DJ4724AlAml4OmLONUSpU2TZGGw9U+Ns5VkVGVl8/PdGbUVPfG2xjYISkeVuqpt9jeZe2fRZejn01G3wAMZiCpDtzPlKAXMMuUdu6vR4dACSZTrHt/6qhYaO3KMSQPhEeCqQQAAqEaDH6bCuLGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745283010; c=relaxed/simple;
	bh=Z1IkgZpkLQVAwv3geQiL8ysl6dOE5s/fLNRUUzxRfis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jw8DxUVolNZ5CQgU2ZJugRXfd7XKrNLvKNDshzjaJf0r7suqLtwy1dsGWUhx83ccXolGgKRBQqhc6QW9zP27ENfCrp2D6wKs9MheYl1EZhJHeyRFSGzkMs4nnib6TnLwcFztX05YL9U6fV27Y5oJ7KTcJzHPEQD/IXxBG4QphPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnZmT+Jc; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476b4c9faa2so58784121cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 17:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745283008; x=1745887808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZK3xriMBBPNg0TTnKlbbMy7FsQE3vShY24rH/8DlgU=;
        b=RnZmT+JcW66pHegbD54cQipvsCiPXvLyJcxLYfeecpdG9GXGAYgdDsFKyTwG8Xp3Ac
         2QE44CjFpmXRhSJ5oT2jLu0lyHBEItDlOsxOYRcZQ55F1AQSVkvMsLSfMYYANiV3MTpa
         oNckrLSXPh9jHrKWczQfXZGnei5YQn52v1vCRctlRb9t4qjZa1MDcF5NH+hKpoYDbiMG
         eD4uaY6tk0oGFdv1nC3mP3vHrGW1aQgMIr9PwrBVb6Uz2244Rl6KcI4RnBigltfN4kOg
         8xERM+56yl0JJ/5HAM7oxR7nKGJSc4On83+TRbyY/Fi+gagY4mdbQeJWXVQJ/amzXrSM
         oWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745283008; x=1745887808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZK3xriMBBPNg0TTnKlbbMy7FsQE3vShY24rH/8DlgU=;
        b=n49zwHDaLb+BfWPNrW2sV4EBIlJdPhxFCELhON4DwQMZM6i645soJ8s5pyhrk6ZIDp
         +PNQJz6baLuW124DPWsQZxv1ywNZKIoQ+i9vFLA2yTAh5B0d5wT/yF7K2kW4Xu4KxgBf
         k+I9Ac9BgNgsn2M+wftbYAzrWCFTqZ3IlDvQNUltLRaRHlD3Sib1X3O088pquPsGx/en
         AS/MKNPjX3nf58rdu5heuJ0DTZTL2FzyzIv3duEWym9LNWiCuJt+SuyYz98oTNPClPqa
         oI1unv/kTj6iOD9gkjkUkPFlGZ+t8RRnlTd4MJNemLxrS11dIedCIGkr5E7k0CuiDyOV
         zxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvf8o8CFYTNXuab5WNCPNm1DWDULd+XtzvKtRshgRRYHvhotytDC2IXeJkL/uK2LX/KqhG8w1MuM1lbsx1@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJtVEh8erevngXA/j8aLWlt3Y6RswU48DWJeqMknkOPLe5cy8
	qc2tPtfdL145lwPYAj0Ji8lZfnO7xaWuvUjnMaM/KCOVidHLQw7Nn2rjLRyufyzAULmTw29G3iZ
	yT+qv3yLoyDCIMinVeqssFxTkVlc=
X-Gm-Gg: ASbGncvmJef6ECEzmL+DT2oA/w8sNJWsDuxnrJifhV2tw+uTWO/rNQv2ze1gADUMSFL
	NwZ5CWwb/v9OX+Nk1p4pu893hdzGmzZEIloAqcO8K54KGqzwrIKQlD4LoFYJWiUBku9bRpdnmgI
	2055IU7u3tG/XhCBxOkC0S6e1tPgKZHpo0B7ukVg==
X-Google-Smtp-Source: AGHT+IHsPdyLYIqA4FKMXal3DcjlWjlzH5dnaY5RJ7NbfpKI5Dai9Lq0pdAYyp8IsDua+MrP/Dc2cMK+NWpMOSe8ZWM=
X-Received: by 2002:ac8:5dcb:0:b0:476:a03b:96e1 with SMTP id
 d75a77b69052e-47aec4c681bmr247664851cf.52.1745283007527; Mon, 21 Apr 2025
 17:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419000614.3795331-1-joannelkoong@gmail.com>
 <5332002a-e444-4f62-8217-8d124182290d@fastmail.fm> <26673a5077b148e98a3957532f0cb445aa7ed3c7.camel@kernel.org>
 <a65b5034-2bae-4eec-92e2-3a9ad003b0bb@fastmail.fm>
In-Reply-To: <a65b5034-2bae-4eec-92e2-3a9ad003b0bb@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 21 Apr 2025 17:49:56 -0700
X-Gm-Features: ATxdqUHBcbhrZBbTzKCTQemv3-fPOyUsV-cQlGRsDkiHqIabEdGON1ZigFoUo2s
Message-ID: <CAJnrk1bGxhuQRCB_biX52J_rbq8S5tvPQyK-Lf+-nsMRK5OtOg@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: use splice for reading user pages on servers
 that enable it
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:38=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 4/21/25 14:35, Jeff Layton wrote:
> > On Mon, 2025-04-21 at 13:49 +0200, Bernd Schubert wrote:
> >>
> >> On 4/19/25 02:06, Joanne Koong wrote:
> >>> For direct io writes, splice is disabled when forwarding pages from t=
he
> >>> client to the server. This is because the pages in the pipe buffer ar=
e
> >>> user pages, which is controlled by the client. Thus if a server repli=
es
> >>> to the request and then keeps accessing the pages afterwards, there i=
s
> >>> the possibility that the client may have modified the contents of the
> >>> pages in the meantime. More context on this can be found in commit
> >>> 0c4bcfdecb1a ("fuse: fix pipe buffer lifetime for direct_io").
> >>>
> >>> For servers that do not need to access pages after answering the
> >>> request, splice gives a non-trivial improvement in performance.
> >>> Benchmarks show roughly a 40% speedup.
> >>>
> >>> Allow servers to enable zero-copy splice for servicing client direct =
io
> >>> writes. By enabling this, the server understands that they should not
> >>> continue accessing the pipe buffer after completing the request or ma=
y
> >>> face incorrect data if they do so.
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> ---
> >>>  fs/fuse/dev.c             | 18 ++++++++++--------
> >>>  fs/fuse/dev_uring.c       |  4 ++--
> >>>  fs/fuse/fuse_dev_i.h      |  5 +++--
> >>>  fs/fuse/fuse_i.h          |  3 +++
> >>>  fs/fuse/inode.c           |  5 ++++-
> >>>  include/uapi/linux/fuse.h |  8 ++++++++
> >>>  6 files changed, 30 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >>> index 67d07b4c778a..1b0ea8593f74 100644
> >>> --- a/fs/fuse/dev.c
> >>> +++ b/fs/fuse/dev.c
> >>> @@ -816,12 +816,13 @@ static int unlock_request(struct fuse_req *req)
> >>>     return err;
> >>>  }
> >>>
> >>> -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
> >>> -               struct iov_iter *iter)
> >>> +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn *fc=
,
> >>> +               bool write, struct iov_iter *iter)
> >>>  {
> >>>     memset(cs, 0, sizeof(*cs));
> >>>     cs->write =3D write;
> >>>     cs->iter =3D iter;
> >>> +   cs->splice_read_user_pages =3D fc->splice_read_user_pages;
> >>>  }
> >>>
> >>>  /* Unmap and put previous page of userspace buffer */
> >>> @@ -1105,9 +1106,10 @@ static int fuse_copy_page(struct fuse_copy_sta=
te *cs, struct page **pagep,
> >>>             if (cs->write && cs->pipebufs && page) {
> >>>                     /*
> >>>                      * Can't control lifetime of pipe buffers, so alw=
ays
> >>> -                    * copy user pages.
> >>> +                    * copy user pages if server does not support spl=
ice
> >>> +                    * for reading user pages.
> >>>                      */
> >>> -                   if (cs->req->args->user_pages) {
> >>> +                   if (cs->req->args->user_pages && !cs->splice_read=
_user_pages) {
> >>>                             err =3D fuse_copy_fill(cs);
> >>>                             if (err)
> >>>                                     return err;
> >>> @@ -1538,7 +1540,7 @@ static ssize_t fuse_dev_read(struct kiocb *iocb=
, struct iov_iter *to)
> >>>     if (!user_backed_iter(to))
> >>>             return -EINVAL;
> >>>
> >>> -   fuse_copy_init(&cs, true, to);
> >>> +   fuse_copy_init(&cs, fud->fc, true, to);
> >>>
> >>>     return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to));
> >>>  }
> >>> @@ -1561,7 +1563,7 @@ static ssize_t fuse_dev_splice_read(struct file=
 *in, loff_t *ppos,
> >>>     if (!bufs)
> >>>             return -ENOMEM;
> >>>
> >>> -   fuse_copy_init(&cs, true, NULL);
> >>> +   fuse_copy_init(&cs, fud->fc, true, NULL);
> >>>     cs.pipebufs =3D bufs;
> >>>     cs.pipe =3D pipe;
> >>>     ret =3D fuse_dev_do_read(fud, in, &cs, len);
> >>> @@ -2227,7 +2229,7 @@ static ssize_t fuse_dev_write(struct kiocb *ioc=
b, struct iov_iter *from)
> >>>     if (!user_backed_iter(from))
> >>>             return -EINVAL;
> >>>
> >>> -   fuse_copy_init(&cs, false, from);
> >>> +   fuse_copy_init(&cs, fud->fc, false, from);
> >>>
> >>>     return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
> >>>  }
> >>> @@ -2301,7 +2303,7 @@ static ssize_t fuse_dev_splice_write(struct pip=
e_inode_info *pipe,
> >>>     }
> >>>     pipe_unlock(pipe);
> >>>
> >>> -   fuse_copy_init(&cs, false, NULL);
> >>> +   fuse_copy_init(&cs, fud->fc, false, NULL);
> >>>     cs.pipebufs =3D bufs;
> >>>     cs.nr_segs =3D nbuf;
> >>>     cs.pipe =3D pipe;
> >>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >>> index ef470c4a9261..52b883a6a79d 100644
> >>> --- a/fs/fuse/dev_uring.c
> >>> +++ b/fs/fuse/dev_uring.c
> >>> @@ -593,7 +593,7 @@ static int fuse_uring_copy_from_ring(struct fuse_=
ring *ring,
> >>>     if (err)
> >>>             return err;
> >>>
> >>> -   fuse_copy_init(&cs, false, &iter);
> >>> +   fuse_copy_init(&cs, ring->fc, false, &iter);
> >>>     cs.is_uring =3D true;
> >>>     cs.req =3D req;
> >>>
> >>> @@ -623,7 +623,7 @@ static int fuse_uring_args_to_ring(struct fuse_ri=
ng *ring, struct fuse_req *req,
> >>>             return err;
> >>>     }
> >>>
> >>> -   fuse_copy_init(&cs, true, &iter);
> >>> +   fuse_copy_init(&cs, ring->fc, true, &iter);
> >>>     cs.is_uring =3D true;
> >>>     cs.req =3D req;
> >>>
> >>> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> >>> index db136e045925..25e593e64c67 100644
> >>> --- a/fs/fuse/fuse_dev_i.h
> >>> +++ b/fs/fuse/fuse_dev_i.h
> >>> @@ -32,6 +32,7 @@ struct fuse_copy_state {
> >>>     bool write:1;
> >>>     bool move_pages:1;
> >>>     bool is_uring:1;
> >>> +   bool splice_read_user_pages:1;
> >>>     struct {
> >>>             unsigned int copied_sz; /* copied size into the user buff=
er */
> >>>     } ring;
> >>> @@ -51,8 +52,8 @@ struct fuse_req *fuse_request_find(struct fuse_pque=
ue *fpq, u64 unique);
> >>>
> >>>  void fuse_dev_end_requests(struct list_head *head);
> >>>
> >>> -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
> >>> -                      struct iov_iter *iter);
> >>> +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn *co=
nn,
> >>> +               bool write, struct iov_iter *iter);
> >>>  int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
> >>>                unsigned int argpages, struct fuse_arg *args,
> >>>                int zeroing);
> >>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> >>> index 3d5289cb82a5..e21875f16220 100644
> >>> --- a/fs/fuse/fuse_i.h
> >>> +++ b/fs/fuse/fuse_i.h
> >>> @@ -898,6 +898,9 @@ struct fuse_conn {
> >>>     /* Use io_uring for communication */
> >>>     bool io_uring:1;
> >>>
> >>> +   /* Allow splice for reading user pages */
> >>> +   bool splice_read_user_pages:1;
> >>> +
> >>>     /** Maximum stack depth for passthrough backing files */
> >>>     int max_stack_depth;
> >>>
> >>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >>> index 43b6643635ee..e82e96800fde 100644
> >>> --- a/fs/fuse/inode.c
> >>> +++ b/fs/fuse/inode.c
> >>> @@ -1439,6 +1439,9 @@ static void process_init_reply(struct fuse_moun=
t *fm, struct fuse_args *args,
> >>>
> >>>                     if (flags & FUSE_REQUEST_TIMEOUT)
> >>>                             timeout =3D arg->request_timeout;
> >>> +
> >>> +                   if (flags & FUSE_SPLICE_READ_USER_PAGES)
> >>> +                           fc->splice_read_user_pages =3D true;
> >>
> >>
> >> Shouldn't that check for capable(CAP_SYS_ADMIN)? Isn't the issue
> >> that one can access file content although the write is already
> >> marked as completed? I.e. a fuse file system might get data
> >> it was never exposed to and possibly secret data?
> >> A more complex version version could check for CAP_SYS_ADMIN, but
> >> also allow later on read/write to files that have the same uid as
> >> the fuser-server process?
> >>
> >
> > IDGI. I don't see how this allows the server access to something it
> > didn't have access to before.
> >
> > This patchset seems to be about a "contract" between the kernel and the
> > userland server. The server is agreeing to be very careful about not
> > touching pages after a write request completes, and the kernel allows
> > splicing the pages if that's the case.
> >
> > Can you explain the potential attack vector?
>
> Let's the server claim it does FUSE_SPLICE_READ_USER_PAGES, i.e. claims
> it stops using splice buffers before completing write requests. But then
> it actually first replies to the write and after an arbitrary amount
> of time writes out the splice buffer. User application might be using
> the buffer it send for write for other things and might not want to
> expose that. I.e. application expects that after write(, buf,)
> it can use 'buf' for other purposes and that the file system does not
> access it anymore once write() is complete. I.e. it can put sensitive
> data into the buffer, which it might not want to expose.
> From my point of the issue is mainly with allow_other in combination
> with "user_allow_other" in libfuse, as root has better ways to access dat=
a.
>

As I understand it, user_allow_other is disabled by default and is
only enabled if explicitly opted into by root.

It seems to me, philosophically, that if a client chooses to interact
with / use a specific fuse mount then it chooses to place its trust in
that fuse server and accepts the possible repercussions from any
malicious actions the server may take. For example, currently any fuse
server right now could choose to deadlock or hang a request which
would stall the client indefinitely.

Curious to hear if you and Jeff agree or disagree with this.

Thanks,
Joanne
>
> Thanks,
> Bernd
>

