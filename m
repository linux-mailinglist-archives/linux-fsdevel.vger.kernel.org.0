Return-Path: <linux-fsdevel+bounces-42933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5402A4C386
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 15:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D743316D30F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F32144BA;
	Mon,  3 Mar 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB/AvcGO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC2214232;
	Mon,  3 Mar 2025 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012662; cv=none; b=lGaZTdwhxSxRQWjVZCdcMVnqYkKjP+9+XPhclpXBuDloJ7s22vaeraXTsRMyuuDwK26vDr7Ng+M3EqAHyA/CiSad/IwXyC+tR+EAo3n1pOdk5z6VWjGopk1vkUPqC6IqjjPELu6XDRXvSNwyM8lc9J5iojHsdXTr44duvoMDr7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012662; c=relaxed/simple;
	bh=TVdfMizijDhx9fFu8L/fgoDGmPdP5RF8aA1SgnGMRs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBfp5FzTFGBrfQTSfmiS5ogMm29UKvmuHphE2V1W2Bgx9Xr6tMIBGrr15+bsTtA8CH1dADQA3y/3BXHrZba778lJzTmIKtoa+lij45HAqtwjBrrF3DkeDqulkIhZ1bv5S9sH4QGsdtijYTPsmbkTw86hR01sI4vVtcP1fx6BY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB/AvcGO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf64aa2a80so297616066b.0;
        Mon, 03 Mar 2025 06:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741012658; x=1741617458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm8Z69nnfULklRz3iB04g6JKiRrew2Mfm5h0+8oieEU=;
        b=ZB/AvcGO0ZOc9jU/YGo0RqwMUdnHI9ESalIMOGXTsEi9clQ00Z11vL+q6duJT0+IfI
         I+w4zij+Cmy+3prXtJ5unTGeh0Eh0vrWpn13nP+sypM8/ZA48vs7CUfACLjXyiyKVDRC
         oKknkFMww2yjARevEofuuWtQsn7be/cj/MCWbZuV23Ry2RSS6u5N7MAnJS+FlIqpa7Ky
         ItLHi1uch/2iBXpv7fJsJdwbzrDzK21IszqfnF4j+jOsj+qQkQYbNLxoA8bXi5qx99hq
         kSHhViQkbyKiT9xaZ/Z+ODTsLYQZA0mo7F5U+494+t+fKmW0nOLoqeeXA0IJZavenjYc
         QIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012658; x=1741617458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm8Z69nnfULklRz3iB04g6JKiRrew2Mfm5h0+8oieEU=;
        b=m/oRPcWckyMpTOwRbqjfY8E/ZH0Ncfl+8ICNxCHAIE61AZmxQhr1vI/ODDu3Z6YdAE
         lwpOuIIZ2l7ZCB+DST2sbtmNRKVN7bHwWgaRGCNTJYji2WdMT1/GHv4oWV/6jBEU1P+j
         7ridp8GL9IUjNXQbUcrUHAyVyOJUc6Tr5D5+FX96hdcTxHkpcTNlTH9EO68adgYGL335
         e5qQwuQZKdxs63gW46BAVFH2w1nWv0kPgkReq7diY9Oo0m4dAfWcZuHgWJXyH5h+WWLJ
         VmiUWXkk/R2i2oVW6/a6Kv2I1+pKC3dSK9pE2FZuoh92JZMIqZd8qEJujbeo91rdnJqr
         4fAw==
X-Forwarded-Encrypted: i=1; AJvYcCWyuQ7Vws3poTlnPuVfwBsvXZ/GGDkkou6Si9Ocleip1Btdmq3ze/JEw+wWvg3WD4tkfqehEObIBN6S26lq@vger.kernel.org, AJvYcCX0AJ/BDsDk9AJbRoq3P0c4X7/KmWiTtkS28eaPGOUmEF61tdQH5RJUvhAsFyvXF/pM09QmZ3tmMVuHaXLi@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBRDkYBvegrOOavn5mbgEXNrU8LO4c0YKvyDe1SLczM4TUl9J
	yV4FGkz/bPg3NvJWjR0FgUWCR8aWNBaOhknL9MWtQyb031H1U0vn0H7agfNjPp5AQXP2Rz+RDxf
	b0BaKo7vCWw8tcv91q9ADyqiON4A=
X-Gm-Gg: ASbGncueRUP7HfF3MZdovVv5KStiYIpym1f3T6gLmGXiMJYCC6r4LCnKDDS40tV8gbJ
	cXlrtWP/XI8O/Di+yortXnscdJWZVpufcrFO5xQluDOSRa5duITZMMBU5eBe9mGg1HR3N8wqble
	DPLQ4TlTUtJ1gLsDFb2YE9lq86
