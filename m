Return-Path: <linux-fsdevel+bounces-44012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B43A60B9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 09:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370393BF316
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C21B4248;
	Fri, 14 Mar 2025 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="F/p+60mL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F77319CD0E
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941050; cv=none; b=OmaORuCCuzSrMdjA3g/tjAtjy90xptFrk8Nzltmx/hi/V60gm++W34t2IhyqPNw6j7wEq9ASOLE4IS7+5ca2lL/+WTlXXNe2NIShrLULOIN7yQi8qyjRaxFKFdEa0kcIdXeMCVuOUtHFZI2vEWTKaQ+h8PwNoOS64K3BQwnEOY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941050; c=relaxed/simple;
	bh=QEE9AtIrkbix+ZMthuGvxPmRXCfxafMZhXp2Rg+Rq5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URbRRbXZtRF9+yx4W+rfNpfrFzrJtFGCVOrZ2pbwydNRohtOx1Eikzdl2iYNcLwDZrkxgJz3VAGPXIqsb8vT5hdIU5ImLUn+t7nE3qPuzy/AAqZeQOcUnA7RxHmKvlDWzvn54ZinaTFFez69gpBaReFUqZu8/GI1P5B06iWijcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=F/p+60mL; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85ae4dc67e5so83742739f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741941047; x=1742545847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVkgjLCnCUI9ioEXp+7869JJX5vgmb7aKbpLKYY91VM=;
        b=F/p+60mLxUDkKAsEjICKDPs0AyBQ5siTDrZ5nQJIb92JvCk9zOKxNm9TTKAim5Uhb+
         yyNjGoDjgefcBBk8KvvQtvEQXrDSftMpy/7zoYBn/Ov+FK1+CGADY5GarYWZ/wpLf0k0
         EdZJ1Ma57h+2HKaZvUJdc94eAeuwi8l7Br9k69PvSi8qid4aUe0dhZ5P7d+EkRULOEJD
         Bvrk8/xxg32228VCbdiD08W/IAka0g4biuaeOZe3PmD2heyVPjoi6TRODs589SlCrurW
         T537RBI5EIIOtBhTdVGhXr28GdGlhL+DNWu78T4Eq2Vw2B5lL7aqnVc6Me57++xb/CXL
         b48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941047; x=1742545847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVkgjLCnCUI9ioEXp+7869JJX5vgmb7aKbpLKYY91VM=;
        b=XZXaU0fZiUXJ1Nha5j8vS/oD5IWFvYER0jAbtZiAavKUeAu7Mwj9d/E2Q78qvn69mR
         SvYDOLsKKrRVhUsRq6gnF1YoqyMutaONQlKjCeZGZLYP8BOcnqHLeCRo/lGOFnLwsS/P
         0p5m9SKKSCL/WhexLmERSOf32Jdz//1zMRPTTwZnLclYOWJKBj8NIxXLWWfupBNnCUzL
         l7uiXmd0UnvYqSLvXrhDm0Q+QoM5wtQ3uRJyCdzMAFEgx1YKfHf8jLt1kY8DyumKY/9j
         nvmNwyCa19ch1fGJR7T2rKC/ShReoLfUTgNRYpzky70DJMkngaUaEkZtas6hx680j6IA
         jgQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtcq4RPdtfAQkZXR5582atecDYaTJfEdnIhZkgDjP73eSwl+Iv89k9psWw1yPDlPaCuovwvFIj4V60s9u7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8LmptksvFS36v8hsUUoCY8FvpwHq7Zur9xICyLpMNv5D/hiqE
	ZEWSrO6czI3lZKZbpi8c90FvStcazAfJ5gzkSXlWAqS7GKczrUq/uqT+MrcDew22XPx3xaUmUIM
	Ti6A0Jn0/DRtqAo6tnHSfTGUUXb9mYs56mBO1ng==
