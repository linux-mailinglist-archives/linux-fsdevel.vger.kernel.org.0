Return-Path: <linux-fsdevel+bounces-45009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74997A70210
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30619188CB8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B7E267B66;
	Tue, 25 Mar 2025 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyPrZX2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6871EB5D4;
	Tue, 25 Mar 2025 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908452; cv=none; b=jrqq/7posKSng++8kNx6wo80V7aqht0OfyqEcfFdiHkhW7WS1uviRvsv4j+MIkChgIPD9tsoO57JX0KpftCctvn4tVFbmwBvOCRpNeTyAaB8NClhIICRJQFDnSrHWpbY8SY4OAlqNWl5keQEwOlJra2jfcWEjfvHer6Yj8B4I6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908452; c=relaxed/simple;
	bh=7bzJUIwY16l63QfKJmsiupVF7IYNqpkd3IzG9gYAALc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpXY77JZei/+ZU7lsyb28PmmjTlrF3nZtvFn3n2TW9QPMQWcW6fx0KgClXm5pK4KZ//PkWrdhnWVepgkw6/WUHfxhX2N74OLjFGqSYYi2pfKt8bgWdBmXQFZy3ni/4E/PIxtJXwar9qTpCXt9GGv3Q1UBcKsmkh7AKvv4tok7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyPrZX2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAD6C4CEE9;
	Tue, 25 Mar 2025 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742908451;
	bh=7bzJUIwY16l63QfKJmsiupVF7IYNqpkd3IzG9gYAALc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NyPrZX2zvYx4m3VH9Fc1wiiQCHtp81BxhFIgJErfM1e6iK8yvSerc4sfbMDBzx1kQ
	 QplIQZnPOseIWFkTXjK02uSDnGG6Uzq1AYv5KPHeujZiOAlbpwn4SbWEHhmX/gy469
	 fFXR2na2foa9uxqRXn9AF0M+fongqdtMQAsDD80dHI5sfoaBLx23YVNceFsMWYKaVs
	 C7/p11hnQkANTPBqtf0OU6Q+v+kaVBZb6VFrZLAR7m0krBlnMAO88LNmzTdnsOfaKI
	 VpbZ0yXg04wccCBO9NlBypwixYU1z2XvmV1vo+KcGfLfjl1MuRnqI83HTSb88ieULT
	 G+VRbIUrF/dSg==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso59983555e9.3;
        Tue, 25 Mar 2025 06:14:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCDQXv//uYnrj0xTcZU7WoVMoXsnC/3gu66XtlzhNcKWAWClCYZLvGFOhRd/wPwE/RplCvZC8TRDulLQ==@vger.kernel.org, AJvYcCUQQaPOp/iHR9mUH3hdZ+jeZspVo8mWHltjG4p6aFoXYWYErU0uVVevUEdNaM5KJyAGAsY/nPfvd/1HefU=@vger.kernel.org, AJvYcCUarW0/Q35ssU9KErxd22g/odNmW7MR/7ygwu9BNiONMaL16TcYLEHZD3f0WgNBNKEv+V9WzIOzDfsrUg==@vger.kernel.org, AJvYcCUpTdI73jiOVulOW3xykQocH8ESIfVuJ0NwI6UXCa48EFAt8i13cVMKKbo2EfJbuxQZugM19eMEj1FkQ9LRdYHAmbIw@vger.kernel.org, AJvYcCUqGtqqdu1BKbieA+m4mV5HVW9A2zxvB7ue4nTXF1/9dYiq5bfuwZ7rxSIw7nzijLV3o4AlDF+9j5T+yYBPyrRD@vger.kernel.org, AJvYcCV0k0WLTol/AmF2TwDXkA5hHdRhlGI57vtKgWgbfUIy5zxgs32qEyeUd6OlBWwU3uue36s7qtb8FHqPZwrUkavU5Q==@vger.kernel.org, AJvYcCV96R7XvC0sBcJzfv1+JFi6y5dPPwcQmIXIgecPUoh5uPwP1IFsxC/aXtchKwD3sa08m65JEC3NRmer9NjWLg==@vger.kernel.org, AJvYcCVbY2P44jOmYD5WokSgc83MD52DC+DZvPTPpxrt5Z8EVe7vmdtWoxhd5FQIWvutTjQApH4EHMpv72NkGG8=@vger.kernel.org, AJvYcCVeJHk5ZgNEpRWzlERRIwowRlMXJhBVfyql9AKKr0d7Vlkx4ICmApOZ2sKWnKcsyPo3n6/yVofk@vger.kernel.org, 
 AJvYcCVuYHLlMYcQv0Chh3BGwMkFkbvO0UOiR8AXIZiZbmMeeD5BxR5ZK3+sVhUbOSkZI44tfEJwGnCNu/tf@vger.kernel.org, AJvYcCWUpyV3xY/tdBoaSzQg2aYhiXmzdLzCoPOIR+F1/QgIJjjSTYJEJ6omIGJqSkMUyyE7I8P8Hv7dhkrBffUb@vger.kernel.org, AJvYcCWY8Lx2oS3HV6lWBflOKBK6wQRPntVljekJTuf6VsvNdyrLl7fuNgVmsaP1ajle7/moLNfx4EQ+KZk084wL@vger.kernel.org, AJvYcCWuz2C1r6mkcr/lPwDS0gbHaYWXfHvDpKWBsvUYR0Ah9PHOarVdzdyUjtghSFfSkhl1Y0+I@vger.kernel.org, AJvYcCXJUJcg+Gw/oApBcMnGSX3f4CVkwk4GwaIN3+KgITbhIslMhO4Qwj6sZCVzL8bM8YRc1wVSQonl65ODuYGW@vger.kernel.org, AJvYcCXa37OlWm9MB2tH2oLAyFSuTKm04ajOsu2x/6NvYEbVFU+WaC89nXd3tzqTZWfvf+ETO+0=@vger.kernel.org, AJvYcCXc+KKLEe6Pf7joAGeGC6EvUCyprnEFqKNblq7UzQ5Q3G3G+cH8Fo/gYPvDL/4ezEKVzwMAyTtn0LfU@vger.kernel.org, AJvYcCXfxGrHfVIPwNBEYnIhw9DhpGlSgk0I/R5ZRuBRRKwoYjDJ8lzE1N0WBhLWQXr8RJSR23cRXkzVQjcPeM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFeIsFzV8LJgj+BUWgRx+dxrTbPmpqy/u2qrclOXzYCj6EUYAD
	nV4naJhtYOgZQWzUIjJnZhpfSvQUrrOMvEzolKZoT37wZCvUyrv5tYCRnUAZQgxDs5gZ7KtmS/+
	YapgTykTq3Os678Q8bDY1BsGd1fo=
