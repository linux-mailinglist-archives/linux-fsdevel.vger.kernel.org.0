Return-Path: <linux-fsdevel+bounces-45060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85665A7106B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 07:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB0E3BB954
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 06:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B64190678;
	Wed, 26 Mar 2025 06:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nco888oV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E484161310;
	Wed, 26 Mar 2025 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742969282; cv=none; b=domLtPSzT0iHWoIhcDXwCm3Tew+dJRTFFj+eAvcLDaC/T0jxBgCN8BhGEPIBQjBWzufcp3MG/MdnDc74KEiUlvD9d3WT/m8sHb3+0gcAGug9KxjqeKxEqr2ZpDcSZCqvJDRPG68xzRWndbgBMnXjerw6KMLCKCFz2E98Hr+cu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742969282; c=relaxed/simple;
	bh=17ilzGvreeHm226kkfQPsyEFUeLiEMTwZ00oVMu8jpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W48BeqGsZ1t2fUTAFQgCKXQAJ2D2lsLPkia/1cEjjgkwUj1AtGXhZAh1J3pzEbi7BmbP0oCB6bkBZLaLOo1eDGFGtfruvav4HfVS0f4ntMYrBHUkByzROm8nICeEV4vSMYiZWGRtrTJfYo59dvB0+s1193+xM5VWnkmkVcMOa2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nco888oV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A181C4CEE8;
	Wed, 26 Mar 2025 06:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742969281;
	bh=17ilzGvreeHm226kkfQPsyEFUeLiEMTwZ00oVMu8jpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nco888oVkpWvjjpmwWCThvxb1AtfGv+uxSw1N4XjTkec3DRuVqc8KPvc5gyVt3uyU
	 IV7JpaJMp0N1G9bNlo7QCS6M3AKZni7g3eSBUqYTCiax5dYr0YNhkTLa/iLtyFs7Wv
	 HtMjo1vjIyvsz1Ery/OFJdGpHbx7zWh4Jt/U+jmcfT2/psOB/aVWJLouBgMnlcLXxi
	 iQ6JWvJv52TlmS30JjLarPhhTiwvQVU+efwiS9Qj/9tY8Xh5NXnQExI9PhYTcscXed
	 SkD/3WaA4QEW7XPf0f3AnBRtjzDT5qFOrBTZk3J5UH2yTDn5Ts9Hsd2ScdykbJt4y0
	 tZfx12/Kj/UNA==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso29092765e9.3;
        Tue, 25 Mar 2025 23:08:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9kzT6BA6N6h87+Q5LlLgA6p87ybvkMC/+e6djgPiK1RymMroREloorw/Bntec6btNgNgetZU17M232IILkfIymvwb@vger.kernel.org, AJvYcCUVbdDsIGoZW4wbdqY4ExqKrN3GTpoOcnacZnfw+W/I8chaKcML5lVDxfc3oGE8dDMoIYxX+HsgFQJR@vger.kernel.org, AJvYcCUWFLdwe7lwdhY4QVROCbCYd3X5Z75wXRkc7rXh8Bb3MOQ/iX5hTefzd/uDQlQ6heWvo5SUOXpw+VWsHlw=@vger.kernel.org, AJvYcCUWVjZ3XPlrA7jPuJO8ObPIUkTqtojM3OAsLCv2ThaZeZOa1bWTc73BR2xmka/oT7upCfxC+jsXFSr6zaE7eBTa@vger.kernel.org, AJvYcCUXji1jIuFBG6161oCJDbIuWuOxiDghQbqsLh62XdF9sHT+YbtdOoFZu+cG3tZhdnYCFbqShie1ZbHRKorn@vger.kernel.org, AJvYcCVSSdzgOS1NRSOcHWRW3oVXx0h0/oTMccv6aez6FZny6stDw6CTkFz16OVdZUpx7iH9sYfKcWMkV0Ax+JE=@vger.kernel.org, AJvYcCW8dLA624cklmFoAEYOpSyGC8lEOBINpemT7x+eOHFqcBFx5qmqTxSclGVFBbZXyGf3D6cWYlO1@vger.kernel.org, AJvYcCWKmmi1flBpuF3G+U6llD8mK4tVWwRfZArstzUSyuicvzdNx/JjMVVaJ8ZqbXd8rYRL2W39AqTX47KJ@vger.kernel.org, AJvYcCWSFXTNbfuLsPiAFx9hNmQ2Rg5+J9l6zBhAUzyqM62EWaWk/3MROgU9CLU+f1wcdGmfUskw@vger.kernel.org, AJvYcCWg5lo1ykuKBd9P8pLYG73yQb1q
 Njce0a/X3l4B+PcuIo7oZNsbWAvO38qA2S93fa4Bxpc=@vger.kernel.org, AJvYcCWlW/LFGElA26cSvMh5T2iUC4aAUqhgQ2QFusESKPKBIoSskwH7jjFtNn9AlU/HjDY29U9R7RCVPuU4hq4U@vger.kernel.org, AJvYcCWpjFEH9caShLPBc82kAI+KcbKOGDEvIR1UJ8N80RNns+V3DB54VBhnQC2CH3K/TuWHpgLgRxggi+yyD3TKPYAbig==@vger.kernel.org, AJvYcCWtl9TLsEYQyGtNQXjn0maTH/39t12gRR0DG7xVAuerstxRSuTXmZ7FmUZ5K/hJzy0QWx6YoMbaSmoRO38=@vger.kernel.org, AJvYcCXNYiqJuDYuZM0K38V1+gcnPcGpq6UDCwA6IKtUjBX8cI6qw6s5sDNduZy7vb9yLVFrjlZK1B2O5CDPPg==@vger.kernel.org, AJvYcCXR7x5G2gD1h/by+2WZSf7P5ZBqK431BkanWVf5fhQeAzIc9Y9w7R3OijTuglyPQCrUOszHGUjqsPfl6Lzn@vger.kernel.org, AJvYcCXYSHeE+0Gt8yLx89rxydHM8RwlmmB7Ygw17ELraN10jyl64fQFCh3sGcg9m1dsYd4+e/o/lz98rnrMFQ==@vger.kernel.org, AJvYcCXoo9sNwuUeUMHbqZtyAOo6Tw2gCN+1pRzUcCsAz7zyyPaEAF1/2sN/2RPsAIeBnbSfhMxzckn0o0f4EfWAXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrNvgQ4sY2SyaFmXOIzWsOqjvA8XC9s2ct7PrwYX2cHCUovBuT
	k+97K0wcz6PnrXIJRcnet1ccY9x+uRY0ikHO2UpmBuzyAj8und5YCwGZXKddIlDKJxJ3kg/rHL+
	dDJ2u5APrOBCm+5G8XtZIcjUdNy4=
