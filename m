Return-Path: <linux-fsdevel+bounces-2294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7FB7E4808
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 19:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4421C20CED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFFD358AF;
	Tue,  7 Nov 2023 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1Xmw/Aq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EBD34CFD;
	Tue,  7 Nov 2023 18:15:53 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFB8AF;
	Tue,  7 Nov 2023 10:15:52 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a6190af24aso924343566b.0;
        Tue, 07 Nov 2023 10:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699380951; x=1699985751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLCkkkRy0xyxhf2w0mzTXDWxtj3x83g3Dw/kY8liqxs=;
        b=a1Xmw/AqoByUYLBTVTA2rinIw6h8P4ol+Yvy/FQvENFCG3EqQ6xH1Cm/iNcBZO0jF1
         6ntGVkcoeC2mrSSq9FhCPOPbosvQBMEVCdE8kYm9VS2bJzBmXlVJ/NOJj4y1W9wLzC9g
         Ckp6fSci94Mpbld1hwNa8+Bnpazf6uncvE4ujsvjNlJREkXnyKW65Mx12uqnb9NKDtx2
         BSnVKGq5OnEb4KcwHMu3zkWVWJTvN9FvjY/CjxS6EhvUAHYYwiUKuV8yVufI029BEjKL
         0i6gH+qQ6bU53BB5Nw3DGTmn8GUQgwHL7EowQqHFlazT+R6fTXOWRCTLpXLb3jINvlCN
         93Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380951; x=1699985751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLCkkkRy0xyxhf2w0mzTXDWxtj3x83g3Dw/kY8liqxs=;
        b=oaaIsGvYCJq+jxebMWXLkO28hCt4MtTT/XzezBYCI5a37cM0HtJJ32q5/zpLKXODYd
         E4hNw57fGTEM5fkNAKk0eBxWxMtu93pom4vDYncmsY3rVn/SLPzIvv6FdyJETSwP6BdT
         eRAQnBDntcQGvO85lxyV0ree8USdbwHhQN5E3SAJ4iDVyj3HSgAOenJ5pHGSR/u26kit
         K4kyuCbwrWyyXQ3ont72LQz9i9AGQuoK2Wz/RsJho64dTyJMggPvagSAF6pW9ctOCQdH
         sapKe/leNBKSKBwymPmQr+qFOhQW0K0VdA8EMq4IE421ZWBOUkjGmxi+8J9JkD076yx9
         Iwxw==
X-Gm-Message-State: AOJu0YyEXEtoZAVBjqWFytOwE6KvPlHfY9pJGvOdklPXYAewW/AECRZD
	gDk2mqS6k75MP8K22VkhVod4jgfGR7Hmb8yrn48=
X-Google-Smtp-Source: AGHT+IEu5edPr9vVltsuODkwaa50hcmnHTRA8lKcWKQoW6T8vdFZrs7ih3QwA4MmdyUXquI2lxrp4aEhdeZvuQjGSwk=
X-Received: by 2002:a17:907:d21:b0:9c0:eb3e:b070 with SMTP id
 gn33-20020a1709070d2100b009c0eb3eb070mr17256502ejc.69.1699380950186; Tue, 07
 Nov 2023 10:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
 <20231107-jag-sysctl_remove_empty_elem_kernel-v1-10-e4ce1388dfa0@samsung.com>
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-10-e4ce1388dfa0@samsung.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 Nov 2023 10:15:39 -0800
Message-ID: <CAEf4BzZY0TATP4ug54j43o=qDvHBe8xW=hKwRRTfBuLUKGjrmg@mail.gmail.com>
Subject: Re: [PATCH 10/10] bpf: Remove the now superfluous sentinel elements
 from ctl_table array
To: j.granados@samsung.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, josh@joshtriplett.org, 
	Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, 
	Iurii Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 5:45=E2=80=AFAM Joel Granados via B4 Relay
<devnull+j.granados.samsung.com@kernel.org> wrote:
>
> From: Joel Granados <j.granados@samsung.com>
>
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
>
> Remove sentinel element from bpf_syscall_table.
>
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  kernel/bpf/syscall.c | 1 -
>  1 file changed, 1 deletion(-)
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index eb01c31ed591..1cb5b852b4e7 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5679,7 +5679,6 @@ static struct ctl_table bpf_syscall_table[] =3D {
>                 .mode           =3D 0644,
>                 .proc_handler   =3D bpf_stats_handler,
>         },
> -       { }
>  };
>
>  static int __init bpf_syscall_sysctl_init(void)
>
> --
> 2.30.2
>

