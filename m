Return-Path: <linux-fsdevel+bounces-45396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50CDA771D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 02:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEBC3A4880
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 00:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3562134AB;
	Tue,  1 Apr 2025 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqqDdi0R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4221372
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466990; cv=none; b=XYM2HsBpzBaFMbCRM2aPs+3DIFYx+gPaaF1AkDRq7Pzs5QniikfPXHt4+IsDHs3Q7SOuXbeRsOpxExH9YgLPnoay2n1X6HBdVJA6dZ55xUeYIaMK6g/7vXf3S+xT3Og4PrAZ9VxLJFgjYn0aCWrpP4FwRipnGnvuEOaI9/835Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466990; c=relaxed/simple;
	bh=ujDujZxic70T4dkrFxgNHMbN+VJH8MSly6+ayLVw6iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQRlBCh4vzd9LpNXwICTwsXMjiNra6mjOzUSrmsApN8h9Aab4Ix8MqytPmHUpD1I0DIMbgKipioMOemrV+ZYvpU0VwF2G2fBH2Yex+zdSjeM7qD6RMli9szp7WqZFT/tchCwwYxetR15dYXN/qQ226JF2QwT2fCEEdaoXqE4UMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqqDdi0R; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4766631a6a4so50466311cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743466987; x=1744071787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im01NijI7A68q58o3vWG5BOq5kXrs/k3cVv6FD0Skrw=;
        b=gqqDdi0Rcsy4BWycrz6eZiC6Y0QEElSe1tlK5lKzJUNkuDR9O4Jzz0KtgxhG1lmtP4
         Kwg2itOFzIQe6eEaNFa6bAt7RVlAla0KZxvXXCbtD2jgttcxvg2LQjFqwxopEAfFYOPL
         pjDWfwI2lGFX1D8LikYIQL2+JZH3pW9hrHvQSabBO8ZsAvgcyya7HE+VJZt42P6S9nVA
         mVUOwtvqDuet3YlWfur3pb4v6fZOlyRglN6+f6EgLwCJ+LcbJNOrLDp96OQuEltx5dzI
         HzaRp7C+wPsWVKq5gpE9cBd+OPGDCRAEn1OhsiM4smXR4jllJouoG3X04rzoLq6a990L
         +qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743466987; x=1744071787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=im01NijI7A68q58o3vWG5BOq5kXrs/k3cVv6FD0Skrw=;
        b=aY4dZq2MooAq7HvowRpfctwAjR604ZG5jVfU2eD43uz9Uweh6YAUArrWGAuTq1FAqD
         o1W1aAAIEmy5BCfREeA+48k2tH/lI3hEj6D+6qs7JmvmsM8cZf6swC5oL0egDL22ZGOx
         1kWrLDM8pQq0IzU7qztY/er9vxWnG1Gtl3whdZBkIVp83ZnQpWtqk5ONAmCMfjsz6wOE
         uJIdBz1xrHv25422CtvDiS9bO3aEZ/e1L4yQzXML3JJLErj6ynJt8t27PYkTxYeEAODj
         P88bX0trJWAtT55M2OFHKQeXL5NfImsFYhqs9k1n8kQFT2MeMrr4QawRCl5CghSoblIJ
         mDZg==
X-Forwarded-Encrypted: i=1; AJvYcCWCVfMKbsr6JooTkTzsWMMK9O3lSaXFk5KxfrMv4kZ4AtIwY3EVYHNOWEZq5U3dPbZvIjE+dfeDTPczkNAd@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkGJXrVa6TCTkaWa7tJQiIH9Y3AB+Biu8jIemyyqZ9O+308oh
	ACx3wC4bPiptly1sBhYu4YmBQi53hCRfh/oO1qqu/rN94TMTqwP3+PQC1MBeQZ0HB9Io5333zEq
	53xzkRtZynoyFGmaBx/7q6rOLOX8=
X-Gm-Gg: ASbGncsoF+3Lx5ewM0fy/feH87NY5kyZnvMbTQjYud2RCt/kyObMzjNFzxaW2vJwooU
	MMC9MfXJbFOgJbwaYDEwZEidLfeFIQ1geWcQLdMkgniczkythK1KoXu99inCOYdbTaOvMsNnfsd
	AQCOKFA5ALgMoMoK7JJ8h6epPxODs=
