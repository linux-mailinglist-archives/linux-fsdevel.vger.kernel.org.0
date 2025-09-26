Return-Path: <linux-fsdevel+bounces-62871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AB9BA3753
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 13:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEB062505E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA0024635E;
	Fri, 26 Sep 2025 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKa3UyoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D15935963
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758885442; cv=none; b=vCa3ynOgA4oZtTbENnFPdjsT0UOpl63bZO07Mpk6tiIsnWBqbByGMYYtChKYT6lSITHEcRcnTlxWOzX2VBQmBJ1AG0K68RBXLxAsf5LCLSk2z8jZn53+ROl0uvGYgd3KbP6+6//O9QAdEe2uW098dsM2CsbxRbDhY9sOKK8V/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758885442; c=relaxed/simple;
	bh=/D/LcGt4F8aQYTdHpUG9hSMl11BBCHQM490BthpgDBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pys1g2gztxnmXiWj0ldphinns/HL3LaJcfWk7NXI2DMFRz1r8oQZq+qahdDgRPYDXH43NslzPQKj4Njrl5gPmAMoVBTd6jbgNGUOP56kpM90UDhNLzEV+5ubAaqK/hPd3pPyrrYL7oNX8E+vufzTHhVsUFufLd0PgqdwVAobTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKa3UyoW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso4132118a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 04:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758885439; x=1759490239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNOorhd6M74qLleN1Die/vRTuCIo1nkdqHcqtDXx7Q8=;
        b=ZKa3UyoWMRgh2lgR+MXHtI4rFA/J9H/pwuKEVB+vhLl6JZSryqb1bjZksVbZzjO+L0
         UpqUZGZN7/Lti/XNkb9IcSzE3KQehkuFdxGb404S3E2B7sXAKbkf6swrV1d88AXZAGrg
         pMibjlOe3lpaeDLe2CgZGn8aBgSbyWBLYRzjmKr7U72JY15CJmHM7aKyUX5csSfIhpy7
         SFS5+TbL8m3MuzPOH33+3Y2c/2bHKrEl69ksVVAbxGvaYs6zW+z82pPhex+iEr7AmOOE
         RaPxa5EYgPhiMvsBvyfX+9DUfovS/OAZH0V4uerztuhAWhuAw00SQztNItprfO2Ss3Wl
         UKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758885439; x=1759490239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNOorhd6M74qLleN1Die/vRTuCIo1nkdqHcqtDXx7Q8=;
        b=P0mzKtCfolIgiSIPFtPqvxRt99Sw7nxpv+DFBtoIow0MOdqcK49hamM8FMeJ4Sk5B5
         /gQxRlHKO0D2cTw3/JaWtMzdr6thMD5c3p398BuiU6fgUez0kUQT0Hy3PvDFe/vPLRdc
         5id8GIG972KDcsn7L+CEE/PEngDnRCqNFqUkzdW71YGJz99FsAH5IsMn/kRfzSNOw2FM
         vl81u5iGA3YZelIfyq2j8TO/iFLMRPOxHuISmbgvwre5ryEZwsQLt1tzqIsn4VKe9s5/
         o9tgi1TT0mmh2pbH6GmeQOdN+3/sIK7A8aHGU99Ijn4UpWVoznntZfeHwcBqo57OJfzD
         +LAg==
X-Gm-Message-State: AOJu0YyQ2QASOP3q8tegl66wyFrh4pRGgSklY0NXKv/RNBqJQONfiugT
	p09bJDtQh9XZh1aHdhwOm3iZRhm7l1i8QhGF/PdeGtnBP10rTpgAfSywgt/kTtLOCkm/FFpLSfm
	niJE9l0RMYXlHtazERDcI6Td5NFvvfMw=
X-Gm-Gg: ASbGncsowRDOgIX7i1yskB/G+aHc4ksY007C2tvKb0epKWQHoTteZj890BQWCuSmeFj
	0up+tJr4bjzFjNF8i/FcvN56MRxEGgD/sFbz6a2day2ia6U8y3FegMvnbzNf1qWn7fEfo+/o8ye
	hiFiEHt7vQWOa/2a9Y52diVdyMpKtqrLY/Ou1V5TRH+crKr/QI/6hq54gRskS0lpCr3Fjs61DZb
	vZt3LBsKi2DUNAp2mwwdzkYf0plFwFzkbS2O7ybJRIE9j3j6Mha
X-Google-Smtp-Source: AGHT+IE8r26967zraCBiRObEI4Jz8j/FetRHIfWBY2uj8Gc+AAgLr5HP+N54vrFBw4YoJ9A6MotRIjIPZlwnQSGdsVg=
X-Received: by 2002:a05:6402:234d:b0:634:54f3:2fbb with SMTP id
 4fb4d7f45d1cf-634a292cddcmr6132869a12.3.1758885438931; Fri, 26 Sep 2025
 04:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925132239.2145036-1-sunjunchao@bytedance.com>
 <fylfqtj5wob72574qjkm7zizc7y4ieb2tanzqdexy4wcgtgov4@h25bh2fsklfn> <5622443b-b5b4-4b19-8a7b-f3923f822dda@bytedance.com>
