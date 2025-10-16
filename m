Return-Path: <linux-fsdevel+bounces-64394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CB5BE5572
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 22:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B85F64F8FFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 20:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA872DECB2;
	Thu, 16 Oct 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve1f5a3X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DC2DCF51
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645609; cv=none; b=VfgRcymPWuA7r0gTB69fsuNlQk5J+chb4MKGBMj+/kfQhYVO/tsh5QefWEsePfI2AbD0ULOM9x5bwFNqHHkRKrBth1rqJu1iiNuNjDugvg8ALMPP4k0ZRN9/O+yMUT8ykwguDUryOoT+V7d3YBrGHEDujk1tx/CxHOP6RdAcvAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645609; c=relaxed/simple;
	bh=AMePQKedklNG+frYE0fNjDWR6wq016bqkOx+pjn4iGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+o41FPbYdytDGEtcmJDo/USlhB7GxtPGN06X8/AVEbmWOUjegduWC24sewdha+Qmg4qjzi1M5pQPxlojF9HuG/yRjmMdMtEPbHr5HAacw+MKW1DLxY5pOjbTmFv2Yp3BsXQvqcDhldMzL97IhLqO3xZn4ik5Ayqghk+gWvym8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ve1f5a3X; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-87808473c3bso241512885a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760645606; x=1761250406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr5v/Wvt5KZjZp/Gp7A4CekLz50aQivP/rnzTiyeINU=;
        b=Ve1f5a3XLRo0oaz3mvXs7d4pxMWJ0ylctYfN+dj2tccRhpxx4vJnhv0VOAq79NO0lb
         GGDFYvpXwfK+HgHcsHMV1Uixsx/ntRSWpDk/B+IPUWS5D4Nh/L4fZyj/kUaqvkNoujcw
         YE2FD31hsgHUuVRq6QH6/gNquTiwX4G3hft7EqhSzMOBLOYbq1AwuCY/z+pE2Et+rpvG
         0cS6r0ZG9/onq15j7UtOvHSTAQ5+T3UjRMEg5MBZ+vYK/FOZ48bZ6uNbesLgnY03v0LZ
         rimilNAVD91PuRk609QVmD4FLv2TqBbax7NV9cBGNNnZQMHtq9DeKmPfYb+snlQf9EIY
         3JEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645606; x=1761250406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr5v/Wvt5KZjZp/Gp7A4CekLz50aQivP/rnzTiyeINU=;
        b=oFjral3LZBFOzE5+w6X4WvWXj0l8vEDpf3uczciaRL9vdCNSt57fcfjX0AmhaEyNnb
         10oayVp5+rzvmt8PCC/Zp1JHJEfjQb+9nEaHincTbqdINw7lyrnef9NEibW+5Y1z68Ig
         4gqt+au2W9ePxL74UxfJ3DgWnPZNWAy1yYLPrY084jpl0I80aXgB+55JjtPBduwWoV5T
         WZTH0XEXhIVHWBsWmbJRBKF4JPBl/t/p0qe4buBdd+lSXDRoxushElIBeAkHhGII+aXJ
         FCxzJhKf15GyjUJNXBNM5JfFR5YDQ89HKrM52V49kY563PIyBhPSk6P7StY3NfccYP6Y
         srpw==
X-Forwarded-Encrypted: i=1; AJvYcCX6SO5je1YJxhnziXfLb/8DUzarlYpBky6cHcHhl5W6z/x3wnzgnXRasqMmVW2PfVYpLq0JjtSxj0UxZ7Qc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfh3RTEYhgIaH7OHgFIR5Rsak334b8OQCSClQof6Ex73YS/y9A
	LDm0JlmrmMDstbYZES4ZLx+RGaZfq86iuUGIbkMgThYEitaPa8/fxge9UyIZbsu4P5U5gYEg2Z7
	yGTTI5aXRZ/ShxHoQG4Zq6cA7/YAu5rs=
X-Gm-Gg: ASbGnctOOl03XqHsTUaS4Z1ifzWnbOfJQ5MS5p74L6QHbuaeGa5bTxxPjMkvmguG224
	VzJEjOOKCSE/kzA9m3toB2lGtbfjKwV6rYvAD6cRNDD1YUKpo/UFbcFcJ8LsLmhazSLOP/x+yNV
	Hmq/bKdU1NYaff114knvlQGlkRHH1pfhAK/FBWKQ3J+3q1pvrg88SaodtjDWq6vNgJIAETGNh1p
	Lsngr8bU6QLkB+Y1e3AqCVybMFWcO4/lfj6q0osy66zcccqL6ZuZcIkkiBdZglyjMvptHfKDCn8
	SbkSaR4c4lUvT34EPvhENu7vTfmxRi6sbzZwlw==
X-Google-Smtp-Source: AGHT+IHhSYaSrFZLwBqDSHhMcDZS1nLGMdO86vV71tRIZaUmzXMjFMvAuflmknH0sEiWF7RnyE9L9CRik0n6q3uKZpc=
X-Received: by 2002:a05:622a:106:b0:4e7:2b6a:643a with SMTP id
 d75a77b69052e-4e89d1d945bmr23395481cf.12.1760645605776; Thu, 16 Oct 2025
 13:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
 <CAJnrk1brjsPoXc_dbMj-Ty4dr5ZCxtVjBn6WGOY8DkGxh87R5Q@mail.gmail.com>
 <6d16a94b-3277-4922-a628-f17f622369bc@bsbernd.com> <CAJnrk1b9xVqmDY9kgDjPpjs7zuXNbiNaQnMyvY0iJirJbHi1yw@mail.gmail.com>
 <20251016085813.GB3245006@noisy.programming.kicks-ass.net> <20251016090019.GH4068168@noisy.programming.kicks-ass.net>
