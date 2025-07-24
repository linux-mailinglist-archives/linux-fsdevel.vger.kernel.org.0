Return-Path: <linux-fsdevel+bounces-55989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDBFB114FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 01:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5326E3BBE29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 23:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723724728C;
	Thu, 24 Jul 2025 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eShBc4ca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707B23C8A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753401433; cv=none; b=ebooxJVyqerGNeBzHWdIJIVP0uwzxtYU8WQtEsh9tfw30NYw+IVESfMzcdC5IA+H6FEhJ1Kc/gZW4oeIDI0rDKCJHDo9IKFmYtWpVZvtCMigQ9xSsgfKzDet4zdoNjXMr5C6EVHt53DpRZRuWyqGERKIJWSipo2TSp0iZE1BboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753401433; c=relaxed/simple;
	bh=yzaIvXTCCw26G0EVejXWQKL+XAS/brQgoYNbSx1UTrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ht0jTDa3tLtVwlo7ATosrvNU2ng6fnqVm7++0Fwypk0SdiTeyg/JG20JuBOZ6P/cu7Q0gT5PNDA187Ct6JP35D2Yb1n0xv/vHEiPeEQO+mo0pPG7dt3oGDTkM5w3hYZor7xmCeYTaT7AsTWJ8nNlYXL/pPvBgwhF6Mr20A06VqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eShBc4ca; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab7384b108so17450611cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jul 2025 16:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753401429; x=1754006229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X6OVQrvEz9CgQDtYSOlWUBEnLU6eYB4Y0yGaQiM7GU=;
        b=eShBc4caPpybch6i3QiBMuekCUIsV5Ta14uwEzPRemheecdCi74Ntx5Jhpq2+U00Fk
         75wfiwToeAeyFUZAlycK5/Ao5gx3i8x+OZ+U/Gc61zleZ/ssnfIk4UprUG8QmCjPB76j
         eUysJnm9aDg1SadcY1ogEk4OUxNpP+dErHDKVEO0PUTSZ3Z2dVKakkgJTnNuQHCRWZom
         lULotiNQCIIbSP/9/QlcNrdZ8TviS5GfnfgBN95G/ZM++wnYzuwTXki9F1r9LRisAXw3
         EII8pvz+3QYuWFg1lDTVtk/Zf4B7C/Hf2BHkDXoZQhxb5lerFP39oQ+9ciFmOP5DIbPm
         AUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753401429; x=1754006229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X6OVQrvEz9CgQDtYSOlWUBEnLU6eYB4Y0yGaQiM7GU=;
        b=qLyFH5PPe0CWTnpX1QhIP5kmQvcY47W4c3JQMz1/d7g3F7XIkjLMRPMbjotakCq/Zf
         j739DTe5sJf5ENU2eDGPtCwaniSGwWZY+2ha4PPUP7+RbviADzz45//vU05k62lrZav5
         /Ocku0jxPOs7xpJbqt5gwENhfpfTFlUmZWrV7G4dOcY1ioqnw76owj4ytI65Re7c+7Sp
         m3h3Wec8vwb0rUU1rq5fakwjYVJ7XYJQgLwCD6kGbK94Rg+kKVqqHySFdjyqQdxAfAwH
         HeQDBDFD65nuXT+o5DZZAk8L3m1vzK/08b60BpeGcW2HQ6bc7Fdv73XwPxxJP9rvFkxA
         WGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEywgOfpH0jeWYhGiQIejESBhg+mnyXCFbCeypaPt4zsTE6Rg+Rkszmd5iPNgixB5mPZYMkvagC7uRvFmx@vger.kernel.org
X-Gm-Message-State: AOJu0YxjiRPrDHvpM01PlD9tgPsaf6cGTedKgs0yrVNtduli8iS9zx0t
	W2FkoOY8NjRzJmqXW2m1GGEUlH3ahtw4TN1cY5SRcs3fET+Rh44ObmxMxt4WpEAEM7ZNcIGGAd0
	qgovZx3eRRkExizgsK659Z5+ps1ArZkM=
X-Gm-Gg: ASbGncthL6mAuzf9yM8NMnkzORnPKrPEVZxie13lUngSpDh4p5QioxECp0TcRlzxzts
	oz8GCnh43gtUMOSR9MAAv4CRDgBFX7qOqVX5LJxkBOYzwLigxCYcXqzdR65oovf4ftbjyRr9Yun
	QGPj9h/dsvWsLuNagS18tyLgxhxFk9gX7HLp/EfLZLYMdhUm97LEoQ7FrEHbhNRxzJiBBiomkHX
	KUMBfw=
