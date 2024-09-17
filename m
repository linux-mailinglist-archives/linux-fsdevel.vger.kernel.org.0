Return-Path: <linux-fsdevel+bounces-29613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9197B5EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 00:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2016B1C2126C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 22:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319E018D629;
	Tue, 17 Sep 2024 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BB6CZxWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4F4166F23
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726613540; cv=none; b=fhK+6qaAGxlTu5/T6L9Bl6kJcu0kRmFOAH3kQ1h24Ou93+N6aTxBsul5wtP21QHRw++D4dKe4+wGVcnVHQQvqqEX2Sv61P1kw2/fCJo9wRjgNuO7cLvall3YZZ2T2H6WvY5zQMzpStZ/icOLeld6Twpg0n3aaFzbhe5jUXAHuBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726613540; c=relaxed/simple;
	bh=xEL5i2NrNoCubbGXHBwmeXVJnMF3QnYuTTU7UJv3VgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVkvtN34wJhp2c/dkjU56xubuM/kz+SiakaZClDSH6ZMcBoCoo9mP+RbrQYJMnbXjKD09JIosxuYExNcIvNCvGAuJdimpdGdb4APlBEVJnNGd0EvM83ANHBf6Nxy//+djd5kUNBh+0+vtr+PoNpmVuxs5wE8m2myP2XkxC2mEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BB6CZxWc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d8f06c2459so3486012a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726613538; x=1727218338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8LgfL6ONVrdwnf/yGtLCv1uWs0otVWaD3MZUYHzEzNc=;
        b=BB6CZxWc/vreTtFohY1cTI2o+68am73u+sZqvlIBKjjpb3TorZ2mz98jwGeKMgUyIB
         1JLGFyfCHLTYw1mkypSFCKafIxU7QC65/ksmhw4/DhLa5JcngnJwJaaovhJ3J0mEuxIh
         LvTeVP0B3xUuEAZ3TVorAKvHt+sond1dQNMu0a4ls+5KuNx2Bvv/x06g8Yd7q47D9k50
         rW66mDORJrX0t+8cmF2bha1xgtJyhDako/oqyQwMKtuJN+/IFQwRNwhinEmwMiWGWudu
         b2IpYV8GD50qjMXIa1Sqn3W8Fq/H7Bl3ISSi/NA5E3m6wULFLO3S+ua75sA0W3EFH1N1
         WfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726613538; x=1727218338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LgfL6ONVrdwnf/yGtLCv1uWs0otVWaD3MZUYHzEzNc=;
        b=RtTAcsbLj4FEv8fq9nWdPdIXOT/74Fyy0wUAOcHAWNufMNGjFG0BbEZnGH1/Ogp6sa
         u7pG4BcMuH962EXpnuJZ/H8Y+OU8vBlSfQDgV7fjtmMnqKfkk+ygoLO4nUL0URPk0W+T
         CaVHNPK5BHVfzT5cQKKB8xjgstmmmptmepc8CIC50b0L3GtedBnlIi7KuKn8OHf0CrWG
         ErPzKv6ZOvi1FIwkBszfok65EQQCQ84ChuQME1524K+nebJv2nQvGA7bFjTjdWAj67QH
         vq9rIhRkGA1btjTXga2yY7e/TJs3fJ8vn26IC4LOdz7LhlxP8ny+vb/Vbhzi4EZouap8
         wmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpjmP2taVXfhy99IgJextP+U1QQb3lE4eyS0za0KttTOmD2riBO3s+/0oAIYJsDLEjSe95PjGBXfK+STl4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7jrfGbachrvwariNcz7bzVP5vGfsIYXV6gwuqVgKzKqwnIjdV
	fGOQ1gdP/7GKnBiToDKM/uz8u44lL6oFKVxGnbQiK2dDGzHdubNZVIdljZomh4A=
