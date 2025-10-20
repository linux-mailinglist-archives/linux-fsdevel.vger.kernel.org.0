Return-Path: <linux-fsdevel+bounces-64792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39929BF3F96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 01:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 044A74E8B6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA73A238D52;
	Mon, 20 Oct 2025 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imgX5bsw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A328136F
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001212; cv=none; b=kLJq5e2qBHSSrBHAA7X4dG8wduFlLGWkimZhiA8QxUTU9VXcVRHglYJ5IeSleKil1SJpzIMcxlYmkI+uiccVmmAvId2xREXHR2vbVl5gumFbtwjM4kSjLV6rsWoLodTk9GvAiZBUWJBYd8oVUeNJP4wp9jrUdBOkro1yjJRSU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001212; c=relaxed/simple;
	bh=pSI2VeN9VGXVzCyoHOrDz9byH3dFRumaCOthPZ5kYmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eULU/5z3WrTl9CwJDxKXKzb2ACo6NHPG0/P8wAQCtYYoS03x5n4jfMBx81wwmpdfiKGg/f5nWMUbqnkDAa6Shbcg/29YHKv/BjdLpLWVMCbLty0tHcoa0w2EGf6gxXovT9UM2JwEljmIY2oq2yS4KDW+gzDqms7JrHEEy/kGvL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imgX5bsw; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88f2aebce7fso745856285a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761001205; x=1761606005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nbgqWVpSo9Zd3gNi8vrt7AlPcSgtpfCDH8TIAOiN2M=;
        b=imgX5bswxFY/j5/C6s/JylPRXHep/zH5PfqzTR1wuQbovbokFvqy8X5H71EGvJpDrR
         pzuifO9Vq+iRmsismewvBYi7MBQ5kcjICO9GdJJWQY6b7RUBlA0FKvnYxrlECrW5uROr
         ljBIRmp5zOXUa2STgbb6Kgnoq46R8ICe1j9AC1CJxZbb0jlpZd68GX/wCQdhpDVjBUyO
         AHX+EAiLd2yq+Lv12pcTSQ7d58wOqpEzJMHL3X+DM1ac8ZmB/qwP2d5k8ksO49UEN4zG
         rhf2tOxVvt26zV+Xl7U92yMbgvHo7V6X9iWAMuCeCz//6DZYYS8YxC1wZE27M9Qai4u3
         os9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761001205; x=1761606005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nbgqWVpSo9Zd3gNi8vrt7AlPcSgtpfCDH8TIAOiN2M=;
        b=YECP5hR74/1jH4ZKyd43kOQGKQFxh5707QSQNicNCmaweAPAX5eCKSukJzjP/Ofsqv
         VaZRriV+Kk+WoyAG/LjWrNnxoz9+gBBGkmktPLobiBXLVkfaCdiL1V24pi/J3z1H21+z
         W0F34AWu8p7CxnnBBMCGXNPwUN3kGRWuYIUHYE1mrSreyViSuekpWdPYGsqIy4BaVFhO
         K2soj8O1SeQEIrb5RIwY+FxG/XCEksPdQMoph6fYWfvoXUyOubLjuLhsxvXu9yILPvBS
         QyfkqxlJFrA8qBZgOdKu3CpRi/uhfO2PPY3+YiYdmBa5MLNEi3cOCE0+RAAXqPQNVzv9
         UK1g==
X-Forwarded-Encrypted: i=1; AJvYcCVLqvGo0w3Fzv6wT06xm+iC48EE/sEcw7Mkgrf6aMi2S7RRx7R9KLpNvZRNkhVKNk5yToQGKkTe2SdQ/SMb@vger.kernel.org
X-Gm-Message-State: AOJu0YxJeqdiIn3s74yANHFUgnaDwHa28BkSVPoqzaZNbV9Fof8ScRPU
	8nhNiihBSvOQCnLcHdSRTxDAKl2cjle2mF6EVNG8XWr2ZZO65owcaNtDdhJ2hF5LVg5ixHFg/K9
	nQVbFMh2ksfd9/aaIBkAtiuo/bTkHPIc=
