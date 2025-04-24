Return-Path: <linux-fsdevel+bounces-47223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1A2A9AC7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 13:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1533ADB7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEA2218821;
	Thu, 24 Apr 2025 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bxkmDyDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D072321FF57
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495567; cv=none; b=LTB9f/uEBgh4mFaDq6nTD1nZxgmvaEN++RPrW5nMIDNuVhKb8hZYzTFFdQdD0NJ1KYiCb/9fF1qiZUaj5jhhxfEPPm8OxYtztrWJRSOevWVcjaQVGqezKtccKrEWMv7AMzZA/rhcHm8s9mXmAMb6/8lqZdCy82hJpvODLh2fZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495567; c=relaxed/simple;
	bh=DjB6yBsMl6lrqs3kS6J4Z5q3FIya7mHUZ9ybBLQq0UM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qXjdD5j1jc3CKZMod2BXSEDUJ44AeCZgQTUPmr0zygMP5uB+Zu6GnQ/ww1Xw/3Hd0aOtaMseqgYnPOAXYBplwzDbp/ThcMLZHTZBe65eB8WkChBwtG1UfJNc1T22l3maKzZRjzE0G2QphOLNLgMsD9Ien5E7BNxX8YcZo/JpxAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bxkmDyDA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf861f936so1657325e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745495564; x=1746100364; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+dd0LSkGUj1HE7Y4OEfSLazS5H3NN900Vi5gbnC580=;
        b=bxkmDyDArMx0OqwBa+08lv4xzsGf09Af9eKmh54vpjoHPwLrnysj0ZYaflCREJRWts
         AKiNtHz8cjrkSf0Lbb9NetGIph216zEBEWzP4tv3W681HV5wi6Pp5fu3AOMHWAxsuhky
         MxMQgFjVqxRF0xd+zaK7mTBfYwRrP4UBVdRwSiirZT5trdIhjcLA6DBFRwemvpMjtxhV
         0f/32r5EV8BffeBi7CqmwagilSyuDkE1jLzZxQNIIHhBudYRKIkuEuJyTaBt13eqcawp
         jOABUZF8+8WhJiIA/bf0daBGvGLUfzHDtR59SpViLKNZNAEJI6hfWU7YLCcb4fS26KIL
         Zj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745495564; x=1746100364;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+dd0LSkGUj1HE7Y4OEfSLazS5H3NN900Vi5gbnC580=;
        b=uCt4ibv8toHwxyzVPyOfUZxI/eSMF/ixSbbBbdCm4kHm211WIt/mUjPsVWv1a/eOXP
         LvDc8xiIZVLtpvrek7WJ68lsiln+v2NBhAXwfMA6f3TzGbXwY3rS19ii6fB+7KYzre9X
         Utj01zInJxIwl2xYdc3Bm6SqIkVJcUcp1QQIkmZPhz/mmck/xQNPcxZdZxQRd0KkIj8r
         KzdIi3hACo12vMG/jEBFXjShKxjc2qKdp4HJJKSJeEx4loW4pHb3Sr6saSQUtN49PD58
         QgFa3kccAec5wfvRFi04HZz/+gDarn66KAYhxf/CCg+zO/eGyDiKLllGtVUTiHC7SHnB
         hbLA==
X-Forwarded-Encrypted: i=1; AJvYcCXb0y/XuH4gbLh+SeoJenY5yDI0CInpf7eK1Muh1fjn6LcnxOx5e3n/I53WEZDqdsPEOHxtVZKHHg96E6yB@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZyAu/S7jyAhNUUbiWXBJPm++lc/nHRkyKT2aZC/fR2D6K7ue
	Fiy0n9zYtEsr1KAo09p6FjG3CGW/zkGw0gMBWFGAibyxJNYfWXBLjVuh5Pfbd8k=
X-Gm-Gg: ASbGnctX4ATzOKCDg07DgCC9zor+MWxkuhMMToEjYOi40+qB4SHfGBT6r1fYQdheJe6
	wpDYqdiOpyjmCzm5qPahsv1zeOTrs6yR2JE5n+7ETa25Wka2qUBMS3ohgIhVx8NAK7Awm1MbAq0
	4Fv6arm3xZMxhJGlFoVczw1nmE/yV9Jao5L2QY0rxGCY+r+L1+jLbEvoEnTbrbgcWFN5vEJsbK/
	R/z2J/pFVRKQ77WkOErKv4COmSxLrsqxcFErP8t7OdSv/vyBGimPIF5xphjmAUPHtBoz3/uTOR6
	OczTUckbOqtgWlITT0atnz7rZpbMsY8ECFoQS5GaNUXJn3V6