X-Google-Smtp-Source: AGHT+IGhq1GnSQZF5MxVR/0K0G2NJThoWCkNzk83MwW/s6Yz+26hm9MeL/l8on1yytS+Oc/w/84WRw==
X-Received: by 2002:a17:90b:164b:b0:2d8:aba8:787a with SMTP id 98e67ed59e1d1-2dbb9db9c78mr20241981a91.6.1726613537298;
        Tue, 17 Sep 2024 15:52:17 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd609d2958sm16864a91.53.2024.09.17.15.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 15:52:16 -0700 (PDT)
Date: Tue, 17 Sep 2024 15:52:11 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Andy Chiu <andybnac@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	quic_zhonhan@quicinc.com, zong.li@sifive.com, zev@bewilderbeest.net,
	david@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
	broonie@kernel.org, dave.hansen@linux.intel.com,
	atishp@rivosinc.com, bjorn@rivosinc.com, namcaov@gmail.com,
	usama.anjum@collabora.com, guoren@kernel.org, alx@kernel.org,
	jszhang@kernel.org, hpa@zytor.com, puranjay@kernel.org,
	shuah@kernel.org, sorear@fastmail.com, costa.shul@redhat.com,
	robh@kernel.org, antonb@tenstorrent.com, quic_bjorande@quicinc.com,
	lorenzo.stoakes@oracle.com, corbet@lwn.net, dawei.li@shingroup.cn,
	anup@brainfault.org, deller@gmx.de, x86@kernel.org,
	andrii@kernel.org, willy@infradead.org, kees@kernel.org,
	mingo@redhat.com, libang.li@antgroup.com, samitolvanen@google.com,
	greentime.hu@sifive.com, osalvador@suse.de, ajones@ventanamicro.com,
	revest@chromium.org, ancientmodern4@gmail.com,
	aou@eecs.berkeley.edu, jerry.shih@sifive.com,
	alexghiti@rivosinc.com, arnd@arndb.de, yang.lee@linux.alibaba.com,
	charlie@rivosinc.com, bgray@linux.ibm.com, Liam.Howlett@oracle.com,
	leobras@redhat.com, songshuaishuai@tinylab.org,
	xiao.w.wang@intel.com, bp@alien8.de, cuiyunhui@bytedance.com,
	mchitale@ventanamicro.com, cleger@rivosinc.com, tglx@linutronix.de,
	krzk+dt@kernel.org, vbabka@suse.cz, brauner@kernel.org,
	bhe@redhat.com, ke.zhao@shingroup.cn, oleg@redhat.com,
	samuel.holland@sifive.com, ben.dooks@codethink.co.uk,
	evan@rivosinc.com, palmer@dabbelt.com, ebiederm@xmission.com,
	andy.chiu@sifive.com, schwab@suse.de, akpm@linux-foundation.org,
	sameo@rivosinc.com, tanzhasanwork@gmail.com, rppt@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v4 23/30] riscv signal: save and restore of shadow stack
 for signal
Message-ID: <ZuoIG43085zzJ5I2@debug.ba.rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
 <20240912231650.3740732-24-debug@rivosinc.com>
 <CAFTtA3ONu7CUNHwQf47ePMh9uvAi-uCV8B0YJAuFX+s0thC41Q@mail.gmail.com>
 <ZuirLvsl6gukn/SG@debug.ba.rivosinc.com>
 <CAFTtA3OX-iB03Y5FPN=EGe4pqGtxff83Nk-w-xka29o2cMNzew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFTtA3OX-iB03Y5FPN=EGe4pqGtxff83Nk-w-xka29o2cMNzew@mail.gmail.com>

