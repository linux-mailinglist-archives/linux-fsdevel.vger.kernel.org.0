Return-Path: <linux-fsdevel+bounces-14037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E36876E7C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 02:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1ED5B21378
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 01:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6915E9B;
	Sat,  9 Mar 2024 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7tBfe1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9C12E5B;
	Sat,  9 Mar 2024 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709947426; cv=none; b=WElDS/EKqRjmz9/PKCz6aEQReV8K1QGEzMeXXzXt93Em7aSNkg0xOafTbRA/URbaLY2IfyQx6bdEVJSRurHwwqsFAFRzupU/xj3g4BRVP/4EHb7HSMitagrp9wuLMZMaM1oEVfEKp5jDRQSee7RDe5gF4Waf5Z3hRUu+Y/GEY+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709947426; c=relaxed/simple;
	bh=zCGj8BlVR14bB1JeMHbRXQzBaaC9CW2Gp3Uo0KDR9B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4NtaOclF11p5Mnkg5jIXPbZ1+vvjpLB047wTE3BjER1eHL4HlXbo5vPJnc5KiDe8b+T94hEUPqxS1KBwFPROBe2uTHO4aXwB/34Xja/MhXf0k6UpsfzVWlFQduftU7CMBZU775tLnbVWSlpAlV7cpUkTq0gPWk8rS8Chv8WstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7tBfe1I; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e7ae72312so588457f8f.1;
        Fri, 08 Mar 2024 17:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709947423; x=1710552223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCGj8BlVR14bB1JeMHbRXQzBaaC9CW2Gp3Uo0KDR9B4=;
        b=R7tBfe1IpMq+lJAMgFtQi728wlqoIyi4t3MWZyEh9ydMdK/nqCObQIWfAYwbUqzVL3
         OwJqVIuQS/pCPyWO4Y8nsxHVnkRJEtP2e5yvT7bbUBAVFP/RKvkMjlM/rz5u0/dE1NC3
         xFoyZEXizw5BwQBjnfrEYqG0WcyEvv2R0d59O5IUpJBuTsnBN3rcPh8KIJM1ubAxfh91
         egPFF0Gqkp2e1v3yDX7625fAuiDaYl/8ghNTFZTmaxViyNm4LN5h9lMvcbjn5a2lSYeq
         to3ypBQoPA9iqbu6HluLtJyR2JHFLAWDnyf+YXtDJsJKnQ6+h05gakVpWNER4cpJJLY4
         3qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709947423; x=1710552223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCGj8BlVR14bB1JeMHbRXQzBaaC9CW2Gp3Uo0KDR9B4=;
        b=B/ZMa55Cd0rha1Co6z/CCmPNAirM98a+QoAy0us7zUrY//hXKelm0b2ONXjj7NpJb3
         kGz0W/FArhFWSYa85Xt1EC+wSDPlBbbB/bIdALrdY9tE/4TE365hH1CB+n0PFp4anP4j
         UDwTyrldvzwpi+Yk7IgshHG2tTa2FUatHgx2dWWI2JktGciIFXj7TzUtvXRVvvgrgK17
         seVXBXv9OK6X5z2XUhZIkfElcNmDaPPnYitxRmZxacxEDnIWJpkRgV4UtNQdONGafn8z
         nuW5V9R6yHS7FbIqiTYoJ208fJ+bkeKdoXNLBxxVTguIVYNHh3TzCFhkP/Amp5caGvx7
         kvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAhGuSZv8UE0RsF/tK89+LYGRvfnnttTy83NNrv6adUTA7JN3NCtM/x6PG36lT8+J+FoYMiHv/hdw+W+4TtykihhaZmq89q6S+AYSzXFzb/HgxbNNuuTh1xb+ixdmI/jZTNWF/E8FhTQnpFRrbwXMwHdGC93eUE6idcSkMCjIyMyY0ttYoBi5jmQ==
X-Gm-Message-State: AOJu0YzGY97edCl2g0bzQFzXQTKLE853XtFwb3z9AfeaKssK9v2V6Nh5
	1e7OZ0F4lPhe71I8esM9rSiiraYsVFePvjArCgl3BVTxL3OmfCZjkjyOxvsqoWgtMYn8vO/yVgy
	F9ioBxHmpySpGAvlkxK6uHaczoV2GnHiwj58=
