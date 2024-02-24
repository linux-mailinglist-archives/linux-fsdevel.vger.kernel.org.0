Return-Path: <linux-fsdevel+bounces-12668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A9586265C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 18:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2247282638
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C850D47A7D;
	Sat, 24 Feb 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q2RvTHzD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5581EF1E
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708795928; cv=none; b=sYWFIVQPAUkR7ek777Hn7oPCHwJ8qpI8530vpMnx1oiLQjYaDr76/BBhjW/EsvuqCkIfcWPvHWU5EMiW9AxskbBfgc7ExWH10+aa8IYLhBYvErXyM889mObEgMD7iQPocp2OcLc0u5+pGMAPGFLzZiQy4EUDaS8O0PEmJjskh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708795928; c=relaxed/simple;
	bh=hcEKBp6u0V4J3KsACVFP+HbQhRIm6Z9d655OiuY/j7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTGkANfp9gf1/qKwuZ3VsIjdEZxV4Mg8dPbqUlJ6+vHjjN4v/VRHzvNVRoE1u3WvkCELvxYm7zJ39OnqCoKAkWygyN8xDTsH8K4g0Yz4x21xjrHF6e+NB2BfGdcAWfEJuG8PH+k6k/DneoVx9NJpVvt+TGd/47byOg0blnlA3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q2RvTHzD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so2347808a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 09:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708795924; x=1709400724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GnLGxXnGSYycF06SFvkDq/uA6dc5TMk/gBMc+z5k6Co=;
        b=Q2RvTHzDI1u1H+1lTPx38bleR1Ushbb5HpZUTu3KhwFVkaPrudPSosRRP5Z2QJK+BS
         t4j28Zj/vwMdbCJ0S26/iGPNSY4Vtbxb8E/GmeEX3RiHyfJSCJ3cINWbd93MV1TpEsiD
         TQB90wqk8RFAuDcZQ0PusrBoqENBFLUapoSHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708795924; x=1709400724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnLGxXnGSYycF06SFvkDq/uA6dc5TMk/gBMc+z5k6Co=;
        b=SvB2cjoy7B29TYtEIOmrfrjcGau0v6JDcxIniEyx50Gy/yogvBQDPIRNBUH4wgvMTV
         iUAuzd2mtUuhFejLlPFg0GOevLt0myy4W90UHuJ2amkB9R6v8SXDSBBFJ2iVmzqyiJcm
         AYgwvhyn1UF3Wk0LOiWsQVM1kcMVgxnLQ9aGdG0B6arGod4pRtgxS4wInKhK8K7jI98H
         cZLuPCc/CYRWZQ2q3Z1wGi0tubR2yup+ZwJwvk6dKCLRK5ooNd4bErYHGEIDm/dLak1T
         +gBg90srYWxKLYJKK3kxZf2xG2Tp3xTjfmP5F7zJ8M+QNtSdr8oAJKT40R7vzaRTqhsc
         OJPw==
X-Forwarded-Encrypted: i=1; AJvYcCXS1KZiQfWBZbpENm5VcPHqXDsRM2VHWMq+8sCwnaDHM/NNa3+OVo3X5sJ0gtVJwNDMjoiIs5VjeJuM1mIaeASEdAFJIEAKBYXjnsjaEw==
X-Gm-Message-State: AOJu0YwtxSrAIiFSqKYQp0nccRBmLAulfTaxeSu8RvzGUE4hZmyZaplb
	xmMaH2S4HrgR9e+DHUdIfPyZTrucPNX1yA3kpZYrYQwS/iEQh3MOgApz90ZrUfu/uzjLeZtxyR9
	Em+E=
X-Google-Smtp-Source: AGHT+IEnFzTnupR669kl47hZPu9n7OrnoVa+h9t5Ky9xkJo+k77ZPd8hHROsDQUoqAn99r7vDyB5mA==
X-Received: by 2002:a05:6402:5149:b0:564:7007:e14a with SMTP id n9-20020a056402514900b005647007e14amr1699928edd.6.1708795924119;
        Sat, 24 Feb 2024 09:32:04 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id c11-20020a0564021f8b00b00565671fd23asm716960edc.22.2024.02.24.09.32.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 09:32:01 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so3032013a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 09:32:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnSiIfQwDO0tpXdE+bMJf3nKqvi4Eidb0o3Lu8KhQPf5fifsYOFzvIKuHPdsQ7boEfegeXiVKEVNI6kyhxfkGZHfBmwy4fM4wxcZWmVQ==
X-Received: by 2002:a17:906:e29a:b0:a42:f222:c832 with SMTP id
 gg26-20020a170906e29a00b00a42f222c832mr1038044ejb.1.1708795921002; Sat, 24
 Feb 2024 09:32:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <Zdlsr88A6AAlJpcc@casper.infradead.org>
