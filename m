Return-Path: <linux-fsdevel+bounces-44019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B809A60BCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 09:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47C93BBD7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 08:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FA21D5AB5;
	Fri, 14 Mar 2025 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZX6pQS8C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AEB1AAA1B
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941290; cv=none; b=ejnHw30EJEUoZeNYxcUL5G1q1+doO6IxmAAOJ7R0F3qSZ2/64qwX8SGbgnp4uPx553vCNvaN/VdhAdCN8PIg/q3pbDgY6BjMxhoIiYFJwog9nkM1KQyeSN5Z0SqQf+UMtXwHerR9W5SQ4wn5Fgr/+AqCLWX4fX5sONPwyACmbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941290; c=relaxed/simple;
	bh=5OarQnCgTAfdocmYPDrI94tCD2az3gBLGjrATX3zRF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGgGqxn0MQyufE8Nd/O1KhWVBt4xW/PR+XL32gTLTydaMTe/rP/ZClOEHD/ZBoJi0WWesWUHQpRsz3eDX2TOZ6/Q+gjEQLH+oV9kEDOR2Z+bSJgRlQs7WPaKOA0Ljwxr8ImFmKnFO1ZvgDNWbwJCmgoQ2LgZZJrmnz0RXbrpvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZX6pQS8C; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85db872dc75so120043739f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 01:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741941287; x=1742546087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm74IWNiiddtjCmKDIAkneaMK7FpbJuBZ2ZaX1ZQ1kw=;
        b=ZX6pQS8CA8sOlSwbzuDg4s1RIS/l5u6Tl+MWW7j/4eqXrW0Pyb7d2+y/dCWX7meg4u
         6BuAWQNFN168Q8j6G6Kj3PoV+ddtd4vN7DuYDQdFa3DllG6HhBIp5496HaK7YHdxfaFC
         Zh+Pceg1h69NFSa3eah8hnSWqbA0gIWz8O13sl46uVlt1K068o0G/Eyb6Moe02+3wiK5
         tQJVJgK6Ns6YDYxiK/93Gozdoh8sy9UkG1bdLlKrekYqHsjpRqsLHtSiFHCGTIKFLZPF
         3/uIAPKsJ4ZFAfDxzV4wOVs1Hvxf4sTo9nqw3CcGz1M5E5oxmtDxI8XHAPJSZAA5O6ZR
         oDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941287; x=1742546087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bm74IWNiiddtjCmKDIAkneaMK7FpbJuBZ2ZaX1ZQ1kw=;
        b=mZPi2gf355r6uVOMQXM093cBpVBTQVsxcKpwVSFg8Nekf6P6CIljdhbp9YMsai8Gji
         ElPlZszTSnmM1U4yEVDofVFQEhEvg0FAcScYwTQkHbHFwi32RVUmSOa5tcr4vBC7lGxz
         jB8yEqw04EsUf9SBdmyZTpRS4vsep9lwRxwZAgB50+yNbR6TXub5yH3+yFL7zrpjlGRM
         sWfKEDBSXQ+UlzMh+ggzfQy1Q5KWRT8mCREXuInIN+vLnuV58qNu6AZWd7Ro0qbbtJH0
         9H7UKkRh4gjRgKtnZowiRvlDLB+uNkbg3C2ZiqeeffKQri74oZi5EapqVIIK1hCPic0d
         otHA==
X-Forwarded-Encrypted: i=1; AJvYcCU1C2tZUC/LJ66y4ChXlWdhu72L5VdUam5gCsYqkLSGFmOZvZD3zU2ss3jrgdWBwDX/beOwo8Lbtwd7gZFZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwqhilmQgF3xcy3AwybThn8LzLyEuR7q1Rl5rwdFHkjCgAEE9eq
	PG6MeLCS0e6vO518wI+e7SVPXrG5J0BHVsSqMOP985nMDV9Hz0XRF5K57qs3j0vQpGz+vCsCyof
	51qRBImM7a2b9tg/1te4LdMjObI6MWeIhJleWrA==
