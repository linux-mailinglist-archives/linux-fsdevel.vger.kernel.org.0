Return-Path: <linux-fsdevel+bounces-2434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE37E5EB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 20:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA991C20BF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 19:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23AA37154;
	Wed,  8 Nov 2023 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpQUIGqY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC8FEEA0
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:35:57 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C42110;
	Wed,  8 Nov 2023 11:35:56 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b58d96a3bbso33549b6e.1;
        Wed, 08 Nov 2023 11:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699472156; x=1700076956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=paNOpk393l1aqFflxT4hXJVPVnwtDZPbYHqWDS7Ayz0=;
        b=ZpQUIGqYYqV3TlmAxiUD1r7bzSNPQCynmeyk9huKbV734N2JvbXO5RQ09c4MH0Oxuq
         WCGy65SLkBb1zeYpNTkur9mLJH8qRrced2AG7QwaBAcLTfVuAf90DweS/uShSbKo2wuW
         suDW++ttPxVSibJJejmMQLY6zUxmAE/A1deRPfSet1YfkmPPmJvjwG/3z2O7f8D4Ndx8
         akFCWRqvblmaIV/xjLh+t3v0HNcPGrxKAMXgTXGOB6W53uMgy60vip00dC0EY3boCWYK
         Ua1T6kGzZ4ACzPgx5sf83jhfresGnNZv+7ZUQFOKzlPSuHj0a82XIqieTcaHkxX6BLOh
         1NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699472156; x=1700076956;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paNOpk393l1aqFflxT4hXJVPVnwtDZPbYHqWDS7Ayz0=;
        b=bLJe5ZLSKXPRPc7svtdY5hR3x0rPN+8rKylpyvGErWliwyIaUV6MYRdzYQCawHs3qO
         xvhRFgjH7DaLYaKE5azpB9Tf5GuYl7Gv6ZfdW0zYD7RBVJb508mc6vCQItsJdLY0UTrD
         f9wLX2nsi+T+dM5QSxYLEvtAi9zox4ZBS/sdcZygvlRCzRIyvlLK7fOpCVq9fSUJeP0v
         8w6Q8n91NCdFDAOvX5yXLjwgDHQTa/BYUr5cnbnkdOW7MbQ/THw8p9mbtqa6UJXiP/Wv
         NQnLrECf/S4xzl6LmAPusDrvNoiM9/Phkrf3273/A81iwGtfQm3c/Gwi+ovi4KrKAYvQ
         xa7w==
X-Gm-Message-State: AOJu0Yw455Bh8YW+OZU9082h+19M0qvnFH3ePsreKvsUWDu0eT9eomfS
	zpUSWdOMlUKdM2RF9qxTwNYOVZ439KUyu1KxBAs=
X-Google-Smtp-Source: AGHT+IH6gyK4ACWGImYctZv4/as81sCqw8qfMghC+jEYWgfUdrQXQm8Qvqu7Sa41ug1rQgloLFib/7CUGSZCXCZjHdE=
X-Received: by 2002:a05:6808:34b:b0:3b5:2ede:d9c1 with SMTP id
 j11-20020a056808034b00b003b52eded9c1mr2950312oie.47.1699472156262; Wed, 08
 Nov 2023 11:35:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:158f:0:b0:4f0:1250:dd51 with HTTP; Wed, 8 Nov 2023
 11:35:55 -0800 (PST)
In-Reply-To: <202311081129.9E1EC8D34@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202311071228.27D22C00@keescook> <20231107205151.qkwlw7aarjvkyrqs@f>
 <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
 <202311071445.53E5D72C@keescook> <CAGudoHF5mYFWtzrv539W8Uc1aO_u6+UJOoDqWY0pePc+cofziw@mail.gmail.com>
 <A7FFA44F-F7DD-477F-83A6-44AF71D6775E@kernel.org> <CAGudoHESNDTAAOGB3riYjU3tgHTXVLRdB7tknfVBem38yqkJEA@mail.gmail.com>
 <202311081129.9E1EC8D34@keescook>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 8 Nov 2023 20:35:55 +0100
