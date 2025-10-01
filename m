Return-Path: <linux-fsdevel+bounces-63132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67213BAEDBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 02:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC28194543F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 00:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7632AEE4;
	Wed,  1 Oct 2025 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="boqJ0Z1j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193745C96
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759277607; cv=none; b=rbCNvLAh+Sp+yMOmzuJ57p8Kj4b4L8HmJasxdeXFUAYH6BtrwKl2gZoP3TBsAPuQTBtm71CVJP6anZMxvLyG1fLUMOZqVDh7zIQPHwaRoQydfFWzUw+Hg7bAQnI3St+/xoyRW08LOszfarr+oZm6vIXRaSWCarkLTX5BNWoZVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759277607; c=relaxed/simple;
	bh=gqyoCfYcvSbHSt4Hjjt/sgk8K9A1QWWHRLiEpqr2tVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnLJZqKp8ve4mC3FdONuUhzgqwppm/U6rSuuaO1TAh2XJpjg//Djx1KIQhTJ9/S93TNvRkNSAq3VK6YKChXPGWmYohSfo7tHBFjUJOqxDtmA8u0v5j84cu+HBZ3qsgpHSWzsmgHqzTGWfTg0AvyHepGaaU+2hcZDywwGXR2BzAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=boqJ0Z1j; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f605f22easo6027878b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 17:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1759277605; x=1759882405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CUsbmESiNHTapnE6rmxwHkpYC/VK0QzGDUHHcofE4qs=;
        b=boqJ0Z1jZVgECeo3rEYRaeGjE3z00y552gyUjE/XxrXTN4T9oBqOSxGEoLv/GI1bqT
         Zq2hvlAvy/tOGH4q2+K1ANInyPulvyHXDGSTNWAUfa4KZ74PlDb7lwjDZQWASoHrnrlJ
         MT3HThs1GMX4n5sVqBKBevDH1B8agZyvln2ADhW1MAlX7LNL+3bznq4iXa5l81/5s5QV
         +uky2e6Q16IpZowZSphRT/YKqU5UByTC48TLl3GSPKfAq+qkkMfmUFDvtNk7xHvuCjzd
         gDo1b1la349O2B4gILTwResrhvMXVI3/jUB/zXld7uPxKHtovixhehMx/cEbNPpMQVSK
         2lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759277605; x=1759882405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUsbmESiNHTapnE6rmxwHkpYC/VK0QzGDUHHcofE4qs=;
        b=DR7MwnCdbYLMTjykGABYYllgOjZsiSfZWyVc9Z3GEyrbLZaN+UpPgq3IbWqS1btl42
         oOdcC+T7f4SaeAWWq+WSKz4k2gpLlzYZnN1cgFSSuiaCTASiCaSVxRu69IqQ5w+dBhVD
         8ezmDBVQeZ9wbrJ1HTmVt4AsviD6ncOh8O6X/8CCWcZepSnXpQDs5Hn7UCnk3XImswy4
         KXqszQW+j5vl9nP6hJM/IYSGoFyObELORkcDQP5gWWFdgCBbltK7VcZ7/BR6HJw3n1bm
         +jXg/v+CpTv4uti3fKFDZ/ifFgDTFLV4s1DrIhpmnqZNTDFpUfuD0tl//Zih3Obu4R17
         9Bdw==
X-Forwarded-Encrypted: i=1; AJvYcCX184NbSu8+9FeF0yb1rl4J2u546X8B8ysVDET07g6uDrVezu/kIlEAIFuS/wQpzQawnwjn+iMoWiAJLOeJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwZIbJ380W+43rF6du63ZRZSOn/vCFsJF3IAve95mFpqNjenpym
	PBr10lyQtRybc7ez6E4Qqjs9fmai6g+iz6GbFlhzBt3kKEzFtVH4spmwBrsly1kh81Q=
X-Gm-Gg: ASbGncsldbMcpU6mbQ0FpsC9Gc7tSy4Vjb4iURYUuPeu0W2fhqd/KftLGxdQvEfldXJ
	TIt01NC4yp3pAyFngyO/FiuTONn0SOCg8qa8RInRSUdmsXmgNSMBCqzJ48upYR423zb8ZK5xc8l
	Gwjmy9P8u3WbT4Cnzc1a0WyGdXY63SrNQ4z6LEj/7ajNzlxnnz787PSuFA3sU0XMeKlAKKm4hAW
	/G/rDLfYWhit53jVY11gF74OlgJqp3I0CviMAwhUGWeL0TYGuak9Iy+hmyYXGfLA7deKLc5kGOB
	IankrG4yJBI6Xp8MSQ9RnEJMEzPLvI+ybvku05ec9cy4h/T19zt7V/wEp6eKtxDvaIv60nb1H/3
	hYCjail8rMsY7AQ41pGNwTwtikXFD4Tnd7DWZpfuHmbzsmj8LUIjnCZSi
