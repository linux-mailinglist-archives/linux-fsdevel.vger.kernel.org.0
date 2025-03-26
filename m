Return-Path: <linux-fsdevel+bounces-45062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14795A710A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 07:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EF0175D3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 06:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F2219994F;
	Wed, 26 Mar 2025 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqWCSEWg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49F15381A;
	Wed, 26 Mar 2025 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742970889; cv=none; b=rc9ipidDLJ1K1tCNBOxyi5M37nQpYbh/5+j+1GkaeCQWxePYK0PHuWwQ//gg2tjT8jWGVylJbhEy8VO+Kfaqi6H0EZLukBNvI9PtQWPYDPmYNHxAzij0dDfTnR0GGTtZQBn9FGUFUjY/eclfJEPZR49LUu1VWNB6CJV6ZoxavaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742970889; c=relaxed/simple;
	bh=2MGPnAtzDlcfNFkgrjhcbs+PSZK/71xFqiqfm4ICurw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1BwKyi41vq1bPoormQrP6RfW1WVndmK57FDr+17ZZ+F/MUx/p7rjhG3S8tCxsdTW+QOY8yMe9sUqX+ODXpLBlHsi4BVKiW1lcTtFMt1MKvdEzI+lB3LMkgDb++lOneohVJXnX82tGXPvClW90H2mIniMavmF/sE5YKdh6+usR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqWCSEWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E46EC4CEFD;
	Wed, 26 Mar 2025 06:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742970888;
	bh=2MGPnAtzDlcfNFkgrjhcbs+PSZK/71xFqiqfm4ICurw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oqWCSEWgqSzuZihIGSGxBq/NFjOUhZjOlwZMMZY+/2ybNPO86h100+06K+NuCc9Mt
	 WYnoiWB1I5d60B7CRE6XuosOocePqX6eDdBEP/8SE+DYlhSfcxkLZF9LrlQ68Y4veL
	 H8xWmZsln8RTeTMzlPXP6pl8crUOBBsMQcncsHm3UJYg5K3kU3IXi4FH/Qc4qv2wOO
	 yEJnquI42uVFFeIsvvRh3GMWQ+sFTb7U/WMNtlSVXjGbMeRckEm9GTcI5P7A0b/Ro3
	 nMSrwoZKByN/PZoX2e4Jn/Y5mLcclU97Oe6eskkQTsOcmnMnijIJvWokjpBxxC2uqF
	 n5hVyTRxxXDfw==
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913d45a148so5217717f8f.3;
        Tue, 25 Mar 2025 23:34:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0Z8fFKCF0vRhplQweEWYJYb4VDCWeUT4Bm1nCypoBk/n/uxsih6rHY58p6FeUcq+Wry1k9YuiK8p1@vger.kernel.org, AJvYcCU4GAChg4xxzAN3U6zdOKIqvtxfwHDLeuD2G5iqstMAIST5NKH7KjJxH5D7n8szeHjoA9LEIoZYfkCwTD+G@vger.kernel.org, AJvYcCUFkl+fLz2Ty4CUosoSsnoduEM8NcjlVOBB+wGeVVmhTCeluHI1NGAUhGT93dGFpJMBhk0kncI9ONob2JmU3K3D0g==@vger.kernel.org, AJvYcCULDFP2m8ArapfMbFHal25WKy2OQVT9dJFZNasejpHyPNDdlsIs1MfY6E262dno7+4xhui7b5SlOUfwGyyFk5b1@vger.kernel.org, AJvYcCUUsJfP0jLy3Jsw7aPbOSO8BKLtCSp+frnkq1Zls74YGFbVK6DtCKcjZNkFxTvGvDf5GObi5jPz/0EN@vger.kernel.org, AJvYcCUXr2P3qruuhJlosLngrSNHmvD70TBKJ6pnDElYTRlILCHOlPsQMooFdVGO2HAxQno3vDd8NzUmw3O/cuA=@vger.kernel.org, AJvYcCUZj9Pcy+b/+sBQHNmT0l0jL2Qw7x5GePbmuQH5lvxOggSGbmLq2ac+ILT5GNh/RW0fgUi5DkgxyoCUCA==@vger.kernel.org, AJvYcCUdyhsoB72OG79gi1NoOaqP78cOx+RMBeV0OLOvNFYEY5F3t33sbho+EKNBRc+LJ0xVKy6rEaX2P/XtYSk=@vger.kernel.org, AJvYcCUv+aZYOjNJCQBrjBYu2lhDf6McfFEOyLeTxcqAZLVC7XBo3afNbKcgvseKWbNSZMPihiT1+KKpw3zrWXI=@vger.kernel.org, AJvYcCV3puId
 FA0KYAx327zBT/qFJcQ2dbJ7yxWunHB4vyO8kYVhtxsM42JSRNPrHb6ncDmiu83N@vger.kernel.org, AJvYcCVKvsdgscn4uqo6A/K28+75ZkFcH53m5a3RN7f9ysrXqDH155/YZuaO1ixmgv1ZO6RUNbKT/B0Y@vger.kernel.org, AJvYcCVguDGFLvtm/rcALP/PZ5+JqxAGWr/Z5FFnnkGQXwQeBRYpwVLDdyTK7ntwruahdlxwkzY=@vger.kernel.org, AJvYcCWCMyj1EvsfYGiSabQwTiT7uvTmasRiKXCDGdJ2HG6KIxn8nCMbQpW791eGMWH3g4iCnnbtk/yOM+SOTDVpKiWugrAb@vger.kernel.org, AJvYcCWEqtQIvpooCRV44g/lVmuuKDjUO/tE0l1IZGYe8b77mdtTRqrYT6msUdpnF7Me4UTdHrHSIdyuJ8LXmw==@vger.kernel.org, AJvYcCWPx+zO84CE/K6pV+HY5Ri9Z0F2AqInOdTtFBqiosG9yGtbL1jRWZ/EHQi0aUtXXcjsYQDBDokXAPltC3V2fg==@vger.kernel.org, AJvYcCWn0O9iCTJ9d/OvkKxW/Eh1PkNijLdm9bnrMSApgfS+yDT9xod9Du3vVK80Z6CoznHnPh+0d77p1rvpLsyw@vger.kernel.org, AJvYcCXmzcG79gR7jXjdwHfzZVXx+XUq+ZcO5IQljshTRFINu9zIzWvy0NnPErfx8A5/+Uv4wq8V5bpZVytIugLs@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRDEZMjBSsppymsMoksIPjPv0rlVGrfIct04Ab/4Ug7QBY8St
	bIVe21apUi5Bk6svytNeUK5qMJ0xgJJsi2cTcTkn0+HZojxoRXUcbw0No1yyLbGjddk7HqdRzne
	kxb/9eVlCS6QwWzfVxO2b1dJrd08=
