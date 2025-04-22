Return-Path: <linux-fsdevel+bounces-46920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D835FA967D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3908188BD41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C4F27CB15;
	Tue, 22 Apr 2025 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujimyuba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0627CB30
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321857; cv=none; b=KCQ07AGHqWTAWwygJLqAbESxuT6L4P7HVPwR/tT4s23bKGfaWEbuhn9ry5wA4Rb/jF486oIDjmKSy72VAfb2yps38rweDhng+L5zFkRKASAVGRHRDdqIbHbv4GPFMiPpqAw+f00qi61DP1M8Hb5a6Zi2dBI5MHqm1Md9b7x3RI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321857; c=relaxed/simple;
	bh=MKcpHV1BthvfXXZ5ZgZUCjy/9Z5ykvflKJedRygyhl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NPGdP2H8J5yRKgW/1hhLF4nEKOT5hMMenZutQG0DZPgofBRzwMzss5r/plWaLe7kfxrE3ZvpWNZ2v9f3IyRvccmZcdNm28qBuVe1m1Sse3dM+t9ddOwt2nlDoSS14RzMs8VSIm+XNsSr4nNNoqOMwLq1R8tF2VDLEYLC5L9ygVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujimyuba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A47C4CEEE;
	Tue, 22 Apr 2025 11:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745321856;
	bh=MKcpHV1BthvfXXZ5ZgZUCjy/9Z5ykvflKJedRygyhl0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UjimyubageCsvC0sfbIc10rShbZeMxhG/i3hqCi7Ig9JRPJ1qHudbZ39lHXCqMXMS
	 eVg2cgDqZ+lTzuSdo8mERgARG9srBwfbHpZ8vXSudGsbuBtGRhEygTrR1Xkh2QyLjS
	 uBZ0bhYB3hBqWlrLFkWcVZdZuEABht8gDl5A8N/MMJJvoVnkcJ0WewR4pxWRJJYRAr
	 rDmGs6vFdEEUBJju3loi61Hdi4exuTebyB0BqbBN5dA6YuvepXerQJBQhZJ1rBQGb8
	 hRQQ041cfBpOr8IEFcePmwgs3KncalSDGey5N8Zvm6UbMaM4L8hqqV80p2tjrle7rO
	 SAutN1cET3VoQ==
Message-ID: <b7034a2d7443c76e1efc90fae9d7b81c80a5c03f.camel@kernel.org>
Subject: Re: [PATCH v1] fuse: use splice for reading user pages on servers
 that enable it
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert
	 <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Date: Tue, 22 Apr 2025 07:37:35 -0400
In-Reply-To: <CAJnrk1bGxhuQRCB_biX52J_rbq8S5tvPQyK-Lf+-nsMRK5OtOg@mail.gmail.com>
References: <20250419000614.3795331-1-joannelkoong@gmail.com>
	 <5332002a-e444-4f62-8217-8d124182290d@fastmail.fm>
	 <26673a5077b148e98a3957532f0cb445aa7ed3c7.camel@kernel.org>
	 <a65b5034-2bae-4eec-92e2-3a9ad003b0bb@fastmail.fm>
	 <CAJnrk1bGxhuQRCB_biX52J_rbq8S5tvPQyK-Lf+-nsMRK5OtOg@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 17:49 -0700, Joanne Koong wrote:
> On Mon, Apr 21, 2025 at 2:38=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >=20
> > On 4/21/25 14:35, Jeff Layton wrote:
> > > On Mon, 2025-04-21 at 13:49 +0200, Bernd Schubert wrote:
> > > >=20
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
> > > > >=20
> > > > > For servers that do not need to access pages after answering the
> > > > > request, splice gives a non-trivial improvement in performance.
> > > > > Benchmarks show roughly a 40% speedup.
> > > > >=20
> > > > > Allow servers to enable zero-copy splice for servicing client dir=
ect io
> > > > > writes. By enabling this, the server understands that they should=
 not
> > > > > continue accessing the pipe buffer after completing the request o=
r may
> > > > > face incorrect data if they do so.
> > > > >=20
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > ---
> > > > >  fs/fuse/dev.c             | 18 ++++++++++--------
> > > > >  fs/fuse/dev_uring.c       |  4 ++--
> > > > >  fs/fuse/fuse_dev_i.h      |  5 +++--
> > > > >  fs/fuse/fuse_i.h          |  3 +++
> > > > >  fs/fuse/inode.c           |  5 ++++-
> > > > >  include/uapi/linux/fuse.h |  8 ++++++++
> > > > >  6 files changed, 30 insertions(+), 13 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > > > index 67d07b4c778a..1b0ea8593f74 100644
> > > > > --- a/fs/fuse/dev.c
> > > > > +++ b/fs/fuse/dev.c
> > > > > @@ -816,12 +816,13 @@ static int unlock_request(struct fuse_req *=
req)
> > > > >     return err;
> > > > >  }
> > > > >=20
> > > > > -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
> > > > > -               struct iov_iter *iter)
> > > > > +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn=
 *fc,
