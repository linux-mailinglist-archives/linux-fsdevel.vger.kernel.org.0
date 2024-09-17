Return-Path: <linux-fsdevel+bounces-29609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6413097B591
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 00:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD57CB229E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 22:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B60018D64C;
	Tue, 17 Sep 2024 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEDTNlL2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67D0A29;
	Tue, 17 Sep 2024 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726610639; cv=none; b=oB0oFE/ZEcfgssiw7U6se35OHHHncSrn7n65TNtHHW/jduTlBwaVAFQxDOpaYOPkhle9zUz01m8T81v1lbX/hrnT9KluB68BK2SYx0T5hsUU27rHd+tFrKegahd3pFtU3PqQxpjSHgCXlNLVLNQTAZcMzWuZz7o3rcCONKJpKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726610639; c=relaxed/simple;
	bh=+YALBx47ePL7IrGX334gCt7+CcIaWQS5D2uZGYRx0LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uN7YMMHkyRMIbLsXTeYdp9VnFoGRz/8L/mPdcMMPwXN8zU2yrBh514ulhcXmLprT+P+i0p49XFljmzHyeVKdrqu5K+U1eEllYdy7JXVDHJu1lJAdbGNMgYcNnSWqouCvo3N4LSGa8zxY8hu/0bXyoCwg7DbvUhfLcfhxqV3wfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEDTNlL2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e1f139b97b5so166851276.0;
        Tue, 17 Sep 2024 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726610637; x=1727215437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh2oyMLt27KGY5wYy4lH9DNRni9rJmyCl/EBJ9/WitY=;
        b=dEDTNlL2EDArYhf8aKn3R3oeYXCMnvDQ1dESaS0kR5ujlxE8GsVLP07hSxLTjRwD5E
         F7GgBEwTeU9A7NiP2SQAc/D3se3mclqi2AuHxR5sLmbYR7JdYcnxe0hPmBCIhU2lv88k
         srI3Ze4IQNS3xl+GGbzsTMU+TH6QxBxYnUiy5pl53MsTUuo5KBhIt0164ZKFJ5qP08DV
         EHtoFKqYHaPy+IlxZcv9mTB2ewSyjQZRQ9O5eQbbYpbpa8Jt9l824Pl3Qx/XraPx3E0/
         MOgQJPd9OkxYXGVINXNogItijNgXr7VqO4STy0UpFoirfOye0lKoeTNWNMgLVBn2tuiR
         zT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726610637; x=1727215437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xh2oyMLt27KGY5wYy4lH9DNRni9rJmyCl/EBJ9/WitY=;
        b=fGdu2Von5M9jpfCGSIk9tgpLEXMfMXsDsDDZFhzrtNOaEfeOFc8WuWvmoWgAySbW3i
         bArflRNRSkVIHiWu3KianhRRCOmaH/+umOrjGfdVckAf0060QoylLtfUeS7uj3/rbv+Y
         xSy4I9SvLSzfQFaOYJSXLsvYhaAE7veOrkXyIkZYA00eKwiIq2KrPBLum2mfv6qtU0KS
         /EbbsYn8rxdv/FXxUSDLkHAnBsOz4PhCj63wbjT/eSIGC1xLEW3HAnwD4LCs957tMZoU
         nYkw8WKVbp/xb3zSsTDmFrXX07o3cOniy8/PBO7H96xy3tlIXeFwGwVo6SuTi3g+mZx9
         D5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUT8snQSkK3/bLIwXgQufX3Q+ygsFjzhHU1b1McdgcfLUPj+H14aE5ST47ni05Jj26elubOGFw/9jY2/qeJ@vger.kernel.org, AJvYcCVe3fUkvfpVh9msMyfwppJOia8may6QKqoHUrHIl06Q2tD054azHUIl+sebWAOZrlP0RxaQ2lUdpZDEe4h1nApw@vger.kernel.org, AJvYcCWEwWMkinDaBRsXibtmX1HfmnWQ2cbxf2JKTRYjsd9903cCVdskydm/cOtw2T8Cc7qbBMs/w1gZbBBc@vger.kernel.org, AJvYcCWmFDFAWL+mJndaIXGcpZCgyK1JycJkPviaaNGz+mY2uARjpfzEjwthrD26ND9Dn52e3qpCsxLESR5b@vger.kernel.org, AJvYcCXEuDLjyjQHr0T0IRtQb5sLbBiKnIlEdus7rf+1PYxHAit1SQHRQosDlWkwtJxlzGupzfqCs22YcECdG220zQ==@vger.kernel.org, AJvYcCXl1BlblJbuRdk0eL8kmOcS3QVvKqIs1sVUzTcomkGYG8g+Xz6OcRrg9dU393Hlps3SQX1thSztZkgJjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xC8Q5pn4ApLyXo5HEc7zhqKi8hLilqoRLt1MX1gopd5u+tTL
	QJfOsFuJTshbvyKljfOzipigUxB2VeKvxgA3bV54Xx+OYx29fiNNly8bd+i6WqNedVSVX9tnW1C
	pS/u22BZy3/Y8tHA+wg2x6AQpOFs=