X-Gm-Gg: ASbGncs591/SI3BI77PRodIjkTmO6CAcDyes4h2UzJrWBW9pCaVQwf9xwUZksoxyKkA
	74hcteQcIUlAt5G6pmGa1+zzzOmHtfPofbJ/LUGvJMLOPS2elNh5BD4GIp1M4RrEzbzdlOdBftY
	3GGZ8L3n7VqPxbzNM9gvFTv2TJNBM=
X-Google-Smtp-Source: AGHT+IFRA5Az3Um9tJHHRXJFx+3mnIqGojBtFl6JREsVb2G4EXt33cQMlFoJn1d6ltMZlRWKhpPmG6wKGqrSmlkGBr0=
X-Received: by 2002:a05:6602:3f08:b0:85b:5869:b5b with SMTP id
 ca18e2360f4ac-85dc48334c9mr187830339f.6.1741941286887; Fri, 14 Mar 2025
 01:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-25-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-25-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:34:36 +0800
X-Gm-Features: AQ5f1JpXeE6tU44day2kKwZlk-ke3YkF8t6JJiPonVbxjr2JHrkve7GNBaApiH4
Message-ID: <CANXhq0qTYAuc_2A+51-BxEKKT67t3-d_nj3-R2O=+khHNOR+AQ@mail.gmail.com>
Subject: Re: [PATCH v11 25/27] riscv: Documentation for landing pad / indirect
 branch tracking
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

On Mon, Mar 10, 2025 at 11:44=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> Adding documentation on landing pad aka indirect branch tracking on riscv
> and kernel interfaces exposed so that user tasks can enable it.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  Documentation/arch/riscv/index.rst   |   1 +
>  Documentation/arch/riscv/zicfilp.rst | 115 +++++++++++++++++++++++++++++=
++++++
>  2 files changed, 116 insertions(+)
>
> diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/risc=
v/index.rst
> index eecf347ce849..be7237b69682 100644
> --- a/Documentation/arch/riscv/index.rst
> +++ b/Documentation/arch/riscv/index.rst
> @@ -14,6 +14,7 @@ RISC-V architecture
>      uabi
>      vector
>      cmodx
> +    zicfilp
>
>      features
>
> diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/ri=
scv/zicfilp.rst
> new file mode 100644
> index 000000000000..a188d78fcde6
> --- /dev/null
> +++ b/Documentation/arch/riscv/zicfilp.rst
> @@ -0,0 +1,115 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Author: Deepak Gupta <debug@rivosinc.com>
> +:Date:   12 January 2024
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Tracking indirect control transfers on RISC-V Linux
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +This document briefly describes the interface provided to userspace by L=
inux
> +to enable indirect branch tracking for user mode applications on RISV-V
> +
> +1. Feature Overview
> +--------------------
> +
> +Memory corruption issues usually result in to crashes, however when in h=
ands of
> +an adversary and if used creatively can result into variety security iss=
ues.
> +
> +One of those security issues can be code re-use attacks on program where=
 adversary
> +can use corrupt function pointers and chain them together to perform jum=
p oriented
> +programming (JOP) or call oriented programming (COP) and thus compromisi=
ng control
> +flow integrity (CFI) of the program.
> +
> +Function pointers live in read-write memory and thus are susceptible to =
corruption
> +and allows an adversary to reach any program counter (PC) in address spa=
ce. On
> +RISC-V zicfilp extension enforces a restriction on such indirect control
> +transfers:
> +
> +- indirect control transfers must land on a landing pad instruction ``lp=
ad``.
> +  There are two exception to this rule:
> +
> +  - rs1 =3D x1 or rs1 =3D x5, i.e. a return from a function and returns =
are
> +    protected using shadow stack (see zicfiss.rst)
> +
> +  - rs1 =3D x7. On RISC-V compiler usually does below to reach function
> +    which is beyond the offset possible J-type instruction::
> +
> +      auipc x7, <imm>
> +      jalr (x7)
> +
> +       Such form of indirect control transfer are still immutable and do=
n't rely
> +    on memory and thus rs1=3Dx7 is exempted from tracking and considered=
 software
