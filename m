Return-Path: <linux-fsdevel+bounces-31150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336539926CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 10:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FE61C22472
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 08:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E176D18BB8C;
	Mon,  7 Oct 2024 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XSGIF6M2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466E189F59
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 08:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289081; cv=none; b=mN4sgCdVdm+5n8n+rG6XX/y/LbTN/6qWneE2GTxGeKglKhPzfIHC5X7AtmhISi+qtNUsHChoNqfCOQMJc8XJAiC8PDIpnuzBTtsH3f4sim8ptwdZjypK/PzF0U9nEgQSEiGbkHUwZFKywdT2NotQnJ8P2I4qHC8xC1/+aXpHnxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289081; c=relaxed/simple;
	bh=Nmph6WDs9Xq7iTOfvd0cLrjjvG2iMe2g5y57xwNvOkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLnx/SM5Pjrvsr4t4wt/ugkvw7/Ezv8inSZGhI3gXV81JOEbh5odIwYGyp6qRrNDAEdUnIlFc+Vc1ncMNPG3WquUKpp3M5KKA+f4zco/zk2n3G6AVwbd/pw4R27T3ilalrigqIFRifUq8DlLvzo6r7+nLVJcayAkGzAFyOkIcEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XSGIF6M2; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82cf3286261so154373239f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1728289078; x=1728893878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV5iKTZRSVTQUCoJBZzYZK+9ejJVraol8LawWsL5uGA=;
        b=XSGIF6M25Lbz0GpQpKB5rNdxaLqJ+91BffQhZawZ8hJ9WodEiehgVlQXcPY6vDjDNQ
         MaSj2qxb5wHrX6+Mj5hjS8e8uyp9uxDMZD8t5sUKfTc3wEHAgj7V4eqLfbYQI2HpNLTJ
         DgP3n27FA34JxTz0cOjNAnuUhLi4zMsBxejCPkqPxxgpVmE4FMeNb8rAGVRyHxSxkccQ
         N+Rafv+NKwXl0/lQPFPCz9ZhNznlCIsBqokEpvGnzlsO/WUeOTqQryd3X3r/Ad04er+4
         c4R3XI15030EUJYbCHsX9sD2uQKpy5RHDfxRmo5mKyeO4UrSOHg3I+oDm+ZFFuLEp6hz
         Ax3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728289078; x=1728893878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV5iKTZRSVTQUCoJBZzYZK+9ejJVraol8LawWsL5uGA=;
        b=mah2AkOEvXEisBpoheAM1DxmZY0C3BZRG8mqnSTUY3kDECBsDZImuEA3uTGxds+djb
         wM1gdaYQB+5bKSB6vKJMsjnm6GraTwiu1l63b1jxszKo+ArFfns+FEy+z1hQY1gub2kb
         SXVUDhVCNfRcP9PL+GostOn5q2hBftffslRX6+Gg2ni0gWNrXYCP1OJlcXdCR0ac8ofn
         N+PSCXiujPhYGAL/GO6toN4v5gMjrexeeiVX0xsMEP3ekLC/kU3TK+xHvnQIa9LKjsfS
         QpAWjCa722zY0XS4KdbyqBNEIeVq9Lx4k3b7SCXcIMsJwEtmaJS9uNlS4hQ6MRkofYb5
         Wn9g==
X-Forwarded-Encrypted: i=1; AJvYcCXXbOuwN1jrIxneFxsdGZSfVMFREcqu8kBjRtbzSCrd9ubRnYkihCFAbrWQx35nvIveblC+SrCnWOBbnBVH@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1rK+m62FPNSjhqLWw+Yio2TuMuGJ0RVLIXTPb3JVyYGL6FBI
	04LB3RSCX7V+WVu+Oij/UkX7SAI8G98CICReojJbYpgOcHavgqrXQSKIkVudOhiXUL2dQ1Dx7s2
	N04n33ExoDiHw/EVWAqcN1UP/F2ePBpNVVuC6HA==
X-Google-Smtp-Source: AGHT+IGbrFX2fkGwh4/hSUi/bswFsAwHoZTucK0BPSJDYS8wpDCXqS1WF3XKaDolR3S9yJug1dqVltHjNKSJeho3ET0=
X-Received: by 2002:a05:6602:14c1:b0:806:31ee:132 with SMTP id
 ca18e2360f4ac-834f7ca6040mr1014345639f.4.1728289078482; Mon, 07 Oct 2024
 01:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com> <20241001-v5_user_cfi_series-v1-16-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-16-3ba65b6e550f@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 7 Oct 2024 16:17:47 +0800