X-Gm-Gg: ASbGncuwvQKhL8ZBaJg29cCamVfgF6hnR6qWvjiW8ChlGGTlPY/xcLosKIsVyTXa4Qr
	xDfYp3WaNFM+AHMsJml3veqhAe454E3SvCkpIi50CgMbAShnaxt24kJsPifjwzkQxSZe85339WI
	xdZZBkUZUNdpzekj0smhk6NKk6hFO2GR0SeMRwVbWDeTYFPGYHR8vWjP0HFez/s3eqnwm0t3hcZ
	YGsGU7ZvI6hCRHY7fZMyDL7aFSRNTedkF1voY6myA5+lDs/Pccgax42pYWvoDFhbCluk2eEquss
	lbbJa53tCgM0yMdKEeWFBpxgSC8=
X-Google-Smtp-Source: AGHT+IEZPddfQrZMfI+Lli7cjqt1FTyCpJkjTRfohAujAlhaozZ5EVjQ6kDG/mdIsgyDSStA/9O82MCk4payzXp2eQQ=
X-Received: by 2002:a05:620a:2952:b0:851:cb50:c5d0 with SMTP id
 af79cd13be357-8906e2ce114mr1966770485a.12.1761001205076; Mon, 20 Oct 2025
 16:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
 <20251013-reduced-nr-ring-queues_3-v3-4-6d87c8aa31ae@ddn.com>
 <CAJnrk1YEvQ6yR_1HCQ4Aoxg1h+nXKYfPanuL8emiV1T3MonVfg@mail.gmail.com> <fb571198-c947-4435-aaf4-76932c219889@ddn.com>
In-Reply-To: <fb571198-c947-4435-aaf4-76932c219889@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 20 Oct 2025 15:59:54 -0700
X-Gm-Features: AS18NWAXdQc9I6AenVdRk3P3t0xu4tCv_K6r_oPYwvPInqc9Dts3fbt8J4SECgs
Message-ID: <CAJnrk1b=OJXq7Typ4xaterNPLpEa0q-0OGBMcQ5p14YPkVofyQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] fuse: {io-uring} Distribute load among queues
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Luis Henriques <luis@igalia.com>, 
	Gang He <dchg2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 12:00=E2=80=AFPM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> On 10/18/25 02:12, Joanne Koong wrote:
