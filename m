Return-Path: <linux-fsdevel+bounces-64560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57510BEC241
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 02:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32A71AE18DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 00:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B933EC;
	Sat, 18 Oct 2025 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDdBwuqF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A30D515
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746341; cv=none; b=hlHRckA2+fZXw5gjpqyrnCepTr7bZB5hkijcL7T2bRmUPsQbuKoYou6jgW/pHryd447yU67OS1JmOQ0TzssRfLN4GYyNs9IvfEb6cDAl8KFcfGhtd8Pqltj4j/HwtfQwoxzLgs5Lnb8ohcDsxsyJ8Iuu47hlXMuId18cnzc7j4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746341; c=relaxed/simple;
	bh=5TRDf7+HtBABCr53xOrZoQHhAl+YmjCDFnw82KoAXhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1b0XxZBcQr04WBAm+w8JABQm1B51QcbmGJxrOJFBHzLcCa0ygAAZaHPWOliy2diNC2Eoe/gOJmX9M4JvrQNR5FKkj4VtwdRcr0W/pE5Euyd4QcWoYf2qzaY+j5qCa+lEtIerBFsGaml1S8LEKXGEKY0RBzYFw/ruabvi/kNkNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDdBwuqF; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88f8e855b4eso212534085a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 17:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760746339; x=1761351139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv7WhRnru+UFgIk87D8oiAsYsLl7NzLWRmDxO0jSmgE=;
        b=PDdBwuqFjBzYZiUP1EHW15Ti54wNIkzYY8vzi25o/Qk2qtCE13sRn6MtVyPBSd/yjv
         GuAvT/U1D1ET09vIF87G0QvJln9Ki7B3kw135651ciNT3SKmkc9u1gghypCFBvim3pUL
         HknmET5I3kQUPWfZv8gAtKVxSEV3LIdqxTKGeeMyfE8mspcuZij46BudYZqh3f67pG15
         72c2IWMAXIv4jvS8uVUmNxKmpWBUrlaxCogGu/i6LFNjFZIIJNphfy/KROSHKO3+yAvI
         2m43WKdIg4HAxXHkDqedeWYb3IRyr0KaIO10bipFgCgiMFQyhPAdzN81KohYAHMt7W59
         k94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746339; x=1761351139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv7WhRnru+UFgIk87D8oiAsYsLl7NzLWRmDxO0jSmgE=;
        b=GaQYBdHfQxK5KhvFvDIAoSvZPV8EwAb+2gPgshlqQL5RoC1aL2o8nxujUzWl7TFulJ
         jMSXmahVq01UnX++LkfBziNeMOu/H2jVUhDMBcfy1RQi4l98h/XWZwSweqojEFgru5F2
         uFsV3Dgz0lVMhIrgX78Q89LTPIlaJ4Q/HRfY4QbsiaaMdVOhOVMlt0gY67wOKJNvyP6u
         fjagO2bXxZ2DAIa0utUUh3cEem0hMSkXwy8w51dxufTu6KznohJUJ/oZXvPTNYOBRiLL
         gwE7n3SI9YhnfleXW9GgE9ltzTuCpBs/goa8qvmPPrW1kokPWANSjXZ88UI8YGwg94Hf
         pDQA==
X-Forwarded-Encrypted: i=1; AJvYcCVeiOnZnN9pzG5ZRq2ktE/WX7j18cVfLhLSrJ7cSl3tvqaZj3guv2Brr7/jWPnyzYCAhlmSl+NaNwUB1bHq@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsDyKfMG/ThBc5KlQFJJE61lIEN2sM/O4Tvj9FYha1i4OwDKG
	LDYcCWIZQAlhLCSCcMJWWYfNgO3rbL5sdFSXn+CUMPD89leoz1HD4K3dp9NvuQiP+1iryAnQbCn
	Q29yn+BaSNtEihbZ1FiWO8Kes/Z7ZoNk=
X-Gm-Gg: ASbGncvW0/RxMBpFQgw5gtzAVLt3jOl/jnwtmJehOGgR/XSABUUWf9lQw9ItLvd4oRw
	K/jqyfKS9iLWcwOwZtv7LJ7TKAD+k6jZK13oX5AWPytygQo9SHxdKt+9xH1CcqktUQE4YRCnPtF
	b0lCYiKBXJt/qM8JvKH/Kz0MWIn4tCdFuP3Fn66u54u7ENeB3yNgtKpjzZK5obXZookIuad5BP9
	/sM0lW/KvGfp0DAQkbBl48OtrUhc2Pp1JmEpvWI8E3U5Onx9AEY9CpbZAx81j9/5O52a1t8Nml1
	utVkBky3YP6Ic18qp/ju+PFXWM0=