Message-ID: <CANXhq0rpwQkZ9+mZLGVUq=r4WiA8BbZ-eeTDogf3fzeEPqeeqA@mail.gmail.com>
Subject: Re: [PATCH 16/33] riscv/shstk: If needed allocate a new shadow stack
 on clone
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:20=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Userspace specifies CLONE_VM to share address space and spawn new thread.
> `clone` allow userspace to specify a new stack for new thread. However
> there is no way to specify new shadow stack base address without changing
> API. This patch allocates a new shadow stack whenever CLONE_VM is given.
>
> In case of CLONE_VFORK, parent is suspended until child finishes and thus
> can child use parent shadow stack. In case of !CLONE_VM, COW kicks in
> because entire address space is copied from parent to child.
>
> `clone3` is extensible and can provide mechanisms using which shadow stac=
k
> as an input parameter can be provided. This is not settled yet and being
> extensively discussed on mailing list. Once that's settled, this commit
> will adapt to that.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/usercfi.h |  25 ++++++++
>  arch/riscv/kernel/process.c      |  11 +++-
>  arch/riscv/kernel/usercfi.c      | 121 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 156 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/us=
ercfi.h
> index 4fa201b4fc4e..719e28e043c8 100644
> --- a/arch/riscv/include/asm/usercfi.h
> +++ b/arch/riscv/include/asm/usercfi.h
> @@ -8,6 +8,9 @@
>  #ifndef __ASSEMBLY__
>  #include <linux/types.h>
>
> +struct task_struct;
> +struct kernel_clone_args;
> +
>  #ifdef CONFIG_RISCV_USER_CFI
>  struct cfi_status {
>         unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
> @@ -17,6 +20,28 @@ struct cfi_status {
>         unsigned long shdw_stk_size; /* size of shadow stack */
>  };
>
> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
> +                                                       const struct kern=
el_clone_args *args);
> +void shstk_release(struct task_struct *tsk);
> +void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, =
unsigned long size);
> +unsigned long get_shstk_base(struct task_struct *task, unsigned long *si=
ze);
> +void set_active_shstk(struct task_struct *task, unsigned long shstk_addr=
);
> +bool is_shstk_enabled(struct task_struct *task);
> +
> +#else
> +
> +#define shstk_alloc_thread_stack(tsk, args) 0
> +
> +#define shstk_release(tsk)
> +
> +#define get_shstk_base(task, size) 0
> +
> +#define set_shstk_base(task, shstk_addr, size)
> +
> +#define set_active_shstk(task, shstk_addr)
> +
> +#define is_shstk_enabled(task) false
> +
>  #endif /* CONFIG_RISCV_USER_CFI */
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 1f2574fb2edb..f6f58b1ed905 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -28,6 +28,7 @@
>  #include <asm/vector.h>
>  #include <asm/cpufeature.h>
>  #include <asm/exec.h>
> +#include <asm/usercfi.h>
>
>  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER=
_TASK)
>  #include <linux/stackprotector.h>
> @@ -203,7 +204,7 @@ int arch_dup_task_struct(struct task_struct *dst, str=
uct task_struct *src)
>
>  void exit_thread(struct task_struct *tsk)
>  {
> -
> +       shstk_release(tsk);
>  }
>
>  int copy_thread(struct task_struct *p, const struct kernel_clone_args *a=
rgs)
> @@ -211,6 +212,7 @@ int copy_thread(struct task_struct *p, const struct k=
ernel_clone_args *args)
>         unsigned long clone_flags =3D args->flags;
>         unsigned long usp =3D args->stack;
>         unsigned long tls =3D args->tls;
> +       unsigned long ssp =3D 0;
>         struct pt_regs *childregs =3D task_pt_regs(p);
>
>         memset(&p->thread.s, 0, sizeof(p->thread.s));
> @@ -225,11 +227,18 @@ int copy_thread(struct task_struct *p, const struct=
 kernel_clone_args *args)
>                 p->thread.s[0] =3D (unsigned long)args->fn;
>                 p->thread.s[1] =3D (unsigned long)args->fn_arg;
>         } else {
> +               /* allocate new shadow stack if needed. In case of CLONE_=
VM we have to */
> +               ssp =3D shstk_alloc_thread_stack(p, args);
> +               if (IS_ERR_VALUE(ssp))
> +                       return PTR_ERR((void *)ssp);
> +
>                 *childregs =3D *(current_pt_regs());
>                 /* Turn off status.VS */
>                 riscv_v_vstate_off(childregs);
>                 if (usp) /* User fork */
>                         childregs->sp =3D usp;
> +               /* if needed, set new ssp */
> +               ssp ? set_active_shstk(p, ssp) : 0;
>                 if (clone_flags & CLONE_SETTLS)
>                         childregs->tp =3D tls;
>                 childregs->a0 =3D 0; /* Return value of fork() */
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> index ce002eabbdc1..7a7f0b57b2d4 100644
> --- a/arch/riscv/kernel/usercfi.c
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -19,6 +19,41 @@
>
>  #define SHSTK_ENTRY_SIZE sizeof(void *)
>
> +bool is_shstk_enabled(struct task_struct *task)
> +{
> +       return task->thread_info.user_cfi_state.ubcfi_en ? true : false;
> +}
> +
> +void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, =
unsigned long size)
> +{
> +       task->thread_info.user_cfi_state.shdw_stk_base =3D shstk_addr;
> +       task->thread_info.user_cfi_state.shdw_stk_size =3D size;
> +}
> +
> +unsigned long get_shstk_base(struct task_struct *task, unsigned long *si=
ze)
> +{
> +       if (size)
> +               *size =3D task->thread_info.user_cfi_state.shdw_stk_size;
> +       return task->thread_info.user_cfi_state.shdw_stk_base;
> +}
> +
> +void set_active_shstk(struct task_struct *task, unsigned long shstk_addr=
)
> +{
> +       task->thread_info.user_cfi_state.user_shdw_stk =3D shstk_addr;
> +}
> +
> +/*
> + * If size is 0, then to be compatible with regular stack we want it to =
be as big as
> + * regular stack. Else PAGE_ALIGN it and return back
> + */
> +static unsigned long calc_shstk_size(unsigned long size)
> +{
> +       if (size)
> +               return PAGE_ALIGN(size);
> +
> +       return PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK),=
 SZ_4G));
