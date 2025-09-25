Return-Path: <linux-fsdevel+bounces-62770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769ABA0371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 17:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9A056008E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F52ED84A;
	Thu, 25 Sep 2025 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aJTLYxvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF1C2E2657
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812861; cv=none; b=ubpv8qhIzGUrZZvxQfnJjbp/wXaoJp7y7pQgxrepwjGxAciRtStmo4ghTa3knvqQDC0JYjpSvG50lzZzUBRMF/NzvTdBEicUSj/feZpADuD5Iql6eM2Kfjk+DxGA0MziSQ+LytZJA/2n7EiPkD5csTMiVmfLV945Ivl8kt5cgmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812861; c=relaxed/simple;
	bh=KTPdMDFNOlFP4wpn+4ognk+Lj8iX++1s9077Y5P+yK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2Bu8Rk4Uk44wDN3KKPURESBZ5RcmslFvVkXarMBZFWs+gEKtrLOGpWUpcm40/j0MYyt4AyimELQc3bMnoAylleLHeNabfeXyvGWn5VMU1FkO893jhrXq6sCxkmuSK5Wso2C1YCcVl3bOZV/gis5eJZs+a0/twP0OYKm0xeMlxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aJTLYxvI; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-749399349ddso11590967b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758812858; x=1759417658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpLopcviAyL+cm/HeEUTCBhC6Rw+eg0eRJGycPnbyFI=;
        b=aJTLYxvIYw5XyCMD56WfTg/RkJSK9UKyiSG1C35yBBBCBD1smzAgzBXtz3EayzXUje
         WaVlqNxq1ASSZQkT0jDhDAL4nYtFbsIoG4kSoESEIgiLH2IFVWqbsW9jCCpe80FDx6Z1
         01Di0NlJF/9GIVKVXLKYKjEa4FmownW//OQyflTabDfa2MdaDWJ3MGVD41MYlmS/TKv1
         x4zD04gl7qXdRFDPSaPZX5f+PZopD+KE024ZQcnIm/LS+FhLmiEZnnbzC6dPYDrLFyO+
         q6eDUEdy11SA2DpJoYR7r0Xvzlw0ESPm0XP4x9kjol6DaSnTbOa4t1i9BqqLYlVGDUGw
         FAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758812858; x=1759417658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpLopcviAyL+cm/HeEUTCBhC6Rw+eg0eRJGycPnbyFI=;
        b=mFm+yN8u9AnmWuh/9MzS965yJcOCnbLAWkLRHkKE8rNSOzjeIlZHt5weQ7cPUX/IP2
         9/N7RxcK1ZuIYdgvAUDQoqTQCZ1pCFIWyppflM9Wz2kN/bpzcqAltMyQQiDeJ+oKw9I3
         Pqe5c7ju9ZnOSRNUXGu2kg8yxM4o7y3u0+eEnwoHbxGLWjBQT//hnAhAiX4njHEDiN/C
         s1d96Yhohuct0T348YryAHNRm+G9WJpfcOQCMaMmwM8yJa/CYIko+Xl1dKyh4RO23Y0+
         iqnD2TdQ0CXVQFXI/4ysXzJqinrzidr2hY4XpWoyDFIPKWU2yDS6q0YJJoY3mfTeXzdI
         manQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbBnqHXl35CABvdZytXe36NfnVLUjmBAUmjjaKI+bvPSVbFghuE1LXfR717VUrdy/fBwbYqQLfAHCVdud/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/4wl5DH+S6bcjq7V0rTBjzvHshdBTBuLrbfh33ACxANZmwd4q
	oFA7vLt7eeUx3TyEuvPs0i+jlMIlxu6MWsRtNDuBRM+bMci7lR/TTvpSVGSxKyijDWOkvK9y1xF
	QYwZzKj2Qr9zZQnOxz8zfPWRphD0UU3Ma2LfwW6sy9w==
