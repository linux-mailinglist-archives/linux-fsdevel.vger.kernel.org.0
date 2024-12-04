Return-Path: <linux-fsdevel+bounces-36470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3E69E3CFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96A51636B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76E120ADF5;
	Wed,  4 Dec 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NdPhhjHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A5920ADEE
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323255; cv=none; b=av0g8Xh61/W58POulgOHVuctH2llwC+nbkR8v+LOxxuBGDHLfLgoNjG7wF6PSymAYON96cfYvIImhzzCBp9ynvGsxgS/WRbqyaA9g5/0SXrbe7sVNwC4uWfPeQ83Y8LQ1UAmEIFtnNNE2J2WUcWJ4wRK60DFrIDIHMY6FXy96S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323255; c=relaxed/simple;
	bh=er/WBJ8rAQU+ZLj544SyYRI63cJyxCSFKajeNjafhxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ1FSRH8HQW2CsuehaTWnp5M0BbYxNZS4r5d2nZagdHtIx5XKNm8ceJvnqZwQFd27OYoE+0Wg5+bFgEX9jXjmX0/Sk28jnJA6YWU3UTvttkAfo+9I9iP/drQlt4/IFcblW6ZVH2yygYlacjXRfc6eKGZYxt0ZXE5F6v8W9Ru25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NdPhhjHz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa5325af6a0so976445066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 06:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733323251; x=1733928051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UB2Jw8yzcjqftlqTBhCR3AJxQhWEz/gFCdCJGcNbxs=;
        b=NdPhhjHzlUU5zmuxuCYEgwenKEQjs3qn1TvQMoEKlq+MIcnYlZSMVvGWrifEvc0iaK
         y8bzIIMa2f6RLjvtT1ny1p+FveXFkehM6shOCndUSw3ZvGf4UYSg17rHjb9g2ZaSL4Hl
         X2/7RBw0xhVxcVDl5pmt1I2GeJldXYpj6Z1yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733323251; x=1733928051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UB2Jw8yzcjqftlqTBhCR3AJxQhWEz/gFCdCJGcNbxs=;
        b=iE+TWmmKSLjIHmPiwT/TQQRsR/2D3gEchIEcoVjkTIP7u7854gHz0aP6PIzyXNIFtF
         /DaOmSCdjLNo3DuJ++K+wHbeQ2xzC1Ujpfl5GkT9Uwjbb1YwMrdTDPt3FAcpEbgO3s4d
         oIB+Hv8f7sPrdC/tIXmJhnounD6+n908sSGBQ2ZPWo7H68eu5Gen4+tx7j4UYKkP6t4O
         Cn3YVbIXKPpbsiNsmooJV+Mt0DbfNYDTe3ctY9aOeZLnbH0EDchU6D/KRv2dBrrqy8Wk
         uLV1IftqcowxMej8vu9dmsAyM3D1KfLNILJNa0WN36YAxv1EpK2Ag9zBbgQid9wDvURH
         9Jag==
X-Forwarded-Encrypted: i=1; AJvYcCUiY8/OS0zgDWq1r0kvwCeNvMS+/1qCPQed2X2zZ7Wa1WDbYrXo/nOEhIGhTyl3TbD8Tvrsr3AtfyFp4S1M@vger.kernel.org
X-Gm-Message-State: AOJu0YxwO0sMBt6KdUySMK5ISCZjlomQpoYBgS4MBmdrqYBqW8CWKjgb
	Ch9Sqnv3CxOAiLEJH2n8k/n1xAhq7kGR3z31TfRDx+ql/SG8wK+fs/RFdWa/z8vsOGb5kgrO8JX
	4XA==
X-Gm-Gg: ASbGncvR4VtNAZZCT75yXHUqx1qO7uMSXmintJ+zgA6cGC5WbXfDOQsQePw0cYvaRCK
	YIHMeD05hnXhWU+8dC5qW06wT+XQZ58/NA52BeYGJHmu0wilNKhSEEIkN2o9LetVW/SCiZ1mPH0
	QUL+FRi+HcZaB6i0ou1YfyPpmAW7b/VZXS4kvUGMEpSNldonkoWi0rsNYwrGrqy9118p9qGwLAi
	M+ePXgb9mwG4unDj1q4pqNAZnR+kG4IoJqTLMMuhZK4h3+9+Qu2K3kziLzJmA0aq7qj2UWycWhK
	DXShXaGq0w==
