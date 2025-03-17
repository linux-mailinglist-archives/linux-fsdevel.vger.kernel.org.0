Return-Path: <linux-fsdevel+bounces-44153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 760F7A63A39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 02:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4047A2979
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 01:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B4013BAE3;
	Mon, 17 Mar 2025 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L04rTBIq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892CA7DA82
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174955; cv=none; b=nGZd0CyRI4jA/IZ2lUquY5Aj4aVN+gmDXqsdNwnowgWPszkitlMHkMDk08XRBa81wAQyNTo8kI3Js42/f87fVBgXzakATzjrkFANNRx78MABlt/xTksSd7etOWn2+lEpeG2gBa2Kal1RpJHG7zxypkWOZqUj4Xp+cSyDJwYTF4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174955; c=relaxed/simple;
	bh=OOU+y75plyLuveX4R6mlZHByJagiF/jVTDsFtenIXmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPzuOmB/ws4ClVPWJwRFe/SKlIX8T/aLvDJ9fLL1c9LKrNIiBZxJiSXT2/UPi1w886hhwgUF7NnvoVp5pF6GT5bmbIyW9gENxSTSd37StqZqVE3r1MfqnhLKOqjA5h4UDVnFxCKtTJHhgnvUIxySHJ2Q45SB63eXxO7KB7VentA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=L04rTBIq; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d434c84b7eso25910165ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Mar 2025 18:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1742174951; x=1742779751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHE3Xzw/cN8v249darLwU5ncF/r/SV4XjU/TRkif508=;
        b=L04rTBIqxynN/jbYTXd55f8iWCClZEdOHLB0dZkbzK08vY3Ui1USzCzb2uGmxrv81O
         mcgOdSdIdTfZkCSBaJVNMys6ZM+tMy7JAmWAJTFYCy2DOAtZE7q06ZPkh7fEHkuZfW9D
         Sm1r2AVYcajZu+KK+csuCUY3/CF9NjOE/OTeL0JxISows6dWgNJhzVVvmtKsdYdTBSts
         AE1UHFlo3f/ozdh5MfFBlmrtpYJdJFpGVW+Zb0JpuI7Ed6ojs1c4dlH4vyThTKMVdX4t
         OnxjbVTRUrLvd34TwvoxWSnUEjN0P+CUXE5ov34atDmw9fZahUe8hY8LDZ5bsEZRkJTN
         e0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174951; x=1742779751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHE3Xzw/cN8v249darLwU5ncF/r/SV4XjU/TRkif508=;
        b=fly4bE9X6Mjv0cM8Zyhy9FQpbzfOJVynYeqiNE7yq8hGRsQDIuI9GFk/60EGNBwEC9
         dUFjra/sqv81QZfA+PI2R/1it7DItA2xYJgbXA5o9tqAuvnqQBd5jYyy+rzxnuKBLH+A
         755kraHB0RpQKdLZ2zuFTDfGeEo5KR6J84unQWHpPdGhYbcupXEBr3kQYYR7lynj1iJu
         xxUp39cmmysxASNfqzLJLrFV/ki2UKiB1baDXyEh7biFWqKb66qQU9TAFUypaZgzy4iH
         wS4CpvO+JpLbmf5+tFB78sQXF7kf57PMAt+Rn9y1lUXpNvFOKRVZGvMUb/dMyDkOrAIx
         WllQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd4MWpH9/tbDzQBaDEzgJYVh6OUuvZx72ercQgjAoafFW3nOR2y454pD/s/KcBGSVhDU9/pyNxaMs88YIb@vger.kernel.org
X-Gm-Message-State: AOJu0YyUiWpxSr8PqvlLJNG9mMttVJ5kFbTtItGlONOORIvMmaBZf5pJ
	ulCBAW/f6kLH2qlYEXLEKcWkSbTooXrFMfkKsKcToJqDmKpe1+B14Vwa9YRZK0gvi5VEaUVZVow
	uGuCBRboWyJccWLuJL5VpeQVUHveKkl944ksbDQ==
X-Gm-Gg: ASbGnctqdmGe1unJJA91Kir3oRTB0O32WEI9snk5TIxOEGDafvzlL1UTatn6Wb0z7kV
	xcuJdpLCKSADlUPJXqbnhVy6PQLcU/G7h3/5Vvq0FZL9LKLugtHI3HVB1R+GWIrnibzduRJHrwf
	F9p448G08PwstkM5mpzUOVT7XKQnh3
X-Google-Smtp-Source: AGHT+IFwMX5RIXP869hniuySeM4y0TL6MKtDgVXH439PW8w24/lM0YZJkQEjsvENb9uge5eD+gRnDQypjWH1VcK2Qic=
X-Received: by 2002:a92:c263:0:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d483a09d10mr122402375ab.7.1742174951563; Sun, 16 Mar 2025
 18:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com> <20250314-v5_user_cfi_series-v12-12-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-12-e51202b53138@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 17 Mar 2025 09:29:00 +0800