X-Google-Smtp-Source: AGHT+IH1ajiur2VZSdi3/i+zRO/0+860zWmY2Oc/Oh+OdPF2Hx4MVy9Glo++QmHnaPr2yVoYd0LYtw==
X-Received: by 2002:a05:6a00:3d51:b0:77f:2f7c:b709 with SMTP id d2e1a72fcca58-78af404c9c4mr1324097b3a.5.1759277605281;
        Tue, 30 Sep 2025 17:13:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b64599sm14805168b3a.70.2025.09.30.17.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 17:13:24 -0700 (PDT)
Date: Tue, 30 Sep 2025 17:13:21 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Florian Weimer <fweimer@redhat.com>
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
	Andy Chiu <andybnac@gmail.com>, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	bharrington@redhat.com, Aurelien Jarno <aurel32@debian.org>,
	bergner@tenstorrent.com, jeffreyalaw@gmail.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Message-ID: <aNxyIeVB8Rjsu6wW@debug.ba.rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
 <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
 <aNQ7D6_ZYMhCdkmL@debug.ba.rivosinc.com>
 <lhuldlwgpij.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <lhuldlwgpij.fsf@oldenburg.str.redhat.com>

On Tue, Sep 30, 2025 at 01:15:32PM +0200, Florian Weimer wrote:
>* Deepak Gupta:
>
>> Any distro who is shipping userspace (which all of them are) along
>> with kernel will not be shipping two different userspaces (one with
>> shadow stack and one without them). If distro are shipping two
>> different userspaces, then they might as well ship two different
>> kernels. Tagging some distro folks here to get their take on shipping
>> different userspace depending on whether hardware is RVA23 or
>> not. @Heinrich, @Florian, @redbeard and @Aurelien.
>>
>> Major distro's have already drawn a distinction here that they will drop
>> support for hardware which isn't RVA23 for the sake of keeping binary
>> distribution simple.
>
>The following are just my personal thoughts.
>
>For commercial distributions, I just don't see how things work out if
>you have hardware that costs less than (say) $30 over its lifetime, and
>you want LTS support for 10+ years.  The existing distribution business
>models aren't really compatible with such low per-node costs.  So it
>makes absolute sense for distributions to target more powerful cores,
>and therefore require RVA23.  Nobody is suggesting that mainstream
>distributions should target soft-float, either.
>
>For community distributions, it is a much tougher call.  Obsoleting
>virtually all existing hardware sends a terrible signal to early
>supporters of the architecture.  But given how limited the RISC-V
>baseline ISA is, I'm not sure if there is much of a choice here.  Maybe
>it's possible to soften the blow by committing to (say) two more years
>of baseline ISA support, and then making the switch, assuming that RVA23
>hardware for local installation is widely available by then.

Yes that's totally fine. Distro (community or commercial) get to decide.
They aren't forced to make a decision of RVA23 switch. Question is about
"Once they switch to RVA23 on say release `A`, will they build release `A`
for non-RVA23 as well". 

Once they make a switch, I do not expect the userspace they're building
to be able to run on older hardware because it'll have zimop instruction
in them in epilogue and prologue.

Sure, they can keep supporting older releases, keep building userspace
without cfi/non-rva23 and thus they should be building kernel without
cfi config as well for those releases.

New release (RVA23) isn't expected to run on older hardware. If new userspace
is not going to be able to run on older hardware and new userspace isn't
making an effort to have runtime selection of binaries depending on which
hardware it is running, Is it worth the effort to have two vDSO in kernel
and expose the one depending on which hardware its running? It's just added
complexity for usecase which I don't really see a usecase.

Yes a savvy kernel hacker might have a need where they want to build a kernel
with RVA23 and transport it on all kind of hardware but that's a very corner
use-case. 

At the very least this corner use case shouldn't block these patches from
being taken in 6.18. Current patches don't block such future capability (if any
one feels like this is really needed).

>
>However, my real worry is that in the not-too-distant future, another
>ISA transition will be required after RVA23.  This is not entirely
>hypothetical because RVA23 is still an ISA designed mostly for C (at
>least in the scalar space, I don't know much about the vector side).
>Other architectures carry forward support for efficient overflow
>checking (as required by Ada and some other now less-popular languages,
>and as needed for efficiently implementing fixnums with arbitrary
>precision fallback).  Considering current industry trends, it is not
>inconceivable that these ISA features become important again in the near
>term.
>

I can only be optimistic here and hope that enough ecosystem adoption would
prevent such breaks in transition.

>You can see the effect of native overflow checking support if you look
>at Ada code examples with integer arithmetic.  For example, this:
>
>function Fib (N: Integer) return Integer is
>begin
>   if N <= 1 then
>      return N;
>   else
>      return Fib (N - 1) + Fib (N - 2);
>   end if;
>end;
>
>produces about 370 RISC-V instructions with -gnato, compared to 218
>instructions with -gnato0 and overflow checking disabled (using GCC
>trunk).  For GCC 15, the respective instruction counts are 301 and 258
>for x86-64, and 288 and 244 for AArch64.  RVA23 reduces the instruction
>count with overflow checking to 353.  A further reduction should be
>possible once GCC starts using xnor in its overflow checks, but I expect
>that the overhead from overflow checking will remain high.
>
>Thanks,
>Florian
>

