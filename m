Return-Path: <linux-fsdevel+bounces-45132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9BDA73325
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 14:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59439175CBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 13:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6B6215F5F;
	Thu, 27 Mar 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rucCoEpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA72147F1;
	Thu, 27 Mar 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743081237; cv=none; b=nmOho+1L1imQilhtyO4S8cPLiNHbrdsGCxpHOAZCDxy3zRtfAmJ/ojkLsYrII1k9Q+W3iS0mPTXZVaTH+MefECXcuXWL8bq0ts855TlW1fyw2NHs4gQvz8HPVxBC5a6tZX6SnEADG1rAv8hSkaUXSUtwZxrx1cOwH7lr712y4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743081237; c=relaxed/simple;
	bh=fKz9pnQ+RHCIb1EIYOpjNQk9UHkPlQZ8YelVCnzImCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ed/A+/Wjt2/Rl79hcr4/tsoUPRhJ/hY7f8wxkUOeTj8mVbMlwqGASF2xjGugX54dhK8pIcttExhJQvjLGk4m8vXsf+l+kLjcfVwc5W1NGpIMRFCPz3Ix5uflbohCenbM76BUS+uulfL2xFvaB/D92k/5OKudDWRvhwI6wgtul+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rucCoEpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A54C4CEF2;
	Thu, 27 Mar 2025 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743081236;
	bh=fKz9pnQ+RHCIb1EIYOpjNQk9UHkPlQZ8YelVCnzImCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rucCoEpKD2uKA82npuUHc2IlG2oWnwqgT8U9tN8DMOP4U1dwkgyyYXgAIKPFMuNMW
	 Mr/rysi/pjy41dJOAzljBbZzg72+mfpEOGGzhjDTx6c9rxCGjmC5SMyEbWJ2N0+oWF
	 Xl99PlkGVupFWkqkqPnK/n7IH270nzZea0M/gmSRDQXN9qd9osa7eI+CFXdg5DLHuu
	 1M2pbO4Lh5olO8JonWgiuDrCf/0OvRFMkhALjgLziXzN6dyFchrENnGietvVrKXS4A
	 SEpLCltJiXG4chUafZNqd/4THrfGNnJIQszxbPkTKIenmMOlkgpgrOYysOf2geIYRL
	 xyGI4KognAkFg==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso9907195e9.0;
        Thu, 27 Mar 2025 06:13:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2rHYbsSoYALOqwNl+LyeGIXHPf/b7Hx5OBUC9w2azC9c0hEq6q1A7YV5CONjcTZstr3s/6TX/a6UGkaHN@vger.kernel.org, AJvYcCUAZCStn3bQIQUYHFT1ZJCZL8w4m3D4TXm/cKD9xLEaU19ACPf6+2AETge+UhwQdM/i/CXz34NZ0G6yuGVTesD3tA==@vger.kernel.org, AJvYcCUELgBhaY1jk7n9YD6L5IY6qRH7wKIPJogQZuZAAovzx2Hxyph/+wBrI47Hi8bhkHpnJPYkjsCKs+7yIgUIZS3oVIRf@vger.kernel.org, AJvYcCUKanLLvmZ4li3OmCWCyTCixdpqApDTm8nR/snTeCo5Op+Yxd82EC7fcdlLzTpsQQ9ZALMnYOaDioo4HD24@vger.kernel.org, AJvYcCUP7Xrb/zIIcggnQcvdZ8TB4HDO5kSh8uwhR1zsRpqeQ2Ha6rQ+puuAmcYw59f2CDJFMBZz2AlIUa2K0ig=@vger.kernel.org, AJvYcCUxp3BBaGBr7W2jzq/L/Z4K5KEl8JpV8JkBATkQuhmYLH85Otl6gI/xNDeWRb3iLQkZkf+U@vger.kernel.org, AJvYcCV9v2gSAeYHLCFpjTMYwr3Q8Iii79Ltmqrt2Oo/5jB2czj55HDLtIEqIQbHZ/+RXF8gyi/sbFqSmBvmpSkJBQ==@vger.kernel.org, AJvYcCVCESevdvNm+d0y4Ds0WJykCwDXTNJfvlMKnYVx/h6oqWPoVKScPEbQ05/hqFMStfPL/xA=@vger.kernel.org, AJvYcCVsaB84xARMIS68Iw6z+alSFQNFbRCP59YXqQ2sZLZkT6L5dcGrrmCcb2Xk/0wxH+ZBa7JMciFnw9Vw@vger.kernel.org, AJvYcCVxHoc2XCjDk2K1L++k
 q+O9OUEPuZzpQPFxOqLd/UO1CjJJOnLnfwg1Fu9uyN/wq6WDl7oDCpLNuumOEw==@vger.kernel.org, AJvYcCW/wzG9fxNKHDwf9sSRv3xZhNJT1qkhHhz62ydfz7gWaS1qtJDLExnbH5TQ45Tj/YaXSpLU/L/DwLONL6M=@vger.kernel.org, AJvYcCWBlybRWOtFWwx5OBsngOOrnh3lX9Q23VY4im+KeAoJx3+N+z56tKGnJ/MPLp7OnxcTgIEgMlHIrvZOtA==@vger.kernel.org, AJvYcCWX6DTFnzZ7QSVr2C+VWuqKNy7PGwytH/oTtLQHesYb6X8pEcXmw1K4y2tTKQX2CnngBZTkEe9VKtBzpBALTU2z@vger.kernel.org, AJvYcCX8Jur3EAlHTbMwSMiFh7/kUf/WygJAq9XTG62wVlkHNnMkMF2OrfE2QPEMZSG7BKNLeRELJPWQ@vger.kernel.org, AJvYcCXGfp0IFaSFKeXK20hDoElxEzViOGEO+egiBp0V9zAAlJalbatFhQiyF/nOWyZRgubAapPuLdC8W704QGg=@vger.kernel.org, AJvYcCXhrp3xcCkT7Vs6cJmniu4gWoeZW55jHPO0om4Od7XCqxD2Ch3rMPtT+eIZZ8xAeAPbahvaIdgMC4/1O1g4@vger.kernel.org, AJvYcCXujID1aVANCNeBM6SX7S7u6PPffTQq8mOPWcAKV2KHzXWLg6PvS7najW9J3LhOKeC+tePPTmmh2fcM@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3XeMuyGY6AFmN/pySrCXspUqGVyjqsc98fswN8ZoixDsLEe0
	BqBolDfMViEAo80nKs6eKGxseCJXtifHHgyDpO/Axn9vAtsgbLgh2CU7TXJh7DDKtGy4Goq63rl
	BCVtbcQJFY6Nr8nanYXtdfaEU77I=