X-Google-Smtp-Source: AGHT+IEuIFNoPjN0AZZplDS08UZSXPKtCbe3v92zS/QV8r4A1uiHzUqZnFSHaB3urAWjtmc7YALAB9tDHWY70m3ocVw=
X-Received: by 2002:a05:6000:1fa7:b0:390:e5c6:920 with SMTP id
 ffacd0b85a97d-3997f9008c2mr16208871f8f.3.1742969279888; Tue, 25 Mar 2025
 23:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325122640.GK36322@noisy.programming.kicks-ass.net>
 <db3c9923-8800-4ed3-a352-4ee9ef79c0b7@app.fastmail.com>
In-Reply-To: <db3c9923-8800-4ed3-a352-4ee9ef79c0b7@app.fastmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 26 Mar 2025 14:07:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSHpZMyUk+8HL0=bevCd4XZYRAkrPM600qLPCKxG+bfrg@mail.gmail.com>
X-Gm-Features: AQ5f1JqPvj-l64SFz6C-IoAkuirA5RSoM_MAB1hbvMnwwKSuwLAnDrMsa14MaDw
Message-ID: <CAJF2gTSHpZMyUk+8HL0=bevCd4XZYRAkrPM600qLPCKxG+bfrg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 00/43] rv64ilp32_abi: Build CONFIG_64BIT
 kernel-self with ILP32 ABI
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Eric Dumazet <edumazet@google.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, Drew Fustini <drew@pdp7.com>, 
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, ctsai390@andestech.com, 
	wefu@redhat.com, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Ingo Molnar <mingo@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Xiao W Wang <xiao.w.wang@intel.com>, 
	qingfang.deng@siflower.com.cn, Leonardo Bras <leobras@redhat.com>, 
	Jisheng Zhang <jszhang@kernel.org>, "Conor.Dooley" <conor.dooley@microchip.com>, 
	Samuel Holland <samuel.holland@sifive.com>, yongxuan.wang@sifive.com, 
	Xu Lu <luxu.kernel@bytedance.com>, David Hildenbrand <david@redhat.com>, 
	Ruan Jinjie <ruanjinjie@huawei.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, qiaozhe@iscas.ac.cn, 
	Ard Biesheuvel <ardb@kernel.org>, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 9:18=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Mar 25, 2025, at 13:26, Peter Zijlstra wrote:
