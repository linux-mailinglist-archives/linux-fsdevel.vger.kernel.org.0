Return-Path: <linux-fsdevel+bounces-62873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F10BA393B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4456273FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA2D2EAD18;
	Fri, 26 Sep 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwy2mFLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CF2EA754
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888376; cv=none; b=IDNZWg0LB6L10AiYD/V0Bz1GKCV/c7eG/Kd+IPKwXEKv+pzw9fDxA6VGktgW0F2TUAWCrnekJ/wY4drq9bbQHOsgqycH0clWoXXNB0bxDb1SC6vTJahfRuBbyQ1SzEAtuhKB52kOkVDXXfj5Il8/L0M+P0zZ/qJchs90SJ7By+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888376; c=relaxed/simple;
	bh=vpdeuaSyWg+SH5NGQQa5lflsAyzfgi1VGkoFi+9Nmrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkTh/lAqeWI5OP30RWTEU+itmZaUuCyXZd0ad7iHIVWtrmLyAJglgBvXA45q3logMGch/Y7oCrXSsE/KtR714bI1qhibOJjURiugGFJPFXrh82UITp/PqcNTeRvJW45WNvqixJqNe5ZDBoBYWay6MvCgKU50OK/MW9pvwzSyVSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwy2mFLo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b0418f6fc27so321755766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 05:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758888373; x=1759493173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCAW40hJUq07IC5oVFTQa39ibFy9Hlxjs7i6NVvpONc=;
        b=Fwy2mFLotoIx/zXlUF8gN3Jbtshh4UaxTupGvkPywf7+Rpcj4OiU0wieVP0MootuK6
         FAsx0FDt3k2B66by84u3ejvsr3au5sQZlGmtkEo46l2n83HeLyZQRwdIGC+8Euxlcdz0
         e2lUx5KZ/MEOEXWtXDXop9ovGw6cXzCYJF2YCakWrDXauWc6AOiJn7SnDoQQtYMm5XPT
         BpyBbFdiR1Hj0Bey4hatEnB755FGcJc7g6CbEuqLBu4CwsJBvfJz7/aNjrlSOmqd7EBM
         8Wopel5aE+Qa2LAeN5OtL0U74DlioJKpO6R+SGoUM75Poix8+JG9Ro5i+dihwqHeXdCT
         4FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758888373; x=1759493173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCAW40hJUq07IC5oVFTQa39ibFy9Hlxjs7i6NVvpONc=;
        b=VMVn9zQ+OU5gCv7ODpJlsxRo5jwA3EsyUZ0GGVFELWi4crl4RzbCuUE6Ue9jSg7p9L
         9RT2ubkEQpr+2JAImKJGZc2G1zWqtsB+I9RVgMQ1NE95rtXUQGo1IvHRRo7nnb2HBxaj
         imvB0ADDoC3WGn/wozbHdmPxvlL9gkDKhAwvFUyfgMrgxbs8LhNgzYmQSgzWHTC5mN8u
         P9paKtxhV66ObEnysl80OrQhMjX298tdbR+RMQ+NQ9pVMrKytNxsCIQhZSKXDDJNGLKn
         lvexMKfxFiYaD7qu6cOtjCwKHtl6nHXh7ltibDqy2hVuYVZupxJ7UbmrKlL3IC+cF9si
         3vPQ==
X-Gm-Message-State: AOJu0YzAbsJRvqwwq6FqEBinmpPR1mbb1SuzVB/KossbKcYBe0ks+Z1c
	SPzvKdXzKcnIhEjHRF6+eNk/0K9vW6oRb6/vEw41eYxBnb9/JDyND9rd6/nO7GuKwhfEHlXKPVZ
	NQ3joPaeFvLLHHZY7pTHjg93mcLYMzOM=
X-Gm-Gg: ASbGncsh9O0R5AWErkXB6qiGnb4T0xrciANMYmFQn9kSiXyNUeXHMYXiCxHsY8PBry/
	liTyFcwUZPeK72HKb1l61OjLrCdjhTWdZ277RQYvfU8g3GSqpNqtmhbKqrmtzBVxh5DoFsFzIaI
	AKveL0DzlPPMcxvsk1cMY3lYNudLkHRhM2/SoVfjptU6vKJ9KzG/+Oaif7D2dOXFkha2GCH5Sz3
	AIc23zRQLtZbMZkxg1jnWY3erJwYs/mjPOXxAoQkg==
