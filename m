Return-Path: <linux-fsdevel+bounces-29362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A039788EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 21:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015481C23502
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9714830D;
	Fri, 13 Sep 2024 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7Le8gbs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CECE12D773;
	Fri, 13 Sep 2024 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255571; cv=none; b=scyOysv2dbMJxEYM4VDYktXJvh0ZdN5gkp5Sc49/eYG0Lq7YITQxDjAcEITVPjBgjx7vtFhX95OWXrR0zxy3yEQAYdMh1epQepcOc/hM3X+GpWfxXL/+tFGxwQOfLyozR7LVgnumqmHI8nkFFOaSVd5Ck0F4mJBrcnPU72O6LdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255571; c=relaxed/simple;
	bh=hmsI6ba5wPoh1SX+s579olqleckQEv6rLckwDCtMoMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOVm6LIsX4lBkTWDUFTZzR0FO5Yq+ixY5fqO8/PmlrSIArrx8/rHo9O0xvC1bo8kXl2ge/Hlp7ro7/m9UlMTXWMB9u2wrqdI/jedwDZdT15Bvt20OU/BNGci87vm/V4cvTiOTjoVggGQT7S7T602nyfE2hRsLIIRCAd6hZiJ/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7Le8gbs; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1d0e74f484so2312495276.2;
        Fri, 13 Sep 2024 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726255569; x=1726860369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6beJARF+aSnbJbz8dieNkhAHHu1gphlJ9Cq9hvPspA=;
        b=d7Le8gbs9I0+xPhukcPIKA4vhJ7U5WhLxVl0fL/lcDhUGWL3A30xYj7GidJW7SULAn
         8IWNxHKG+f3ufQxqHfEdacbXvkq9XEEWRpU+b32iILvABckJU2l3Doxb8fv0rHKUoD3C
         GH/WEamjXJoHlZDpLlI2PDlQjnZRSaNkF+IeuIPb9sWwpQQGlDWYI0uuNm6vocw9s6ci
         AsZrwDUCcP3A1i8jvBwAvbnJD+EAs7oTYSkxqfFXunkqeXTfMMwGm+ryOcPFWspCBULi
         3q0y4HyAiNNVy4tJGj90d8tJxaAdmbAlKkOZfmK78SPbD0V9kbqH1EvCeAJjqPrOySXu
         2Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726255569; x=1726860369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6beJARF+aSnbJbz8dieNkhAHHu1gphlJ9Cq9hvPspA=;
        b=GmGGUTjR9Grb1CwIRo2MsOSjuqgqnW9u6OWferiebmyIjWHPJJvtmc4/agVr2Gt1lm
         l/tUqJyNU7fdKstGyw/cK38xVObBRk/mD9DErvVSNS76y1D+v57CffadHgMzKMahUMlv
         3wXOYB/5mchswfeEND8UIzEi6qjqYVJq3z8hhGPxxqR/+g1DhHNZ5kQRGXyD3QhSW74H
         qNJSDdrXYu7Rc0J8tMUvEvTe9cpHdAFelcsCC/C26aplVCpLYLv0dMYluUVTA9SQy8qX
         hjgdiisObzH7XwXKr0/S0ut73v8p00xwJC4ffT6m/Lj4b16NgSwkGObC6y7SRtmo4GDf
         aFYg==
X-Forwarded-Encrypted: i=1; AJvYcCUFmBB1NhgUiyMo2WgtLlCz/aDre9GhC+5Ko/8BOOzrcplwfV/b+zJCRkWVkeXz3HVkuxjGAwpHWuzP@vger.kernel.org, AJvYcCUjZKEi+sWtAx1Y1AwKETetuhExn8VuuNArmgXbonULKxoE9g6A/GfgP1ubUlDqa+Tj14S0CNLGrDyQsN0R@vger.kernel.org, AJvYcCUq94I3QGlrzPM2CT2hVzjy2gbiF8YDfsoOyEg8earObySLVr8bmshd2Nm/7GzRlth6wlXhKCbNeqWZNFGxcjIy@vger.kernel.org, AJvYcCVo8keVwDu1Ns3NeYh43DKrdZH50vyuqeX5JkN2c2tOMMalyRHjxP5QDlpzPNFpCoUi9+UQFOtlF8sF@vger.kernel.org, AJvYcCWUI1yUG/liYcJIceEcKT44i7Sjr/YzGGyRM4U+saDynnLs06SX0FH82HPPTDPhuMhhuJ4PksdszXSMvfA8uw==@vger.kernel.org, AJvYcCWYPWvqIylCRJbwTyuYLsFi+rNPOVaBIHejatkKOVazq5knw8SNOmQrI4VAe0V8cJL6D7fM2/ob1n9Iqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbaVsiyjzm+KdxsjR1MM/TLiuEEPCnBDoCYGjHVSJxvUGH5U+h
	RdcBC8HTrM3JchaASQTC4UxbOx0iRJ7niCea8/Ar7Y6YcZOBS1wV0iR3g7ecf+Pmae0eODQ39j/
	GgFWiImmLjN/mBDa4xcNHEyR6MYI=
