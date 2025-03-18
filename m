Return-Path: <linux-fsdevel+bounces-44378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5607A680A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E16C7A31A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 23:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F5C1F7076;
	Tue, 18 Mar 2025 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxLPwpWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072F1D6DBC
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339798; cv=none; b=qBwQAdYhZeQbT8HEI9pYYly/SIWddFg/Q/9FiTUmTXCTzpSzEuVLBMFQolNp1DwfMnF+va79yLSRHlvJNupn1SXOB7ug5dfjVuu2h3xTu/CWi8/9bpN7L1M1VU3uL0egd43cE0ejq7QpbfTj8HRrdppMyYYiaW+Je0ZBlqMNOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339798; c=relaxed/simple;
	bh=ayAeRXvtZKZXJcNNuwrwuAARO/vCuD7DbIRIbM2a1V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiN5J0KRR/aJ1gO1FEl8ugDa3NVxXO/AfAqL0HdVk5/vLjMy91/Vl6AxWBay9ubXLB8CPse2pUvmIQnpOecS1bV1TYAyN+OMrl0fFvs8MytKf1FM4e5z/kdTACoHyOSbVIIU4onimUTjLERmpYVp/UiO5itRhjDGZVxmhJx9ogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxLPwpWF; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476f4e9cf92so18386731cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339795; x=1742944595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dANghKS4Ua1df77VAwcJE2chG305e6Go0F7nOty3OU=;
        b=cxLPwpWFeS0HijDm872jiLCglVK2v44ev5NvZHBSqj30y9jCUxvZvY4MX06EN4IpjH
         8faGo4f0p0BO8uTMfk0r6cpRA685OnDlKt8yEOmD4Ajrx3aDmh4hR+AQ066JJS33TROE
         e1zSj7vFS67kGrzqC5oxvHs6RuqservAo/Ac1EhHn5vM69chvCe5a4LwCZjsTjgbezYc
         68fAKWjZ2EUptvNMpgCw3MYSk3JF+ze3qatV/8hjQRTbvPcBc9UK0xsXvN64931M/ftt
         1g/tpHiaUFCY5FlU9yG+hfHbRU46SmvWdIJIn7C6OumRFk/c+XPvQTzSMc9hKCGSkqG8
         7TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339795; x=1742944595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dANghKS4Ua1df77VAwcJE2chG305e6Go0F7nOty3OU=;
        b=O/w0CzTGKYh98OjHyCv3NR6+EZ4+DbKVycWLkVAj7M4YnspcPVuvjYTshOSDJC5rMu
         7nx/QjLZgvDXMdBuerqQecTNPKGtU+1Q5FyIuYdxTYJuQrSd9Bdgg6qQ3n/GxcWDOR28
         iLPNMhcA4uCH7b6zU6rcEKtKvzFk/TsrEPrQ+DBYgZsdR1AjGR1Cxl33Ecx0IXYqYUBU
         XZqx1ROyVLadUc9B2v67dOpB9U01ZMOVFz8aYC8V4slBa6ePoM8BNt1jCxencTrtX5sY
         YJo4sbUjfECOinabZUPPsNGhEAm3QHg+Lw7FBAPnCLjKFJusgtMGtj8iBKo1KvopbOIp
         JoNw==
X-Forwarded-Encrypted: i=1; AJvYcCVUKMKilf8laGEibpEXH2cp8y0dmZFygtKFaXqpQGURCwDuI7YwrqH4aw4iMLLEr5K4vWi5BNi70M5b6H5O@vger.kernel.org
X-Gm-Message-State: AOJu0YwaH4cmv2syLedV7MkE78CWsZ3E2P6Q37x/yCYkIiytEz8XIuJT
	GhP8CzELBdStsFqizWCME/AFwERYggmFVQVwroRXnVW3h6in39fUxFod3GRQ6U8hQRldS3JAljS
	6KeY8FtUiQVjdZd3MTyldFzuFMQ8=
X-Gm-Gg: ASbGnctW2SBBpdD/Bct+4xbT+wPEcfAyE6N7Ytll3MW3UvjjokQlZAos3GeZkJ8w9IG
	zuZGXdL8IUkqXrhf7ThmoosZ9GUD70NzB6dhmcS4YtrE4kTZX1bX4khm7Av/34aDqCYNYsiPPUl
	b4IrkgdtNvr8v1W4kB1qEksGWfVF+lHHqq30VT7go/NQ==