X-Gm-Features: AQ5f1JpqGc27CbzPvkDJGrdFCuQMvB1yiEI6FP2zzi4dH2aTyuuebgyN_m4AbWI
Message-ID: <CANXhq0oNc2=dXbNmBN29JUQu1FYn3fVSJ8NWYU7jiGQ5qDRPsw@mail.gmail.com>
Subject: Re: [PATCH v12 12/28] riscv: Implements arch agnostic shadow stack prctls
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
> Implement architecture agnostic prctls() interface for setting and gettin=
g
> shadow stack status.
>
> prctls implemented are PR_GET_SHADOW_STACK_STATUS,
> PR_SET_SHADOW_STACK_STATUS and PR_LOCK_SHADOW_STACK_STATUS.
>
> As part of PR_SET_SHADOW_STACK_STATUS/PR_GET_SHADOW_STACK_STATUS, only
> PR_SHADOW_STACK_ENABLE is implemented because RISCV allows each mode to
> write to their own shadow stack using `sspush` or `ssamoswap`.
>
> PR_LOCK_SHADOW_STACK_STATUS locks current configuration of shadow stack
> enabling.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/usercfi.h |  18 ++++++-
>  arch/riscv/kernel/process.c      |   8 +++
>  arch/riscv/kernel/usercfi.c      | 110 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 135 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/us=
ercfi.h
> index 82d28ac98d76..c4dcd256f19a 100644
> --- a/arch/riscv/include/asm/usercfi.h
> +++ b/arch/riscv/include/asm/usercfi.h
> @@ -7,6 +7,7 @@
>
>  #ifndef __ASSEMBLY__
>  #include <linux/types.h>
> +#include <linux/prctl.h>
>
>  struct task_struct;
>  struct kernel_clone_args;
> @@ -14,7 +15,8 @@ struct kernel_clone_args;
>  #ifdef CONFIG_RISCV_USER_CFI
>  struct cfi_status {
>         unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
> -       unsigned long rsvd : ((sizeof(unsigned long) * 8) - 1);
> +       unsigned long ubcfi_locked : 1;
> +       unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);
>         unsigned long user_shdw_stk; /* Current user shadow stack pointer=
 */
