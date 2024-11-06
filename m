Return-Path: <linux-fsdevel+bounces-33833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42E9BF90E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7AFB20D43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 22:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A720CCD7;
	Wed,  6 Nov 2024 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy3R/6PM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB61D5151;
	Wed,  6 Nov 2024 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931343; cv=none; b=O12IuZG4QxqOOUQt+ej6PArb2nBUvLDpqTa+gdEF+VGFjtRoZSo51Kqht3Bb27xR6szxNacNBL68S5j7LPf9yHot1QsnfxDTgctjAVxXX8/XXjslWBTv0oeIiSbN9/IynSupGKhNefyGR4/6vsQmx24BuipSOzrL2lmbMCiRNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931343; c=relaxed/simple;
	bh=z98hpMQxfpYc0n+ZYrKaPSTkUUMba3878SMe8PgSAkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdDCpHm3DtIglRv06RPpFV8AB1IWMZ9C+06laa8FjHha3hqnti80aj/B2X4hNV8t91oe/45WSI/FI87VnPsm42QjqmshoUMBD3bVHofybyq6bK7I6HPxB+Z+HyWgu2nKPubujc21rr2ecnpKvLP4bj7TKFDaCspVOqHZuuo+6kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy3R/6PM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so272538a12.2;
        Wed, 06 Nov 2024 14:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730931339; x=1731536139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVlemPBZb31F4Ktpe27you5t3FXwVBtCloJLcZZCTYE=;
        b=Hy3R/6PML+Cc1tjxXosOJPqMY5GafN2M2DyiwrK0VGc8aBUNVsNvNMvIAuZfNwjXN8
         LahKKfewYf7zXjZjb4RTJPc02XPWWnHiPRWTH5NMWna3lg91aIFDDpV+U6GQWNPfTHdA
         KwR9kHA4ya6F4GUHscJbd9gOhxMl9YAg4vq5GYf65A8Bpuw68f9W5fgAwN5D0G9HYJ2+
         lx6NjmYE24nZE8wrq3KWeVGSUUprs0paM0KkWPFkQjF7T6WSLI5PqBMJ3MYy//94guZo
         6e4MnrQ6s+EdF7AcEffxaJBQg2LfXx5QubberCkQKX0e5sSrklGaM89NW56pH2LGedl+
         7evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931339; x=1731536139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVlemPBZb31F4Ktpe27you5t3FXwVBtCloJLcZZCTYE=;
        b=CclwgXJgLMdaUSdndi0gY62Mim0U1mFQFpkGeknHVgHqcxYkrjsVg7Al8Ckz97WBW+
         w1EwIjSVmIWcgx6xC8fYelutNlZPNIXqRuA3S899timt9vjl9ePiggMDbMZgcRnpVFY8
         d/aR6JLVAAm5BoQ5+gi90xs+41qldXCgxFDbdbXgFPLaptneFOBxG4U2sUYMwnxUN4is
         8/L+cSS/fUuxsL3aFnVmLemJs1eVsUZ2+p4qQkW5ygBc3CgoygPKldxDyhU+36aqgXeO
         8KOGyIdFVAKflC2QBaUC+mUNJny5/F8C0hWTMReBwivL8aO6wGFhP2t3Q8Zhtqy8tZwu
         r5TA==
X-Forwarded-Encrypted: i=1; AJvYcCUeOhFHdYIojgAqVPG/iIP+gbF7LamEB0pkyKrGZYHtFs+xsOinhZ9ZEOI7/VA4JyeZcAM=@vger.kernel.org, AJvYcCWD5nXC9toy72AjB2JpEmi8ojILpszw03y5GKYwapWnxm8cyhR7GznWMe7+eTdy9Vy/ms0zg0+r0n6Y7kDZ@vger.kernel.org, AJvYcCXWISNYludpuFmWS8eD4z+bgWpsdBASmEtNNkhsGmyCYg4JflAl/lHO59PM6IAiPgUAuEu6toPx7JOjxjGKJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmJSwlS0H1rhJuRqA+oOrwD6rEcaE+RtDbpyOh9XPV/hf2N6P5
	ESWqJXtWQXVjU1K+NDwPOQsG2w1QGIiO4exbAPXtKCA1q8c3j+su3rNAm7MV1PhQgLPtgvEKMj/
	/2hIrjMMskk4b29efZzFwpHDMgQU=