X-Google-Smtp-Source: AGHT+IGkhj7qQP6D375mEYXIQEAD3OJnthZpxt2RvFVoUGl0sRC5XJNNbEYwDPisbtourdjpM/QsBQ==
X-Received: by 2002:a17:907:3da7:b0:aa5:358f:1eea with SMTP id a640c23a62f3a-aa5f7d2297bmr671914866b.16.1733323250808;
        Wed, 04 Dec 2024 06:40:50 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d413asm740960366b.59.2024.12.04.06.40.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 06:40:49 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d1228d66a0so1272a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 06:40:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZl2biN19EBwLpbspTxJjeBqNooWC4oUQ9/se5w3YTEyz3e7H+92VHSIUzUHdsfpd3kMIstLxuR1J/R4Ce@vger.kernel.org
X-Received: by 2002:a50:fe9a:0:b0:5d0:d7ca:7bf4 with SMTP id
 4fb4d7f45d1cf-5d11689aaedmr87850a12.0.1733323249202; Wed, 04 Dec 2024
 06:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com> <20241128104437.GB10431@google.com>
 <25e0e716-a4e8-4f72-ad52-29c5d15e1d61@fastmail.fm> <20241128110942.GD10431@google.com>
 <8c5d292f-b343-435f-862e-a98910b6a150@ddn.com> <20241128115455.GG10431@google.com>
 <CAAFQd5BW+nqZ2-_U_dj+=jLeOK9_FYN7sf_4U9PTTcbw8WJYWQ@mail.gmail.com>
 <ab0c3519-2664-4a23-adfa-d179164e038d@fastmail.fm> <CAJnrk1b3n7z3wfbZzUB_zVi3PTfjbZFbiUTfFMfAu61-t-W7Ug@mail.gmail.com>
In-Reply-To: <CAJnrk1b3n7z3wfbZzUB_zVi3PTfjbZFbiUTfFMfAu61-t-W7Ug@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 4 Dec 2024 23:40:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B+CkvZDSa+tZ0_ZpF0fQRC9ryXsGqm2R-ofvVqNnAJ1Q@mail.gmail.com>
Message-ID: <CAAFQd5B+CkvZDSa+tZ0_ZpF0fQRC9ryXsGqm2R-ofvVqNnAJ1Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Joanne Koong <joannelkoong@gmail.com>, Brian Geffon <bgeffon@google.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Bernd Schubert <bschubert@ddn.com>, 
	"miklos@szeredi.hu" <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, 
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>, "laoar.shao@gmail.com" <laoar.shao@gmail.com>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 4:29=E2=80=AFAM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Mon, Dec 2, 2024 at 6:43=E2=80=AFAM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> > On 12/2/24 10:45, Tomasz Figa wrote:
> > > Hi everyone,
> > >
> > > On Thu, Nov 28, 2024 at 8:55=E2=80=AFPM Sergey Senozhatsky
> > > <senozhatsky@chromium.org> wrote:
> > >>
> > >> Cc-ing Tomasz
> > >>
> > >> On (24/11/28 11:23), Bernd Schubert wrote:
> > >>>> Thanks for the pointers again, Bernd.
> > >>>>
> > >>>>> Miklos had asked for to abort the connection in v4
> > >>>>> https://lore.kernel.org/all/CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2J=
ACFdgJJ_b8FdHw@mail.gmail.com/raw
> > >>>>
> > >>>> OK, sounds reasonable. I'll try to give the series some testing in=
 the
