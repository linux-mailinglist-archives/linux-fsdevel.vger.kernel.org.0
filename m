Return-Path: <linux-fsdevel+bounces-31275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E1B993E42
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 07:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418BE1F235F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 05:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E83013C3F6;
	Tue,  8 Oct 2024 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lx6Wwt6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA733985
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364592; cv=none; b=lY/gceLdPpw4xIOdmuTcFSBqj1720noarsf+Dk0T+Jnp2Gi1sbkMGaEebRjJgg+N6HSA/MTMWfl6Af3MVMs/yfCb823DQC9vBpC4dt1EN8HhGYLtSZG9nKINw5gGF7US7dqMk7JjVQAxonRsqZ//MR9FFtwdcyA9mX3woFHLO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364592; c=relaxed/simple;
	bh=J+sL/JH0w5uxfdfZLeo2CgWwLFTpOCgCJ9fT9v9s7sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7VbUH/lhTz5ReaJjCzPYkq7ZhV4vXWZX4naEGb2FkkiFGAo0Py+aLSpkGJiCRYU/ed+L/CGlVrX9jTrKVyxuW4xAAke6GVOZNonPi3NEx4jutgdVQsx5+dH4lskaKeMq+zEP7hnzWP548KYKHgYvBT0qgz03GiJBHfMsL0W1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lx6Wwt6p; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82d24e18dfcso208434239f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 22:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1728364589; x=1728969389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4w/TdKOPPfwgKMj85c6/te+TDmMrhbBdxi4k1LLIvc=;
        b=lx6Wwt6pfemKtg/RtsUkh6zDXx+AMz2u0XC29jh3q6XGNRXDJyCEhkRdOgYFcDPU61
         dn5uW6y9KwHovP3mgvRj5hzQFEeGkq5yruXm/xei0zfQDP4mdl50KJRLL0Bm5FvNYvtS
         9XLj30EwxrVfPGWLG1GU6+Hg5eu3rXJX7VFRHw8A5+8iMWithntSRSsM8op0l5wdQw8H
         K43UnN/dnkjJxgJgdutFmFW6zcsc9OplF9dUy/TKgk/d5/je/a2QFJKGDfF/hf/7aXL2
         dSBX913GuMhdeFvJ3um/fUKbVwq3sVok8iu2Go4mTHtEj9rTWXSpuJE0ViHCjC8nT23q
         HHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728364589; x=1728969389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4w/TdKOPPfwgKMj85c6/te+TDmMrhbBdxi4k1LLIvc=;
        b=NpV9YJ1bp4xTuRrebvOCVFz2G7xl8/BmlwOTLFUptZJN1eZzev3gtYuFYesWx9lntn
         ZW24VU1lzqzo9aQ9SM623NgdZJY5PxiLTjLb9J5JBv7OkSKJZxZER4g6Z/BF5U5Lv/3l
         rkUYnfBNp0JHzTX1L3mZfbto15re3TIXQkZlDCVtPTv3m1Cpz8gr0Xd2fo7fjoa2reH7
         mRngnQJ9O3SdzOgvQJkJjRgGohfFPGHKqcfPuBlpy2kpzttiObYMCcombhTJS66CkLrJ
         ENMce5RLP0e4cnZSbRiSYTxtqGL9zZ/jAGhLIgOwQmbRDznPq77e+gibEBnhNbtHZIZd
         OvYg==
X-Forwarded-Encrypted: i=1; AJvYcCWqfuRa3irtpfMCb+kQP4qTnCpoJKOVb0OqqeZHCvL1LP71/gyJ6XNv6iSH6+J5gyG/6u2YjouNZHK0h05M@vger.kernel.org
X-Gm-Message-State: AOJu0YxJokD6auQYbVKHrVNYN44Vj64N3hFv29B62rZkmBxfQq7s1Zhd
	ILvAt79I5IXuolSyAL0Z/hxnWWm42dYvsdOcOaKJzRyvKjVscY2drhVlORVYwWtqXXzzIjVUoZG
	5tq/5uMLlyfug3hMiWVDm++HsLnHQU98Dwk7wZQ==