X-Google-Smtp-Source: AGHT+IEaHpXovxEnTBSjD/xg0buYFRdzQjDsM5/+SmMZHsAbJwTRLOmuMTd6X44Az/uVBAlOZAGOdxuxMQH3SH6kTcY=
X-Received: by 2002:a05:6902:2413:b0:e1d:8a06:ac1e with SMTP id
 3f1490d57ef6-e1d9db991acmr6804493276.5.1726255568736; Fri, 13 Sep 2024
 12:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912231650.3740732-1-debug@rivosinc.com> <20240912231650.3740732-24-debug@rivosinc.com>
In-Reply-To: <20240912231650.3740732-24-debug@rivosinc.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Fri, 13 Sep 2024 21:25:57 +0200
Message-ID: <CAFTtA3ONu7CUNHwQf47ePMh9uvAi-uCV8B0YJAuFX+s0thC41Q@mail.gmail.com>
Subject: Re: [PATCH v4 23/30] riscv signal: save and restore of shadow stack
 for signal
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, palmer@sifive.com, conor@kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, quic_zhonhan@quicinc.com, zong.li@sifive.com, 
	zev@bewilderbeest.net, david@redhat.com, peterz@infradead.org, 
	catalin.marinas@arm.com, broonie@kernel.org, dave.hansen@linux.intel.com, 
	atishp@rivosinc.com, bjorn@rivosinc.com, namcaov@gmail.com, 
	usama.anjum@collabora.com, guoren@kernel.org, alx@kernel.org, 
	jszhang@kernel.org, hpa@zytor.com, puranjay@kernel.org, shuah@kernel.org, 
	sorear@fastmail.com, costa.shul@redhat.com, robh@kernel.org, 
	antonb@tenstorrent.com, quic_bjorande@quicinc.com, lorenzo.stoakes@oracle.com, 
	corbet@lwn.net, dawei.li@shingroup.cn, anup@brainfault.org, deller@gmx.de, 
	x86@kernel.org, andrii@kernel.org, willy@infradead.org, kees@kernel.org, 
	mingo@redhat.com, libang.li@antgroup.com, samitolvanen@google.com, 
	greentime.hu@sifive.com, osalvador@suse.de, ajones@ventanamicro.com, 
	revest@chromium.org, ancientmodern4@gmail.com, aou@eecs.berkeley.edu, 
	jerry.shih@sifive.com, alexghiti@rivosinc.com, arnd@arndb.de, 
	yang.lee@linux.alibaba.com, charlie@rivosinc.com, bgray@linux.ibm.com, 
	Liam.Howlett@oracle.com, leobras@redhat.com, songshuaishuai@tinylab.org, 
	xiao.w.wang@intel.com, bp@alien8.de, cuiyunhui@bytedance.com, 
	mchitale@ventanamicro.com, cleger@rivosinc.com, tglx@linutronix.de, 
	krzk+dt@kernel.org, vbabka@suse.cz, brauner@kernel.org, bhe@redhat.com, 
	ke.zhao@shingroup.cn, oleg@redhat.com, samuel.holland@sifive.com, 
	ben.dooks@codethink.co.uk, evan@rivosinc.com, palmer@dabbelt.com, 
	ebiederm@xmission.com, andy.chiu@sifive.com, schwab@suse.de, 
	akpm@linux-foundation.org, sameo@rivosinc.com, tanzhasanwork@gmail.com, 
	rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Deepak,