X-Google-Smtp-Source: AGHT+IGIApydo9VgmdhIDcmOnmG1sSv1FEEmzeINRVbJ26tbvLOq+REJlE+tfl+WofDYebAF8b+RY6kbO+n3ISps8p8=
X-Received: by 2002:a5d:47c6:0:b0:38d:d371:e04d with SMTP id
 ffacd0b85a97d-3997f937cd7mr16526330f8f.34.1742970886849; Tue, 25 Mar 2025
 23:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
 <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
In-Reply-To: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 26 Mar 2025 14:34:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRZyAAgrM1RMrTi7Zi+Vx_VBnM1=CWwZZtLy+uHZ=vZpw@mail.gmail.com>
X-Gm-Features: AQ5f1JpGXhmRPDvCQOc_Kwk_PFeqm824JtKAYEkQji0TkGjMeyznsoqjkxAkPig
Message-ID: <CAJF2gTRZyAAgrM1RMrTi7Zi+Vx_VBnM1=CWwZZtLy+uHZ=vZpw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: Linus Torvalds <torvalds@linux-foundation.org>
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
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 4:41=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
> >
> > The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> > leverages the lp64 abi Linux interface. Hence, unify the
> > BITS_PER_LONG =3D 32 memory layout to match BITS_PER_LONG =3D 64.
>
> No.
>
> This isn't happening.
>
> You can't do crazy things in the RISC-V code and then expect the rest
> of the kernel to just go "ok, we'll do crazy things".
>
> We're not doing crazy __riscv_xlen hackery with random structures
> containing 64-bit values that the kernel then only looks at the low 32
> bits. That's wrong on *so* many levels.
>
> I'm willing to say "big-endian is dead", but I'm not willing to accept
> this kind of crazy hackery.
>
> Not today, not ever.
>
> If you want to run a ilp32 kernel on 64-bit hardware (and support
> 64-bit ABI just in a 32-bit virtual memory size), I would suggest you
>
>  (a) treat the kernel as natively 32-bit (obviously you can then tell
> the compiler to use the rv64 instructions, which I presume you're
> already doing - I didn't look)
I used CONFIG_32BIT in v1 and v2, but I've abandoned them because,
based on CONFIG_64BIT, I gain more functionality by inheriting the
lp64-abi kernel. I want the full functionality of the CONFIG_64BIT
Linux kernel, which can be equivalent, used interchangeably, and
seamlessly.

>
>  (b) look at making the compat stuff do the conversion the "wrong way".
>
> And btw, that (b) implies *not* just ignoring the high bits. If
> user-space gives 64-bit pointer, you don't just treat it as a 32-bit
> one by dropping the high bits. You add some logic to convert it to an
> invalid pointer so that user space gets -EFAULT.
Thanks for the advice. I'm looking at how to make the compat stuff.

--=20
Best Regards
 Guo Ren

