Return-Path: <linux-fsdevel+bounces-36280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C1C9E0C1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 20:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A91016259D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D01B1DE4D7;
	Mon,  2 Dec 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHFwTafc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63B2AD21
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167758; cv=none; b=YHVKc30UlfptZf0HVkcGQQ3AbwUK4EyaQsazz9OP8dyPS0O9FqtbUwcL87r+8cCp7zBea+Jeg+0RDzgxTWAruoWCucRyt23NY/Z99v2Vss5lPZbCz1+iO5qtmxguB59C3LQwyM6ZKsaoSPBlo9TbB4XLRvOCneruCMqZ9CBTzEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167758; c=relaxed/simple;
	bh=T8aUwdoe2h9MXjHhR766fuTVLeRQntoJGjtcRqIt+gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5IdnA7jySTl7GAwz7uGjqC7SztpkqhQ0NbCihOjGAfH/Mk2NIU0yooDJRyyIffJJRhQyNpSduj11ByaYNw2kFx/V/TBKs8kfEmafZhldyMO12uMpX+8/jY0tEmmsanimlPfhMhTep8E5TRDg0q5sP40rFzj2hkl7Ux/UualCsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHFwTafc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6844074e7so405679785a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 11:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733167755; x=1733772555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXaoLDWgkU52P9NujhZF3/n+n3sYZLK7GfVkpbmCbM4=;
        b=VHFwTafcnVcJx6IzXWDMhOUE+vefC+kgOAcL4kf47dZjUbcu5cRP3w0wds6tQwpViE
         Kao9sda/yX59hQhEJoX7YrweNTkWXwG06KSva7/sdlBcLuHq0Gby7744PhsXZcTU4kkd
         NRjxXNKRfMO6Bb3E1eHKAcpRdi6TyaBeQO3TBfjSHwW9SQKn2E+GTt6jAx83yzGRmZM9
         Gq+UyUIjFi+W1GHwUeQ94urEb+4lW4MoV0VhkoXZYeVkaVDkpoZKuIWr3bxnCzaBdABq
         Cy23yPV1JP42SMUPxgc6a6YcZ5y2zp2iFlxh5Xy7UFu+yj1c7c6s8PYL5lkrj4bYqXcx
         Gn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167755; x=1733772555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXaoLDWgkU52P9NujhZF3/n+n3sYZLK7GfVkpbmCbM4=;
        b=p9ZvH4GsZLTdiv1zcxqPbvjrMFRMdeoNjLgyBT4q436EzgwfCuVdFycdAgKiRPBAQJ
         btYjoimZNWmVnu8ny0VmMJ+TWbiLhrfebP2WjRedL3m0UPxQTfwmiQHUaRl5IojbJeuY
         A+lStEJAYK+pyO9yON3DC6QHoPqQNB+nd1iYIgSYblOTD84WyeHoYWKJLU5YKPP3s/8W
         Y6vPRTD4yfLsP7xyqwOl8hPUSMJGxE8mH+c5IwZVVw+E9YPSVc8LWrFxxVhDxEr4qvP6
         onuTsshcMCCHYIzBvRdpFdCv4/ZMbAV6+76B+XHcqO/LsHGh8xjUWfkzZ9SzFWF7LC+G
         5sEw==
X-Forwarded-Encrypted: i=1; AJvYcCWtkzURH34UZeWVMn+mqHEsRXRkoIIB1hps4AcBFlTkryDkWKqGl824d3k3dvUIQnOYwoSLTtcwzrloHU2n@vger.kernel.org
X-Gm-Message-State: AOJu0YyWicOhYugxBjwilJW89fL4Skd92C9qyWIXL6hSL0iBbKJvyIhQ
	1n4JvAjejxG+XsifzTGfMFzoHfEKh1kjoUsAPvqXWMAloKYZ2o2v6P8Eb76KemMqj7gfX4gBgpg
	32CeFS6AXhRxnCVY4HTAsjhWGXkw=
X-Gm-Gg: ASbGncuVRbQ9SNjTLkTqV38QVa7uXEmbICIKrxCbZziZrFGIfnmXa0+bkqSrcS7EF65
	29p2zRI5gGM96Fk/Ys15Yd9ZqeW7rDZWMiz4XFLSUZnJVQDY=
X-Google-Smtp-Source: AGHT+IGCYyhFUayzq4WJUJiG7AP5mIoj9dHUuYS9Vy6tKho1fshWC9E4aw25EBL92ThPhcreZLVhz6pG5o9m71Cc810=
X-Received: by 2002:a05:620a:4481:b0:7b1:3b33:521b with SMTP id
 af79cd13be357-7b67c43525bmr3585356085a.44.1733167755490; Mon, 02 Dec 2024
 11:29:15 -0800 (PST)
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
 <CAAFQd5BW+nqZ2-_U_dj+=jLeOK9_FYN7sf_4U9PTTcbw8WJYWQ@mail.gmail.com> <ab0c3519-2664-4a23-adfa-d179164e038d@fastmail.fm>
