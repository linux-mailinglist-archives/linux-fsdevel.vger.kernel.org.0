Return-Path: <linux-fsdevel+bounces-47354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745DCA9C798
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95A2160C90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C585D23E32D;
	Fri, 25 Apr 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BeKf1Jbv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444623D2A7
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745580460; cv=none; b=MkenSJJOdUDq8YdSnOgoJNJ3YkrGkdAQEvnFjzx1cEo3TDph7LabCuhe3CsqGSS8SbnJ8jyGxjS9/hsyaSrtruy/BAe2gP1GYsnB2KfWdEsut+75MT/KZco0GQX+dUP+5Soxqj+CWmKUAkCNpsahkG06dsMloz4cy/w1DM/pYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745580460; c=relaxed/simple;
	bh=L9I7eiN2f73J5dPVzszuLYpZejlZqjoUq0SaVPSprwE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=B0b0GkUVxHPUyQxme/BKnJUCHnDM1zaqKlUVMjfDYufUlPJnyGAbd+wxdza8CjpjOGPj+oplVS5dLWkTcnbk4vsAC2QwpIO5oKpCGNt+ieUbzTvf7Kubtrt/35/ijiQLiHu8ZDxUgKUxW0BxV0GmLb4A84tQKooZvkQZ04NIE24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BeKf1Jbv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912ebb8e88so128243f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 04:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745580456; x=1746185256; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tdcxdU/uqiM5JHIE0ih8RzkRpPBvVsrQ+sQtZ+utPU=;
        b=BeKf1JbvEe86laQNNzzsu38dwjJfOp2oJziFAnmoWqsMbkQX7rgfKSMJBcS5wn9lX/
         le6OTfnKYIUDlr9y9es740hx/A9QyE25H/Yy+CuZFImgWB9RUme4Zk7a2clmaukJFFFF
         //djvxQCG2JB89Vw4/pGrhGGowVfM6p8qj5ic2tcEPQ5D13mdFo3TQoIpozBKfyOlZNm
         sprNbfWJ6nQNdxp2NXBN4IYtQk6d5oczduvV1ZJLHEB0gAgCUSl9EZmROHTItBH2ShDh
         2+rVqlSze0iTzP8C2PHzqtFySPVO2sfoSKtGvY4RRXwUizBClW/EBnWfPWEMPnI8AZkM
         ddhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745580456; x=1746185256;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9tdcxdU/uqiM5JHIE0ih8RzkRpPBvVsrQ+sQtZ+utPU=;
        b=U1FcnsYbniPWnr6nC3wgUM0wx31/9hUTzvZxTOPEAlOcUyf99lVgsmU9GBm0jgIndI
         JZmWFFofmB9WE4vPWx5HQ0aOedk/GOUbmDgLUnqL8GugSmqh7GBI09f17SNAjhpQSiB4
         8shRUWsJwf9wUt1bSQ6iBZnOmdL2e0Q7xt/JuFivhXX31jWSVLIqGroYBiacYPAJkIlv
         TGwyhzyNJHGO/njFlQq42ZuHhsg8zY21Swq/j3tWUeODhkHVfxfViwrjKZx7Su/NgftO
         URlzvQe7sFrATdS0rPTntL2DazhYSyx7yJ+E8wuLCKDOTBjrBX1ei6UdgXy5TbDtUMz/
         /D4w==
X-Forwarded-Encrypted: i=1; AJvYcCUOjVUSQglESfc96/D2RUDjOk3GQeR17LjzbD5n5IgPKmYtPzru3dti+rkshlq8OgUc4w5vKkgB+328mTVv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RcrJ4H+DTuQJl/OM3Pehu5DMtXIUGFQliahIbIaLk5OkMQW6
	TwT64VQ27u6nOWXeZbovk+97BOq42SvQWE4bZlo2wdXwrbrI8ZwLcEvJVmgb/RA=
X-Gm-Gg: ASbGnctiJN3/ETqVEYqh18ijqBzU2GFsZI1iMbFu07Nh1FBiMAe5xFITrleA0VGNQoI
	QlbEyKCupGgqjazKlp1el9LJIFf5FjVKRUjWqQC/8Kuyyvd1VEXxGuXLXR5Z4M79vG+iOJMhxtf
	dxd+DK5OJ/X6iXxK+UDBrbSPdYmLD2gsgayRsLm4LmzL5OH/p+KAs9q4TrcbvMQ85Uk10+Vh1I2
	sqwnNkaxDVCm3zHzYntLeMsYCzMBePv1wtCkt1xIFvu0c2vnVb5cq6T6ULzCK37NNgLt2opFrxF
	isPOwCOgd7G/i8K8In9PcFVJsza91Th8tszkLR+cL610nS/Q