X-Google-Smtp-Source: AGHT+IEFkNA24Bfc2hcPeRldDC6hJhriCm0iTr9rWVk/ERnr3vYpKaGnNcCCLgWc4qAk2g9kO9xVnJH/kJICdftXuaA=
X-Received: by 2002:ac8:5e47:0:b0:4e8:b0cb:ebba with SMTP id
 d75a77b69052e-4e8b0cbf13fmr2001351cf.32.1760746338716; Fri, 17 Oct 2025
 17:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com> <20251013-reduced-nr-ring-queues_3-v3-4-6d87c8aa31ae@ddn.com>
In-Reply-To: <20251013-reduced-nr-ring-queues_3-v3-4-6d87c8aa31ae@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Oct 2025 17:12:08 -0700
X-Gm-Features: AS18NWAsl8x42PNUEgc51xcGP0o0IKd7uVJTBTl-c5Q1DuLmGFlxjJgc0F1NDrQ
Message-ID: <CAJnrk1YEvQ6yR_1HCQ4Aoxg1h+nXKYfPanuL8emiV1T3MonVfg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] fuse: {io-uring} Distribute load among queues
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:10=E2=80=AFAM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> So far queue selection was only for the queue corresponding
> to the current core.
> With bitmaps about registered queues and counting of queued
> requests per queue, distributing the load is possible now.
>
> This is on purpose lockless and accurate, under the assumption that a loc=
k
> between queues might become the limiting factor. Approximate selection
> based on queue->nr_reqs should be good enough. If queues get slightly
> more requests than given by that counter it should not be too bad,
> as number of kernel/userspace transitions gets reduced with higher
> queue sizes.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 84 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 02c4b40e739c7aa43dc1c581d4ff1f721617cc79..92401adecf813b1c4570d9257=
18be772c8f02975 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -19,6 +19,10 @@ MODULE_PARM_DESC(enable_uring,
>
>  #define FUSE_URING_IOV_SEGS 2 /* header and payload */
>
> +/* Number of queued fuse requests until a queue is considered full */
> +#define FURING_Q_LOCAL_THRESHOLD 2
> +#define FURING_Q_NUMA_THRESHOLD (FURING_Q_LOCAL_THRESHOLD + 1)
> +#define FURING_Q_GLOBAL_THRESHOLD (FURING_Q_LOCAL_THRESHOLD * 2)
>
>  bool fuse_uring_enabled(void)
>  {
> @@ -1285,22 +1289,94 @@ static void fuse_uring_send_in_task(struct io_uri=
ng_cmd *cmd,
>         fuse_uring_send(ent, cmd, err, issue_flags);
>  }
>
> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring=
 *ring)
> +/*
> + * Pick best queue from mask. Follows the algorithm described in
> + * "The Power of Two Choices in Randomized Load Balancing"
> + *  (Michael David Mitzenmacher, 1991)
> + */
> +static struct fuse_ring_queue *fuse_uring_best_queue(const struct cpumas=
k *mask,
> +                                                    struct fuse_ring *ri=
ng)
> +{
> +       unsigned int qid1, qid2;
> +       struct fuse_ring_queue *queue1, *queue2;
> +       int weight =3D cpumask_weight(mask);
> +
> +       if (weight =3D=3D 0)
> +               return NULL;
> +
> +       if (weight =3D=3D 1) {
> +               qid1 =3D cpumask_first(mask);
> +               return READ_ONCE(ring->queues[qid1]);
> +       }
> +
> +       /* Get two different queues using optimized bounded random */
> +       qid1 =3D cpumask_nth(get_random_u32_below(weight), mask);
> +       queue1 =3D READ_ONCE(ring->queues[qid1]);
> +
> +       qid2 =3D cpumask_nth(get_random_u32_below(weight), mask);
> +
> +       /* Avoid retries and take this queue for code simplicity */
> +       if (qid1 =3D=3D qid2)
> +               return queue1;
> +
> +       queue2 =3D READ_ONCE(ring->queues[qid2]);
> +
> +       if (WARN_ON_ONCE(!queue1 || !queue2))
> +               return NULL;
> +
> +       return (READ_ONCE(queue1->nr_reqs) < READ_ONCE(queue2->nr_reqs)) =
?
> +               queue1 : queue2;
> +}
> +
> +/*
> + * Get the best queue for the current CPU
> + */
> +static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring *ri=
ng)
>  {
>         unsigned int qid;
> -       struct fuse_ring_queue *queue;
> +       struct fuse_ring_queue *local_queue, *best_numa, *best_global;
> +       int local_node;
> +       const struct cpumask *numa_mask, *global_mask;
>
>         qid =3D task_cpu(current);
> -
>         if (WARN_ONCE(qid >=3D ring->max_nr_queues,
>                       "Core number (%u) exceeds nr queues (%zu)\n", qid,
>                       ring->max_nr_queues))
>                 qid =3D 0;
>
> -       queue =3D ring->queues[qid];
> -       WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
> +       local_queue =3D READ_ONCE(ring->queues[qid]);
> +       local_node =3D cpu_to_node(qid);
> +       if (WARN_ON_ONCE(local_node > ring->nr_numa_nodes))
> +               local_node =3D 0;
>
> -       return queue;
> +       /* Fast path: if local queue exists and is not overloaded, use it=
 */
> +       if (local_queue &&
> +           READ_ONCE(local_queue->nr_reqs) <=3D FURING_Q_LOCAL_THRESHOLD=
)
> +               return local_queue;
> +
> +       /* Find best NUMA-local queue */
> +       numa_mask =3D ring->numa_registered_q_mask[local_node];
> +       best_numa =3D fuse_uring_best_queue(numa_mask, ring);
> +
> +       /* If NUMA queue is under threshold, use it */
> +       if (best_numa &&
> +           READ_ONCE(best_numa->nr_reqs) <=3D FURING_Q_NUMA_THRESHOLD)
> +               return best_numa;
> +
> +       /* NUMA queues above threshold, try global queues */
> +       global_mask =3D ring->registered_q_mask;
> +       best_global =3D fuse_uring_best_queue(global_mask, ring);
> +
> +       /* Might happen during tear down */
> +       if (!best_global)
> +               return NULL;
> +
> +       /* If global queue is under double threshold, use it */
> +       if (READ_ONCE(best_global->nr_reqs) <=3D FURING_Q_GLOBAL_THRESHOL=
D)
> +               return best_global;
> +
> +       /* There is no ideal queue, stay numa_local if possible */
> +       return best_numa ? best_numa : best_global;
>  }

