Return-Path: <linux-fsdevel+bounces-36473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A309F9E3D50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0A8160873
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39A820ADDD;
	Wed,  4 Dec 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrlUmf72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF920ADC3
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323952; cv=none; b=Q3HIflh9Lc/XfsZv52pHwr9WGjDnIx/eaKFbVSekTglsk74caqU2s+o93jcoREc3dmVsiQX5gUDc8X6h+0M63kXuRL03k8dmILgKy6DbDa85jZD/9STrbz/Vbde5dn2dxcHieHLgeDNb8Kam6/fa3cN4tzNfhgH3TD5UO31T7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323952; c=relaxed/simple;
	bh=QTXNPwIjFQ8kJ0dyyTbJcq9WG6V2T/qt9MHUJI8Dn1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oc848UOsfX30WuwNRJR2SLPX2ej4TlwcHfTnOj9KSudMbsVN7USMzLzmxepwNIU67fNcGgqD7BZ11E03oxoL/AxdoEy0O7pkrF8EVVeUAzPEGh103ozv2o/ZVdwcFBLi36yI7JVgRhgMD46R9H2OLDC65S7e9EKgThN+xoIZZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PrlUmf72; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2154dc36907so152525ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733323950; x=1733928750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xem8jZCC8L+7nU9TYzFYsBjXOPSnRgjkBiWRHx3L9cA=;
        b=PrlUmf721oqGPElBht8iBCUHncFrnZUG6e34BTmSvBZt3GowmykA7ew+l6UdQIw768
         Zkujb5669STeYq51qFo7XwvWYYra51Xzn18R56Y98GwJThEBsv3LWtZLKwER5zjvGIa6
         Gy1FFXUyGxIfxeLTi7vt693Kg8m/hOvvEyZw//UFpz6mGBcjyqb43d3eabS1SjeaZkAl
         Nfie2YWjLp7iyHHGnKCpNuf5/nXv8A++2HTy/rwlQWnFSqrSsFdsqLe60l4uWlSLhgkW
         ydQuVnovTr6HtBsTw/x/rAgQyDiJVkINw8yKN6dIFo71TLyMhEDUviSVofFjytjQDpfx
         AaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733323950; x=1733928750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xem8jZCC8L+7nU9TYzFYsBjXOPSnRgjkBiWRHx3L9cA=;
        b=XXPv4U1d+XMdqkNQE1A2cDmQQJ4YVg8l84A5dDCiaWYMSOnVaeCIeI2+KArYZIhcxz
         iMtzGfWqCIyvJclc/pmCjcScR4hYqsLs3wSrvlIwmqo2Lgz5bQ5uvTp0sUeR+9yw5eoG
         Fpc1SBs6yqpUW1zwmyawFtLQ2uDKXPw6AWmkVw0jtxMp8AgtxF0tKuxI+bf3wAZGEin9
         F8EC6UW/dOaUx4YmlDJJ0x/JhaUL30hlf43+YrCKqEbgVGattugjWn7l5K5aIwSvMGpN
         Tfs0Hri81vkigcdBtKl1hmmF1so+auvIOXXUAS8CH4XIP1gq/VNCw+G6/QcStXyVz1Tw
         maVw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8nzCVRExcG4hU6fqJw9rjmeC17HZigfSP39TYa4054m1681H5pP+sS8aWp1rwpHB/bdlhRZlojOIFEt1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4N3QbJBkYq6MGuRl+m6FrwkRpMym/MxWajGlnuEsAPAJ57tK
	mCuYWkINERFaiujkoyULLv5TkosY5abVcFNImo/Le/b3FQChMGIbmu/LzkbjaYdypBLSgEPwUGf
	aamcYNt21Tfa4DCGU6QWzVJYB7Bt0vOKbIQUK
X-Gm-Gg: ASbGncufNaDNXqlEKRnv13TEErFbwtQRWSRmDwAagJTJadol2rwCoFtNTD4OjANRhlq
	7OOSFwWYBcUei4exyHkyQJsflEbNpSg==
