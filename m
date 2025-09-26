Return-Path: <linux-fsdevel+bounces-62902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7A8BA4816
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 17:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15AF3A4F5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F8A224240;
	Fri, 26 Sep 2025 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVzhrp+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384BC15530C
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901859; cv=none; b=sDxQ9MP2BShDcWIa/cAi90JKxGDe+c3YZt6w3hD/cJbvUjuTat9RUTZrB4k1MMraC2gp9u/OVfYe5fF2jIAHeSAo/lkt3s1hBTxFf8ZL9Qk0CbPQZ4ICbWZbRBU29xY0ZwLKjXL0yXRi/dJcq6fch0Do1Pcbj0/UZbpwmt87qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901859; c=relaxed/simple;
	bh=d37t+8zAmVM4Ird9FXdErnZR9h0eHHT1Mk15Kr5/U6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZG4vFA1YJwa8WEQ9b/K8I8+qEsds2hQHsUHnC0g69KsVHPo/z/EDBf4+6u2PJMfM1N8VXVxz959iIe8iyLR66guCFXfg1gXsY+G0icoY9gGtlrfoyy/t8A2I3/u6MktDt3wKtZTpsIOssmzF7/QmQzyL5ysPPSLZCmTHcF7YJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVzhrp+c; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so4734537a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 08:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758901855; x=1759506655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSvxfYzOxY7L1PDSIoIGThH2VtlBCRNazpOVbqgkq/U=;
        b=MVzhrp+cImWcTHc1h1wUx39eeNkYjpnz1Lsgq9Z8uXysX+LxjXrGik8YTmBlgx18yn
         nAO/ke2qWVZgyChPAcZHY6L3pqSQGVa1l34pp0a4JIqkCG/RC87V5OP7R9unBIm2CYyH
         6G3MNiPSO/9BMb5wa96F+xkPU2Y9pgzpZHVjzcSO+ku8V0fODEb3eYNNPE/vytllvifA
         klbJTCwdCTy8G2UmXQ33eJDiOC60T7RDPZUovPAoRvCYcLuC3wJuHvDI1J6USN7JkMqV
         IJJsS+ggxPvtZdxrXEu33bWm5Uvf58eItchUISM7taL97FOGjhyxGro1mFSmWtGCYnGy
         8K5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901855; x=1759506655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSvxfYzOxY7L1PDSIoIGThH2VtlBCRNazpOVbqgkq/U=;
        b=TVNFWVdZ0i6bYB2JJ0WOMm2Zy+vE0gqawuqSoKp6MzE8LeLgH23ObOQqka5HfFLYam
         XlMPS/1o8rER4ZGLV4MpuuLkXNlypqqArSvyehpnxtbEXEH+Ix1YsyoWVgZ1kkyi8n8c
         mscjZm23M88iFfNO/Hd9gq669g+L9mDM0GLpTA9pmGPrjtk8VcckVuLsUHPzC2THHfY1
         JvJFAcIUhBJQrXUzb7ZzvnAkAniufptuRGHujR2msPiXXRMU3NVtyrhgtt4UIeNVSJ+C
         VLMX1UDg9ulAg6U+ioo3aKQL0Z30Hpqbn9BEt6FZvI1voeIxBm1M7FRCo+kUXkb56CHx
         Fm+A==
X-Forwarded-Encrypted: i=1; AJvYcCVOzH2lhTV7veDr5bBPzQA/44xIamg8Yw09CZADcPFCuisOeiqbLLPEVDobaTx298Fa3jUsFZ9OBEIEW636@vger.kernel.org
X-Gm-Message-State: AOJu0YxUackjgbMasfGTNc3p/gY4lFw86SRCx9XlUHCtsu+dl+Mw69OU
	Psoileok4IbIcc77CWZvNXGhFbLBhKcui8Z4eDZzAqJ9ahEPef3RHkNtB5ItrFuzvEeK41FdGWc
	dmuKn/CWyR9oaOOELswHPOacvl6sbGQ8=
X-Gm-Gg: ASbGncuUYl1HJERD27XCqfqVQs1ipwWS7RsPXxeeVJszZT5ihqfTpzwrjjtqHpt1FiK
	fIRZyOedm+Zoit8xCb7UTxuT1C6dWQzOLYGbOxtyv9xe5bywctqNVESFUAjVcgorvVaXHPcnhQU
	8glzGHYHa+bu16X9VjMVd2kDUN0G/98z0cVlxGpOk3OMlfgcVlkSiszw1hEcRdOEFjHYmss5+gx
	lL8nYhosUhsyT1L6DPFIOZkAtj3IyXxkAcaY5O/mQ==