> > On Mon, Oct 13, 2025 at 10:10=E2=80=AFAM Bernd Schubert <bschubert@ddn.=
com> wrote:
> >>
> >> So far queue selection was only for the queue corresponding
> >> to the current core.
> >> With bitmaps about registered queues and counting of queued
> >> requests per queue, distributing the load is possible now.
> >>
> >> This is on purpose lockless and accurate, under the assumption that a =
lock
> >> between queues might become the limiting factor. Approximate selection
> >> based on queue->nr_reqs should be good enough. If queues get slightly
> >> more requests than given by that counter it should not be too bad,
> >> as number of kernel/userspace transitions gets reduced with higher
> >> queue sizes.
> >>
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >> ---
> >>  fs/fuse/dev_uring.c | 92 ++++++++++++++++++++++++++++++++++++++++++++=
++++-----
> >>  1 file changed, 84 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >> index 02c4b40e739c7aa43dc1c581d4ff1f721617cc79..92401adecf813b1c4570d9=
25718be772c8f02975 100644
> >> --- a/fs/fuse/dev_uring.c
> >> +++ b/fs/fuse/dev_uring.c
> >> @@ -19,6 +19,10 @@ MODULE_PARM_DESC(enable_uring,
> >>
> >>  #define FUSE_URING_IOV_SEGS 2 /* header and payload */
> >>
> >> +/* Number of queued fuse requests until a queue is considered full */
> >> +#define FURING_Q_LOCAL_THRESHOLD 2
> >> +#define FURING_Q_NUMA_THRESHOLD (FURING_Q_LOCAL_THRESHOLD + 1)
> >> +#define FURING_Q_GLOBAL_THRESHOLD (FURING_Q_LOCAL_THRESHOLD * 2)
> >>
> >>  bool fuse_uring_enabled(void)
> >>  {
> >> @@ -1285,22 +1289,94 @@ static void fuse_uring_send_in_task(struct io_=
uring_cmd *cmd,
> >>         fuse_uring_send(ent, cmd, err, issue_flags);
> >>  }
> >>
> >> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_r=
ing *ring)
> >> +/*
> >> + * Pick best queue from mask. Follows the algorithm described in
> >> + * "The Power of Two Choices in Randomized Load Balancing"
> >> + *  (Michael David Mitzenmacher, 1991)
> >> + */
> >> +static struct fuse_ring_queue *fuse_uring_best_queue(const struct cpu=
mask *mask,
> >> +                                                    struct fuse_ring =
*ring)
> >> +{
> >> +       unsigned int qid1, qid2;
> >> +       struct fuse_ring_queue *queue1, *queue2;
> >> +       int weight =3D cpumask_weight(mask);
> >> +
> >> +       if (weight =3D=3D 0)
> >> +               return NULL;
> >> +
> >> +       if (weight =3D=3D 1) {
> >> +               qid1 =3D cpumask_first(mask);
> >> +               return READ_ONCE(ring->queues[qid1]);
> >> +       }
> >> +
> >> +       /* Get two different queues using optimized bounded random */
> >> +       qid1 =3D cpumask_nth(get_random_u32_below(weight), mask);
> >> +       queue1 =3D READ_ONCE(ring->queues[qid1]);
> >> +
> >> +       qid2 =3D cpumask_nth(get_random_u32_below(weight), mask);
> >> +
> >> +       /* Avoid retries and take this queue for code simplicity */
> >> +       if (qid1 =3D=3D qid2)
> >> +               return queue1;
> >> +
> >> +       queue2 =3D READ_ONCE(ring->queues[qid2]);
> >> +
> >> +       if (WARN_ON_ONCE(!queue1 || !queue2))
> >> +               return NULL;
> >> +
> >> +       return (READ_ONCE(queue1->nr_reqs) < READ_ONCE(queue2->nr_reqs=
)) ?
> >> +               queue1 : queue2;
> >> +}
> >> +
> >> +/*
> >> + * Get the best queue for the current CPU
> >> + */
> >> +static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_ring =
*ring)
> >>  {
> >>         unsigned int qid;
> >> -       struct fuse_ring_queue *queue;
> >> +       struct fuse_ring_queue *local_queue, *best_numa, *best_global;
> >> +       int local_node;
> >> +       const struct cpumask *numa_mask, *global_mask;
> >>
> >>         qid =3D task_cpu(current);
> >> -
> >>         if (WARN_ONCE(qid >=3D ring->max_nr_queues,
> >>                       "Core number (%u) exceeds nr queues (%zu)\n", qi=
d,
> >>                       ring->max_nr_queues))
> >>                 qid =3D 0;
> >>
> >> -       queue =3D ring->queues[qid];
> >> -       WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
> >> +       local_queue =3D READ_ONCE(ring->queues[qid]);
> >> +       local_node =3D cpu_to_node(qid);
> >> +       if (WARN_ON_ONCE(local_node > ring->nr_numa_nodes))
> >> +               local_node =3D 0;
> >>
> >> -       return queue;
> >> +       /* Fast path: if local queue exists and is not overloaded, use=
 it */
> >> +       if (local_queue &&
> >> +           READ_ONCE(local_queue->nr_reqs) <=3D FURING_Q_LOCAL_THRESH=
OLD)
> >> +               return local_queue;
> >> +
> >> +       /* Find best NUMA-local queue */
> >> +       numa_mask =3D ring->numa_registered_q_mask[local_node];
> >> +       best_numa =3D fuse_uring_best_queue(numa_mask, ring);
> >> +
> >> +       /* If NUMA queue is under threshold, use it */
> >> +       if (best_numa &&
> >> +           READ_ONCE(best_numa->nr_reqs) <=3D FURING_Q_NUMA_THRESHOLD=
)
> >> +               return best_numa;
> >> +
> >> +       /* NUMA queues above threshold, try global queues */
> >> +       global_mask =3D ring->registered_q_mask;
> >> +       best_global =3D fuse_uring_best_queue(global_mask, ring);
> >> +
> >> +       /* Might happen during tear down */
> >> +       if (!best_global)
> >> +               return NULL;
> >> +
> >> +       /* If global queue is under double threshold, use it */
> >> +       if (READ_ONCE(best_global->nr_reqs) <=3D FURING_Q_GLOBAL_THRES=
HOLD)
> >> +               return best_global;
> >> +
> >> +       /* There is no ideal queue, stay numa_local if possible */
> >> +       return best_numa ? best_numa : best_global;
> >>  }
> >
> > Hi Bernd,
> >
> > I started looking a bit at the block layer blk-mq.c code because, as I
> > understand it, they have to address this same problem of allocating
> > requests to queues while taking into account NUMA locality.
> >
> > I haven't looked at the code deeply yet but I think what it does is
> > maintain a static mapping (that considers numa topology) of cpus to
> > queues which then makes queue selection very simple with minimal
> > overhead. For distributing load, I think it relies on the CPU
> > scheduler to distribute application tasks fairly across CPUs rather
> > than doing load balancing itself (which would also then have to break
> > numa locality if the request gets moved to a different queue).
> > Regarding load balancing, my read of this patch is that it uses the
> > number of current requests on queues as the metric of load but I'm not
> > sure that's accurate - for example, some requests may be more
> > intensive (eg fetching a read over a network) where even if there's
> > only a few requests on that queue, that queue could still be more
> > loaded with higher latency than other queues.
> >
> > I'm curious to hear your thoughts on whether you think a simple
> > mapping solution like what the block layer does would suffice or not
> > for fuse uring queue selection.
>
Hi Bernd,