X-Gm-Gg: ASbGnctI1LJ3uhsOCIKTfzlKwQdmh/d8HmlbsOGfXAcT0/61eOZzaYeBDxaSEmSjIVH
	jwW2GhwbnJZc1llHYF54dTLOFOp15xxvzi94QcLuo7atCycj3JqBvy8NVMzbcwWiIOicZFcaC2J
	rGjoRACuBtNLYEC7ET67jz0Eh6zoem9OJXrxURzMmjeoBtrKpgf4iUrpbDv33lNki6WL5JkI0F
X-Google-Smtp-Source: AGHT+IGJjpOjF1gEoONMW3eJFJViXG5AodzdaKYdKIgJXeEIkqy8REpwSvtzJ3VcNK/DtFxa4Brmx09wKn93tzbNHDU=
X-Received: by 2002:a05:6902:729:b0:eb3:c364:37e with SMTP id
 3f1490d57ef6-eb3c3640c1fmr1374039276.30.1758812857890; Thu, 25 Sep 2025
 08:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <20250922132718.GB49638@noisy.programming.kicks-ass.net> <aNGQoPFTH2_xrd9L@infradead.org>
 <20250922145045.afc6593b4e91c55d8edefabb@linux-foundation.org>
 <20250923071607.GR3245006@noisy.programming.kicks-ass.net> <dndr5xdp3bweqtwlyixtzajxgkhxbt2qb2fzg6o2wy5msrhzi4@h3klek5hff5i>
In-Reply-To: <dndr5xdp3bweqtwlyixtzajxgkhxbt2qb2fzg6o2wy5msrhzi4@h3klek5hff5i>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Thu, 25 Sep 2025 23:07:24 +0800
X-Gm-Features: AS18NWCEIRypu1nYMSOfm4MhEFu5D4ZSJZwTJZewijiycz6KgR4n8DcFX7UDH-8
Message-ID: <CAHSKhteCMv0fUmDKHdKXhg=D-rz-Jmze5ei-Up16vMsNEy898w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/3] Suppress undesirable hung task warnings.
To: Jan Kara <jack@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lance.yang@linux.dev, 
	mhiramat@kernel.org, agruenba@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 24, 2025 at 6:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 23-09-25 09:16:07, Peter Zijlstra wrote:
