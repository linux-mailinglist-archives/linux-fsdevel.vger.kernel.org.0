Return-Path: <linux-fsdevel+bounces-65540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B2C0776F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AE2735C4A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5F32E74C;
	Fri, 24 Oct 2025 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkC/meZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C4342CB8
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325560; cv=none; b=IzybZZ7JDoGOR/4GNLdsbBvHBrC7IWvTTWEwHv54HitqK2kUVGhj+akrC/iw9mILsSAMt6TPY2OTioLl++EtgzGYVIEPML50scuyHpDb/tViAPi3h7BydFSnlMK4NIQqOkhAGAw+quCrpM0vtE+9ULgR9lOBTisneu/H3QiY+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325560; c=relaxed/simple;
	bh=/E++uXaBszuAeYcON+oULT1zkt6vaZU2Ct9r4sWts/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6sHFIA9mZltGb2QVEyhjQFq84kwbUT5QD2kg0nTe+FniR+cV/Mlc7swkFvVBuNwjvvh/i1VfCCPIlCEPAZknD+U1daUQVlnivLGixsscDzpW/bzXMelpee2vVojSdc7kjtdVfUG0ywAKOzpoUNMasPxYzylJkIxckptJFLx990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkC/meZf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e88dbe8b77so19255131cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761325557; x=1761930357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s5CHw9as854CmHgIAN/Z5J2YMEI5C8PGSpNwUjVvUM=;
        b=CkC/meZfU/fnjKQKQbPJx+7aKC13srAhvq4PCz7UCyoJ/ZdOr/falwiyasp8TKBWwS
         WUg5FiROEXDkXWKWtSfJOjU1w2S0vuntwkpk9tL8mC3g/YfcHOjCZ0YAYtdoSdHBgH0U
         KxZtTCmhAtHAUk52fk9d4i39EQw+YwYXAz09IGQf4Mjg9/QFk1zJXfjJDuQ6eg1FNR1B
         wf5SRWYGAywPnyDlPUcXmX26Kz/9ER7U1XfaPWTaTzC1bf3CYFeFuGMZDBFOHWIFBTSc
         1o69M0fx5zY6f5+R6qlq/Ym9xtLz4QX22D+8BCkzf5NVvIWi7smKX97F3BpOQiaZgTM3
         YLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761325557; x=1761930357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s5CHw9as854CmHgIAN/Z5J2YMEI5C8PGSpNwUjVvUM=;
        b=m/83Yy53k0sM3oajNnkaq4u7F0pak2V+6vhR8OleFN64nAo+fdEnOrVML9CsuP6bph
         VSHvpyNALMpZ1tGnYGlsD11BkwRt6xEhaw+QO4xn37HZiQU1AkHWWLflU9fZdxPia+s8
         ZqWU9IaqW6OIzjopRJzTqWTzvRYsFkG7+oVVg23dftjpRwCWLK4WkCRecC3bG5W930rn
         BXLtCvQb/ty+vrmACiJiLZ8LqQ82Gt44WynBXPqbjAFqVG7ckug71i6+MccCTul3w6zU
         DffapF7QecHsKmsbzIjfwr3n/5FPlvmqxStwgqU9JtURRS2oPP6WE5Yhnka/fiSJyRNx
         0QOw==
X-Forwarded-Encrypted: i=1; AJvYcCUUlFZBGIcPnbEHmpN6Q2Al0w19pbht2qcy4uoF1nJzFAUwdFOxKSh93YauNcxk6yjtisZG/YDHD4FqBBMy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzir6llJbK4bNd1dw/OfCfqu9xia3UzJJdsXHTWzXCZVgQQW24r
	4I80xaocVeBlXl7ZsIL3jQy7IiZbMPgCfRjyNflC0xhGNBezl5c9Dto/4BnVEN89a/EyK4wua+x
	NAYYqoPZG8X9k9ZTJlouxuixevRNfv+Q=
X-Gm-Gg: ASbGncuWX4uUIBpwWjWvS9QrYOPKMho1qXkONFofoqnCTXSpBJ7Pa+SRrZAM9CEoG3I
	pV7dKLsf4YMS0hBGJtDaWHRJQlWDr4i2EoqPlMgC7MuMc+bSCGTxAcmXpV+lGbIwd2Y8LrHLnlW
	GCVllmwZRzDB6Fp0Xs39umUbQRopLIedovAj0sw8TJvk2FG+wAAhgOm0HRyUsL3RZllm9KiiX/4
	q0RBKiRexYfsQhMcWutbdJyAysw2JDXf9L5K17fWap0XvLqjQdANHRNw48I4tUd8VK0GFepe13Y
	7O1IKvDP6ftNkMfW1t0hqpQD+Q==