On Wed, Sep 18, 2024 at 12:03:45AM +0200, Andy Chiu wrote:
>Deepak Gupta <debug@rivosinc.com> 於 2024年9月17日 週二 上午12:03寫道：
>>
>> On Fri, Sep 13, 2024 at 09:25:57PM +0200, Andy Chiu wrote:
>> >Hi Deepak,
>> >
>> >Deepak Gupta <debug@rivosinc.com> 於 2024年9月13日 週五 上午1:20寫道：
>> >>
>> >> Save shadow stack pointer in sigcontext structure while delivering signal.
>> >> Restore shadow stack pointer from sigcontext on sigreturn.
>> >>
>> >> As part of save operation, kernel uses `ssamoswap` to save snapshot of
>> >> current shadow stack on shadow stack itself (can be called as a save
>> >> token). During restore on sigreturn, kernel retrieves token from top of
>> >> shadow stack and validates it. This allows that user mode can't arbitrary
>> >> pivot to any shadow stack address without having a token and thus provide
>> >> strong security assurance between signaly delivery and sigreturn window.
>> >>
>> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> >> Suggested-by: Andy Chiu <andy.chiu@sifive.com>
>> >> ---
>> >>  arch/riscv/include/asm/usercfi.h | 19 ++++++++++
>> >>  arch/riscv/kernel/signal.c       | 62 +++++++++++++++++++++++++++++++-
>> >>  arch/riscv/kernel/usercfi.c      | 57 +++++++++++++++++++++++++++++
>> >>  3 files changed, 137 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
>> >> index 20a9102cce51..d5050a5df26c 100644
>> >> --- a/arch/riscv/include/asm/usercfi.h
>> >> +++ b/arch/riscv/include/asm/usercfi.h
>> >> @@ -8,6 +8,7 @@
>> >>  #ifndef __ASSEMBLY__
>> >>  #include <linux/types.h>
>> >>  #include <linux/prctl.h>
>> >> +#include <linux/errno.h>
>> >>
>> >>  struct task_struct;
>> >>  struct kernel_clone_args;
>> >> @@ -35,6 +36,9 @@ bool is_shstk_locked(struct task_struct *task);
>> >>  bool is_shstk_allocated(struct task_struct *task);
>> >>  void set_shstk_lock(struct task_struct *task);
>> >>  void set_shstk_status(struct task_struct *task, bool enable);
>> >> +unsigned long get_active_shstk(struct task_struct *task);
>> >> +int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr);
>> >> +int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr);
>> >>  bool is_indir_lp_enabled(struct task_struct *task);
>> >>  bool is_indir_lp_locked(struct task_struct *task);
>> >>  void set_indir_lp_status(struct task_struct *task, bool enable);
>> >> @@ -96,6 +100,21 @@ static inline void set_shstk_status(struct task_struct *task, bool enable)
>> >>
>> >>  }
>> >>
>> >> +static inline int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)
>> >> +{
>> >> +       return -EINVAL;
>> >> +}
>> >> +
>> >> +static inline int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr)
>> >> +{
>> >> +       return -EINVAL;
>> >> +}
>> >> +
>> >> +static inline unsigned long get_active_shstk(struct task_struct *task)
>> >> +{
>> >> +       return 0;
>> >> +}
>> >> +
>> >>  static inline bool is_indir_lp_enabled(struct task_struct *task)
>> >>  {
>> >>         return false;
>> >> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
>> >> index dcd282419456..7d5c1825650f 100644
>> >> --- a/arch/riscv/kernel/signal.c
>> >> +++ b/arch/riscv/kernel/signal.c
>> >> @@ -22,6 +22,7 @@
>> >>  #include <asm/vector.h>
>> >>  #include <asm/csr.h>
>> >>  #include <asm/cacheflush.h>
>> >> +#include <asm/usercfi.h>
>> >>
>> >>  unsigned long signal_minsigstksz __ro_after_init;
>> >>
>> >> @@ -153,6 +154,16 @@ static long restore_sigcontext(struct pt_regs *regs,
>> >>         void __user *sc_ext_ptr = &sc->sc_extdesc.hdr;
>> >>         __u32 rsvd;
>> >>         long err;
>> >> +       unsigned long ss_ptr = 0;
>> >> +       struct __sc_riscv_cfi_state __user *sc_cfi = NULL;
>> >> +
>> >> +       sc_cfi = (struct __sc_riscv_cfi_state *)
>> >> +                ((unsigned long) sc_ext_ptr + sizeof(struct __riscv_ctx_hdr));
>> >> +
>> >> +       if (has_vector() && riscv_v_vstate_query(regs))
>> >> +               sc_cfi = (struct __sc_riscv_cfi_state *)
>> >> +                        ((unsigned long) sc_cfi + riscv_v_sc_size);
>> >> +
>> >>         /* sc_regs is structured the same as the start of pt_regs */
>> >>         err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
>> >>         if (unlikely(err))
>> >> @@ -172,6 +183,24 @@ static long restore_sigcontext(struct pt_regs *regs,
>> >>         if (unlikely(rsvd))
>> >>                 return -EINVAL;
>> >>
>> >> +       /*
>> >> +        * Restore shadow stack as a form of token stored on shadow stack itself as a safe
>> >> +        * way to restore.
>> >> +        * A token on shadow gives following properties
>> >> +        *      - Safe save and restore for shadow stack switching. Any save of shadow stack
>> >> +        *        must have had saved a token on shadow stack. Similarly any restore of shadow
>> >> +        *        stack must check the token before restore. Since writing to shadow stack with
>> >> +        *        address of shadow stack itself is not easily allowed. A restore without a save
>> >> +        *        is quite difficult for an attacker to perform.
>> >> +        *      - A natural break. A token in shadow stack provides a natural break in shadow stack
>> >> +        *        So a single linear range can be bucketed into different shadow stack segments.
>> >> +        *        sspopchk will detect the condition and fault to kernel as sw check exception.
>> >> +        */
>> >> +       if (is_shstk_enabled(current)) {
>> >> +               err |= __copy_from_user(&ss_ptr, &sc_cfi->ss_ptr, sizeof(unsigned long));
>> >> +               err |= restore_user_shstk(current, ss_ptr);
>> >> +       }
>> >> +
>> >>         while (!err) {
>> >>                 __u32 magic, size;
>> >>                 struct __riscv_ctx_hdr __user *head = sc_ext_ptr;
>> >> @@ -215,6 +244,10 @@ static size_t get_rt_frame_size(bool cal_all)
>> >>                 if (cal_all || riscv_v_vstate_query(task_pt_regs(current)))
>> >>                         total_context_size += riscv_v_sc_size;
>> >>         }
>> >> +
>> >> +       if (is_shstk_enabled(current))
>> >> +               total_context_size += sizeof(struct __sc_riscv_cfi_state);
>> >> +
>> >>         /*
>> >>          * Preserved a __riscv_ctx_hdr for END signal context header if an
>> >>          * extension uses __riscv_extra_ext_header
>> >> @@ -276,18 +309,40 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
>> >>  {
>> >>         struct sigcontext __user *sc = &frame->uc.uc_mcontext;
>> >>         struct __riscv_ctx_hdr __user *sc_ext_ptr = &sc->sc_extdesc.hdr;
>> >> +       unsigned long ss_ptr = 0;
>> >> +       struct __sc_riscv_cfi_state __user *sc_cfi = NULL;
>> >>         long err;
>> >>
>> >> +       sc_cfi = (struct __sc_riscv_cfi_state *) (sc_ext_ptr + 1);
>> >> +
>> >
>> >Is it intended that cfi sigcontext does not follow the sigcontext rule
>> >setup by Vector? It seems like there is no extension header (struct
>> >__riscv_ctx_hdr) defined for cfi sigcontext here. If the sigcontext is
>> >directly appended to the signal stack, the user may not be able to
>> >recognize the meaning without defining a new ABI.
>>
>> Hmm... I didn't realize that struct `struct __riscv_ctx_hdr` is strongly
>> tied to vector state. I was under the impression that any new extended
>> state addition would require this header to be present.
>
>__riscv_ctx_hdr is not tied to vector state. Your impression is not
>wrong. When sigcontext for Vector was designed, it is intended that
>every new extension should define its header, please check
>RISCV_V_MAGIC. The magic value and the size of the extension added to
>the sigcontext are written into each hdr->magic and hdr->size.
>However, I did not find the corresponding code in this patch. Or,
>maybe I am missing something obvious. Could you help point me out it?

Sorry I was under the impression that there is only one ctx header for
all extended state. It seems like from this conversation, any new state
must declare it's own header, magic word and size.

Now that I am having this conversation, it seems like that the idea for
having ctx header is to ensure that any software (user space or kernel)
must parse sigcontext beyong pt_regs iteratively and start poking only
when it sees relevant data structure (based on magic word?)

Hopefully, I got it right this time. I'll fix it, if that's the intention
here.

>
>>
>> cfi sigcontenxt doesn't need any ABI between user and kernel here. We need
>> this space so that kernel can save a pointer to shadow stack token on signal
>> delivery. Once sigreturn happens, kernel will use the same pointer, verify
>> the token saved on shadow stack and restore shadow stack for user mode.
>> At no point in this scheme, user mode is required to perform any action.
>>
>> All that is needed is that user mode doesn't accidenly trample at this offset.
>>
>> Since I was under the impression that `struct __riscv_ctx_hdr` is there for
>> context extension and must be present for any state beyond `sc_regs`, I assumed
>> that I must make space for this header (even if vector state is not present).
>>
>> >
>> >BTW, I have sent a patch[1] that refactor setup_sigcontext so it'd be
>> >easier for future extensions to expand on the signal stack.
>>
>> I can adopt to this, although its orthogonal to what we are discussing here.
>>
>> >
>> >>         /* sc_regs is structured the same as the start of pt_regs */
>> >>         err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
>> >>         /* Save the floating-point state. */
>> >>         if (has_fpu())
>> >>                 err |= save_fp_state(regs, &sc->sc_fpregs);
>> >>         /* Save the vector state. */
>> >> -       if (has_vector() && riscv_v_vstate_query(regs))
>> >> +       if (has_vector() && riscv_v_vstate_query(regs)) {
>> >>                 err |= save_v_state(regs, (void __user **)&sc_ext_ptr);
>> >> +               sc_cfi = (struct __sc_riscv_cfi_state *) ((unsigned long) sc_cfi + riscv_v_sc_size);
>> >> +       }
>> >>         /* Write zero to fp-reserved space and check it on restore_sigcontext */
>> >>         err |= __put_user(0, &sc->sc_extdesc.reserved);
>> >> +       /*
>> >> +        * Save a pointer to shadow stack itself on shadow stack as a form of token.
>> >> +        * A token on shadow gives following properties
>> >> +        *      - Safe save and restore for shadow stack switching. Any save of shadow stack
>> >> +        *        must have had saved a token on shadow stack. Similarly any restore of shadow
>> >> +        *        stack must check the token before restore. Since writing to shadow stack with
>> >> +        *        address of shadow stack itself is not easily allowed. A restore without a save
>> >> +        *        is quite difficult for an attacker to perform.
>> >> +        *      - A natural break. A token in shadow stack provides a natural break in shadow stack
>> >> +        *        So a single linear range can be bucketed into different shadow stack segments. Any
>> >> +        *        sspopchk will detect the condition and fault to kernel as sw check exception.
>> >> +        */
>> >> +       if (is_shstk_enabled(current)) {
>> >> +               err |= save_user_shstk(current, &ss_ptr);
>> >> +               err |= __put_user(ss_ptr, &sc_cfi->ss_ptr);
>> >> +       }
>> >>         /* And put END __riscv_ctx_hdr at the end. */
>> >>         err |= __put_user(END_MAGIC, &sc_ext_ptr->magic);
>> >>         err |= __put_user(END_HDR_SIZE, &sc_ext_ptr->size);
>> >> @@ -345,6 +400,11 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>> >>  #ifdef CONFIG_MMU
>> >>         regs->ra = (unsigned long)VDSO_SYMBOL(
>> >>                 current->mm->context.vdso, rt_sigreturn);
>> >> +
>> >> +       /* if bcfi is enabled x1 (ra) and x5 (t0) must match. not sure if we need this? */
>> >> +       if (is_shstk_enabled(current))
>> >> +               regs->t0 = regs->ra;
>> >> +
>> >>  #else
>> >>         /*
>> >>          * For the nommu case we don't have a VDSO.  Instead we push two
>> >> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
>> >> index 8da509afdbe9..40c32258b6ec 100644
>> >> --- a/arch/riscv/kernel/usercfi.c
>> >> +++ b/arch/riscv/kernel/usercfi.c
>> >> @@ -52,6 +52,11 @@ void set_active_shstk(struct task_struct *task, unsigned long shstk_addr)
>> >>         task->thread_info.user_cfi_state.user_shdw_stk = shstk_addr;
>> >>  }
>> >>
>> >> +unsigned long get_active_shstk(struct task_struct *task)
>> >> +{
>> >> +       return task->thread_info.user_cfi_state.user_shdw_stk;
>> >> +}
>> >> +
>> >>  void set_shstk_status(struct task_struct *task, bool enable)
>> >>  {
>> >>         task->thread_info.user_cfi_state.ubcfi_en = enable ? 1 : 0;
>> >> @@ -164,6 +169,58 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
>> >>         return 0;
>> >>  }
>> >>
>> >> +/*
>> >> + * Save user shadow stack pointer on shadow stack itself and return pointer to saved location
>> >> + * returns -EFAULT if operation was unsuccessful
>> >> + */
>> >> +int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr)
>> >> +{
>> >> +       unsigned long ss_ptr = 0;
>> >> +       unsigned long token_loc = 0;
>> >> +       int ret = 0;
>> >> +
>> >> +       if (saved_shstk_ptr == NULL)
>> >> +               return -EINVAL;
>> >> +
>> >> +       ss_ptr = get_active_shstk(tsk);
>> >> +       ret = create_rstor_token(ss_ptr, &token_loc);
>> >> +
>> >> +       if (!ret) {
>> >> +               *saved_shstk_ptr = token_loc;
>> >> +               set_active_shstk(tsk, token_loc);
>> >> +       }
>> >> +
>> >> +       return ret;
>> >> +}
>> >> +
>> >> +/*
>> >> + * Restores user shadow stack pointer from token on shadow stack for task `tsk`
>> >> + * returns -EFAULT if operation was unsuccessful
>> >> + */
>> >> +int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)
>> >> +{
>> >> +       unsigned long token = 0;
>> >> +
>> >> +       token = amo_user_shstk((unsigned long __user *)shstk_ptr, 0);
>> >> +
>> >> +       if (token == -1)
>> >> +               return -EFAULT;
>> >> +
>> >> +       /* invalid token, return EINVAL */
>> >> +       if ((token - shstk_ptr) != SHSTK_ENTRY_SIZE) {
>> >> +               pr_info_ratelimited(
>> >> +                               "%s[%d]: bad restore token in %s: pc=%p sp=%p, token=%p, shstk_ptr=%p\n",
>> >> +                               tsk->comm, task_pid_nr(tsk), __func__,
>> >> +                               (void *)(task_pt_regs(tsk)->epc), (void *)(task_pt_regs(tsk)->sp),
>> >> +                               (void *)token, (void *)shstk_ptr);
>> >> +               return -EINVAL;
>> >> +       }
>> >> +
>> >> +       /* all checks passed, set active shstk and return success */
>> >> +       set_active_shstk(tsk, token);
>> >> +       return 0;
>> >> +}
>> >> +
>> >>  static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
>> >>                                 unsigned long token_offset,
>> >>                                 bool set_tok)
>> >> --
>> >> 2.45.0
>> >>
>> >>
>> >> _______________________________________________
>> >> linux-riscv mailing list
>> >> linux-riscv@lists.infradead.org
>> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
>> >
>> >- [1]: https://lore.kernel.org/all/20240628-dev-signal-refactor-v1-1-0c391b260261@sifive.com/
>> >
>> >Thanks,
>> >Andy
>
>Regards,
>Andy

