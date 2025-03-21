Return-Path: <linux-fsdevel+bounces-44682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98801A6B57E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 08:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9457A6566
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 07:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6921EDA0A;
	Fri, 21 Mar 2025 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="J4TMQ/tQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CAD26ACB
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543468; cv=none; b=GW+fuN767MHb3TrBwO1CZ9gpvaSki5Ha866n4MAWEC+BBouWo7Bb9A8AbpCn5W2vP4+sLFMjk6EGrMc/KG/xiH8OdS7dCEd2XPf/1kymqcbp+kwIxiFfMrZVz07AAtnAgn9+QKhwN2cF3jJL8q8BTzJSdzVBeBjyaY8UwPFF2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543468; c=relaxed/simple;
	bh=y4dXpl3cvatt6fzahD+2xibQ5xvZLmqxOM6dGyrnOAY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=bv+1l998QIf8SrcJF4fOJH7+FzUu/SV2NKiWtAiCnaAQWraMERXzGq36w16ryvKvz2SDVyiLY+VqDhEJ8GBqscmMYzyhv8MWvj99wpC+f7chbwD9qSVQa5Xy+oBNLgSOo2JkZ6+m+N/7FlEk13qL61BkvfpGKrxEkm90SdjnWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=J4TMQ/tQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39973c72e8cso235060f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Mar 2025 00:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742543465; x=1743148265; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhIkdGys04hj0FOCl78FUSdH2+gL7DQzkmTGKMi3P1w=;
        b=J4TMQ/tQ7kTYKGnisvf4KLzfcQHqt+wqQu+H0MR5iP6uE75MqTF12z1+TQWGyK6GWh
         iD1Ej0oi4jTnCOoTxAhwTwR9NZ8ZstTQ+OOOzCeBLvaCTSxkoEGNXzm0zOF7zeStKgBu
         PWyZWzReCQwiVnh5ouvRLebs7wWvp5DQAZ2DQN8FE1cY9L5SibTakRgjlLzmKw867CqO
         atw4Q9I38DhYVh+t3HU68MeJQNSJIKQ8sqIk+T79lTfMDnGmI++iiSQMId8u2lN1MiP8
         8xEuYMAvRSSnCyyuYYlkzjWLmU3zSXBh5NIgaB3rOZX/fkUaU4EjyGVPvFxOlQD73GGb
         dRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742543465; x=1743148265;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PhIkdGys04hj0FOCl78FUSdH2+gL7DQzkmTGKMi3P1w=;
        b=AnRg1eq5Zpi7gZwyMYtwb9f1XNx24UAlnWVESz+XhKqSJAcjG6cGRyoj+eHzLoWNNg
         Nveq+9AEZpOLux1E/8iKaQITyxFAvfrL+2gMJR8JFNyNGHle7K9upeXPJR86JQSCWd2b
         2rntUP1ZehcjN/7m/ngFpE+QBwU+dEuXatyLu1gizvG8JvRFQqndv7Q9MJxF2H4HvW9h
         fT8GLBxX1/oF5KDWKbDi13AwYlRqSzQVZ+EcW6zrWfhr9BbtycC2dGj+C4GXuB6SErnf
         EJ1yOvwD4jgv5HK3Em981iYno//BHB+cn78z0mIgQyl+tJzM+UUWu/SHDORj3iyoSZPh
         A/yA==
X-Forwarded-Encrypted: i=1; AJvYcCXqj4EaSWVSCLr1aFAFkjiQi923Mf9FrEZA282wQDPxpVhp69qFND3d3HZ5SCNs1WGLGtBjKnIu5uPWLJQ7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2U1PdhAq3yKssK6moGzCpxoND3NoZyYUIGuI3/EX4U50td/ej
	9zWN4R8/4H/TQoA/0IvFidcMiSbgie0ul4agK+mYUC9NeqTKUN/5ORk/6yzPvI4=
X-Gm-Gg: ASbGncsCBE4qGtTmRr3azK99Xb/r2yv1h9+mS4ZOZA8CEfgJGC49cfjCUJVYlz7RWZL
	4et4XFCncRehFk4i7IJ2PDbEuEbHHuCDspiHsy3PBlZ+eYaLHa2y3EmYO1eAgk+QA1T4NylZNun
	D96K8BamrKJdtAInhBPGndcNenVLYNrkd1KMWqChx2HJAViI3j0dJjZCU6EEjRD2Xbb5JUtSzYj
	Kb8AaSKlvfWQiHXa8HWYsYowXqUtNH7IYtckG2c371hX+swsnZxtTFWfZzyvFLarYYTaWrQbArw
	su1TfedBi58RSOrHoL2LNrpAmuK3NXRj8p7Uf52U5gmLk5pRZURuYJEVqYF2MrG20h7hnmsc6YO
	3QfB4