X-Google-Smtp-Source: AGHT+IEQ9pK+JKMDBMS71i2ytNl3g5Iz5jsYozyFh9v4Ot2oPm70zEuu2n9VUWJTfr8L27VdCIYOXQ==
X-Received: by 2002:a05:6000:420e:b0:39c:1efc:44ed with SMTP id ffacd0b85a97d-3a074e42259mr527990f8f.7.1745580456083;
        Fri, 25 Apr 2025 04:27:36 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:84a3:2b0a:bdb8:ce08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a536a02csm22002045e9.27.2025.04.25.04.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 04:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Apr 2025 13:27:34 +0200
Message-Id: <D9FOMMGOGOZS.FN9LKYJAB9PD@ventanamicro.com>
Subject: Re: [PATCH v12 05/28] riscv: usercfi state for task and
 save/restore of CSR_SSP on trap entry/exit
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Conor Dooley" <conor@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Arnd Bergmann" <arnd@arndb.de>, "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Eric Biederman" <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <shuah@kernel.org>, "Jann
 Horn" <jannh@google.com>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <alistair.francis@wdc.com>, <richard.henderson@linaro.org>,
 <jim.shu@sifive.com>, <andybnac@gmail.com>, <kito.cheng@sifive.com>,
 <charlie@rivosinc.com>, <atishp@rivosinc.com>, <evan@rivosinc.com>,
 <cleger@rivosinc.com>, <broonie@kernel.org>, <rick.p.edgecombe@intel.com>,
 "Zong Li" <zong.li@sifive.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
 <D92WQWAUQYY4.2ED8JAFBDHGRN@ventanamicro.com>
 <aAl_HRk49lnseiio@debug.ba.rivosinc.com>
 <D9EUJBQ5OHN0.2KUJHGXK262TR@ventanamicro.com>
 <aAp7Un415hNqtshd@debug.ba.rivosinc.com>
In-Reply-To: <aAp7Un415hNqtshd@debug.ba.rivosinc.com>

2025-04-24T10:56:34-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Apr 24, 2025 at 01:52:43PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>>2025-04-23T17:00:29-07:00, Deepak Gupta <debug@rivosinc.com>:
>>> On Thu, Apr 10, 2025 at 01:04:39PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 w=
rote:
>>>>2025-03-14T14:39:24-07:00, Deepak Gupta <debug@rivosinc.com>:
>>>>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/includ=
e/asm/thread_info.h
>>>>> @@ -62,6 +62,9 @@ struct thread_info {
>>>>>  	long			user_sp;	/* User stack pointer */
>>>>>  	int			cpu;
>>>>>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>>>>> +#ifdef CONFIG_RISCV_USER_CFI
>>>>> +	struct cfi_status	user_cfi_state;
>>>>> +#endif
>>>>
>>>>I don't think it makes sense to put all the data in thread_info.
>>>>kernel_ssp and user_ssp is more than enough and the rest can comfortabl=
y
>>>>live elsewhere in task_struct.
>>>>
>>>>thread_info is supposed to be as small as possible -- just spanning
>>>>multiple cache-lines could be noticeable.
>>>
>>> I can change it to only include only `user_ssp`, base and size.
>>
>>No need for base and size either -- we don't touch that in the common
>>exception code.
>
> got it.
>
>>
>>> But before we go there, see below:
>>>
>>> $ pahole -C thread_info kbuild/vmlinux
>>> struct thread_info {
>>>          long unsigned int          flags;                /*     0     =
8 */
>>>          int                        preempt_count;        /*     8     =
4 */
>>>
>>>          /* XXX 4 bytes hole, try to pack */
>>>
>>>          long int                   kernel_sp;            /*    16     =
8 */
>>>          long int                   user_sp;              /*    24     =
8 */
>>>          int                        cpu;                  /*    32     =
4 */
>>>
>>>          /* XXX 4 bytes hole, try to pack */
>>>
>>>          long unsigned int          syscall_work;         /*    40     =
8 */
>>>          struct cfi_status          user_cfi_state;       /*    48    3=
2 */
>>>          /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
>>>          long unsigned int          a0;                   /*    80     =
8 */
>>>          long unsigned int          a1;                   /*    88     =
8 */
>>>          long unsigned int          a2;                   /*    96     =
8 */
>>>
>>>          /* size: 104, cachelines: 2, members: 10 */
>>>          /* sum members: 96, holes: 2, sum holes: 8 */
>>>          /* last cacheline: 40 bytes */
>>> };
>>>
>>> If we were to remove entire `cfi_status`, it would still be 72 bytes (8=
8 bytes
>>> if shadow call stack were enabled) and already spans across two cacheli=
nes.
>>
>>It has only 64 bytes of data without shadow call stack, but it wasted 8
>>bytes on the holes.
>>a2 is somewhat an outlier that is not used most exception paths and
>>excluding it makes everything fit nicely even now.
>
> But we can't exclude shadow call stack. It'll lead to increased size if t=
hat
> config is selected. A solution has to work for all the cases and not half
> hearted effort.

We could drop a0 or user_sp and place the two ints next to each other,
saving at least 16 bytes.

(user_sp, a0, a1, and a2 are just temporary storage.  I think would be
 fine with just two temporaries + kernel_sp, to provide three registers
 for new_vmalloc_check and we never need more.)

>>> if shadow call stack were enabled) and already spans across two cacheli=
nes. I
>>> did see the comment above that it should fit inside a cacheline. Althou=
gh I
>>> assumed its stale comment given that it already spans across cacheline =
and I
>>> didn't see any special mention in commit messages of changes which grew=
 this
