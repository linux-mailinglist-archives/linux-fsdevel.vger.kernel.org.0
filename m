Return-Path: <linux-fsdevel+bounces-46622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B8A918A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 12:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7F14614A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 10:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398BA22A7FE;
	Thu, 17 Apr 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw0KbeHR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9AB22576A;
	Thu, 17 Apr 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884194; cv=none; b=iy6idV+V+k8JDxom4N7f5PjBJzUEaSn5rX/zCZF3hERM9TahAJawUQwhEFjhoNCRClJnAvZ4EjsRNUgkKZou4rjfdkrZ4wRGjTOpcTq+LCHvNP0EvrKbP8ewAWQ/SB7hJOoXkLy1JpLx0mMdTI1MJXL9HB3e/Twnr7qC0xyEHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884194; c=relaxed/simple;
	bh=I7zxJCwU7N0r059HEveddu3wetPxMfDMzyBxBoyKHtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuSGKUFKqXqHZJRmqY0XuruUzSyB8INMuYEh8Q6tZvvanH2AeRfGXBMQgi0Mq+bO3C0HqJvgSdxB5Izu9KVBA4N5AkmUUhOQHXJTTuSxfwFu5IjMqAntAt1Y25MVfjh9iPcXg9XareUU5n0OKLozp25UisCp08GSRjEp8RfBpmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw0KbeHR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso103915666b.0;
        Thu, 17 Apr 2025 03:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744884189; x=1745488989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKNGeRyEtlwvcHvAxwrzvP9PfO3QBhY6/wsmJghQQ8U=;
        b=bw0KbeHRFohlHNycEUqddEKRwqSKguM/1c2RJwwu//zNWhv9cDM8EUF0QC36XQ1eHx
         kzr2oDnZ5NsvulqjZzvxwJQj9Wz4NrnD/2bUe0prVRd6F/DRMetw9wpFyH2io89ZjJyu
         mJrGnQufJA4oyUbsCTZWkRxXaNnXy+lHSnjmdaB9uUtFook4AxZKau8JFUWOtQ8dNpvD
         qEIzqXZaCSeDk0aA3YDCIAFdLSbDYOLyr0tv9O2UTOuZ0zBsYgd02ia01h7aEUAACPtb
         1MYBmKaYkuArPe0MUUFkCJnyfN+mf6tV1Temoj1K/xN8gIc/BWMyZenErk+s36VjxP//
         bJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744884189; x=1745488989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKNGeRyEtlwvcHvAxwrzvP9PfO3QBhY6/wsmJghQQ8U=;
        b=H6SJuni/qs4f8ci8NT8Y+OQnMXjneK7hr2+/Xah0WuVwM650w7e9JDj2+5dWbaRzBh
         NNrusYoW5iSt+iyN2UrDlPlos4mOWjjgYzNLj2VvbO1beIqciURErGB9iCITc66bL2xw
         4XKD8T0hLYghcC4Rv3ZiSGe0ahUW1zQ27KUrum/4r+CrlLwfzW67DhVcCYzFHyAL7WVg
         UOZHHEBeaK/LvGTQd8BNClOWe3b9Dtq9u8I7ziguPk3Lahw7T5/bghn0rxAFJbE6bYFc
         pgfbRgJOhkeBaOWyN8VHpKsGMqDyDjm8l5ukg3+NHaDGBVucZR525x4GWRz7akbHilEQ
         dKww==
X-Forwarded-Encrypted: i=1; AJvYcCWJkkAVlc+PtnFWHlfzFH5aAGqxfIXfhXFMKIIsapDmwKjbgzxmV9NNwS1tXTIT42qdYX9bPpbxag6s0YLZ@vger.kernel.org, AJvYcCXzJhBKA1LOPS57EeAmaUSnf56mDGzniKbN4C1PkEeBCHJCfjw8vuSjsUM05UTBtpxsMdaeTBhPaSGfeSYO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CM6r3gW6W/w8yfFqRNoq/QmTuIam5Kg07y63zaNOzLxbMEXC
	kZ5RdZbUfUvtjmM67vq1yb732itwiZljOnKnH9ABZTWrHxq7SuNBL/UeTllVEdWTgu864SMos+p
	nOoQ1KcJz/VhGLUnlSqRFaaCWcAs=
X-Gm-Gg: ASbGncuR032T22mCEICcGS8gKSkn/b4pjv3T4v5p+BEwDQsk/8LzrVevT7SR1Bucgal
	YRak3BXM5NNPznBPrHrMkN3ab5Fh8G9ku9TnaAtcTDzeWxYeQ9L1nrFQ4iAnSdZ23/CJiV+/xen
	cASubXCDUZ/WsWNFc6m1AdOQ==
X-Google-Smtp-Source: AGHT+IHpCOeA/9GuZ/djHA4ZCzAWst3qLkT5glZ/ReiPJA9veAF27CAJ1HiQnKeil8rhJ0/VeXhEZ3k+PFcDhr0vGsQ=
X-Received: by 2002:a17:907:c807:b0:ac1:dd6f:f26c with SMTP id
 a640c23a62f3a-acb42c4d3a3mr498332366b.46.1744884189110; Thu, 17 Apr 2025
 03:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202504171513.6d6f8a16-lkp@intel.com> <CAGudoHGcQspttcaZ6nYfwBkXiJEC-XKuprxnmXRjjufz2vPRhw@mail.gmail.com>
