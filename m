Return-Path: <linux-fsdevel+bounces-25923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E49951E25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BD81C22132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93B51B4C42;
	Wed, 14 Aug 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY5D38zp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7E1B3F30;
	Wed, 14 Aug 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648129; cv=none; b=RTlhol5MN3slxjAHsFu7qJgWcmHrn5lBAfEOOIwIjy15mXH9bYHU9hNHYFg5X2IkIQIT8nTKnDhF180VGxeNrj5HVFsglHoq3AICOs7rIqU460plijjUI9nkf21Yqr1ttiue4+pPT8Qv1HhpEbhIj9C08ot2eg3E3yXQae1/UpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648129; c=relaxed/simple;
	bh=I4/5wqtOSUu+M385EHWXdTF02i9g4nL1NlaP6k2SrFQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=svwB/UTNVDjhLvE1ifi352+AZ2xEJ11awahWhzGiAr1/19CMsHGQ/W+ain02aTrIoM0K8WoHLkxh2fuLH7BfC+iOpaQPKo9Ly/vYCeKJtA3iPAsDxSIE4go2Hn3mYsHRbh5is1ywMSpgC6MMUdGWCtQ0k+59a2Ru8qrpe77r3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY5D38zp; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d81dc0beso429100085a.2;
        Wed, 14 Aug 2024 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723648126; x=1724252926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JnJVLsmunKz1N0MNEXD3u4nXpBfSOLV7GhQ/fPiuuU=;
        b=DY5D38zp/XdaZX5+vJTlxZdZkinU+jbU4O4FBwPy6gX+eXcUr9LgzpC6A5wkmnUPAQ
         hslwsuhQ4n+3rf4Rc/gqXI9J9oR6CVsefP4RBQ2q5HCFSgOvAIJ1JNyOfwSaYQ8ZHD2R
         effdf4N/HkMxRGXIkc2ipfEFtATwyZGHnwJWCkcfJsKzXNUJ7FgsA6xoqlpaybtyvDy8
         AJam6E8rFkxsY3UBfQ6y71yu2+da+XYw/ECLUVzuDxWoXNyuFlf9udD28OfcgB9zK3fv
         yWTUZdXrTVIHt4yk1vqxbYgXguoP7P9GWJDEWx3kT/nol2xLVVf9f1lvZnBAjeDw80rH
         YBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723648126; x=1724252926;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+JnJVLsmunKz1N0MNEXD3u4nXpBfSOLV7GhQ/fPiuuU=;
        b=K+fHyCfWn3uVAGf7lPte5ye29yy2+lzDdK48o5cmzKqk6WxT74aDCPK330hz/+T8Hn
         ex8L7yUeCXQdmzN4v4DmrK5uljEDNeTcNTwyixUIki/3YT/LK7eM1y9+INd8JSrj4vTH
         yIoe0062cPENAgsa+unLv8Oob393CogObda5jHiYVC9sXAj98SwqhPPk28J3jxaBwcqW
         jjl10e88EcfM5jZm9pUwYDqfaDDXOpYvtxPeFZR6qCoogYQGW+q9a1XzX7PIRTGIefYx
         x3mUfkgjmWe89SE2fjK39f4Ha8qIddjzEth6TbUeYZhwS9d9X9Clq/yabgDfOoxd4h1a
         +dHA==
X-Forwarded-Encrypted: i=1; AJvYcCWFkXIt8q+XnZDqUrunKYgJA6At3tsXoJCBwneSYlwdlaUtDPk/c4wj8Gsy106uvxHiHmcqU5D2CLHNkl2n3I9GGCngT92FKHJ9oy+Jlv5ZMzuljT0J7tzSSJbwWSNEIwybI4k2xgciwIrypywd/cDNyZMhSY1JvXjOFSBzwINXlTsmSdtcH4woNZpvxeIubVJpp78CTs4cbnICb/KKBw==
X-Gm-Message-State: AOJu0Yz9vdrqIMk7iRku6pfCPkzszlNOLzpVCRNz/pNmvheeDlallz4E
	zrg17SCcpBaFAPZWbvEb9YStRyHjWOMQtdeyjbFkyq1d9LL3bdzm