> > On Tue, Mar 25, 2025 at 08:15:41AM -0400, guoren@kernel.org wrote:
> >> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >>
> >> Since 2001, the CONFIG_64BIT kernel has been built with the LP64 ABI,
> >> but this patchset allows the CONFIG_64BIT kernel to use an ILP32 ABI
> >
> > Please, don't do this. This adds a significant maintenance burden on al=
l
> > of us.
>
> It would be easier to this with CONFIG_64BIT disabled and continue
> treating CONFIG_64BIT to be the same as BITS_PER_LONG=3D64, but I still
> think it's fundamentally a bad idea to support this in mainline
> kernels in any variation, other than supporting regular 32-bit
> compat mode tasks on a regular 64-bit kernel.
>
> >> The patchset targets RISC-V and is built on the RV64ILP32 ABI, which
> >> was introduced into RISC-V's psABI in January 2025 [1]. This patchset
> >> equips an rv64ilp32-abi kernel with all the functionalities of a
> >> traditional lp64-abi kernel, yet restricts the address space to 2GiB.
> >> Hence, the rv64ilp32-abi kernel simultaneously supports lp64-abi
> >> userspace and ilp32-abi (compat) userspace, the same as the
> >> traditional lp64-abi kernel.
>
> You declare the syscall ABI to be the native 64-bit ABI, but this
> is fundamentally not true because a many uapi structures are
> defined in terms of 'long' or pointer values, in particular in
> the ioctl call.

I modified uapi with
void __user *msg_name;
->
union {void __user *msg_name; u64 __msg_name;};
to make native 64-bit ABI.

I would look at compat stuff instead of using __riscv_xlen macro.

> This might work for an rv64ilp32 userspace that
> uses the same headers and the same types, but you explicitly
> say that the goal is to run native rv64 or compat rv32 tasks,
> not rv64ilp32 (thanks!).

It's not for rv64ilp32-abi userspace, no rv64ilp32-abi userspace
introduced in the patch set.
It's for native lp64-abi.

Let's discuss this in the first patch thread:
uapi: Reuse lp64 ABI interface

>
> As far as I can tell, there is no way to rectify this design flaw
> other than to drop support for 64-bit userspace and only support
> regular rv32 userspace. I'm also skeptical that supporting rv64
> userspace helps in practice other than for testing, since
> generally most memory overhead is in userspace rather than the
> kernel, and there is much more to gain from shrinking the larger
> userspace by running rv32 compat mode binaries on a 64-bit kernel
> than the other way round.

The lp64-abi userspace rootfs works fine in this patch set, which
proves the technique is valid. But the modification on uapi is raw,
and I'm looking at compat stuff.

Supporting lp64-abi userspace is essential because riscv lp64-abi and
ilp32-abi userspace are hybrid deployments when the target is
ilp32-abi userspace. The lp64-abi provides a good supplement to
ilp32-abi which eases the development.

>
> If you remove the CONFIG_64BIT changes that Peter mentioned and
> the support for ilp64 userland from your series, you end up
> with a kernel that is very similar to a native rv32 kernel
> but executes as rv64ilp32 and runs rv32 userspace. I don't have
> any objections to that approach, and the same thing has come
> up on arm64 as a possible idea as well, but I don't know if
> that actually brings any notable advantage over an rv32 kernel.
>
> Are there CPUs that can run rv64 kernels and rv32 userspace
> but not rv32 kernels, similar to what we have on Arm Cortex-A76
> and Cortex-A510?

Yes, there is, and it only supports rv32 userspace, not rv32 kernel.
https://www.xrvm.com/product/xuantie/C908

Here are the products:
https://developer.canaan-creative.com/k230_canmv/en/dev/userguide/boards/ca=
nmv_k230d.html
http://riscv.org/ecosystem-news/2024/07/unpacking-the-canmv-k230-risc-v-boa=
rd/

--=20
Best Regards
 Guo Ren

