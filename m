Return-Path: <linux-fsdevel+bounces-62919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE9BBA528C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 23:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1DB32218C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD4B28C84F;
	Fri, 26 Sep 2025 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="OzgAM4Wl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18D284B58
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920832; cv=none; b=t14YE0WigjzeIJGraS63jJE+x7Oh9PoXgWhLIWmYmMhEu7unK2MkJmWJcbYDXuasKfuJ14dExQmUpZfhC6eE6E8DegANOC/NTbzgW0F9b7py7b+ZkDCTmQQECOSOL0Q/5lAHzjK/4VGjU2+1gA7/kEwP8PvF3s1DHDrkKrk1Brg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920832; c=relaxed/simple;
	bh=zNQpeKWP6iuGOhZinBW1XMutuiMBR/+q9XOpc4A9o9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwsi+rSB27qv2Akw7WEi+Gs+8Aqn/ie+Q4N0SUyaWjO+e1YngXAlybmUaAJ86i5jveTK50FL+kxjPfncPJbTL33j2YMvU5ZRjt+u7uYYDLBFqcpiVkFJzWPMjnJkRjgU1Nzzv5x+CAU0D6DyUD5D45b1J2AVUuggEMWp7OCGCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=OzgAM4Wl; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b58445361e8so682981a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 14:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1758920830; x=1759525630; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KnypQUg3EKrzG9RmKnVPYdoI8/tvp78hXYQJseWkeXU=;
        b=OzgAM4WlyfVg9esUCQ4S1VEi1fOPIK50vw3dEzYQ1l+AL9Bd9Ddmxkik9sPhvlzUsy
         kWbdsip8BH4UA84c9wULgngKuSsZBEzXZi2t5EkPtRi/Pq/FFRq51G6i330QjhQyhVeY
         szDCMgnXAb7MjRFan5dbj6cD/xp77ecGBCgBtH3FbpPMQy6wlwi/gKrbFJq9Lwkm8ORM
         mAvzPIbDmm2QkG9atD75FdAnFneJUp2E2TFENu9AUS9D5wh1JvsSqxluARHcfTJkKNPr
         pXI8Ce/SEPqCivghS51B88JfxzVqzbFYSCn1+7XBsKLAMNBsPVXCJaf/ydB4U4jS7mJb
         +rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758920830; x=1759525630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnypQUg3EKrzG9RmKnVPYdoI8/tvp78hXYQJseWkeXU=;
        b=S25H+49iE6kqUxrB9P0bXu3MuO3cBQJq+d8wDRqqCz92gzZZaCC++mPZgJ8wl/+EK/
         wGPlROHOBZcYwv6vVxEwD6RNcXS72VQmx2yIT22lHXtHpCKbaL9397pyKrOPE/X+I8+z
         z2tW5ConnQ7Z8UoJJl7vPGFLJPKw63jEvwKKFMv4ONCtEmn9HacojWEhi5gOb9VNT2wz
         KdEmVMbBZ8pPqdh59ljcL1nvdpF+LSJDqUgtkwwm38uT8jKaCs9x23k4RoXcAAV6GBB0
         aUcl0oo5a3d/fI8C0XVgcpYN9+oA1w8np4CjCwsmhdQhHLdglOVCrPavFSTED1uFRxtq
         NpUg==
X-Forwarded-Encrypted: i=1; AJvYcCVxhbmqZvbxlnzPmh5xywCYa4GVVe03MJbpaVZ0BsYE2W7WK7ZUXHnb/BSm1pJBEDHS0MzJhTnZ3JuEJwHy@vger.kernel.org
X-Gm-Message-State: AOJu0YznnseE0f1+F97v7URrlxQSrIGQQTheG9ABMxrFzod1+fVXbcDI
	nbmjQnQP//a7r72SpFOagtQN26bQJeiaqfeRfP9hKxqvVhss5hBIboUiAdy3FapsGLQ=