X-Google-Smtp-Source: AGHT+IEl77zc4g8f5fHZ7ZSChLtcAm72gMMmppwUCxI922umY71YyYZo6G6p71ce8GqwCEo1zqzbbg==
X-Received: by 2002:a05:620a:31a9:b0:79e:fc62:c3fb with SMTP id af79cd13be357-7a4ee3ac5f7mr329523285a.53.1723648125840;
        Wed, 14 Aug 2024 08:08:45 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4e428e2c9sm181095485a.134.2024.08.14.08.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:08:45 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:08:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <jdamato@fastly.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 netdev@vger.kernel.org, 
 amritha.nambiar@intel.com, 
 sridhar.samudrala@intel.com, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Breno Leitao <leitao@debian.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Johannes Berg <johannes.berg@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
 "open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <66bcc87d605_b1f942948@willemb.c.googlers.com.notmuch>
In-Reply-To: <Zry9AO5Im6rjW0jm@LQ3V64L9R2.home>
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
 <Zry9AO5Im6rjW0jm@LQ3V64L9R2.home>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Joe Damato wrote:
> On Tue, Aug 13, 2024 at 11:16:07PM -0400, Willem de Bruijn wrote:
> > Martin Karsten wrote:
> > > On 2024-08-13 00:07, Stanislav Fomichev wrote:
> > > > On 08/12, Martin Karsten wrote:
> > > >> On 2024-08-12 21:54, Stanislav Fomichev wrote:
> > > >>> On 08/12, Martin Karsten wrote:
> > > >>>> On 2024-08-12 19:03, Stanislav Fomichev wrote:
> > > >>>>> On 08/12, Martin Karsten wrote:
> > > >>>>>> On 2024-08-12 16:19, Stanislav Fomichev wrote:
> > > >>>>>>> On 08/12, Joe Damato wrote:
> =

> [...]
> =

> > > >>
> > > >> One of the goals of this patch set is to reduce parameter tuning=
 and make
> > > >> the parameter setting independent of workload dynamics, so it sh=
ould make
> > > >> things easier. This is of course notwithstanding that per-napi s=
ettings
> > > >> would be even better.
> > =

> > I don't follow how adding another tunable reduces parameter tuning.
> =

> Thanks for taking a look and providing valuable feedback, Willem.
> =

> An early draft of the cover letter included some paragraphs which were =
removed
> for the sake of brevity that we can add back in, which addresses your c=
omment
> above:
> =

>  The existing mechanism in the kernel (defer_hard_irqs and gro_flush_ti=
meout)
>  is useful, but picking the correct values for these settings is diffic=
ult and
>  the ideal values change as the type of traffic and workload changes.
> =

>  For example: picking a large timeout value is good for batching packet=

>  processing, but induces latency. Picking a small timeout value will in=
terrupt
>  user app processing and reduce efficiency. The value chosen would be d=
ifferent
>  depending on whether the system is under high load (large timeout) or =
when less
>  busy (small timeout).
> =

> As such, adding the new tunable makes it much easier to use the existin=
g ones
> and also produces better performance as shown in the results we present=
ed. =

> =

> Please let me know if you have any questions; I know that the change we=
 are
> introducing is very subtle and I am happy to expand the cover letter if=
 it'd be
> helpful for you.
> =

> My concern was that the cover letter was too long already, but a big ta=
keaway
> for me thus far has been that we should expand the cover letter.
> =

> [...]
> =

> > > > Let's see how other people feel about per-dev irq_suspend_timeout=
. Properly
> > > > disabling napi during busy polling is super useful, but it would =
still
> > > > be nice to plumb irq_suspend_timeout via epoll context or have it=
 set on
> > > > a per-napi basis imho.
> > > =

