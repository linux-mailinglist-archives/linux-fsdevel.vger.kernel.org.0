Return-Path: <linux-fsdevel+bounces-44154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41474A63A42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 02:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8413716D683
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 01:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB6076034;
	Mon, 17 Mar 2025 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="diSUR5Iz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229713A3F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174983; cv=none; b=Z+p2tgri/QRi3mw1nSeCmp7qHqoHk8ZFcGI5FeLTCrTTV8zgW48LyqYFq8+gStsKo3hZ3hIdSa67SBuxYp7EW7hmVbs+ePaELxKknBtrK1AXGEGFQ9s4lB2kJPCXZZhvFG1qTxC9oMdx7qs7cYE0on9rbhMsc8CzFAm84SIZfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174983; c=relaxed/simple;
	bh=sBUAav1FFvgBjKgeVxJ0EVH51r2m9LIesRdspscRl6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLr3UWCSI427dPG6x0ExRvjGJ3EMiHRKUTrTAK+T6gODEgYbxFREVi4jNHve/L71QT/7UPXA5gSnpupfMsQqfFWM4QG6KhiKTAe6RRH80biWD/MdDPy6s3tJCzn+59flbEyqUj23iY371svms+J9ZBkLxJgFGxc2P6Fx0ACUPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=diSUR5Iz; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d46fddf357so10463145ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Mar 2025 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1742174980; x=1742779780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXV1YPaItWH5GuExWu6nvtOdHmuNPHwz3fpSrmXloOk=;
        b=diSUR5Izi2iYU8RfmW2sNMI4WfqfOfMPLcj4LO1eV6fJhUr4v00czUvxtuyU+Ttiqs
         Hz8coVWSDDD18gQZ0kdUDcs/MS4bgtBH/FgDrrRzd3OlfOR5pA4sMU0RJD+a/EfkecQ5
         HO3YcqeFrgAGO+vWzOYH2UiyGo7YaF/t2ORovxZlp6vS6QyM07x0kkWnBYBVkIeGMY4d
         2AteIgOv5ZhsJ7q3ZKlVuqsI2ggEYBXJahAX55mtEOf4pRbFHutQKlTIIksyHYoVEwMJ
         9ADSDS2n0OZTi/688Rhk5+FDJn7FtMMoxS9uD3ipcWipZFLvsVi0XKx2shuLfdLdZYLI
         5Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174980; x=1742779780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXV1YPaItWH5GuExWu6nvtOdHmuNPHwz3fpSrmXloOk=;
        b=hvMTwp0SPNpx/r6r9U31Y5hKlzL40GJ+K+WK2ysBoS+5AKOz1DX4ZxY0U+QLvZumqB
         si1ReM+iiVR3bLqNg4rqz9/z/eQfTh+ZiH7qcJHe92DyEDEmX3wKup+ZzKfHCrlxovEK
         TIzcVh9o8/GcYdBY9NUL5+8edUyIuguMAfGnEJfjVZOmmZQjobEKKQoqJ9hkwO1O0MRP
         jcpo+3PUY8aLLTVDyQjyelij7AsvosvJ7F8NVs0nCoY4Qz3So9NYGaqhaJKA9BoejiX1
         OEbLCUNszia6dpQ1h/Ava12fYVr0T56sYfWeVkILJalng3esbni0ramGDJLu07Cz74SA
         C2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjsaKwGfpXTLChNo+6YM6N8889oWcR6X5I+kJ/4UskfRVOvgHy0dcTi/9BavO7jf++ugARaXEQs3nYLe5E@vger.kernel.org
X-Gm-Message-State: AOJu0Yybr2+QuLHvnk4In/sextwDBpP/E+Y6WwgPmZNN+rdzmDcxsqzj
	h8AnTJFEvKTj3KZ77Hlpir1c1OZk+zcvcYFhZc0/z52txz3rosHt2fdXlnEL/Pjquteyt9VXocm
	+5+RI88xKZYRLcR9gjhSFefkii5SQu5jORA5ZWQ==
