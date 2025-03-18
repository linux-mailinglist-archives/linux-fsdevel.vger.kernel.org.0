Return-Path: <linux-fsdevel+bounces-44231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D46A6644B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 01:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9F91898097
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 00:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8E6148857;
	Tue, 18 Mar 2025 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqZyKT61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76414375D
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259335; cv=none; b=p5fd4tfH8n3/HgZe7s/S333ozDOFQgbYPORAlqF5bgRfueUHXaae2necLLInzTfhR63irXYhGlOuaAsxc5YVfBvkMGgriB8x88vJElotZXl5vzMxnLSSCiVxpxCE1dqkbUraMlFGKTtAtBQsXaZz3GgN/RhB+OwDKFZbBlVv/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259335; c=relaxed/simple;
	bh=lVPe8SpWl1/gLh9ETzFlpfyU2XRyif9eLZDVUimXibI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPTnBeFz623KyywfayDaQcfZsheFwoP5hVxEV8nb1LE8DIT1hn5Wy4QmfqNPpe5U6CXc+eEil2ya44bdFFnu3KW1pLHu4t7i6TzagG5middtopL145zT5c+0AflcypoGEkX+50rO+05TKF2cz2SmUm1g+yqIsG4axEIuZzcOxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqZyKT61; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47662449055so24694501cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 17:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742259332; x=1742864132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZCmsUqdgHopyfO2KHj6PebGnOMj9HOVxcV4wMd5PnE=;
        b=XqZyKT61g8I+IVVNzrPazw9GZRy9cMjf2/kR7IJes3mP/lGjdBLYkV4pN28jXZoOMn
         wiFoWodWHguE+/97sKeHl2bAs4JikR9M5JD0ualTlFeI69Ncb6ssSynu3nkOYgP0HBJg
         es/OrVARfjx8yZ/iEOHHftjcvCWUC4vPeC8aen1BtuDLbJK/D0gdazmGe5CuqzAoHEuz
         xhDi8t/J+9hutcJrAMVoDCfbWG5DEqf1G5eJPO89QGObaEVICOas8CtJPbH3+Px2xO/F
         xvKI9c8WgtvDlSeAr7mTBmjABRlmxAjLvmIdj43Ly9T/6/bgRS6ge3suk9aNVea+3AyX
         dVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742259332; x=1742864132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZCmsUqdgHopyfO2KHj6PebGnOMj9HOVxcV4wMd5PnE=;
        b=aJN0waV40GQ+u14xO8Rx8anFXro3o6surkBcoP9eXv1fvW6/0ohBRSmKmBaVjNsVqr
         lpDE2Brz9v0t71iSsqKMlNngzRmxVXpSI1TOmBd3opF1SGruUap6/GqBgNVVBHmwBrWn
         +aaXaM/RgNAjLAVC8nQI6OxyPUoUWVVkTCP+jmM2KcyxeROJXyC4HjwmV1URIvKgxD2n
         v1tnSBUtdZuJcwQJRwU4k49/6eB93c4gEAkru39Hi3aKVYFcisPAxDADW1cqJTwJvwtb
         QVpiX5LXxhHAEqhIvvh5GKU3DwvTuHQQ+SL9fOegtD6moA739467g631clRn/3ol/Pt6
         4NZg==
X-Forwarded-Encrypted: i=1; AJvYcCUN0mWqXPvCgVK3Q5WJ9yHnID7nGA1ceqRQQmmL7ZX/MtgAgjAomaHdt1wADdXJJbIvyG4zP8G8IFz3RO9s@vger.kernel.org
X-Gm-Message-State: AOJu0YyGRPRaOu7/usleu+BAO9SYNopGjdzQaeM4QOVOxvLmNpAStaal
	S18SgME+8XOWwG3PE9Olve+cPPAIwLnw0epCmzmUtS1dMr1zcAKDxQbyQyLBz2UZOEfiT1SV8qw
	lUOrt4uELC+/rTbOdWVa1EKquH7A=