X-Google-Smtp-Source: AGHT+IEei1npI/rvun+oayAJ6gDcfPkdXdqVpDuVDNwyzd7rSEFe/5aAhJarx4sEt/UsgRyXxOACVJE11Uw66Zf+H/g=
X-Received: by 2002:ac8:7d88:0:b0:4b3:104:792c with SMTP id
 d75a77b69052e-4eb949095dbmr38756581cf.57.1761325556925; Fri, 24 Oct 2025
 10:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
 <20251013-reduced-nr-ring-queues_3-v3-4-6d87c8aa31ae@ddn.com>
 <CAJnrk1YEvQ6yR_1HCQ4Aoxg1h+nXKYfPanuL8emiV1T3MonVfg@mail.gmail.com>
 <fb571198-c947-4435-aaf4-76932c219889@ddn.com> <CAJnrk1b=OJXq7Typ4xaterNPLpEa0q-0OGBMcQ5p14YPkVofyQ@mail.gmail.com>
In-Reply-To: <CAJnrk1b=OJXq7Typ4xaterNPLpEa0q-0OGBMcQ5p14YPkVofyQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Oct 2025 10:05:45 -0700
X-Gm-Features: AS18NWDSIyQ2gEMLE8JZ7eThG_2FKiSTTDMpbGBKP2472Fx1bdLT7HV0GfOfxQg
Message-ID: <CAJnrk1bNbdpsNDkYRG5BQAQMBp5Yb64WszOQ01Dffp9qu-p60A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] fuse: {io-uring} Distribute load among queues
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Luis Henriques <luis@igalia.com>, 
	Gang He <dchg2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 3:59=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Oct 20, 2025 at 12:00=E2=80=AFPM Bernd Schubert <bschubert@ddn.co=