X-Gm-Gg: ASbGnctln9D3TAhCe4gOhHDHsAjTVeqLnEmrD1LXBE94Q4f+56V5wKCQpNqaRCz2yrt
	2KdiCz7EysF4jlBTRGR6oIE8VFThScY1nFht91OqJbdkG4lAqUuY4M2kLO/Us01ChKiV8/ACq1U
	ZVnUf6w5AfaMkJajImSbMsUv0+J1Pv920raL8jzNg=
X-Google-Smtp-Source: AGHT+IHhjOPG6EGR3h5ZoxINkquScgFy27rLR9k3To3zRQ6sSX22EXVVLbZqhYGhk5BG8qHjIGiTQP6ZKF5VsUZ7wNw=
X-Received: by 2002:a05:6e02:2146:b0:3d4:700f:67e2 with SMTP id
 e9e14a558f8ab-3d483a142bcmr103325245ab.10.1742174980058; Sun, 16 Mar 2025
 18:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com> <20250314-v5_user_cfi_series-v12-14-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-14-e51202b53138@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 17 Mar 2025 09:29:28 +0800
X-Gm-Features: AQ5f1Jq1XMUvueQ2i8jGfmFKuB0WixGyohaNaR6cxlktpRaErRRA5S28rQgfU70
Message-ID: <CANXhq0oz72vtaAxKH02ccJg+JHO9JnWbWhfwdDAgNd14ghNMCg@mail.gmail.com>
Subject: Re: [PATCH v12 14/28] riscv: Implements arch agnostic indirect branch
 tracking prctls
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

On Sat, Mar 15, 2025 at 6:51=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> prctls implemented are:
> PR_SET_INDIR_BR_LP_STATUS, PR_GET_INDIR_BR_LP_STATUS and
> PR_LOCK_INDIR_BR_LP_STATUS
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/usercfi.h | 16 +++++++-
>  arch/riscv/kernel/entry.S        |  2 +-
>  arch/riscv/kernel/process.c      |  5 +++
>  arch/riscv/kernel/usercfi.c      | 79 ++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 100 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/us=
ercfi.h
> index c4dcd256f19a..a8cec7c14d1d 100644
> --- a/arch/riscv/include/asm/usercfi.h
> +++ b/arch/riscv/include/asm/usercfi.h
> @@ -16,7 +16,9 @@ struct kernel_clone_args;
>  struct cfi_status {
>         unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>         unsigned long ubcfi_locked : 1;
> -       unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);
> +       unsigned long ufcfi_en : 1; /* Enable for forward cfi. Note that =
ELP goes in sstatus */
> +       unsigned long ufcfi_locked : 1;
> +       unsigned long rsvd : ((sizeof(unsigned long) * 8) - 4);
>         unsigned long user_shdw_stk; /* Current user shadow stack pointer=
 */