In-Reply-To: <Zdlsr88A6AAlJpcc@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Feb 2024 09:31:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
Message-ID: <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 20:12, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Feb 23, 2024 at 03:59:58PM -0800, Luis Chamberlain wrote:
> >  What are the limits to buffered IO
> > and how do we test that? Who keeps track of it?
>
> TLDR: Why does the pagecache suck?

What? No.

Our page cache is so good that the question is literally "what are the
limits of it", and "how we would measure them".

That's not a sign of suckage.

When you have to have completely unrealistic loads that nobody would
actually care about in reality just to get a number for the limit,
it's not a sign of problems.

Or rather, the "problem" is the person looking at a stupid load, and
going "we need to improve this because I can write a benchmark for
this".

Here's a clue: a hardware discussion forum I visit was arguing about
memory latencies, and talking about how their measured overhead of
DRAM latency was literally 85% on the CPU side, not the DRAM side.

Guess what? It's because the CPU in question had quite a bit of L3,
and it was spread out, and the CPU doesn't even start the memory
access before it has checked caches.

And here's a big honking clue: only a complete nincompoop and mentally
deficient rodent would look at that and say "caches suck".

> >  ~86 GiB/s on pmem DIO on xfs with 64k block size, 1024 XFS agcount on x86_64
> >      Vs
> >  ~ 7,000 MiB/s with buffered IO
>
> Profile?  My guess is that you're bottlenecked on the xa_lock between
> memory reclaim removing folios from the page cache and the various
> threads adding folios to the page cache.

I doubt it's the locking.

In fact, for writeout in particular it's probably not even the page
cache at all.

For writeout, we have a very traditional problem: we care about a
million times more about latency than we care about throughput,
because nobody ever actually cares all that much about performance of
huge writes.

Ask yourself when you have last *really* sat there waiting for writes,
unless it's some dog-slow USB device that writes at 100kB/s?

The main situation where people care about cached write performance
(ignoring silly benchmarks) tends to be when you create files, and the
directory entry ordering means that the bottleneck is a number of
small writes and their *ordering* and their latency.

And then the issue is basically never the page cache, but the
filesystem ordering of the metadata writes against each other and
against the page writeout.

Why? Because on all but a *miniscule* percentage of loads, all the
actual data writes are quite gracefully taken by the page cache
completely asynchronously, and nobody ever cares about the writeout
latencies.

Now, the benchmark that Luis highlighted is a completely different
class of historical problems that has been around forever, namely the
"fill up lots of memory with dirty data".

And there - because the problem is easy to trigger but nobody tends to
care deeply about throughput because they care much much *MUCH* more
about latency, we have a rather stupid big hammer approach.

It's called "vm_dirty_bytes".

Well, that's the knob (not the only one). The actual logic around it
is then quite the moreass of turning that into the
dirty_throttle_control, and the per-bdi dirty limits that try to take
the throughput of the backing device into account etc etc.

And then all those heuristics are used to actually LITERALLY PAUSE the
writer. We literally have this code:

                __set_current_state(TASK_KILLABLE);
                bdi->last_bdp_sleep = jiffies;
                io_schedule_timeout(pause);

in balance_dirty_pages(), which is all about saying "I'm putting you
to sleep, because I judge you to have dirtied so much memory that
you're making things worse for others".

And a lot of *that* is then because we haven't wanted everybody to
rush in and start their own synchronous writeback, but instead watn
all writeback to be done by somebody else. So now we move from
mm/page-writeback.c to fs/fs-writeback.c, and all the work-queues to
do dirty writeout.

Notice how the io_schedule_timeout() above doesn't even get woken up
by IO completing. Nope. The "you have written too much" logic
literally pauses the writer, and doesn't even want to wake it up when
there is no more dirty data.

So the "you went over the dirty limits It's a penalty box, and all of
this comes from "you are doing something that is abnormal and that
disturbs other people, so you get an unconditional penalty". Yes, the
timeout is then obviously tied to how much of a problem the dirtying
is (based on that whole "how fast is the device") but it's purely a
heuristic.

And (one) important part here is "nobody sane does that".  So
benchmarking this is a bit crazy. The code is literally meant for bad
actors, and what you are benchmarking is the kernel telling you "don't
do that then".

And absolutely *NONE* of this all has anything to do with the page cache. NADA.

And yes, there's literally thousands of lines of code all explicitly
designed for this "slow down writers" and make it be at least somewhat
graceful and gradual.

That's pretty much all mm/page-writeback.c does (yes, that file *also*
does have the "start/end folio writeback" functions, but they are only
a small part of it, even if that's obviously the origin of the file -
the writeback throttling logic has just grown a lot more).

               Linus