In-Reply-To: <20251016090019.GH4068168@noisy.programming.kicks-ass.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Oct 2025 13:13:13 -0700
X-Gm-Features: AS18NWARr7vPYi_W10o-VeQoBPiyxlqAxcC3uLN_OazkOQKaBnOT7O75bAHrSoM
Message-ID: <CAJnrk1aoPZj6KWKhBhPSASs-kgWDxipfY3MjPDBtG4v-zay3rg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Wake requests on the same cpu
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 2:00=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Oct 16, 2025 at 10:58:14AM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 15, 2025 at 03:19:31PM -0700, Joanne Koong wrote:
> >
> > > > > Won't this lose cache locality for all the other data that is in =
the
> > > > > client thread's cache on the previous CPU? It seems to me like on
> > > > > average this would be a costlier miss overall? What are your thou=
ghts
> > > > > on this?
> > > >
> > > > So as in the introduction, which b4 made a '---' comment below,
> > > > initially I thought this should be a conditional on queue-per-core.
> > > > With queue-per-core it should be easy to explain, I think.
> > > >
> > > > App submits request on core-X, waits/sleeps, request gets handle on
> > > > core-X by queue-X.
> > > > If there are more applications running on this core, they
> > > > get likely re-scheduled to another core, as the libfuse queue threa=
d is
> > > > core bound. If other applications don't get re-scheduled either the
> > > > entire system is overloaded or someone sets manual application core
> > > > affinity - we can't do much about that in either case. With
> > > > queue-per-core there is also no debate about "previous CPU".
> > > > Worse is actually scheduler behavior here, although the ring thread
> > > > itself goes to sleep soon enough. Application gets still quite ofte=
n
> > > > re-scheduled to another core. Without wake-on-same core behavior is
> > > > even worse and it jumps across all the time. Not good for CPU cache=
...
> > >
> > > Maybe this is a lack of my understanding of scheduler internals,  but
> > > I'm having a hard time seeing what the benefit of
> > > wake_up_on_current_cpu() is over wake_up() for the queue-per-core
> > > case.
> > >
> > > As I understand it, with wake_up() the scheduler already will try to
> > > wake up the thread and put it back on the same core to maintain cache
> > > locality, which in this case is the same core
> > > "wake_up_on_current_cpu()" is trying to put it on. If there's too muc=
h
> > > load imbalance then regardless of whether you call wake_up() or
> > > wake_up_on_current_cpu(), the scheduler will migrate the task to
> > > whatever other core is better for it.
> > >
> > > So I guess the main benefit of calling wake_up_on_current_cpu() over
> > > wake_up() is that for situations where there is only some but not too
> > > much load imbalance we force the application to run on the current
> > > core even despite the scheduler thinking it's better for overall
> > > system health to distribute the load? I don't see an issue if the
> > > application thread runs very briefly but it seems more likely that th=
e
> > > application thread could be work intensive in which case it seems lik=
e
> > > the thread would get migrated anyways or lead to more latency in the
> > > long term with trying to compete on an overloaded core?
> >
> > So the scheduler will try and wake on the previous CPU, but if that CPU
> > is not idle it will look for any non-idle CPU in the same L3 and very
>
> Typing hard: s/non-//
>
> > aggressively move tasks around.
> >
> > Notably if Task-A is waking Task-B, and Task-A is running on CPU-1 and
> > Task-B was previously running on CPU-1, then the wakeup will see CPU-1
> > is not idle (it is running Task-A) and it will try and find another CPU
> > in the same L3.
> >
> > This is fine if Task-A continues running; however in the case where
> > Task-A is going to sleep right after doing the wakeup, this is perhaps
> > sub-optimal, CPU-1 will end up idle.
> >
> > We have the WF_SYNC (wake-flag) that tries to indicate this latter case=
;
> > trouble is, it often gets used where it should not be, it is unreliable=
.
> > Therefore it not a strong hint.
> >
> > Then we 'recently' grew WF_CURRENT_CPU, that forces the wakeup to the
> > same CPU. If you abuse, you keep pieces :-)
> >
> > So it all depends a bit on the workload, machine and situation.
> >
> > Some machines L3 is fine, some machines L3 has exclusive L2 and it hurt=
s
> > more to move tasks. Some workloads don't fit L2 so it doesn't matter
> > anyway. TL;DR is we need this damn crystal ball instruction :-)

Thanks for the explanation! I found it very helpful.

In light of that information, it seems to me that the original
wake_up() would be more optimal here than wake_up_on_current_cpu()
then. After fuse_request_end(), the thread still has work to do with
fetching and servicing the next requests. If it wakes up the
application on its cpu, then with queue-per-core the thread would be
forced to sleep since on the libfuse side during setup the thread is
pinned to the core, which would prevent any migration while the
application task runs. Or am I misassuming something in this analysis,
Bernd?

Thanks,
Joanne