X-Gm-Gg: ASbGnct2DX+w1Ck5SVFR+wK85I5+s0sfpaYYfGWXfC7tpiIhQb/DDF6o/8CHVx0Mjeq
	6ooWqoKmwXiN5a1973YQ+kHavDIPQ7oamtXb91BgnlSY4+/T1iW9roJzivHxjd4ZByZW4Adpaj+
	VltQhFJY52v5IabgPBFDH9q54e7mNS9q7K2AdSMIQ8l38/mfHuagepahv94o5eoPwCBjKo38EtK
	ZWF9XZtSI+n6FT035+ryaUZ+Sm4F5D6DI9FXF82S+/oqqjKDpM+awqS8ogkAGmo0G7A70ljVoMC
	goFE2UD5WJzJH6EM392A77PFsl67U/shDrUiXUCcfZrYN1AlZMAyQEYpTLLPO2Ug0b5u/+9m/J6
	PY0JImcHAFsSr/bdwI7SuGhtux/DFIESia95w6QPrVB8=
X-Google-Smtp-Source: AGHT+IHn6NeY5dtoWojDFn95+d6BgY2U1yoTg8Yib4J+bRdePmMEhyGi2ikTPsB6k/JjLKsrf4UQUQ==
X-Received: by 2002:a17:90b:17ce:b0:32e:7340:a7fe with SMTP id 98e67ed59e1d1-336b3ca1d27mr750014a91.12.1758920829689;
        Fri, 26 Sep 2025 14:07:09 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a2c45sm5436382a12.45.2025.09.26.14.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:07:09 -0700 (PDT)
Date: Fri, 26 Sep 2025 14:07:06 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Charles Mirabile <cmirabil@redhat.com>
Cc: pjw@kernel.org, Liam.Howlett@oracle.com, a.hindborg@kernel.org,
	akpm@linux-foundation.org, alex.gaynor@gmail.com,
	alexghiti@rivosinc.com, aliceryhl@google.com,
	alistair.francis@wdc.com, andybnac@gmail.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, atishp@rivosinc.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, bp@alien8.de, brauner@kernel.org,
	broonie@kernel.org, charlie@rivosinc.com, cleger@rivosinc.com,
	conor+dt@kernel.org, conor@kernel.org, corbet@lwn.net,
	dave.hansen@linux.intel.com, david@redhat.com,
	devicetree@vger.kernel.org, ebiederm@xmission.com,
	evan@rivosinc.com, gary@garyguo.net, hpa@zytor.com,
	jannh@google.com, jim.shu@sifive.com, kees@kernel.org,
	kito.cheng@sifive.com, krzk+dt@kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com,
	lossin@kernel.org, mingo@redhat.com, ojeda@kernel.org,
	oleg@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
	peterz@infradead.org, richard.henderson@linaro.org,
	rick.p.edgecombe@intel.com, robh@kernel.org,
	rust-for-linux@vger.kernel.org, samitolvanen@google.com,
	shuah@kernel.org, tglx@linutronix.de, tmgross@umich.edu,
	vbabka@suse.cz, x86@kernel.org, zong.li@sifive.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Message-ID: <aNcAela5tln5KTUI@debug.ba.rivosinc.com>
References: <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
 <20250926192919.349578-1-cmirabil@redhat.com>
 <aNbwNN_st4bxwdwx@debug.ba.rivosinc.com>
 <CABe3_aE4+06Um2x3e1D=M6Z1uX4wX8OjdcT48FueXRp+=KD=-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABe3_aE4+06Um2x3e1D=M6Z1uX4wX8OjdcT48FueXRp+=KD=-w@mail.gmail.com>