X-Google-Smtp-Source: AGHT+IGwi45hePFM2TZdMOTyXUgfdngf4+B913tg/H8YfeoX7CrwBIY2Kj9KlDmHfMfV0eRC+zYKag==
X-Received: by 2002:a5d:598b:0:b0:38d:d743:7d36 with SMTP id ffacd0b85a97d-3997f93046emr899094f8f.10.1742543464931;
        Fri, 21 Mar 2025 00:51:04 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdb06b9sm18758395e9.36.2025.03.21.00.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 08:51:04 +0100
Message-Id: <D8LS3S6B9Y09.ZH6AQOD6UXRI@ventanamicro.com>
Subject: Re: [PATCH v12 25/28] riscv: create a config for shadow stack and
 landing pad instr support
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
 <cleger@rivosinc.com>, <alexghiti@rivosinc.com>, <samitolvanen@google.com>,
 <broonie@kernel.org>, <rick.p.edgecombe@intel.com>, "Zong Li"
 <zong.li@sifive.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Deepak Gupta" <debug@rivosinc.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-25-e51202b53138@rivosinc.com>
 <D8LESTM58PV0.7F6M6XYSL4BU@ventanamicro.com>
 <CAKC1njQHu1UeSSApWHXedEURBezuQL1BDcrpsSfi=D0JmDFX8A@mail.gmail.com>
In-Reply-To: <CAKC1njQHu1UeSSApWHXedEURBezuQL1BDcrpsSfi=D0JmDFX8A@mail.gmail.com>

2025-03-20T15:29:55-07:00, Deepak Gupta <debug@rivosinc.com>:
> On Thu, Mar 20, 2025 at 2:25=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrc=
mar@ventanamicro.com> wrote:
>>
>> 2025-03-14T14:39:44-07:00, Deepak Gupta <debug@rivosinc.com>:
>> > This patch creates a config for shadow stack support and landing pad i=
nstr
>> > support. Shadow stack support and landing instr support can be enabled=
 by
>> > selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` w=
ires
>> > up path to enumerate CPU support and if cpu support exists, kernel wil=
l
>> > support cpu assisted user mode cfi.
>> >
>> > If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS=
`,
>> > `ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.
>> >
>> > Reviewed-by: Zong Li <zong.li@sifive.com>
>> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> > ---
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > @@ -250,6 +250,26 @@ config ARCH_HAS_BROKEN_DWARF5
>> > +config RISCV_USER_CFI
>> > +     def_bool y
>> > +     bool "riscv userspace control flow integrity"
>> > +     depends on 64BIT && $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zi=
cfiss)
>> > +     depends on RISCV_ALTERNATIVE
>> > +     select ARCH_HAS_USER_SHADOW_STACK
>> > +     select ARCH_USES_HIGH_VMA_FLAGS
>> > +     select DYNAMIC_SIGFRAME
>> > +     help
>> > +       Provides CPU assisted control flow integrity to userspace task=
s.
>> > +       Control flow integrity is provided by implementing shadow stac=
k for
>> > +       backward edge and indirect branch tracking for forward edge in=
 program.
>> > +       Shadow stack protection is a hardware feature that detects fun=
ction
>> > +       return address corruption. This helps mitigate ROP attacks.
>> > +       Indirect branch tracking enforces that all indirect branches m=
ust land
>> > +       on a landing pad instruction else CPU will fault. This mitigat=
es against
>> > +       JOP / COP attacks. Applications must be enabled to use it, and=
 old user-
>> > +       space does not get protection "for free".
>> > +       default y
>>
>> A high level question to kick off my review:
>>
>> Why are landing pads and shadow stacks merged together?
>>
>> Apart from adding build flexibility, we could also split the patches
>> into two isolated series, because the features are independent.
>
> Strictly from CPU extensions point of view they are independent features.
> Although from a usability point of view they complement each other. A use=
r
> wanting to enable support for control flow integrity wouldn't be enabling
> only landing pad and leaving return flow open for an attacker and vice-ve=
rsa.
> That's why I defined a single CONFIG for CFI.
>
> From organizing patches in the patch series, shadow stack and landing
> pad patches do not cross into each other and are different from each
> other except dt-bindings, hwprobe, csr definitions. I can separate them
> out as well if that's desired.

It would be my preference, but it's the maintainer's call.

I think that landing pads could be merged earlier if they were posted
separately, but this series is already on v12, so I don't want to force
anything.

> Furthermore, I do not see an implementation only implementing zicfilp
> while not implementing zicfiss. There is a case of a nommu case where
> only zicfilp might be implemented and no zicfiss. However that's the case
> which is anyways riscv linux kernel is not actively being tested. IIRC,
> it was (nommu linux) considered to be phased out/not supported as well.
>
> We could have two different configs but I don't see what would serve
> apart from the ability to build support for landing pad and shadow stack
> differently. As I said from a usability point of view both features
> are complimenting
> to each other rather than standing out alone and providing full protectio=
n.
>
> A kernel is built with support for enabling both features or none. Sure u=
ser
> can use either of the prctl to enable either of the features in whatever
> combination they see fit.

Yeah, it will be rare, but if for some reason one feature cannot be
used, then having just one is better than none.
We can easily add compile options later and if we start with separate
kernel parameters, then the users won't even notice a difference.

