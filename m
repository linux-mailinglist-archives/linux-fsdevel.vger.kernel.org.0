Return-Path: <linux-fsdevel+bounces-72864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C6ED0453F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 397C030F4120
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864BD2D73AD;
	Thu,  8 Jan 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="IV37lyqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0FF2741C9
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885046; cv=none; b=i9ThNTa4tGLup+w5451DM0ifom4TpggzElX9N0PLeh4cAu2t7MsQmIaTZva2nfpUcLYwRlijogkgQ0xlXlHy8eri80LI/RVMsop4RVp8xvaIJNfMxn2fSJA9jiIVrgpPeG9/04Q29VDDBNdEhdppXz7/P2Vrp76BuRjHvPsiBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885046; c=relaxed/simple;
	bh=C64R9vkxaI9K5ONeC3tgaLirXTXcWSDMfLRS3TxDK8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQwCX/O0/9rW/c2erISQiOqApb9eTf3q4RKEPhZerujbirQWEMbePkjTdSb6RXoKby9c9TZHW9GbC2NzU4zSMEQSDAW7rSnWvgdCb7McQSpkzDwtNjNlsgn1UWiZkfpQTNhPDSF4a31C/CAh9rxpDRu5jYefUSE67SvsoOBM0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=IV37lyqx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7904a401d5cso36314067b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 07:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1767885044; x=1768489844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTkbey9LWC4b27P/G+EnN+lFuImbI+lYFoSxJEGXtiI=;
        b=IV37lyqxJep/5ajHTExa7SHZy3vjwyq5ntmGicmKUKgrvygjZPpOn2bfiTpIWobWhk
         IWs5pUbC+vQCl/WCppd2iPEavLxoStqCg1xP3I1GgBoXqPKor7JCgshPYAdU9lXAGTgA
         vePeN6LzMXucEhQSHr1yFtRPsGsOyh+v/LFWE36UZhiLzNicZ1kEoWIS6OJqBWdUuLJi
         b5n5wKdDmy6KfFs0me7P6uevmyaIc8qi1eGUTrl299YgHA7fjZdTwIueqmsYQ/1puMWR
         YMHg1IY6SlhUiHKl1Ie570K96HL/H3BWRDBs4R0tFjoVmdwoasS+Q0koJ/pwpZfQ+FBe
         tR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767885044; x=1768489844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QTkbey9LWC4b27P/G+EnN+lFuImbI+lYFoSxJEGXtiI=;
        b=qib1NCLx7iKH1dAGdxX6a+rLHjdQaVz4iVr0iW40U218FG3uVXWqtwn/YnQc52kMrm
         9uoTnO9PIVJdUXAwGbZgGbsDJNqFeWqYZmXjIA3Pjz0sAIkJ0RSUtXNDNaRNGCNVala7
         8Lr+HNBx66CjXRw1Th4nG893bYDn7SsycXKprcLNTLDTVlHEpfZ3DpZmtqe61K0rVL92
         eOuhrB93L4TSpXT2EaO6+V+DPrZKcMqX7v6j+b4Z+5qL9zODextMemiT+x57wj/9z5Z/
         RByhoFNW6UVxie/8/MgBQE3RxW+WEz1CL4xCzEcBErG4bcvTFdOAP8/Nt9QCoip0OXEX
         twVg==
X-Forwarded-Encrypted: i=1; AJvYcCXsBI1UgRgUZ9HH1B8Yez0OES0fcTtS7KzMN/16LmNIcTco/jVAcB2wR4npNE1CORwMqCos2vLRCt0TOeMr@vger.kernel.org
X-Gm-Message-State: AOJu0YxrIG6YfjyW0YPEkLTb8/YkovJTwUzW2/Ke3i1Ls/6RpD48ejIX
	94x9DptCjDVypOgWZu5Mo3Rf3Apl8XupBh+qT9mc6Jl2LZfjtQkGb9c68HPWLweUZcIR1Wp/UKw
	fHvp2Y1hwGnArSi84pNyFfnZK6SPkv2eR0cz5+ry9Dw==
X-Gm-Gg: AY/fxX4spTGTFdmAUS6aTGl78EXPrbBLr3RekOPYHX3jGuh+frz3WmmokgZfNllpR1x
	ojv6oxIdHNEU+YdsBv9bRSUMDoU5jIy7kA+ZLPTtFupB/TEVndJVrGrlvDnhQsQOiN46rBRGbz5
	hQL/YB1GiL4mSjcfNxuyjWD+fvz69rE3MTcQeT3glH81oQWlVxT8DAupbGmaCHX3Tmv8Lo08qL0
	M4ZppdFVssb1yB51D8FVRG3pUWdkjI7G4tgzUeGSdrTV5xxJ9l1bDexouO8ZWA93GHsHw==