X-Google-Smtp-Source: AGHT+IHj+3nyjDRUlzo6HU3+Ye4UA98AMbnjv3+zlmAvnKbqvLOrOys0YnN7vCUlZP6Nh+cnnTYFiH4anmDFOKj+zMw=
X-Received: by 2002:a05:6602:14c1:b0:82a:2143:8 with SMTP id
 ca18e2360f4ac-834f7d65974mr1658309439f.10.1728364589159; Mon, 07 Oct 2024
 22:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-16-3ba65b6e550f@rivosinc.com>
 <CANXhq0rpwQkZ9+mZLGVUq=r4WiA8BbZ-eeTDogf3fzeEPqeeqA@mail.gmail.com> <ZwRvAEwFbrpq3zZq@debug.ba.rivosinc.com>
In-Reply-To: <ZwRvAEwFbrpq3zZq@debug.ba.rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 8 Oct 2024 13:16:17 +0800
Message-ID: <CANXhq0qaokjDC9hb75_dpGuyOd_ex8+q7YNe8pAg7dbTcxuLSg@mail.gmail.com>
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

On Tue, Oct 8, 2024 at 7:30=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> On Mon, Oct 07, 2024 at 04:17:47PM +0800, Zong Li wrote:
> >On Wed, Oct 2, 2024 at 12:20=E2=80=AFAM Deepak Gupta <debug@rivosinc.com=
> wrote:
> >>
> >> Userspace specifies CLONE_VM to share address space and spawn new thre=
ad.
> >> `clone` allow userspace to specify a new stack for new thread. However
> >> there is no way to specify new shadow stack base address without chang=
ing
> >> API. This patch allocates a new shadow stack whenever CLONE_VM is give=
n.
> >>
> >> In case of CLONE_VFORK, parent is suspended until child finishes and t=
hus
> >> can child use parent shadow stack. In case of !CLONE_VM, COW kicks in
> >> because entire address space is copied from parent to child.
> >>
> >> `clone3` is extensible and can provide mechanisms using which shadow s=
tack
> >> as an input parameter can be provided. This is not settled yet and bei=
ng
> >> extensively discussed on mailing list. Once that's settled, this commi=
t
> >> will adapt to that.
> >>
> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >> ---
> >>  arch/riscv/include/asm/usercfi.h |  25 ++++++++
>
> ... snipped...
>
> >> +
> >> +/*
> >> + * This gets called during clone/clone3/fork. And is needed to alloca=
te a shadow stack for
> >> + * cases where CLONE_VM is specified and thus a different stack is sp=
ecified by user. We
> >> + * thus need a separate shadow stack too. How does separate shadow st=
ack is specified by
> >> + * user is still being debated. Once that's settled, remove this part=
 of the comment.
> >> + * This function simply returns 0 if shadow stack are not supported o=
r if separate shadow
> >> + * stack allocation is not needed (like in case of !CLONE_VM)
> >> + */
> >> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
> >> +                                          const struct kernel_clone_a=
rgs *args)
> >> +{
> >> +       unsigned long addr, size;
> >> +
> >> +       /* If shadow stack is not supported, return 0 */
> >> +       if (!cpu_supports_shadow_stack())
> >> +               return 0;
> >> +
> >> +       /*
> >> +        * If shadow stack is not enabled on the new thread, skip any
> >> +        * switch to a new shadow stack.
> >> +        */
> >> +       if (is_shstk_enabled(tsk))
> >
> >Hi Deepak,
> >Should it be '!' is_shstk_enabled(tsk)?
>
> Yes it is a bug. It seems like fork without CLONE_VM or with CLONE_VFORK,=
 it was returning
> 0 anyways. And in the case of CLONE_VM (used by pthread), it was not doin=
g the right thing.

Hi Deepak,
I'd like to know if I understand correctly. Could I know whether there
might also be a risk when the user program doesn't enable the CFI and
the kernel doesn't activate CFI. Because this flow will still try to
allocate the shadow stack and execute the ssamowap command. Thanks

> Most of the testing has been with busybox build (independent binaries0 dr=
iven via buildroot
> setup. Wondering why it wasn't caught.
>
> Anyways, will fix it. Thanks for catching it.
>
> >
> >> +               return 0;
> >> +
> >> +       /*

