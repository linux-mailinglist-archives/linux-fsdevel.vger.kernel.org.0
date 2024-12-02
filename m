Return-Path: <linux-fsdevel+bounces-36229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F419DFD83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 10:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D915B282B01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E6C1FBEA1;
	Mon,  2 Dec 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nzQRWmaX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7B1FBE91
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132732; cv=none; b=HsjNrNhGK/bWuvNbjn+WhgkpyI5sArWSTcXsf8D1pNwF9xxUW8BgbWcuxNb1gnDQ1s+Yu3z5yiX/9VDPJnJJPowrpKx5XZ4tVO+X+FJ3XHmpOTGXEZfu1/Pa6ojpIVL+xhsBJszgdQQQzwHIsw9uYaZm+G+6lDQLqlng+Pi7qpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132732; c=relaxed/simple;
	bh=e/crmDZ5A8X10+tJcJNy1NwuSFl77VnTElSQXT3A1Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5I/TezVl5Wg12ODqq8TTEYQ+bez4ERr/l9SpTJiyCT5KefZVnGdin96B1fRr+dO8nJD9Xfio0CjL9pg7cwZOlP06SKl33P14TFfZQvtHJT5dV558MCCLbMjIHAYlu3erSoKvoWz+zGOwc53i0WaFnUy6I9hxN6I39+cCD1b7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nzQRWmaX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so4909024a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 01:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733132729; x=1733737529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE2iQ9UBMwsTpNrARZHZF06rdwbNTQTKZL/vG7/23ys=;
        b=nzQRWmaXPLHlXpnpXXgd8VmuhEhBntDnR94MLMwrR3QqeyL9NdI8z2raYWWL2NKHNq
         RjNy7ZvEMKzL6cZAZVgDj+cQelDMsWpucFbUST0TOjEdwgKgR16+MDu8vIlE6FWVIMMO
         f9OH9jBSFBlXW7Y2DI/eEt0Z132XfwpSr7GVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132729; x=1733737529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cE2iQ9UBMwsTpNrARZHZF06rdwbNTQTKZL/vG7/23ys=;
        b=DPM0unmLZoo+Y6vHK2bTNW9dAy9nlAJDzx3txcv8AM1j7z+IJtOHbQNh8Q/wFvVQqb
         +Q6HOHIGqy7HtjR8n4ZQGsh9a1TBIy7bR48767NlCMMQNaDGGAcNXNBv7Hi1RiwsnN3V
         h1JSC9RulAkz+EXei59LOL03AwkItKECWaZhIbMO2gZPNdjf6GHMuViY3KCkUhkCt0Bb
         wH62AePLj1ZMkbJTj9cFx9mT7bQC5ntWz1JD+l8IwxxPDRYy45xzEriZAHNSED+/vOtE
         98cXdHL0wqMCLMUsA6efftQdfvvyOQY7XiwakV3YDvS8dcwGD2GxXdFjyqKgf0wGkKD+
         LSBg==
X-Forwarded-Encrypted: i=1; AJvYcCW2YHmMLSrRJdIsknn2ocE53wH0jiAYDLZH837u5HzX94SEk/UwHF6Cd6hXjR8EZ1du/tcYr/qJlsmzCIcy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5su5Wlscy4wxTWljoZEwwlm/y8HuJcgH0yiQ/LBkiIBAVyERu
	1IAVZ2GonV7Awe77s84Eld2G7uhkrgC7aNecebGz2IOQ/8RtLoBsV3BgozvylC2rdOIkONU5kmV
	bQw==
X-Gm-Gg: ASbGncsaTuc43YFWVWcLTWBJylc9acNnUXWlCLTMQIqct6VngHs0cZfmTy0df65Qm/B
	cBqQJceEcj6OgAtZW0p5hDf68fw4V/qTDN9MFWBGE9R+z8M47rRekLL4tWiGh9nybvEqMN3Fn+K
	a3Beh0qL8vhmTyNN2NzVG0gkpF9K2n8yaF0Qp2s04PbQxUDkHg5zbdLUZ3ydzk7gtlhhYc0g1w5
	1P2dQcyN+tzdlJXaCv9QjnCXV1Skluo0DJsm+2S220WQdzhpzLvYNc1drjYo4pYQBM/pvWutwEg
	ZfYxFlJmGQ==
X-Google-Smtp-Source: AGHT+IHySP1t5TddtS+8W6HBRtqUX+5QHrgWD26btSUL5385Pf1/LHeW4M84x3FbOsAjbbTJ/kiK+w==
X-Received: by 2002:a05:6402:2491:b0:5cf:d19c:e21c with SMTP id 4fb4d7f45d1cf-5d080bd3fe6mr22819732a12.20.1733132728630;
        Mon, 02 Dec 2024 01:45:28 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0b264f0d2sm3769309a12.72.2024.12.02.01.45.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 01:45:27 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so9618a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 01:45:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVO0G19BxoGFm/OSWMZUxadafMJ+ZMsjsDs7jSsbQpWMJOD5rQWBcqdoOQsMZNh8dIuQUUPeTSCeIMk/nvY@vger.kernel.org
