Return-Path: <linux-fsdevel+bounces-37395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750F59F1B65
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 01:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A1616B200
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277ABD2FF;
	Sat, 14 Dec 2024 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSJwYglD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C44D268;
	Sat, 14 Dec 2024 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734136922; cv=none; b=TfvzZj2avMnI25hbjmWetOUKnqgXw8HF8hj+MV1qagDNtKsZcUMJlbC/sF9PAtq+AH07w9zjITw45mCeWbsuj2rRjcDfbTO4hLxgbn25zSoD9UAWTN0+urKBKCKdRBavLydPEVVl02Hrnkiacls25vg+qoWUHYpPE/JlCorLdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734136922; c=relaxed/simple;
	bh=df5/NF1DUIdtxL0yuFGJSGKlxifxc3b7lbEXT66nzJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGfEj/lafG8lsDV1WNng7i+oo2F619jmXb0HlXLuyEBlgYvfjstkq+gpgxq6+2YY9eEstPJlojTIpnucu8fCa82fwyOKGLUoa4A77x07WUAxVgdsOmPOgICaTSWWZayJOemx6rVvwxF3X47D5pTQkNEtTXAwXu6O5HKheoeIBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSJwYglD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385eed29d17so1214753f8f.0;
        Fri, 13 Dec 2024 16:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734136919; x=1734741719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df5/NF1DUIdtxL0yuFGJSGKlxifxc3b7lbEXT66nzJQ=;
        b=SSJwYglD0V+cbKlko4oMjGuDTWUWMVoIKu+WTxE9NTvJPUweYca7aEZVBCcVivmWTy
         6DmcRT1aPvQ8tPOKnTqCbeBhPwc2mla6HvymjB3rxdfnqHE1vPAkNA1iu6bMfWjE6p7g
         cKjeFc+g4vqPj65AC5K/DNIXTrS5TW78SlWNwYERpUexvsgLpGpZ2ALePmwxChcY1CAx
         YZfDVuAqi5IC9RuVaiQrxQX5xbaC4U924wStrb0g/jU8PvPmf7NKdOATHUxKULIBlp2v
         p+d/wpxlVDBO3aZzIoPi6+OzZgZzrh0FwQwLS3BWcUV4/6jLUYmAVMYJ3wi/tD3L6WSK
         r+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734136919; x=1734741719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df5/NF1DUIdtxL0yuFGJSGKlxifxc3b7lbEXT66nzJQ=;
        b=u9Fo3lEZVNn+s2f7tr3Ktu2mqPDw6bvBkMJ0KykPoDNwd2N3L86ZjQVrg4+8AC7iFu
         IEL4IEh0u+ZfrpREbCbhlewWm3Q7XGWofMMRLbtL7AhGN78lcJun9uiEp6CH8U30LZUZ
         WHt4BIIlO8x8SSWOxde+JEC0kXki77x0FZfg93cq/f/Q2kvUw0eKVxUSvJMDPe33YT4p
         7KT21hyanEt4KC6+8bKL/gg+MZJ0PLmPDoiwz8R5TEoA/BC0TdjeQexJ/6uUaL2kYY4m
         auS0wLoX+N8PZacirhdhP0Mgd3mmun4EB0qYpuSlvS8JgMDeATxfGNJEvKcu6TagEDYd
         IC0g==
X-Forwarded-Encrypted: i=1; AJvYcCVlXTmvh00VP9/x1WZPuF2JXRcmcIT3MO2n4lxnThrneEIgwX4MjXEkNqE0vmIxgioDV8kvSDYOdTwRcPgngA==@vger.kernel.org, AJvYcCWmt+01SUOU3fV5FvYS1Vk5vVCy4YaaDba43G2Z+FMobtejiKopmxZ3lTPtoVlai07lh3c=@vger.kernel.org, AJvYcCXy4L/x4ACPgbZ7c6c+2MBKFT1iqlpmASzyYQGcMMUOZM2wcMzorsJMW73T5yOFy7SXrRTWP9EV/nYndu5H@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKLAJwVR/hWtxC9G3J7XI/OegjlG5hWsjwzNNUfWmmxkhhoDE
	vZ7cUQeiqUmtIvy0O/9dKXXPtRm/yWpADKPy0i4y+TGA2Bm1qpqmQAJ5PshZ7XBXBEELTfjRexb
	xDT3jCw98Z4fU77rJ70KaVQD7c04=
X-Gm-Gg: ASbGnct+K0fj9hjQEVByqzICovh5RoC/M7NYGAkTfXHysSLiEyOGWjVzPKvuvejG42L
	9LVpLuv7grmbu70wiRtJ20PA6+izHwAC+0FONnuwmU+FvlUalajeL1W5ek5GeAUxydS6D/g==