Deepak Gupta <debug@rivosinc.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:20=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Save shadow stack pointer in sigcontext structure while delivering signal=
.
> Restore shadow stack pointer from sigcontext on sigreturn.
>
> As part of save operation, kernel uses `ssamoswap` to save snapshot of
> current shadow stack on shadow stack itself (can be called as a save
> token). During restore on sigreturn, kernel retrieves token from top of
> shadow stack and validates it. This allows that user mode can't arbitrary
> pivot to any shadow stack address without having a token and thus provide
> strong security assurance between signaly delivery and sigreturn window.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Suggested-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>  arch/riscv/include/asm/usercfi.h | 19 ++++++++++
>  arch/riscv/kernel/signal.c       | 62 +++++++++++++++++++++++++++++++-
>  arch/riscv/kernel/usercfi.c      | 57 +++++++++++++++++++++++++++++
>  3 files changed, 137 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/us=
ercfi.h
> index 20a9102cce51..d5050a5df26c 100644
> --- a/arch/riscv/include/asm/usercfi.h
> +++ b/arch/riscv/include/asm/usercfi.h
> @@ -8,6 +8,7 @@
>  #ifndef __ASSEMBLY__
>  #include <linux/types.h>
>  #include <linux/prctl.h>
> +#include <linux/errno.h>
>
>  struct task_struct;
>  struct kernel_clone_args;
> @@ -35,6 +36,9 @@ bool is_shstk_locked(struct task_struct *task);
>  bool is_shstk_allocated(struct task_struct *task);
>  void set_shstk_lock(struct task_struct *task);
>  void set_shstk_status(struct task_struct *task, bool enable);
> +unsigned long get_active_shstk(struct task_struct *task);
> +int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)=
;
> +int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_=
ptr);
>  bool is_indir_lp_enabled(struct task_struct *task);
>  bool is_indir_lp_locked(struct task_struct *task);
>  void set_indir_lp_status(struct task_struct *task, bool enable);
> @@ -96,6 +100,21 @@ static inline void set_shstk_status(struct task_struc=
t *task, bool enable)
>
>  }
>
> +static inline int restore_user_shstk(struct task_struct *tsk, unsigned l=
ong shstk_ptr)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline int save_user_shstk(struct task_struct *tsk, unsigned long=
 *saved_shstk_ptr)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline unsigned long get_active_shstk(struct task_struct *task)