X-Gm-Gg: ASbGncsXqpjlWwxvxFID8JlW0VEvuKo3hCGmeH7HtphoO+eCgib4ADGSbfznpxuu6bl
	MH2aKx87tY8gW4slM7wuSKc6MXcn6vBza20cgGKBVFAVIweF0000sm0uM/QW23nUA5F2w1Zpu+E
	lsNt2yRyyqubfeDKAyFIg1uBgwfgQ=
X-Google-Smtp-Source: AGHT+IFWp0so50j/pj0q80+N5pNVDDJV0PKTkFCKEUgPJqbURfJzftDPMl2yQe8jE+KIcC0bOMvyNNoalps1kuAhEuc=
X-Received: by 2002:a05:6602:4c0b:b0:85b:6118:db67 with SMTP id
 ca18e2360f4ac-85dc47c5578mr150925139f.2.1741941047135; Fri, 14 Mar 2025
 01:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-11-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-11-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:30:35 +0800
X-Gm-Features: AQ5f1Jru716EmtibEWxuiBHJ0hbbelGrNS70UuKCfZm5CBH2LXMI4b2SkG1AS6M
Message-ID: <CANXhq0rdYLxUwpHHu9ErYZW93dGF20-ra7TfeKPv8ounu1rC9w@mail.gmail.com>
Subject: Re: [PATCH v11 11/27] riscv/shstk: If needed allocate a new shadow
 stack on clone
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
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
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

On Mon, Mar 10, 2025 at 11:42=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
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
>  arch/riscv/include/asm/mmu_context.h |   7 ++
>  arch/riscv/include/asm/usercfi.h     |  25 ++++++++
>  arch/riscv/kernel/process.c          |   9 +++
>  arch/riscv/kernel/usercfi.c          | 120 +++++++++++++++++++++++++++++=
++++++
>  4 files changed, 161 insertions(+)
>
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/as=
m/mmu_context.h
> index 8c4bc49a3a0f..dbf27a78df6c 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -48,6 +48,13 @@ static inline unsigned long mm_untag_mask(struct mm_st=
ruct *mm)
>  }
>  #endif
>
> +#define deactivate_mm deactivate_mm
> +static inline void deactivate_mm(struct task_struct *tsk,
> +                                struct mm_struct *mm)
> +{
> +       shstk_release(tsk);
> +}
> +
>  #include <asm-generic/mmu_context.h>
>
>  #endif /* _ASM_RISCV_MMU_CONTEXT_H */
> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/us=
ercfi.h
> index 5f2027c51917..82d28ac98d76 100644
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
> +                                      const struct kernel_clone_args *ar=
gs);
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
> +#define get_shstk_base(task, size) 0UL
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
> index 7c244de77180..99acb6342a37 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -29,6 +29,7 @@
>  #include <asm/vector.h>
>  #include <asm/cpufeature.h>
>  #include <asm/exec.h>
> +#include <asm/usercfi.h>
>
>  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER=
_TASK)
>  #include <linux/stackprotector.h>
> @@ -211,6 +212,7 @@ int copy_thread(struct task_struct *p, const struct k=
ernel_clone_args *args)
>         unsigned long clone_flags =3D args->flags;
>         unsigned long usp =3D args->stack;
>         unsigned long tls =3D args->tls;
> +       unsigned long ssp =3D 0;
>         struct pt_regs *childregs =3D task_pt_regs(p);
>
>         /* Ensure all threads in this mm have the same pointer masking mo=
de. */
> @@ -229,11 +231,18 @@ int copy_thread(struct task_struct *p, const struct=
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
> index 24022809a7b5..73cf87dab186 100644
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
> @@ -142,3 +177,88 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, add=
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
> +                                      const struct kernel_clone_args *ar=
gs)
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
> +       if (!is_shstk_enabled(tsk))
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
> +       if (!cpu_supports_shadow_stack() || !is_shstk_enabled(tsk))
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
LGTM.

Reviewed-by: Zong Li <zong.li@sifive.com>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