> > > Fingers crossed. I hope this patch will be accepted, because it has=
 =

> > > practical performance and efficiency benefits, and that this will =

> > > further increase the motivation to re-design the entire irq =

> > > defer(/suspend) infrastructure for per-napi settings.
> > =

> > Overall, the idea of keeping interrupts disabled during event
> > processing is very interesting.
> =

> Thanks; I'm happy to hear we are aligned on this.
> =

> > Hopefully the interface can be made more intuitive. Or documented mor=
e
> > easily. I had to read the kernel patches to fully (perhaps) grasp it.=

> > =

> > Another +1 on the referenced paper. Pointing out a specific differenc=
e
> > in behavior that is unrelated to the protection domain, rather than a=

> > straightforward kernel vs user argument. The paper also had some
> > explanation that may be clearer for a commit message than the current=

> > cover letter:
> > =

> > "user-level network stacks put the application in charge of the entir=
e
> > network stack processing (cf. Section 2). Interrupts are disabled and=

> > the application coordinates execution by alternating between
> > processing existing requests and polling the RX queues for new data"
> > " [This series extends this behavior to kernel busy polling, while
> > falling back onto interrupt processing to limit CPU overhead.]
> > =

> > "Instead of re-enabling the respective interrupt(s) as soon as
> > epoll_wait() returns from its NAPI busy loop, the relevant IRQs stay
> > masked until a subsequent epoll_wait() call comes up empty, i.e., no
> > events of interest are found and the application thread is about to b=
e
> > blocked."
> > =

> > "A fallback technical approach would use a kernel timeout set on the
> > return path from epoll_wait(). If necessary, the timeout re-enables
> > interrupts regardless of the application=C2=B4s (mis)behaviour."
> > [Where misbehavior is not calling epoll_wait again]
> > =

> > "The resulting execution model mimics the execution model of typical
> > user-level network stacks and does not add any requirements compared
> > to user-level networking. In fact, it is slightly better, because it
> > can resort to blocking and interrupt delivery, instead of having to
> > continuously busyloop during idle times."
> >
> > This last part shows a preference on your part to a trade-off:
> > you want low latency, but also low cpu utilization if possible.
> > This also came up in this thread. Please state that design decision
> > explicitly.
> =

> Sure, we can include that in the list of cover letter updates we
> need to make. I could have called it out more clearly, but in the cover=

> letter [1] I mentioned that latency improved for compared CPU usage (i.=
e.
> CPU efficiency improved):
> =

>   The overall takeaway from the results below is that the new mechanism=

>   (suspend20, see below) results in reduced 99th percentile latency and=

>   increased QPS in the MAX QPS case (compared to the other cases), and
>   reduced latency in the lower QPS cases for comparable CPU usage to th=
e
>   base case (and less CPU than the busy case).
> =

> > There are plenty of workloads where burning a core is acceptable
> > (especially as core count continues increasing), not "slightly worse"=
.
> =

> Respectfully, I don't think I'm on board with this argument. "Burning a=
 core"
> has side effects even as core counts increase (power, cooling, etc) and=
 it
> seems the counter argument is equally valid, as well: there are plenty =
of
> workloads where burning a core is undesirable.

Even more, likely. As this might be usable for standard efficiency
focused production services.

> Using less CPU to get comparable performance is strictly better, even i=
f a
> system can theoretically support the increased CPU/power/cooling load.

If it is always a strict win yes. But falling back onto interrupts
with standard moderation will not match busy polling in all cases.

Different solutions for different workloads. No need to stack rank
them. My request is just to be explicit which design point this
chooses, and that the other design point (continuous busy polling) is
already addressed in Linux kernel busypolling.

> Either way: this is not an either/or. Adding support for the code we've=

> proposed will be very beneficial for an important set of workloads with=
out
> taking anything anyway.
> =

> - Joe
> =

> [1]: https://lore.kernel.org/netdev/20240812125717.413108-1-jdamato@fas=
tly.com/