> +{
> +       return 0;
> +}
> +
>  static inline bool is_indir_lp_enabled(struct task_struct *task)
>  {
>         return false;
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index dcd282419456..7d5c1825650f 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -22,6 +22,7 @@
>  #include <asm/vector.h>
>  #include <asm/csr.h>
>  #include <asm/cacheflush.h>
> +#include <asm/usercfi.h>
>
>  unsigned long signal_minsigstksz __ro_after_init;
>
> @@ -153,6 +154,16 @@ static long restore_sigcontext(struct pt_regs *regs,
>         void __user *sc_ext_ptr =3D &sc->sc_extdesc.hdr;
>         __u32 rsvd;
>         long err;
> +       unsigned long ss_ptr =3D 0;
> +       struct __sc_riscv_cfi_state __user *sc_cfi =3D NULL;
> +
> +       sc_cfi =3D (struct __sc_riscv_cfi_state *)
> +                ((unsigned long) sc_ext_ptr + sizeof(struct __riscv_ctx_=
hdr));
> +
> +       if (has_vector() && riscv_v_vstate_query(regs))
> +               sc_cfi =3D (struct __sc_riscv_cfi_state *)
> +                        ((unsigned long) sc_cfi + riscv_v_sc_size);
> +
>         /* sc_regs is structured the same as the start of pt_regs */
>         err =3D __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs))=
;
>         if (unlikely(err))
> @@ -172,6 +183,24 @@ static long restore_sigcontext(struct pt_regs *regs,
>         if (unlikely(rsvd))
>                 return -EINVAL;
>
> +       /*
> +        * Restore shadow stack as a form of token stored on shadow stack=
 itself as a safe
> +        * way to restore.
> +        * A token on shadow gives following properties
> +        *      - Safe save and restore for shadow stack switching. Any s=
ave of shadow stack
> +        *        must have had saved a token on shadow stack. Similarly =
any restore of shadow
> +        *        stack must check the token before restore. Since writin=
g to shadow stack with
> +        *        address of shadow stack itself is not easily allowed. A=
 restore without a save
> +        *        is quite difficult for an attacker to perform.
> +        *      - A natural break. A token in shadow stack provides a nat=
ural break in shadow stack
> +        *        So a single linear range can be bucketed into different=
 shadow stack segments.
> +        *        sspopchk will detect the condition and fault to kernel =
as sw check exception.
> +        */
> +       if (is_shstk_enabled(current)) {
> +               err |=3D __copy_from_user(&ss_ptr, &sc_cfi->ss_ptr, sizeo=
f(unsigned long));
> +               err |=3D restore_user_shstk(current, ss_ptr);
> +       }
> +
>         while (!err) {
>                 __u32 magic, size;
>                 struct __riscv_ctx_hdr __user *head =3D sc_ext_ptr;
> @@ -215,6 +244,10 @@ static size_t get_rt_frame_size(bool cal_all)
>                 if (cal_all || riscv_v_vstate_query(task_pt_regs(current)=
))
>                         total_context_size +=3D riscv_v_sc_size;
>         }
> +
> +       if (is_shstk_enabled(current))
> +               total_context_size +=3D sizeof(struct __sc_riscv_cfi_stat=
e);
> +
>         /*
>          * Preserved a __riscv_ctx_hdr for END signal context header if a=
n
>          * extension uses __riscv_extra_ext_header
> @@ -276,18 +309,40 @@ static long setup_sigcontext(struct rt_sigframe __u=
ser *frame,
>  {
>         struct sigcontext __user *sc =3D &frame->uc.uc_mcontext;
>         struct __riscv_ctx_hdr __user *sc_ext_ptr =3D &sc->sc_extdesc.hdr=
;
> +       unsigned long ss_ptr =3D 0;
> +       struct __sc_riscv_cfi_state __user *sc_cfi =3D NULL;
>         long err;
>
> +       sc_cfi =3D (struct __sc_riscv_cfi_state *) (sc_ext_ptr + 1);
> +

Is it intended that cfi sigcontext does not follow the sigcontext rule
setup by Vector? It seems like there is no extension header (struct
__riscv_ctx_hdr) defined for cfi sigcontext here. If the sigcontext is
directly appended to the signal stack, the user may not be able to
recognize the meaning without defining a new ABI.

BTW, I have sent a patch[1] that refactor setup_sigcontext so it'd be
easier for future extensions to expand on the signal stack.

>         /* sc_regs is structured the same as the start of pt_regs */
>         err =3D __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
>         /* Save the floating-point state. */
>         if (has_fpu())
>                 err |=3D save_fp_state(regs, &sc->sc_fpregs);
>         /* Save the vector state. */
> -       if (has_vector() && riscv_v_vstate_query(regs))
> +       if (has_vector() && riscv_v_vstate_query(regs)) {
>                 err |=3D save_v_state(regs, (void __user **)&sc_ext_ptr);
> +               sc_cfi =3D (struct __sc_riscv_cfi_state *) ((unsigned lon=
g) sc_cfi + riscv_v_sc_size);
> +       }
>         /* Write zero to fp-reserved space and check it on restore_sigcon=
text */
>         err |=3D __put_user(0, &sc->sc_extdesc.reserved);
> +       /*
> +        * Save a pointer to shadow stack itself on shadow stack as a for=
m of token.
> +        * A token on shadow gives following properties
> +        *      - Safe save and restore for shadow stack switching. Any s=
ave of shadow stack
> +        *        must have had saved a token on shadow stack. Similarly =
any restore of shadow
> +        *        stack must check the token before restore. Since writin=
g to shadow stack with
> +        *        address of shadow stack itself is not easily allowed. A=
 restore without a save
> +        *        is quite difficult for an attacker to perform.
> +        *      - A natural break. A token in shadow stack provides a nat=
ural break in shadow stack
> +        *        So a single linear range can be bucketed into different=
 shadow stack segments. Any
> +        *        sspopchk will detect the condition and fault to kernel =
as sw check exception.
> +        */
> +       if (is_shstk_enabled(current)) {
> +               err |=3D save_user_shstk(current, &ss_ptr);
> +               err |=3D __put_user(ss_ptr, &sc_cfi->ss_ptr);
> +       }
>         /* And put END __riscv_ctx_hdr at the end. */
>         err |=3D __put_user(END_MAGIC, &sc_ext_ptr->magic);
>         err |=3D __put_user(END_HDR_SIZE, &sc_ext_ptr->size);
> @@ -345,6 +400,11 @@ static int setup_rt_frame(struct ksignal *ksig, sigs=
et_t *set,
>  #ifdef CONFIG_MMU
>         regs->ra =3D (unsigned long)VDSO_SYMBOL(
>                 current->mm->context.vdso, rt_sigreturn);
> +
> +       /* if bcfi is enabled x1 (ra) and x5 (t0) must match. not sure if=
 we need this? */
> +       if (is_shstk_enabled(current))
> +               regs->t0 =3D regs->ra;
> +
>  #else
>         /*
>          * For the nommu case we don't have a VDSO.  Instead we push two
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> index 8da509afdbe9..40c32258b6ec 100644
> --- a/arch/riscv/kernel/usercfi.c
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -52,6 +52,11 @@ void set_active_shstk(struct task_struct *task, unsign=
ed long shstk_addr)
>         task->thread_info.user_cfi_state.user_shdw_stk =3D shstk_addr;
>  }
>
> +unsigned long get_active_shstk(struct task_struct *task)
> +{
> +       return task->thread_info.user_cfi_state.user_shdw_stk;
> +}
> +
>  void set_shstk_status(struct task_struct *task, bool enable)
>  {
>         task->thread_info.user_cfi_state.ubcfi_en =3D enable ? 1 : 0;
> @@ -164,6 +169,58 @@ static int create_rstor_token(unsigned long ssp, uns=
igned long *token_addr)
>         return 0;
>  }
>
> +/*
> + * Save user shadow stack pointer on shadow stack itself and return poin=
ter to saved location
> + * returns -EFAULT if operation was unsuccessful
> + */
> +int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_=
ptr)
> +{
> +       unsigned long ss_ptr =3D 0;
> +       unsigned long token_loc =3D 0;
> +       int ret =3D 0;
> +
> +       if (saved_shstk_ptr =3D=3D NULL)
> +               return -EINVAL;
> +
> +       ss_ptr =3D get_active_shstk(tsk);
> +       ret =3D create_rstor_token(ss_ptr, &token_loc);
> +
> +       if (!ret) {
> +               *saved_shstk_ptr =3D token_loc;
> +               set_active_shstk(tsk, token_loc);
> +       }
> +
> +       return ret;
> +}
> +
> +/*
> + * Restores user shadow stack pointer from token on shadow stack for tas=
k `tsk`
> + * returns -EFAULT if operation was unsuccessful
> + */
> +int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)
> +{
> +       unsigned long token =3D 0;
> +
> +       token =3D amo_user_shstk((unsigned long __user *)shstk_ptr, 0);
> +
> +       if (token =3D=3D -1)
> +               return -EFAULT;
> +
> +       /* invalid token, return EINVAL */
> +       if ((token - shstk_ptr) !=3D SHSTK_ENTRY_SIZE) {
> +               pr_info_ratelimited(
> +                               "%s[%d]: bad restore token in %s: pc=3D%p=
 sp=3D%p, token=3D%p, shstk_ptr=3D%p\n",
> +                               tsk->comm, task_pid_nr(tsk), __func__,
> +                               (void *)(task_pt_regs(tsk)->epc), (void *=
)(task_pt_regs(tsk)->sp),
> +                               (void *)token, (void *)shstk_ptr);
> +               return -EINVAL;
> +       }
> +
> +       /* all checks passed, set active shstk and return success */
> +       set_active_shstk(tsk, token);
> +       return 0;
> +}
> +
>  static unsigned long allocate_shadow_stack(unsigned long addr, unsigned =
long size,
>                                 unsigned long token_offset,
>                                 bool set_tok)
> --
> 2.45.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

- [1]: https://lore.kernel.org/all/20240628-dev-signal-refactor-v1-1-0c391b=
260261@sifive.com/

Thanks,
Andy