X-Gm-Gg: ASbGnctljlivZlRPErKJFsbcTIEh4pgsKkpRAWldGN7h6HluttPrzZLZNcAzeh1JSW1
	S2RXdOcnGoI9uvmR95hEx/Tdm4scQTeF9ha5OyeyfpAQ2qm5udpE1+2DDK3qusF6HBTF/kgxZPd
	Evy1a/ay04qjqCFCsMMuRoKS/ZrTHCD+0RYA9tlDDjDA==
X-Google-Smtp-Source: AGHT+IHB/j+67TS7AialBef6rH00eAr3f1WCHA+uHh3WfmN30sJuS8pVnvddbhL1TvmTJAhAFSrr3KdWh/BF7mPsWLo=
X-Received: by 2002:a05:622a:255:b0:476:80b3:ee with SMTP id
 d75a77b69052e-476c811efb0mr190484661cf.6.1742259331665; Mon, 17 Mar 2025
 17:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314204437.726538-1-joannelkoong@gmail.com> <8aca27b0-609b-44c4-90ff-314e3c086b90@fastmail.fm>
In-Reply-To: <8aca27b0-609b-44c4-90ff-314e3c086b90@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 17 Mar 2025 17:55:20 -0700
X-Gm-Features: AQ5f1Jqf7S7MdXbFDK6-BjrbPgBkq4nnrTD9BfTCb1z6_5CXwLwOn9YsqDjVRlM
Message-ID: <CAJnrk1YoN6gayDQ6hBMa9NnxgkOpf9qYmMRg9kP=2iQR9_B8Ew@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: support configurable number of uring queues
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,
Thanks for the quick turnaround on the review!

