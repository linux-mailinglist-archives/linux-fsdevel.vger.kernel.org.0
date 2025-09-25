Return-Path: <linux-fsdevel+bounces-62768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C76DBA0034
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 16:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BE01BC0A54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323072D7DC2;
	Thu, 25 Sep 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="LhWRuoRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B42D7395
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810632; cv=none; b=M+iErhUOA30fmdezMDb59iqC4fQ6kjopuSXgyEpp+bs8ZPk93R6vK47J9YFmr7py57CdVgbugHkPKywvcHdsNb38/AxGsZrl/KEyS3MkCwiRXWjDx15f1gov1OiwMfaT4wYnfH5RCM8U3C9MAvg1bsFv//mqUOe8+zmEJ1v3S50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810632; c=relaxed/simple;
	bh=C0GfpwF7RY7Xo4qa0YBZdMNr7838kNVWqEk+4k+STrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsLpTC3InxRtygN7cP+1aK5qiw7IqqWLc/scAZ8mN3RtwcWv+WluxzYQ3+yypGeax4n+IxjuTkiUNPU9MspJi06FQWEctDO9FPJ8CXGWc5iF3rbzkKqHqP8WgtDEouhszve9BFRe3sfMCN9dRI3/0HfvXtacMraE+egl1zMdLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=LhWRuoRl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2697899a202so17344455ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1758810629; x=1759415429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B/ScXH9deltQU9YLRjtGdHjjN9goLEMoCpX6Ad5jX+g=;
        b=LhWRuoRlIOpX0Eb7orLG7HINPKL4NxpLqV8UjVFVXQ6JGBZ+/MnLWcKx2FCPuUdYWg
         CUdKHZPhEtgBtAZRCDM4zK/wr2UYfEXXPH5SSvy6cvn6qgfvQwZhi9gWjDRO0D6LXna1
         rj3aK27ZJ2GaUVaQVqmCyjouwM4nTJR7NcdU7lN5tIQ08Ch9x6FuWfpzVonhRtiUMi8R
         7fv4IjYWywwHz+MshJnPKPrc4HiLahN62o7z/GrztqVydi3bMEG9crneIqkG71vU3i/O
         AvdiVMLQAkKMhtZcSA3UmVkr8LciY1LYWdSedWs7yWj/2c+2aRjpvufIVvEBNC7LdqLv
         d6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810629; x=1759415429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/ScXH9deltQU9YLRjtGdHjjN9goLEMoCpX6Ad5jX+g=;
        b=a2S4EFa1zzHVdiRyjs8qR7JVPHjITDHkszX5nJMWtEXjAormioUzmzCYttK7KUOlFP
         f2UaFVlJg9BK6OQmNk7i/XcaQSZSx2eNrvSfiEOP9FDxyK+0p3zNJ+KiR8a7dW8xxGmJ
         U5r31J6tu/gJpgNbN2xLlUvagvqQ+AZgo4QS/Tp8ZANJxTY20EhVxvUnTAtOMwN8yXTz
         JauokW6C4jZ4ImtPcEj1kBycL2WEpCVz7rcmwWr543ruLL5MVs7YdnBU5uZoz4RiXny7
         N5L5M54LhoGdJ6vjnrMYY3ttm9UD2/7xL/v51JODfTYIAl3Z1xbpNG7UyLDdEQDotwKy
         Ep8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa84KJ/GwI34H4KqH1KQeXP+W1vVaRL7AzsAF3lnnNJuHJMpJc1L0cXCclcxgKArTlTXdnUIUKG/yFTShi@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7lU7Z3xtxWIiVP3exKud2MXo6WN1Jt1vNNDlP59VJsP7OJIF
	ce6YphY35Iyqdob+LWXl/REEVELOo+gZJuDopWinEShl28o3bpogxelWrQxfZPURGi0=
X-Gm-Gg: ASbGncvyNyYgTmVqDoeG14kmZhFhEa+9BPZJYg92fgZrqy+f1vCm0pcsjXvla4HjID0
	JHFpqe2KALkoJE0Uf0cVW2dZro30esLC/0OuSMPDanQuUWxhKPFvJt/zDdNJPKdZ0BFNRZ6KkIw
	aH7u42Hi6KRsbBNqzHQozK8B49Wtpt1nLFn4C5vHSEDS4Ot/U8Amvr37ZuGsLjOhrHUCjvIPdq2
	yv8NZ2MNfs2HsixYJEtH5gIB7DDRPOYiVHzB/Vr9wH8LQycrpnuZA14XWtu5rk93j/46carALXW
	mppGUyNeA5EonYm9Zjz1YbRVC0gvpT+9qxQeSmX/b5RLseT3uMPOXCq6EQcIfcc2CJixhTU3VIu
	/woRwDY/5jvYDJzXxD4K6V9C+taVv+zXs