X-Google-Smtp-Source: AGHT+IECQjMaTAOtrvCIclDN00ArWON5JAshjkDJfLdvdo8mYPHO3ivUGE4G4+awVUuPGcrWiq6N6RXldc3Ga5TKxOA=
X-Received: by 2002:a05:622a:98c:b0:499:5503:7b2c with SMTP id
 d75a77b69052e-4ae6df763f6mr147183751cf.43.1753401428809; Thu, 24 Jul 2025
 16:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com> <20250722-reduced-nr-ring-queues_3-v1-3-aa8e37ae97e6@ddn.com>
In-Reply-To: <20250722-reduced-nr-ring-queues_3-v1-3-aa8e37ae97e6@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 24 Jul 2025 16:56:58 -0700
X-Gm-Features: Ac12FXy46p3nHtvIqGWi2lL--2xC68ZwvJGVTtJYBKuiy1al7HLXXQ991KhnPtI
Message-ID: <CAJnrk1ZuoWC7pRy7WRgMnqKGcox=CYXYJLn6kvfAm90SpRN9yg@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: {io-uring} Use bitmaps to track queue availability
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 2:58=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> Add per-CPU and per-NUMA node bitmasks to track which
> io-uring queues are available for new requests.
>
> - Global queue availability (avail_q_mask)
> - Per-NUMA node queue availability (per_numa_avail_q_mask)
> - Global queue registration (registered_q_mask)
> - Per-NUMA node queue registration (numa_registered_q_mask)
>
> Note that these bitmasks are not lock protected, accessing them
> will not be absolutely accurate. Goal is to determine which
> queues are aproximately idle and might be better suited for
> a request.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c   | 99 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/dev_uring_i.h | 18 ++++++++++
>  2 files changed, 117 insertions(+)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 0f5ab27dacb66c9f5f10eac2713d9bd3eb4c26da..c2bc20848bc54541ede928656=
2177994e7ca5879 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> +static int fuse_ring_create_q_masks(struct fuse_ring *ring)
> +{
> +       if (!zalloc_cpumask_var(&ring->avail_q_mask, GFP_KERNEL_ACCOUNT))
> +               return -ENOMEM;
> +
> +       if (!zalloc_cpumask_var(&ring->registered_q_mask, GFP_KERNEL_ACCO=
UNT))
> +               return -ENOMEM;
> +
> +       ring->per_numa_avail_q_mask =3D kcalloc(ring->nr_numa_nodes,
> +                                             sizeof(struct cpumask *),

nit: sizeof(cpumask_var_t) since per_numa_avail_q_mask gets defined in
the struct as a cpumask_var_t?

> +                                             GFP_KERNEL_ACCOUNT);
> +       if (!ring->per_numa_avail_q_mask)
> +               return -ENOMEM;
> +       for (int node =3D 0; node < ring->nr_numa_nodes; node++)

nit: afaik, the general convention has the int declared at top of
function instead of inside loop scope

> +               if (!zalloc_cpumask_var(&ring->per_numa_avail_q_mask[node=
],
> +                                       GFP_KERNEL_ACCOUNT))
> @@ -472,11 +539,18 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
>
>         for (qid =3D 0; qid < ring->max_nr_queues; qid++) {
>                 struct fuse_ring_queue *queue =3D READ_ONCE(ring->queues[=
qid]);
> +               int node;
>
>                 if (!queue)
>                         continue;
>
>                 fuse_uring_teardown_entries(queue);
> +
> +               node =3D queue->numa_node;
> +               cpumask_clear_cpu(qid, ring->registered_q_mask);
> +               cpumask_clear_cpu(qid, ring->avail_q_mask);
> +               cpumask_clear_cpu(qid, ring->numa_registered_q_mask[node]=
);
> +               cpumask_clear_cpu(qid, ring->per_numa_avail_q_mask[node])=
;

Would it be more efficient to clear it all at once (eg
cpumask_clear()) outside the loop instead of clearing it bit by bit
here?

>         }
>
>         if (atomic_read(&ring->queue_refs) > 0) {
> @@ -744,9 +818,18 @@ static int fuse_uring_send_next_to_ring(struct fuse_=
ring_ent *ent,
>  static void fuse_uring_ent_avail(struct fuse_ring_ent *ent,
>                                  struct fuse_ring_queue *queue)
>  {
> +       struct fuse_ring *ring =3D queue->ring;
> +       int node =3D queue->numa_node;
> +
>         WARN_ON_ONCE(!ent->cmd);
>         list_move(&ent->list, &queue->ent_avail_queue);
>         ent->state =3D FRRS_AVAILABLE;
> +
> +       if (list_is_singular(&queue->ent_avail_queue) &&

Did you mean to include "list_is_singular()" here? I think even if
queue->ent_avail_queue has more than one entry on it, we still need to
run this loop in case it previously used to be the case that
queue->nr_reqs >=3D FUSE_URING_QUEUE_THRESHOLD?

> +           queue->nr_reqs <=3D FUSE_URING_QUEUE_THRESHOLD) {

Should this be <? Afaict, if queue->nr_reqs =3D=3D
FUSE_URING_QUEUE_THRESHOLD then it's considered full (and no longer
available)?

> +               cpumask_set_cpu(queue->qid, ring->avail_q_mask);
> +               cpumask_set_cpu(queue->qid, ring->per_numa_avail_q_mask[n=
ode]);
> +       }
>  }
>
>  /* Used to find the request on SQE commit */
> @@ -769,6 +852,8 @@ static void fuse_uring_add_req_to_ring_ent(struct fus=
e_ring_ent *ent,
>                                            struct fuse_req *req)
>  {
>         struct fuse_ring_queue *queue =3D ent->queue;
> +       struct fuse_ring *ring =3D queue->ring;
> +       int node =3D queue->numa_node;
>
>         lockdep_assert_held(&queue->lock);
>
> @@ -783,6 +868,16 @@ static void fuse_uring_add_req_to_ring_ent(struct fu=
se_ring_ent *ent,
>         ent->state =3D FRRS_FUSE_REQ;
>         list_move_tail(&ent->list, &queue->ent_w_req_queue);
>         fuse_uring_add_to_pq(ent, req);
> +
> +       /*
> +        * If there are no more available entries, mark the queue as unav=
ailable
> +        * in both global and per-NUMA node masks
> +        */
> +       if (list_empty(&queue->ent_avail_queue)) {
> +               cpumask_clear_cpu(queue->qid, ring->avail_q_mask);
> +               cpumask_clear_cpu(queue->qid,
> +                                 ring->per_numa_avail_q_mask[node]);
> +       }
>  }
>
>  /* Fetch the next fuse request if available */
> @@ -982,6 +1077,7 @@ static void fuse_uring_do_register(struct fuse_ring_=
ent *ent,
>         struct fuse_ring *ring =3D queue->ring;
>         struct fuse_conn *fc =3D ring->fc;
>         struct fuse_iqueue *fiq =3D &fc->iq;
> +       int node =3D queue->numa_node;
>
>         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
>
> @@ -990,6 +1086,9 @@ static void fuse_uring_do_register(struct fuse_ring_=
ent *ent,
>         fuse_uring_ent_avail(ent, queue);
>         spin_unlock(&queue->lock);
>
> +       cpumask_set_cpu(queue->qid, ring->registered_q_mask);
> +       cpumask_set_cpu(queue->qid, ring->numa_registered_q_mask[node]);
> +
>         if (!ring->ready) {
>                 bool ready =3D is_ring_ready(ring, queue->qid);
>
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 708412294982566919122a1a0d7f741217c763ce..0457dbc6737c8876dd7a7d4c9=
c724da05e553e6a 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -125,6 +131,18 @@ struct fuse_ring {
>          */
>         unsigned int stop_debug_log : 1;
>
> +       /* Tracks which queues are available (empty) globally */

nit: is "(empty)" accurate here? afaict, the queue is available as
long as it has <=3D FUSE_URING_QUEUE_THRESHOLD requests (eg even if it's
not empty)?

> +       cpumask_var_t avail_q_mask;

Should avail_q_mask  also get set accordingly when requests are queued
(eg fuse_uring_queue_fuse_req(), fuse_uring_queue_bq_req()) or
completed by userspace (eg fuse_uring_req_end()), if they meet
FUSE_URING_QUEUE_THRESHOLD?


Thanks,
Joanne
> +