X-Google-Smtp-Source: AGHT+IGoa4EwyKQ9q0o3rAtjqkt9eWQJHHojFIPXisFCOG2rhYOAOUut6WyMBJLoYAN+H7bWwHrPQjA3WRtMI6J45zA=
X-Received: by 2002:a17:907:720b:b0:b2c:fa32:51d4 with SMTP id
 a640c23a62f3a-b34b7209db4mr750232366b.3.1758888372637; Fri, 26 Sep 2025
 05:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925132239.2145036-1-sunjunchao@bytedance.com>
 <fylfqtj5wob72574qjkm7zizc7y4ieb2tanzqdexy4wcgtgov4@h25bh2fsklfn>
 <5622443b-b5b4-4b19-8a7b-f3923f822dda@bytedance.com> <CAGudoHGigCyz60ec6Mv3NL2-x7tfLWYdK1M=Rj2OHRAgqHKOdg@mail.gmail.com>
 <14ee6648-1878-4b46-9e46-d275cc50bf0a@bytedance.com>
In-Reply-To: <14ee6648-1878-4b46-9e46-d275cc50bf0a@bytedance.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 26 Sep 2025 14:05:59 +0200
X-Gm-Features: AS18NWCNdQKmqMMm-i1SWLkPc2q7l4qDSo-fzDzuJFiZe5c4Mwy6_kDKrkF3dTE
Message-ID: <CAGudoHEkJfenk7ePETr3PCCqb9AYo7F4Ha754EjV4rT+U6_qoQ@mail.gmail.com>
Subject: Re: [PATCH] write-back: Wake up waiting tasks when finishing the
 writeback of a chunk.
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, peterz@infradead.org, akpm@linux-foundation.org, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 1:43=E2=80=AFPM Julian Sun <sunjunchao@bytedance.co=
m> wrote:
>
> On 9/26/25 7:17 PM, Mateusz Guzik wrote:
> > On Fri, Sep 26, 2025 at 4:26=E2=80=AFAM Julian Sun <sunjunchao@bytedanc=
e.com> wrote:
> >>
> >> On 9/26/25 1:25 AM, Mateusz Guzik wrote:
> >>> On Thu, Sep 25, 2025 at 09:22:39PM +0800, Julian Sun wrote:
> >>>> Writing back a large number of pages can take a lots of time.
> >>>> This issue is exacerbated when the underlying device is slow or
> >>>> subject to block layer rate limiting, which in turn triggers
> >>>> unexpected hung task warnings.
> >>>>
> >>>> We can trigger a wake-up once a chunk has been written back and the
> >>>> waiting time for writeback exceeds half of
> >>>> sysctl_hung_task_timeout_secs.
> >>>> This action allows the hung task detector to be aware of the writeba=
ck
> >>>> progress, thereby eliminating these unexpected hung task warnings.
> >>>>
> >>>
> >>> If I'm reading correctly this is also messing with stats how long the
> >>> thread was stuck to begin with.
> >>
> >> IMO, it will not mess up the time. Since it only updates the time when
> >> we can see progress (which is not a hang). If the task really hangs fo=
r
> >> a long time, then we can't perform the time update=E2=80=94so it will =
not mess
> >> up the time.
> >>
> >
> > My point is that if you are stuck in the kernel for so long for the
> > hung task detector to take notice, that's still something worth
> > reporting in some way, even if you are making progress. I presume with
> > the patch at hand this information is lost.
> >
> > For example the detector could be extended to drop a one-liner about
> > encountering a thread which was unable to leave the kernel for a long
> > time, even though it is making progress. Bonus points if the message
> > contained info this is i/o and for which device.
>
> Let me understand: you want to print logs when writeback is making
> progress but is so slow that the task can't exit, correct?
> I see this as a new requirement different from the existing hung task
> detector: needing to print info when writeback is slow.
> Indeed, the existing detector prints warnings in two cases: 1) no
> writeback progress; 2) progress is made but writeback is so slow it will
> take too long.

I am saying it would be a nice improvement to extend the htd like that.

And that your patch as proposed would avoidably make it harder -- you
can still get what you are aiming for without the wakeups.

Also note that when looking at a kernel crashdump it may be beneficial
to know when a particular thread got first stuck in the kernel, which
is again gone with your patch.

> This patch eliminates warnings for case 2, but only to make hung task
> warnings more accurate.
> Case 2 is essentially a performance issue. Increasing
> sysctl_hung_task_timeout_secs may make case 2 warnings disappear, but
> not case 1.
> So we should consider: do we need to print info when slow writeback
> keeps a task from exiting beyond a certain time?

I would wager that helps figure out why there is no apparent progress.