X-Google-Smtp-Source: AGHT+IEMgHBIg76lvdFqk9Gvx5K24uD0OsQh7CrLqzchjmu0y5UKi/uIwzyR5+JXQVqcFmGihLXcUt2KTE+mV6pQ04s=
X-Received: by 2002:a17:90b:17c1:b0:2e2:cd6b:c6ca with SMTP id
 98e67ed59e1d1-2e94c51b643mr29502308a91.25.1730931339400; Wed, 06 Nov 2024
 14:15:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 14:15:27 -0800
Message-ID: <CAEf4BzZJuWcCLeUdmzhRVe9nyi9jAN8y=u2nK=mqzxXG6DTkDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf/crib: Add open-coded style process
 file iterator and file related CRIB kfuncs
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, 
	brauner@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 11:35=E2=80=AFAM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> This patch series adds open-coded style process file iterator
> bpf_iter_task_file and file related kfuncs bpf_fget_task(),
> bpf_get_file_ops_type(), and corresponding selftests test cases.
>
> Known future merge conflict: In linux-next task_lookup_next_fdget_rcu()
> has been removed and replaced with fget_task_next() [0], but that has
> not happened yet in bpf-next, so I still
> use task_lookup_next_fdget_rcu() in bpf_iter_task_file_next().
>
> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/=
commit/?id=3D8fd3395ec9051a52828fcca2328cb50a69dea8ef
>
> Although iter/task_file already exists, for CRIB we still need the
> open-coded iterator style process file iterator, and the same is true
> for other bpf iterators such as iter/tcp, iter/udp, etc.
>
> The traditional bpf iterator is more like a bpf version of procfs, but
> similar to procfs, it is not suitable for CRIB scenarios that need to
> obtain large amounts of complex, multi-level in-kernel information.
>
> The following is from previous discussions [1].
>
> [1]: https://lore.kernel.org/bpf/AM6PR03MB5848CA34B5B68C90F210285E99B12@A=
M6PR03MB5848.eurprd03.prod.outlook.com/
>
> This is because the context of bpf iterators is fixed and bpf iterators
> cannot be nested. This means that a bpf iterator program can only
> complete a specific small iterative dump task, and cannot dump
> multi-level data.
>
> An example, when we need to dump all the sockets of a process, we need
> to iterate over all the files (sockets) of the process, and iterate over
> the all packets in the queue of each socket, and iterate over all data
> in each packet.
>
> If we use bpf iterator, since the iterator can not be nested, we need to
> use socket iterator program to get all the basic information of all
> sockets (pass pid as filter), and then use packet iterator program to
> get the basic information of all packets of a specific socket (pass pid,
> fd as filter), and then use packet data iterator program to get all the
> data of a specific packet (pass pid, fd, packet index as filter).
>
> This would be complicated and require a lot of (each iteration)
> bpf program startup and exit (leading to poor performance).
>
> By comparison, open coded iterator is much more flexible, we can iterate
> in any context, at any time, and iteration can be nested, so we can
> achieve more flexible and more elegant dumping through open coded
> iterators.
>
> With open coded iterators, all of the above can be done in a single
> bpf program, and with nested iterators, everything becomes compact
> and simple.
>
> Also, bpf iterators transmit data to user space through seq_file,
> which involves a lot of open (bpf_iter_create), read, close syscalls,
> context switching, memory copying, and cannot achieve the performance
> of using ringbuf.
>
> Discussion
> ----------
>
> 1. Do we need bpf_iter_task_file_get_fd()?
>
> Andrii suggested that next() should return a pointer to
> a bpf_iter_task_file_item, which contains *file and fd.
>
> This is feasible, but it might compromise iterator encapsulation?