>         unsigned long shdw_stk_base; /* Base address of shadow stack */
>         unsigned long shdw_stk_size; /* size of shadow stack */
> @@ -27,6 +29,12 @@ void set_shstk_base(struct task_struct *task, unsigned=
 long shstk_addr, unsigned
>  unsigned long get_shstk_base(struct task_struct *task, unsigned long *si=
ze);
>  void set_active_shstk(struct task_struct *task, unsigned long shstk_addr=
);
>  bool is_shstk_enabled(struct task_struct *task);
> +bool is_shstk_locked(struct task_struct *task);
> +bool is_shstk_allocated(struct task_struct *task);
> +void set_shstk_lock(struct task_struct *task);
> +void set_shstk_status(struct task_struct *task, bool enable);
> +
> +#define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
>
>  #else
>
> @@ -42,6 +50,14 @@ bool is_shstk_enabled(struct task_struct *task);
>
>  #define is_shstk_enabled(task) false
>
> +#define is_shstk_locked(task) false
> +
> +#define is_shstk_allocated(task) false
> +
> +#define set_shstk_lock(task)
> +
> +#define set_shstk_status(task, enable)
> +
>  #endif /* CONFIG_RISCV_USER_CFI */
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 99acb6342a37..cd11667593fe 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -153,6 +153,14 @@ void start_thread(struct pt_regs *regs, unsigned lon=
g pc,
>         regs->epc =3D pc;
>         regs->sp =3D sp;
>
> +       /*
> +        * clear shadow stack state on exec.
> +        * libc will set it later via prctl.
> +        */
> +       set_shstk_status(current, false);
> +       set_shstk_base(current, 0, 0);
> +       set_active_shstk(current, 0);
> +
>  #ifdef CONFIG_64BIT
>         regs->status &=3D ~SR_UXL;
>
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> index 73cf87dab186..b93b324eed26 100644
> --- a/arch/riscv/kernel/usercfi.c
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -24,6 +24,16 @@ bool is_shstk_enabled(struct task_struct *task)
>         return task->thread_info.user_cfi_state.ubcfi_en ? true : false;
>  }
>
> +bool is_shstk_allocated(struct task_struct *task)
> +{
> +       return task->thread_info.user_cfi_state.shdw_stk_base ? true : fa=
lse;
> +}
> +
> +bool is_shstk_locked(struct task_struct *task)
> +{
> +       return task->thread_info.user_cfi_state.ubcfi_locked ? true : fal=
se;
> +}
> +
>  void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, =
unsigned long size)
>  {
>         task->thread_info.user_cfi_state.shdw_stk_base =3D shstk_addr;
> @@ -42,6 +52,26 @@ void set_active_shstk(struct task_struct *task, unsign=
ed long shstk_addr)
>         task->thread_info.user_cfi_state.user_shdw_stk =3D shstk_addr;
>  }
>
> +void set_shstk_status(struct task_struct *task, bool enable)
> +{
> +       if (!cpu_supports_shadow_stack())
> +               return;
> +
> +       task->thread_info.user_cfi_state.ubcfi_en =3D enable ? 1 : 0;
> +
> +       if (enable)
> +               task->thread.envcfg |=3D ENVCFG_SSE;
> +       else
> +               task->thread.envcfg &=3D ~ENVCFG_SSE;
> +
> +       csr_write(CSR_ENVCFG, task->thread.envcfg);
> +}
> +
> +void set_shstk_lock(struct task_struct *task)
> +{
> +       task->thread_info.user_cfi_state.ubcfi_locked =3D 1;
> +}
> +
>  /*
>   * If size is 0, then to be compatible with regular stack we want it to =
be as big as
>   * regular stack. Else PAGE_ALIGN it and return back
> @@ -262,3 +292,83 @@ void shstk_release(struct task_struct *tsk)
>         vm_munmap(base, size);
>         set_shstk_base(tsk, 0, 0);
>  }
> +
> +int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __=
user *status)
> +{
> +       unsigned long bcfi_status =3D 0;
> +
> +       if (!cpu_supports_shadow_stack())
> +               return -EINVAL;
> +
> +       /* this means shadow stack is enabled on the task */
> +       bcfi_status |=3D (is_shstk_enabled(t) ? PR_SHADOW_STACK_ENABLE : =
0);
> +
> +       return copy_to_user(status, &bcfi_status, sizeof(bcfi_status)) ? =
-EFAULT : 0;
> +}
> +
> +int arch_set_shadow_stack_status(struct task_struct *t, unsigned long st=
atus)
> +{
> +       unsigned long size =3D 0, addr =3D 0;
> +       bool enable_shstk =3D false;
> +
> +       if (!cpu_supports_shadow_stack())
> +               return -EINVAL;
> +
> +       /* Reject unknown flags */
> +       if (status & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
> +               return -EINVAL;
> +
> +       /* bcfi status is locked and further can't be modified by user */
> +       if (is_shstk_locked(t))
> +               return -EINVAL;
> +
> +       enable_shstk =3D status & PR_SHADOW_STACK_ENABLE;
> +       /* Request is to enable shadow stack and shadow stack is not enab=
led already */
> +       if (enable_shstk && !is_shstk_enabled(t)) {
> +               /* shadow stack was allocated and enable request again
> +                * no need to support such usecase and return EINVAL.
> +                */
> +               if (is_shstk_allocated(t))
> +                       return -EINVAL;
> +
> +               size =3D calc_shstk_size(0);
> +               addr =3D allocate_shadow_stack(0, size, 0, false);
> +               if (IS_ERR_VALUE(addr))
> +                       return -ENOMEM;
> +               set_shstk_base(t, addr, size);
> +               set_active_shstk(t, addr + size);
> +       }
> +
> +       /*
> +        * If a request to disable shadow stack happens, let's go ahead a=
nd release it
> +        * Although, if CLONE_VFORKed child did this, then in that case w=
e will end up
> +        * not releasing the shadow stack (because it might be needed in =
parent). Although
> +        * we will disable it for VFORKed child. And if VFORKed child tri=
es to enable again
> +        * then in that case, it'll get entirely new shadow stack because=
 following condition
> +        * are true
> +        *  - shadow stack was not enabled for vforked child
> +        *  - shadow stack base was anyways pointing to 0
> +        * This shouldn't be a big issue because we want parent to have a=
vailability of shadow
> +        * stack whenever VFORKed child releases resources via exit or ex=
ec but at the same
> +        * time we want VFORKed child to break away and establish new sha=
dow stack if it desires
> +        *
> +        */
> +       if (!enable_shstk)
> +               shstk_release(t);
> +
> +       set_shstk_status(t, enable_shstk);
> +       return 0;
> +}
> +
> +int arch_lock_shadow_stack_status(struct task_struct *task,
> +                                 unsigned long arg)
> +{
> +       /* If shtstk not supported or not enabled on task, nothing to loc=
k here */
> +       if (!cpu_supports_shadow_stack() ||
> +           !is_shstk_enabled(task) || arg !=3D 0)
> +               return -EINVAL;
> +
> +       set_shstk_lock(task);
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