X-Google-Smtp-Source: AGHT+IG8CHbOtciYp7ZA6bFHIDnhGv8m2u+7YDNm8uMU1z/Y/mCjxEsgsskkXOQtk+mMrh6PZQ7n/uMw0SIUfy+VcOo=
X-Received: by 2002:a05:622a:11c4:b0:477:6ef6:12f with SMTP id
 d75a77b69052e-477ed6d2041mr176267931cf.3.1743466986985; Mon, 31 Mar 2025
 17:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314204437.726538-1-joannelkoong@gmail.com>
 <8aca27b0-609b-44c4-90ff-314e3c086b90@fastmail.fm> <CAJnrk1YoN6gayDQ6hBMa9NnxgkOpf9qYmMRg9kP=2iQR9_B8Ew@mail.gmail.com>
 <1b249021-c69c-4548-b01b-0321b241d434@fastmail.fm> <CAJnrk1azHgMXTaUjb+c4iZ-g7S-RqqfmNPQneZaOaZrQsy_cxQ@mail.gmail.com>
In-Reply-To: <CAJnrk1azHgMXTaUjb+c4iZ-g7S-RqqfmNPQneZaOaZrQsy_cxQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 31 Mar 2025 17:22:56 -0700
X-Gm-Features: AQ5f1Jrp8sXvJRd5kDCZs30-QGK93m4fQLP9daF-VUiiwgjEMi2zaRQEuppWYOY
Message-ID: <CAJnrk1aUXaYngs1XeGjGqbXkYkTiV_BF2CiwGy_rDtZznVw29g@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: support configurable number of uring queues
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 4:16=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Tue, Mar 18, 2025 at 3:33=E2=80=AFAM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> > On 3/18/25 01:55, Joanne Koong wrote:
> > > Hi Bernd,
> > > Thanks for the quick turnaround on the review!
> > >
> > > On Fri, Mar 14, 2025 at 4:11=E2=80=AFPM Bernd Schubert
> > > <bernd.schubert@fastmail.fm> wrote:
> > >>
> > >> Thanks Joanne! That is rather close to what I wanted to add,
> > >> just a few comments.
> > >>
> > >> On 3/14/25 21:44, Joanne Koong wrote:
> > >>> In the current uring design, the number of queues is equal to the n=
umber
> > >>> of cores on a system. However, on high-scale machines where there a=
re
> > >>> hundreds of cores, having such a high number of queues is often
> > >>> overkill and resource-intensive. As well, in the current design whe=
re
> > >>> the queue for the request is set to the cpu the task is currently
> > >>> executing on (see fuse_uring_task_to_queue()), there is no guarante=
e
> > >>> that requests for the same file will be sent to the same queue (eg =
if a
> > >>> task is preempted and moved to a different cpu) which may be proble=
matic
> > >>> for some servers (eg if the server is append-only and does not supp=
ort
> > >>> unordered writes).
> > >>>
> > >>> In this commit, the server can configure the number of uring queues
> > >>> (passed to the kernel through the init reply). The number of queues=
 must
> > >>> be a power of two, in order to make queue assignment for a request
> > >>> efficient. If the server specifies a non-power of two, then it will=
 be
> > >>> automatically rounded down to the nearest power of two. If the serv=
er
> > >>> does not specify the number of queues, then this will automatically
> > >>> default to the current behavior where the number of queues will be =
equal
> > >>> to the number of cores with core and numa affinity. The queue id ha=
sh
> > >>> is computed on the nodeid, which ensures that requests for the same=
 file