> This deserves a new patch: record a timestamp at writeback start,
> compare it with the initial timestamp after each chunk is written back,
> and decide whether to print. This should meet your needs.
> If fs maintainers find this reasonable, I'm willing to contribute the
> code.

That sounds great, let's see what the fs folk think.

> >> cc Lance and Andrew.
> >>>
> >>> Perhaps it would be better to have a var in task_struct which would
> >>> serve as an indicator of progress being made (e.g., last time stamp o=
f
> >>> said progress).
> >>>
> >>> task_struct already has numerous holes so this would not have to grow=
 it
> >>> above what it is now.
> >>>
> >>>
> >>>> This patch has passed the xfstests 'check -g quick' test based on ex=
t4,
> >>>> with no additional failures introduced.
> >>>>
> >>>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> >>>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >>>> ---
> >>>>    fs/fs-writeback.c                | 13 +++++++++++--
> >>>>    include/linux/backing-dev-defs.h |  1 +
> >>>>    2 files changed, 12 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> >>>> index a07b8cf73ae2..475d52abfb3e 100644
> >>>> --- a/fs/fs-writeback.c
> >>>> +++ b/fs/fs-writeback.c
> >>>> @@ -14,6 +14,7 @@
> >>>>     *         Additions for address_space-based writeback
> >>>>     */
> >>>>
> >>>> +#include <linux/sched/sysctl.h>
> >>>>    #include <linux/kernel.h>
> >>>>    #include <linux/export.h>
> >>>>    #include <linux/spinlock.h>
> >>>> @@ -174,9 +175,12 @@ static void finish_writeback_work(struct wb_wri=
teback_work *work)
> >>>>               kfree(work);
> >>>>       if (done) {
> >>>>               wait_queue_head_t *waitq =3D done->waitq;
> >>>> +            /* Report progress to inform the hung task detector of =
the progress. */
> >>>> +            bool force_wake =3D (jiffies - done->stamp) >
> >>>> +                               sysctl_hung_task_timeout_secs * HZ /=
 2;
> >>>>
> >>>>               /* @done can't be accessed after the following dec */
> >>>> -            if (atomic_dec_and_test(&done->cnt))
> >>>> +            if (atomic_dec_and_test(&done->cnt) || force_wake)
> >>>>                       wake_up_all(waitq);
> >>>>       }
> >>>>    }
> >>>> @@ -213,7 +217,7 @@ static void wb_queue_work(struct bdi_writeback *=
wb,
> >>>>    void wb_wait_for_completion(struct wb_completion *done)
> >>>>    {
> >>>>       atomic_dec(&done->cnt);         /* put down the initial count =
*/
> >>>> -    wait_event(*done->waitq, !atomic_read(&done->cnt));
> >>>> +    wait_event(*done->waitq, ({ done->stamp =3D jiffies; !atomic_re=
ad(&done->cnt); }));
> >>>>    }
> >>>>
> >>>>    #ifdef CONFIG_CGROUP_WRITEBACK
> >>>> @@ -1975,6 +1979,11 @@ static long writeback_sb_inodes(struct super_=
block *sb,
> >>>>                */
> >>>>               __writeback_single_inode(inode, &wbc);
> >>>>
> >>>> +            /* Report progress to inform the hung task detector of =
the progress. */
> >>>> +            if (work->done && (jiffies - work->done->stamp) >
> >>>> +                HZ * sysctl_hung_task_timeout_secs / 2)
> >>>> +                    wake_up_all(work->done->waitq);
> >>>> +
> >>>>               wbc_detach_inode(&wbc);
> >>>>               work->nr_pages -=3D write_chunk - wbc.nr_to_write;
> >>>>               wrote =3D write_chunk - wbc.nr_to_write - wbc.pages_sk=
ipped;
> >>>> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backin=
g-dev-defs.h
> >>>> index 2ad261082bba..c37c6bd5ef5c 100644
> >>>> --- a/include/linux/backing-dev-defs.h
> >>>> +++ b/include/linux/backing-dev-defs.h
> >>>> @@ -63,6 +63,7 @@ enum wb_reason {
> >>>>    struct wb_completion {
> >>>>       atomic_t                cnt;
> >>>>       wait_queue_head_t       *waitq;
> >>>> +    unsigned long stamp;
> >>>>    };
> >>>>
> >>>>    #define __WB_COMPLETION_INIT(_waitq)       \
> >>>> --
> >>>> 2.39.5
> >>>>
> >>
> >> Thanks,
> >> --
> >> Julian Sun <sunjunchao@bytedance.com>
>
> Thanks,
> --
> Julian Sun <sunjunchao@bytedance.com>

