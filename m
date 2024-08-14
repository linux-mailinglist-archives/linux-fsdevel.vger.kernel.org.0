Return-Path: <linux-fsdevel+bounces-25990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55596952459
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C631C21977
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2C1C57B5;
	Wed, 14 Aug 2024 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm0WOU5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7996A1B86C1;
	Wed, 14 Aug 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669150; cv=none; b=LB4nxvnH8iwdxvGaoEDXxcs7M9HDBlWKVjBN0WphGSgeOITZcf69GJOTVMXx0x/QasJK5MsqCY1EFuk7Zu7+TWtkcS+TKI23Vfc/zQvUoiVHctmK/O8UTMmAr8Vjp0hk5maK0UNQMCRGAJQChBa0hSsmh2tIbcYNi750INUJ2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669150; c=relaxed/simple;
	bh=8vFVUwpWpI+/TgcmZS2f6NXJyi95TXmRURxuOJMiRuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGM/YckFYzqaS4pliqYuftEq40/MPzEiTJbMHCobnTOlgrCdqU+UA4Q4b/vG94rD7MnX7j4yWPZ0QJAF/X+UeK+7vIPeoshDMn/PiOqPiI1TbM3nygZcScUUZ1S76+efYSsfdxG93vWOUaob5pBfkfwbsJuS/qREAHOQN6Fc+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm0WOU5H; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so457944a12.3;
        Wed, 14 Aug 2024 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723669146; x=1724273946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUFsxtwjK4qBkT3u2gTB6Vh0/NowA8UD9DfqrFrunBQ=;
        b=hm0WOU5HppKZU+7oZL95RF3daLFHEx33rV+SjMloWfvriV8wlD9QT2xlwKmRJdnVWU
         OnTLB2T6xKMpl+OyeC99MMoLBEdvwJaIQMcs99r6plzw4W2lAejjMICm7QcbmahMM+Oc
         c+P5pg3JCgNgNPcSGmvouKxT/f720mr5/rJvTzAtK4WCb5Ia7WJoUjxdfDKbjCuoiI7x
         8DWejXxyhXo0dMSfoir3AAFxHfcZBh7XCVAt/LyzGEKe2BJEcbDM3txZlkl8XY6Bh+1d
         r/GSzIRQYt8kxyZx/phTANyBEIzN81xuG5ZwG5Ym4znKP96CkYIPCQKMRMZLZBQhcfXA
         kAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669146; x=1724273946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUFsxtwjK4qBkT3u2gTB6Vh0/NowA8UD9DfqrFrunBQ=;
        b=XjvxuBpbOAQxT406lWgkwxfDry3UoeelNEZFQizMUK187rfMkgkA1bBnFfgKeUL9fp
         tAdrfrUns4RqP0nWaWKmm5/zpI29yKaicPUf9H4InFjxBEGCTo55v8axski/V/K7AND/
         elROu1T1algavZqP6KLJ52APOavaSZKQiilcQ6whALh5TxGyZ3vBMeUX9TH5rQ/mJaI9
         2peAVvL35U7yYksA6tgs4w1DOLfrY5P5njkCcLzu+tR8asWYXj6HtQi1XrLxY2XOUtjA
         wsjZFpNsQ4Pro+DvK0zuI2ACI1+StFgVslgZnOyb9lQZrTdYY0aD66S9nkH7gcysUAQ/
         vXjw==
X-Forwarded-Encrypted: i=1; AJvYcCVyi+kwEEDCB7y4mtOhvvs6K57yw7+JsFqjNAi70HE7cTyfC1w9DXNFwvJ5diGpNhbwAY+lqsFO0dpxeyPywMOjLTPg877OTIDj7Ouq/Vfy7nmttGRiqGs2OgUrWan87glQKNz6YZJIfjSlZg==
X-Gm-Message-State: AOJu0Yzg6N/73OKmTiu5s9W/UDA4AZAJIz/vkix46483+JlCTG9yKS7M
	zw4HbpLIF3M3M+B168Dx6Al8+WW8XBfAtpg7lRmdzkpVDVYYZcSQ/FioS4t0eQZ4BSUCF8kB/5U
	gx5hneU1cRWLAaKk+fven+sAZLTI=
