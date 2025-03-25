Return-Path: <linux-fsdevel+bounces-45049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85756A70BC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 21:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A11189A98E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 20:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CB26658D;
	Tue, 25 Mar 2025 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OXql/SFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9541A9B24
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935724; cv=none; b=WjzfdGGWENyO2d1yHnD//k9yNOtwNXLif5/U4G6g0AFJyVLMm0TvrUUFzHPUrjin4DY8Cl1x848wMhorn4UpxZJAJEr0Sj0kp/0U4VCeXMtX04xlkye/29kppoiQ0wmCx/mOLobE+PO/Unf27NbwnQueYe/yXE2RkrIBxAH7QQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935724; c=relaxed/simple;
	bh=GCAhGVtueceq1ubCUXU7aIifbCxnCpAKEuI8oUAtt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8ChJL0LOeGmOOsq3RBLgB5+/BY0moSZINvqQnSgZLzwhuCn68/lfSSfCvBkJEuaq8mqF6tpuFHpUJVGWbfE9sAQZniQAVFaPd2pBJ9Y0+THpLM8+LJ5sNJINp3HwFX3eK1qZCqEjD13SqWa0REsfNY3orhDBaUZAZDunug7MNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OXql/SFD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso58937281fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742935720; x=1743540520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=OXql/SFDRLMwCdERdfNPebO6I0RO3Gam8W/rNVTiB3VRltzL7hQ+5mkDtnggUgI+Bs
         ypI22mod9X7CnGoMW+9Z2qiwe6iw1Ixv/yoKEDTkOUFPcaIkzd3ggscs7GwBYo74hEde
         ulqh8ZkxtLBXHQ4vcJhguZlY/g9GAmmuR0sMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935720; x=1743540520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=Axq3mSYwAMEx0eGNIEZS5ElnGKKqBG1S4x3vQ4ZDSQNABXisaNSEzZwtRse75rrN+4
         Qvat6InAwbvcav8yb8tCIDAxux7swgv9NZ3YdeXPCwMBI7RGWy6Nt8MiQCWr0T3qpw86
         orgir1M1MUMvyuzVyj1dmjdHn2EL1k1ieCgzI7jzBa/6aucQuGIB7U9DkoJO/j4KVQxy
         j17Dq72VCI7dWkPURNBv1B6YhvP3kZ86MjupW8kxvYo1KSmPqEMDzaIcuppA1ECnKWVP
         uGiNO/Y+UCvETLSijG8yQ2kdXI61pogcH+UgiOSt6v0WmtIySqkc9zw+hT0E8xy7aCZQ
         JWsw==
X-Forwarded-Encrypted: i=1; AJvYcCVtGrbtXRBiVMQbAGlKbxmo1s6yB2b1L9Dw4rtZitOdieIaVvhz8n7tvWZZRGywNuKVyGiuVVQtZ14KOuBZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4mFXvcgjUhHnp26rgBrTAEDtEyFqqL/XsZBGtTU8jA+G3HhF
	pPBiEcVjFJdkHbjnu42Um2BtOdlmWQs8jD/WK47OFS6SZRTZ43fii6m8xwXkPQ6oLTYUmZLls6o
	jvN5i0Q==
X-Gm-Gg: ASbGncs/CRHpUBAPp+VNj6PZwG3BExlvZCeBPmOgqH0GJojr36gz39ZrXnWUA3liLiz
	Pb//sqPdX2y5NKoRPWd0YQ6bn6cicnqmBpEx/O6OrCPEGSQ9sytJmQSYY2ZV9j4SRisX8YiHrYy
	js23cVmEMW+QhTVqrQ8NnKyHqi1KTz4jwe7T2Ks7qCzVvowsehlQoLsgd5aYVplC7febcVFDafe
	hk5QeO5R96uu208urrMG16FvI6q6vKQgpf00CqbM6BUa9KWbOTlydFXjCJEhTp4jvm7QYIu3a9f
	wZWWSPLi/seo+l3fSET1k9kOxX3pSvFkM/c8iTPUIBWzXd7Lu3Cqo3EohQhKmGTDBBaNEXSOl5X
	7qp7M9GoQt/6P68V/3GNZsOfsjwBdsg==
X-Google-Smtp-Source: AGHT+IE0jC2Q/kSx4ZuiCMgaMkRNmIFpv1f95OnozIN2HZrAUD+eSQkYBoM1iRfC6pmr4zjXyFagJw==
X-Received: by 2002:a05:651c:b0f:b0:30b:d63c:ad20 with SMTP id 38308e7fff4ca-30d7e2ba2aemr74332951fa.24.1742935720352;
        Tue, 25 Mar 2025 13:48:40 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d910e70sm18659271fa.105.2025.03.25.13.48.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:48:39 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54af20849bbso2160681e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 13:48:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLTp4TtQVuGBr1yeeld6kv4LBFCtBmxv8gboG2jKZOGMwTGM47xIamGtFG8ZbwE/wxjavGOK14tWMmj5T8@vger.kernel.org
X-Received: by 2002:a17:907:95a4:b0:ac3:48e4:f8bc with SMTP id
 a640c23a62f3a-ac3f27fd3b3mr1859596466b.48.1742935307883; Tue, 25 Mar 2025
 13:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
In-Reply-To: <20250325121624.523258-2-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
X-Gm-Features: AQ5f1JpwFc7ifwGuAhyrs4E5qPgHx1McCR38KFycRhkLFRMKTveHrmoaWi4zba4
Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
>
> The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> leverages the lp64 abi Linux interface. Hence, unify the
> BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

No.

This isn't happening.

You can't do crazy things in the RISC-V code and then expect the rest
of the kernel to just go "ok, we'll do crazy things".

We're not doing crazy __riscv_xlen hackery with random structures
containing 64-bit values that the kernel then only looks at the low 32
bits. That's wrong on *so* many levels.

I'm willing to say "big-endian is dead", but I'm not willing to accept
this kind of crazy hackery.

Not today, not ever.

If you want to run a ilp32 kernel on 64-bit hardware (and support
64-bit ABI just in a 32-bit virtual memory size), I would suggest you

 (a) treat the kernel as natively 32-bit (obviously you can then tell
the compiler to use the rv64 instructions, which I presume you're
already doing - I didn't look)

 (b) look at making the compat stuff do the conversion the "wrong way".

And btw, that (b) implies *not* just ignoring the high bits. If
user-space gives 64-bit pointer, you don't just treat it as a 32-bit
one by dropping the high bits. You add some logic to convert it to an
invalid pointer so that user space gets -EFAULT.

            Linus