>         unsigned long shdw_stk_base; /* Base address of shadow stack */
>         unsigned long shdw_stk_size; /* size of shadow stack */
> @@ -33,6 +35,10 @@ bool is_shstk_locked(struct task_struct *task);
>  bool is_shstk_allocated(struct task_struct *task);
>  void set_shstk_lock(struct task_struct *task);
>  void set_shstk_status(struct task_struct *task, bool enable);
> +bool is_indir_lp_enabled(struct task_struct *task);
> +bool is_indir_lp_locked(struct task_struct *task);
> +void set_indir_lp_status(struct task_struct *task, bool enable);
> +void set_indir_lp_lock(struct task_struct *task);
>
>  #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
>
> @@ -58,6 +64,14 @@ void set_shstk_status(struct task_struct *task, bool e=
nable);
>
>  #define set_shstk_status(task, enable)
>
> +#define is_indir_lp_enabled(task) false
> +
> +#define is_indir_lp_locked(task) false
> +
> +#define set_indir_lp_status(task, enable)
> +
> +#define set_indir_lp_lock(task)
> +
>  #endif /* CONFIG_RISCV_USER_CFI */
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 68c99124ea55..00494b54ff4a 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -143,7 +143,7 @@ SYM_CODE_START(handle_exception)
>          * Disable the FPU/Vector to detect illegal usage of floating poi=
nt
>          * or vector in kernel space.
>          */
> -       li t0, SR_SUM | SR_FS_VS
> +       li t0, SR_SUM | SR_FS_VS | SR_ELP
>
>         REG_L s0, TASK_TI_USER_SP(tp)
>         csrrc s1, CSR_STATUS, t0
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index cd11667593fe..4587201dd81d 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -160,6 +160,11 @@ void start_thread(struct pt_regs *regs, unsigned lon=
g pc,
>         set_shstk_status(current, false);
>         set_shstk_base(current, 0, 0);
>         set_active_shstk(current, 0);
> +       /*
> +        * disable indirect branch tracking on exec.
> +        * libc will enable it later via prctl.
> +        */
> +       set_indir_lp_status(current, false);
>
>  #ifdef CONFIG_64BIT
>         regs->status &=3D ~SR_UXL;
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> index b93b324eed26..7937bcef9271 100644
> --- a/arch/riscv/kernel/usercfi.c
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -72,6 +72,35 @@ void set_shstk_lock(struct task_struct *task)
>         task->thread_info.user_cfi_state.ubcfi_locked =3D 1;
>  }
>
> +bool is_indir_lp_enabled(struct task_struct *task)
> +{
> +       return task->thread_info.user_cfi_state.ufcfi_en ? true : false;
> +}
> +
> +bool is_indir_lp_locked(struct task_struct *task)
> +{
> +       return task->thread_info.user_cfi_state.ufcfi_locked ? true : fal=
se;
> +}
> +
> +void set_indir_lp_status(struct task_struct *task, bool enable)
> +{
> +       if (!cpu_supports_indirect_br_lp_instr())
> +               return;
> +
> +       task->thread_info.user_cfi_state.ufcfi_en =3D enable ? 1 : 0;
> +
> +       if (enable)
> +               task->thread.envcfg |=3D ENVCFG_LPE;
> +       else
> +               task->thread.envcfg &=3D ~ENVCFG_LPE;
> +
> +       csr_write(CSR_ENVCFG, task->thread.envcfg);
> +}
> +
> +void set_indir_lp_lock(struct task_struct *task)
> +{
> +       task->thread_info.user_cfi_state.ufcfi_locked =3D 1;
> +}
>  /*
>   * If size is 0, then to be compatible with regular stack we want it to =
be as big as
>   * regular stack. Else PAGE_ALIGN it and return back
> @@ -372,3 +401,53 @@ int arch_lock_shadow_stack_status(struct task_struct=
 *task,
>
>         return 0;
>  }
> +
> +int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __u=
ser *status)
> +{
> +       unsigned long fcfi_status =3D 0;
> +
> +       if (!cpu_supports_indirect_br_lp_instr())
> +               return -EINVAL;
> +
> +       /* indirect branch tracking is enabled on the task or not */
> +       fcfi_status |=3D (is_indir_lp_enabled(t) ? PR_INDIR_BR_LP_ENABLE =
: 0);
> +
> +       return copy_to_user(status, &fcfi_status, sizeof(fcfi_status)) ? =
-EFAULT : 0;
> +}
> +
> +int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long sta=
tus)
> +{
> +       bool enable_indir_lp =3D false;
> +
> +       if (!cpu_supports_indirect_br_lp_instr())
> +               return -EINVAL;
> +
> +       /* indirect branch tracking is locked and further can't be modifi=
ed by user */
> +       if (is_indir_lp_locked(t))
> +               return -EINVAL;
> +
> +       /* Reject unknown flags */
> +       if (status & ~PR_INDIR_BR_LP_ENABLE)
> +               return -EINVAL;
> +
> +       enable_indir_lp =3D (status & PR_INDIR_BR_LP_ENABLE) ? true : fal=
se;
> +       set_indir_lp_status(t, enable_indir_lp);
> +
> +       return 0;
> +}
> +
> +int arch_lock_indir_br_lp_status(struct task_struct *task,
> +                                unsigned long arg)
> +{
> +       /*
> +        * If indirect branch tracking is not supported or not enabled on=
 task,
> +        * nothing to lock here
> +        */
> +       if (!cpu_supports_indirect_br_lp_instr() ||
> +           !is_indir_lp_enabled(task) || arg !=3D 0)
> +               return -EINVAL;
> +
> +       set_indir_lp_lock(task);
> +
> +       return 0;
> +}
>
LGTM

Reviewed-by: Zong Li <zong.li@sifive.com>

> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