> > >>> will be forwarded to the same queue.
> > >>>
> > >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > >>> ---
> > >>>  fs/fuse/dev_uring.c       | 48 +++++++++++++++++++++++++++++++++++=
----
> > >>>  fs/fuse/dev_uring_i.h     | 11 +++++++++
> > >>>  fs/fuse/fuse_i.h          |  1 +
> > >>>  fs/fuse/inode.c           |  4 +++-
> > >>>  include/uapi/linux/fuse.h |  6 ++++-
> > >>>  5 files changed, 63 insertions(+), 7 deletions(-)
> > >>>
> > >>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > >>> index 64f1ae308dc4..f173f9e451ac 100644
> > >>> --- a/fs/fuse/dev_uring.c
> > >>> +++ b/fs/fuse/dev_uring.c
> > >>> @@ -209,9 +209,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
> > >>>  static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
> > >>>  {
> > >>>       struct fuse_ring *ring;
> > >>> -     size_t nr_queues =3D num_possible_cpus();
> > >>> +     size_t nr_queues =3D fc->uring_nr_queues;
> > >>>       struct fuse_ring *res =3D NULL;
> > >>>       size_t max_payload_size;
> > >>> +     unsigned int nr_cpus =3D num_possible_cpus();
> > >>>
> > >>>       ring =3D kzalloc(sizeof(*fc->ring), GFP_KERNEL_ACCOUNT);
> > >>>       if (!ring)
> > >>> @@ -237,6 +238,13 @@ static struct fuse_ring *fuse_uring_create(str=
uct fuse_conn *fc)
> > >>>
> > >>>       fc->ring =3D ring;
> > >>>       ring->nr_queues =3D nr_queues;
> > >>> +     if (nr_queues =3D=3D nr_cpus) {
> > >>> +             ring->core_affinity =3D 1;
> > >>> +     } else {
> > >>> +             WARN_ON(!nr_queues || nr_queues > nr_cpus ||
> > >>> +                     !is_power_of_2(nr_queues));
> > >>> +             ring->qid_hash_bits =3D ilog2(nr_queues);
> > >>> +     }
> > >>>       ring->fc =3D fc;
> > >>>       ring->max_payload_sz =3D max_payload_size;
> > >>>       atomic_set(&ring->queue_refs, 0);
> > >>> @@ -1217,12 +1225,24 @@ static void fuse_uring_send_in_task(struct =
io_uring_cmd *cmd,
> > >>>       fuse_uring_send(ent, cmd, err, issue_flags);
> > >>>  }
> > >>>
> > >>> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fus=
e_ring *ring)
> > >>> +static unsigned int hash_qid(struct fuse_ring *ring, u64 nodeid)
> > >>> +{
> > >>> +     if (ring->nr_queues =3D=3D 1)
> > >>> +             return 0;
> > >>> +
> > >>> +     return hash_long(nodeid, ring->qid_hash_bits);
> > >>> +}
> > >>> +
> > >>> +static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fus=
e_ring *ring,
> > >>> +                                                     struct fuse_r=
eq *req)
> > >>>  {
> > >>>       unsigned int qid;
> > >>>       struct fuse_ring_queue *queue;
> > >>>
> > >>> -     qid =3D task_cpu(current);
> > >>> +     if (ring->core_affinity)
> > >>> +             qid =3D task_cpu(current);
> > >>> +     else
> > >>> +             qid =3D hash_qid(ring, req->in.h.nodeid);
> > >>
> > >> I think we need to handle numa affinity.
> > >>
> > >
> > > Could you elaborate more on this? I'm not too familiar with how to
> > > enforce this in practice. As I understand it, the main goal of numa
> > > affinity is to make sure processes access memory that's physically
> > > closer to the CPU it's executing on. How does this usually get
> > > enforced at the kernel level?
> >
> > The request comes on a specific core and that is on a numa node -
> > we should try to avoid switching. If there is no queue for the
> > current core we should try to stay on the same numa node.
> > And we should probably also consider the waiting requests per
> > queue and distribute between that, although that is a bit
> > independent.
> >
>
> In that case then, there's no guarantee that requests on the same file
> will get sent to the same queue. But thinking more about this, maybe
> it doesn't matter after all if they're sent to different queues. I
> need to think some more about this. But I agree, if we don't care
> about requests for the same inode getting routed to the same queue,
> then we should aim for numa affinity. I'll look more into this.
>

Thought about this some more... is this even worth doing? AFAICT,
there's no guarantee that the same number of CPUs are distributed
evenly across numa nodes. For example, one numa node may have CPUs 0
to 5 on them, then another numa node might have CPU 6 and 7. If
there's two queues, each associated with a numa node, then requests
will be disproportionately / unevenly allocated. Eg most of the
workload will be queued on the numa node with CPUs 0 to 5. Moreover, I
don't think there's a good way to enforce this in the cases where
number of queues < number of numa nodes. For example if there's 3 numa
nodes with say 3 CPUs each and there's 2 queues. The logic for which
cpu gets sent to which queue gets a little messy here.

imo, this is an optimization that could be added in the future if the
need for this comes up. WDYT?

Thanks,
Joanne

> Thanks,
> Joanne
>
> > >
> > >>>
> > >>>       if (WARN_ONCE(qid >=3D ring->nr_queues,
> > >>>                     "Core number (%u) exceeds nr queues (%zu)\n", q=
id,
> > >>> @@ -1253,7 +1273,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iq=
ueue *fiq, struct fuse_req *req)
> > >>>       int err;
> > >>>
> > >>>       err =3D -EINVAL;
> > >>> -     queue =3D fuse_uring_task_to_queue(ring);
> > >>> +     queue =3D fuse_uring_task_to_queue(ring, req);
> > >>>       if (!queue)
> > >>>               goto err;
> > >>>
> > >>> @@ -1293,7 +1313,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req =
*req)
> > >>>       struct fuse_ring_queue *queue;
> > >>>       struct fuse_ring_ent *ent =3D NULL;
> > >>>
> > >>> -     queue =3D fuse_uring_task_to_queue(ring);
> > >>> +     queue =3D fuse_uring_task_to_queue(ring, req);
> > >>>       if (!queue)
> > >>>               return false;
> > >>>
> > >>> @@ -1344,3 +1364,21 @@ static const struct fuse_iqueue_ops fuse_io_=
uring_ops =3D {
> > >>>       .send_interrupt =3D fuse_dev_queue_interrupt,
> > >>>       .send_req =3D fuse_uring_queue_fuse_req,
> > >>>  };
> > >>> +
> > >>> +void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int n=
r_queues)
> > >>> +{
> > >>> +     if (!nr_queues) {
> > >>> +             fc->uring_nr_queues =3D num_possible_cpus();
> > >>> +             return;
> > >>> +     }
> > >>> +
> > >>> +     if (!is_power_of_2(nr_queues)) {
> > >>> +             unsigned int old_nr_queues =3D nr_queues;
> > >>> +
> > >>> +             nr_queues =3D rounddown_pow_of_two(nr_queues);
> > >>> +             pr_debug("init: uring_nr_queues=3D%u is not a power o=
f 2. "
> > >>> +                      "Rounding down uring_nr_queues to %u\n",
> > >>> +                      old_nr_queues, nr_queues);
> > >>> +     }
> > >>> +     fc->uring_nr_queues =3D min(nr_queues, num_possible_cpus());
> > >>> +}
> > >>> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> > >>> index ce823c6b1806..81398b5b8bf2 100644
> > >>> --- a/fs/fuse/dev_uring_i.h
> > >>> +++ b/fs/fuse/dev_uring_i.h
> > >>> @@ -122,6 +122,12 @@ struct fuse_ring {
> > >>>        */
> > >>>       unsigned int stop_debug_log : 1;
> > >>>
> > >>> +     /* Each core has its own queue */
> > >>> +     unsigned int core_affinity : 1;
> > >>> +
> > >>> +     /* Only used if core affinity is not set */
> > >>> +     unsigned int qid_hash_bits;
> > >>> +
> > >>>       wait_queue_head_t stop_waitq;
> > >>>
> > >>>       /* async tear down */
> > >>> @@ -143,6 +149,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, un=
signed int issue_flags);
> > >>>  void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fus=
e_req *req);
> > >>>  bool fuse_uring_queue_bq_req(struct fuse_req *req);
> > >>>  bool fuse_uring_request_expired(struct fuse_conn *fc);
> > >>> +void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int n=
r_queues);
> > >>>
> > >>>  static inline void fuse_uring_abort(struct fuse_conn *fc)
> > >>>  {
> > >>> @@ -200,6 +207,10 @@ static inline bool fuse_uring_request_expired(=
struct fuse_conn *fc)
> > >>>       return false;
> > >>>  }
> > >>>
> > >>> +static inline void fuse_uring_set_nr_queues(struct fuse_conn *fc, =
unsigned int nr_queues)
> > >>> +{
> > >>> +}
> > >>> +
> > >>>  #endif /* CONFIG_FUSE_IO_URING */
> > >>>
> > >>>  #endif /* _FS_FUSE_DEV_URING_I_H */
> > >>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > >>> index 38a782673bfd..7c3010bda02d 100644
> > >>> --- a/fs/fuse/fuse_i.h
> > >>> +++ b/fs/fuse/fuse_i.h
> > >>> @@ -962,6 +962,7 @@ struct fuse_conn {
> > >>>  #ifdef CONFIG_FUSE_IO_URING
> > >>>       /**  uring connection information*/
> > >>>       struct fuse_ring *ring;
> > >>> +     uint8_t uring_nr_queues;
> > >>>  #endif
> > >>>
> > >>>       /** Only used if the connection opts into request timeouts */
> > >>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > >>> index fd48e8d37f2e..c168247d87f2 100644
> > >>> --- a/fs/fuse/inode.c
> > >>> +++ b/fs/fuse/inode.c
> > >>> @@ -1433,8 +1433,10 @@ static void process_init_reply(struct fuse_m=
ount *fm, struct fuse_args *args,
> > >>>                               else
> > >>>                                       ok =3D false;
> > >>>                       }
> > >>> -                     if (flags & FUSE_OVER_IO_URING && fuse_uring_=
enabled())
> > >>> +                     if (flags & FUSE_OVER_IO_URING && fuse_uring_=
enabled()) {
> > >>>                               fc->io_uring =3D 1;
> > >>> +                             fuse_uring_set_nr_queues(fc, arg->uri=
ng_nr_queues);
> > >>> +                     }
> > >>>
> > >>>                       if (flags & FUSE_REQUEST_TIMEOUT)
> > >>>                               timeout =3D arg->request_timeout;
> > >>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > >>> index 5ec43ecbceb7..0d73b8fcd2be 100644
> > >>> --- a/include/uapi/linux/fuse.h
> > >>> +++ b/include/uapi/linux/fuse.h
> > >>> @@ -232,6 +232,9 @@
> > >>>   *
> > >>>   *  7.43
> > >>>   *  - add FUSE_REQUEST_TIMEOUT
> > >>> + *
> > >>> + * 7.44
> > >>> + * - add uring_nr_queues to fuse_init_out
> > >>>   */
> > >>>
> > >>>  #ifndef _LINUX_FUSE_H
> > >>> @@ -915,7 +918,8 @@ struct fuse_init_out {
> > >>>       uint32_t        flags2;
> > >>>       uint32_t        max_stack_depth;
> > >>>       uint16_t        request_timeout;
> > >>> -     uint16_t        unused[11];
> > >>> +     uint8_t         uring_nr_queues;
> > >>> +     uint8_t         unused[21];
> > >>
> > >>
> > >> I'm a bit scared that uint8_t might not be sufficient at some.
> > >> The largest system we have in the lab has 244 cores. So far
> > >> I'm still not sure if we are going to do queue-per-core or
> > >> are going to reduce it. That even might become a generic tuning
> > >> for us. If we add this value it probably would need to be
> > >> uint16_t. Though I wonder if we can do without this variable
> > >> and just set initialization to completed once the first
> > >> queue had an entry.
> > >
> > > The only thing I could think of for not having it be part of the init=
 was:
> > > a) adding another ioctl call, something like FUSE_IO_URING_CMD_INIT
> > > where we pass that as an init param before FUSE_IO_URING_CMD_REGISTER=
s
> > > get called
> > > or
> > > b) adding the nr_queues to fuse_uring_cmd_req (in the padding bits)
> > > for FUSE_IO_URING_CMD_REGISTER calls
> > >
> > > but I don't think either of these are backwards-compatible unfortunat=
ely.
> > >
> > > I think the issue with setting initialization to completed once the
> > > first queue has an entry is that we need to allocate the queues at
> > > ring creation time, so we need to know nr_queues from the beginning.
> > >
> > > If we do go with the init approach, having uring_nr_queues be a
> > > uint16_t sounds reasonable to me.
> >
> > I will take an hour a bit later today and try to update the patch.
> >
> >
> > Thanks,
> > Bernd

