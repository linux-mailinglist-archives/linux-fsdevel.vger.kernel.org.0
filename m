Return-Path: <linux-fsdevel+bounces-25919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53BC951CE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 16:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322C3288F05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A49E1B32BC;
	Wed, 14 Aug 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Kv1LNkky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D051B32B8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723645190; cv=none; b=ToYYy5+fB5fnp8f5AAZ/ocQ5ovix5EbWp8dqh1Y4Mk4tojRy/aJtc/SfNnrrbzElJCvYNChCIfOEalezVHqTiWfjC7eyHJYAk9KvxXARFMwohaF7f5EgFxR2bWECPZMG7CUNgiL3vilDxAL0Ko2vZoXCRhqoSpkeJuN5tbFoFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723645190; c=relaxed/simple;
	bh=HVroeHgT75p4mx/kjl9PfYZHiauPCT5X26P0iCgBt8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N607PT+/ch2RNj3GeDqnD2D8rOhUI88yeKrp98blR5XUFx4969mKFa33lodeUi/keFe6L3nmND5cjoLim26My3mMhB0FcFndump+4R0Y1yfR8RIli1b4JEucK+BhGuyWJr3oRC/RKi7X443ggGMw8Mj18mKENSH172lMzj3UDyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Kv1LNkky; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso49528425e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723645187; x=1724249987; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Da9YmzdiApbeXQcXz3ENTfNNAAvA7VbcLD5ruFK2oT8=;
        b=Kv1LNkkyR07JHWqaWkJHxmTRgFcMAuCg2XyA/068C6NbwtoVFqA/Ce85IDHFnNEdUJ
         MGEVPmf11ZaTxOyPK84i+XyGxjuqZTS18R9TzYRZGFhGOM5Qt/PBzs0YFdb5pa6v58Xu
         3IKZB1UJfL72aCXFGl2+rrZIZPT1z1c8QDEF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723645187; x=1724249987;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Da9YmzdiApbeXQcXz3ENTfNNAAvA7VbcLD5ruFK2oT8=;
        b=O5lo5Zqo7jQbfF675y2JJOspl7gmzhncmXsnNIaICL+B6bM8EMCuqZu8Bm214ZXETb
         fuKCwr6DACOf/QP+bj/mynOs41ly0dSdBSwelaqUFcEu+gXG2TbQ8vxZePq2nVixt5Vg
         2zaH0vwT1X00W56gnxvhIA/yCF0ViPUbmZ70m4OalSymyK4EyjgH+izNhFqUZ2yRLwRU
         O1stEZyLvjmgXYG1wurrHlUwyu1w2GtKEcxfRGIaVo/xXT0KRjSy8dbcroXM30+meAWx
         0yU6/tvHizSGdV6AaKemFa7fjidadQ1M7oJYSHQRHjYaaN8u/38qnl/SlWL6/e3qbCmz
         uYLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXxJ7iwbeQfmkFWdO5qwLawodLiJRioe/ljj2LSrdcfXC8h90lsoGVHLSuPY5QlWWtk76fp2JO7wfXDOmDRsmOS9J5dCTLlxTbQAIZKw==
X-Gm-Message-State: AOJu0YyGaTOQV3tXArKDFAHP56DP8bFDhaj6ebKYR8eXkwdkmZRk4X1S
	H63IgGHe1ANryiijSV9JNuBaBz2wC5p3dBeshtxpYEpC7AwzHbOJlbGB82d87O8=
X-Google-Smtp-Source: AGHT+IGjy6UqrgdbSznY5oj8eOp/e9kukvu2+aB5a/gmgZLDw2cmWwT3/5lBN+QfWxZEkEbw6anX3g==
X-Received: by 2002:a05:600c:4e87:b0:426:6158:962d with SMTP id 5b1f17b1804b1-429dd25fa21mr21152715e9.23.1723645187017;
        Wed, 14 Aug 2024 07:19:47 -0700 (PDT)
Received: from LQ3V64L9R2.home ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded32538sm21204145e9.16.2024.08.14.07.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:19:46 -0700 (PDT)
Date: Wed, 14 Aug 2024 15:19:44 +0100
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Message-ID: <Zry9AO5Im6rjW0jm@LQ3V64L9R2.home>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <ZrpuWMoXHxzPvvhL@mini-arch>
 <2bb121dd-3dcd-4142-ab87-02ccf4afd469@uwaterloo.ca>
 <ZrqU3kYgL4-OI-qj@mini-arch>
 <d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
 <Zrq8zCy1-mfArXka@mini-arch>
 <5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
 <Zrrb8xkdIbhS7F58@mini-arch>
 <6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
 <66bc21772c6bd_985bf294b0@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66bc21772c6bd_985bf294b0@willemb.c.googlers.com.notmuch>

On Tue, Aug 13, 2024 at 11:16:07PM -0400, Willem de Bruijn wrote:
> Martin Karsten wrote:
> > On 2024-08-13 00:07, Stanislav Fomichev wrote:
> > > On 08/12, Martin Karsten wrote:
> > >> On 2024-08-12 21:54, Stanislav Fomichev wrote:
> > >>> On 08/12, Martin Karsten wrote:
> > >>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
> > >>>>> On 08/12, Martin Karsten wrote:
> > >>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
> > >>>>>>> On 08/12, Joe Damato wrote:

