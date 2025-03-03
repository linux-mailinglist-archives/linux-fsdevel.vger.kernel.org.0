Return-Path: <linux-fsdevel+bounces-42935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57367A4C3DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 15:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4912A1895BED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605A213E6E;
	Mon,  3 Mar 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3wq1AWK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151AB126BF9;
	Mon,  3 Mar 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013478; cv=none; b=HQ5eQ9f0bADGaexrwEFdAyvwAIkw0DHcBVDbCP3MaypjEiAiN6RXFaBiyP+I7bVM5pC6R95N2LjaM33im/MC2p+nD32r3vpx4uQ7bmQ+YBW/p1T/QLQ+qQOrX2OKt02YkO5RdE3v5/ES9v75ykRh0KUvb0iFcWyDJ6U66qRKIvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013478; c=relaxed/simple;
	bh=frXbckAMmvdYemLHwdtxsw0YTX9VEJykOz8M59HdY4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONwn1tdK9Xchn6nh77ZiElt1i6VpGzJJ0Zqz+FYA05mDrv3llrIOlN0/D81i2K8Rmc/rSun5miiVCYDP4UM1YGyiGMvWL/f6IC64lf6MUzUXn9vXT/UTRbB991oMlPz8ZWdN8ePS+ARDRX7343XTyDKIU7dSN5jIc1vs6Jkrhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3wq1AWK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so8221290a12.0;
        Mon, 03 Mar 2025 06:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741013474; x=1741618274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwqkG7YyhqbAJbNNYfeEoCjGaAC53ymv9D7KEp/21vk=;
        b=B3wq1AWK6e4ZxvxLCDuO79/WfLBHWAzNeODeS1hV5nQRuXnQQ+ActQkBEah82pKVJ8
         T56kuVkezMtSm6Wy3zyWyU8PgA+oBXVoHA6wERmpDBIgtfevgHiBVaoWkfupPjowfcZZ
         wQZR+lK4uVpIz00/m+jNmiIR1KkIHIGTz2x+IA8chunMczqba5HGWvpz3Q8xEV7jgMpb
         6F64hWJbyisDbCynP4q9hgQH7e98uznXoTjWUGNSAwebMihQKt5T+YDlD0tHd3pOlDDr
         sKFKyFkeatkHdJAqfI9QPU3yCcEwRVlWb1lwD0bdz7FcXAQqlP4wu/ld/pKBOYQNFkRD
         NQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741013474; x=1741618274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwqkG7YyhqbAJbNNYfeEoCjGaAC53ymv9D7KEp/21vk=;
        b=YcaWdNvdWr/M9IR61d6LJSEwwqhYZGStVQXFU8j4lzdGNcCew0+AUC4Y+TiegdE4g/
         M87A3iYgNK0kNNUvJw8/LZ6FfdQZEioh3JpnDbDdKs3WfjGrLq283ACDu2n6Ouo13gmz
         jcsWrJnsTUshK8D5k8gl94TWNmujRxV2fny2WvNJ0mddBELjDuWHRbiz7xjj2IaleerI
         Ezba6XG8Q9B7JBW1R352ItikDF+RmRkKHNMat4xnc/fXvd42aFcKq6Y9LahpxANO9maY
         6vkcXljQmUgRhqRcOtgaw1vC64bkCZAWeKVfGIiKRHEVH7yN2/TV1JsHPAibmM3clit5
         CyCA==
X-Forwarded-Encrypted: i=1; AJvYcCVucHJ/PBqAG35DHR2NRfx7Yras/iYyE3isJxw94KkMNxIL0L121haf/jKOqCpaqtqEvXNxbw8iWX4NcbQs@vger.kernel.org, AJvYcCWLG9QgMVopmdx2wlXrkIGhWvjCErCNr/JKJGuRl6mM4KzCwcoVOXKq/YaWTdtVi8hp5/+3FQmthEs6+noY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwm2/yyWYoyWp6u37zcfZMprgqLrm9PUV+vsIYXpbxu1cevoPj
	BpF+IFNWJeCto6n5OBEtzBz0ZB+QdP3Sb0iyHex4EqW/xzy8ppRdhxcuYW5LkMJV1MftOXhmy1c
	wq9GjksZPBGE3Fr4tmTq2DvFPCZI=
X-Gm-Gg: ASbGnct9uttyfnlxYjGzCWHm24B1Auy+NwgkIJ/dPbnc7j5UiIwVnkpZiZEpCXuvOJc
	s0FpOIkUH8h7png9E/SGHlTsdOHdsaPRt6vsy6QtNjeWzn4JrHixG0aQjXT8tpd4SdRewwza8oj
	s3HRNKdRE94p81iFb3stC3HTdW
X-Google-Smtp-Source: AGHT+IE39ppoxtcWhzkszi5nanjE0dF87vTbX+fej3JtjpPSjVA3oEL4CO0pun5npggkgk3mdij2fanKyRgqvsX4GX0=
X-Received: by 2002:a17:907:72d4:b0:abf:58cd:7775 with SMTP id
 a640c23a62f3a-abf58cd7b70mr1025297466b.54.1741013474031; Mon, 03 Mar 2025
 06:51:14 -0800 (PST)
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
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
In-Reply-To: <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 3 Mar 2025 15:51:02 +0100
X-Gm-Features: AQ5f1JoX3RWKo46kBkLG9VG13L4gBFpYMr8qdRlmFcyt9QVpUceiEsEceb_VnpA
Message-ID: <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
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