Message-ID: <CAGudoHEqv=JmMyV8vYSvhubxXaW-cK3n5WRR=nR7eDZjBOQTcw@mail.gmail.com>
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search before
 allocating mm
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 11/8/23, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Nov 08, 2023 at 01:03:33AM +0100, Mateusz Guzik wrote:
>> On 11/8/23, Kees Cook <kees@kernel.org> wrote:
>> >
>> >
>> > On November 7, 2023 3:08:47 PM PST, Mateusz Guzik <mjguzik@gmail.com>
>> > wrote:
>> >>On 11/7/23, Kees Cook <keescook@chromium.org> wrote:
>> >>> On Tue, Nov 07, 2023 at 10:23:16PM +0100, Mateusz Guzik wrote:
>> >>>> If the patch which dodges second lookup still somehow appears slower
>> >>>> a
>> >>>> flamegraph or other profile would be nice. I can volunteer to take a
>> >>>> look at what's going on provided above measurements will be done and
>> >>>> show funkyness.
>> >>>
>> >>> When I looked at this last, it seemed like all the work done in
>> >>> do_filp_open() (my patch, which moved the lookup earlier) was heavier
>> >>> than the duplicate filename_lookup().
>> >>>
>> >>> What I didn't test was moving the sched_exec() before the mm
>> >>> creation,
>> >>> which Peter confirmed shouldn't be a problem, but I think that might
>> >>> be
>> >>> only a tiny benefit, if at all.
>> >>>
>> >>> If you can do some comparisons, that would be great; it always takes
>> >>> me
>> >>> a fair bit of time to get set up for flame graph generation, etc. :)
>> >>>
>> >>
>> >>So I spawned *one* process executing one statocally linked binary in a
>> >>loop, test case from http://apollo.backplane.com/DFlyMisc/doexec.c .
>> >>
>> >>The profile is definitely not what I expected:
>> >>   5.85%  [kernel]           [k] asm_exc_page_fault
>> >>   5.84%  [kernel]           [k] __pv_queued_spin_lock_slowpath
>> >>[snip]
>> >>
>> >>I'm going to have to recompile with lock profiling, meanwhile
>> >>according to bpftrace
>> >>(bpftrace -e 'kprobe:__pv_queued_spin_lock_slowpath { @[kstack()] =
>> >> count(); }')
>> >>top hits would be:
>> >>
>> >>@[
>> >>    __pv_queued_spin_lock_slowpath+1
>> >>    _raw_spin_lock+37
>> >>    __schedule+192
>> >>    schedule_idle+38
>> >>    do_idle+366
>> >>    cpu_startup_entry+38
>> >>    start_secondary+282
>> >>    secondary_startup_64_no_verify+381
>> >>]: 181
>> >>@[
>> >>    __pv_queued_spin_lock_slowpath+1
>> >>    _raw_spin_lock_irq+43
>> >>    wait_for_completion+141
>> >>    stop_one_cpu+127
>> >>    sched_exec+165
>> >
>> > There's the suspicious sched_exec() I was talking about! :)
>> >
>> > I think it needs to be moved, and perhaps _later_ instead of earlier?
>> > Hmm...
>> >
>>
>> I'm getting around 3.4k execs/s. However, if I "taskset -c 3
>> ./static-doexec 1" the number goes up to about 9.5k and lock
>> contention disappears from the profile. So off hand looks like the
>> task is walking around the box when it perhaps could be avoided -- it
>> is idle apart from running the test. Again this is going to require a
>> serious look instead of ad hoc pokes.
>
> Peter, is this something you can speak to? It seems like execve() forces
> a change in running CPU. Is this really something we want to be doing?
> Or is there some better way to keep it on the same CPU unless there is
> contention?
>

sched_exec causes migration only for only few % of execs in the bench,
but when it does happen there is tons of overhead elsewhere.

I expect real programs which get past execve will be prone to
migrating anyway, regardless of what sched_exec is doing.

That is to say, while sched_exec buggering off here would be nice, I
think for real-world wins the thing to investigate is the overhead
which comes from migration to begin with.

-- 
Mateusz Guzik <mjguzik gmail.com>