> +}
> +
>  /*
>   * Writes on shadow stack can either be `sspush` or `ssamoswap`. `sspush=
` can happen
>   * implicitly on current shadow stack pointed to by CSR_SSP. `ssamoswap`=
 takes pointer to
> @@ -143,3 +178,89 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, add=
r, unsigned long, size, unsi
>
>         return allocate_shadow_stack(addr, aligned_size, size, set_tok);
>  }
> +
> +/*
> + * This gets called during clone/clone3/fork. And is needed to allocate =
a shadow stack for
> + * cases where CLONE_VM is specified and thus a different stack is speci=
fied by user. We
> + * thus need a separate shadow stack too. How does separate shadow stack=
 is specified by
> + * user is still being debated. Once that's settled, remove this part of=
 the comment.
> + * This function simply returns 0 if shadow stack are not supported or i=
f separate shadow
> + * stack allocation is not needed (like in case of !CLONE_VM)
> + */
> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
> +                                          const struct kernel_clone_args=
 *args)
> +{
> +       unsigned long addr, size;
> +
> +       /* If shadow stack is not supported, return 0 */
> +       if (!cpu_supports_shadow_stack())
> +               return 0;
> +
> +       /*
> +        * If shadow stack is not enabled on the new thread, skip any
> +        * switch to a new shadow stack.
> +        */
> +       if (is_shstk_enabled(tsk))

Hi Deepak,
Should it be '!' is_shstk_enabled(tsk)?

> +               return 0;
> +
> +       /*
> +        * For CLONE_VFORK the child will share the parents shadow stack.
> +        * Set base =3D 0 and size =3D 0, this is special means to track =
this state
> +        * so the freeing logic run for child knows to leave it alone.
> +        */
> +       if (args->flags & CLONE_VFORK) {
> +               set_shstk_base(tsk, 0, 0);
> +               return 0;
> +       }
> +
> +       /*
> +        * For !CLONE_VM the child will use a copy of the parents shadow
> +        * stack.
> +        */
> +       if (!(args->flags & CLONE_VM))
> +               return 0;
> +
> +       /*
> +        * reaching here means, CLONE_VM was specified and thus a separat=
e shadow
> +        * stack is needed for new cloned thread. Note: below allocation =
is happening
> +        * using current mm.
> +        */
> +       size =3D calc_shstk_size(args->stack_size);
> +       addr =3D allocate_shadow_stack(0, size, 0, false);
> +       if (IS_ERR_VALUE(addr))
> +               return addr;
> +
> +       set_shstk_base(tsk, addr, size);
> +
> +       return addr + size;
> +}
> +
> +void shstk_release(struct task_struct *tsk)
> +{
> +       unsigned long base =3D 0, size =3D 0;
> +       /* If shadow stack is not supported or not enabled, nothing to re=
lease */
> +       if (!cpu_supports_shadow_stack() ||
> +               !is_shstk_enabled(tsk))
> +               return;
> +
> +       /*
> +        * When fork() with CLONE_VM fails, the child (tsk) already has a
> +        * shadow stack allocated, and exit_thread() calls this function =
to
> +        * free it.  In this case the parent (current) and the child shar=
e
> +        * the same mm struct. Move forward only when they're same.
> +        */
> +       if (!tsk->mm || tsk->mm !=3D current->mm)
> +               return;
> +
> +       /*
> +        * We know shadow stack is enabled but if base is NULL, then
> +        * this task is not managing its own shadow stack (CLONE_VFORK). =
So
> +        * skip freeing it.
> +        */
> +       base =3D get_shstk_base(tsk, &size);
> +       if (!base)
> +               return;
> +
> +       vm_munmap(base, size);
> +       set_shstk_base(tsk, 0, 0);
> +}
>
> --
> 2.45.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

