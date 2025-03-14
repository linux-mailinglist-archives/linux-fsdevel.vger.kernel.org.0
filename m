Return-Path: <linux-fsdevel+bounces-44030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484FBA61620
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8883B3B008F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF7470824;
	Fri, 14 Mar 2025 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IYtijmjX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92F20013C
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969205; cv=none; b=OkGcnt0ddLLh9Ukuh5AM48DDVXcC2xVEqvBPLzWyT5G3W+Q5pg0dKqWLGvWVm5Tk1kEENKK57i4Xwb3ptfFcMHckVVA9yNHAIttZ/hiGtnNlSPoN3gb4vQYmI3NBTn2EnT9DezeJp32Rc155UUAtTACa84IE+/y4yI7ohysasp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969205; c=relaxed/simple;
	bh=IjfqCxJWOuyuQTYKA1wW0W4fouvMcTGBSmGHe1hIGLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3E/57puhh7KGUgizwwL9908cwetzH1Wi2MApPOsitFlFGFSzCP48QMHDpXb/EZc3uXgEJsSTRpQk+vrUO/ORUYxM8nahdtoPAAYepJ5FRLvjyNOAZNE0DBrRnuelR2EQdzQV1oTwWfbMQAF7xgM5tD1LRhUNJ1MaC7gvw03o5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IYtijmjX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2239c066347so48973295ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741969201; x=1742574001; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4iE9Aj155vU9nWMwEtJbFQr2Ek1tXLJTCSgBH0mDSSs=;
        b=IYtijmjXNJLYeugSpGA3Y11W7CHNJ5QSxFEN1rxTiEBfVOj0b9Z43ZTkTNBrNhBT70
         36dL8x5EuKfgmWNEE+KjuCgAq8Ay9utWD3GJs2sVaHZLx0tdSRSJOG1S+XC/S1XeE9XS
         xEbmJwHRCpjhJG2+xk1K7gONpCt1/0VaLsDluBB2uwMdHTftosaNHaKBAkJ0gpaxCnTc
         E3vKbQI9G218kJvvehzcKK/X7g1xW+CXsU0FR/ZsQjndxl3MXc7R2V7JKq1zKGIY53+A
         Ty8dia5YJH8k3TE9iHQ2aUmCcJgQ8rqnBdtYE/lRpDcTymwJlY1O4jFb3vHbS0i3D3fz
         AYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741969201; x=1742574001;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4iE9Aj155vU9nWMwEtJbFQr2Ek1tXLJTCSgBH0mDSSs=;
        b=WcUMGkN7s6UnWHE44ykI/+NMzUsjUM0d4X0qP/wKIINS6HOMt62up7glk6vfw4MUBv
         MUoi3+bWxJYd2hZ7Xkmg7SGCaT01Oa/oBHLPEY2RYSck1lkr8pYKo6zuemEXNQTTgFg/
         vGmpCOPhpgQM9T6Ti5C++cAUkLQcD+q7Sa7LEnlsB2T40vb3VLS+xehqaalq7zZuROTh
         LBTawS9pr0g24i1ZaomYksTGdeoIk64pkl+aKw46B9YoMl6z8P/amo/dXJZmdbudCuxk
         rCEriaRu9j/B28SNo7pL1xVQwry8n3WzNr7mIYFKDQNLwhf7yz0UUG8O8AL23KRKQAKn
         ghVg==
X-Forwarded-Encrypted: i=1; AJvYcCVSOEqg/59KOF8pnTTlGMMH+JB9o1yjCPd9ZMGXIRY+PFZEM4HKQbUQXmOmZdPlyw04qcaRZiLxyv/78wC5@vger.kernel.org
X-Gm-Message-State: AOJu0YzNK+LtnhbaYFJz/9dtuuNHQr2XgzzhOEBhxXXN5xXPPV9Vuidj
	OTVu+MpPpHxwKIcu7Runb+Z++/Dz0u+WlDDm8O5EswWnd7Lm0oosID7YLdavUBY=
X-Gm-Gg: ASbGncuLRRjTRqUKRMgcc33PYqRrMKhm6Ug8u2H5pFwEfiz7dueoZfU4yub2fGMCqk0
	jy3+H7mz11gYspQCbICuBJNY0g7qGqkvT0Yo79/ID+p2WwJ8OJh/yoFvNkJ66c08gKNvUc1SFiP
	9ASIeWGaxjWkPXJIDlfc9UE0cFBxaeTALfXljljLIXRqa5SqbQwDlphcqCpRHqNCclHohFuB4ui
	qF4IaEzuDs3FIF9GJpT3aeJxHuKwvArkLStsaupx1q0g9dp8eiqfXUfaqtk67BtmZ4feUXLGf2h
	sivVNxa6fBtJr2HtGsDqRrKNADKPjISSPGaN/3LyMJw387L2E/ilrYgA2bA1KFSUmg==