X-Received: by 2002:a05:6402:292:b0:5d0:b20c:2063 with SMTP id
 4fb4d7f45d1cf-5d0b20c21b4mr143815a12.7.1733132727177; Mon, 02 Dec 2024
 01:45:27 -0800 (PST)
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
In-Reply-To: <20241128115455.GG10431@google.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 2 Dec 2024 18:45:10 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BW+nqZ2-_U_dj+=jLeOK9_FYN7sf_4U9PTTcbw8WJYWQ@mail.gmail.com>
Message-ID: <CAAFQd5BW+nqZ2-_U_dj+=jLeOK9_FYN7sf_4U9PTTcbw8WJYWQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Bernd Schubert <bschubert@ddn.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Joanne Koong <joannelkoong@gmail.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, 
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>, "laoar.shao@gmail.com" <laoar.shao@gmail.com>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

On Thu, Nov 28, 2024 at 8:55=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Cc-ing Tomasz
>
> On (24/11/28 11:23), Bernd Schubert wrote:
> > > Thanks for the pointers again, Bernd.
> > >
> > >> Miklos had asked for to abort the connection in v4
> > >> https://lore.kernel.org/all/CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACF=
dgJJ_b8FdHw@mail.gmail.com/raw
> > >
> > > OK, sounds reasonable. I'll try to give the series some testing in th=
e
> > > coming days.
> > >
> > > // I still would probably prefer "seconds" timeout granularity.
> > > // Unless this also has been discussed already and Bernd has a link ;=
)
> >
> >
> > The issue is that is currently iterating through 256 hash lists +
> > pending + bg.
> >
> > https://lore.kernel.org/all/CAJnrk1b7bfAWWq_pFP=3D4XH3ddc_9GtAM2mE7EgWn=
x2Od+UUUjQ@mail.gmail.com/raw
>
> Oh, I see.
>
> > Personally I would prefer a second list to avoid the check spike and la=
tency
> > https://lore.kernel.org/linux-fsdevel/9ba4eaf4-b9f0-483f-90e5-9512aded4=
19e@fastmail.fm/raw
>
> That's good to know.  I like the idea of less CPU usage in general,
> our devices a battery powered so everything counts, to some extent.
>
> > What is your opinion about that? I guess android and chromium have an
> > interest low latencies and avoiding cpu spikes?
>
> Good question.
>
> Can't speak for android, in chromeos we probably will keep it at 1 minute=
,
> but this is because our DEFAULT_HUNG_TASK_TIMEOUT is larger than that (we
> use default value of 120 sec). There are setups that might use lower
> values, or even re-define default value, e.g.:
>
> arch/arc/configs/axs101_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D10
> arch/arc/configs/axs103_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D10
> arch/arc/configs/axs103_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D=
10
> arch/arc/configs/hsdk_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D10
> arch/arc/configs/vdk_hs38_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D10
> arch/arc/configs/vdk_hs38_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=
=3D10
> arch/powerpc/configs/mvme5100_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=
=3D20
>
> In those cases 1 minute fuse timeout will overshot HUNG_TASK_TIMEOUT
> and then the question is whether HUNG_TASK_PANIC is set.
>
> On the other hand, setups that set much lower timeout than
> DEFAULT_HUNG_TASK_TIMEOUT=3D120 will have extra CPU activities regardless=
,
> just because watchdogs will run more often.
>
> Tomasz, any opinions?

First of all, thanks everyone for looking into this.

How about keeping a list of requests in the FIFO order (in other
words: first entry is the first to timeout) and whenever the first
entry is being removed from the list (aka the request actually
completes), re-arming the timer to the timeout of the next request in
the list? This way we don't really have any timer firing unless there
is really a request that timed out.

(In fact, we could optimize it even further by opportunistically
scheduling a timer slightly later and opportunistically handling timed
out requests when other requests are being completed, but this would
be optimizing for the slow path, so probably an overkill.)

As for the length of the request timeout vs the hung task watchdog
timeout, my opinion is that we should make sure that the hung task
watchdog doesn't hit in any case, simply because a misbehaving
userspace process must not be able to panic the kernel. In the
blk-core, the blk_io_schedule() function [1] uses
sysctl_hung_task_timeout_secs to determine the maximum length of a
single uninterruptible sleep. I suppose we could use the same
calculation to obtain our timeout number. What does everyone think?

[1] https://elixir.bootlin.com/linux/v6.12.1/source/block/blk-core.c#L1232

Best regards,
Tomasz