X-Google-Smtp-Source: AGHT+IFCMIdM9j9DcQCw2hb2X1Y/LiYtpLoltfJrdaqwL/4sMTrMSY8+fIGlI991mDjiE9djk1JdP3S+dul6KzonQqo=
X-Received: by 2002:a05:622a:248e:b0:476:ac73:c3f3 with SMTP id
 d75a77b69052e-477082c1083mr17280301cf.1.1742339795352; Tue, 18 Mar 2025
 16:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314204437.726538-1-joannelkoong@gmail.com>
 <8aca27b0-609b-44c4-90ff-314e3c086b90@fastmail.fm> <CAJnrk1YoN6gayDQ6hBMa9NnxgkOpf9qYmMRg9kP=2iQR9_B8Ew@mail.gmail.com>
 <1b249021-c69c-4548-b01b-0321b241d434@fastmail.fm>
In-Reply-To: <1b249021-c69c-4548-b01b-0321b241d434@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 18 Mar 2025 16:16:24 -0700
X-Gm-Features: AQ5f1Jqjsz3w_nVh-8lsdFBycGNVsB2_czL-u4_UZD50dCRM-RYbRrvvcAaGVE0
Message-ID: <CAJnrk1azHgMXTaUjb+c4iZ-g7S-RqqfmNPQneZaOaZrQsy_cxQ@mail.gmail.com>
Subject: Re: [PATCH v1] fuse: support configurable number of uring queues
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 3:33=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 3/18/25 01:55, Joanne Koong wrote:
> > Hi Bernd,
> > Thanks for the quick turnaround on the review!
> >
> > On Fri, Mar 14, 2025 at 4:11=E2=80=AFPM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >> Thanks Joanne! That is rather close to what I wanted to add,
> >> just a few comments.
> >>
> >> On 3/14/25 21:44, Joanne Koong wrote:
> >>> In the current uring design, the number of queues is equal to the num=
ber
> >>> of cores on a system. However, on high-scale machines where there are
> >>> hundreds of cores, having such a high number of queues is often
> >>> overkill and resource-intensive. As well, in the current design where
> >>> the queue for the request is set to the cpu the task is currently
> >>> executing on (see fuse_uring_task_to_queue()), there is no guarantee
> >>> that requests for the same file will be sent to the same queue (eg if=
 a
> >>> task is preempted and moved to a different cpu) which may be problema=
tic
> >>> for some servers (eg if the server is append-only and does not suppor=
t
> >>> unordered writes).
> >>>
> >>> In this commit, the server can configure the number of uring queues
> >>> (passed to the kernel through the init reply). The number of queues m=
ust
> >>> be a power of two, in order to make queue assignment for a request
> >>> efficient. If the server specifies a non-power of two, then it will b=
e
> >>> automatically rounded down to the nearest power of two. If the server
> >>> does not specify the number of queues, then this will automatically
> >>> default to the current behavior where the number of queues will be eq=
ual
> >>> to the number of cores with core and numa affinity. The queue id hash
> >>> is computed on the nodeid, which ensures that requests for the same f=
ile
> >>> will be forwarded to the same queue.
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> ---
> >>>  fs/fuse/dev_uring.c       | 48 +++++++++++++++++++++++++++++++++++--=
--
> >>>  fs/fuse/dev_uring_i.h     | 11 +++++++++
> >>>  fs/fuse/fuse_i.h          |  1 +
> >>>  fs/fuse/inode.c           |  4 +++-
> >>>  include/uapi/linux/fuse.h |  6 ++++-
> >>>  5 files changed, 63 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >>> index 64f1ae308dc4..f173f9e451ac 100644
> >>> --- a/fs/fuse/dev_uring.c
> >>> +++ b/fs/fuse/dev_uring.c
> >>> @@ -209,9 +209,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
> >>>  static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
> >>>  {
> >>>       struct fuse_ring *ring;
> >>> -     size_t nr_queues =3D num_possible_cpus();
> >>> +     size_t nr_queues =3D fc->uring_nr_queues;
> >>>       struct fuse_ring *res =3D NULL;
> >>>       size_t max_payload_size;
> >>> +     unsigned int nr_cpus =3D num_possible_cpus();
> >>>
> >>>       ring =3D kzalloc(sizeof(*fc->ring), GFP_KERNEL_ACCOUNT);
> >>>       if (!ring)
> >>> @@ -237,6 +238,13 @@ static struct fuse_ring *fuse_uring_create(struc=
t fuse_conn *fc)
> >>>
> >>>       fc->ring =3D ring;
> >>>       ring->nr_queues =3D nr_queues;
> >>> +     if (nr_queues =3D=3D nr_cpus) {
> >>> +             ring->core_affinity =3D 1;
> >>> +     } else {
> >>> +             WARN_ON(!nr_queues || nr_queues > nr_cpus ||
> >>> +                     !is_power_of_2(nr_queues));
> >>> +             ring->qid_hash_bits =3D ilog2(nr_queues);
> >>> +     }
> >>>       ring->fc =3D fc;
> >>>       ring->max_payload_sz =3D max_payload_size;
> >>>       atomic_set(&ring->queue_refs, 0);
> >>> @@ -1217,12 +1225,24 @@ static void fuse_uring_send_in_task(struct io=
_uring_cmd *cmd,
> >>>       fuse_uring_send(ent, cmd, err, issue_flags);
> >>>  }
> >>>
> >>> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_=
ring *ring)
> >>> +static unsigned int hash_qid(struct fuse_ring *ring, u64 nodeid)
> >>> +{
> >>> +     if (ring->nr_queues =3D=3D 1)
> >>> +             return 0;
> >>> +
> >>> +     return hash_long(nodeid, ring->qid_hash_bits);
> >>> +}
> >>> +
> >>> +static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_=
ring *ring,
> >>> +                                                     struct fuse_req=
 *req)