In-Reply-To: <ab0c3519-2664-4a23-adfa-d179164e038d@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 2 Dec 2024 11:29:04 -0800
Message-ID: <CAJnrk1b3n7z3wfbZzUB_zVi3PTfjbZFbiUTfFMfAu61-t-W7Ug@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Bernd Schubert <bschubert@ddn.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, 
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>, "laoar.shao@gmail.com" <laoar.shao@gmail.com>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 6:43=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 12/2/24 10:45, Tomasz Figa wrote:
> > Hi everyone,
> >
> > On Thu, Nov 28, 2024 at 8:55=E2=80=AFPM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> >>
> >> Cc-ing Tomasz
> >>
> >> On (24/11/28 11:23), Bernd Schubert wrote:
> >>>> Thanks for the pointers again, Bernd.
> >>>>
> >>>>> Miklos had asked for to abort the connection in v4
> >>>>> https://lore.kernel.org/all/CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JAC=
FdgJJ_b8FdHw@mail.gmail.com/raw
> >>>>
> >>>> OK, sounds reasonable. I'll try to give the series some testing in t=
he
> >>>> coming days.
> >>>>
> >>>> // I still would probably prefer "seconds" timeout granularity.
> >>>> // Unless this also has been discussed already and Bernd has a link =
;)
> >>>
> >>>
> >>> The issue is that is currently iterating through 256 hash lists +
> >>> pending + bg.
> >>>
> >>> https://lore.kernel.org/all/CAJnrk1b7bfAWWq_pFP=3D4XH3ddc_9GtAM2mE7Eg=
Wnx2Od+UUUjQ@mail.gmail.com/raw
> >>
> >> Oh, I see.
> >>
> >>> Personally I would prefer a second list to avoid the check spike and =
latency
> >>> https://lore.kernel.org/linux-fsdevel/9ba4eaf4-b9f0-483f-90e5-9512ade=
d419e@fastmail.fm/raw
> >>
> >> That's good to know.  I like the idea of less CPU usage in general,
> >> our devices a battery powered so everything counts, to some extent.
> >>
> >>> What is your opinion about that? I guess android and chromium have an
> >>> interest low latencies and avoiding cpu spikes?
> >>
> >> Good question.
> >>
> >> Can't speak for android, in chromeos we probably will keep it at 1 min=
ute,
> >> but this is because our DEFAULT_HUNG_TASK_TIMEOUT is larger than that =
(we
> >> use default value of 120 sec). There are setups that might use lower
> >> values, or even re-define default value, e.g.:
> >>
> >> arch/arc/configs/axs101_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D1=
0
> >> arch/arc/configs/axs103_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D1=
0
> >> arch/arc/configs/axs103_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=
=3D10
> >> arch/arc/configs/hsdk_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D10
> >> arch/arc/configs/vdk_hs38_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=
=3D10
> >> arch/arc/configs/vdk_hs38_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEO=
UT=3D10
> >> arch/powerpc/configs/mvme5100_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEO=
UT=3D20
> >>
> >> In those cases 1 minute fuse timeout will overshot HUNG_TASK_TIMEOUT
> >> and then the question is whether HUNG_TASK_PANIC is set.
> >>
> >> On the other hand, setups that set much lower timeout than
> >> DEFAULT_HUNG_TASK_TIMEOUT=3D120 will have extra CPU activities regardl=
ess,
> >> just because watchdogs will run more often.
> >>
> >> Tomasz, any opinions?
> >
> > First of all, thanks everyone for looking into this.

Hi Sergey and Tomasz,

Sorry for the late reply - I was out the last couple of days. Thanks
Bernd for weighing in and answering the questions!

> >
> > How about keeping a list of requests in the FIFO order (in other
> > words: first entry is the first to timeout) and whenever the first
> > entry is being removed from the list (aka the request actually
> > completes), re-arming the timer to the timeout of the next request in
> > the list? This way we don't really have any timer firing unless there
> > is really a request that timed out.

I think the issue with this is that we likely would end up wasting
more cpu cycles. For a busy FUSE server, there could be hundreds
(thousands?) of requests that happen within the span of
FUSE_TIMEOUT_TIMER_FREQ seconds.

While working on the patch, one thing I considered was disarming the
timer in the timeout handler fuse_check_timeout() if no requests are
on the list, in order to accomodate for "quiet periods" (eg if the
FUSE server is inactive for a few minutes or hours) but ultimately
decided against it because of the overhead it'd incur per request (eg
check if the timer is disarmed, would most likely need to grab the
fc->lock as well since timer rearming would need to be synchronized
between background and non-background requests, etc.).

All in all, imo I don't think having the timer trigger every 60
seconds (what FUSE_TIMEOUT_TIMER_FREQ is set to) is too costly.

>
> Requests are in FIFO order on the list and only head is checked.
> There are 256 hash lists per fuse device for requests currently
> in user space, though.
>
> >
> > (In fact, we could optimize it even further by opportunistically
> > scheduling a timer slightly later and opportunistically handling timed
> > out requests when other requests are being completed, but this would
> > be optimizing for the slow path, so probably an overkill.)
> >
> > As for the length of the request timeout vs the hung task watchdog
> > timeout, my opinion is that we should make sure that the hung task
> > watchdog doesn't hit in any case, simply because a misbehaving
> > userspace process must not be able to panic the kernel. In the
> > blk-core, the blk_io_schedule() function [1] uses
> > sysctl_hung_task_timeout_secs to determine the maximum length of a
> > single uninterruptible sleep. I suppose we could use the same
> > calculation to obtain our timeout number. What does everyone think?
> >
> > [1] https://elixir.bootlin.com/linux/v6.12.1/source/block/blk-core.c#L1=
232
>
> I think that is a good idea.

Btw, just something to note, the fuse request timeout has an upper
margin of error associated with it.

Copying over from the commit message -

"Please note that these timeouts are not 100% precise. The request may
take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
timeout due to how it's internally implemented."

For example, if a server sets the request timeout config to 10
minutes, the server could be aborted after 11 minutes
(FUSE_TIMEOUT_TIMER_FREQ is set to 60 seconds internally) instead of
10 minutes.


Thanks,
Joanne
>
>
> Thanks,
> Bernd