X-Google-Smtp-Source: AGHT+IEY5BSiBwNXEMT+eJeprlWhvYaVjud2VavXTPTPRvbe/6IFqzcZmwQqb+uo+KChSyUJAdyAvfkgwaIRQv6W9xk=
X-Received: by 2002:a05:6000:1ace:b0:391:29f:4f70 with SMTP id
 ffacd0b85a97d-39ad17544e8mr3039357f8f.3.1743081235006; Thu, 27 Mar 2025
 06:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325122640.GK36322@noisy.programming.kicks-ass.net>
 <db3c9923-8800-4ed3-a352-4ee9ef79c0b7@app.fastmail.com> <CAJF2gTSHpZMyUk+8HL0=bevCd4XZYRAkrPM600qLPCKxG+bfrg@mail.gmail.com>
 <a9dddc3d-d03d-4614-9d55-1ce48c6ad5ef@app.fastmail.com>
In-Reply-To: <a9dddc3d-d03d-4614-9d55-1ce48c6ad5ef@app.fastmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 27 Mar 2025 21:13:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQtdKzq2Qc6s2qQs3pwMS79Re3vRY735kLM31qNFQD=rg@mail.gmail.com>
X-Gm-Features: AQ5f1JrgAJHOCdrriP16_V_QmEg1YQ85TRRC6Mrmapp2zXhvmV1mwcc9X_F3CrI
Message-ID: <CAJF2gTQtdKzq2Qc6s2qQs3pwMS79Re3vRY735kLM31qNFQD=rg@mail.gmail.com>
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