X-Google-Smtp-Source: AGHT+IGuYDbYOFbt/URo5ueRt2R1arcvzh9Jy44eip/ZIK8luMgQkrLNNnl1suOUXJ0CqVfVIyslvub69BEF9WR64gk=
X-Received: by 2002:a17:902:850a:b0:215:79b5:aa7e with SMTP id
 d9443c01a7336-215d9b76154mr2030845ad.13.1733323949904; Wed, 04 Dec 2024
 06:52:29 -0800 (PST)
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
 <CAAFQd5B+CkvZDSa+tZ0_ZpF0fQRC9ryXsGqm2R-ofvVqNnAJ1Q@mail.gmail.com>
In-Reply-To: <CAAFQd5B+CkvZDSa+tZ0_ZpF0fQRC9ryXsGqm2R-ofvVqNnAJ1Q@mail.gmail.com>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 4 Dec 2024 09:51:53 -0500
Message-ID: <CADyq12xSgHVFf4-bxk_9uN5-KJWnCohz1VAZKH4QEKJLJpcUEA@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Tomasz Figa <tfiga@chromium.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Bernd Schubert <bschubert@ddn.com>, 
	"miklos@szeredi.hu" <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, 
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>, "laoar.shao@gmail.com" <laoar.shao@gmail.com>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 9:40=E2=80=AFAM Tomasz Figa <tfiga@chromium.org> wro=
te:
>
> On Tue, Dec 3, 2024 at 4:29=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > On Mon, Dec 2, 2024 at 6:43=E2=80=AFAM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> > >
> > > On 12/2/24 10:45, Tomasz Figa wrote:
> > > > Hi everyone,
> > > >
> > > > On Thu, Nov 28, 2024 at 8:55=E2=80=AFPM Sergey Senozhatsky
> > > > <senozhatsky@chromium.org> wrote:
> > > >>
> > > >> Cc-ing Tomasz
> > > >>
> > > >> On (24/11/28 11:23), Bernd Schubert wrote:
> > > >>>> Thanks for the pointers again, Bernd.
> > > >>>>
> > > >>>>> Miklos had asked for to abort the connection in v4
> > > >>>>> https://lore.kernel.org/all/CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S=
2JACFdgJJ_b8FdHw@mail.gmail.com/raw
> > > >>>>
> > > >>>> OK, sounds reasonable. I'll try to give the series some testing =
in the
> > > >>>> coming days.
> > > >>>>
> > > >>>> // I still would probably prefer "seconds" timeout granularity.
> > > >>>> // Unless this also has been discussed already and Bernd has a l=
ink ;)
> > > >>>
> > > >>>
> > > >>> The issue is that is currently iterating through 256 hash lists +
> > > >>> pending + bg.
> > > >>>
> > > >>> https://lore.kernel.org/all/CAJnrk1b7bfAWWq_pFP=3D4XH3ddc_9GtAM2m=
E7EgWnx2Od+UUUjQ@mail.gmail.com/raw
> > > >>
> > > >> Oh, I see.
> > > >>
> > > >>> Personally I would prefer a second list to avoid the check spike =
and latency
> > > >>> https://lore.kernel.org/linux-fsdevel/9ba4eaf4-b9f0-483f-90e5-951=
2aded419e@fastmail.fm/raw
> > > >>
> > > >> That's good to know.  I like the idea of less CPU usage in general=
,
> > > >> our devices a battery powered so everything counts, to some extent=
.
> > > >>
> > > >>> What is your opinion about that? I guess android and chromium hav=
e an
> > > >>> interest low latencies and avoiding cpu spikes?
> > > >>
> > > >> Good question.
> > > >>
> > > >> Can't speak for android, in chromeos we probably will keep it at 1=
 minute,
> > > >> but this is because our DEFAULT_HUNG_TASK_TIMEOUT is larger than t=
hat (we
> > > >> use default value of 120 sec). There are setups that might use low=
er
> > > >> values, or even re-define default value, e.g.:
> > > >>
> > > >> arch/arc/configs/axs101_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=
=3D10
> > > >> arch/arc/configs/axs103_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=
=3D10
> > > >> arch/arc/configs/axs103_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIM=
EOUT=3D10
> > > >> arch/arc/configs/hsdk_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=
=3D10
> > > >> arch/arc/configs/vdk_hs38_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEO=
UT=3D10
> > > >> arch/arc/configs/vdk_hs38_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_T=
IMEOUT=3D10
> > > >> arch/powerpc/configs/mvme5100_defconfig:CONFIG_DEFAULT_HUNG_TASK_T=
IMEOUT=3D20
> > > >>
> > > >> In those cases 1 minute fuse timeout will overshot HUNG_TASK_TIMEO=
UT
> > > >> and then the question is whether HUNG_TASK_PANIC is set.

