Return-Path: <linux-fsdevel+bounces-46809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621EEA953DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBD0189517A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5141E1022;
	Mon, 21 Apr 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvFwV9Hl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38E33EC;
	Mon, 21 Apr 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745252000; cv=none; b=Ftag3eupT/LGdgiPURlsa/riiYP5o02CkwL5PGFyJYy+rmZZNF69wDYapNgeghgDWgLbBSjDp97N14mym3YcJ8lb/F4E2qN1Q4ELqHlAU1IYNebQkkVm6l37LaxPC5cH3il+0LBZ48eTZC3dftPCTRl6Da+vHWSX3ZWIASLdL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745252000; c=relaxed/simple;
	bh=fjHyYEUz8mq+kd32kuPuYxYj0H98bcmAhUeHAtoZ0Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNruy1hwv/xDa9iZ78mmdMr/V1YQqXXfHX8627FJIgum6zLrRFpLw/3a7cuiUt+o8s8XujmqjRy3ZsqwIByWKgfTsdZQNxFuqYEMhYYU1AGVXYSyr92bs8XZ6FOUGTVy59x9Cbs47my0+RsBpkSru+oWsoOWeKRvAwq6/TV7tHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvFwV9Hl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so2480557f8f.0;
        Mon, 21 Apr 2025 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745251996; x=1745856796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zLX7K/cYY3IleSeSkksUZh8idp3aJvGLpMSPQRzdiw=;
        b=YvFwV9Hl0bw4MjxtQPjEQl8W7GfA8Hvn5lfHfw2inVxZ/TlMWBuLxziiAzGP7OU+Vm
         KpzGaoGIhPS5jUlEI4LMKrUtIBQGCUd0P/oF/t4g5Yif4fyJVeLKtMhviusWSd+C4Eez
         rvKRsBVza2yHaOmqDD1U4oLMQwuZmR1Ej2d+fA9mf9QH4XyOeUpTVcm2s2+sR/nVGN6Q
         Ttr6BDnT/E5ArOhcnOypWPRRkc2Cy7CEnfeDah3JoW4uYqgkQSUwNhu+jkHTo7Q+6iHX
         GZ7kTzZZT/5FsTh7+YqzmpBNXJ7Rv1kR/45CqMmZX2KmSbPM9O4ZtvUmD67qJm/ia9QC
         m58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745251996; x=1745856796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zLX7K/cYY3IleSeSkksUZh8idp3aJvGLpMSPQRzdiw=;
        b=oikGSrQyCU1U5R5ghXtteIGEBvJbzHTFzCITbCcGBmiahkzxTC6//IXc9EoPfO8w/f
         ZAo0uoMnJ8QIN4mlEpqT3bs6DLASkpvDejACZ26WFhYOh+hnVTT7AV3J+FrIC1Zp0aFc
         EfiKlYd0v5OBbpbsqEIJUYDoKvP3L5ILJi82eIhs8H3ohyk4DJDluplqR6KStgHroZEu
         5bJA3XuZk+qZv4b9fmrPhK1rX9N1/RE+PI0nPf+7EE8Sx6vsr54AjXISDbOkU0j4RF0y
         Tlc5NcRogj94zHYCX8G/O7XEftUKWl3hoPjN/AQzFS3QVZbiy7gR1bG/fSw4FMnBR5mz
         83CA==
X-Forwarded-Encrypted: i=1; AJvYcCUUTbQ4aQ2n75Qeh+xdoNZhhHxnpryXTnA2kNhInbG+73Mtj6idfCZzON0C3CulwyioL4c=@vger.kernel.org, AJvYcCUbR/9hfBiMtTYBCl8j6hPBS1vnjCj35JE9ZbZ3Yb4IUen/hCXZCA8mXzbn38Iu2xtxXzHQNzmXgTciKSPrdfT8yw==@vger.kernel.org, AJvYcCUoJhnMYSH6I4MdtF3s4Uez3qAkDqWFNhD4mES/gJwcDVzIsoFaiuVHGyrO2bUFEKM3rJfIItsmuOrqV3w=@vger.kernel.org, AJvYcCVBglNtso3nTc8twJBFzZWRUDuhT7L/72MlLpCvXwVYLA2af+QaMvvAib4bZATEOWv+cnucDShazxpAAtsUfrKP@vger.kernel.org, AJvYcCVDBuWk5c+wscaV4sQa98Ma9Z1a1vj/qUOuvVMS5V1SWagxwiPZ3nwoiwIrAONuafZtGQ8t5SD1+zZfqx3I@vger.kernel.org, AJvYcCW/VXntTVvtnAIrPhQcMW7JebXnYMh3L1TMjY9PHkYJZhXeEGuta6yp6CF+ANd/1Wr+cMkgP75y@vger.kernel.org, AJvYcCWce9Dy1PT9NLBTyzS5fpLDAKUZi+9UJRt4cRzgUF4JBq1MLrxLkGqXZ/yzMCKXCAHFvIYPRr9b44pfbPHV2uwOXJvA@vger.kernel.org, AJvYcCWta6dCYDpgn02Rqnk87qhRToqCUEDF0/Fz9Qpw2YxMsCW01eVT7QzVwxurxbhoZP1lSbbKkXur2Vc+4YWvuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9PUFfHR2o/xBQoq8j4rjjEveMu94gRG8EwwCTj7WSUiIy/j77
	Nf6F4HOk5PpQalefbFTKROlZxw7moxaRpnA4NlQiQmzV75jEIO0zhGE5Aw+F/pzFgNaSYT+ayZr
	doMt2R/QcsZQSCXGO1J3iIpFG1SM=