[...]

> > >>
> > >> One of the goals of this patch set is to reduce parameter tuning and make
> > >> the parameter setting independent of workload dynamics, so it should make
> > >> things easier. This is of course notwithstanding that per-napi settings
> > >> would be even better.
> 
> I don't follow how adding another tunable reduces parameter tuning.

Thanks for taking a look and providing valuable feedback, Willem.

An early draft of the cover letter included some paragraphs which were removed
for the sake of brevity that we can add back in, which addresses your comment
above:

 The existing mechanism in the kernel (defer_hard_irqs and gro_flush_timeout)
 is useful, but picking the correct values for these settings is difficult and
 the ideal values change as the type of traffic and workload changes.

 For example: picking a large timeout value is good for batching packet
 processing, but induces latency. Picking a small timeout value will interrupt
 user app processing and reduce efficiency. The value chosen would be different
 depending on whether the system is under high load (large timeout) or when less
 busy (small timeout).

As such, adding the new tunable makes it much easier to use the existing ones
and also produces better performance as shown in the results we presented. 

Please let me know if you have any questions; I know that the change we are
introducing is very subtle and I am happy to expand the cover letter if it'd be
helpful for you.

My concern was that the cover letter was too long already, but a big takeaway
for me thus far has been that we should expand the cover letter.

[...]

> > > Let's see how other people feel about per-dev irq_suspend_timeout. Properly
> > > disabling napi during busy polling is super useful, but it would still
> > > be nice to plumb irq_suspend_timeout via epoll context or have it set on
> > > a per-napi basis imho.
> > 
> > Fingers crossed. I hope this patch will be accepted, because it has 
> > practical performance and efficiency benefits, and that this will 
> > further increase the motivation to re-design the entire irq 
> > defer(/suspend) infrastructure for per-napi settings.
> 
> Overall, the idea of keeping interrupts disabled during event
> processing is very interesting.

Thanks; I'm happy to hear we are aligned on this.

> Hopefully the interface can be made more intuitive. Or documented more
> easily. I had to read the kernel patches to fully (perhaps) grasp it.
> 
> Another +1 on the referenced paper. Pointing out a specific difference
> in behavior that is unrelated to the protection domain, rather than a
> straightforward kernel vs user argument. The paper also had some
> explanation that may be clearer for a commit message than the current
> cover letter:
> 
> "user-level network stacks put the application in charge of the entire
> network stack processing (cf. Section 2). Interrupts are disabled and
> the application coordinates execution by alternating between
> processing existing requests and polling the RX queues for new data"
> " [This series extends this behavior to kernel busy polling, while
> falling back onto interrupt processing to limit CPU overhead.]
> 
> "Instead of re-enabling the respective interrupt(s) as soon as
> epoll_wait() returns from its NAPI busy loop, the relevant IRQs stay
> masked until a subsequent epoll_wait() call comes up empty, i.e., no
> events of interest are found and the application thread is about to be
> blocked."
> 
> "A fallback technical approach would use a kernel timeout set on the
> return path from epoll_wait(). If necessary, the timeout re-enables
> interrupts regardless of the application´s (mis)behaviour."
> [Where misbehavior is not calling epoll_wait again]
> 
> "The resulting execution model mimics the execution model of typical
> user-level network stacks and does not add any requirements compared
> to user-level networking. In fact, it is slightly better, because it
> can resort to blocking and interrupt delivery, instead of having to
> continuously busyloop during idle times."
>
> This last part shows a preference on your part to a trade-off:
> you want low latency, but also low cpu utilization if possible.
> This also came up in this thread. Please state that design decision
> explicitly.

Sure, we can include that in the list of cover letter updates we
need to make. I could have called it out more clearly, but in the cover
letter [1] I mentioned that latency improved for compared CPU usage (i.e.
CPU efficiency improved):

  The overall takeaway from the results below is that the new mechanism
  (suspend20, see below) results in reduced 99th percentile latency and
  increased QPS in the MAX QPS case (compared to the other cases), and
  reduced latency in the lower QPS cases for comparable CPU usage to the
  base case (and less CPU than the busy case).

> There are plenty of workloads where burning a core is acceptable
> (especially as core count continues increasing), not "slightly worse".

Respectfully, I don't think I'm on board with this argument. "Burning a core"
has side effects even as core counts increase (power, cooling, etc) and it
seems the counter argument is equally valid, as well: there are plenty of
workloads where burning a core is undesirable.

Using less CPU to get comparable performance is strictly better, even if a
system can theoretically support the increased CPU/power/cooling load.

Either way: this is not an either/or. Adding support for the code we've
proposed will be very beneficial for an important set of workloads without
taking anything anyway.

- Joe

[1]: https://lore.kernel.org/netdev/20240812125717.413108-1-jdamato@fastly.com/