X-Google-Smtp-Source: AGHT+IFD384mKLi9tiE8oMVelWsJF8EntROLIMyoUiTfWkm4n9EX1jPko7YklLovHGv49yMPVN9cCCBfsiYXtyxSNqE=
X-Received: by 2002:adf:e392:0:b0:33c:e396:b035 with SMTP id
 e18-20020adfe392000000b0033ce396b035mr370928wrm.69.1709947422550; Fri, 08 Mar
 2024 17:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709675979.git.mattbobrowski@google.com>
 <20240306-flach-tragbar-b2b3c531bf0d@brauner> <20240306-sandgrube-flora-a61409c2f10c@brauner>
 <CAADnVQ+RBV_rJx5LCtCiW-TWZ5DCOPz1V3ga_fc__RmL_6xgOg@mail.gmail.com>
 <20240307-phosphor-entnahmen-8ef28b782abf@brauner> <CAADnVQLMHdL1GfScnG8=0wL6PEC=ACZT3xuuRFrzNJqHKrYvsw@mail.gmail.com>
 <20240308-kleben-eindecken-73c993fb3ebd@brauner>
In-Reply-To: <20240308-kleben-eindecken-73c993fb3ebd@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Mar 2024 17:23:30 -0800
Message-ID: <CAADnVQJVNntnH=DLHwUioe9mEw0FzzdUvmtj3yx8SjL38daeXQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@google.com>, 
	Jann Horn <jannh@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 2:36=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
>
> These exports are specifically for an out-of-tree BPF LSM program that
> is not accessible to the public. The question in the other mail stands.

The question was already answered. You just don't like the answer.
bpf progs are not equivalent to kernel modules.
They have completely different safety and visibility properties.
The safety part I already talked about.
Sounds like the visibility has to be explained.
Kernel modules are opaque binary blobs.
bpf programs are fully transparent. The intent is known
to the verifier and to anyone with understanding
of bpf assembly.
Those that cannot read bpf asm can read C source code that is
embedded in the bpf program in kernel memory.
It's not the same as "llvm-dwarfdump module.ko" on disk.
The bpf prog source code is loaded into the kernel
at program verification time for debugging and visibility reasons.
If there is a verifier bug and bpf manages to crash the kernel
vmcore will have relevant lines of program C source code right there.

Hence out-of-tree or in-tree bpf makes no practical difference.
The program cannot hide its meaning and doesn't hamper debugging.

Hence adding EXPORT_SYMBOL =3D=3D Brace for impact!
Expect crashes, api misuse and what not.

While adding bpf_kfunc is a nop for kernel development.
If kfunc is in the way of code refactoring it can be removed
(as we demonstrated several times).
A kfunc won't cause headaches for the kernel code it is
calling (assuming no verifier bugs).
If there is a bug it's on us to fix it as we demonstrated in the past.
For example: bpf_probe_read_kernel().
It's a wrapper of copy_from_kernel_nofault() and over the years
bpf users hit various bugs in copy_from_kernel_nofault(),
reported them, and _bpf developers_ fixed them.
Though copy_from_kernel_nofault() is as generic as it can get
and the same bugs could have been reproduced without bpf
we took care of fixing these parts of the kernel.

Look at path_put().
It's EXPORT_SYMBOL and any kernel module can easily screw up
reference counting, so that sooner or later distro folks
will experience debug pains due to out-of-tree drivers.

kfunc that calls path_put() won't have such consequences.
The verifier will prevent path_put() on a pointer that wasn't
acquired by the same bpf program. No support pains.
It's a nop for vfs folks.

> > First of all, there is no such thing as get_task_fs_pwd/root
> > in the kernel.
>
> Yeah, we'd need specific helpers for a never seen before out-of-tree BPF
> LSM. I don't see how that's different from an out-of-tree kernel module.

Sorry, but you don't seem to understand what bpf can and cannot do,
hence they look similar.

> > One can argue that get_mm_exe_file() is not exported,
> > but it's nothing but rcu_lock-wrap plus get_file_rcu()
> > which is EXPORT_SYMBOL.
>
> Oh, good spot. That's an accident. get_file_rcu() definitely shouldn't
> be exported. So that'll be removed asap.

So, just to make a point that
"Included in that set are functions that aren't currently even
exported to modules"
you want to un-export get_file_rcu() ?

Because as the patch stands today everything that these kfuncs are
calling is EXPORT_SYMBOL.