> > >>>> coming days.
> > >>>>
> > >>>> // I still would probably prefer "seconds" timeout granularity.
> > >>>> // Unless this also has been discussed already and Bernd has a lin=
k ;)
> > >>>
> > >>>
> > >>> The issue is that is currently iterating through 256 hash lists +
> > >>> pending + bg.
> > >>>
> > >>> https://lore.kernel.org/all/CAJnrk1b7bfAWWq_pFP=3D4XH3ddc_9GtAM2mE7=
EgWnx2Od+UUUjQ@mail.gmail.com/raw
> > >>
> > >> Oh, I see.
> > >>
> > >>> Personally I would prefer a second list to avoid the check spike an=
d latency
> > >>> https://lore.kernel.org/linux-fsdevel/9ba4eaf4-b9f0-483f-90e5-9512a=
ded419e@fastmail.fm/raw
> > >>
> > >> That's good to know.  I like the idea of less CPU usage in general,
> > >> our devices a battery powered so everything counts, to some extent.
> > >>
> > >>> What is your opinion about that? I guess android and chromium have =
an
> > >>> interest low latencies and avoiding cpu spikes?
> > >>
> > >> Good question.
> > >>
> > >> Can't speak for android, in chromeos we probably will keep it at 1 m=
inute,
> > >> but this is because our DEFAULT_HUNG_TASK_TIMEOUT is larger than tha=
t (we
> > >> use default value of 120 sec). There are setups that might use lower
> > >> values, or even re-define default value, e.g.:
> > >>
> > >> arch/arc/configs/axs101_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=
=3D10
> > >> arch/arc/configs/axs103_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=
=3D10
> > >> arch/arc/configs/axs103_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEO=
UT=3D10
> > >> arch/arc/configs/hsdk_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D1=
0
> > >> arch/arc/configs/vdk_hs38_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=
=3D10
> > >> arch/arc/configs/vdk_hs38_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIM=
EOUT=3D10
> > >> arch/powerpc/configs/mvme5100_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIM=
EOUT=3D20
> > >>
> > >> In those cases 1 minute fuse timeout will overshot HUNG_TASK_TIMEOUT
> > >> and then the question is whether HUNG_TASK_PANIC is set.
> > >>
> > >> On the other hand, setups that set much lower timeout than
> > >> DEFAULT_HUNG_TASK_TIMEOUT=3D120 will have extra CPU activities regar=
dless,
> > >> just because watchdogs will run more often.
> > >>
> > >> Tomasz, any opinions?
> > >
> > > First of all, thanks everyone for looking into this.
>
> Hi Sergey and Tomasz,
>
> Sorry for the late reply - I was out the last couple of days. Thanks
> Bernd for weighing in and answering the questions!
>
> > >
> > > How about keeping a list of requests in the FIFO order (in other
> > > words: first entry is the first to timeout) and whenever the first
> > > entry is being removed from the list (aka the request actually
> > > completes), re-arming the timer to the timeout of the next request in
> > > the list? This way we don't really have any timer firing unless there
> > > is really a request that timed out.
>
> I think the issue with this is that we likely would end up wasting
> more cpu cycles. For a busy FUSE server, there could be hundreds
> (thousands?) of requests that happen within the span of
> FUSE_TIMEOUT_TIMER_FREQ seconds.
>
> While working on the patch, one thing I considered was disarming the
> timer in the timeout handler fuse_check_timeout() if no requests are
> on the list, in order to accomodate for "quiet periods" (eg if the
> FUSE server is inactive for a few minutes or hours) but ultimately
> decided against it because of the overhead it'd incur per request (eg
> check if the timer is disarmed, would most likely need to grab the
> fc->lock as well since timer rearming would need to be synchronized
> between background and non-background requests, etc.).
>
> All in all, imo I don't think having the timer trigger every 60
> seconds (what FUSE_TIMEOUT_TIMER_FREQ is set to) is too costly.
>
> >
> > Requests are in FIFO order on the list and only head is checked.
> > There are 256 hash lists per fuse device for requests currently
> > in user space, though.
> >
> > >
> > > (In fact, we could optimize it even further by opportunistically
> > > scheduling a timer slightly later and opportunistically handling time=
d
> > > out requests when other requests are being completed, but this would
> > > be optimizing for the slow path, so probably an overkill.)
> > >
> > > As for the length of the request timeout vs the hung task watchdog
> > > timeout, my opinion is that we should make sure that the hung task
> > > watchdog doesn't hit in any case, simply because a misbehaving
> > > userspace process must not be able to panic the kernel. In the
> > > blk-core, the blk_io_schedule() function [1] uses
> > > sysctl_hung_task_timeout_secs to determine the maximum length of a
> > > single uninterruptible sleep. I suppose we could use the same
> > > calculation to obtain our timeout number. What does everyone think?
> > >
> > > [1] https://elixir.bootlin.com/linux/v6.12.1/source/block/blk-core.c#=
L1232
> >
> > I think that is a good idea.
>
> Btw, just something to note, the fuse request timeout has an upper
> margin of error associated with it.
>
> Copying over from the commit message -
>
> "Please note that these timeouts are not 100% precise. The request may
> take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
> timeout due to how it's internally implemented."
>
> For example, if a server sets the request timeout config to 10
> minutes, the server could be aborted after 11 minutes
> (FUSE_TIMEOUT_TIMER_FREQ is set to 60 seconds internally) instead of
> 10 minutes.
>

Let me add +Brian Geffon who also was thinking about the right timeout valu=
e.

>
> Thanks,
> Joanne
> >
> >
> > Thanks,
> > Bernd