X-Google-Smtp-Source: AGHT+IHwlV11mJiZRvrc0ba9gyUKkJLs3Ivv5ZO/Sp66Caj6iICdWSs+vjcbtX7JeT7w+lz4Sr6DicIt8PKx9jaUzQk=
X-Received: by 2002:a05:690e:b88:b0:644:6ad4:fdfd with SMTP id
 956f58d0204a3-64716c14086mr5723963d50.71.1767885043558; Thu, 08 Jan 2026
 07:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211-v5_user_cfi_series-v26-0-f0f419e81ac0@rivosinc.com>
 <e052745b-6bf0-c2a3-21b2-5ecd8b04ec70@kernel.org> <aTxf7IGlkGLgHgI2@debug.ba.rivosinc.com>
In-Reply-To: <aTxf7IGlkGLgHgI2@debug.ba.rivosinc.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 8 Jan 2026 07:10:32 -0800
X-Gm-Features: AQt7F2r-MFLse9aM2Y-9SmWOvFLm93MsLbBkGvYnQc0D6QLcC_Q6_utP6Kihh0s
Message-ID: <CAKC1njQ-hS+kUJ0C_v0oqZW1EZw2zAXMp-SnnA-ZXh_H-SoVdQ@mail.gmail.com>
Subject: Re: [PATCH v26 00/28] riscv control-flow integrity for usermode
To: Paul Walmsley <pjw@kernel.org>
Cc: x86@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, 
	Andy Chiu <andybnac@gmail.com>, kito.cheng@sifive.com, charlie@rivosinc.com, 
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
	Zong Li <zong.li@sifive.com>, Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
	Valentin Haudiquet <valentin.haudiquet@canonical.com>, Charles Mirabile <cmirabil@redhat.com>, 
	Jesse Huang <jesse.huang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

I have a bugfix for a bug reported by Jesse Huang (thanks Jesse) in riscv
implementation of `map_shadow_stack`.

Should I send a new series or only the bugfix-patch for implementation
of `map_shadow_stack`

Let me know. Thanks.

-Deepak

-Deepak



On Fri, Dec 12, 2025 at 10:33=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> On Fri, Dec 12, 2025 at 01:30:29AM -0700, Paul Walmsley wrote:
> >On Thu, 11 Dec 2025, Deepak Gupta via B4 Relay wrote:
> >
> >> v26: CONFIG_RISCV_USER_CFI depends on CONFIG_MMU (dependency of shadow=
 stack
> >> on MMU). Used b4 to pick tags, apparantly it messed up some tag picks.=
 Fixing it
> >
> >Deepak: I'm now (at least) the third person to tell you to stop resendin=
g
> >this entire series over and over again.
>
> To be very honest I also feel very bad doing and DOSing the lists. Sorry =
to you
> and everyone else.
>
> But I have been sitting on this patch series for last 3-4 merge windows w=
ith
> patches being exactly same/similar. So I have been a little more than des=
perate
> to get it in.
>
> I really haven't had any meaningful feedback on patch series except stall=
ing
> just before each merge window for reasons which really shouldn't stall it=
s
> merge. Sure that's the nature of open source development and it's maintai=
ner's
> call at the end of the day. And I am new to this. I'll improve.
>
> >
> >First, a modified version of the CFI v23 series was ALREADY SITTING IN
> >LINUX-NEXT.  So there's no reason you should be resending the entire
> >series, UNLESS your intention for me is to drop the entire existing seri=
es
> >and wait for another merge window.
> >
> >Second: when someone asks you questions about an individual patch, and y=
ou
> >want to answer those questions, it's NOT GOOD for you to resend the enti=
re
> >28 series as the response!  You are DDOSing a bunch of lists and E-mail
> >inboxes.  Just answer the question in a single E-mail.  If you want to
> >update a single patch, just send that one patch.
>
> Noted. I wasn't sure about it. I'll explicitly ask next time if you want =
me to
> send another one.
>
> >
> >If you don't start paying attention to these rules then people are going
> >to start ignoring you -- at best! -- and it's going to give the entire
> >community a bad reputation.
>
> Even before this, this patch series has been ignored largely. I don't kno=
w
> how to get attention. All I wanted was either feedback or get it in. And =
as I
> said I've been desparate to get it in. Also as I said, I'll improve.
>
> >
> >Please acknowledge that you understand this,
>
> ACKed.
>
> >
> >
> >- Paul