Thanks for your reply and for sharing your thoughts on this.

>
> Hi Joanne,
>
> thanks for looking at the patch. I think we have primarily a static
> mapping? For completeness, please also look at the patch 6/6, which
> updates queue selection. Basically with patch 6/6 we have static
> mapping to the local queue, with neighbor queues as retries. I
> had already answered Luis question - I can show that retries
> to the neighbor QIDs improves performance, at least for fio's
> '--ioengine=3Dio_uring --numjobs=3D{1..8} --iodepth=3D{8..128} --direct=
=3D1'.
>
> So that leaves the fallback to random QIDs - I don't have strong
> opinion about that, but I don't think the CPU scheduler can handle it.
> Let's say you are doing write-back to a single file and let's say
> fuse is tuned to allow lot's of dirty pages. How should the scheduler
> be able to distribute single threaded dirty page flush? Especially

For writeback, I believe the writeback workqueue is unbound (I'm
seeing bdi_wq allocated with WQ_UNBOUND in default_bid_init()) to any
cpu. As I understand it, the worker thread can be migrated by the
scheduler which will distribute writing back dirty data across
multiple cpus as it sees fit.

> also see in patch 6/6 that we really want to have a different CPU
> to handle async data - the cpu scheduler will not even try to move the
> the application or migration thread to a different cpu, because
> there is no conflict. And for cpu cache, C-states and frequency,
> we actually also want to the scheduler to limit migration to
> absolutely minimum.
>
> Another choice instead of random fallback would be to distribute
> requests to neighbor queues within FURING_NEXT_QUEUE_RETRIES.
> Maybe that would even give better peformance, as random queues so
> far didn't have a positive effect in my testing.
>
> The kind of ideal queue selection for async requests seems to be
> to fill a queue and then to move to the next qid, within a numa
> domain. I just hadn't found a way to do that lockless yet.
>
> Regarding usage of number of requests - I guess there always
> will be workloads where the algorithm isn't perfect - see the
> scheduler wake discussion. Maybe we can find a way in the future
> to map queued requests in fuse-daemon and then use that + number
> of unhandled io-uring CQEs to know if a queue is busy. Any chance
> we can do it step by step?
>
> I don't have a big problem to remove
> the random queue selection fallback, but also would be good
> to have Miklos' opinion - Miklos had some concerns in September

I agree, it'd be good to have Miklos's opinion on this and go with that.

My opinion looking at this is that the fuse uring problem of
distributing requests to queues is very similar to what the block
layer has to do with assigning bio submissions to hardware queues. The
block layer's solution to me seems more elegantly simple and flows
organically with the cpu scheduler's internal load balancing. I think
we should try to keep things as simple as possible, as I don't see how
the optimizations with the custom load balancing we're doing here can
be accurate enough to warrant the extra complexity and overhead.

But I defer to whatever approach you and Miklos think is best and
would rather go with.

Thanks,
Joanne

> last year that queues/ring-threads might end up being unused,
> although they could take requests...
>
>
> Thanks,
> Bernd
>
>
>

