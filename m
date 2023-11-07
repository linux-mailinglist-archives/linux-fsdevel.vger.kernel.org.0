Return-Path: <linux-fsdevel+bounces-2334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D827E4D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE431C20CA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5336A34573;
	Tue,  7 Nov 2023 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAPIXaHI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48573456B
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 23:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC3DC433C8;
	Tue,  7 Nov 2023 23:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699400368;
	bh=Mj2pwAn8Ayyso+nFqVs/qWRLklVo1CoXY6S2HNE1B58=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rAPIXaHIDgIZQR3P2JuU+NcVe9EuOwlx1iNGZeG2Xi0sJ1W4HVZWsehsjhPNPtE8V
	 5snCqAbXmW73htMvn4b9I2v5cLJixZj8rJP4xRliGNmioL1VP13RRGTuL9yzdbXYyp
	 KHzgmLAy8w804FnWscmh1RaG400zjPNJNVoyIzNf56CNMsMOdEgJNYCOuGT20J7+XR
	 Jvav0JCcHP3SguaQ27D756T7GOQ/TCVxzViillu0sUNXYblFiuu2IsIBfch33DoVAF
	 qfkNysMAoD7qQuVW11YeGV8t4ZIQslOJ4fLOXSO6HJ3b5S6xIQhx1iZ6MWZZNRk3jq
	 I53rTUVpcsKXg==
Date: Tue, 07 Nov 2023 15:39:28 -0800
From: Kees Cook <kees@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>, Kees Cook <keescook@chromium.org>
CC: Josh Triplett <josh@joshtriplett.org>, Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_fs/exec=2Ec=3A_Add_fast_path_for_?= =?US-ASCII?Q?ENOENT_on_PATH_search_before_allocating_mm?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGudoHF5mYFWtzrv539W8Uc1aO_u6+UJOoDqWY0pePc+cofziw@mail.gmail.com>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org> <202311071228.27D22C00@keescook> <20231107205151.qkwlw7aarjvkyrqs@f> <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com> <202311071445.53E5D72C@keescook> <CAGudoHF5mYFWtzrv539W8Uc1aO_u6+UJOoDqWY0pePc+cofziw@mail.gmail.com>
Message-ID: <A7FFA44F-F7DD-477F-83A6-44AF71D6775E@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 7, 2023 3:08:47 PM PST, Mateusz Guzik <mjguzik@gmail=2Ecom> wr=
ote:
>On 11/7/23, Kees Cook <keescook@chromium=2Eorg> wrote:
>> On Tue, Nov 07, 2023 at 10:23:16PM +0100, Mateusz Guzik wrote:
>>> If the patch which dodges second lookup still somehow appears slower a
>>> flamegraph or other profile would be nice=2E I can volunteer to take a
>>> look at what's going on provided above measurements will be done and
>>> show funkyness=2E
>>
>> When I looked at this last, it seemed like all the work done in
>> do_filp_open() (my patch, which moved the lookup earlier) was heavier
>> than the duplicate filename_lookup()=2E
>>
>> What I didn't test was moving the sched_exec() before the mm creation,
>> which Peter confirmed shouldn't be a problem, but I think that might be
>> only a tiny benefit, if at all=2E
>>
>> If you can do some comparisons, that would be great; it always takes me
>> a fair bit of time to get set up for flame graph generation, etc=2E :)
>>
>
>So I spawned *one* process executing one statocally linked binary in a
>loop, test case from http://apollo=2Ebackplane=2Ecom/DFlyMisc/doexec=2Ec =
=2E
>
>The profile is definitely not what I expected:
>   5=2E85%  [kernel]           [k] asm_exc_page_fault
>   5=2E84%  [kernel]           [k] __pv_queued_spin_lock_slowpath
>[snip]
>
>I'm going to have to recompile with lock profiling, meanwhile
>according to bpftrace
>(bpftrace -e 'kprobe:__pv_queued_spin_lock_slowpath { @[kstack()] =3D cou=
nt(); }')
>top hits would be:
>
>@[
>    __pv_queued_spin_lock_slowpath+1
>    _raw_spin_lock+37
>    __schedule+192
>    schedule_idle+38
>    do_idle+366
>    cpu_startup_entry+38
>    start_secondary+282
>    secondary_startup_64_no_verify+381
>]: 181
>@[
>    __pv_queued_spin_lock_slowpath+1
>    _raw_spin_lock_irq+43
>    wait_for_completion+141
>    stop_one_cpu+127
>    sched_exec+165

There's the suspicious sched_exec() I was talking about! :)

I think it needs to be moved, and perhaps _later_ instead of earlier? Hmm=
=2E=2E=2E

-Kees

>    bprm_execve+328
>    do_execveat_common=2Eisra=2E0+429
>    __x64_sys_execve+50
>    do_syscall_64+46
>    entry_SYSCALL_64_after_hwframe+110
>]: 206
>
>I did not see this coming for sure=2E I'll poke around maybe this weekend=
=2E
>

--=20
Kees Cook