I don't think so, replied on v2 ([0]). I know you saw that, I'm just
linking it for others.

  [0] https://lore.kernel.org/bpf/CAEf4Bzba2N7pxPQh8_BDrVgupZdeow_3S7xSjDms=
dhL19eXb3A@mail.gmail.com/


>
> More detailed discussion can be found at [3] [4]
>
> [3]: https://lore.kernel.org/bpf/CAEf4Bzbt0kh53xYZL57Nc9AWcYUKga_NQ6uUrTe=
U4bj8qyTLng@mail.gmail.com/
> [4]: https://lore.kernel.org/bpf/AM6PR03MB584814D93FE3680635DE61A199562@A=
M6PR03MB5848.eurprd03.prod.outlook.com/
>
> What should we do? Maybe more discussion is needed?
>
> 2. Where should we put CRIB related kfuncs?
>
> I totally agree that most of the CRIB related kfuncs are not
> CRIB specific.
>
> The goal of CRIB is to collect all relevant information about a process,
> which means we need to add kfuncs involving several different kernel
> subsystems (though these kfuncs are not complex and many just help the
> bpf program reach a certain data structure).
>
> But here is a question, where should these CRIB kfuncs be placed?
> There doesn't seem to be a suitable file to put them in.
>
> My current idea is to create a crib folder and then create new files for
> the relevant subsystems, e.g. crib/files.c, crib/socket.c, crib/mount.c
> etc. Putting them in the same folder makes it easier to maintain
> them centrally.
>
> If anyone else wants to use CRIB kfuncs, welcome to use them.
>

CRIB is just one of possible applications of such kfuncs, so I'd steer
away from over-specifying it as CRIB.

task_file open-coded iterator is generic, and should stay close to
other task iterator code, as you do in this revision.

bpf_get_file_ops_type() is unnecessary, as we already discussed on v2,
__ksym and comparison is the way to go here.

bpf_fget_task(), if VFS folks agree to add it, probably will have to
stay close to other similar VFS helpers.

> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
> v2 -> v3:
> 1. Move task_file open-coded iterator to kernel/bpf/helpers.c.
>
> 2. Fix duplicate error code 7 in test_bpf_iter_task_file().
>
> 3. Add comment for case when bpf_iter_task_file_get_fd() returns -1.
>
> 4. Add future plans in commit message of "Add struct file related
> CRIB kfuncs".
>
> 5. Add Discussion section to cover letter.
>
> v1 -> v2:
> Fix a type definition error in the fd parameter of
> bpf_fget_task() at crib_common.h.
>
> Juntong Deng (4):
>   bpf/crib: Introduce task_file open-coded iterator kfuncs
>   selftests/bpf: Add tests for open-coded style process file iterator
>   bpf/crib: Add struct file related CRIB kfuncs
>   selftests/bpf: Add tests for struct file related CRIB kfuncs
>
>  kernel/bpf/Makefile                           |   1 +
>  kernel/bpf/crib/Makefile                      |   3 +
>  kernel/bpf/crib/crib.c                        |  28 ++++
>  kernel/bpf/crib/files.c                       |  54 ++++++++
>  kernel/bpf/helpers.c                          |   4 +
>  kernel/bpf/task_iter.c                        |  96 +++++++++++++
>  tools/testing/selftests/bpf/prog_tests/crib.c | 126 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/crib_common.h |  25 ++++
>  .../selftests/bpf/progs/crib_files_failure.c  | 108 +++++++++++++++
>  .../selftests/bpf/progs/crib_files_success.c  | 119 +++++++++++++++++
>  10 files changed, 564 insertions(+)
>  create mode 100644 kernel/bpf/crib/Makefile
>  create mode 100644 kernel/bpf/crib/crib.c
>  create mode 100644 kernel/bpf/crib/files.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/crib.c
>  create mode 100644 tools/testing/selftests/bpf/progs/crib_common.h
>  create mode 100644 tools/testing/selftests/bpf/progs/crib_files_failure.=
c
>  create mode 100644 tools/testing/selftests/bpf/progs/crib_files_success.=
c
>
> --
> 2.39.5
>