On Fri, Sep 26, 2025 at 04:28:58PM -0400, Charles Mirabile wrote:
>Hi Deepak -
>
>On Fri, Sep 26, 2025 at 3:57 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Hi Charles,
>>
>> Thanks for response. Rest inline
>>
>> On Fri, Sep 26, 2025 at 03:29:19PM -0400, Charles Mirabile wrote:
>> >Hi -
>> >
>> >Hoping that I got everything right with git-send-email so that this is
>> >delivered alright...
>> >
>> >Wanted to jump in to head off a potential talking past one another /
>> >miscommunication situation I see here.
>> >
>> >On Wed, Sep 24, 2025 at 08:36:11AM -0600, Paul Walmsley wrote:
>> >> Hi,
>> >>
>> >> On Thu, 31 Jul 2025, Deepak Gupta wrote:
>> >>
>> >> [ ... ]
>> >>
>> >> > vDSO related Opens (in the flux)
>> >> > =================================
>> >> >
>> >> > I am listing these opens for laying out plan and what to expect in future
>> >> > patch sets. And of course for the sake of discussion.
>> >> >
>> >>
>> >> [ ... ]
>> >>
>> >> > How many vDSOs
>> >> > ---------------
>> >> > Shadow stack instructions are carved out of zimop (may be operations) and if CPU
>> >> > doesn't implement zimop, they're illegal instructions. Kernel could be running on
>> >> > a CPU which may or may not implement zimop. And thus kernel will have to carry 2
>> >> > different vDSOs and expose the appropriate one depending on whether CPU implements
>> >> > zimop or not.
>> >>
>> >> If we merge this series without this, then when CFI is enabled in the
>> >> Kconfig, we'll wind up with a non-portable kernel that won't run on older
>> >> hardware.  We go to great lengths to enable kernel binary portability
>> >> across the presence or absence of other RISC-V extensions, and I think
>> >> these CFI extensions should be no different.
>> >
>> >That is not true, this series does not contain the VDSO changes so it can
>> >be merged as is.
>>
>> Look at patch 23/27. It does have vDSO change. Although shadow stack
>> instruction are inserted as compiled flag for vDSO only when cfi config is
>> selected by user. Right now default is "No". So it won't impact anyone unles
>> user explicitly says "Yes".
>
>Yes sorry I caught that after hitting send and replied to my own email
>(but then I said 19/27 instead of 23/27 *facepalm*)
>
>>
>> >
>> >>
>> >> So before considering this for merging, I'd like to see at least an
>> >> attempt to implement the dual-vDSO approach (or something equivalent)
>> >> where the same kernel binary with CFI enabled can run on both pre-Zimop
>> >> and post-Zimop hardware, with the existing userspaces that are common
>> >> today.
>> >
>> >I agree that when the VDSO patches are submitted for inclusion they should
>> >be written in a way that avoids limiting the entire kernel to either
>> >pre-Zimop or post-Zimop hardware based on the config, but I think it
>> >should be quite possible to perform e.g. runtime patching of the VDSO
>> >to replace the Zimop instructions with nops if the config is enabled but
>> >the hardware does not support Zimop.
>>
>> Why kernel need to do this extra work of carry two binaries and patching it
>> runtime?
>>
>> If for instance we do this, and then this allow this kernel to be taken to
>> pre-Zimop hardware, it is assumed that entire userspace for such hardware
>> was compiled without shadow stack (thus no zimop). In that case, kernel
>> should have been compiled without CFI option.
>
>You raise a good point, it just breaks the tradition of runtime
>detection and backwards compat that has been the standard for riscv
>extensions in the kernel so far.

riscv (and others arches) have been able to do that because of "alternatives".
It's just that due to composable nature of riscv, alternatives are just spread
everywhere in the code and feels like riscv is doing something unique here.
Whenever there is a surgical placement of certain instructions in kernel, it
could be hidden behind alternatives and be patched in runtime.

However situations where instructions are emitted as part of codegen, there is
no hiding. Either it works or it doesn't. If we have auto vectorization enabled
in usermode, such a binary won't run on hardware which doesn't implement vector.

In case of shadow stack, it similar situation. If enabled compiler decides to
insert sspush and sspopchk. They necessarily won't be prologue or epilogue but
somewhere in function body as deemed fit by compiler, thus increasing the
complexity of runtime patching.

More so, here are wishing for kernel to do this patching for usermode vDSO when
there is no guarantee of such of rest of usermode (which if was compiled with
shadow stack would have faulted before vDSO's sspush/sspopchk if ran on
pre-zimop hardware)

>
>It would be nice if a kernel could be built that would run on both
>pre-Zimop and post-Zimop hardware and be able to offer CFI to
>userspace when running on hardware with Zimop (and Zicfiss / Zicfilp)
>but agree that it is a burden.
>
>>
>> Just for sake of thought exercise, let's say Fedora 43 is first release with
>> RVA23 compatiblity (zimop and shadow stack), there is no way this and future
>> release will be able to run on pre-zimop hardware. Unless redhat is going to
>> start two different binary distribution. One for pre-zimop and one for
>> post-zimop. If that would be the case, then compiling two different kernel for
>> such two different hardware would be least of the worry.
>
>It would be one thing if there were hardware supporting
>Zimop/Zicfiss/Zicfilp readily available, but I am not aware of any