X-Google-Smtp-Source: AGHT+IGQI/GqSVJNN2m1G5pYHxbq7cq1JScEtonBtg7lqRhk25Lp9qrINbJhjmEGIyELLEjYKMTz4EjlVGsuWv2C2KM=
X-Received: by 2002:a17:907:7213:b0:abf:75b8:cb38 with SMTP id
 a640c23a62f3a-abf75b8cc51mr534971566b.36.1741012658287; Mon, 03 Mar 2025
 06:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102140715.GA7091@redhat.com> <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com> <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com> <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com> <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com> <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
In-Reply-To: <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 3 Mar 2025 15:37:26 +0100
X-Gm-Features: AQ5f1JrJn7s8IQtE2vlkTBx3nTSQJtOfIME3uHBWd6UR3A5tFqhSHrJZ5pxLwB0
Message-ID: <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Manfred Spraul <manfred@colorfullife.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 10:46=E2=80=AFAM Sapkal, Swapnil <swapnil.sapkal@amd=
.com> wrote:
> But in the meanwhile me and Prateek tried some of the experiments in the =
weekend.
> We were able to reproduce this issue on a third generation EPYC system as=
 well as
> on an Intel Emerald Rapids (2 X INTEL(R) XEON(R) PLATINUM 8592+).
>
> We tried heavy hammered tracing approach over the weekend on top of your =
debug patch.
> I have attached the debug patch below. With tracing we found the followin=
g case for
> pipe_writable():
>
>    hackbench-118768  [206] .....  1029.550601: pipe_write: 000000005eea28=
ff: 0: 37 38 16: 1
>
> Here,
>
> head =3D 37
> tail =3D 38
> max_usage =3D 16
> pipe_full() returns 1.
>

AFAICT the benchmark has one reader per fd, but multiple writers.

Maybe I'm misunderstanding something, but for such a case I think this
is expected as a possible transient condition and while not ideal, it
should not lead to the bug at hand.

Suppose there is only one reader and one writer and a wakeup-worthy
condition showed up. Then both sides perform wakeups *after* dropping
the pipe mutex, meaning their state is published before whoever they
intend to wake up gets on CPU. At the same time any new arrivals which
did not sleep start with taking the mutex.

Suppose there are two or more writers (one of which is blocked) and
still one reader and the pipe transitions to no longer full. Before
the woken up writer reaches pipe_writable() the pipe could have
transitioned to any state an arbitrary number of times, but someone
had to observe the correct state. In particular it is legitimate for a
non-sleeping writer to sneak in and fill in the pipe and the reader to
have time to get back empty it again etc.

Or to put it differently, if the patch does correct the bug, it needs
to explain how everyone ends up blocked. Per the above, there always
should be at least one writer and one reader who make progress -- this
somehow breaks (hence the bug), but I don't believe the memory
ordering explains it.

Consequently I think the patch happens to hide the bug, just like the
now removed spurious wakeup used to do.

> Between reading of head and later the tail, the tail seems to have moved =
ahead of the
> head leading to wraparound. Applying the following changes I have not yet=
 run into a
> hang on the original machine where I first saw it:
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index ce1af7592780..a1931c817822 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -417,9 +417,19 @@ static inline int is_packetized(struct file *file)
>   /* Done while waiting without holding the pipe lock - thus the READ_ONC=
E() */
>   static inline bool pipe_writable(const struct pipe_inode_info *pipe)
>   {
> -       unsigned int head =3D READ_ONCE(pipe->head);
> -       unsigned int tail =3D READ_ONCE(pipe->tail);
>         unsigned int max_usage =3D READ_ONCE(pipe->max_usage);
> +       unsigned int head, tail;
> +
> +       tail =3D READ_ONCE(pipe->tail);
> +       /*
> +        * Since the unsigned arithmetic in this lockless preemptible con=
text
> +        * relies on the fact that the tail can never be ahead of head, r=
ead
> +        * the head after the tail to ensure we've not missed any updates=
 to
> +        * the head. Reordering the reads can cause wraparounds and give =
the
> +        * illusion that the pipe is full.
> +        */
> +       smp_rmb();
> +       head =3D READ_ONCE(pipe->head);
>
>         return !pipe_full(head, tail, max_usage) ||
>                 !READ_ONCE(pipe->readers);
> ---
>
> smp_rmb() on x86 is a nop and even without the barrier we were not able t=
o
> reproduce the hang even after 10000 iterations.
>
> If you think this is a genuine bug fix, I will send a patch for this.
>


--=20
Mateusz Guzik <mjguzik gmail.com>