In-Reply-To: <CAGudoHGcQspttcaZ6nYfwBkXiJEC-XKuprxnmXRjjufz2vPRhw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 17 Apr 2025 12:02:55 +0200
X-Gm-Features: ATxdqUEyaI-CE7Yu-n9341eTKL4FOFtUnYFfzkjEaaoc6mhMT1ygmXlz4pSdayE
Message-ID: <CAGudoHHMvREPjWNvmAa_qQovK-9S1zvCAGh=K6U21oyr4pTtzg@mail.gmail.com>
Subject: Re: [linus:master] [fs] a914bd93f3: stress-ng.close.close_calls_per_sec
 52.2% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 11:54=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Thu, Apr 17, 2025 at 10:24=E2=80=AFAM kernel test robot
> <oliver.sang@intel.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed a 52.2% regression of stress-ng.close.close_c=
alls_per_sec on:
> >
> >
> > commit: a914bd93f3edfedcdd59deb615e8dd1b3643cac5 ("fs: use fput_close()=
 in filp_close()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > [still regression on linus/master      7cdabafc001202de9984f22c973305f4=
24e0a8b7]
> > [still regression on linux-next/master 01c6df60d5d4ae00cd5c164881874483=
8bba7763]
> >
> > testcase: stress-ng
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 192 threads 2 sockets Intel(R) Xeon(R) Platinum 8468V  CP=
U @ 2.4GHz (Sapphire Rapids) with 384G memory
> > parameters:
> >
> >         nr_threads: 100%
> >         testtime: 60s
> >         test: close
> >         cpufreq_governor: performance
> >
> >
> > the data is not very stable, but the regression trend seems clear.
> >
> > a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json:  "stress-ng.close=
.close_calls_per_sec": [
> > a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    193538.65,
> > a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    232133.85,
> > a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    276146.66,
> > a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    193345.38,
> > a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    209411.34,
> > a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-    254782.41
> > a914bd93f3edfedcdd59deb615e8dd1b3643cac5/matrix.json-  ],
> >
> > 3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json:  "stress-ng.close=
.close_calls_per_sec": [
> > 3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    427893.13,
> > 3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    456267.6,
> > 3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    509121.02,
> > 3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    544289.08,
> > 3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    354004.06,
> > 3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-    552310.73
> > 3e46a92a27c2927fcef996ba06cbe299da629c28/matrix.json-  ],
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202504171513.6d6f8a16-lkp@inte=
l.com
> >
> >
> > Details are as below:
> > -----------------------------------------------------------------------=
--------------------------->
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250417/202504171513.6d6f8a16-=
lkp@intel.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/tes=
tcase/testtime:
> >   gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz=
/igk-spr-2sp1/close/stress-ng/60s
> >
> > commit:
> >   3e46a92a27 ("fs: use fput_close_sync() in close()")
> >   a914bd93f3 ("fs: use fput_close() in filp_close()")
> >
>
> I'm going to have to chew on it.
>
> First, the commit at hand states:
>     fs: use fput_close() in filp_close()
>
>     When tracing a kernel build over refcounts seen this is a wash:
>     @[kprobe:filp_close]:
>     [0]                32195 |@@@@@@@@@@
>            |
>     [1]               164567
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>
>     I verified vast majority of the skew comes from do_close_on_exec() wh=
ich
>     could be changed to use a different variant instead.
>
> So if need be this is trivially revertable without a major loss anywhere.
>
> But also:
>     Even without changing that, the 19.5% of calls which got here still c=
an
>     save the extra atomic. Calls here are borderline non-existent compare=
d
>     to fput (over 3.2 mln!), so they should not negatively affect
>     scalability.
>
> As the code converts a lock xadd into a lock cmpxchg loop in exchange
> for saving an atomic if this is the last close. This indeed scales
> worse if this in fact does not close the file.
>
> stress-ng dups fd 2 several times and then closes it in close_range()
> in a loop. this manufactures a case where this is never the last close
> and the cmpxchg loop is a plain loss.
>

huh, bad editing

bottom line though is there is a known tradeoff there and stress-ng
manufactures a case where it is always the wrong one.