Hi Bernd,

I started looking a bit at the block layer blk-mq.c code because, as I
understand it, they have to address this same problem of allocating
requests to queues while taking into account NUMA locality.

I haven't looked at the code deeply yet but I think what it does is
maintain a static mapping (that considers numa topology) of cpus to
queues which then makes queue selection very simple with minimal
overhead. For distributing load, I think it relies on the CPU
scheduler to distribute application tasks fairly across CPUs rather
than doing load balancing itself (which would also then have to break
numa locality if the request gets moved to a different queue).
Regarding load balancing, my read of this patch is that it uses the
number of current requests on queues as the metric of load but I'm not
sure that's accurate - for example, some requests may be more
intensive (eg fetching a read over a network) where even if there's
only a few requests on that queue, that queue could still be more
loaded with higher latency than other queues.

I'm curious to hear your thoughts on whether you think a simple
mapping solution like what the block layer does would suffice or not
for fuse uring queue selection.

Thanks,
Joanne

>
>  static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
> @@ -1321,7 +1397,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *=
fiq, struct fuse_req *req)
>         int err;
>
>         err =3D -EINVAL;
> -       queue =3D fuse_uring_task_to_queue(ring);
> +       queue =3D fuse_uring_get_queue(ring);
>         if (!queue)
>                 goto err;
>
> @@ -1365,7 +1441,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>         struct fuse_ring_queue *queue;
>         struct fuse_ring_ent *ent =3D NULL;
>
> -       queue =3D fuse_uring_task_to_queue(ring);
> +       queue =3D fuse_uring_get_queue(ring);
>         if (!queue)
>                 return false;
>
>
> --
> 2.43.0
>

