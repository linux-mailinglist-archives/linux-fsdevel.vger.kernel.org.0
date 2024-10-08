Return-Path: <linux-fsdevel+bounces-31279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD6A993F40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9F21C21894
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAE31DF243;
	Tue,  8 Oct 2024 06:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XTIHt7n8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BFF1DEFDE
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368877; cv=none; b=Tlzcgpvi+WY6IycxTO3UK2vqrESbB0l44Cz7rN484R5NOrAnqqQhkV9SEpGYamqEK7tV0eZOw4p1w7tsTbtkreMND7p1GKF/IP8J80h7ONUVaqbnz8AzB03zzBHASyr7FaV2fkhHWH1TP0USOKZj30yCbg+DkeoVL+WQjjb3qzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368877; c=relaxed/simple;
	bh=sRrs971ywU2XBHAio/v+KH3KPEi6b2tpjaOK3Y8GDYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEHmRzD6dSaOEvYBZGdmrRo4kiHsmKYP/WZpYW2Nlz1Zbjq4/WUVnVa07TRxGQFn6zQHaKOc18Q+a2M/2QpHjBpnCe5ZgcMXtjMHEMGAfxFz4KyBKZisN7fqNQMC5KzTU85Huknrip6IgGka32ZVMxBK54oc6FqO4bCK+HskX2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XTIHt7n8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e06acff261so3594741a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 23:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728368873; x=1728973673; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yD1uY1GFMUYlwE1Gpa3bWH24Ki4C8p8PksybGuIxKXE=;
        b=XTIHt7n8eFdZ98U/iFWue/AxK+I9gGtVd1ksnkBACkNE4Ir/TPvhqYx+tkzy8Sl5J5
         Swmen6YabiMoYR83mUXPFuus/OrvInPq/eOgEJjayw11BERkTFwsaDqhqR8TEnNdadX2
         HSjfp0VtceYiCRaLbHfQ1dlUm01Y+B+4/hIvll01ntHwoKENIJ5+LxiF9Ek2G2TaLjJI
         kyQOrkZSTZ1/WGp6V+i5slBo/mqB39+TwKTPE9YGXfyY2ffObMucn5Q6jg3XMnjAHtjA
         Q+34YskpP/mU99fti72DpH+Ol4kOXEWdvmkEy1ffzlCW4BcziiNvJrrIUm2NZgiGUvsJ
         hdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728368873; x=1728973673;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yD1uY1GFMUYlwE1Gpa3bWH24Ki4C8p8PksybGuIxKXE=;
        b=q9W/PjzufD3EvqpkOIYSASmk3TwjHFaOqF1DFp1Nwt3wtRa6v+fqlI+WCR/aYMGRlK
         tq/XkSHT6pRD2cKa+wJ9yJj0AkfgJFe0i/PB0MEs9pfQVTn00LeLi/GhhL4dHDRHG3dR
         C2xNf5oIQ8pS+O7M02HNc9M9L60jYkwFBebWuX020yqqyu8jlv59wHg0aPmA57dnIQD4
         JuIURFRlUvZzTzpvldUk7Uvc4qtQ1iNX9Ubd5Hnk//IEszndIbf+vk9oR0doE9h+P2j0
         lGp3CZ5/8H753UilYVwIGZGLaZGUm4ohF4R1hp+RN79CBRpT1iJCR4s3/tozscJZqD2L
         6wxw==
X-Forwarded-Encrypted: i=1; AJvYcCVVB5Z/iSmNjBEw/3OUe/r5lVN+c4cbZiBeNeWmg00EQ3eu30yvB7HX57VFuxpnp8grwDFPFZq5bdHP/Hfw@vger.kernel.org
X-Gm-Message-State: AOJu0YxCPMsJcfdsyIziwymYfz9c+AzDiF2KmGNRIT4lfdG4c4WWYVXu
	HpRWF7bKv7eUYEG4MqddExzi9GbdDf+kOWgteQGC4b30cj67zDXjZLo5SCiEPwU=
X-Google-Smtp-Source: AGHT+IF/ZQHlU6tp9Sg21rBMwoL6ZDWlzQEcykMAFPhKfSpu/YJnzOfJudFoJo575FCLm+0FY5JUkg==
X-Received: by 2002:a17:90b:1b05:b0:2d3:cd5c:15bb with SMTP id 98e67ed59e1d1-2e1e63698a6mr17009604a91.25.1728368873537;
        Mon, 07 Oct 2024 23:27:53 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e28b773a77sm464805a91.11.2024.10.07.23.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 23:27:53 -0700 (PDT)
Date: Mon, 7 Oct 2024 23:27:49 -0700
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
Subject: Re: [PATCH 16/33] riscv/shstk: If needed allocate a new shadow stack
 on clone
Message-ID: <ZwTQ5c+YOQFHa4YC@debug.ba.rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-16-3ba65b6e550f@rivosinc.com>
 <CANXhq0rpwQkZ9+mZLGVUq=r4WiA8BbZ-eeTDogf3fzeEPqeeqA@mail.gmail.com>
 <ZwRvAEwFbrpq3zZq@debug.ba.rivosinc.com>
 <CANXhq0qaokjDC9hb75_dpGuyOd_ex8+q7YNe8pAg7dbTcxuLSg@mail.gmail.com>
 <ZwTDonkiATv999sS@debug.ba.rivosinc.com>
 <CANXhq0r611Hi7pohDGRXhvi2E_uOFjwLRDrqZcL2WdLHcs+oHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0r611Hi7pohDGRXhvi2E_uOFjwLRDrqZcL2WdLHcs+oHA@mail.gmail.com>