X-Google-Smtp-Source: AGHT+IF8wqwUphleYE2qKoazIUMOkR8h6x1rMfa0xrlvKXCx8csAkRx3P4JsSRpMyeAudqq5D+3jRA==
X-Received: by 2002:a5d:6d8a:0:b0:3a0:678f:ddd8 with SMTP id ffacd0b85a97d-3a06cf5262cmr625001f8f.2.1745495563895;
        Thu, 24 Apr 2025 04:52:43 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:b30c:ee4d:9e10:6a46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d5323casm1860957f8f.75.2025.04.24.04.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 04:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Apr 2025 13:52:43 +0200
Message-Id: <D9EUJBQ5OHN0.2KUJHGXK262TR@ventanamicro.com>
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
In-Reply-To: <aAl_HRk49lnseiio@debug.ba.rivosinc.com>

2025-04-23T17:00:29-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Apr 10, 2025 at 01:04:39PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>>2025-03-14T14:39:24-07:00, Deepak Gupta <debug@rivosinc.com>:
>>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/=
asm/thread_info.h
>>> @@ -62,6 +62,9 @@ struct thread_info {
>>>  	long			user_sp;	/* User stack pointer */
>>>  	int			cpu;
>>>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>>> +#ifdef CONFIG_RISCV_USER_CFI
>>> +	struct cfi_status	user_cfi_state;
>>> +#endif
>>
>>I don't think it makes sense to put all the data in thread_info.
>>kernel_ssp and user_ssp is more than enough and the rest can comfortably
>>live elsewhere in task_struct.
>>
>>thread_info is supposed to be as small as possible -- just spanning
>>multiple cache-lines could be noticeable.
>
> I can change it to only include only `user_ssp`, base and size.

No need for base and size either -- we don't touch that in the common
exception code.

> But before we go there, see below:
>
> $ pahole -C thread_info kbuild/vmlinux
> struct thread_info {
>          long unsigned int          flags;                /*     0     8 =
*/
>          int                        preempt_count;        /*     8     4 =
*/
>
>          /* XXX 4 bytes hole, try to pack */
>
>          long int                   kernel_sp;            /*    16     8 =
*/
>          long int                   user_sp;              /*    24     8 =
*/
>          int                        cpu;                  /*    32     4 =
*/
>
>          /* XXX 4 bytes hole, try to pack */
>
>          long unsigned int          syscall_work;         /*    40     8 =
*/
>          struct cfi_status          user_cfi_state;       /*    48    32 =
*/
>          /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
>          long unsigned int          a0;                   /*    80     8 =
*/
>          long unsigned int          a1;                   /*    88     8 =
*/
>          long unsigned int          a2;                   /*    96     8 =
*/
>
>          /* size: 104, cachelines: 2, members: 10 */
>          /* sum members: 96, holes: 2, sum holes: 8 */
>          /* last cacheline: 40 bytes */
> };
>
> If we were to remove entire `cfi_status`, it would still be 72 bytes (88 =
bytes
> if shadow call stack were enabled) and already spans across two cacheline=
s.

It has only 64 bytes of data without shadow call stack, but it wasted 8
bytes on the holes.
a2 is somewhat an outlier that is not used most exception paths and
excluding it makes everything fit nicely even now.

> if shadow call stack were enabled) and already spans across two cacheline=
s. I
> did see the comment above that it should fit inside a cacheline. Although=
 I
> assumed its stale comment given that it already spans across cacheline an=
d I
> didn't see any special mention in commit messages of changes which grew t=
his
> structure above one cacheline. So I assumed this was a stale comment.
>
> On the other hand, whenever enable/lock bits are checked, there is a high
> likelyhood that user_ssp and other fields are going to be accessed and
> thus it actually might be helpful to have it all in one cacheline during
> runtime.

Yes, although accessing enable/lock bits will be relatively rare.
It seems better to have the overhead during thread setup, rather than on
every trap.

> So I am not sure if its helpful sticking to the comment which already is =
stale.

We could fix the holes and also use sp instead of a0 in the
new_vmalloc_check, so everything would fit better.

We are really close to fitting into a single cache-line, so I'd prefer
if shadow stack only filled thread_info with data that is used very
often in the exception handling code.

I think we could do without user_sp in thread_info as well, so there are
other packing options.

Btw. could ssp be added to pt_regs?

Thanks.