X-Google-Smtp-Source: AGHT+IGdSc8RRMW0gKX7milUELby8xxu8FYFmuJQijJp02Mur1Dl9G2v+NTJf9N8dW3MCk2HaByAebPcPsO244l2DLA=
X-Received: by 2002:a05:6902:10c4:b0:e1d:2fcc:6e4 with SMTP id
 3f1490d57ef6-e1d9e1a5461mr14715043276.22.1726610636601; Tue, 17 Sep 2024
 15:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912231650.3740732-1-debug@rivosinc.com> <20240912231650.3740732-24-debug@rivosinc.com>
 <CAFTtA3ONu7CUNHwQf47ePMh9uvAi-uCV8B0YJAuFX+s0thC41Q@mail.gmail.com> <ZuirLvsl6gukn/SG@debug.ba.rivosinc.com>
In-Reply-To: <ZuirLvsl6gukn/SG@debug.ba.rivosinc.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 18 Sep 2024 00:03:45 +0200
Message-ID: <CAFTtA3OX-iB03Y5FPN=EGe4pqGtxff83Nk-w-xka29o2cMNzew@mail.gmail.com>
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

Deepak Gupta <debug@rivosinc.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=8817=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Sep 13, 2024 at 09:25:57PM +0200, Andy Chiu wrote:
> >Hi Deepak,
> >
> >Deepak Gupta <debug@rivosinc.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=8813=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=881:20=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> Save shadow stack pointer in sigcontext structure while delivering sig=
nal.
> >> Restore shadow stack pointer from sigcontext on sigreturn.
> >>
> >> As part of save operation, kernel uses `ssamoswap` to save snapshot of
> >> current shadow stack on shadow stack itself (can be called as a save
> >> token). During restore on sigreturn, kernel retrieves token from top o=
f
> >> shadow stack and validates it. This allows that user mode can't arbitr=
ary
> >> pivot to any shadow stack address without having a token and thus prov=
ide
> >> strong security assurance between signaly delivery and sigreturn windo=
w.
> >>
> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >> Suggested-by: Andy Chiu <andy.chiu@sifive.com>
> >> ---
> >>  arch/riscv/include/asm/usercfi.h | 19 ++++++++++
> >>  arch/riscv/kernel/signal.c       | 62 +++++++++++++++++++++++++++++++=
-
> >>  arch/riscv/kernel/usercfi.c      | 57 +++++++++++++++++++++++++++++
> >>  3 files changed, 137 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm=
/usercfi.h
> >> index 20a9102cce51..d5050a5df26c 100644
> >> --- a/arch/riscv/include/asm/usercfi.h
> >> +++ b/arch/riscv/include/asm/usercfi.h
> >> @@ -8,6 +8,7 @@
> >>  #ifndef __ASSEMBLY__
> >>  #include <linux/types.h>
> >>  #include <linux/prctl.h>
> >> +#include <linux/errno.h>
> >>
> >>  struct task_struct;
> >>  struct kernel_clone_args;
> >> @@ -35,6 +36,9 @@ bool is_shstk_locked(struct task_struct *task);
> >>  bool is_shstk_allocated(struct task_struct *task);
> >>  void set_shstk_lock(struct task_struct *task);
> >>  void set_shstk_status(struct task_struct *task, bool enable);
> >> +unsigned long get_active_shstk(struct task_struct *task);
> >> +int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_p=
tr);
> >> +int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shs=
tk_ptr);
> >>  bool is_indir_lp_enabled(struct task_struct *task);
> >>  bool is_indir_lp_locked(struct task_struct *task);
> >>  void set_indir_lp_status(struct task_struct *task, bool enable);
> >> @@ -96,6 +100,21 @@ static inline void set_shstk_status(struct task_st=
ruct *task, bool enable)
> >>
> >>  }
> >>
> >> +static inline int restore_user_shstk(struct task_struct *tsk, unsigne=
d long shstk_ptr)
> >> +{
> >> +       return -EINVAL;
> >> +}
> >> +
> >> +static inline int save_user_shstk(struct task_struct *tsk, unsigned l=
ong *saved_shstk_ptr)
> >> +{
> >> +       return -EINVAL;
> >> +}
> >> +
> >> +static inline unsigned long get_active_shstk(struct task_struct *task=
)
> >> +{
> >> +       return 0;
> >> +}
> >> +
> >>  static inline bool is_indir_lp_enabled(struct task_struct *task)
> >>  {
> >>         return false;
> >> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> >> index dcd282419456..7d5c1825650f 100644
> >> --- a/arch/riscv/kernel/signal.c
> >> +++ b/arch/riscv/kernel/signal.c
> >> @@ -22,6 +22,7 @@
> >>  #include <asm/vector.h>
> >>  #include <asm/csr.h>
> >>  #include <asm/cacheflush.h>
> >> +#include <asm/usercfi.h>
> >>
> >>  unsigned long signal_minsigstksz __ro_after_init;
> >>
> >> @@ -153,6 +154,16 @@ static long restore_sigcontext(struct pt_regs *re=
gs,
> >>         void __user *sc_ext_ptr =3D &sc->sc_extdesc.hdr;
> >>         __u32 rsvd;
> >>         long err;
> >> +       unsigned long ss_ptr =3D 0;
> >> +       struct __sc_riscv_cfi_state __user *sc_cfi =3D NULL;
> >> +
> >> +       sc_cfi =3D (struct __sc_riscv_cfi_state *)
> >> +                ((unsigned long) sc_ext_ptr + sizeof(struct __riscv_c=
tx_hdr));
> >> +
> >> +       if (has_vector() && riscv_v_vstate_query(regs))
> >> +               sc_cfi =3D (struct __sc_riscv_cfi_state *)
> >> +                        ((unsigned long) sc_cfi + riscv_v_sc_size);
> >> +
> >>         /* sc_regs is structured the same as the start of pt_regs */
> >>         err =3D __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_reg=
s));
> >>         if (unlikely(err))
> >> @@ -172,6 +183,24 @@ static long restore_sigcontext(struct pt_regs *re=
gs,
> >>         if (unlikely(rsvd))
> >>                 return -EINVAL;
> >>
> >> +       /*
> >> +        * Restore shadow stack as a form of token stored on shadow st=
ack itself as a safe
> >> +        * way to restore.
> >> +        * A token on shadow gives following properties
> >> +        *      - Safe save and restore for shadow stack switching. An=
y save of shadow stack
> >> +        *        must have had saved a token on shadow stack. Similar=
ly any restore of shadow
> >> +        *        stack must check the token before restore. Since wri=
ting to shadow stack with
> >> +        *        address of shadow stack itself is not easily allowed=
. A restore without a save
> >> +        *        is quite difficult for an attacker to perform.
> >> +        *      - A natural break. A token in shadow stack provides a =
natural break in shadow stack
> >> +        *        So a single linear range can be bucketed into differ=
ent shadow stack segments.
> >> +        *        sspopchk will detect the condition and fault to kern=
el as sw check exception.
> >> +        */
> >> +       if (is_shstk_enabled(current)) {
> >> +               err |=3D __copy_from_user(&ss_ptr, &sc_cfi->ss_ptr, si=
zeof(unsigned long));
> >> +               err |=3D restore_user_shstk(current, ss_ptr);
> >> +       }
> >> +
> >>         while (!err) {
> >>                 __u32 magic, size;
> >>                 struct __riscv_ctx_hdr __user *head =3D sc_ext_ptr;
> >> @@ -215,6 +244,10 @@ static size_t get_rt_frame_size(bool cal_all)
> >>                 if (cal_all || riscv_v_vstate_query(task_pt_regs(curre=
nt)))
> >>                         total_context_size +=3D riscv_v_sc_size;
> >>         }
> >> +
> >> +       if (is_shstk_enabled(current))
> >> +               total_context_size +=3D sizeof(struct __sc_riscv_cfi_s=
tate);
> >> +
> >>         /*
> >>          * Preserved a __riscv_ctx_hdr for END signal context header i=
f an
> >>          * extension uses __riscv_extra_ext_header
> >> @@ -276,18 +309,40 @@ static long setup_sigcontext(struct rt_sigframe =
__user *frame,
> >>  {
> >>         struct sigcontext __user *sc =3D &frame->uc.uc_mcontext;
> >>         struct __riscv_ctx_hdr __user *sc_ext_ptr =3D &sc->sc_extdesc.=
hdr;
> >> +       unsigned long ss_ptr =3D 0;
> >> +       struct __sc_riscv_cfi_state __user *sc_cfi =3D NULL;
> >>         long err;
> >>
> >> +       sc_cfi =3D (struct __sc_riscv_cfi_state *) (sc_ext_ptr + 1);
> >> +
> >
> >Is it intended that cfi sigcontext does not follow the sigcontext rule
> >setup by Vector? It seems like there is no extension header (struct
> >__riscv_ctx_hdr) defined for cfi sigcontext here. If the sigcontext is
> >directly appended to the signal stack, the user may not be able to
> >recognize the meaning without defining a new ABI.
>
> Hmm... I didn't realize that struct `struct __riscv_ctx_hdr` is strongly
> tied to vector state. I was under the impression that any new extended
> state addition would require this header to be present.

__riscv_ctx_hdr is not tied to vector state. Your impression is not
wrong. When sigcontext for Vector was designed, it is intended that
every new extension should define its header, please check
RISCV_V_MAGIC. The magic value and the size of the extension added to
the sigcontext are written into each hdr->magic and hdr->size.
However, I did not find the corresponding code in this patch. Or,
maybe I am missing something obvious. Could you help point me out it?

>
> cfi sigcontenxt doesn't need any ABI between user and kernel here. We nee=
d
> this space so that kernel can save a pointer to shadow stack token on sig=
nal
> delivery. Once sigreturn happens, kernel will use the same pointer, verif=
y
> the token saved on shadow stack and restore shadow stack for user mode.
> At no point in this scheme, user mode is required to perform any action.
>
> All that is needed is that user mode doesn't accidenly trample at this of=
fset.
>
> Since I was under the impression that `struct __riscv_ctx_hdr` is there f=
or
> context extension and must be present for any state beyond `sc_regs`, I a=
ssumed
> that I must make space for this header (even if vector state is not prese=
nt).
>
> >
> >BTW, I have sent a patch[1] that refactor setup_sigcontext so it'd be
> >easier for future extensions to expand on the signal stack.
>
> I can adopt to this, although its orthogonal to what we are discussing he=
re.
>
> >
> >>         /* sc_regs is structured the same as the start of pt_regs */
> >>         err =3D __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs)=
);
> >>         /* Save the floating-point state. */
> >>         if (has_fpu())
> >>                 err |=3D save_fp_state(regs, &sc->sc_fpregs);
> >>         /* Save the vector state. */
> >> -       if (has_vector() && riscv_v_vstate_query(regs))
> >> +       if (has_vector() && riscv_v_vstate_query(regs)) {
> >>                 err |=3D save_v_state(regs, (void __user **)&sc_ext_pt=
r);
> >> +               sc_cfi =3D (struct __sc_riscv_cfi_state *) ((unsigned =
long) sc_cfi + riscv_v_sc_size);
> >> +       }
> >>         /* Write zero to fp-reserved space and check it on restore_sig=
context */
> >>         err |=3D __put_user(0, &sc->sc_extdesc.reserved);
> >> +       /*
> >> +        * Save a pointer to shadow stack itself on shadow stack as a =
form of token.
> >> +        * A token on shadow gives following properties
> >> +        *      - Safe save and restore for shadow stack switching. An=
y save of shadow stack
> >> +        *        must have had saved a token on shadow stack. Similar=
ly any restore of shadow
> >> +        *        stack must check the token before restore. Since wri=
ting to shadow stack with
> >> +        *        address of shadow stack itself is not easily allowed=
. A restore without a save
> >> +        *        is quite difficult for an attacker to perform.
> >> +        *      - A natural break. A token in shadow stack provides a =
natural break in shadow stack
> >> +        *        So a single linear range can be bucketed into differ=
ent shadow stack segments. Any
> >> +        *        sspopchk will detect the condition and fault to kern=
el as sw check exception.
> >> +        */
> >> +       if (is_shstk_enabled(current)) {
> >> +               err |=3D save_user_shstk(current, &ss_ptr);
> >> +               err |=3D __put_user(ss_ptr, &sc_cfi->ss_ptr);
> >> +       }
> >>         /* And put END __riscv_ctx_hdr at the end. */
> >>         err |=3D __put_user(END_MAGIC, &sc_ext_ptr->magic);
> >>         err |=3D __put_user(END_HDR_SIZE, &sc_ext_ptr->size);
> >> @@ -345,6 +400,11 @@ static int setup_rt_frame(struct ksignal *ksig, s=
igset_t *set,
> >>  #ifdef CONFIG_MMU
> >>         regs->ra =3D (unsigned long)VDSO_SYMBOL(
> >>                 current->mm->context.vdso, rt_sigreturn);
> >> +
> >> +       /* if bcfi is enabled x1 (ra) and x5 (t0) must match. not sure=
 if we need this? */
> >> +       if (is_shstk_enabled(current))
> >> +               regs->t0 =3D regs->ra;
> >> +
> >>  #else
> >>         /*
> >>          * For the nommu case we don't have a VDSO.  Instead we push t=
wo
> >> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> >> index 8da509afdbe9..40c32258b6ec 100644
> >> --- a/arch/riscv/kernel/usercfi.c
> >> +++ b/arch/riscv/kernel/usercfi.c
> >> @@ -52,6 +52,11 @@ void set_active_shstk(struct task_struct *task, uns=
igned long shstk_addr)
> >>         task->thread_info.user_cfi_state.user_shdw_stk =3D shstk_addr;
> >>  }
> >>
> >> +unsigned long get_active_shstk(struct task_struct *task)
> >> +{
> >> +       return task->thread_info.user_cfi_state.user_shdw_stk;
> >> +}
> >> +
> >>  void set_shstk_status(struct task_struct *task, bool enable)
> >>  {
> >>         task->thread_info.user_cfi_state.ubcfi_en =3D enable ? 1 : 0;
> >> @@ -164,6 +169,58 @@ static int create_rstor_token(unsigned long ssp, =
unsigned long *token_addr)
> >>         return 0;
> >>  }
> >>
> >> +/*
> >> + * Save user shadow stack pointer on shadow stack itself and return p=
ointer to saved location
> >> + * returns -EFAULT if operation was unsuccessful
> >> + */
> >> +int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shs=
tk_ptr)
> >> +{
> >> +       unsigned long ss_ptr =3D 0;
> >> +       unsigned long token_loc =3D 0;
> >> +       int ret =3D 0;
> >> +
> >> +       if (saved_shstk_ptr =3D=3D NULL)
> >> +               return -EINVAL;
> >> +
> >> +       ss_ptr =3D get_active_shstk(tsk);
> >> +       ret =3D create_rstor_token(ss_ptr, &token_loc);
> >> +
> >> +       if (!ret) {
> >> +               *saved_shstk_ptr =3D token_loc;
> >> +               set_active_shstk(tsk, token_loc);
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +/*
> >> + * Restores user shadow stack pointer from token on shadow stack for =
task `tsk`
> >> + * returns -EFAULT if operation was unsuccessful
> >> + */
> >> +int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_p=
tr)
> >> +{
> >> +       unsigned long token =3D 0;
> >> +
> >> +       token =3D amo_user_shstk((unsigned long __user *)shstk_ptr, 0)=
;
> >> +
> >> +       if (token =3D=3D -1)
> >> +               return -EFAULT;
> >> +
> >> +       /* invalid token, return EINVAL */
> >> +       if ((token - shstk_ptr) !=3D SHSTK_ENTRY_SIZE) {
> >> +               pr_info_ratelimited(
> >> +                               "%s[%d]: bad restore token in %s: pc=
=3D%p sp=3D%p, token=3D%p, shstk_ptr=3D%p\n",
> >> +                               tsk->comm, task_pid_nr(tsk), __func__,
> >> +                               (void *)(task_pt_regs(tsk)->epc), (voi=
d *)(task_pt_regs(tsk)->sp),
> >> +                               (void *)token, (void *)shstk_ptr);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       /* all checks passed, set active shstk and return success */
> >> +       set_active_shstk(tsk, token);
> >> +       return 0;
> >> +}
> >> +
> >>  static unsigned long allocate_shadow_stack(unsigned long addr, unsign=
ed long size,
> >>                                 unsigned long token_offset,
> >>                                 bool set_tok)
> >> --
> >> 2.45.0
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >- [1]: https://lore.kernel.org/all/20240628-dev-signal-refactor-v1-1-0c3=
91b260261@sifive.com/
> >
> >Thanks,
> >Andy

Regards,
Andy