X-Google-Smtp-Source: AGHT+IGw4nlcyMj0x1ophUEj8Naebsm2dV8OM2R6VcoSoV/iVH85aly4v8pa48kMi8x3QmjHpu5KEw==
X-Received: by 2002:a17:903:3845:b0:26e:7ac9:9d3 with SMTP id d9443c01a7336-27ed722bb71mr33822815ad.18.1758810628859;
        Thu, 25 Sep 2025 07:30:28 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed670f748sm27032895ad.42.2025.09.25.07.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 07:30:28 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:30:24 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Andy Chiu <andybnac@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com,
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Florian Weimer <fweimer@redhat.com>, bharrington@redhat.com,
	Aurelien Jarno <aurel32@debian.org>
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Message-ID: <aNVSAD4Og23rNTms@debug.ba.rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
 <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
 <aNQ7D6_ZYMhCdkmL@debug.ba.rivosinc.com>
 <CAFTtA3Nxq0UmXcuN7jmQOiuTbrenKbR4ihH027ya1WWybgLq4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFTtA3Nxq0UmXcuN7jmQOiuTbrenKbR4ihH027ya1WWybgLq4Q@mail.gmail.com>

On Thu, Sep 25, 2025 at 07:30:08AM -0500, Andy Chiu wrote:
>Hi Deepak,
>
>On Wed, Sep 24, 2025 at 1:40 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> On Wed, Sep 24, 2025 at 08:36:11AM -0600, Paul Walmsley wrote:
>> >Hi,
>> >
>> >On Thu, 31 Jul 2025, Deepak Gupta wrote:
>> >
>> >[ ... ]
>> >
>> >> vDSO related Opens (in the flux)
>> >> =================================
>> >>
>> >> I am listing these opens for laying out plan and what to expect in future
>> >> patch sets. And of course for the sake of discussion.
>> >>
>> >
>> >[ ... ]
>> >
>> >> How many vDSOs
>> >> ---------------
>> >> Shadow stack instructions are carved out of zimop (may be operations) and if CPU
>> >> doesn't implement zimop, they're illegal instructions. Kernel could be running on
>> >> a CPU which may or may not implement zimop. And thus kernel will have to carry 2
>> >> different vDSOs and expose the appropriate one depending on whether CPU implements
>> >> zimop or not.
>> >
>> >If we merge this series without this, then when CFI is enabled in the
>> >Kconfig, we'll wind up with a non-portable kernel that won't run on older
>> >hardware.  We go to great lengths to enable kernel binary portability
>> >across the presence or absence of other RISC-V extensions, and I think
>> >these CFI extensions should be no different.
>> >
>> >So before considering this for merging, I'd like to see at least an
>> >attempt to implement the dual-vDSO approach (or something equivalent)
>> >where the same kernel binary with CFI enabled can run on both pre-Zimop
>> >and post-Zimop hardware, with the existing userspaces that are common
>> >today.
>>
>> Added some distro folks in this email chain.
>>
>> After patchwork meeting today, I wanted to continue discussion here. So thanks
>> Paul for looking into it and initiating a discussion here.
>>
>> This patch series has been in the queue for quite a long time and we have had
>> deliberations on vDSO topic earlier as well and after those deliberations it
>> was decided to go ahead with merge and it indeed was sent for 6.17 merge
>> window. Unfortunatley due to other unforeseen reasons, entirety of riscv
>> changes were not picked. So it's a bit disappointing to see back-paddling on
>> this topic.
>>
>> Anyways, we are here. So I'll provide a bit of context for the list about
>> deliberations and discussions we have been having for so many merge windows.
>> This so that a holistic discussion can happen on this before we make a
>> decision.
>>
>> Issue
>> ======
>>
>> Instructions in RISC-V shadow stack extension (zicfiss - [1]) are carved out of
>> "may be ops" aka zimop extension [2]. "may be ops" are illegal on non-RVA23
>> hardware. This means any existing riscv CPU or future CPU which isn't RVA23
>> compliant and not implementing zimop will treat these encodings as illegal.
>>
>> Current kernel patches enable shadow stack and landing pad support for
>> userspace using config `CONFIG_RISCV_USER_CFI`. If this config is selected then
>> vDSO that will be exposed to user space will also have shadow stack
>> instructions in them. Kernel compiled with `CONFIG_RISCV_USER_CFI`, for sake of
>> this discussion lets call it RVA23 compiled kernel.
>>
>> Issue that we discussed earlier and even today is "This RVA23 compiled kernel
>> won't be able to support non-RVA23 userspace on non-RVA23 hardware because".
>> Please note that issue exists only on non-RVA23 hardware (which is existing
>> hardware and future hardware which is not implementing zimop). RVA23 compiled
>> kernel can support any sort of userspace on RVA23 hardware.
>>
>>
>> Discussion
>> ===========
>>
>> So the issue is not really shadow stack instructions but rather may be op
>> instructions in codegen (binaries and vDSO) which aren't hidden behind any
>> flag (to hide them if hardware doesn't support). And if I can narrow down
>> further, primary issue we are discussing is that if cfi is enabled during
>> kernel compile, it is bringing in a piece of code (vDSO) which won't work
>> on existing hardware. But the counter point is if someone were to deploy
>> RVA23 compiled kernel on non-RVA23 hardware, they must have compiled
>> rest of the userspace without shadow stack instructions in them for such
>> a hardware. And thus at this point they could simply choose *not* to turn on
>> `CONFIG_RISCV_USER_CFI` when compiling such kernel. It's not that difficult to
>> do so.
>>
>> Any distro who is shipping userspace (which all of them are) along with kernel
>> will not be shipping two different userspaces (one with shadow stack and one
>> without them). If distro are shipping two different userspaces, then they might
>> as well ship two different kernels. Tagging some distro folks here to get their
>> take on shipping different userspace depending on whether hardware is RVA23 or
>> not. @Heinrich, @Florian, @redbeard and @Aurelien.
>>
>> Major distro's have already drawn a distinction here that they will drop
>> support for hardware which isn't RVA23 for the sake of keeping binary
>> distribution simple.
>>
>> Only other use case that was discussed of a powerful linux user who just wants
>> to use a single kernel on all kinds of riscv hardware. I am imagining such a
>> user knows enough about kernel and if is really dear to them, they can develop
>> their own patches and send it upstream to support their own usecase and we can
>> discuss them out. Current patchset don't prevent such a developer to send such
>> patches upstream.
>>
>> I heard the argument in meeting today that "Zbb" enabling works similar for
>> kernel today. I looked at "Zbb" enabling. It's for kernel usage and it's
>> surgically placed in kernel using asm hidden behind alternatives. vDSO isn't
>> compiled with Zbb. Shadow stack instructions are part of codegen for C files
>> compiled into vDSO.
>>
>> Furthermore,
>>
>> Kernel control flow integrity will introduce shadow stack instructions all
>> over the kernel binary. Such kernel won't be deployable on non-RVA23 hardware.
>> How to deal with this problem for a savvy kernel developer who wants to run
>> same cfi enabled kernel binary on multiple hardware?
>>
>> Coming from engineering and hacker point of view, I understand the desire here
>> but I still see that it's complexity enforced on rest of the kernel from a user
>> base which anyways can achieve such goals. For majority of usecases, I don't
>> see a reason to increase complexity in the kernel for build, possibly runtime
>> patching and thus possibly introduce more issues and errors just for the sake
>> of a science project.
>>
>> Being said that, re-iterating that currently default for `CONFIG_RISCV_USER_CFI`
>> is "n" which means it won't be breaking anything unless a user opts "Y". So even
>> though I really don't see a reason and usability to have complexity in kernel to
>> carry multiple vDSOs, current patchsets are not a hinderance for such future
>> capability (because current default is No) and motivated developer is welcome
>> to build on top of it. Bottomline is I don't see a reason to block current
>> patchset from merging in v6.18.
>
>Sorry for reiterating, I have been gone for a while, so maybe I lost a
>bit of context.
>
>In that case, should we add a comment in the Kconfig that says "it
>breaks userspace on older-than RVA23 platforms"?

Its quite apparant for whoever is compiling userspace for non-RVA23 hardware.
First sspush/sspopchk instruction in ld/libc will do illegal instruction. It
won't even come to vDSO's sspush/sspopchk.

But sure if that's what get these patches merged in, I can add that comment.

>
>Perhaps a very ugly way to make RVA23-compiled kernel compatible with
>pre-RVA23 platforms is to decode maybe-ops in the illegal exception
>handler...

Yes that can be done but that shouldn't gate current patchset from merging in.

>
>Btw, I don't think kenrel-level shadow stack should be an argument

Argument to block current patches is below
"Kernel should be binary portable". That's why I gave that argument.
A kernel compiled with shadow stack (kcfi) is not portable on non-RVA23
hardware.

Yes we can try making kernel portable by carrying two different vDSO.
One that is for non-RVA23 (actually non-zimop) hardware and one for
RVA23 hardware. But I don't imagine a distro shipping two different
userspaces (ld/glibc, everything) once they start compiling their
userspace with RVA23. If for an instance they start compiling two
userspaces, its not that big of an effort to compile kernel differently
as well. If for an instance they choose to only support rv64gc for
userspace then they are not opting anyways for CFI then just not select
that option in kernel compile. I just don't see a scenario where kernel
is forced to carry two different libraries while rest of the userspace
will not distribute two different binaries for same release.

>here, as kernel-level APIs are more flexible by nature.

I didn't get it. How kernel level APIs help with binary portability
of a kernel compiled in with shadow stack instructions to run on hardware
where these instructions are illegal?

>
>Thanks,
>Andy