In my opinion this is a good argument for having the hung task timeout
and a fuse timeout independent. The hung task timeout is for hung
kernel threads, in this situation we're potentially taking too long in
userspace but that doesn't necessarily mean the system is hung. I
think a loop which does an interruptible wait with a timeout of 1/2
the hung task timeout would make sense to ensure the hung task timeout
doesn't hit. There might be situations where we want a fuse timeout
which is larger than the hung task timeout, perhaps a file system
being read over a satellite internet connection?

> > > >>
> > > >> On the other hand, setups that set much lower timeout than
> > > >> DEFAULT_HUNG_TASK_TIMEOUT=3D120 will have extra CPU activities reg=
ardless,
> > > >> just because watchdogs will run more often.
> > > >>
> > > >> Tomasz, any opinions?
> > > >
> > > > First of all, thanks everyone for looking into this.
> >
> > Hi Sergey and Tomasz,
> >
> > Sorry for the late reply - I was out the last couple of days. Thanks
> > Bernd for weighing in and answering the questions!
> >
> > > >
> > > > How about keeping a list of requests in the FIFO order (in other
> > > > words: first entry is the first to timeout) and whenever the first
> > > > entry is being removed from the list (aka the request actually
> > > > completes), re-arming the timer to the timeout of the next request =
in
> > > > the list? This way we don't really have any timer firing unless the=
re
> > > > is really a request that timed out.
> >
> > I think the issue with this is that we likely would end up wasting
> > more cpu cycles. For a busy FUSE server, there could be hundreds
> > (thousands?) of requests that happen within the span of
> > FUSE_TIMEOUT_TIMER_FREQ seconds.
> >
> > While working on the patch, one thing I considered was disarming the
> > timer in the timeout handler fuse_check_timeout() if no requests are
> > on the list, in order to accomodate for "quiet periods" (eg if the
> > FUSE server is inactive for a few minutes or hours) but ultimately
> > decided against it because of the overhead it'd incur per request (eg
> > check if the timer is disarmed, would most likely need to grab the
> > fc->lock as well since timer rearming would need to be synchronized
> > between background and non-background requests, etc.).
> >
> > All in all, imo I don't think having the timer trigger every 60
> > seconds (what FUSE_TIMEOUT_TIMER_FREQ is set to) is too costly.
> >
> > >
> > > Requests are in FIFO order on the list and only head is checked.
> > > There are 256 hash lists per fuse device for requests currently
> > > in user space, though.
> > >
> > > >
> > > > (In fact, we could optimize it even further by opportunistically
> > > > scheduling a timer slightly later and opportunistically handling ti=
med
> > > > out requests when other requests are being completed, but this woul=
d
> > > > be optimizing for the slow path, so probably an overkill.)
> > > >
> > > > As for the length of the request timeout vs the hung task watchdog
> > > > timeout, my opinion is that we should make sure that the hung task
> > > > watchdog doesn't hit in any case, simply because a misbehaving
> > > > userspace process must not be able to panic the kernel. In the
> > > > blk-core, the blk_io_schedule() function [1] uses
> > > > sysctl_hung_task_timeout_secs to determine the maximum length of a
> > > > single uninterruptible sleep. I suppose we could use the same
> > > > calculation to obtain our timeout number. What does everyone think?
> > > >
> > > > [1] https://elixir.bootlin.com/linux/v6.12.1/source/block/blk-core.=
c#L1232
> > >
> > > I think that is a good idea.
> >
> > Btw, just something to note, the fuse request timeout has an upper
> > margin of error associated with it.
> >
> > Copying over from the commit message -
> >
> > "Please note that these timeouts are not 100% precise. The request may
> > take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
> > timeout due to how it's internally implemented."
> >
> > For example, if a server sets the request timeout config to 10
> > minutes, the server could be aborted after 11 minutes
> > (FUSE_TIMEOUT_TIMER_FREQ is set to 60 seconds internally) instead of
> > 10 minutes.
> >
>
> Let me add +Brian Geffon who also was thinking about the right timeout va=
lue.
>
> >
> > Thanks,
> > Joanne
> > >
> > >
> > > Thanks,
> > > Bernd