X-Google-Smtp-Source: AGHT+IHaZv14PiDCCl5alLmsrLTAosVgBcOkr+N1Y8pEfjFu2xgCXzp40ME/YZI+0wTGJ7KUwvdfgw==
X-Received: by 2002:a17:903:2b0c:b0:21f:45d:21fb with SMTP id d9443c01a7336-225e0a28ademr37966685ad.3.1741969201235;
        Fri, 14 Mar 2025 09:20:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153534510sm1208138a91.22.2025.03.14.09.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:20:00 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:19:57 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH v11 13/27] prctl: arch-agnostic prctl for indirect branch
 tracking
Message-ID: <Z9RXLU0w59h1QEtR@debug.ba.rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
 <20250310-v5_user_cfi_series-v11-13-86b36cbfb910@rivosinc.com>
 <CANXhq0r1dd2jCtCbinD4iy9rx+oQ+VDMWjATf1GqxEmuvFzyWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0r1dd2jCtCbinD4iy9rx+oQ+VDMWjATf1GqxEmuvFzyWw@mail.gmail.com>

On Fri, Mar 14, 2025 at 04:25:59PM +0800, Zong Li wrote:
>On Mon, Mar 10, 2025 at 11:42 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Three architectures (x86, aarch64, riscv) have support for indirect branch
>> tracking feature in a very similar fashion. On a very high level, indirect
>> branch tracking is a CPU feature where CPU tracks branches which uses
>> memory operand to perform control transfer in program. As part of this
>> tracking on indirect branches, CPU goes in a state where it expects a
>> landing pad instr on target and if not found then CPU raises some fault
>> (architecture dependent)
>>
>> x86 landing pad instr - `ENDBRANCH`
>> aarch64 landing pad instr - `BTI`
>> riscv landing instr - `lpad`
>>
>> Given that three major arches have support for indirect branch tracking,
>> This patch makes `prctl` for indirect branch tracking arch agnostic.
>>
>> To allow userspace to enable this feature for itself, following prtcls are
>> defined:
>>  - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect
>>    branch tracking.
>>  - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch
>>    tracking.
>>    Following status options are allowed
>>        - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
>>          thread.
>>        - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on user
>>          thread.
>>  - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branch
>>    tracking for user thread.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> ---
>>  arch/riscv/include/asm/usercfi.h | 16 ++++++++-
>>  arch/riscv/kernel/entry.S        |  2 +-
>>  arch/riscv/kernel/process.c      |  5 +++
>>  arch/riscv/kernel/usercfi.c      | 76 ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/cpu.h              |  4 +++
>>  include/uapi/linux/prctl.h       | 27 ++++++++++++++
>>  kernel/sys.c                     | 30 ++++++++++++++++
>>  7 files changed, 158 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
>> index c4dcd256f19a..a8cec7c14d1d 100644
>> --- a/arch/riscv/include/asm/usercfi.h
>> +++ b/arch/riscv/include/asm/usercfi.h
>> @@ -16,7 +16,9 @@ struct kernel_clone_args;
>>  struct cfi_status {
>>         unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>>         unsigned long ubcfi_locked : 1;
>> -       unsigned long rsvd : ((sizeof(unsigned long) * 8) - 2);
>> +       unsigned long ufcfi_en : 1; /* Enable for forward cfi. Note that ELP goes in sstatus */
>> +       unsigned long ufcfi_locked : 1;
>> +       unsigned long rsvd : ((sizeof(unsigned long) * 8) - 4);
>>         unsigned long user_shdw_stk; /* Current user shadow stack pointer */
>>         unsigned long shdw_stk_base; /* Base address of shadow stack */
>>         unsigned long shdw_stk_size; /* size of shadow stack */
>> @@ -33,6 +35,10 @@ bool is_shstk_locked(struct task_struct *task);
>>  bool is_shstk_allocated(struct task_struct *task);
>>  void set_shstk_lock(struct task_struct *task);
>>  void set_shstk_status(struct task_struct *task, bool enable);
>> +bool is_indir_lp_enabled(struct task_struct *task);
>> +bool is_indir_lp_locked(struct task_struct *task);
>> +void set_indir_lp_status(struct task_struct *task, bool enable);
>> +void set_indir_lp_lock(struct task_struct *task);
>>
>>  #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
>>
>> @@ -58,6 +64,14 @@ void set_shstk_status(struct task_struct *task, bool enable);
>>
>>  #define set_shstk_status(task, enable)
>>
>> +#define is_indir_lp_enabled(task) false
>> +
>> +#define is_indir_lp_locked(task) false
>> +
>> +#define set_indir_lp_status(task, enable)
>> +
>> +#define set_indir_lp_lock(task)
>> +
>>  #endif /* CONFIG_RISCV_USER_CFI */
>>
>>  #endif /* __ASSEMBLY__ */
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 68c99124ea55..00494b54ff4a 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -143,7 +143,7 @@ SYM_CODE_START(handle_exception)
>>          * Disable the FPU/Vector to detect illegal usage of floating point
>>          * or vector in kernel space.
>>          */
>> -       li t0, SR_SUM | SR_FS_VS
>> +       li t0, SR_SUM | SR_FS_VS | SR_ELP
>>
>>         REG_L s0, TASK_TI_USER_SP(tp)
>>         csrrc s1, CSR_STATUS, t0
>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>> index cd11667593fe..4587201dd81d 100644
>> --- a/arch/riscv/kernel/process.c
>> +++ b/arch/riscv/kernel/process.c
>> @@ -160,6 +160,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>>         set_shstk_status(current, false);
>>         set_shstk_base(current, 0, 0);
>>         set_active_shstk(current, 0);
>> +       /*
>> +        * disable indirect branch tracking on exec.
>> +        * libc will enable it later via prctl.
>> +        */
>> +       set_indir_lp_status(current, false);
>
>In set_indir_lp_status and set_shstk_status, the $senvcfg.LPE and
>$senvcfg.SSE fields are set. However, if the CPU does not support this
>CSR, writing to it will trigger an illegal instruction exception.
>Should we add sanity checks to handle this situation? Thanks

hmm. these were two patches. something happened in my workflow and two
were squash together it seems. I need to split them (one for introduction
of generic prctls and another which implements them on riscv)

Being said that, yes good point here. I'll make that change.
>>
>>  #ifdef CONFIG_64BIT
>>         regs->status &= ~SR_UXL;
>> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
>> index 37d6fb8144e7..3a66f149a4ef 100644
>> --- a/arch/riscv/kernel/usercfi.c
>> +++ b/arch/riscv/kernel/usercfi.c
>> @@ -69,6 +69,32 @@ void set_shstk_lock(struct task_struct *task)
>>         task->thread_info.user_cfi_state.ubcfi_locked = 1;
>>  }
>>
>> +bool is_indir_lp_enabled(struct task_struct *task)
>> +{
>> +       return task->thread_info.user_cfi_state.ufcfi_en ? true : false;
>> +}
>> +
>> +bool is_indir_lp_locked(struct task_struct *task)
>> +{
>> +       return task->thread_info.user_cfi_state.ufcfi_locked ? true : false;
>> +}
>> +
>> +void set_indir_lp_status(struct task_struct *task, bool enable)
>> +{
>> +       task->thread_info.user_cfi_state.ufcfi_en = enable ? 1 : 0;
>> +
>> +       if (enable)
>> +               task->thread.envcfg |= ENVCFG_LPE;
>> +       else
>> +               task->thread.envcfg &= ~ENVCFG_LPE;
>> +
>> +       csr_write(CSR_ENVCFG, task->thread.envcfg);
>> +}
>> +
>> +void set_indir_lp_lock(struct task_struct *task)
>> +{
>> +       task->thread_info.user_cfi_state.ufcfi_locked = 1;
>> +}
>>  /*
>>   * If size is 0, then to be compatible with regular stack we want it to be as big as
>>   * regular stack. Else PAGE_ALIGN it and return back
>> @@ -369,3 +395,53 @@ int arch_lock_shadow_stack_status(struct task_struct *task,
>>
>>         return 0;
>>  }
>> +
>> +int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
>> +{
>> +       unsigned long fcfi_status = 0;
>> +
>> +       if (!cpu_supports_indirect_br_lp_instr())
>> +               return -EINVAL;
>> +
>> +       /* indirect branch tracking is enabled on the task or not */
>> +       fcfi_status |= (is_indir_lp_enabled(t) ? PR_INDIR_BR_LP_ENABLE : 0);
>> +
>> +       return copy_to_user(status, &fcfi_status, sizeof(fcfi_status)) ? -EFAULT : 0;
>> +}
>> +
>> +int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
>> +{
>> +       bool enable_indir_lp = false;
>> +
>> +       if (!cpu_supports_indirect_br_lp_instr())
>> +               return -EINVAL;
>> +
>> +       /* indirect branch tracking is locked and further can't be modified by user */
>> +       if (is_indir_lp_locked(t))
>> +               return -EINVAL;
>> +
>> +       /* Reject unknown flags */
>> +       if (status & ~PR_INDIR_BR_LP_ENABLE)
>> +               return -EINVAL;
>> +
>> +       enable_indir_lp = (status & PR_INDIR_BR_LP_ENABLE) ? true : false;
>> +       set_indir_lp_status(t, enable_indir_lp);
>> +
>> +       return 0;
>> +}
>> +
>> +int arch_lock_indir_br_lp_status(struct task_struct *task,
>> +                                unsigned long arg)
>> +{
>> +       /*
>> +        * If indirect branch tracking is not supported or not enabled on task,
>> +        * nothing to lock here
>> +        */
>> +       if (!cpu_supports_indirect_br_lp_instr() ||
>> +           !is_indir_lp_enabled(task) || arg != 0)
>> +               return -EINVAL;
>> +
>> +       set_indir_lp_lock(task);
>> +
>> +       return 0;
>> +}
>> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
>> index 6a0a8f1c7c90..fb0c394430c6 100644
>> --- a/include/linux/cpu.h
>> +++ b/include/linux/cpu.h
>> @@ -204,4 +204,8 @@ static inline bool cpu_mitigations_auto_nosmt(void)
>>  }
>>  #endif
>>
>> +int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status);
>> +int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status);
>> +int arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status);
>> +
>>  #endif /* _LINUX_CPU_H_ */
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index 5c6080680cb2..6cd90460cbad 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -353,4 +353,31 @@ struct prctl_mm_map {
>>   */
>>  #define PR_LOCK_SHADOW_STACK_STATUS      76
>>
>> +/*
>> + * Get the current indirect branch tracking configuration for the current
>> + * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STATUS.
>> + */
>> +#define PR_GET_INDIR_BR_LP_STATUS      77
>> +
>> +/*
>> + * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE will
>> + * enable cpu feature for user thread, to track all indirect branches and ensure
>> + * they land on arch defined landing pad instruction.
>> + * x86 - If enabled, an indirect branch must land on `ENDBRANCH` instruction.
>> + * arch64 - If enabled, an indirect branch must land on `BTI` instruction.
>> + * riscv - If enabled, an indirect branch must land on `lpad` instruction.
>> + * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indirect
>> + * branches will no more be tracked by cpu to land on arch defined landing pad
>> + * instruction.
>> + */
>> +#define PR_SET_INDIR_BR_LP_STATUS      78
>> +# define PR_INDIR_BR_LP_ENABLE            (1UL << 0)
>> +
>> +/*
>> + * Prevent further changes to the specified indirect branch tracking
>> + * configuration.  All bits may be locked via this call, including
>> + * undefined bits.
>> + */
>> +#define PR_LOCK_INDIR_BR_LP_STATUS      79
>> +
>>  #endif /* _LINUX_PRCTL_H */
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index cb366ff8703a..f347f3518d0b 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -2336,6 +2336,21 @@ int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long st
>>         return -EINVAL;
>>  }
>>
>> +int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
>> +{
>> +       return -EINVAL;
>> +}
>> +
>> +int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
>> +{
>> +       return -EINVAL;
>> +}
>> +
>> +int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long status)
>> +{
>> +       return -EINVAL;
>> +}
>> +
>>  #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
>>
>>  #ifdef CONFIG_ANON_VMA_NAME
>> @@ -2811,6 +2826,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>                         return -EINVAL;
>>                 error = arch_lock_shadow_stack_status(me, arg2);
>>                 break;
>> +       case PR_GET_INDIR_BR_LP_STATUS:
>> +               if (arg3 || arg4 || arg5)
>> +                       return -EINVAL;
>> +               error = arch_get_indir_br_lp_status(me, (unsigned long __user *)arg2);
>> +               break;
>> +       case PR_SET_INDIR_BR_LP_STATUS:
>> +               if (arg3 || arg4 || arg5)
>> +                       return -EINVAL;
>> +               error = arch_set_indir_br_lp_status(me, arg2);
>> +               break;
>> +       case PR_LOCK_INDIR_BR_LP_STATUS:
>> +               if (arg3 || arg4 || arg5)
>> +                       return -EINVAL;
>> +               error = arch_lock_indir_br_lp_status(me, arg2);
>> +               break;
>>         default:
>>                 trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
>>                 error = -EINVAL;
>>
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