>>> structure above one cacheline. So I assumed this was a stale comment.
>>>
>>> On the other hand, whenever enable/lock bits are checked, there is a hi=
gh
>>> likelyhood that user_ssp and other fields are going to be accessed and
>>> thus it actually might be helpful to have it all in one cacheline durin=
g
>>> runtime.
>>
>>Yes, although accessing enable/lock bits will be relatively rare.
>>It seems better to have the overhead during thread setup, rather than on
>>every trap.
>>
>>> So I am not sure if its helpful sticking to the comment which already i=
s stale.
>>
>>We could fix the holes and also use sp instead of a0 in the
>>new_vmalloc_check, so everything would fit better.
>>
>>We are really close to fitting into a single cache-line, so I'd prefer
>>if shadow stack only filled thread_info with data that is used very
>>often in the exception handling code.
>
> I don't get what's the big deal if it results in two cachelines. We can
> (re)organize data structure in a way the most frequently accessed members=
 are
> together in a single cacheline. We just need to find those members.

Yes, and because this patch is reorganizing the structure, I thought it
would be better to do the analysis now, rather than to incur additional
debt.

thread_info members are accessed during the first instructions after a
trap.  We want to maximize the chance that the execution doesn't stall
until uarch has time to engage its crystal ball.

> In the hot path of exception handling, I see accesses to pt_regs on stack=
 as
> well. These are definitley different cacheline than thread_info.

Right, and we also access cache-lines for the code.

I don't know how well each uarch keeps the early trap data/code in
caches, but it doesn't seem like a bad idea to minimize the amount of
cache-lines that are accessed early after trap.

> I understand the argument of one member field crossing into two cacheline=
s can
> have undesired perf effects. I do not understand reasoning that thread_in=
fo
> exactly has to fit inside one cacheline.

I agree that we could probably lift the constraint for some values --
it's a lot of performance modeling and convincing, though...

In this series, I think it would be good to avoid splitting kernel_sp
and a0/a1 into two cache-lines.  kernel_sp and a0/a1 are accessed within
the first few instructions.

> If this was always supposed to fit in a single cacheline, clearly this
> invariant isn't/wasn't maintained as changes trickled in. I would like to=
 see
> what maintainers have to say or someone who did data analysis on this.

I don't think it is necessary to fix the rest, just not making things
worse is already great.

>>I think we could do without user_sp in thread_info as well, so there are
>>other packing options.
>
> Sure, probably somewhere in task_struct. But fact of the matter is that i=
t has
> to be saved/restore during exception entry/exit. But then load/store to
> task_struct is essentially a different cachline. Not sure what we will ac=
hieve
> here?

user_sp is only temporarily storage space in thread_info.
The sp register is restored from pt_regs, so we could refactor the code
to drop user_sp from thread_info.

e.g. use a0, a1, or a2 for the temporary storage: user_sp is not even
the userspace sp, it is sp of the previous sp "user", which might have
been the kernel.

>>Btw. could ssp be added to pt_regs?
>
> I had that earlier. It breaks user abi. And it was a no go.

Thanks, I was afraid of that. :)

We might want to eventually push ssp to the stack to follow the same
design for trap nesting as sp has, but that can happen when implementing
ssp for the kernel.  Squeezing into thread_info should work for now.