> > On Mon, Sep 22, 2025 at 02:50:45PM -0700, Andrew Morton wrote:
> > > On Mon, 22 Sep 2025 11:08:32 -0700 Christoph Hellwig <hch@infradead.o=
rg> wrote:
> > >
> > > > On Mon, Sep 22, 2025 at 03:27:18PM +0200, Peter Zijlstra wrote:
> > > > > > Julian Sun (3):
> > > > > >   sched: Introduce a new flag PF_DONT_HUNG.
> > > > > >   writeback: Introduce wb_wait_for_completion_no_hung().
> > > > > >   memcg: Don't trigger hung task when memcg is releasing.
> > > > >
> > > > > This is all quite terrible. I'm not at all sure why a task that i=
s
> > > > > genuinely not making progress and isn't killable should not be re=
ported.
> > > >
> > > > The hung device detector is way to aggressive for very slow I/O.
> > > > See blk_wait_io, which has been around for a long time to work
> > > > around just that.  Given that this series targets writeback I suspe=
ct
> > > > it is about an overloaded device as well.
> > >
> > > Yup, it's writeback - the bug report is in
> > > https://lkml.kernel.org/r/20250917212959.355656-1-sunjunchao@bytedanc=
e.com
> > >
> > > Memory is big and storage is slow, there's nothing wrong if a task
> > > which is designed to wait for writeback waits for a long time.
> > >
> > > Of course, there's something wrong if some other task which isn't
> > > designed to wait for writeback gets stuck waiting for the task which
> > > *is* designed to wait for writeback, but we'll still warn about that.
> > >
> > >
> > > Regarding an implementation, I'm wondering if we can put a flag in
> > > `struct completion' telling the hung task detector that this one is
> > > expected to wait for long periods sometimes.  Probably messy and it
> > > only works for completions (not semaphores, mutexes, etc).  Just
> > > putting it out there ;)
> >
> > So the problem is that there *is* progress (albeit rather slowly), the
> > watchdog just doesn't see that. Perhaps that is the thing we should loo=
k
> > at fixing.
> >
> > How about something like the below? That will 'spuriously' wake up the
> > waiters as long as there is some progress being made. Thereby increasin=
g
> > the context switch counters of the tasks and thus the hung_task watchdo=
g
> > sees progress.
> >
> > This approach should be safer than the blk_wait_io() hack, which has a
> > timer ticking, regardless of actual completions happening or not.
>
> I like the idea. The problem with your patch is that the progress is not
> visible with high enough granularity in wb_writeback_work->done completio=
n.
> That is only incremented by 1, when say a request to writeout 1GB is queu=
ed
> and decremented by 1 when that 1GB is written. The progress can be observ=
ed
> with higher granularity by wb_writeback_work->nr_pages getting decremente=
d
> as we submit pages for writeback but this counter still gets updated only
> once we are done with a particular inode so if all those 1GB of data are =
in
> one inode there wouldn't be much to observe. So we might need to observe
> how struct writeback_control member nr_to_write gets updated. That is
> really updated frequently on IO submission but each filesystem updates it
> in their writepages() function so implementing that gets messy pretty
> quickly.
>
> But maybe a good place to hook into for registering progress would be
> wbc_init_bio()? Filesystems call that whenever we create new bio for writ=
eback
> purposes. We do have struct writeback_control available there so through
> that we could propagate information that forward progress is being made.
>
> What do people think?

Sorry for the late reply. Yes, Jan, I agree =E2=80=94 your proposal sounds
both fine-grained and elegant. But do we really have a strong need for
such detailed progress tracking?

In background writeback, for example, if the bandwidth is very low
(e.g. avg_write_bandwidth=3D24), writeback_chunk_size() already splits
pages into chunks of MIN_WRITEBACK_PAGES (1024). This is usually
enough to avoid hung task warnings, so reporting progress there might
be sufficient.

I=E2=80=99m also a bit concerned that reporting progress on every
wbc_init_bio() could lead to excessive wakeups in normal or
high-throughput cases, which might have side effects. Please correct
me if I=E2=80=99m missing something.

>
>                                                                 Honza
>
> > ---
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index a07b8cf73ae2..1326193b4d95 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -174,9 +174,10 @@ static void finish_writeback_work(struct wb_writeb=
ack_work *work)
> >               kfree(work);
> >       if (done) {
> >               wait_queue_head_t *waitq =3D done->waitq;
> > +             bool force_wake =3D (jiffies - done->stamp) > HZ/2;
> >
> >               /* @done can't be accessed after the following dec */
> > -             if (atomic_dec_and_test(&done->cnt))
> > +             if (atomic_dec_and_test(&done->cnt) || force_wake)
> >                       wake_up_all(waitq);
> >       }
> >  }
> > @@ -213,7 +214,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
> >  void wb_wait_for_completion(struct wb_completion *done)
> >  {
> >       atomic_dec(&done->cnt);         /* put down the initial count */
> > -     wait_event(*done->waitq, !atomic_read(&done->cnt));
> > +     wait_event(*done->waitq, ({ done->stamp =3D jiffies; !atomic_read=
(&done->cnt); }));
> >  }
> >
> >  #ifdef CONFIG_CGROUP_WRITEBACK
> > diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-d=
ev-defs.h
> > index 2ad261082bba..197593193ce3 100644
> > --- a/include/linux/backing-dev-defs.h
> > +++ b/include/linux/backing-dev-defs.h
> > @@ -63,6 +63,7 @@ enum wb_reason {
> >  struct wb_completion {
> >       atomic_t                cnt;
> >       wait_queue_head_t       *waitq;
> > +     unsigned long           stamp;
> >  };
> >
> >  #define __WB_COMPLETION_INIT(_waitq) \
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