> > > > > +               bool write, struct iov_iter *iter)
> > > > >  {
> > > > >     memset(cs, 0, sizeof(*cs));
> > > > >     cs->write =3D write;
> > > > >     cs->iter =3D iter;
> > > > > +   cs->splice_read_user_pages =3D fc->splice_read_user_pages;
> > > > >  }
> > > > >=20
> > > > >  /* Unmap and put previous page of userspace buffer */
> > > > > @@ -1105,9 +1106,10 @@ static int fuse_copy_page(struct fuse_copy=
_state *cs, struct page **pagep,
> > > > >             if (cs->write && cs->pipebufs && page) {
> > > > >                     /*
> > > > >                      * Can't control lifetime of pipe buffers, so=
 always
> > > > > -                    * copy user pages.
> > > > > +                    * copy user pages if server does not support=
 splice
> > > > > +                    * for reading user pages.
> > > > >                      */
> > > > > -                   if (cs->req->args->user_pages) {
> > > > > +                   if (cs->req->args->user_pages && !cs->splice_=
read_user_pages) {
> > > > >                             err =3D fuse_copy_fill(cs);
> > > > >                             if (err)
> > > > >                                     return err;
> > > > > @@ -1538,7 +1540,7 @@ static ssize_t fuse_dev_read(struct kiocb *=
iocb, struct iov_iter *to)
> > > > >     if (!user_backed_iter(to))
> > > > >             return -EINVAL;
> > > > >=20
> > > > > -   fuse_copy_init(&cs, true, to);
> > > > > +   fuse_copy_init(&cs, fud->fc, true, to);
> > > > >=20
> > > > >     return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to));
> > > > >  }
> > > > > @@ -1561,7 +1563,7 @@ static ssize_t fuse_dev_splice_read(struct =
file *in, loff_t *ppos,
> > > > >     if (!bufs)
> > > > >             return -ENOMEM;
> > > > >=20
> > > > > -   fuse_copy_init(&cs, true, NULL);
> > > > > +   fuse_copy_init(&cs, fud->fc, true, NULL);
> > > > >     cs.pipebufs =3D bufs;
> > > > >     cs.pipe =3D pipe;
> > > > >     ret =3D fuse_dev_do_read(fud, in, &cs, len);
> > > > > @@ -2227,7 +2229,7 @@ static ssize_t fuse_dev_write(struct kiocb =
*iocb, struct iov_iter *from)
> > > > >     if (!user_backed_iter(from))
> > > > >             return -EINVAL;
> > > > >=20
> > > > > -   fuse_copy_init(&cs, false, from);
> > > > > +   fuse_copy_init(&cs, fud->fc, false, from);
> > > > >=20
> > > > >     return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
> > > > >  }
> > > > > @@ -2301,7 +2303,7 @@ static ssize_t fuse_dev_splice_write(struct=
 pipe_inode_info *pipe,
> > > > >     }
> > > > >     pipe_unlock(pipe);
> > > > >=20
> > > > > -   fuse_copy_init(&cs, false, NULL);
> > > > > +   fuse_copy_init(&cs, fud->fc, false, NULL);
> > > > >     cs.pipebufs =3D bufs;
> > > > >     cs.nr_segs =3D nbuf;
> > > > >     cs.pipe =3D pipe;
> > > > > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > > > > index ef470c4a9261..52b883a6a79d 100644
> > > > > --- a/fs/fuse/dev_uring.c
> > > > > +++ b/fs/fuse/dev_uring.c
> > > > > @@ -593,7 +593,7 @@ static int fuse_uring_copy_from_ring(struct f=
use_ring *ring,
> > > > >     if (err)
> > > > >             return err;
> > > > >=20
> > > > > -   fuse_copy_init(&cs, false, &iter);
> > > > > +   fuse_copy_init(&cs, ring->fc, false, &iter);
> > > > >     cs.is_uring =3D true;
> > > > >     cs.req =3D req;
> > > > >=20
> > > > > @@ -623,7 +623,7 @@ static int fuse_uring_args_to_ring(struct fus=
e_ring *ring, struct fuse_req *req,
> > > > >             return err;
> > > > >     }
> > > > >=20
> > > > > -   fuse_copy_init(&cs, true, &iter);
> > > > > +   fuse_copy_init(&cs, ring->fc, true, &iter);
> > > > >     cs.is_uring =3D true;
> > > > >     cs.req =3D req;
> > > > >=20
> > > > > diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> > > > > index db136e045925..25e593e64c67 100644
> > > > > --- a/fs/fuse/fuse_dev_i.h
> > > > > +++ b/fs/fuse/fuse_dev_i.h
> > > > > @@ -32,6 +32,7 @@ struct fuse_copy_state {
> > > > >     bool write:1;
> > > > >     bool move_pages:1;
> > > > >     bool is_uring:1;
> > > > > +   bool splice_read_user_pages:1;
> > > > >     struct {
> > > > >             unsigned int copied_sz; /* copied size into the user =
buffer */
> > > > >     } ring;
> > > > > @@ -51,8 +52,8 @@ struct fuse_req *fuse_request_find(struct fuse_=
pqueue *fpq, u64 unique);
> > > > >=20
> > > > >  void fuse_dev_end_requests(struct list_head *head);
> > > > >=20
> > > > > -void fuse_copy_init(struct fuse_copy_state *cs, bool write,
> > > > > -                      struct iov_iter *iter);
> > > > > +void fuse_copy_init(struct fuse_copy_state *cs, struct fuse_conn=
 *conn,
> > > > > +               bool write, struct iov_iter *iter);
> > > > >  int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numa=
rgs,
> > > > >                unsigned int argpages, struct fuse_arg *args,
> > > > >                int zeroing);
> > > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > > index 3d5289cb82a5..e21875f16220 100644
> > > > > --- a/fs/fuse/fuse_i.h
> > > > > +++ b/fs/fuse/fuse_i.h
> > > > > @@ -898,6 +898,9 @@ struct fuse_conn {
> > > > >     /* Use io_uring for communication */
> > > > >     bool io_uring:1;
> > > > >=20
> > > > > +   /* Allow splice for reading user pages */
> > > > > +   bool splice_read_user_pages:1;
> > > > > +
> > > > >     /** Maximum stack depth for passthrough backing files */
> > > > >     int max_stack_depth;
> > > > >=20
> > > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > > index 43b6643635ee..e82e96800fde 100644
> > > > > --- a/fs/fuse/inode.c
> > > > > +++ b/fs/fuse/inode.c
> > > > > @@ -1439,6 +1439,9 @@ static void process_init_reply(struct fuse_=
mount *fm, struct fuse_args *args,
> > > > >=20
> > > > >                     if (flags & FUSE_REQUEST_TIMEOUT)
> > > > >                             timeout =3D arg->request_timeout;
> > > > > +
> > > > > +                   if (flags & FUSE_SPLICE_READ_USER_PAGES)
> > > > > +                           fc->splice_read_user_pages =3D true;
> > > >=20
> > > >=20
> > > > Shouldn't that check for capable(CAP_SYS_ADMIN)? Isn't the issue
> > > > that one can access file content although the write is already
> > > > marked as completed? I.e. a fuse file system might get data
> > > > it was never exposed to and possibly secret data?
> > > > A more complex version version could check for CAP_SYS_ADMIN, but
> > > > also allow later on read/write to files that have the same uid as
> > > > the fuser-server process?
> > > >=20
> > >=20
> > > IDGI. I don't see how this allows the server access to something it
> > > didn't have access to before.
> > >=20
> > > This patchset seems to be about a "contract" between the kernel and t=
he
> > > userland server. The server is agreeing to be very careful about not
> > > touching pages after a write request completes, and the kernel allows
> > > splicing the pages if that's the case.
> > >=20
> > > Can you explain the potential attack vector?
> >=20
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
> >=20
>=20
> As I understand it, user_allow_other is disabled by default and is
> only enabled if explicitly opted into by root.
>=20
> It seems to me, philosophically, that if a client chooses to interact
> with / use a specific fuse mount then it chooses to place its trust in
> that fuse server and accepts the possible repercussions from any
> malicious actions the server may take. For example, currently any fuse
> server right now could choose to deadlock or hang a request which
> would stall the client indefinitely.
>=20
> Curious to hear if you and Jeff agree or disagree with this.
>=20
>=20

I'm not sure here -- again FUSE isn't my area of expertise, but
disclosing potentially private info is generally considered worse than
a denial of service attack.

I wonder whether we could check if there are extra folio refs
outstanding after the I/O is done?

IOW, get the refcount on the folios you're splicing before you send
them to userland. After the I/O is done, get their refcounts again and
see if they have been elevated? If so, then something is probably
misusing those buffers?
--=20
Jeff Layton <jlayton@kernel.org>