> +    guarded jumps.
> +
> +``lpad`` instruction is pseudo of ``auipc rd, <imm_20bit>`` with ``rd=3D=
x0`` and
> +is a HINT nop. ``lpad`` instruction must be aligned on 4 byte boundary a=
nd
> +compares 20 bit immediate withx7. If ``imm_20bit`` =3D=3D 0, CPU don't p=
erform any
> +comparision with ``x7``. If ``imm_20bit`` !=3D 0, then ``imm_20bit`` mus=
t match
> +``x7`` else CPU will raise ``software check exception`` (``cause=3D18``)=
 with
> +``*tval =3D 2``.
> +
> +Compiler can generate a hash over function signatures and setup them (tr=
uncated
> +to 20bit) in x7 at callsites and function prologues can have ``lpad`` wi=
th same
> +function hash. This further reduces number of program counters a call si=
te can
> +reach.
> +
> +2. ELF and psABI
> +-----------------
> +
> +Toolchain sets up :c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_FCFI` for prope=
rty
> +:c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the obje=
ct file.
> +
> +3. Linux enabling
> +------------------
> +
> +User space programs can have multiple shared objects loaded in its addre=
ss space
> +and it's a difficult task to make sure all the dependencies have been co=
mpiled
> +with support of indirect branch. Thus it's left to dynamic loader to ena=
ble
> +indirect branch tracking for the program.
> +
> +4. prctl() enabling
> +--------------------
> +
> +:c:macro:`PR_SET_INDIR_BR_LP_STATUS` / :c:macro:`PR_GET_INDIR_BR_LP_STAT=
US` /
> +:c:macro:`PR_LOCK_INDIR_BR_LP_STATUS` are three prctls added to manage i=
ndirect
> +branch tracking. prctls are arch agnostic and returns -EINVAL on other a=
rches.
> +
> +* prctl(PR_SET_INDIR_BR_LP_STATUS, unsigned long arg)
> +
> +If arg1 is :c:macro:`PR_INDIR_BR_LP_ENABLE` and if CPU supports ``zicfil=
p``
> +then kernel will enabled indirect branch tracking for the task. Dynamic =
loader
> +can issue this :c:macro:`prctl` once it has determined that all the obje=
cts
> +loaded in address space support indirect branch tracking. Additionally i=
f there
> +is a `dlopen` to an object which wasn't compiled with ``zicfilp``, dynam=
ic
> +loader can issue this prctl with arg1 set to 0 (i.e.
> +:c:macro:`PR_INDIR_BR_LP_ENABLE` being clear)
> +
> +* prctl(PR_GET_INDIR_BR_LP_STATUS, unsigned long arg)
> +
> +Returns current status of indirect branch tracking. If enabled it'll ret=
urn
> +:c:macro:`PR_INDIR_BR_LP_ENABLE`
> +
> +* prctl(PR_LOCK_INDIR_BR_LP_STATUS, unsigned long arg)
> +
> +Locks current status of indirect branch tracking on the task. User space=
 may
> +want to run with strict security posture and wouldn't want loading of ob=
jects
> +without ``zicfilp`` support in it and thus would want to disallow disabl=
ing of
> +indirect branch tracking. In that case user space can use this prctl to =
lock
> +current settings.
> +
> +5. violations related to indirect branch tracking
> +--------------------------------------------------
> +
> +Pertaining to indirect branch tracking, CPU raises software check except=
ion in
> +following conditions:
> +
> +- missing ``lpad`` after indirect call / jmp
> +- ``lpad`` not on 4 byte boundary
> +- ``imm_20bit`` embedded in ``lpad`` instruction doesn't match with ``x7=
``
> +
> +In all 3 cases, ``*tval =3D 2`` is captured and software check exception=
 is
> +raised (``cause=3D18``)
> +
> +Linux kernel will treat this as :c:macro:`SIGSEV`` with code =3D
> +:c:macro:`SEGV_CPERR` and follow normal course of signal delivery.
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