On Wed, Mar 26, 2025 at 2:56=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Mar 26, 2025, at 07:07, Guo Ren wrote:
> > On Tue, Mar 25, 2025 at 9:18=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Tue, Mar 25, 2025, at 13:26, Peter Zijlstra wrote:
> >> > On Tue, Mar 25, 2025 at 08:15:41AM -0400, guoren@kernel.org wrote:
> >>
> >> You declare the syscall ABI to be the native 64-bit ABI, but this
> >> is fundamentally not true because a many uapi structures are
> >> defined in terms of 'long' or pointer values, in particular in
> >> the ioctl call.
> >
> > I modified uapi with
> > void __user *msg_name;
> > ->
> > union {void __user *msg_name; u64 __msg_name;};
> > to make native 64-bit ABI.
> >
> > I would look at compat stuff instead of using __riscv_xlen macro.
>
> The problem I see here is that there are many more drivers
> that you did not modify than drivers that you did change this
> way.  The union is particularly ugly, but even if you find
> a nicer method of doing this, you now also put the burden
> on future driver writers to do this right for your platform.
Got it.

>
> >> As far as I can tell, there is no way to rectify this design flaw
> >> other than to drop support for 64-bit userspace and only support
> >> regular rv32 userspace. I'm also skeptical that supporting rv64
> >> userspace helps in practice other than for testing, since
> >> generally most memory overhead is in userspace rather than the
> >> kernel, and there is much more to gain from shrinking the larger
> >> userspace by running rv32 compat mode binaries on a 64-bit kernel
> >> than the other way round.
> >
> > The lp64-abi userspace rootfs works fine in this patch set, which
> > proves the technique is valid. But the modification on uapi is raw,
> > and I'm looking at compat stuff.
>
> There is a big difference between making it work for a particular
> set of userspace binaries and making it correct for the entire
> kernel ABI.
>
> I agree that limiting the hacks to the compat side while keeping
> the native ABI as ilp32 as in your previous versions is better,
> but I also don't think this can be easily done without major
> changes to how compat mode works in general, and that still
> seems like a show-stopper for two reasons:
>
> - it still puts the burden on driver writers to get it right
>   for your platform. The scope is a bit smaller than in the
>   current version because that would be limited to the compat
>   handlers and not change the native codepath, but that's
>   still a lot of drivers.
>
> - the way that I would imagine this to be implemented in
>   practice would require changing the compat code in a way that
>   allows multiple compat ABIs, so drivers can separate the
>   normal 32-on-64 handling from the 64-on-32 version you need.
>   We have discussed something like this in the past, but Linus
>   has already made it very clear that he doesn't want it done
>   that way. Whichever way you do it, this is unlikely to
>   find consensus.
Got it, thanks for analysing.

>
> > Supporting lp64-abi userspace is essential because riscv lp64-abi and
> > ilp32-abi userspace are hybrid deployments when the target is
> > ilp32-abi userspace. The lp64-abi provides a good supplement to
> > ilp32-abi which eases the development.
>
> I'm not following here, please clarify. I do understand that
> having a mixed 32/64 userspace can help for development, but
> that can already be done on a 64-bit kernel and it doesn't
> seem to be useful for deployment because having two sets of
> support libraries makes this counterproductive for the goal
> of saving RAM.
In my case, most binaries and libraries are based on 32-bit, but a
small part would remain on 64-bit, which may be statically linked.
For RISC-V, the rv64 ecosystem is more complete than the rv32's. So,
rv64-abi is always necessary, and rv32-abi is a supplement.

>
> >> If you remove the CONFIG_64BIT changes that Peter mentioned and
> >> the support for ilp64 userland from your series, you end up
> >> with a kernel that is very similar to a native rv32 kernel
> >> but executes as rv64ilp32 and runs rv32 userspace. I don't have
> >> any objections to that approach, and the same thing has come
> >> up on arm64 as a possible idea as well, but I don't know if
> >> that actually brings any notable advantage over an rv32 kernel.
> >>
> >> Are there CPUs that can run rv64 kernels and rv32 userspace
> >> but not rv32 kernels, similar to what we have on Arm Cortex-A76
> >> and Cortex-A510?
> >
> > Yes, there is, and it only supports rv32 userspace, not rv32 kernel.
> > https://www.xrvm.com/product/xuantie/C908
>
> Ok, thanks for the link.
>
>        Arnd
>


--=20
Best Regards
 Guo Ren