fd 2 at hand is inherited (it's the tty) and shared between *all*
workers on all CPUs.

Ignoring some fluff, it's this in a loop:
dup2(2, 1024)                           =3D 1024
dup2(2, 1025)                           =3D 1025
dup2(2, 1026)                           =3D 1026
dup2(2, 1027)                           =3D 1027
dup2(2, 1028)                           =3D 1028
dup2(2, 1029)                           =3D 1029
dup2(2, 1030)                           =3D 1030
dup2(2, 1031)                           =3D 1031
[..]
close_range(1024, 1032, 0)              =3D 0

where fd 2 is the same file object in all 192 workers doing this.

> While I don't believe this represents real-world behavior, maybe
> something can be done. I note again this patch can be whacked
> altogether without any tears shed.
>
> So I'm going to chew on it.
>
> > 3e46a92a27c2927f a914bd93f3edfedcdd59deb615e
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >     355470 =C4=85 14%     -17.6%     292767 =C4=85  7%  cpuidle..usage
> >       5.19            -0.6        4.61 =C4=85  3%  mpstat.cpu.all.usr%
> >     495615 =C4=85  7%     -38.5%     304839 =C4=85  8%  vmstat.system.c=
s
> >     780096 =C4=85  5%     -23.5%     596446 =C4=85  3%  vmstat.system.i=
n
> >    2512168 =C4=85 17%     -45.8%    1361659 =C4=85 71%  sched_debug.cfs=
_rq:/.avg_vruntime.min
> >    2512168 =C4=85 17%     -45.8%    1361659 =C4=85 71%  sched_debug.cfs=
_rq:/.min_vruntime.min
> >     700402 =C4=85  2%     +19.8%     838744 =C4=85 10%  sched_debug.cpu=
.avg_idle.avg
> >      81230 =C4=85  6%     -59.6%      32788 =C4=85 69%  sched_debug.cpu=
.nr_switches.avg
> >      27992 =C4=85 20%     -70.2%       8345 =C4=85 74%  sched_debug.cpu=
.nr_switches.min
> >     473980 =C4=85 14%     -52.2%     226559 =C4=85 13%  stress-ng.close=
.close_calls_per_sec
> >    4004843 =C4=85  8%     -21.1%    3161813 =C4=85  8%  stress-ng.time.=
involuntary_context_switches
> >       9475            +1.1%       9582        stress-ng.time.system_tim=
e
> >     183.50 =C4=85  2%     -37.8%     114.20 =C4=85  3%  stress-ng.time.=
user_time
> >   25637892 =C4=85  6%     -42.6%   14725385 =C4=85  9%  stress-ng.time.=
voluntary_context_switches
> >      23.01 =C4=85  2%      -1.4       21.61 =C4=85  3%  perf-stat.i.cac=
he-miss-rate%
> >   17981659           -10.8%   16035508 =C4=85  4%  perf-stat.i.cache-mi=
sses
> >   77288888 =C4=85  2%      -6.5%   72260357 =C4=85  4%  perf-stat.i.cac=
he-references
> >     504949 =C4=85  6%     -38.1%     312536 =C4=85  8%  perf-stat.i.con=
text-switches
> >      33030           +15.7%      38205 =C4=85  4%  perf-stat.i.cycles-b=
etween-cache-misses
> >       4.34 =C4=85 10%     -38.3%       2.68 =C4=85 20%  perf-stat.i.met=
ric.K/sec
> >      26229 =C4=85 44%     +37.8%      36145 =C4=85  4%  perf-stat.overa=
ll.cycles-between-cache-misses
> >      30.09           -12.8       17.32        perf-profile.calltrace.cy=
cles-pp.filp_flush.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
> >       9.32            -9.3        0.00        perf-profile.calltrace.cy=
cles-pp.fput.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64=
_after_hwframe
> >      41.15            -5.9       35.26        perf-profile.calltrace.cy=
cles-pp.__dup2
> >      41.02            -5.9       35.17        perf-profile.calltrace.cy=
cles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__dup2
> >      41.03            -5.8       35.18        perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64_after_hwframe.__dup2
> >      13.86            -5.5        8.35        perf-profile.calltrace.cy=
cles-pp.filp_flush.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64
> >      40.21            -5.5       34.71        perf-profile.calltrace.cy=
cles-pp.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe.__dup2
> >      38.01            -4.9       33.10        perf-profile.calltrace.cy=
cles-pp.do_dup2.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_after_hwframe=
.__dup2
> >       4.90 =C4=85  2%      -1.9        2.96 =C4=85  3%  perf-profile.ca=
lltrace.cycles-pp.locks_remove_posix.filp_flush.filp_close.__do_sys_close_r=
ange.do_syscall_64
> >       2.63 =C4=85  9%      -1.9        0.76 =C4=85 18%  perf-profile.ca=
lltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.filp_flush.filp_close.__d=
o_sys_close_range.do_syscall_64
> >       4.44            -1.7        2.76 =C4=85  2%  perf-profile.calltra=
ce.cycles-pp.dnotify_flush.filp_flush.filp_close.__do_sys_close_range.do_sy=
scall_64
> >       2.50 =C4=85  2%      -0.9        1.56 =C4=85  3%  perf-profile.ca=
lltrace.cycles-pp.locks_remove_posix.filp_flush.filp_close.do_dup2.__x64_sy=
s_dup2
> >       2.22            -0.8        1.42 =C4=85  2%  perf-profile.calltra=
ce.cycles-pp.dnotify_flush.filp_flush.filp_close.do_dup2.__x64_sys_dup2
> >       1.66 =C4=85  5%      -0.3        1.37 =C4=85  5%  perf-profile.ca=
lltrace.cycles-pp.ksys_dup3.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe.__dup2
> >       1.60 =C4=85  5%      -0.3        1.32 =C4=85  5%  perf-profile.ca=
lltrace.cycles-pp._raw_spin_lock.ksys_dup3.__x64_sys_dup2.do_syscall_64.ent=
ry_SYSCALL_64_after_hwframe
> >       0.58 =C4=85  2%      +0.0        0.62 =C4=85  2%  perf-profile.ca=
lltrace.cycles-pp.do_read_fault.do_pte_missing.__handle_mm_fault.handle_mm_=
fault.do_user_addr_fault
> >       0.54 =C4=85  2%      +0.0        0.58 =C4=85  2%  perf-profile.ca=
lltrace.cycles-pp.filemap_map_pages.do_read_fault.do_pte_missing.__handle_m=
m_fault.handle_mm_fault
> >       0.72 =C4=85  4%      +0.1        0.79 =C4=85  4%  perf-profile.ca=
lltrace.cycles-pp._raw_spin_lock.__do_sys_close_range.do_syscall_64.entry_S=
YSCALL_64_after_hwframe.syscall
> >       0.00            +1.8        1.79 =C4=85  5%  perf-profile.calltra=
ce.cycles-pp.asm_sysvec_apic_timer_interrupt.fput_close.filp_close.__do_sys=
_close_range.do_syscall_64
> >      19.11            +4.4       23.49        perf-profile.calltrace.cy=
cles-pp.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe
> >      40.94            +6.5       47.46        perf-profile.calltrace.cy=
cles-pp.filp_close.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_afte=
r_hwframe.syscall
> >      42.24            +6.6       48.79        perf-profile.calltrace.cy=
cles-pp.syscall
> >      42.14            +6.6       48.72        perf-profile.calltrace.cy=
cles-pp.entry_SYSCALL_64_after_hwframe.syscall
> >      42.14            +6.6       48.72        perf-profile.calltrace.cy=
cles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
> >      41.86            +6.6       48.46        perf-profile.calltrace.cy=
cles-pp.__do_sys_close_range.do_syscall_64.entry_SYSCALL_64_after_hwframe.s=
yscall
> >       0.00           +14.6       14.60 =C4=85  2%  perf-profile.calltra=
ce.cycles-pp.fput_close.filp_close.do_dup2.__x64_sys_dup2.do_syscall_64
> >       0.00           +29.0       28.95 =C4=85  2%  perf-profile.calltra=
ce.cycles-pp.fput_close.filp_close.__do_sys_close_range.do_syscall_64.entry=
_SYSCALL_64_after_hwframe
> >      45.76           -19.0       26.72        perf-profile.children.cyc=
les-pp.filp_flush
> >      14.67           -14.7        0.00        perf-profile.children.cyc=
les-pp.fput
> >      41.20            -5.9       35.30        perf-profile.children.cyc=
les-pp.__dup2
> >      40.21            -5.5       34.71        perf-profile.children.cyc=
les-pp.__x64_sys_dup2
> >      38.53            -5.2       33.33        perf-profile.children.cyc=
les-pp.do_dup2
> >       7.81 =C4=85  2%      -3.1        4.74 =C4=85  3%  perf-profile.ch=
ildren.cycles-pp.locks_remove_posix
> >       7.03            -2.6        4.40 =C4=85  2%  perf-profile.childre=
n.cycles-pp.dnotify_flush
> >       1.24 =C4=85  3%      -0.4        0.86 =C4=85  4%  perf-profile.ch=
ildren.cycles-pp.syscall_exit_to_user_mode
> >       1.67 =C4=85  5%      -0.3        1.37 =C4=85  5%  perf-profile.ch=
ildren.cycles-pp.ksys_dup3
> >       0.29            -0.1        0.22 =C4=85  2%  perf-profile.childre=
n.cycles-pp.update_load_avg
> >       0.10 =C4=85 10%      -0.1        0.05 =C4=85 46%  perf-profile.ch=
ildren.cycles-pp.__x64_sys_fcntl
> >       0.17 =C4=85  7%      -0.1        0.12 =C4=85  4%  perf-profile.ch=
ildren.cycles-pp.entry_SYSCALL_64
> >       0.15 =C4=85  3%      -0.0        0.10 =C4=85 18%  perf-profile.ch=
ildren.cycles-pp.clockevents_program_event
> >       0.06 =C4=85 11%      -0.0        0.02 =C4=85 99%  perf-profile.ch=
ildren.cycles-pp.stress_close_func
> >       0.13 =C4=85  5%      -0.0        0.10 =C4=85  7%  perf-profile.ch=
ildren.cycles-pp.__switch_to
> >       0.06 =C4=85  7%      -0.0        0.04 =C4=85 71%  perf-profile.ch=
ildren.cycles-pp.lapic_next_deadline
> >       0.11 =C4=85  3%      -0.0        0.09 =C4=85  5%  perf-profile.ch=
ildren.cycles-pp.__update_load_avg_cfs_rq
> >       0.06 =C4=85  6%      +0.0        0.08 =C4=85  6%  perf-profile.ch=
ildren.cycles-pp.__folio_batch_add_and_move
> >       0.26 =C4=85  2%      +0.0        0.28 =C4=85  3%  perf-profile.ch=
ildren.cycles-pp.folio_remove_rmap_ptes
> >       0.08 =C4=85  4%      +0.0        0.11 =C4=85 10%  perf-profile.ch=
ildren.cycles-pp.set_pte_range
> >       0.45 =C4=85  2%      +0.0        0.48 =C4=85  2%  perf-profile.ch=
ildren.cycles-pp.zap_present_ptes
> >       0.18 =C4=85  3%      +0.0        0.21 =C4=85  4%  perf-profile.ch=
ildren.cycles-pp.folios_put_refs
> >       0.29 =C4=85  3%      +0.0        0.32 =C4=85  3%  perf-profile.ch=
ildren.cycles-pp.__tlb_batch_free_encoded_pages
> >       0.29 =C4=85  3%      +0.0        0.32 =C4=85  3%  perf-profile.ch=
ildren.cycles-pp.free_pages_and_swap_cache
> >       0.34 =C4=85  4%      +0.0        0.38 =C4=85  3%  perf-profile.ch=
ildren.cycles-pp.tlb_finish_mmu
> >       0.24 =C4=85  3%      +0.0        0.27 =C4=85  5%  perf-profile.ch=
ildren.cycles-pp._raw_spin_lock_irqsave
> >       0.73 =C4=85  2%      +0.0        0.78 =C4=85  2%  perf-profile.ch=
ildren.cycles-pp.do_read_fault
> >       0.69 =C4=85  2%      +0.0        0.74 =C4=85  2%  perf-profile.ch=
ildren.cycles-pp.filemap_map_pages
> >      42.26            +6.5       48.80        perf-profile.children.cyc=
les-pp.syscall
> >      41.86            +6.6       48.46        perf-profile.children.cyc=
les-pp.__do_sys_close_range
> >      60.05           +10.9       70.95        perf-profile.children.cyc=
les-pp.filp_close
> >       0.00           +44.5       44.55 =C4=85  2%  perf-profile.childre=
n.cycles-pp.fput_close
> >      14.31 =C4=85  2%     -14.3        0.00        perf-profile.self.cy=
cles-pp.fput
> >      30.12 =C4=85  2%     -13.0       17.09        perf-profile.self.cy=
cles-pp.filp_flush
> >      19.17 =C4=85  2%      -9.5        9.68 =C4=85  3%  perf-profile.se=
lf.cycles-pp.do_dup2
> >       7.63 =C4=85  3%      -3.0        4.62 =C4=85  4%  perf-profile.se=
lf.cycles-pp.locks_remove_posix
> >       6.86 =C4=85  3%      -2.6        4.28 =C4=85  3%  perf-profile.se=
lf.cycles-pp.dnotify_flush
> >       0.64 =C4=85  4%      -0.4        0.26 =C4=85  4%  perf-profile.se=
lf.cycles-pp.syscall_exit_to_user_mode
> >       0.22 =C4=85 10%      -0.1        0.15 =C4=85 11%  perf-profile.se=
lf.cycles-pp.x64_sys_call
> >       0.23 =C4=85  3%      -0.1        0.17 =C4=85  8%  perf-profile.se=
lf.cycles-pp.__schedule
> >       0.08 =C4=85 19%      -0.1        0.03 =C4=85100%  perf-profile.se=
lf.cycles-pp.pick_eevdf
> >       0.06 =C4=85  7%      -0.0        0.03 =C4=85100%  perf-profile.se=
lf.cycles-pp.lapic_next_deadline
> >       0.13 =C4=85  7%      -0.0        0.10 =C4=85 10%  perf-profile.se=
lf.cycles-pp.__switch_to
> >       0.09 =C4=85  8%      -0.0        0.06 =C4=85  8%  perf-profile.se=
lf.cycles-pp.__update_load_avg_se
> >       0.08 =C4=85  4%      -0.0        0.05 =C4=85  7%  perf-profile.se=
lf.cycles-pp.asm_sysvec_apic_timer_interrupt
> >       0.08 =C4=85  9%      -0.0        0.06 =C4=85 11%  perf-profile.se=
lf.cycles-pp.entry_SYSCALL_64
> >       0.06 =C4=85  7%      +0.0        0.08 =C4=85  8%  perf-profile.se=
lf.cycles-pp.filemap_map_pages
> >       0.12 =C4=85  3%      +0.0        0.14 =C4=85  4%  perf-profile.se=
lf.cycles-pp.folios_put_refs
> >       0.25 =C4=85  2%      +0.0        0.27 =C4=85  3%  perf-profile.se=
lf.cycles-pp.folio_remove_rmap_ptes
> >       0.17 =C4=85  5%      +0.0        0.20 =C4=85  6%  perf-profile.se=
lf.cycles-pp._raw_spin_lock_irqsave
> >       0.00            +0.1        0.07 =C4=85  5%  perf-profile.self.cy=
cles-pp.do_nanosleep
> >       0.00            +0.1        0.10 =C4=85 15%  perf-profile.self.cy=
cles-pp.filp_close
> >       0.00           +43.9       43.86 =C4=85  2%  perf-profile.self.cy=
cles-pp.fput_close
> >       2.12 =C4=85 47%    +151.1%       5.32 =C4=85 28%  perf-sched.sch_=
delay.avg.ms.__cond_resched.__do_sys_close_range.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe.[unknown]
> >       0.28 =C4=85 60%    +990.5%       3.08 =C4=85 53%  perf-sched.sch_=
delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.do_eventfd.__x64_sys_eve=
ntfd2.do_syscall_64
> >       0.96 =C4=85 28%     +35.5%       1.30 =C4=85 25%  perf-sched.sch_=
delay.avg.ms.__cond_resched.__kmalloc_noprof.load_elf_phdrs.load_elf_binary=
.exec_binprm
> >       2.56 =C4=85 43%    +964.0%      27.27 =C4=85161%  perf-sched.sch_=
delay.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
> >      12.80 =C4=85139%    +366.1%      59.66 =C4=85107%  perf-sched.sch_=
delay.avg.ms.__cond_resched.dput.shmem_unlink.vfs_unlink.do_unlinkat
> >       2.78 =C4=85 25%     +50.0%       4.17 =C4=85 19%  perf-sched.sch_=
delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc_c=
ursor.dcache_dir_open
> >       0.78 =C4=85 18%     +39.3%       1.09 =C4=85 19%  perf-sched.sch_=
delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_pre=
allocate.vma_shrink
> >       2.63 =C4=85 10%     +16.7%       3.07 =C4=85  4%  perf-sched.sch_=
delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_ne=
w_vma.__mmap_region
> >       0.04 =C4=85223%   +3483.1%       1.38 =C4=85 67%  perf-sched.sch_=
delay.avg.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fpu=
t
> >       0.72 =C4=85 17%     +42.5%       1.02 =C4=85 22%  perf-sched.sch_=
delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
> >       0.35 =C4=85134%    +457.7%       1.94 =C4=85 61%  perf-sched.sch_=
delay.avg.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_us=
er_mode.do_syscall_64
> >       1.88 =C4=85 34%    +574.9%      12.69 =C4=85115%  perf-sched.sch_=
delay.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_sysc=
all_64.entry_SYSCALL_64_after_hwframe
> >       2.41 =C4=85 10%     +18.0%       2.84 =C4=85  9%  perf-sched.sch_=
delay.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.=
do_user_addr_fault
> >       1.85 =C4=85 36%    +155.6%       4.73 =C4=85 50%  perf-sched.sch_=
delay.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
> >      28.94 =C4=85 26%     -52.4%      13.78 =C4=85 36%  perf-sched.sch_=
delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
> >       2.24 =C4=85  9%     +22.1%       2.74 =C4=85  8%  perf-sched.sch_=
delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write=
.unlink_file_vma_batch_final
> >       2.19 =C4=85  7%     +17.3%       2.57 =C4=85  6%  perf-sched.sch_=
delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write=
.vma_link_file
> >       2.39 =C4=85  6%     +16.4%       2.79 =C4=85  9%  perf-sched.sch_=
delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write=
.vma_prepare
> >       0.34 =C4=85 77%   +1931.5%       6.95 =C4=85 99%  perf-sched.sch_=
delay.max.ms.__cond_resched.__kmalloc_cache_noprof.do_eventfd.__x64_sys_eve=
ntfd2.do_syscall_64
> >      29.69 =C4=85 28%    +129.5%      68.12 =C4=85 28%  perf-sched.sch_=
delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.pe=
rf_event_mmap.__mmap_region
> >       1.48 =C4=85 96%    +284.6%       5.68 =C4=85 56%  perf-sched.sch_=
delay.max.ms.__cond_resched.copy_strings_kernel.kernel_execve.call_usermode=
helper_exec_async.ret_from_fork
> >       3.59 =C4=85 57%    +124.5%       8.06 =C4=85 45%  perf-sched.sch_=
delay.max.ms.__cond_resched.down_read.mmap_read_lock_maybe_expand.get_arg_p=
age.copy_string_kernel
> >       3.39 =C4=85 91%    +112.0%       7.19 =C4=85 44%  perf-sched.sch_=
delay.max.ms.__cond_resched.down_read_killable.iterate_dir.__x64_sys_getden=
ts64.do_syscall_64
> >      22.16 =C4=85 77%    +117.4%      48.17 =C4=85 34%  perf-sched.sch_=
delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.lo=
ad_elf_binary
> >       8.72 =C4=85 17%    +358.5%      39.98 =C4=85 61%  perf-sched.sch_=
delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_pre=
allocate.__mmap_new_vma
> >       0.04 =C4=85223%   +3484.4%       1.38 =C4=85 67%  perf-sched.sch_=
delay.max.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fpu=
t
> >       0.53 =C4=85154%    +676.1%       4.12 =C4=85 61%  perf-sched.sch_=
delay.max.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_us=
er_mode.do_syscall_64
> >      25.76 =C4=85 70%   +9588.9%       2496 =C4=85127%  perf-sched.sch_=
delay.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_sysc=
all_64.entry_SYSCALL_64_after_hwframe
> >      51.53 =C4=85 26%     -58.8%      21.22 =C4=85106%  perf-sched.sch_=
delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
> >       4.97 =C4=85 48%    +154.8%      12.66 =C4=85 75%  perf-sched.sch_=
delay.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
> >       4.36 =C4=85 48%    +147.7%      10.81 =C4=85 29%  perf-sched.wait=
_and_delay.avg.ms.__cond_resched.__do_sys_close_range.do_syscall_64.entry_S=
YSCALL_64_after_hwframe.[unknown]
> >     108632 =C4=85  4%     +23.9%     134575 =C4=85  6%  perf-sched.wait=
_and_delay.count.__cond_resched.__do_sys_close_range.do_syscall_64.entry_SY=
SCALL_64_after_hwframe.[unknown]
> >     572.67 =C4=85  6%     +37.3%     786.17 =C4=85  7%  perf-sched.wait=
_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cp=
us_allowed_ptr.__sched_setaffinity
> >     596.67 =C4=85 12%     +43.9%     858.50 =C4=85 13%  perf-sched.wait=
_and_delay.count.__cond_resched.__wait_for_common.wait_for_completion_state=
.call_usermodehelper_exec.__request_module
> >     294.83 =C4=85  9%     +31.1%     386.50 =C4=85 11%  perf-sched.wait=
_and_delay.count.__cond_resched.dput.terminate_walk.path_openat.do_filp_ope=
n
> >    1223275 =C4=85  2%     -17.7%    1006293 =C4=85  6%  perf-sched.wait=
_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clo=
ck_nanosleep
> >       2772 =C4=85 11%     +43.6%       3980 =C4=85 11%  perf-sched.wait=
_and_delay.count.do_wait.kernel_wait.call_usermodehelper_exec_work.process_=
one_work
> >      11690 =C4=85  7%     +29.8%      15173 =C4=85 10%  perf-sched.wait=
_and_delay.count.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
> >       4072 =C4=85100%    +163.7%      10737 =C4=85  7%  perf-sched.wait=
_and_delay.count.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[u=
nknown]
> >       8811 =C4=85  6%     +26.2%      11117 =C4=85  9%  perf-sched.wait=
_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt=
.[unknown].[unknown]
> >     662.17 =C4=85 29%    +187.8%       1905 =C4=85 29%  perf-sched.wait=
_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
> >      15.50 =C4=85 11%     +48.4%      23.00 =C4=85 16%  perf-sched.wait=
_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
> >     167.67 =C4=85 20%     +48.0%     248.17 =C4=85 26%  perf-sched.wait=
_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_w=
rite.open_last_lookups
> >       2680 =C4=85 12%     +42.5%       3820 =C4=85 11%  perf-sched.wait=
_and_delay.count.schedule_timeout.___down_common.__down_timeout.down_timeou=
t
> >     137.17 =C4=85 13%     +31.8%     180.83 =C4=85  9%  perf-sched.wait=
_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_sta=
te.__wait_rcu_gp
> >       2636 =C4=85 12%     +43.1%       3772 =C4=85 12%  perf-sched.wait=
_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_sta=
te.call_usermodehelper_exec
> >      10.50 =C4=85 11%     +74.6%      18.33 =C4=85 23%  perf-sched.wait=
_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
> >       5619 =C4=85  5%     +38.8%       7797 =C4=85  9%  perf-sched.wait=
_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
> >      70455 =C4=85  4%     +32.3%      93197 =C4=85  6%  perf-sched.wait=
_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_a=
fter_hwframe.[unknown]
> >       6990 =C4=85  4%     +37.4%       9603 =C4=85  9%  perf-sched.wait=
_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
> >     191.28 =C4=85124%   +1455.2%       2974 =C4=85100%  perf-sched.wait=
_and_delay.max.ms.__cond_resched.dput.path_openat.do_filp_open.do_sys_opena=
t2
> >       2.24 =C4=85 48%    +144.6%       5.48 =C4=85 29%  perf-sched.wait=
_time.avg.ms.__cond_resched.__do_sys_close_range.do_syscall_64.entry_SYSCAL=
L_64_after_hwframe.[unknown]
> >       8.06 =C4=85101%    +618.7%      57.94 =C4=85 68%  perf-sched.wait=
_time.avg.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
> >       0.28 =C4=85146%    +370.9%       1.30 =C4=85 64%  perf-sched.wait=
_time.avg.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.d=
o_vmi_align_munmap
> >       3.86 =C4=85  5%     +86.0%       7.18 =C4=85 44%  perf-sched.wait=
_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
> >       2.54 =C4=85 29%     +51.6%       3.85 =C4=85 12%  perf-sched.wait=
_time.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.=
entry_SYSCALL_64_after_hwframe
> >       1.11 =C4=85 39%    +201.6%       3.36 =C4=85 47%  perf-sched.wait=
_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.lo=
ad_elf_binary
> >       3.60 =C4=85 68%   +1630.2%      62.29 =C4=85153%  perf-sched.wait=
_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
> >       0.20 =C4=85 64%    +115.4%       0.42 =C4=85 42%  perf-sched.wait=
_time.avg.ms.__cond_resched.filemap_read.__kernel_read.load_elf_binary.exec=
_binprm
> >      55.51 =C4=85 53%    +218.0%     176.54 =C4=85 83%  perf-sched.wait=
_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.in=
ode_init_always_gfp.alloc_inode
> >       3.22 =C4=85  3%     +15.4%       3.72 =C4=85  9%  perf-sched.wait=
_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma=
.vms_gather_munmap_vmas
> >       0.04 =C4=85223%  +37562.8%      14.50 =C4=85198%  perf-sched.wait=
_time.avg.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fpu=
t
> >       1.19 =C4=85 30%     +59.3%       1.90 =C4=85 34%  perf-sched.wait=
_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_alig=
n_munmap.do_vmi_munmap
> >       0.36 =C4=85133%    +447.8%       1.97 =C4=85 60%  perf-sched.wait=
_time.avg.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_us=
er_mode.do_syscall_64
> >       1.73 =C4=85 47%    +165.0%       4.58 =C4=85 51%  perf-sched.wait=
_time.avg.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
> >       1.10 =C4=85 21%    +693.9%       8.70 =C4=85 70%  perf-sched.wait=
_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[un=
known]
> >      54.56 =C4=85 32%    +400.2%     272.90 =C4=85 67%  perf-sched.wait=
_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.k=
ernel_clone
> >      10.87 =C4=85 18%    +151.7%      27.36 =C4=85 68%  perf-sched.wait=
_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_mi=
ssing.__handle_mm_fault
> >     123.35 =C4=85181%   +1219.3%       1627 =C4=85 82%  perf-sched.wait=
_time.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSC=
ALL_64_after_hwframe
> >       9.68 =C4=85108%   +5490.2%     541.19 =C4=85185%  perf-sched.wait=
_time.max.ms.__cond_resched.__kmalloc_cache_noprof.do_epoll_create.__x64_sy=
s_epoll_create.do_syscall_64
> >       3.39 =C4=85 91%    +112.0%       7.19 =C4=85 44%  perf-sched.wait=
_time.max.ms.__cond_resched.down_read_killable.iterate_dir.__x64_sys_getden=
ts64.do_syscall_64
> >       1.12 =C4=85128%    +407.4%       5.67 =C4=85 52%  perf-sched.wait=
_time.max.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.d=
o_vmi_align_munmap
> >      30.58 =C4=85 29%   +1741.1%     563.04 =C4=85 80%  perf-sched.wait=
_time.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
> >       3.82 =C4=85114%    +232.1%      12.70 =C4=85 49%  perf-sched.wait=
_time.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.__mmap_prepar=
e.__mmap_region
> >       7.75 =C4=85 46%     +72.4%      13.36 =C4=85 32%  perf-sched.wait=
_time.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.=
entry_SYSCALL_64_after_hwframe
> >      13.39 =C4=85 48%    +259.7%      48.17 =C4=85 34%  perf-sched.wait=
_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.lo=
ad_elf_binary
> >      12.46 =C4=85 30%     +90.5%      23.73 =C4=85 34%  perf-sched.wait=
_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgo=
ff.do_syscall_64
> >     479.90 =C4=85 78%    +496.9%       2864 =C4=85141%  perf-sched.wait=
_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
> >     185.75 =C4=85116%    +875.0%       1811 =C4=85 84%  perf-sched.wait=
_time.max.ms.__cond_resched.dput.path_openat.do_filp_open.do_sys_openat2
> >       2.52 =C4=85 44%    +105.2%       5.18 =C4=85 36%  perf-sched.wait=
_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.alloc_bpr=
m.kernel_execve
> >       0.04 =C4=85223%  +37564.1%      14.50 =C4=85198%  perf-sched.wait=
_time.max.ms.__cond_resched.netlink_release.__sock_release.sock_close.__fpu=
t
> >       0.54 =C4=85153%    +669.7%       4.15 =C4=85 61%  perf-sched.wait=
_time.max.ms.__cond_resched.task_numa_work.task_work_run.syscall_exit_to_us=
er_mode.do_syscall_64
> >      28.22 =C4=85 14%     +41.2%      39.84 =C4=85 25%  perf-sched.wait=
_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.part.0
> >       4.90 =C4=85 51%    +158.2%      12.66 =C4=85 75%  perf-sched.wait=
_time.max.ms.io_schedule.folio_wait_bit_common.__do_fault.do_read_fault
> >      26.54 =C4=85 66%   +5220.1%       1411 =C4=85 84%  perf-sched.wait=
_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[un=
known]
> >       1262 =C4=85  9%    +434.3%       6744 =C4=85 60%  perf-sched.wait=
_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.k=
ernel_clone
> >
> >
> >
> >
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are pr=
ovided
> > for informational purposes only. Any difference in system hardware or s=
oftware
> > design or configuration may affect actual performance.
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
>
>
> --
> Mateusz Guzik <mjguzik gmail.com>



--=20
Mateusz Guzik <mjguzik gmail.com>

