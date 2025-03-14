Return-Path: <linux-fsdevel+bounces-44004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B0A60B53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 09:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBB51749BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 08:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0A91A5B82;
	Fri, 14 Mar 2025 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gytbqIqv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D31957E4
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940773; cv=none; b=imUhPY2+InCIppmIvBuUCFF5fbz4qViGswoc06S/koZ1M0u3KB6V8xAkMiyoS4zx5AO62aUxJtImgQgqYBpp+Qy+ClwPpddVB+nXho0MJ8rWV2/YCrmcGAu+SDJjtw1jxziCjVH6OgQXu98gKsY5KFJHFr4tPLpI6h+oTwvekvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940773; c=relaxed/simple;
	bh=BImU62aPrPj4pLX2GWuGbB5M1kn+CRgvRsXxyzcuPyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IML+HjG7FR+1WFLZabmV3W9JUBNf6MzjLZTqIeLRBTpwApMZ/s27n0MSt4J929ZyqIXdQ0u9Wc5lsaKh2TEkRMoqGr9rf6eduuDGJIrkkfd2t/rIsfjiLV+0yp18jLpwI5857iCGVLg2IKtwH+vGfbmNI//8GduDI43H72iPsMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gytbqIqv; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85afd2b911aso68262239f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741940770; x=1742545570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFBqxcyHmYrKZ5CeeWDkGHLMtgfSG5xm6fdVTs4Uk9M=;
        b=gytbqIqv3OjA7KnYFAbWg8zNtrmjhhZOadXpYc6Yc0WausxHt+fiOuwa0F/9pzi9rY
         X+X7OMm2KZlKLbpsr1/1qVj4WZgL6+MH4frrYIqUc3hYp5GFvakkJMRD461Eul+ecvQH
         Kn2WZ+Bm704z1vMehn+t/VLYAiSTeyI71Cedx/TqEEKJLIwYXsczRJK7xNe1cqDKgJd8
         45SdApJsjaYQ5KuNdDcBDemUChF7SAY36hy9cBJvYns2V7H5dIte/pgmYH9n7plE0eFj
         siUq6ZFGdReyLEB3iI30EKfi+TsL/bZQrH+f1w37Nqm5+h5DttfIRP6+a/RjUIHzaqPf
         HtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741940770; x=1742545570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFBqxcyHmYrKZ5CeeWDkGHLMtgfSG5xm6fdVTs4Uk9M=;
        b=v3cZVP0Uq9ywnSLZgTA6idxLvStXhcdNR+n4Aoq1zhF6IyEI184CgfS31V6ZdsasC0
         o0SY0AG23zEt4PrvLEpAD20W6CDwfBKAFarTxYY0nhTqgCpaJQPkx8W45QuCEOYD3dGA
         vqg4W4am0Zg5B/xfWYoMJx7tYAxlciwtYCdUKAbhhd5FbmBIIEIyQ1XqXFX1Dp4xkLHU
         tY+NC0cxlaxdub+kinphL+XIwgL08ISQq2udspALAF0xdd5SOLnlRLLMYytsnku7vpCB
         s+5fWleM5+h8LP2fl5vqEyP4NQ+exaGdYxGFdS3+O4iub/quNAufUvITSvMxs0Lo48FQ
         s0uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnLE3sncpMiEGb2C/EJh1D50MC6Hgx5IWTT06gsIxPnv5Z2FoPpN/RbWeLiRSm1XrlR+QGg6ubPN6NdKbk@vger.kernel.org
X-Gm-Message-State: AOJu0YxwiRH1LSkPTZzhctxnSM32ZJKEOq0TnPK/3zzK7mK2sYMCD/so
	VK95Hj/o/iZC7mncaiggfQD5oM97mOq36TEcvfzPnUOzj9GaTOYS4SuRroic9g8W2Nz/GKujjyU
	OKzl2UhKwk8sxu9TbFchZJpGvacOLh406VNgdiA==
X-Gm-Gg: ASbGnctSTl0U6icyeW9yVBiyHwcXK9hU171WLIUec71Rz+QxKhRXXzudhNtPh+Oz9dB
	jlwujEzyYAuTOhIP2QSm1dyyqyRb030qc0UIIccHfO3exMjJ+qjOObfj6Z6qZ07g+Tf+FN8SN33
	OAgzv8Bt/1vgHWwxeKEsyV3bFT/AGVfjXzJg6EaA==
X-Google-Smtp-Source: AGHT+IHmSCGAzZxmTnBk7MXVzTw1qzESoE4LhRvbcrXSorktNy4ZRhz+uxQ6Mf+uq1bo4tboFsnErwawS40GnQpS2RM=
X-Received: by 2002:a05:6e02:170d:b0:3d3:eeec:8a0b with SMTP id
 e9e14a558f8ab-3d483a25083mr11623635ab.10.1741940769881; Fri, 14 Mar 2025
 01:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-13-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-13-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:25:59 +0800