And that's the reason currently default is "No" for cfi config in kernel.
Hope is whenever we have hardware, we can start lighting up and take decision
how to proceed. I keep reiterting, door isn't closed yet but we gotta approach
the door.

>platform other than qemu to test this code. 

I have tested this with qemu in following configurations

qemu implements cfi extensions:
Kernel with cfi enable is able to host userspace with and without cfi compiled.
Kernel with cfi enable is able to host userspace with cfi but disabled (default
to zimop)
Kernel without cfi enable is able to host userspace with cfi (default to zimop)
and without cfi.

qemu doesn't implement cfi extension:
- Kernel without cfi enable is able to host userspace without cfi compiled in.
- Kernel without cfi enable hosting userspace with cfi compiled in faults in
   libc/ld on first sspush.
- Kernel with cfi enable trying to host userspace with cfi faults in libc/ld on
   first sspush.
- Kernel with cfi enable trying to host userspace without cfi faults in vDSO on
   first sspush.

Last case is the only breaking case, rest all compatibilities stories work.
In order to solve this last compatiblity story, I am fearful that we might be
adding un-necessary complexity in kernel which isn't desired because rest of
the userspace won't be signing up for that complexity of patching and making
it work with single binary.

> Since it breaks
>compatibility with hardware I am not sure anyone will be able to do
>anything with this config option and it moves the burden on to each
>distro to go in and specifically enabling it vs just making things
>work to get important security improvements if the hardware has
>support and not if it doesn't in a backwards compatible way.

I wished that shadow stack instructions came out of HINT space. But it is
what it is. Perhaps distro should give this feedback to RVI. But here we
are.

zimop is backward compatible only RVA23 onwards. That's why it's important
for distro to make a decision on this. Once they compile for RVA23 profile,
it assumed a clean break from previous hardware. Future extensions will also
take encodings out of zimop and thus I believe its better to take that decision
now with first user of zimop.

>
>>
>> Only other usecase is of a seasoned kernel developer or build your own stuff
>> in embedded environment, those users can anyways are advanced users. But it
>> forces complexity on rest of kernel. There will be more extensions taking zimop
>> encodings in future, we will end up patching vDSO and keep this complexity
>> while rest of the userspace will not be patched and will be separate binary
>> distribution (if OS distros endup distributing multiple binaries per release)
>>
>> >
>> >However, that concern should not hold up this patch series. Raise it again
>> >when the VDSO patches are posted.
>>
>> As I said earlier, these changes default cfi config to No. So whenever this
>> is selected "Yes" by a distro, they can drive such patches (if there is a real
>> need)
>
>If we did the patching we could make this config default to yes to
>that you are building a kernel that is set up to be able to offer CFI
>when running on hardware which supports it as long as you have a
>toolchain that recognizes the extensions which I think would be good
>for moving this important security feature forward.

Again, Why kernel should be doing this when rest of the userspace isn't
patchable on pre-zimop hardware (thats the only scenario patching is needed)?

Are distro's distributing different binary for with autovec and without autovec
for different kind of riscv hardware?

Giving example of Fedora 43, once it is compiled in with cfi enabling, kernel is
also compiled in with the feature. Its not like there is going to "Fedora
43_rv64gc" release. If there is going to be a "Fedora 43_rv64gc" release, it'll
be much easier to no select CFI for that release's kernel compile rather than
kernel doing patching in runtime (rest of userspace is not doing any patching)

>
>>
>> >
>> >>
>> >> thanks Deepak,
>> >>
>> >> - Paul
>> >
>> >Best - Charlie
>> >
>>
>
>Sorry for stirring the pot on this. I really appreciate your work on
>this patch series.
>
>I agree that this is a difficult call, and I could see it going either
>way but I lean towards trying to maintain the backwards compatibility
>because the hardware doesn't exist yet.
>
>Best - Charlie
>