In-Reply-To: <5622443b-b5b4-4b19-8a7b-f3923f822dda@bytedance.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 26 Sep 2025 13:17:05 +0200
X-Gm-Features: AS18NWDFRZ_Z5-4R4C62-4XeD8xSioY1-AHcWYMM0cNJ3m5XFL4GkO_4tw7tvcw
Message-ID: <CAGudoHGigCyz60ec6Mv3NL2-x7tfLWYdK1M=Rj2OHRAgqHKOdg@mail.gmail.com>
Subject: Re: [PATCH] write-back: Wake up waiting tasks when finishing the
 writeback of a chunk.
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, peterz@infradead.org, akpm@linux-foundation.org, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:26=E2=80=AFAM Julian Sun <sunjunchao@bytedance.co=
m> wrote:
>
> On 9/26/25 1:25 AM, Mateusz Guzik wrote:
> > On Thu, Sep 25, 2025 at 09:22:39PM +0800, Julian Sun wrote:
> >> Writing back a large number of pages can take a lots of time.
> >> This issue is exacerbated when the underlying device is slow or
> >> subject to block layer rate limiting, which in turn triggers
> >> unexpected hung task warnings.
> >>
> >> We can trigger a wake-up once a chunk has been written back and the
> >> waiting time for writeback exceeds half of
> >> sysctl_hung_task_timeout_secs.
> >> This action allows the hung task detector to be aware of the writeback
> >> progress, thereby eliminating these unexpected hung task warnings.
> >>
> >
> > If I'm reading correctly this is also messing with stats how long the
> > thread was stuck to begin with.
>
> IMO, it will not mess up the time. Since it only updates the time when
> we can see progress (which is not a hang). If the task really hangs for
> a long time, then we can't perform the time update=E2=80=94so it will not=
 mess
> up the time.
>

My point is that if you are stuck in the kernel for so long for the
hung task detector to take notice, that's still something worth
reporting in some way, even if you are making progress. I presume with
the patch at hand this information is lost.

For example the detector could be extended to drop a one-liner about
encountering a thread which was unable to leave the kernel for a long
time, even though it is making progress. Bonus points if the message
contained info this is i/o and for which device.

> cc Lance and Andrew.
> >
> > Perhaps it would be better to have a var in task_struct which would
> > serve as an indicator of progress being made (e.g., last time stamp of
> > said progress).
> >
> > task_struct already has numerous holes so this would not have to grow i=
t
> > above what it is now.
> >
> >
> >> This patch has passed the xfstests 'check -g quick' test based on ext4=
,
> >> with no additional failures introduced.
> >>
> >> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> >> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >> ---
> >>   fs/fs-writeback.c                | 13 +++++++++++--
> >>   include/linux/backing-dev-defs.h |  1 +
> >>   2 files changed, 12 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> >> index a07b8cf73ae2..475d52abfb3e 100644
> >> --- a/fs/fs-writeback.c
> >> +++ b/fs/fs-writeback.c
> >> @@ -14,6 +14,7 @@
> >>    *         Additions for address_space-based writeback
> >>    */
> >>
> >> +#include <linux/sched/sysctl.h>
> >>   #include <linux/kernel.h>
> >>   #include <linux/export.h>
> >>   #include <linux/spinlock.h>
> >> @@ -174,9 +175,12 @@ static void finish_writeback_work(struct wb_write=
back_work *work)
> >>              kfree(work);
> >>      if (done) {
> >>              wait_queue_head_t *waitq =3D done->waitq;
> >> +            /* Report progress to inform the hung task detector of th=
e progress. */
> >> +            bool force_wake =3D (jiffies - done->stamp) >
> >> +                               sysctl_hung_task_timeout_secs * HZ / 2=
;
> >>
> >>              /* @done can't be accessed after the following dec */
> >> -            if (atomic_dec_and_test(&done->cnt))
> >> +            if (atomic_dec_and_test(&done->cnt) || force_wake)
> >>                      wake_up_all(waitq);
> >>      }
> >>   }
> >> @@ -213,7 +217,7 @@ static void wb_queue_work(struct bdi_writeback *wb=
,
> >>   void wb_wait_for_completion(struct wb_completion *done)
> >>   {
> >>      atomic_dec(&done->cnt);         /* put down the initial count */
> >> -    wait_event(*done->waitq, !atomic_read(&done->cnt));
> >> +    wait_event(*done->waitq, ({ done->stamp =3D jiffies; !atomic_read=
(&done->cnt); }));
> >>   }
> >>
> >>   #ifdef CONFIG_CGROUP_WRITEBACK
> >> @@ -1975,6 +1979,11 @@ static long writeback_sb_inodes(struct super_bl=
ock *sb,
> >>               */
> >>              __writeback_single_inode(inode, &wbc);
> >>
> >> +            /* Report progress to inform the hung task detector of th=
e progress. */
> >> +            if (work->done && (jiffies - work->done->stamp) >
> >> +                HZ * sysctl_hung_task_timeout_secs / 2)
> >> +                    wake_up_all(work->done->waitq);
> >> +
> >>              wbc_detach_inode(&wbc);
> >>              work->nr_pages -=3D write_chunk - wbc.nr_to_write;
> >>              wrote =3D write_chunk - wbc.nr_to_write - wbc.pages_skipp=
ed;
> >> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-=
dev-defs.h
> >> index 2ad261082bba..c37c6bd5ef5c 100644
> >> --- a/include/linux/backing-dev-defs.h
> >> +++ b/include/linux/backing-dev-defs.h
> >> @@ -63,6 +63,7 @@ enum wb_reason {
> >>   struct wb_completion {
> >>      atomic_t                cnt;
> >>      wait_queue_head_t       *waitq;
> >> +    unsigned long stamp;
> >>   };
> >>
> >>   #define __WB_COMPLETION_INIT(_waitq)       \
> >> --
> >> 2.39.5
> >>
>
> Thanks,
> --
> Julian Sun <sunjunchao@bytedance.com>