On Mon, Mar 3, 2025 at 3:37=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Mon, Mar 3, 2025 at 10:46=E2=80=AFAM Sapkal, Swapnil <swapnil.sapkal@a=
md.com> wrote:
> > But in the meanwhile me and Prateek tried some of the experiments in th=
e weekend.
> > We were able to reproduce this issue on a third generation EPYC system =
as well as
> > on an Intel Emerald Rapids (2 X INTEL(R) XEON(R) PLATINUM 8592+).
> >
> > We tried heavy hammered tracing approach over the weekend on top of you=
r debug patch.
> > I have attached the debug patch below. With tracing we found the follow=
ing case for
> > pipe_writable():
> >
> >    hackbench-118768  [206] .....  1029.550601: pipe_write: 000000005eea=
28ff: 0: 37 38 16: 1
> >
> > Here,
> >
> > head =3D 37
> > tail =3D 38
> > max_usage =3D 16
> > pipe_full() returns 1.
> >
>
> AFAICT the benchmark has one reader per fd, but multiple writers.
>
> Maybe I'm misunderstanding something, but for such a case I think this
> is expected as a possible transient condition and while not ideal, it
> should not lead to the bug at hand.
>
> Suppose there is only one reader and one writer and a wakeup-worthy
> condition showed up. Then both sides perform wakeups *after* dropping
> the pipe mutex, meaning their state is published before whoever they
> intend to wake up gets on CPU. At the same time any new arrivals which
> did not sleep start with taking the mutex.
>
> Suppose there are two or more writers (one of which is blocked) and
> still one reader and the pipe transitions to no longer full. Before
> the woken up writer reaches pipe_writable() the pipe could have
> transitioned to any state an arbitrary number of times, but someone
> had to observe the correct state. In particular it is legitimate for a
> non-sleeping writer to sneak in and fill in the pipe and the reader to
> have time to get back empty it again etc.
>
> Or to put it differently, if the patch does correct the bug, it needs
> to explain how everyone ends up blocked. Per the above, there always
> should be at least one writer and one reader who make progress -- this
> somehow breaks (hence the bug), but I don't believe the memory
> ordering explains it.
>
> Consequently I think the patch happens to hide the bug, just like the
> now removed spurious wakeup used to do.
>

Now that I wrote the above, I had an epiphany and indeed there may be
something to it. :)

Suppose the pipe is full, the reader drains one buffer and issues a
wakeup on its way out. There is still several bytes stored to read.

Suppose the woken up writer is still trying to get on CPU.

On subsequent calls the reader keeps messing with the tail, *exposing*
the possibility of the pipe_writable check being racy even if there is
only one reader and one writer.

I'm gonna grab lunch and chew on it, but I think you guys are on the
right track. But some more fences may be needed.

> > Between reading of head and later the tail, the tail seems to have move=
d ahead of the
> > head leading to wraparound. Applying the following changes I have not y=
et run into a
> > hang on the original machine where I first saw it:
> >
> > diff --git a/fs/pipe.c b/fs/pipe.c
> > index ce1af7592780..a1931c817822 100644
> > --- a/fs/pipe.c
> > +++ b/fs/pipe.c
> > @@ -417,9 +417,19 @@ static inline int is_packetized(struct file *file)
> >   /* Done while waiting without holding the pipe lock - thus the READ_O=
NCE() */
> >   static inline bool pipe_writable(const struct pipe_inode_info *pipe)
> >   {
> > -       unsigned int head =3D READ_ONCE(pipe->head);
> > -       unsigned int tail =3D READ_ONCE(pipe->tail);
> >         unsigned int max_usage =3D READ_ONCE(pipe->max_usage);
> > +       unsigned int head, tail;
> > +
> > +       tail =3D READ_ONCE(pipe->tail);
> > +       /*
> > +        * Since the unsigned arithmetic in this lockless preemptible c=
ontext
> > +        * relies on the fact that the tail can never be ahead of head,=
 read
> > +        * the head after the tail to ensure we've not missed any updat=
es to
> > +        * the head. Reordering the reads can cause wraparounds and giv=
e the
> > +        * illusion that the pipe is full.
> > +        */
> > +       smp_rmb();
> > +       head =3D READ_ONCE(pipe->head);
> >
> >         return !pipe_full(head, tail, max_usage) ||
> >                 !READ_ONCE(pipe->readers);
> > ---
> >
> > smp_rmb() on x86 is a nop and even without the barrier we were not able=
 to
> > reproduce the hang even after 10000 iterations.
> >
> > If you think this is a genuine bug fix, I will send a patch for this.
> >
>
>
> --
> Mateusz Guzik <mjguzik gmail.com>



--=20
Mateusz Guzik <mjguzik gmail.com>