X-Gm-Gg: ASbGncvqMLhxcrRnvUeGjcWzx5XvV2zWKlRntGLFRxf55bfyLqGY7ZLKXgd/CaPs14d
	eipqtmQYnE2qPJDOS660LFkB0HE2D+5C4WliL4FlHMX7BcR2UH/NGIcW1U+rCPVIx8wy/fEaMsz
	1N/cOEwFkcq/qrMMGrRfeZfAR2tc9yUsa+mJFwjw==
X-Google-Smtp-Source: AGHT+IERc9SbXqHoD9IEJg7efyEpkbehIMV7qdPZVeaGZ/dKsZqt8X+kv+83Lua/+4bYS6g8aPAmuT20YbQK/7LgbuE=
X-Received: by 2002:a05:6000:188b:b0:38f:503a:d93f with SMTP id
 ffacd0b85a97d-39efbacdc16mr9730639f8f.40.1745251995604; Mon, 21 Apr 2025
 09:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744169424.git.dxu@dxuuu.xyz> <5b3433d942eaecdbcc92876c9ed8b7d17f7e1086.1744169424.git.dxu@dxuuu.xyz>
In-Reply-To: <5b3433d942eaecdbcc92876c9ed8b7d17f7e1086.1744169424.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Apr 2025 09:13:03 -0700
X-Gm-Features: ATxdqUH2LI9xx7Ht6ga__5IFi0RUqBTSDZrwpNL136ky8WsOy4vl2AEULf1HMhQ
Message-ID: <CAADnVQK111J3b-4gauYkptFf51fhYQn2J78dH8QiwdSigiRuJw@mail.gmail.com>
Subject: Re: [RFC bpf-next 11/13] treewide: bpf: Export symbols used by verifier
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Namhyung Kim <namhyung@kernel.org>, Eric Dumazet <edumazet@google.com>, Sean Young <sean@mess.org>, 
	X86 ML <x86@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Song Liu <song@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 8:35=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit EXPORT_SYMBOL_GPL()'s all the unresolved symbols from verifie=
r.o.
> This is necessary to support loads and reloads of the verifier at
> runtime.
>
> The list of symbols was generated using:
>
>     nm -u kernel/bpf/verifier.o | grep -ve "__asan\|__ubsan\|__kasan" | a=
wk '{print $2}'
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  arch/x86/net/bpf_jit_comp.c |  2 ++
>  drivers/media/rc/bpf-lirc.c |  1 +
>  fs/bpf_fs_kfuncs.c          |  4 ++++
>  kernel/bpf/bpf_iter.c       |  1 +
>  kernel/bpf/bpf_lsm.c        |  5 +++++
>  kernel/bpf/bpf_struct_ops.c |  2 ++
>  kernel/bpf/btf.c            | 40 +++++++++++++++++++++++++++++++++++++
>  kernel/bpf/cgroup.c         |  4 ++++
>  kernel/bpf/core.c           | 29 +++++++++++++++++++++++++++
>  kernel/bpf/disasm.c         |  4 ++++
>  kernel/bpf/helpers.c        |  2 ++
>  kernel/bpf/local_storage.c  |  2 ++
>  kernel/bpf/log.c            | 12 +++++++++++
>  kernel/bpf/map_iter.c       |  1 +
>  kernel/bpf/memalloc.c       |  3 +++
>  kernel/bpf/offload.c        | 10 ++++++++++
>  kernel/bpf/syscall.c        |  7 +++++++
>  kernel/bpf/tnum.c           | 20 +++++++++++++++++++
>  kernel/bpf/token.c          |  1 +
>  kernel/bpf/trampoline.c     |  5 +++++
>  kernel/events/callchain.c   |  3 +++
>  kernel/trace/bpf_trace.c    |  9 +++++++++
>  lib/error-inject.c          |  2 ++
>  net/core/filter.c           | 26 ++++++++++++++++++++++++
>  net/core/xdp.c              |  2 ++
>  net/netfilter/nf_bpf_link.c |  1 +
>  26 files changed, 198 insertions(+)

Patches 1-10 look ok. Moving the code around and few targeted
exports are fine,
but this patch goes too far.
At least btf.c, log.c, tnum.c and may be others should be a part
of the module.
Then check_sock_access() can be refactored into callbacks
to avoid exports in filter.c
We can approach it from the pov of minimizing exports,
but such steps won't give us clarity on how portable such
modular verifier will be.
Other questions to answer is whether maps should be in the module too.
Modules can provide their kfuncs already, so existing kfuncs
can stay where they are.

Namespacing into "bpf_internal" as Stanislav suggested is
a good thing too with a warning somewhere in Documentation/bpf/
that these must only be used by the verifier.