On Tue, Oct 08, 2024 at 02:18:58PM +0800, Zong Li wrote:
>On Tue, Oct 8, 2024 at 1:31 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> On Tue, Oct 08, 2024 at 01:16:17PM +0800, Zong Li wrote:
>> >On Tue, Oct 8, 2024 at 7:30 AM Deepak Gupta <debug@rivosinc.com> wrote:
>> >>
>> >> On Mon, Oct 07, 2024 at 04:17:47PM +0800, Zong Li wrote:
>> >> >On Wed, Oct 2, 2024 at 12:20 AM Deepak Gupta <debug@rivosinc.com> wrote:
>> >> >>
>> >> >> Userspace specifies CLONE_VM to share address space and spawn new thread.
>> >> >> `clone` allow userspace to specify a new stack for new thread. However
>> >> >> there is no way to specify new shadow stack base address without changing
>> >> >> API. This patch allocates a new shadow stack whenever CLONE_VM is given.
>> >> >>
>> >> >> In case of CLONE_VFORK, parent is suspended until child finishes and thus
>> >> >> can child use parent shadow stack. In case of !CLONE_VM, COW kicks in
>> >> >> because entire address space is copied from parent to child.
>> >> >>
>> >> >> `clone3` is extensible and can provide mechanisms using which shadow stack
>> >> >> as an input parameter can be provided. This is not settled yet and being
>> >> >> extensively discussed on mailing list. Once that's settled, this commit
>> >> >> will adapt to that.
>> >> >>
>> >> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> >> >> ---
>> >> >>  arch/riscv/include/asm/usercfi.h |  25 ++++++++
>> >>
>> >> ... snipped...
>> >>
>> >> >> +
>> >> >> +/*
>> >> >> + * This gets called during clone/clone3/fork. And is needed to allocate a shadow stack for
>> >> >> + * cases where CLONE_VM is specified and thus a different stack is specified by user. We
>> >> >> + * thus need a separate shadow stack too. How does separate shadow stack is specified by
>> >> >> + * user is still being debated. Once that's settled, remove this part of the comment.
>> >> >> + * This function simply returns 0 if shadow stack are not supported or if separate shadow
>> >> >> + * stack allocation is not needed (like in case of !CLONE_VM)
>> >> >> + */
>> >> >> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
>> >> >> +                                          const struct kernel_clone_args *args)
>> >> >> +{
>> >> >> +       unsigned long addr, size;
>> >> >> +
>> >> >> +       /* If shadow stack is not supported, return 0 */
>> >> >> +       if (!cpu_supports_shadow_stack())
>> >> >> +               return 0;
>> >> >> +
>> >> >> +       /*
>> >> >> +        * If shadow stack is not enabled on the new thread, skip any
>> >> >> +        * switch to a new shadow stack.
>> >> >> +        */
>> >> >> +       if (is_shstk_enabled(tsk))
>> >> >
>> >> >Hi Deepak,
>> >> >Should it be '!' is_shstk_enabled(tsk)?
>> >>
>> >> Yes it is a bug. It seems like fork without CLONE_VM or with CLONE_VFORK, it was returning
>> >> 0 anyways. And in the case of CLONE_VM (used by pthread), it was not doing the right thing.
>> >
>> >Hi Deepak,
>> >I'd like to know if I understand correctly. Could I know whether there
>> >might also be a risk when the user program doesn't enable the CFI and
>> >the kernel doesn't activate CFI. Because this flow will still try to
>> >allocate the shadow stack and execute the ssamowap command. Thanks
>>
>> `shstk_alloc_thread_stack` is only called from `copy_thread` and  allocates and
>> returns non-zero (positive value) for ssp only if `CLONE_VM` is specified.
>> `CLONE_VM` means that address space is shared and userspace has allocated
>> separate stack. This flow is ensuring that newly created thread with separate
>> data stack gets a separate shadow stack as well.
>>
>> Retruning zero value from `shstk_alloc_thread_stack` means that, no need to
>> allocate a shadow stack. If you look at `copy_thread` function, it simply sets
>> the returned ssp in newly created task's task_struct (if it was non-zero).
>> If returned ssp was zero, `copy_thread` doesn't do anything. Thus whatever is
>> current task settings are that will be copied over to new forked/cloned task.
>> If current task had shadow stack enabled, new task will also get it enabled at
>> same address (to be COWed later).
>>
>> Any task get shadow stack enabled for first time using new prctls (see prctl
>> patches).
>>
>> So only time `ssamoswap` will be exercised will be are
>> - User issues enabling `prctl` (it'll be issued from loader)
>> - fork/clone happens
>>
>> In both cases, it is guarded against checks of whether cpu supports it and task
>> has shadow stack enabled.
>>
>> Let me know if you think I missed any flow.
>
>Thanks a lot for the detail, it is very helpful for me. But sorry for
>the confusion, my question is actually on the situation with this bug
>(i.e., before the fix)


Yeah with the bug (i.e. before the fix), this function would still return 0
for `fork` or `clone` with `!CLONE_VM`. And if existing (current) thread had
shadow stack enabled, that will become shadow stack for new thread (COWed later)

The bug would surface only when `clone` is called with `CLONE_VM` and in that case
instead of allocating a new shadow stack, it would be re-using same shadow stack
for both `pthreads`.

In anycase, thanks again for noticing and bringing it up.

>
>>
>> >
>> >> Most of the testing has been with busybox build (independent binaries0 driven via buildroot
>> >> setup. Wondering why it wasn't caught.
>> >>
>> >> Anyways, will fix it. Thanks for catching it.
>> >>
>> >> >
>> >> >> +               return 0;
>> >> >> +
>> >> >> +       /*