X-Gm-Features: AQ5f1JrgyyKY0dBFW7yldm9HxW3CrPyd2-B_tuI2-7Cjq10tI4uDUrJdMcVX0K4
Message-ID: <CANXhq0r1dd2jCtCbinD4iy9rx+oQ+VDMWjATf1GqxEmuvFzyWw@mail.gmail.com>
Subject: Re: [PATCH v11 13/27] prctl: arch-agnostic prctl for indirect branch tracking
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
> Three architectures (x86, aarch64, riscv) have support for indirect branc=
h
> tracking feature in a very similar fashion. On a very high level, indirec=
t
> branch tracking is a CPU feature where CPU tracks branches which uses
> memory operand to perform control transfer in program. As part of this
> tracking on indirect branches, CPU goes in a state where it expects a
> landing pad instr on target and if not found then CPU raises some fault
> (architecture dependent)
>
> x86 landing pad instr - `ENDBRANCH`
> aarch64 landing pad instr - `BTI`
> riscv landing instr - `lpad`
>
> Given that three major arches have support for indirect branch tracking,
> This patch makes `prctl` for indirect branch tracking arch agnostic.
>
> To allow userspace to enable this feature for itself, following prtcls ar=
e
> defined:
>  - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect
>    branch tracking.
>  - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch
>    tracking.
>    Following status options are allowed
>        - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
>          thread.
>        - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on use=
r
>          thread.
>  - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branc=
h
>    tracking for user thread.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/riscv/include/asm/usercfi.h | 16 ++++++++-
>  arch/riscv/kernel/entry.S        |  2 +-
>  arch/riscv/kernel/process.c      |  5 +++
>  arch/riscv/kernel/usercfi.c      | 76 ++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/cpu.h              |  4 +++
>  include/uapi/linux/prctl.h       | 27 ++++++++++++++
>  kernel/sys.c                     | 30 ++++++++++++++++
>  7 files changed, 158 insertions(+), 2 deletions(-)
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

In set_indir_lp_status and set_shstk_status, the $senvcfg.LPE and
$senvcfg.SSE fields are set. However, if the CPU does not support this
CSR, writing to it will trigger an illegal instruction exception.
Should we add sanity checks to handle this situation? Thanks
>
>  #ifdef CONFIG_64BIT
>         regs->status &=3D ~SR_UXL;
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> index 37d6fb8144e7..3a66f149a4ef 100644
> --- a/arch/riscv/kernel/usercfi.c
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -69,6 +69,32 @@ void set_shstk_lock(struct task_struct *task)
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
> @@ -369,3 +395,53 @@ int arch_lock_shadow_stack_status(struct task_struct=
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
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 6a0a8f1c7c90..fb0c394430c6 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -204,4 +204,8 @@ static inline bool cpu_mitigations_auto_nosmt(void)
>  }
>  #endif
>
> +int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __u=
ser *status);
> +int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long sta=
tus);
> +int arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long st=
atus);
> +
>  #endif /* _LINUX_CPU_H_ */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 5c6080680cb2..6cd90460cbad 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -353,4 +353,31 @@ struct prctl_mm_map {
>   */
>  #define PR_LOCK_SHADOW_STACK_STATUS      76
>
> +/*
> + * Get the current indirect branch tracking configuration for the curren=
t
> + * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STAT=
US.
> + */
> +#define PR_GET_INDIR_BR_LP_STATUS      77
> +
> +/*
> + * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE=
 will
> + * enable cpu feature for user thread, to track all indirect branches an=
d ensure
> + * they land on arch defined landing pad instruction.
> + * x86 - If enabled, an indirect branch must land on `ENDBRANCH` instruc=
tion.
> + * arch64 - If enabled, an indirect branch must land on `BTI` instructio=
n.
> + * riscv - If enabled, an indirect branch must land on `lpad` instructio=
n.
> + * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indir=
ect
> + * branches will no more be tracked by cpu to land on arch defined landi=
ng pad
> + * instruction.
> + */
> +#define PR_SET_INDIR_BR_LP_STATUS      78
> +# define PR_INDIR_BR_LP_ENABLE            (1UL << 0)
> +
> +/*
> + * Prevent further changes to the specified indirect branch tracking
> + * configuration.  All bits may be locked via this call, including
> + * undefined bits.
> + */
> +#define PR_LOCK_INDIR_BR_LP_STATUS      79
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index cb366ff8703a..f347f3518d0b 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2336,6 +2336,21 @@ int __weak arch_lock_shadow_stack_status(struct ta=
sk_struct *t, unsigned long st
>         return -EINVAL;
>  }
>
> +int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned l=
ong __user *status)
> +{
> +       return -EINVAL;
> +}
> +
> +int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned l=
ong status)
> +{
> +       return -EINVAL;
> +}
> +
> +int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned =
long status)
> +{
> +       return -EINVAL;
> +}
> +
>  #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
>
>  #ifdef CONFIG_ANON_VMA_NAME
> @@ -2811,6 +2826,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
>                         return -EINVAL;
>                 error =3D arch_lock_shadow_stack_status(me, arg2);
>                 break;
> +       case PR_GET_INDIR_BR_LP_STATUS:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error =3D arch_get_indir_br_lp_status(me, (unsigned long =
__user *)arg2);
> +               break;
> +       case PR_SET_INDIR_BR_LP_STATUS:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error =3D arch_set_indir_br_lp_status(me, arg2);
> +               break;
> +       case PR_LOCK_INDIR_BR_LP_STATUS:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error =3D arch_lock_indir_br_lp_status(me, arg2);
> +               break;
>         default:
>                 trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
>                 error =3D -EINVAL;
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