X-Google-Smtp-Source: AGHT+IE+q8WyDRZou/tM0fmC4CDOmu67S4j/1xw7k9NIFZ1RfVTzOUezdCAG+mkrItstm3Yg/SA/rc57D1GEF4GexHI=
X-Received: by 2002:a17:907:e2cc:b0:a77:dd1c:6276 with SMTP id
 a640c23a62f3a-a8366c1fc04mr288940966b.7.1723669145319; Wed, 14 Aug 2024
 13:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811085954.17162-1-wen.yang@linux.dev> <w7ldxi4jcdizkefv7musjwxblwu66pg3rfteprfymqoxaev6by@ikvzlsncihbr>
 <f21b635e-3bd7-48c3-b257-dde1b9f49c6c@linux.dev>
In-Reply-To: <f21b635e-3bd7-48c3-b257-dde1b9f49c6c@linux.dev>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 14 Aug 2024 22:58:52 +0200
Message-ID: <CAGudoHFQtxU7r+Y9AV2yPc+JrTdMtzJopsjUinFK8uE5h7cbTQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] eventfd: introduce ratelimited wakeup for
 non-semaphore eventfd
To: Wen Yang <wen.yang@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Dylan Yudaken <dylany@fb.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kernel test robot <lkp@intel.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:15=E2=80=AFPM Wen Yang <wen.yang@linux.dev> wrote=
:
>
>
>
> On 2024/8/11 18:26, Mateusz Guzik wrote:
> > On Sun, Aug 11, 2024 at 04:59:54PM +0800, Wen Yang wrote:
> >> For the NON-SEMAPHORE eventfd, a write (2) call adds the 8-byte intege=
r
> >> value provided in its buffer to the counter, while a read (2) returns =
the
> >> 8-byte value containing the value and resetting the counter value to 0=
.
> >> Therefore, the accumulated value of multiple writes can be retrieved b=
y a
> >> single read.
> >>
> >> However, the current situation is to immediately wake up the read thre=
ad
> >> after writing the NON-SEMAPHORE eventfd, which increases unnecessary C=
PU
> >> overhead. By introducing a configurable rate limiting mechanism in
> >> eventfd_write, these unnecessary wake-up operations are reduced.
> >>
> >>
> > [snip]
> >
> >>      # ./a.out  -p 2 -s 3
> >>      The original cpu usage is as follows:
> >> 09:53:38 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %ste=
al  %guest  %gnice   %idle
> >> 09:53:40 PM    2   47.26    0.00   52.74    0.00    0.00    0.00    0.=
00    0.00    0.00    0.00
> >> 09:53:40 PM    3   44.72    0.00   55.28    0.00    0.00    0.00    0.=
00    0.00    0.00    0.00
> >>
> >> 09:53:40 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %ste=
al  %guest  %gnice   %idle
> >> 09:53:42 PM    2   45.73    0.00   54.27    0.00    0.00    0.00    0.=
00    0.00    0.00    0.00
> >> 09:53:42 PM    3   46.00    0.00   54.00    0.00    0.00    0.00    0.=
00    0.00    0.00    0.00
> >>
> >> 09:53:42 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %ste=
al  %guest  %gnice   %idle
> >> 09:53:44 PM    2   48.00    0.00   52.00    0.00    0.00    0.00    0.=
00    0.00    0.00    0.00
> >> 09:53:44 PM    3   45.50    0.00   54.50    0.00    0.00    0.00    0.=
00    0.00    0.00    0.00
> >>
> >> Then enable the ratelimited wakeup, eg:
> >>      # ./a.out  -p 2 -s 3  -r1000 -c2
> >>
> >> Observing a decrease of over 20% in CPU utilization (CPU # 3, 54% ->30=
%), as shown below:
> >> 10:02:32 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %ste=
al  %guest  %gnice   %idle
> >> 10:02:34 PM    2   53.00    0.00   47.00    0.00    0.00    0.00    0.=
00    0.00    0.00    0.00
> >> 10:02:34 PM    3   30.81    0.00   30.81    0.00    0.00    0.00    0.=
00    0.00    0.00   38.38
> >>
> >> 10:02:34 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %ste=
al  %guest  %gnice   %idle
> >> 10:02:36 PM    2   48.50    0.00   51.50    0.00    0.00    0.00    0.=
00    0.00    0.00    0.00
> >> 10:02:36 PM    3   30.20    0.00   30.69    0.00    0.00    0.00    0.=
00    0.00    0.00   39.11
> >>
> >> 10:02:36 PM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %ste=
al  %guest  %gnice   %idle
> >> 10:02:38 PM    2   45.00    0.00   55.00    0.00    0.00    0.00    0.=
00    0.00    0.00    0.00
> >> 10:02:38 PM    3   27.08    0.00   30.21    0.00    0.00    0.00    0.=
00    0.00    0.00   42.71
> >>
> >>
> >
> > Where are these stats from? Is this from your actual program you coded
> > the feature for?
> >
> > The program you inlined here does next to nothing in userspace and
> > unsurprisingly the entire thing is dominated by kernel time, regardless
> > of what event rate can be achieved.
> >
> > For example I got: /a.out -p 2 -s 3  5.34s user 60.85s system 99% cpu 6=
6.19s (1:06.19) total
> >
> > Even so, looking at perf top shows me that a significant chunk is
> > contention stemming from calls to poll -- perhaps the overhead will
> > sufficiently go down if you epoll instead?
>
> We have two threads here, one publishing and one subscribing, running on
> CPUs 2 and 3 respectively. If we further refine and collect performance
> data on CPU 2, we will find that a large amount of CPU is consumed on
> the spin lock of the wake-up logic of event write, for example:
>
>   # perf top  -C 2  -e cycles:k
>
>      65.80%  [kernel]       [k] do_syscall_64
>      14.71%  [kernel]       [k] _raw_spin_unlock_irq
>       7.54%  [kernel]       [k] __fget_light
>       4.52%  [kernel]       [k] ksys_write
>       1.94%  [kernel]       [k] vfs_write
>       1.43%  [kernel]       [k] _copy_from_user
>       0.87%  [kernel]       [k] common_file_perm
>       0.61%  [kernel]       [k] aa_file_perm
>       0.46%  [kernel]       [k] eventfd_write
>
>
> One of its call stacks:
>
> |--6.39%--vfs_write
> |           --5.46%--eventfd_write
> |                      --4.73%--_raw_spin_unlock_irq
>
>
> >  > I think the idea is pretty dodgey. If the consumer program can toler=
ate
> > some delay in event processing, this probably can be massaged entirely =
in
> > userspace.
> >
> > If your real program has the wake up rate so high that it constitutes a
> > tangible problem I wonder if eventfd is even the right primitive to use
> > -- perhaps something built around shared memory and futexes would do th=
e
> > trick significantly better?
>
> Thank you for your feedback.
>
> This demo comes from the real world: the test vehicle has sensors with
> multiple cycles (such as 1ms, 5ms, 10ms, etc.), and due to the large
> number of sensors, data is reported at all times. The publisher reported
> data through libzmq and went to the write logic of eventfd, frequently
> waking up the receiver. We collected flame graph and observed that a
> significant amount of CPU was consumed in this path: eventfd_write ->
> _raw_spin_unlock_irq.
>
> We did modify a lot of code in user mode on the test vehicle to avoid
> this issue, such as not using wake-up, not using eventfd, the publisher
> writing shared memory directly, the receiver periodically extracting the
> content of shared memory, and so on.
>

Well I don't have the full picture and whatnot, but given the
additional info you posted here I even more strongly suspect eventfd
is a bad fit. AFAICS this boils down to batching a number of updates
and collecting them at some interval.

With the assumption that updates to the eventfd counter are guaranteed
to not overflow within the wakeup delay and that there is constant
traffic, I'm suspect you would get the expected speed up by using
timerfd to wake the consumer up periodically. Then you would only
issue an eventfd read when the timerfd tells you time is up. You would
(e)poll only on that as well, never on the eventfd.

Even so, as is I think this wants a page shared between producer(s)
and the consumer updating everything with atomics and the consumer
collecting it periodically (atomic add on one side, atomic swap with 0
on the consumer, I don't know the c11 intrinsics). It would be
drastically cheaper all around.

Bottom line though, my non-maintainer feedback so far is that the
functionality you are proposing does not seem warranted for the
problem you are facing.

--=20
Mateusz Guzik <mjguzik gmail.com>