m> wrote:
> >
> > On 10/18/25 02:12, Joanne Koong wrote:
> > > On Mon, Oct 13, 2025 at 10:10=E2=80=AFAM Bernd Schubert <bschubert@dd=
n.com> wrote:
> > >>
> > >> So far queue selection was only for the queue corresponding
> > >> to the current core.
> > >> With bitmaps about registered queues and counting of queued
> > >> requests per queue, distributing the load is possible now.
> > >>
> > >> This is on purpose lockless and accurate, under the assumption that =
a lock
> > >> between queues might become the limiting factor. Approximate selecti=
on
> > >> based on queue->nr_reqs should be good enough. If queues get slightl=
y
> > >> more requests than given by that counter it should not be too bad,
> > >> as number of kernel/userspace transitions gets reduced with higher
> > >> queue sizes.
> > >>
> > >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > >> ---
> > >>  fs/fuse/dev_uring.c | 92 ++++++++++++++++++++++++++++++++++++++++++=
++++++-----
> > >>  1 file changed, 84 insertions(+), 8 deletions(-)
> > >>
> > >> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > >> index 02c4b40e739c7aa43dc1c581d4ff1f721617cc79..92401adecf813b1c4570=
d925718be772c8f02975 100644
> > >> --- a/fs/fuse/dev_uring.c
> > >> +++ b/fs/fuse/dev_uring.c
> > >> @@ -19,6 +19,10 @@ MODULE_PARM_DESC(enable_uring,
> > >>
> > >>  #define FUSE_URING_IOV_SEGS 2 /* header and payload */
> > >>
> > >> +/* Number of queued fuse requests until a queue is considered full =
*/
> > >> +#define FURING_Q_LOCAL_THRESHOLD 2
> > >> +#define FURING_Q_NUMA_THRESHOLD (FURING_Q_LOCAL_THRESHOLD + 1)
> > >> +#define FURING_Q_GLOBAL_THRESHOLD (FURING_Q_LOCAL_THRESHOLD * 2)
> > >>
> > >>  bool fuse_uring_enabled(void)
> > >>  {
> > >> @@ -1285,22 +1289,94 @@ static void fuse_uring_send_in_task(struct i=
o_uring_cmd *cmd,
> > >>         fuse_uring_send(ent, cmd, err, issue_flags);
> > >>  }
> > >>
> > >> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse=
_ring *ring)
> > >> +/*
> > >> + * Pick best queue from mask. Follows the algorithm described in
> > >> + * "The Power of Two Choices in Randomized Load Balancing"
> > >> + *  (Michael David Mitzenmacher, 1991)
> > >> + */
> > >> +static struct fuse_ring_queue *fuse_uring_best_queue(const struct c=
pumask *mask,
> > >> +                                                    struct fuse_rin=
g *ring)
> > >> +{
> > >> +       unsigned int qid1, qid2;
> > >> +       struct fuse_ring_queue *queue1, *queue2;
> > >> +       int weight =3D cpumask_weight(mask);
> > >> +
> > >> +       if (weight =3D=3D 0)
> > >> +               return NULL;
> > >> +
> > >> +       if (weight =3D=3D 1) {
> > >> +               qid1 =3D cpumask_first(mask);
> > >> +               return READ_ONCE(ring->queues[qid1]);
> > >> +       }
> > >> +
> > >> +       /* Get two different queues using optimized bounded random *=
/
> > >> +       qid1 =3D cpumask_nth(get_random_u32_below(weight), mask);
> > >> +       queue1 =3D READ_ONCE(ring->queues[qid1]);
> > >> +
> > >> +       qid2 =3D cpumask_nth(get_random_u32_below(weight), mask);
> > >> +
> > >> +       /* Avoid retries and take this queue for code simplicity */
> > >> +       if (qid1 =3D=3D qid2)
> > >> +               return queue1;
> > >> +
> > >> +       queue2 =3D READ_ONCE(ring->queues[qid2]);
> > >> +
> > >> +       if (WARN_ON_ONCE(!queue1 || !queue2))
> > >> +               return NULL;
> > >> +
> > >> +       return (READ_ONCE(queue1->nr_reqs) < READ_ONCE(queue2->nr_re=
qs)) ?
> > >> +               queue1 : queue2;
> > >> +}
> > >> +
> > >> +/*
> > >> + * Get the best queue for the current CPU
> > >> + */
> > >> +static struct fuse_ring_queue *fuse_uring_get_queue(struct fuse_rin=
g *ring)
> > >>  {
> > >>         unsigned int qid;
> > >> -       struct fuse_ring_queue *queue;
> > >> +       struct fuse_ring_queue *local_queue, *best_numa, *best_globa=
l;
> > >> +       int local_node;
> > >> +       const struct cpumask *numa_mask, *global_mask;
> > >>
> > >>         qid =3D task_cpu(current);
> > >> -
> > >>         if (WARN_ONCE(qid >=3D ring->max_nr_queues,
> > >>                       "Core number (%u) exceeds nr queues (%zu)\n", =
qid,
> > >>                       ring->max_nr_queues))
> > >>                 qid =3D 0;
> > >>
> > >> -       queue =3D ring->queues[qid];
> > >> -       WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
> > >> +       local_queue =3D READ_ONCE(ring->queues[qid]);
> > >> +       local_node =3D cpu_to_node(qid);
> > >> +       if (WARN_ON_ONCE(local_node > ring->nr_numa_nodes))
> > >> +               local_node =3D 0;
> > >>
> > >> -       return queue;
> > >> +       /* Fast path: if local queue exists and is not overloaded, u=
se it */
> > >> +       if (local_queue &&
> > >> +           READ_ONCE(local_queue->nr_reqs) <=3D FURING_Q_LOCAL_THRE=
SHOLD)
> > >> +               return local_queue;
> > >> +
> > >> +       /* Find best NUMA-local queue */
> > >> +       numa_mask =3D ring->numa_registered_q_mask[local_node];
> > >> +       best_numa =3D fuse_uring_best_queue(numa_mask, ring);
> > >> +
> > >> +       /* If NUMA queue is under threshold, use it */
> > >> +       if (best_numa &&
> > >> +           READ_ONCE(best_numa->nr_reqs) <=3D FURING_Q_NUMA_THRESHO=
LD)
> > >> +               return best_numa;
> > >> +
> > >> +       /* NUMA queues above threshold, try global queues */
> > >> +       global_mask =3D ring->registered_q_mask;
> > >> +       best_global =3D fuse_uring_best_queue(global_mask, ring);
> > >> +
> > >> +       /* Might happen during tear down */
> > >> +       if (!best_global)
> > >> +               return NULL;
> > >> +
> > >> +       /* If global queue is under double threshold, use it */
> > >> +       if (READ_ONCE(best_global->nr_reqs) <=3D FURING_Q_GLOBAL_THR=
ESHOLD)
> > >> +               return best_global;
> > >> +
> > >> +       /* There is no ideal queue, stay numa_local if possible */
> > >> +       return best_numa ? best_numa : best_global;
> > >>  }
> > >
> > > Hi Bernd,
> > >
> > > I started looking a bit at the block layer blk-mq.c code because, as =
I
> > > understand it, they have to address this same problem of allocating
> > > requests to queues while taking into account NUMA locality.
> > >
> > > I haven't looked at the code deeply yet but I think what it does is
> > > maintain a static mapping (that considers numa topology) of cpus to
> > > queues which then makes queue selection very simple with minimal
> > > overhead. For distributing load, I think it relies on the CPU
> > > scheduler to distribute application tasks fairly across CPUs rather
> > > than doing load balancing itself (which would also then have to break
> > > numa locality if the request gets moved to a different queue).
> > > Regarding load balancing, my read of this patch is that it uses the
> > > number of current requests on queues as the metric of load but I'm no=
t
> > > sure that's accurate - for example, some requests may be more
> > > intensive (eg fetching a read over a network) where even if there's
> > > only a few requests on that queue, that queue could still be more
> > > loaded with higher latency than other queues.
> > >
> > > I'm curious to hear your thoughts on whether you think a simple
> > > mapping solution like what the block layer does would suffice or not
> > > for fuse uring queue selection.
> >
> Hi Bernd,
>
> Thanks for your reply and for sharing your thoughts on this.
>
> >
> > Hi Joanne,
> >
> > thanks for looking at the patch. I think we have primarily a static
> > mapping? For completeness, please also look at the patch 6/6, which
> > updates queue selection. Basically with patch 6/6 we have static
> > mapping to the local queue, with neighbor queues as retries. I
> > had already answered Luis question - I can show that retries
> > to the neighbor QIDs improves performance, at least for fio's
> > '--ioengine=3Dio_uring --numjobs=3D{1..8} --iodepth=3D{8..128} --direct=
=3D1'.
> >
> > So that leaves the fallback to random QIDs - I don't have strong
> > opinion about that, but I don't think the CPU scheduler can handle it.
> > Let's say you are doing write-back to a single file and let's say
> > fuse is tuned to allow lot's of dirty pages. How should the scheduler
> > be able to distribute single threaded dirty page flush? Especially
>
> For writeback, I believe the writeback workqueue is unbound (I'm
> seeing bdi_wq allocated with WQ_UNBOUND in default_bid_init()) to any
> cpu. As I understand it, the worker thread can be migrated by the
> scheduler which will distribute writing back dirty data across
> multiple cpus as it sees fit.
>
> > also see in patch 6/6 that we really want to have a different CPU
> > to handle async data - the cpu scheduler will not even try to move the
> > the application or migration thread to a different cpu, because
> > there is no conflict. And for cpu cache, C-states and frequency,
> > we actually also want to the scheduler to limit migration to
> > absolutely minimum.
> >
> > Another choice instead of random fallback would be to distribute
> > requests to neighbor queues within FURING_NEXT_QUEUE_RETRIES.
> > Maybe that would even give better peformance, as random queues so
> > far didn't have a positive effect in my testing.
> >
> > The kind of ideal queue selection for async requests seems to be
> > to fill a queue and then to move to the next qid, within a numa
> > domain. I just hadn't found a way to do that lockless yet.
> >
> > Regarding usage of number of requests - I guess there always
> > will be workloads where the algorithm isn't perfect - see the
> > scheduler wake discussion. Maybe we can find a way in the future
> > to map queued requests in fuse-daemon and then use that + number
> > of unhandled io-uring CQEs to know if a queue is busy. Any chance
> > we can do it step by step?
> >
> > I don't have a big problem to remove
> > the random queue selection fallback, but also would be good
> > to have Miklos' opinion - Miklos had some concerns in September
>
> I agree, it'd be good to have Miklos's opinion on this and go with that.
>
> My opinion looking at this is that the fuse uring problem of
> distributing requests to queues is very similar to what the block
> layer has to do with assigning bio submissions to hardware queues. The
> block layer's solution to me seems more elegantly simple and flows
> organically with the cpu scheduler's internal load balancing. I think
> we should try to keep things as simple as possible, as I don't see how
> the optimizations with the custom load balancing we're doing here can
> be accurate enough to warrant the extra complexity and overhead.
>
> But I defer to whatever approach you and Miklos think is best and
> would rather go with.

Miklos, could you share your thoughts on how we should approach this?

Thanks,
Joanne
>
> Thanks,
> Joanne
>
> > last year that queues/ring-threads might end up being unused,
> > although they could take requests...
> >
> >
> > Thanks,
> > Bernd
> >
> >
> >