X-Google-Smtp-Source: AGHT+IFeH/BTkMeNqByZXMAshWl9z6JVM6prz9wmrS6pANVhcDH76wh15xHsC+6N4utFoXupZMRdIxcjcBWnwA4R4LA=
X-Received: by 2002:a05:6000:1f8b:b0:385:fb59:8358 with SMTP id
 ffacd0b85a97d-3888e0c0801mr4079232f8f.53.1734136918805; Fri, 13 Dec 2024
 16:41:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-eckig-april-9ffc098f193b@brauner> <CAADnVQKdBrX6pSJrgBY0SvFZQLpu+CMSshwD=21NdFaoAwW_eg@mail.gmail.com>
 <AM6PR03MB508072B5D29C8BD433AD186E993E2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQK3toLsVLVYjGVXEuQGWUKF98OG9ogAQbJ4UeER42ZyGg@mail.gmail.com> <DB7PR03MB508153EF2FECDC66FC5325BF99382@DB7PR03MB5081.eurprd03.prod.outlook.com>
In-Reply-To: <DB7PR03MB508153EF2FECDC66FC5325BF99382@DB7PR03MB5081.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Dec 2024 16:41:47 -0800
Message-ID: <CAADnVQKyXV8jHv2_0Sj2TcmWXwUsv+2Mm00pdCveRmNbWF5mXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for SYSCALL
 and TRACING program types
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 10:51=E2=80=AFAM Juntong Deng <juntong.deng@outlook=
.com> wrote:
>
> >
> > sched-ext is struct_ops only. No syscall progs there.
> >
>
> I saw some on Github [0], sorry, yes they are not in the Linux tree.
>
> [0]:
> https://github.com/search?q=3Drepo%3Asched-ext%2Fscx%20SEC(%22syscall%22)=
&type=3Dcode

Ahh. I see. Those are executed from user space via prog_run.
https://github.com/sched-ext/scx/blob/e8e68e8ee80f65f62a6e900d457306217b764=
e58/scheds/rust/scx_lavd/src/main.rs#L794

These progs are not executed by sched-ext core,
so not really sched-ext progs.
They're auxiliary progs that populate configs and knobs in bpf maps
that sched-ext progs use later.

>
> >> As BPF_PROG_TYPE_SYSCALL becomes more general, it would be valuable to
> >> make more kfuncs available for BPF_PROG_TYPE_SYSCALL.
> >
> > Maybe. I still don't understand how it helps CRIB goal.
>
> For CRIB goals, the program type is not important. What is important is
> that CRIB bpf programs are able to call the required kfuncs, and that
> CRIB ebpf programs can be executed from userspace.
>
> In our previous discussion, the conclusion was that we do not need a
> separate CRIB program type [1].
>
> BPF_PROG_TYPE_SYSCALL can be executed from userspace via prog_run, which
> fits the CRIB use case of calling the ebpf program from userspace to get
> process information.
>
> So BPF_PROG_TYPE_SYSCALL becomes an option.
>
> [1]:
> https://lore.kernel.org/bpf/etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh=
5bgnj@feoli4hj22so/
>
> In fs/bpf_fs_kfuncs.c, CRIB currently needs bpf_fget_task (dump files
> opened by the process), bpf_put_file, and bpf_get_task_exe_file.
>
> So I would like these kfuncs to be available for BPF_PROG_TYPE_SYSCALL.
>
> bpf_get_dentry_xattr, bpf_get_file_xattr, and bpf_path_d_path have
> nothing to do with CRIB, but they are all in bpf_fs_kfunc_set_ids.
>
> Should we make bpf_fs_kfunc_set_ids available to BPF_PROG_TYPE_SYSCALL
> as a whole? Or create a separate set? Maybe we can discuss.

I don't think it's necessary to slide and dice that match.
Since they're all safe from syscall prog it's cleaner to enable them all.

When I said:

> I still don't understand how it helps CRIB goal.

I meant how are you going to use them from CRIB ?

Patch 5 selftest does:

+ file =3D bpf_fget_task(task, test_fd1);
+ if (file =3D=3D NULL) {
+ err =3D 2;
+ return 0;
+ }
+
+ if (file->f_op !=3D &pipefifo_fops) {
+ err =3D 3;
+ bpf_put_file(file);
+ return 0;
+ }
+
+ bpf_put_file(file);


It's ok for selftest, but not enough to explain the motivation and
end-to-end operation of CRIB.

Patch 2 selftest is also weak.
It's not using bpf_iter_task_file_next() like iterators are
normally used.

When selftests are basic sanity tests, it begs the question: what's next?
How are they going to be used for real?