X-Google-Smtp-Source: AGHT+IH6niltYBbQ6DxpNPznklY7ugKYtglsbEE8nCQ07WOXa3Zk8gEwtGDiwue5sAL4y3kEvbLLfFly9C++Vb5KJE4=
X-Received: by 2002:a05:6402:3482:b0:634:c3f3:20fb with SMTP id
 4fb4d7f45d1cf-634c3f32acfmr1739389a12.34.1758901855339; Fri, 26 Sep 2025
 08:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925132239.2145036-1-sunjunchao@bytedance.com>
 <fylfqtj5wob72574qjkm7zizc7y4ieb2tanzqdexy4wcgtgov4@h25bh2fsklfn>
 <5622443b-b5b4-4b19-8a7b-f3923f822dda@bytedance.com> <CAGudoHGigCyz60ec6Mv3NL2-x7tfLWYdK1M=Rj2OHRAgqHKOdg@mail.gmail.com>
 <14ee6648-1878-4b46-9e46-d275cc50bf0a@bytedance.com> <CAGudoHEkJfenk7ePETr3PCCqb9AYo7F4Ha754EjV4rT+U6_qoQ@mail.gmail.com>
 <xetmahjj5tlxksfxfkronyam6ppdeiobpdz2zuvigichqkqcos@6hembfwhlayn>
In-Reply-To: <xetmahjj5tlxksfxfkronyam6ppdeiobpdz2zuvigichqkqcos@6hembfwhlayn>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 26 Sep 2025 17:50:43 +0200
X-Gm-Features: AS18NWAswfMfN0lIAKy6frELVqZks6yHQJ7ZV94tqGaaeWPF0_KbTFV4X4_PL5U
Message-ID: <CAGudoHETCiATjWYcHbO_SBkE-X0fWWi0YCkn51+VLcjw7620oA@mail.gmail.com>
Subject: Re: [PATCH] write-back: Wake up waiting tasks when finishing the
 writeback of a chunk.
To: Jan Kara <jack@suse.cz>
Cc: Julian Sun <sunjunchao@bytedance.com>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, peterz@infradead.org, 
	akpm@linux-foundation.org, Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 5:48=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 26-09-25 14:05:59, Mateusz Guzik wrote:
> > On Fri, Sep 26, 2025 at 1:43=E2=80=AFPM Julian Sun <sunjunchao@bytedanc=
e.com> wrote:
> > >
> > > On 9/26/25 7:17 PM, Mateusz Guzik wrote:
> > > > On Fri, Sep 26, 2025 at 4:26=E2=80=AFAM Julian Sun <sunjunchao@byte=
dance.com> wrote:
> > > >>
> > > >> On 9/26/25 1:25 AM, Mateusz Guzik wrote:
> > > >>> On Thu, Sep 25, 2025 at 09:22:39PM +0800, Julian Sun wrote:
> > > >>>> Writing back a large number of pages can take a lots of time.
> > > >>>> This issue is exacerbated when the underlying device is slow or
> > > >>>> subject to block layer rate limiting, which in turn triggers
> > > >>>> unexpected hung task warnings.
> > > >>>>
> > > >>>> We can trigger a wake-up once a chunk has been written back and =
the
> > > >>>> waiting time for writeback exceeds half of
> > > >>>> sysctl_hung_task_timeout_secs.
> > > >>>> This action allows the hung task detector to be aware of the wri=
teback
> > > >>>> progress, thereby eliminating these unexpected hung task warning=
s.
> > > >>>>
> > > >>>
> > > >>> If I'm reading correctly this is also messing with stats how long=
 the
> > > >>> thread was stuck to begin with.
> > > >>
> > > >> IMO, it will not mess up the time. Since it only updates the time =
when
> > > >> we can see progress (which is not a hang). If the task really hang=
s for
> > > >> a long time, then we can't perform the time update=E2=80=94so it w=
ill not mess
> > > >> up the time.
> > > >>
> > > >
> > > > My point is that if you are stuck in the kernel for so long for the
> > > > hung task detector to take notice, that's still something worth
> > > > reporting in some way, even if you are making progress. I presume w=
ith
> > > > the patch at hand this information is lost.
> > > >
> > > > For example the detector could be extended to drop a one-liner abou=
t
> > > > encountering a thread which was unable to leave the kernel for a lo=
ng
> > > > time, even though it is making progress. Bonus points if the messag=
e
> > > > contained info this is i/o and for which device.
> > >
> > > Let me understand: you want to print logs when writeback is making
> > > progress but is so slow that the task can't exit, correct?
> > > I see this as a new requirement different from the existing hung task
> > > detector: needing to print info when writeback is slow.
> > > Indeed, the existing detector prints warnings in two cases: 1) no
> > > writeback progress; 2) progress is made but writeback is so slow it w=
ill
> > > take too long.
> >
> > I am saying it would be a nice improvement to extend the htd like that.
> >
> > And that your patch as proposed would avoidably make it harder -- you
> > can still get what you are aiming for without the wakeups.
> >
> > Also note that when looking at a kernel crashdump it may be beneficial
> > to know when a particular thread got first stuck in the kernel, which
> > is again gone with your patch.
>
> I understand your concerns but I think it's stretching the goals for this
> patch a bit too much.  I'm fine with the patch going in as is and if Juli=
an
> is willing to work on this additional debug features, then great!
>

I am not asking the patch does all that work, merely that it gets
implemented in a way which wont require a rewrite should the above
work get done. Which boils down to storing the timestamp somewhere in
task_struct.

> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