> >>>  {
> >>>       unsigned int qid;
> >>>       struct fuse_ring_queue *queue;
> >>>
> >>> -     qid =3D task_cpu(current);
> >>> +     if (ring->core_affinity)
> >>> +             qid =3D task_cpu(current);
> >>> +     else
> >>> +             qid =3D hash_qid(ring, req->in.h.nodeid);
> >>
> >> I think we need to handle numa affinity.
> >>
> >
> > Could you elaborate more on this? I'm not too familiar with how to
> > enforce this in practice. As I understand it, the main goal of numa
> > affinity is to make sure processes access memory that's physically
> > closer to the CPU it's executing on. How does this usually get
> > enforced at the kernel level?
>
> The request comes on a specific core and that is on a numa node -
> we should try to avoid switching. If there is no queue for the
> current core we should try to stay on the same numa node.
> And we should probably also consider the waiting requests per
> queue and distribute between that, although that is a bit
> independent.
>

In that case then, there's no guarantee that requests on the same file
will get sent to the same queue. But thinking more about this, maybe
it doesn't matter after all if they're sent to different queues. I
need to think some more about this. But I agree, if we don't care
about requests for the same inode getting routed to the same queue,
then we should aim for numa affinity. I'll look more into this.

Thanks,
Joanne

> >
> >>>
> >>>       if (WARN_ONCE(qid >=3D ring->nr_queues,
> >>>                     "Core number (%u) exceeds nr queues (%zu)\n", qid=
,
> >>> @@ -1253,7 +1273,7 @@ void fuse_uring_queue_fuse_req(struct fuse_ique=
ue *fiq, struct fuse_req *req)
> >>>       int err;
> >>>
> >>>       err =3D -EINVAL;
> >>> -     queue =3D fuse_uring_task_to_queue(ring);
> >>> +     queue =3D fuse_uring_task_to_queue(ring, req);
> >>>       if (!queue)
> >>>               goto err;
> >>>
> >>> @@ -1293,7 +1313,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *r=
eq)
> >>>       struct fuse_ring_queue *queue;
> >>>       struct fuse_ring_ent *ent =3D NULL;
> >>>
> >>> -     queue =3D fuse_uring_task_to_queue(ring);
> >>> +     queue =3D fuse_uring_task_to_queue(ring, req);
> >>>       if (!queue)
> >>>               return false;
> >>>
> >>> @@ -1344,3 +1364,21 @@ static const struct fuse_iqueue_ops fuse_io_ur=
ing_ops =3D {
> >>>       .send_interrupt =3D fuse_dev_queue_interrupt,
> >>>       .send_req =3D fuse_uring_queue_fuse_req,
> >>>  };
> >>> +
> >>> +void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_=
queues)
> >>> +{
> >>> +     if (!nr_queues) {
> >>> +             fc->uring_nr_queues =3D num_possible_cpus();
> >>> +             return;
> >>> +     }
> >>> +
> >>> +     if (!is_power_of_2(nr_queues)) {
> >>> +             unsigned int old_nr_queues =3D nr_queues;
> >>> +
> >>> +             nr_queues =3D rounddown_pow_of_two(nr_queues);
> >>> +             pr_debug("init: uring_nr_queues=3D%u is not a power of =
2. "
> >>> +                      "Rounding down uring_nr_queues to %u\n",
> >>> +                      old_nr_queues, nr_queues);
> >>> +     }
> >>> +     fc->uring_nr_queues =3D min(nr_queues, num_possible_cpus());
> >>> +}
> >>> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> >>> index ce823c6b1806..81398b5b8bf2 100644
> >>> --- a/fs/fuse/dev_uring_i.h
> >>> +++ b/fs/fuse/dev_uring_i.h
> >>> @@ -122,6 +122,12 @@ struct fuse_ring {
> >>>        */
> >>>       unsigned int stop_debug_log : 1;
> >>>
> >>> +     /* Each core has its own queue */
> >>> +     unsigned int core_affinity : 1;
> >>> +
> >>> +     /* Only used if core affinity is not set */
> >>> +     unsigned int qid_hash_bits;
> >>> +
> >>>       wait_queue_head_t stop_waitq;
> >>>
> >>>       /* async tear down */
> >>> @@ -143,6 +149,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsi=
gned int issue_flags);
> >>>  void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_=
req *req);
> >>>  bool fuse_uring_queue_bq_req(struct fuse_req *req);
> >>>  bool fuse_uring_request_expired(struct fuse_conn *fc);
> >>> +void fuse_uring_set_nr_queues(struct fuse_conn *fc, unsigned int nr_=
queues);
> >>>
> >>>  static inline void fuse_uring_abort(struct fuse_conn *fc)
> >>>  {
> >>> @@ -200,6 +207,10 @@ static inline bool fuse_uring_request_expired(st=
ruct fuse_conn *fc)
> >>>       return false;
> >>>  }
> >>>
> >>> +static inline void fuse_uring_set_nr_queues(struct fuse_conn *fc, un=
signed int nr_queues)
> >>> +{
> >>> +}
> >>> +
> >>>  #endif /* CONFIG_FUSE_IO_URING */
> >>>
> >>>  #endif /* _FS_FUSE_DEV_URING_I_H */
> >>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> >>> index 38a782673bfd..7c3010bda02d 100644
> >>> --- a/fs/fuse/fuse_i.h
> >>> +++ b/fs/fuse/fuse_i.h
> >>> @@ -962,6 +962,7 @@ struct fuse_conn {
> >>>  #ifdef CONFIG_FUSE_IO_URING
> >>>       /**  uring connection information*/
> >>>       struct fuse_ring *ring;
> >>> +     uint8_t uring_nr_queues;
> >>>  #endif
> >>>
> >>>       /** Only used if the connection opts into request timeouts */
> >>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >>> index fd48e8d37f2e..c168247d87f2 100644
> >>> --- a/fs/fuse/inode.c
> >>> +++ b/fs/fuse/inode.c
> >>> @@ -1433,8 +1433,10 @@ static void process_init_reply(struct fuse_mou=
nt *fm, struct fuse_args *args,
> >>>                               else
> >>>                                       ok =3D false;
> >>>                       }
> >>> -                     if (flags & FUSE_OVER_IO_URING && fuse_uring_en=
abled())
> >>> +                     if (flags & FUSE_OVER_IO_URING && fuse_uring_en=
abled()) {
> >>>                               fc->io_uring =3D 1;
> >>> +                             fuse_uring_set_nr_queues(fc, arg->uring=
_nr_queues);
> >>> +                     }
> >>>
> >>>                       if (flags & FUSE_REQUEST_TIMEOUT)
> >>>                               timeout =3D arg->request_timeout;
> >>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> >>> index 5ec43ecbceb7..0d73b8fcd2be 100644
> >>> --- a/include/uapi/linux/fuse.h
> >>> +++ b/include/uapi/linux/fuse.h
> >>> @@ -232,6 +232,9 @@
> >>>   *
> >>>   *  7.43
> >>>   *  - add FUSE_REQUEST_TIMEOUT
> >>> + *
> >>> + * 7.44
> >>> + * - add uring_nr_queues to fuse_init_out
> >>>   */
> >>>
> >>>  #ifndef _LINUX_FUSE_H
> >>> @@ -915,7 +918,8 @@ struct fuse_init_out {
> >>>       uint32_t        flags2;
> >>>       uint32_t        max_stack_depth;
> >>>       uint16_t        request_timeout;
> >>> -     uint16_t        unused[11];
> >>> +     uint8_t         uring_nr_queues;
> >>> +     uint8_t         unused[21];
> >>
> >>
> >> I'm a bit scared that uint8_t might not be sufficient at some.
> >> The largest system we have in the lab has 244 cores. So far
> >> I'm still not sure if we are going to do queue-per-core or
> >> are going to reduce it. That even might become a generic tuning
> >> for us. If we add this value it probably would need to be
> >> uint16_t. Though I wonder if we can do without this variable
> >> and just set initialization to completed once the first
> >> queue had an entry.
> >
> > The only thing I could think of for not having it be part of the init w=
as:
> > a) adding another ioctl call, something like FUSE_IO_URING_CMD_INIT
> > where we pass that as an init param before FUSE_IO_URING_CMD_REGISTERs
> > get called
> > or
> > b) adding the nr_queues to fuse_uring_cmd_req (in the padding bits)
> > for FUSE_IO_URING_CMD_REGISTER calls
> >
> > but I don't think either of these are backwards-compatible unfortunatel=
y.
> >
> > I think the issue with setting initialization to completed once the
> > first queue has an entry is that we need to allocate the queues at
> > ring creation time, so we need to know nr_queues from the beginning.
> >
> > If we do go with the init approach, having uring_nr_queues be a
> > uint16_t sounds reasonable to me.
>
> I will take an hour a bit later today and try to update the patch.
>
>
> Thanks,
> Bernd

