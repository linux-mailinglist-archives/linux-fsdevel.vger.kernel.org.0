Return-Path: <linux-fsdevel+bounces-39035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296D7A0B62C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 12:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A3218868DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7D204588;
	Mon, 13 Jan 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IoC/Rd1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94EC1C3C05
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769488; cv=none; b=Hnp7iWig3tZ5siRX4Umhqz+VfIdjB52HUzrV0YKyORUl9l6n/q85gnPKtf9LyOBqxd1f49asfcjm0YhqvatiCqrWYgg0OecFBmtHM/kzKj/qX0smIjRK8BCe8N5hw1o0HgVE3niENmNSpIctlrDe3kZV2iNRvn0OzpKnWfGOnV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769488; c=relaxed/simple;
	bh=qgyVFZDPnC+G8DMUJgqykNkVLBD/QbOS28ZJkPZnikk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKVlpf+YmDhoi8rSPUhgyOFju/Y9ONvrYOARrSM5QPy9UtFF6poc57jNKsKZ4PxFqWqspP3grqamcLx7+S6g4L5p72OfczldcAbqfgEtv0RLHg8gwxL7LPxjKD3ZZARoscSGkoAK1NeWgDxUduvSU53oJa5U8JdrpKE1SMZb92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IoC/Rd1l; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso990365166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 03:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736769484; x=1737374284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6LB2zo5JQVbNy5aPdEgFHYNY7dBu+ItB6O48CNiVtk=;
        b=IoC/Rd1l/mYP6TwRZharT7IXYfh2yNGtxHmE1D648CPDVmXf+Gb/8GlZlweHAJSqb7
         7lYEDcfDQ7dmUcq3C7Q23eFfdrmvkIEF9/Ijj10qMPcKYyu/BzTqz+FkcLSHOxHoaU3d
         la9XLwO3cTM7A/LS86ZPHp9QggNCmXumODXjbbx3tlvc4gZOXukaoiPNOf3XOO5N5Ggp
         NDPMFBGUnjMHVEKW71qd+UMAQWfRk+k0bxyKv8jXSMSaKtHCGE4/9zhNTPQ106UfE4bp
         T8tadT+9A7q3IoTiOZJZNH3Gfql4gOYt7Nt2Wunv9efHLbsA2cQ9WRF9VU/BAbaNKJ73
         GB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736769484; x=1737374284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6LB2zo5JQVbNy5aPdEgFHYNY7dBu+ItB6O48CNiVtk=;
        b=ewBLd3WjYTCZy3DdRJ/DrGAdRNn4qMijq2TA44X6yXtozD3cTyLxR25/VaNMwYdAdZ
         IvnOHsTmCJ7ZlxbEngRHv5qhztDcA5Blzbyg9Y4TubVL78cDGayslIkSTss+O95B+TIh
         HBOu4O7iBzCD7ByjwY+h9oFJNuCpqjzKe0vWkiKEPPY2oKA9Nw9FSuMmEokIOcjyRPup
         H4gwYt8cikbDWO/5zdhnorh8H8D3FLGybgmcyLxtAucCAB1VbVI0uETAWEYPLLPJy53g
         Caa11vACnlRas9Y0CNcIJQamdrn6qJpR2oJSAdA89/XWl6XXhLILh+4wxHnV8+5m9IUF
         USyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmO+ZGG2t3ttB7WtkFN8WRVd9z+1oeSfH6tMrv7bb8a8RFtfSIQ/3HLw8ATMFwrh1ouGyKOYt8Jpu1tGf/@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvNA9I3OW077nwyNvo7yEMfGNKrXNGI8KoP5mGn1cDIdmGjwa
	UHClflglYwdFXabnoEjHYUFRw38o1yZcSjI2TwHPL/dKFHYvHgcotHJ5Dxmmz8it+sjjn7C2gMX
	n0lN9tIXEYOcV6z8uweVYEP/shK5x6VuPVY+7Ew==
X-Gm-Gg: ASbGncsFGlVi0RiQiASUJ3IoCwk754YNnGpDPSoCEb4aqgTx1yZwYYTdlmwjUAaZUAH
	+dWX+WvAnYPk+AFyIRZwnioZL20wFd54rR+QPMd3ec0X835DK7weGkpUy