On Fri, Mar 14, 2025 at 4:11=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Thanks Joanne! That is rather close to what I wanted to add,
> just a few comments.
>
> On 3/14/25 21:44, Joanne Koong wrote:
> > In the current uring design, the number of queues is equal to the numbe=
r
> > of cores on a system. However, on high-scale machines where there are
> > hundreds of cores, having such a high number of queues is often
> > overkill and resource-intensive. As well, in the current design where
> > the queue for the request is set to the cpu the task is currently
> > executing on (see fuse_uring_task_to_queue()), there is no guarantee
> > that requests for the same file will be sent to the same queue (eg if a
> > task is preempted and moved to a different cpu) which may be problemati=
c
> > for some servers (eg if the server is append-only and does not support
> > unordered writes).
> >
> > In this commit, the server can configure the number of uring queues
> > (passed to the kernel through the init reply). The number of queues mus=
t
> > be a power of two, in order to make queue assignment for a request
> > efficient. If the server specifies a non-power of two, then it will be
> > automatically rounded down to the nearest power of two. If the server
> > does not specify the number of queues, then this will automatically
> > default to the current behavior where the number of queues will be equa=
l
> > to the number of cores with core and numa affinity. The queue id hash
> > is computed on the nodeid, which ensures that requests for the same fil=
e
> > will be forwarded to the same queue.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev_uring.c       | 48 +++++++++++++++++++++++++++++++++++----
> >  fs/fuse/dev_uring_i.h     | 11 +++++++++
> >  fs/fuse/fuse_i.h          |  1 +
> >  fs/fuse/inode.c           |  4 +++-
> >  include/uapi/linux/fuse.h |  6 ++++-
> >  5 files changed, 63 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 64f1ae308dc4..f173f9e451ac 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -209,9 +209,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
> >  static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
> >  {
> >       struct fuse_ring *ring;
> > -     size_t nr_queues =3D num_possible_cpus();
> > +     size_t nr_queues =3D fc->uring_nr_queues;
> >       struct fuse_ring *res =3D NULL;
> >       size_t max_payload_size;
> > +     unsigned int nr_cpus =3D num_possible_cpus();
> >
> >       ring =3D kzalloc(sizeof(*fc->ring), GFP_KERNEL_ACCOUNT);
> >       if (!ring)
> > @@ -237,6 +238,13 @@ static struct fuse_ring *fuse_uring_create(struct =
fuse_conn *fc)
> >
> >       fc->ring =3D ring;
> >       ring->nr_queues =3D nr_queues;
> > +     if (nr_queues =3D=3D nr_cpus) {
> > +             ring->core_affinity =3D 1;
> > +     } else {
> > +             WARN_ON(!nr_queues || nr_queues > nr_cpus ||
> > +                     !is_power_of_2(nr_queues));
> > +             ring->qid_hash_bits =3D ilog2(nr_queues);
> > +     }
> >       ring->fc =3D fc;
> >       ring->max_payload_sz =3D max_payload_size;
> >       atomic_set(&ring->queue_refs, 0);
> > @@ -1217,12 +1225,24 @@ static void fuse_uring_send_in_task(struct io_u=
ring_cmd *cmd,
> >       fuse_uring_send(ent, cmd, err, issue_flags);
> >  }
> >
> > -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ri=
ng *ring)
> > +static unsigned int hash_qid(struct fuse_ring *ring, u64 nodeid)
> > +{
> > +     if (ring->nr_queues =3D=3D 1)
> > +             return 0;
> > +
> > +     return hash_long(nodeid, ring->qid_hash_bits);
> > +}
> > +
> > +static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ri=
ng *ring,
> > +                                                     struct fuse_req *=
req)
> >  {
> >       unsigned int qid;
> >       struct fuse_ring_queue *queue;
> >
> > -     qid =3D task_cpu(current);
> > +     if (ring->core_affinity)
> > +             qid =3D task_cpu(current);
> > +     else
> > +             qid =3D hash_qid(ring, req->in.h.nodeid);
>
> I think we need to handle numa affinity.
>

Could you elaborate more on this? I'm not too familiar with how to
enforce this in practice. As I understand it, the main goal of numa
affinity is to make sure processes access memory that's physically
closer to the CPU it's executing on. How does this usually get
enforced at the kernel level?

> >
> >       if (WARN_ONCE(qid >=3D ring->nr_queues,
> >                     "Core number (%u) exceeds nr queues (%zu)\n", qid,
> > @@ -1253,7 +1273,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue=
 *fiq, struct fuse_req *req)
> >       int err;
> >
> >       err =3D -EINVAL;
> > -     queue =3D fuse_uring_task_to_queue(ring);
> > +     queue =3D fuse_uring_task_to_queue(ring, req);
> >       if (!queue)
> >               goto err;
> >
> > @@ -1293,7 +1313,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req=
)
> >       struct fuse_ring_queue *queue;
> >       struct fuse_ring_ent *ent =3D NULL;
> >
> > -     queue =3D fuse_uring_task_to_queue(ring);
> > +     queue =3D fuse_uring_task_to_queue(ring, req);
> >       if (!queue)
> >               return false;
> >
> > @@ -1344,3 +1364,21 @@ static const struct fuse_iqueue_ops fuse_io_urin=
g_ops =3D {
> >       .send_interrupt =3D fuse_dev_queue_interrupt,
> >       .send_req =3D fuse_uring_queue_fuse_req,
> >  };
> > +
> > +void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_qu=
eues)
> > +{
> > +     if (!nr_queues) {
> > +             fc->uring_nr_queues =3D num_possible_cpus();
> > +             return;
> > +     }
> > +
> > +     if (!is_power_of_2(nr_queues)) {
> > +             unsigned int old_nr_queues =3D nr_queues;
> > +
> > +             nr_queues =3D rounddown_pow_of_two(nr_queues);
> > +             pr_debug("init: uring_nr_queues=3D%u is not a power of 2.=
 "
> > +                      "Rounding down uring_nr_queues to %u\n",
> > +                      old_nr_queues, nr_queues);
> > +     }
> > +     fc->uring_nr_queues =3D min(nr_queues, num_possible_cpus());
> > +}
> > diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> > index ce823c6b1806..81398b5b8bf2 100644
> > --- a/fs/fuse/dev_uring_i.h
> > +++ b/fs/fuse/dev_uring_i.h
> > @@ -122,6 +122,12 @@ struct fuse_ring {
> >        */
> >       unsigned int stop_debug_log : 1;
> >
> > +     /* Each core has its own queue */
> > +     unsigned int core_affinity : 1;
> > +
> > +     /* Only used if core affinity is not set */
> > +     unsigned int qid_hash_bits;
> > +
> >       wait_queue_head_t stop_waitq;
> >
> >       /* async tear down */
> > @@ -143,6 +149,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsign=
ed int issue_flags);
> >  void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_re=
q *req);
> >  bool fuse_uring_queue_bq_req(struct fuse_req *req);
> >  bool fuse_uring_request_expired(struct fuse_conn *fc);
> > +void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_qu=
eues);
> >
> >  static inline void fuse_uring_abort(struct fuse_conn *fc)
> >  {
> > @@ -200,6 +207,10 @@ static inline bool fuse_uring_request_expired(stru=
ct fuse_conn *fc)
> >       return false;
> >  }
> >
> > +static inline void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsi=
gned int nr_queues)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_FUSE_IO_URING */
> >
> >  #endif /* _FS_FUSE_DEV_URING_I_H */
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 38a782673bfd..7c3010bda02d 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -962,6 +962,7 @@ struct fuse_conn {
> >  #ifdef CONFIG_FUSE_IO_URING
> >       /**  uring connection information*/
> >       struct fuse_ring *ring;
> > +     uint8_t uring_nr_queues;
> >  #endif
> >
> >       /** Only used if the connection opts into request timeouts */
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index fd48e8d37f2e..c168247d87f2 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1433,8 +1433,10 @@ static void process_init_reply(struct fuse_mount=
 *fm, struct fuse_args *args,
> >                               else
> >                                       ok =3D false;
> >                       }
> > -                     if (flags & FUSE_OVER_IO_URING && fuse_uring_enab=
led())
> > +                     if (flags & FUSE_OVER_IO_URING && fuse_uring_enab=
led()) {
> >                               fc->io_uring =3D 1;
> > +                             fuse_uring_set_nr_queues(fc, arg->uring_n=
r_queues);
> > +                     }
> >
> >                       if (flags & FUSE_REQUEST_TIMEOUT)
> >                               timeout =3D arg->request_timeout;
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 5ec43ecbceb7..0d73b8fcd2be 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -232,6 +232,9 @@
> >   *
> >   *  7.43
> >   *  - add FUSE_REQUEST_TIMEOUT
> > + *
> > + * 7.44
> > + * - add uring_nr_queues to fuse_init_out
> >   */
> >
> >  #ifndef _LINUX_FUSE_H
> > @@ -915,7 +918,8 @@ struct fuse_init_out {
> >       uint32_t        flags2;
> >       uint32_t        max_stack_depth;
> >       uint16_t        request_timeout;
> > -     uint16_t        unused[11];
> > +     uint8_t         uring_nr_queues;
> > +     uint8_t         unused[21];
>
>
> I'm a bit scared that uint8_t might not be sufficient at some.
> The largest system we have in the lab has 244 cores. So far
> I'm still not sure if we are going to do queue-per-core or
> are going to reduce it. That even might become a generic tuning
> for us. If we add this value it probably would need to be
> uint16_t. Though I wonder if we can do without this variable
> and just set initialization to completed once the first
> queue had an entry.

The only thing I could think of for not having it be part of the init was:
a) adding another ioctl call, something like FUSE_IO_URING_CMD_INIT
where we pass that as an init param before FUSE_IO_URING_CMD_REGISTERs
get called
or
b) adding the nr_queues to fuse_uring_cmd_req (in the padding bits)
for FUSE_IO_URING_CMD_REGISTER calls

but I don't think either of these are backwards-compatible unfortunately.

I think the issue with setting initialization to completed once the
first queue has an entry is that we need to allocate the queues at
ring creation time, so we need to know nr_queues from the beginning.

If we do go with the init approach, having uring_nr_queues be a
uint16_t sounds reasonable to me.

Thanks,
Joanne
>
>
> Thanks,
> Bernd
>
>