X-Google-Smtp-Source: AGHT+IGfKexksGgX0maV0KTcsKLOGrgVH5YKmlbhOfh8iEjwSz3eKgWZcomNnjiD6N1+SrsmiEpO9V65lbI9UvtGx1A=
X-Received: by 2002:a5d:59a2:0:b0:38f:6287:6474 with SMTP id
 ffacd0b85a97d-3997f8fc43dmr15193020f8f.15.1742908449922; Tue, 25 Mar 2025
 06:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325122640.GK36322@noisy.programming.kicks-ass.net>
In-Reply-To: <20250325122640.GK36322@noisy.programming.kicks-ass.net>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 25 Mar 2025 21:13:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRfo-JuGtCJvZKAFJ0BAEzdqe83TvccCKM54BL0NQHHJw@mail.gmail.com>
X-Gm-Features: AQ5f1JorUn_mZoEMhlL0Xe-AITZgnQPYbvOfeukBw1Vy-vsynC2mh-QB0cq8pe8
Message-ID: <CAJF2gTRfo-JuGtCJvZKAFJ0BAEzdqe83TvccCKM54BL0NQHHJw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 00/43] rv64ilp32_abi: Build CONFIG_64BIT
 kernel-self with ILP32 ABI
To: Peter Zijlstra <peterz@infradead.org>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, anup@brainfault.org, 
	atishp@atishpatra.org, oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, 
	will@kernel.org, mark.rutland@arm.com, brauner@kernel.org, 
	akpm@linux-foundation.org, rostedt@goodmis.org, edumazet@google.com, 
	unicorn_wang@outlook.com, inochiama@outlook.com, gaohan@iscas.ac.cn, 
	shihua@iscas.ac.cn, jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, boqun.feng@gmail.com, 
	xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, leobras@redhat.com, 
	jszhang@kernel.org, conor.dooley@microchip.com, samuel.holland@sifive.com, 
	yongxuan.wang@sifive.com, luxu.kernel@bytedance.com, david@redhat.com, 
	ruanjinjie@huawei.com, cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, 
	qiaozhe@iscas.ac.cn, ardb@kernel.org, ast@kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
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

On Tue, Mar 25, 2025 at 8:27=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Mar 25, 2025 at 08:15:41AM -0400, guoren@kernel.org wrote:
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > Since 2001, the CONFIG_64BIT kernel has been built with the LP64 ABI,
> > but this patchset allows the CONFIG_64BIT kernel to use an ILP32 ABI
>
> I'm thinking you're going to be finding a metric ton of assumptions
> about 'unsigned long' being 64bit when 64BIT=3Dy throughout the kernel.
Less than you imagined. Most code is compatible with ILP32 ABI due to
the CONFIG_32BIT. In my practice, it's deemed acceptable.

>
> I know of a couple of places where 64BIT will result in different math
> such that a 32bit 'unsigned long' will trivially overflow.
I would be grateful if you could share some with me.

>
> Please, don't do this. This adds a significant maintenance burden on all
> of us.
The 64ILP32 ABI would bear the maintenance burden, not traditional
64-bit or 32-bit ABIs. The patch set won't impact other CONFIG_64BIT
or CONFIG_32BIT. Numerous RV64 chips require the RV64ILP32 ABI to
reduce the memory and cache footprint; we will bear the burden. The
core code maintainers would receive patches that would make them use
BITS_PER_LONG and CONFIG_64BIT more accurately.

--=20
Best Regards
 Guo Ren