X-Google-Smtp-Source: AGHT+IEWjsMs2qqsiPAcMjyt7OBYoBbUyzumfRZMji8itxfYzAZiZiSksgJh4STo+nRhjNsTMIScLXRh3aHYhGavQTo=
X-Received: by 2002:a17:907:3d93:b0:aa6:8b4a:4695 with SMTP id
 a640c23a62f3a-ab2c3d3c729mr1574290166b.31.1736769484006; Mon, 13 Jan 2025
 03:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110160328.64947-1-oxana@cloudflare.com> <20250110195445.586a1682302e66788e83e83e@linux-foundation.org>
In-Reply-To: <20250110195445.586a1682302e66788e83e83e@linux-foundation.org>
From: Oxana Kharitonova <oxana@cloudflare.com>
Date: Mon, 13 Jan 2025 11:57:53 +0000
X-Gm-Features: AbW1kvZ2Q8EJH8JFxflzIZar_Vpm3SUAK3dAb2wyUj0lHNxeZzRncRNaPC-z6_A
Message-ID: <CALY79ryLY=xB7V_2vVi7rafxudOkhr4misKLU5uVEvCAJB7zuw@mail.gmail.com>
Subject: Re: [PATCH resend] hung_task: add task->flags, blocked by coredump to log
To: Andrew Morton <akpm@linux-foundation.org>
Cc: brauner@kernel.org, bsegall@google.com, dietmar.eggemann@arm.com, 
	jack@suse.cz, juri.lelli@redhat.com, mgorman@suse.de, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, vincent.guittot@linaro.org, 
	viro@zeniv.linux.org.uk, vschneid@redhat.com, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 3:54=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> I added the below fix.
>

Thank you for taking care of the patch and adding the fix!

>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: hung_task-add-task-flags-blocked-by-coredump-to-log-fix
> Date: Fri Jan 10 07:51:53 PM PST 2025
>
> fix printk control string
>
> In file included from ./include/asm-generic/bug.h:22,
>                  from ./arch/x86/include/asm/bug.h:99,
>                  from ./include/linux/bug.h:5,
>                  from ./arch/x86/include/asm/paravirt.h:19,
>                  from ./arch/x86/include/asm/irqflags.h:80,
>                  from ./include/linux/irqflags.h:18,
>                  from ./include/linux/spinlock.h:59,
>                  from ./include/linux/wait.h:9,
>                  from ./include/linux/wait_bit.h:8,
>                  from ./include/linux/fs.h:6,
>                  from ./include/linux/highmem.h:5,
>                  from kernel/sched/core.c:10:
> kernel/sched/core.c: In function 'sched_show_task':
> ./include/linux/kern_levels.h:5:25: error: format '%lx' expects argument =
of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Werro=
r=3Dformat=3D]
>     5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header =
*/
>       |                         ^~~~~~
> ./include/linux/printk.h:473:25: note: in definition of macro 'printk_ind=
ex_wrap'
>   473 |                 _p_func(_fmt, ##__VA_ARGS__);                    =
       \
>       |                         ^~~~
> ./include/linux/printk.h:586:9: note: in expansion of macro 'printk'
>   586 |         printk(KERN_CONT fmt, ##__VA_ARGS__)
>       |         ^~~~~~
> ./include/linux/kern_levels.h:24:25: note: in expansion of macro 'KERN_SO=
H'
>    24 | #define KERN_CONT       KERN_SOH "c"
>       |                         ^~~~~~~~
> ./include/linux/printk.h:586:16: note: in expansion of macro 'KERN_CONT'
>   586 |         printk(KERN_CONT fmt, ##__VA_ARGS__)
>       |                ^~~~~~~~~
> kernel/sched/core.c:7704:9: note: in expansion of macro 'pr_cont'
>  7704 |         pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d task_f=
lags:0x%08lx flags:0x%08lx\n",
>       |         ^~~~~~~
> cc1: all warnings being treated as errors
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Oxana Kharitonova <oxana@cloudflare.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  kernel/sched/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/kernel/sched/core.c~hung_task-add-task-flags-blocked-by-coredump-to=
-log-fix
> +++ a/kernel/sched/core.c
> @@ -7701,7 +7701,7 @@ void sched_show_task(struct task_struct
>         if (pid_alive(p))
>                 ppid =3D task_pid_nr(rcu_dereference(p->real_parent));
>         rcu_read_unlock();
> -       pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d task_flags:0x%=
08lx flags:0x%08lx\n",
> +       pr_cont(" stack:%-5lu pid:%-5d tgid:%-5d ppid:%-6d task_flags:0x%=
04x flags:0x%08lx\n",
>                 free, task_pid_nr(p), task_tgid_nr(p),
>                 ppid, p->flags, read_task_thread_flags(p));
>
> _
>

